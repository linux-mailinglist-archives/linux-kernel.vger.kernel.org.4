Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567016DF868
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDLO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjDLO0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:26:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0376170A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3qJvIOxoolczQy5RdZ6v4DRFskdaG0Va0CAKh9b55/o=; b=PDT7uMS3oxgyC5Wp+jDvcYXhzD
        gHJUi3Ti9E8JrYvOSvhFdTp02iqhf5Rlcc4qafPBkkFk3d/+D3YNUtl2WB5WmPXOedVLAXuA4YjMA
        4pSZ5JoWJrYgLE74Gure9MnC26pJaM7NU1ddPjIymgF4GxrgURfmb/og9PybSTz/8rXUink/GC3uS
        hOsOHfVJSFSARsAD16GcLIMpq+VOaf2ywkKDMj33R9/vMcytNloxOSeXHOp4cXr3uJypVdxqBYel8
        RDNg3IVgFgiCdONa60RrkkhPBVaErTF2QwQpb63FzXY+weH/juUcvikSeaQuuRE38J9vHw91G5I6J
        EL5J4n3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmbQP-00DwfQ-2j;
        Wed, 12 Apr 2023 14:26:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3462300274;
        Wed, 12 Apr 2023 16:26:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A8E921239575; Wed, 12 Apr 2023 16:26:16 +0200 (CEST)
Date:   Wed, 12 Apr 2023 16:26:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230412142616.GI628377@hirez.programming.kicks-ass.net>
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
 <20230411045225.GA3509@ziqianlu-desk2>
 <20230411131221.GA7356@ziqianlu-desk2>
 <20230412091043.GC4253@hirez.programming.kicks-ass.net>
 <20230412114240.GA155547@ziqianlu-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412114240.GA155547@ziqianlu-desk2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 07:42:40PM +0800, Aaron Lu wrote:

> I *guess* you might be able to see some contention with hackbench on
> that HSW-EX system with v4.

Indeed! Notably it seems to be the wakeup from idle that trips it
hardest:

11.31%     0.03%  swapper          [kernel.vmlinux]            [k] schedule_idle
        |
        --11.28%--schedule_idle
                  |
                  --11.27%--__schedule
                            |
                            |--8.61%--mm_cid_get
                            |          |
                            |           --5.78%--_raw_spin_lock
                            |                     |
                            |                      --5.56%--native_queued_spin_lock_slowpath
                            |
                            |--0.81%--finish_task_switch.isra.0
                            |          |
                            |           --0.69%--asm_sysvec_call_function_single
                            |                     |
                            |                      --0.58%--sysvec_call_function_single
                            |
                            --0.57%--switch_mm_irqs_off
                    
                    

