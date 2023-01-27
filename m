Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8764767E857
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjA0OeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjA0OeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:34:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6257810AAF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:34:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4274B82114
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F77C433D2;
        Fri, 27 Jan 2023 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674830052;
        bh=DK0+ODwfApxIzpdQu/leU0y/FH2vCVxk5kJJdJLCFLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfu80J9gS53/y8huiFUCM+iPDL2hgliQj0prxTfug1DjqsWASlaiq2IGPDuGmwhFp
         nYhPDzC0ABKsZ6iKS2b07vFBGlEKkgMZDUUaoab2pUWJv7TVdvpvLOnJsOiRIbmCK+
         itRqRclxfVlGwtBuMlZ2h9wPQuKS03n9wROm1NtNZSXZSEqDbyjJbDihMSIKUegqkq
         G0bN7+YmwD/SDYH0+Yph5kfT9qSiHHz9iJMR7gi7da4p2SchJnbeTJMEBprDp/Wzv5
         vcErXvyGV5epZs7xHvyh6QiItoki9rZHEOyxTccHrP02IwqFpbm2Jnc0CwipPWeXWD
         AsoZqmIZC7q2Q==
Date:   Fri, 27 Jan 2023 14:34:07 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: ntxec: Add version number for EC in Tolino Vision
Message-ID: <Y9Pg35aH5WL7burc@google.com>
References: <20230123230114.3134400-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230123230114.3134400-1-andreas@kemnade.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023, Andreas Kemnade wrote:

> The EC firmware has a different version number than anything
> defined until now.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/ntxec.c       | 1 +
>  include/linux/mfd/ntxec.h | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
> index e16a7a82a929..b02785b10d48 100644
> --- a/drivers/mfd/ntxec.c
> +++ b/drivers/mfd/ntxec.c
> @@ -175,6 +175,7 @@ static int ntxec_probe(struct i2c_client *client)
>  	/* Bail out if we encounter an unknown firmware version */
>  	switch (version) {
>  	case NTXEC_VERSION_KOBO_AURA:
> +	case NTXEC_VERSION_TOLINO_VISION:
>  		subdevs = ntxec_subdev;
>  		n_subdevs = ARRAY_SIZE(ntxec_subdev);
>  		break;
> diff --git a/include/linux/mfd/ntxec.h b/include/linux/mfd/ntxec.h
> index cc6f07bfa2b3..562895eb9a31 100644
> --- a/include/linux/mfd/ntxec.h
> +++ b/include/linux/mfd/ntxec.h
> @@ -35,4 +35,8 @@ static inline u16 ntxec_reg8(u8 value)
>  #define NTXEC_VERSION_KOBO_AURA	0xd726	/* found in Kobo Aura */
>  #define NTXEC_VERSION_TOLINO_SHINE2 0xf110 /* found in Tolino Shine 2 HD */
>  
> +/*
> + * found in Tolino Vision, contains RTC, ADC, PWM, home pad
> + */

Could you please use the same formatting as the others.

> +#define NTXEC_VERSION_TOLINO_VISION 0xe135
>  #endif
> -- 
> 2.30.2
> 

-- 
Lee Jones [李琼斯]
