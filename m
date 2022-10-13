Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E045FD1C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 02:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiJMArI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 20:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiJMAql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 20:46:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E14C141108;
        Wed, 12 Oct 2022 17:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17B7EB81CCA;
        Thu, 13 Oct 2022 00:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2111C433B5;
        Thu, 13 Oct 2022 00:39:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TarLo7j1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665621542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3ozttBKplKfoKYx4kKgPboZZ60Js6dUUZGp7qB7T8A=;
        b=TarLo7j1ZPz+pMOzFkJ9VkA2EHF3zTGPiNWxUnVYG8LK+4n/FQNBzOdxIyFW1X6aS1b2gV
        EmCuPxkqhf0MEfzw/W2p/Im8XOkAS+WiGoyorNyeOrncA1d03KpWYWbgs9AGxbJ//lHB4C
        WE1Z6mosd8TffonkYemSMJa/CMcWoWc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3e471f55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Oct 2022 00:39:02 +0000 (UTC)
Date:   Wed, 12 Oct 2022 18:38:56 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/19] crypto: x86 - standardize suboptimal prints
Message-ID: <Y0deIKJwUJUagvKd@zx2c4.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-18-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221012215931.3896-18-elliott@hpe.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 04:59:29PM -0500, Robert Elliott wrote:
> Reword prints that the module is not being loaded (although
> it otherwise qualifies) because performance would be suboptimal
> on the particular CPU model.
> 
> Although modules are not supposed to print unless they're loaded
> and active, this is an existing exception.
> 
> Signed-off-by: Robert Elliott <elliott@hpe.com>
> ---
>  arch/x86/crypto/blowfish_glue.c     | 5 +----
>  arch/x86/crypto/camellia_glue.c     | 5 +----
>  arch/x86/crypto/des3_ede_glue.c     | 2 +-
>  arch/x86/crypto/twofish_glue_3way.c | 5 +----
>  4 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/crypto/blowfish_glue.c b/arch/x86/crypto/blowfish_glue.c
> index 27b7aed9a488..8d4ecf406dee 100644
> --- a/arch/x86/crypto/blowfish_glue.c
> +++ b/arch/x86/crypto/blowfish_glue.c
> @@ -320,10 +320,7 @@ static int __init blowfish_init(void)
>  		return -ENODEV;
>  
>  	if (!force && is_blacklisted_cpu()) {
> -		printk(KERN_INFO
> -			"blowfish-x86_64: performance on this CPU "
> -			"would be suboptimal: disabling "
> -			"blowfish-x86_64.\n");
> +		pr_info("CPU-optimized crypto module not loaded, crypto optimization performance on this CPU would be suboptimal\n");

This is a comma splice. You need some sort of conjunction.

But also: it's not like the user can do anything about this. Why clutter
dmesg? Seems like we'd be better off without these messages?
