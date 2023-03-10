Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54F46B35FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 06:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCJFMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 00:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCJFMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 00:12:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036DB1CF5B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 21:11:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63598B821BB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E820EC433D2;
        Fri, 10 Mar 2023 05:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678425109;
        bh=Ir05dTnlKpuYrWYmjvIjByW9P/6rdMov7XP7tdTrXQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4Rf0u0mcIQEPNnYUmIksH/D6LdG5/lIZhK/9nMzWAtuq0XAHfXZvIpd5XTaR3xA9
         GHyhPBS/CHpjDgdwI5+elrVHKU5FbdhW61kxYBPvhj/mmkIFgrfpTZDi2ObMFaaP3t
         lZTal9Q/YC7FqzYc5Cm7wgv1LA/rcjIb9M0vI0gaX/+ORnrAkViI2aoiNAHrNm2GFF
         AZBXPHVXQCGAF1P+8rheRliwk/5mpIudd5LIpEMpkCoc0TpPwBbSv/n+6P5WcLlZuk
         JGmpMhTaRGPaznNzzslSi9/QDlyN9ewO80539+agcUvft43A7bL46p5bIQYDlbCF75
         dJ3x20kq7xukQ==
Date:   Thu, 9 Mar 2023 21:11:47 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, fsverity@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsverity: Remove WQ_UNBOUND from fsverity read workqueue
Message-ID: <ZAq8Ey8CZ5I2xcpW@sol.localdomain>
References: <20230309213742.572091-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309213742.572091-1-nhuck@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 01:37:41PM -0800, Nathan Huckleberry wrote:
> WQ_UNBOUND causes significant scheduler latency on ARM64/Android.  This
> is problematic for latency sensitive workloads like I/O post-processing.
> 
> Removing WQ_UNBOUND gives a 96% reduction in fsverity workqueue related
> scheduler latency and improves app cold startup times by ~30ms.

Maybe mention that WQ_UNBOUND was recently removed from the dm-verity workqueue
too, for the same reason?

I'm still amazed that it's such a big improvement!  I don't really need it to
apply this patch, but it would be very interesting to know exactly why the
latency is so bad with WQ_UNBOUND.

> 
> This code was tested by running Android app startup benchmarks and
> measuring how long the fsverity workqueue spent in the ready queue.
> 
> Before
> Total workqueue scheduler latency: 553800us
> After
> Total workqueue scheduler latency: 18962us
> 
> Change-Id: I693efee541757851ed6d229430111cd763d39067

No Change-Id in upstream patches, please.

> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index f50e3b5b52c9..e8ec37774d63 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -395,7 +395,7 @@ int __init fsverity_init_workqueue(void)
>  	 * which blocks reads from completing, over regular application tasks.
>  	 */
>  	fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
> -						  WQ_UNBOUND | WQ_HIGHPRI,
> +						  WQ_HIGHPRI,
>  						  num_online_cpus());

There's a comment just above here that explains why WQ_UNBOUND is being used.
It needs to be updated to explain why WQ_UNBOUND is *not* being used.

- Eric
