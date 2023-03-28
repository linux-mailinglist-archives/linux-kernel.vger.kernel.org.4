Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE066CBCE1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjC1Kus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1Kur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:50:47 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ABD1BC0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:50:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 567F3425BD;
        Tue, 28 Mar 2023 10:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1680000643; bh=Psp2s7G27u3PFSjPrVvcwN9o1kJcqRKqDmtgH/C0pyw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UbcSxKZwSdD3PDi3euGm2JEsLZsdONrH89yZvtEdABhuAW0++deIUvZm3fymn5FJx
         IGo5x4QWDQO18wwLBpNdZrJAlURkPMI2i7oMfKHrELz+r9HXX/XfwrVyIohu4auvLm
         4XPHj1zMVHcEcpFTqRkGni5B7ah8S73+8Z8BX0OMgFLsEfZmxu+XhuQCFx6NLcWxzP
         YVlWcKBVoR6F26yCJ20ve4OP73fcQhZerEiigI/7I2oCC8zvTVhQKS4trhgbUobEET
         +M7mTwSTW7KWgyVIQ2oRpHRX/lnIKl0OtaG4FSJJXEyZGS0R7yjd2/NTb78Zev6uAW
         F+Y6VIdXGgQwQ==
Message-ID: <7f41e2a7-dc0e-483d-9816-8fb742991b68@marcan.st>
Date:   Tue, 28 Mar 2023 19:50:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] soc: apple: rtkit: Fix buffer address field width
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230224-gpu-up-rtkit-v1-1-671178cb2a5e@asahilina.net>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230224-gpu-up-rtkit-v1-1-671178cb2a5e@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 15.49, Asahi Lina wrote:
> The buffer address field is missing two bits. This matters for the GPU,
> which uses upper-half 64-bit addresses on the ASC and those get sign
> extended from the mailbox message field, so the right number of high
> bits need to be set.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  drivers/soc/apple/rtkit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
> index 35ec35aa500d..a02a44a745f6 100644
> --- a/drivers/soc/apple/rtkit.c
> +++ b/drivers/soc/apple/rtkit.c
> @@ -55,7 +55,7 @@ enum {
>  
>  #define APPLE_RTKIT_BUFFER_REQUEST	1
>  #define APPLE_RTKIT_BUFFER_REQUEST_SIZE GENMASK_ULL(51, 44)
> -#define APPLE_RTKIT_BUFFER_REQUEST_IOVA GENMASK_ULL(41, 0)
> +#define APPLE_RTKIT_BUFFER_REQUEST_IOVA GENMASK_ULL(43, 0)
>  
>  #define APPLE_RTKIT_SYSLOG_TYPE GENMASK_ULL(59, 52)
>  
> 
> ---
> base-commit: 83f978b63fa7ad474ca22d7e2772c5988101c9bd
> change-id: 20230224-gpu-up-rtkit-f4bc18e78c8a
> 
> Thank you,
> ~~ Lina
> 

Applied to asahi-soc/soc!

- Hector

