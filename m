Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF4A6DBD59
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 23:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjDHVpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 17:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDHVpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 17:45:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3756590;
        Sat,  8 Apr 2023 14:45:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bp17-20020a17090b0c1100b0023f187954acso1479089pjb.2;
        Sat, 08 Apr 2023 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680990338; x=1683582338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqgSPZYBsDtVwiEZJVoDEmESaLU5H7DMz1BSoSn2S1Y=;
        b=mSJ/X1rr3c3vVPHxFoGeOmsi6zaCi+/+edXfzwes87BlIz/bdb4KVwCpsAogLkEECe
         H6FQLGTn8KB+93PdqO6eDEMypOPMpiVhXpRRuSCABL+waC1lujqqI8kO7eC+mqqDXbOf
         VkrdcDUSM/E758jYGxcj+lFncSdPQmn9mShx0nPK6hZTgsEzv8SY5ngjuqGyh5iaHbMg
         sDH/6uTCb8YCLZKmpujxpog07gJAhEeHLDUW99I6XiP6icQSyI0sY8u6cbjbdbPs9H3U
         OUUDM2C3G0I+H8BXAav2HpVuaS/92Ay35V+8b825chzgZfM3iGRm5tBSUFdh4G6p2jNC
         xgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680990338; x=1683582338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqgSPZYBsDtVwiEZJVoDEmESaLU5H7DMz1BSoSn2S1Y=;
        b=ZCnnq352EryaCngXCc1cqhW8dwbLIeeTF9RZ9BdTKcFHfTKvF2+3NZFh0kxZruOJcn
         s6MR9mhTcwi8xzH+WNMAKso1Ml/i5w9QRVdQdp5KYhk330b/6u9GcORE+Q6Z3vkGwodE
         1MbKvESkrf9vr8aeouog/d1ufKMZDg2GfiV0AqeE3JJtDGIZ/6raeTzsGsVC8vEqxkgC
         vquLrtwq6EP8v14k1hk29aUbCffAU1BttPXUKbc5mJgoOMwqpRs/FmmrAltJiGUt58Js
         UweOf03t0nrt01x6tOQBAJoZHXR0RUAUpGckJS1ECiMGVybLnXcHiSKA5EAuVRzP6LbC
         rZUQ==
X-Gm-Message-State: AAQBX9cPOifPo7CTdmbnyqvfbzw4R69yYjOloJQsKZlVVTLtc31Uf7eR
        iqH9ta6bnDGxnUIT0RNhrrQ=
X-Google-Smtp-Source: AKy350YeQ+EjOvH0//H82sraUYKe/H1jY2NGbOgELoyt7GUy4+kORmVMIBbchbzc/x3LIarUd4YXuA==
X-Received: by 2002:a17:90b:1e0f:b0:23f:ebf2:d3e9 with SMTP id pg15-20020a17090b1e0f00b0023febf2d3e9mr7851623pjb.6.1680990338393;
        Sat, 08 Apr 2023 14:45:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g15-20020a17090a7d0f00b002309279baf8sm6586668pjl.43.2023.04.08.14.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 14:45:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 8 Apr 2023 14:45:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tom Rix <trix@redhat.com>
Cc:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        wim@linux-watchdog.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] watchdog: s3c2410: remove unused freq_to_wdt and
 s3c2410wdt_is_running functions
Message-ID: <72a085ff-172f-4378-8ee2-5bf1e47958bf@roeck-us.net>
References: <20230321183439.1826823-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321183439.1826823-1-trix@redhat.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:34:39PM -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/watchdog/s3c2410_wdt.c:311:35: error: unused function
>   'freq_to_wdt' [-Werror,-Wunused-function]
> static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
>                                   ^
> drivers/watchdog/s3c2410_wdt.c:446:19: error: unused function
>   's3c2410wdt_is_running' [-Werror,-Wunused-function]
> static inline int s3c2410wdt_is_running(struct s3c2410_wdt *wdt)
>                   ^
> These functions are not used, so remove them.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/s3c2410_wdt.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 200ba236a72e..6394dda7a5dc 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -308,11 +308,6 @@ static inline unsigned int s3c2410wdt_max_timeout(struct s3c2410_wdt *wdt)
>  				       / S3C2410_WTCON_MAXDIV);
>  }
>  
> -static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
> -{
> -	return container_of(nb, struct s3c2410_wdt, freq_transition);
> -}
> -
>  static int s3c2410wdt_disable_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
>  {
>  	const u32 mask_val = BIT(wdt->drv_data->mask_bit);
> @@ -443,11 +438,6 @@ static int s3c2410wdt_start(struct watchdog_device *wdd)
>  	return 0;
>  }
>  
> -static inline int s3c2410wdt_is_running(struct s3c2410_wdt *wdt)
> -{
> -	return readl(wdt->reg_base + S3C2410_WTCON) & S3C2410_WTCON_ENABLE;
> -}
> -
>  static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd,
>  				    unsigned int timeout)
>  {
