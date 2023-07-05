Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CF2747CDE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGEGP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGEGPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:15:24 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950C410EA;
        Tue,  4 Jul 2023 23:15:19 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688537718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmOxAXQHkYLKF9gR92m1Yb4f5iEOyGKpTqWF2Mnxsow=;
        b=o/GO2j7TXqz0LLpqHY7sjQqSXdSYbWBe8gE+bnCU572ADqIc1ADXgFXlqq/m+GRrXzIyZ2
        fZ3DZ6vRArHlyWddk+QrtUqOQQTbcdGgJT11jiIhpru3UjH4yTQYNcW+94HflugMjWTXT7
        my0V6M/jxCDc6410NpoKrZ+sHwB1pHXvQGE81P/9aGCp2FfqX+yPouGy8BVX32m789kICM
        36tOGd25iRmjS+NBPzlO11byVOYTAOqz4mLUg/HTwlquidUUA+8sjM3MBMOMm1zViLlrQB
        y5TNnQmMb/rsCedqswiMBbxcZ+uJ2Z7GOV8r07Pp99N+eDQIf0xWAcYm3Ua9/w==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11C681C0005;
        Wed,  5 Jul 2023 06:15:16 +0000 (UTC)
Date:   Wed, 5 Jul 2023 08:15:16 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Yu Hao <yhao016@ucr.edu>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: lan78xx: Fix possible uninit bug
Message-ID: <20230705081516.67d0e26e@bootlin.com>
In-Reply-To: <CA+UBctD1E5ZLnBxkrXh3uxiKiKXphnLKiB=5whYtH73SCTESWw@mail.gmail.com>
References: <CA+UBctD1E5ZLnBxkrXh3uxiKiKXphnLKiB=5whYtH73SCTESWw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 18:15:09 -0700
Yu Hao <yhao016@ucr.edu> wrote:

> The variable buf should be initialized in the function lan78xx_read_reg.
> However, there is no return value check, which means the variable buf
> could still be uninit. But there is a read later.
> 
> Signed-off-by: Yu Hao <yhao016@ucr.edu>
> ---
>  drivers/net/usb/lan78xx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index c458c030fadf..4c9318c92fe6 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1091,8 +1091,11 @@ static int lan78xx_write_raw_otp(struct
> lan78xx_net *dev, u32 offset,
>     int i;
>     u32 buf;
>     unsigned long timeout;
> +   int ret;
> 
> -   lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
> +   ret = lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
> +   if (ret < 0)
> +       return ret;
> 
>     if (buf & OTP_PWR_DN_PWRDN_N_) {
>         /* clear it and wait to be cleared */

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
