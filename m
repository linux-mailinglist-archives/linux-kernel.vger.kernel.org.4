Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B55FF656
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJNWRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJNWRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:17:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411991B864F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xQaKAyCKu0+ueL4Q6Y1AwFEQ4l4Z/XAvSp7zoyHPOUc=; b=jWPxb7hvPO0cC/qmLaMnWu1alM
        tRyrCk4vpg+LURVtndZGTbRk1h1zrMYmkRzUwu286EonS/2S7zHTzLxLR16uUUi5QyycRaJY1ETGa
        V4yaL7Q2pzl9E0G5DMP9AF9z7DwgTNLG6KSTUZFKog1OaXooRBPzKfJ90ZNRP7uAxTSx98OHDnDog
        EOAZh5r03GkD745+RouwjW/iAgtmOEtIsjztnMCys4fikxwdR7XIWk8BsoQ3l3u3qRYV7z1qqJjiK
        zgTF8zNRO8TggdOHOKztN80TXG2m6nA2CXujkg1CyX/AhPTjCoj4ki6qn1gL4T84JDvVnUqacFbbA
        UpYrqcJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojSxn-007xKz-Lr; Fri, 14 Oct 2022 22:15:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D66430008D;
        Sat, 15 Oct 2022 00:15:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 688272C1B4E05; Sat, 15 Oct 2022 00:15:26 +0200 (CEST)
Date:   Sat, 15 Oct 2022 00:15:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: assert from intel_pmu_hw_config
Message-ID: <Y0nffphm+aqtMBMc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

While fuzzing on my ADL, I saw a splat (sadly not captured because
MeshCommander is a pain in the backside).

The thing I did recover was that it was the new
lockdep_assert_event_ctx() triggering from intel_pmu_hw_config().

Now; that code reads:

	if (require_mem_loads_aux_event(event) &&
	    (event->attr.sample_type & PERF_SAMPLE_DATA_SRC) &&
	    is_mem_loads_event(event)) {
		struct perf_event *leader = event->group_leader;
		struct perf_event *sibling = NULL;

		if (!is_mem_loads_aux_event(leader)) {
			for_each_sibling_event(sibling, leader) {
				if (is_mem_loads_aux_event(sibling))
					break;
			}
			if (list_entry_is_head(sibling, &leader->sibling_list, sibling_list))
				return -ENODATA;
		}
	}

And it is trying to assert leader->ctx->mutex is held.

Now, the calling context perf_try_init_event() has:

	/*
	 * A number of pmu->event_init() methods iterate the sibling_list to,
	 * for example, validate if the group fits on the PMU. Therefore,
	 * if this is a sibling event, acquire the ctx->mutex to protect
	 * the sibling_list.
	 */
	if (event->group_leader != event && pmu->task_ctx_nr != perf_sw_context) {
		/*
		 * This ctx->mutex can nest when we're called through
		 * inheritance. See the perf_event_ctx_lock_nested() comment.
		 */
		ctx = perf_event_ctx_lock_nested(event->group_leader,
						 SINGLE_DEPTH_NESTING);
		BUG_ON(!ctx);
	}

IOW; we only hold leader->ctx->mutex when event is *NOT* the group
leader; while the above code *can* in fact use for_each_sibilng_event()
on the group leader when conditions are just right.

Now, it's really late and my brain has long since started the weekend,
but I think something like the below ought to fix things.

Does that make sense? IIRC this would not destroy the purpose of this
code -- although admittedly, the comment there tickles only vague
memories.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d8af75466ee9..450463d36450 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3975,7 +3975,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		struct perf_event *leader = event->group_leader;
 		struct perf_event *sibling = NULL;
 
-		if (!is_mem_loads_aux_event(leader)) {
+		if (event != leader && !is_mem_loads_aux_event(leader)) {
 			for_each_sibling_event(sibling, leader) {
 				if (is_mem_loads_aux_event(sibling))
 					break;
