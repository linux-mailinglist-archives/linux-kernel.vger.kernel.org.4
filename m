Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E905ED5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiI1HVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiI1HVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:21:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E9CD2D4A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:21:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id cc5so18327028wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=8zn6lkl2vokh6itj6Ns6SXmRNN/W/gx52oKq/xijemA=;
        b=NJHF7bjWn49K6Y6H09ebqd0r6xepz4h3DzjtOdV7rs4++OxAN2Kv1Hp+nas/6xr8wr
         dtDRkRfgerOI1/9hhD+u+bzrQ380F+h0nbDVAjTJntmD5v/oj1B7aC9ynPPcUhCkVyth
         4hfh4tSkwMfsFzA3dEl71peqa+VYW5Ft/gYXw9lBB2jxZCzoaoX/jfXSEEOwuN1w6jCt
         7DMQxSWXaZ6kEx8r2yakn/5F5MK7HQRki0i/A0ptUCi1obApgg167+0RTsqxjbGFCa6r
         gs1RxVt7TchM8c2pVRX4BjrMS2k6kqRjJnEsw/6HI/lj5O9VyNANP/VS8ehLqeOIBIY4
         TMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=8zn6lkl2vokh6itj6Ns6SXmRNN/W/gx52oKq/xijemA=;
        b=YrZs9xAgcIRouECMAtV+YMgqN7JcHEIkNeSwe39P05tPEI3/HzOyYkugsutZW0UClX
         26I2/lpBqcXBe/yJnmBEGH7v9VRz5M8aAhO1NXUdTotaMOGqX27Cu41uR4gckPWw4tyZ
         1NTTqYq1e9KG8bsLCAjj42MTZ/kM/0DmukyHGQQkws+Atdt3ODqYV5jrdtFhw6/OVNOf
         lkWPBieYkvZhfOrPbCEy3/Y7zlq2WyrQTZFlu8zbokkP3aJW0pz5UudpUGnYJUamh75v
         XdAHpc6r2YCV03eBkhjQyjVCO5hDqtDTjSx3zs5i0KrlPROLoq/sb/upu6cgIFYtfJvR
         QX6w==
X-Gm-Message-State: ACrzQf31ta6wvTEY+bZK7ZnsLJecp5F30WegdAUQkuJ/YbLNy/XVJ8lW
        aEdejIyFCF8WZ2ky0UrhlJA+aQ==
X-Google-Smtp-Source: AMsMyM5O3xrTlV7t0FdNf/d6caLIfXYe6kFbNK/mai1hkt5c9PSzdLYC7rx3bGVhJrY+CI3qt0JDAg==
X-Received: by 2002:a05:6000:15ce:b0:226:f2ab:516d with SMTP id y14-20020a05600015ce00b00226f2ab516dmr19594330wry.264.1664349702329;
        Wed, 28 Sep 2022 00:21:42 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:5f1e:d910:dd1e:5b09])
        by smtp.gmail.com with ESMTPSA id i1-20020adfa501000000b0022a2f4fa042sm3484424wrb.103.2022.09.28.00.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 00:21:41 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Nate Yocom <nate@yocom.org>, dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net,
        benjamin.tissoires@redhat.com
Subject: Re: [PATCH v6 1/5] Input: joystick: xpad: Add X-Box Adaptive support
In-Reply-To: <20220908173930.28940-2-nate@yocom.org>
References: <20220908173930.28940-1-nate@yocom.org>
 <20220908173930.28940-2-nate@yocom.org>
Date:   Wed, 28 Sep 2022 09:21:40 +0200
Message-ID: <87tu4sezgb.fsf@mkorpershoek-xps-13-9370.home>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 10:39, Nate Yocom <nate@yocom.org> wrote:

> Adds correct VID/PID for this XTYPE_XBOXONE compatible controller to
> xpad_device[] table.
>
> Signed-off-by: Nate Yocom <nate@yocom.org>
> Tested-by: Bastien Nocera <hadess@hadess.net>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/joystick/xpad.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 18190b529bca..c8b38bb73d34 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -131,6 +131,7 @@ static const struct xpad_device {
>  	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
>  	{ 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0, XTYPE_XBOXONE },
>  	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
> +	{ 0x045e, 0x0b0a, "Microsoft X-Box Adaptive Controller", 0, XTYPE_XBOXONE },
>  	{ 0x045e, 0x0b12, "Microsoft Xbox Series S|X Controller", MAP_SELECT_BUTTON, XTYPE_XBOXONE },
>  	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
>  	{ 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360 },
> -- 
> 2.30.2
