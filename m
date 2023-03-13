Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76636B7A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjCMOWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCMOWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:22:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC1C1AD;
        Mon, 13 Mar 2023 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IS55g0S66y8y4INdsvsEQ01kM13lZ7aZPntjdQt/z6k=; b=fIXGJPJMOmi+ej6WgGuCSOwHh6
        09hVUbs9A1swzOHw+opRoouJYbgJ7xt70ELTzNyCRXCiZs86qbcpoA2MKK1UM+chZHRJkvUQQj/iX
        BeRySBsPrD5H0J/xBmZtTUh5owQDcKOOhVa9/s1e48XAMPta4+VyU3Xo9yFms/qnKJy6MEiPRJcWR
        6VRSUpK3L3/LKrN90z/qCevzrq8dcy9msG85rIzh+RiAz3F9QGUA6aPHQVJdcZtbAcxpDN15hk4ke
        thX/6SccEJiT6PQUJQ+yRrJxlC0WetqOuGCMxEAgKRNfY485NLQoXFpB+1vcecwqbHCaQT+Z7dfb1
        4yuaE9cw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pbj3m-001OOw-16;
        Mon, 13 Mar 2023 14:21:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19D9B30030F;
        Mon, 13 Mar 2023 15:21:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00847200C9CB3; Mon, 13 Mar 2023 15:21:56 +0100 (CET)
Date:   Mon, 13 Mar 2023 15:21:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     namhyung@kernel.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH v2 2/3] perf/ibs: Fix interface via core pmu events
Message-ID: <20230313142156.GL2017917@hirez.programming.kicks-ass.net>
References: <20230309101111.444-1-ravi.bangoria@amd.com>
 <20230309101111.444-3-ravi.bangoria@amd.com>
 <20230312145426.GA1757905@hirez.programming.kicks-ass.net>
 <45de7e62-d951-1019-990e-6df285a64cf6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45de7e62-d951-1019-990e-6df285a64cf6@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 05:59:46PM +0530, Ravi Bangoria wrote:

> > Now, we already have a gruesome hack in there, and I'm thikning you
> > should use that instead of adding yet another one. Note:
> > 
> > 		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
> > 			type = event->attr.type;
> > 			goto again;
> > 
> > So if you have amd_pmu_hw_config() do:
> > 
> > 	event->attr.type = ibs_pmu.type;
> > 	return -ENOENT;
> > 
> > it should all just work no?
> 
> IBS driver needs to convert RAW pmu config to IBS config, which it does
> based on original event->attr.type. See perf_ibs_precise_event(). This
> logic will fail with event->attr.type overwrite.

amd_pmu_hw_config() could also rewrite event->attr.config I suppose.

I don't think we actually use/expose these event->attr fields again
after all this, do wel?

The closest to that is perf_event_modify_attr(), but that is limited to
TYPE_BREAKPOINT for the time being (also, could this be used to cure
your in-kernel IBS usage woes?).
