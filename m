Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8882F70128D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbjELXlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjELXk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B13E19AD
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68F561919
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 23:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06390C433D2;
        Fri, 12 May 2023 23:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683934857;
        bh=Crwt2cgtC/p3F/oUx8J189h37ihPXCFKmATi9X0z6ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dXTIYgUn6w2aR4H6KEPPKEKII8eUKoPiq7dt9eFPokRrVGGg/10bJqXgeO1dx7Eah
         kMUkhRhPclGabHDC2Gj+7yWxWjuUvzcWAKIVowjOj4aIuYBb+PDTm6QGTFRBBYo/Lq
         ovGBW9fYnHspX60XQQhSBB9D/1lMU3bTq47JoAmI=
Date:   Fri, 12 May 2023 16:40:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <song@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] watchdog: Prefer use "ref-cycles" for NMI watchdog
Message-Id: <20230512164056.8f1e4e23032f7f7f5cb69df0@linux-foundation.org>
In-Reply-To: <20230509221700.859865-1-song@kernel.org>
References: <20230509221700.859865-1-song@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 15:17:00 -0700 Song Liu <song@kernel.org> wrote:

> NMI watchdog permanently consumes one hardware counters per CPU on the
> system. For systems that use many hardware counters, this causes more
> aggressive time multiplexing of perf events.
> 
> OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
> used. Try use "ref-cycles" for the watchdog. If the CPU supports it, so
> that one more hardware counter is available to the user. If the CPU doesn't
> support "ref-cycles", fall back to "cycles".
> 
> The downside of this change is that users of "ref-cycles" need to disable
> nmi_watchdog.
> 
> ...
>
> @@ -286,6 +286,12 @@ int __init hardlockup_detector_perf_init(void)
>  {
>  	int ret = hardlockup_detector_event_create();
>  
> +	if (ret) {

If we get here, hardlockup_detector_event_create() has sent a scary
pr_debug message.

> +		/* Failed to create "ref-cycles", try "cycles" instead */
> +		wd_hw_attr.config = PERF_COUNT_HW_CPU_CYCLES;
> +		ret = hardlockup_detector_event_create();

So it would be good to emit a followup message here telling users that
things are OK.  Or tell the user we're retrying with a different
counter, etc.

> +		/* Failed to create "ref-cycles", try "cycles" instead */
> +		wd_hw_attr.config = PERF_COUNT_HW_CPU_CYCLES;
> +		ret = hardlockup_detector_event_create();
> +	}
> +
>  	if (ret) {
>  		pr_info("Perf NMI watchdog permanently disabled\n");
>  	} else {
> -- 
> 2.34.1
