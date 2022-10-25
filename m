Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E960C6CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJYIqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJYIpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:45:55 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF2AD18D1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:45:54 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p16so9746114iod.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r7Y5khI94/D2ljSZhlC1O6a2PmmY16yoIwTovHKDb3o=;
        b=a1vITaQWC9wX5kZL0LSKI6aBsiRjCc4Sv++aaVxhu7tmXDZWlAkT4hTB/LO2SU8kei
         OpaIiKyH8rO75wdLEY76es+7cGVc6FI9hNpKUIISNQkOwERw7tYB8wCyKB0EzPYw+9ko
         ASdRb7Pp8VU6GGx4cDhDRamITFOdGk8+vIPjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7Y5khI94/D2ljSZhlC1O6a2PmmY16yoIwTovHKDb3o=;
        b=K1LmgwAkxHaJHkHGVUTogcYTCwCYC/sCtlOHcp+M+qk22ZZEq3n0I3Szp0jQQ1lmnf
         Kfuo8RleBheAaFnJTKTpzdb7iphFFNsEBNhgnYFX5KKq/jOHtwKuLQqpmKRNTOWRvM8o
         54BK6MH99Lps9M/ojttbW1Amf7oXMVYpDc8Vn4Ujyb+PFjVt/3sxrOJWFbLepf9Z3zng
         ICbRlQNcp1HkfowhevoYyHKOJTwXWOZj7q2lwuzCNOtm3rMgzYgfabhbyXWxfIO7XUu7
         tfBZhmP97Krh1K6qBscnvqVd2aTEI/kVJyPnCqsp6LigEtgfAD9cv1LTlHy3JPOwBtHI
         EcWQ==
X-Gm-Message-State: ACrzQf2u3NsLRi16Kr9fQcoprXgyJN3SpS1TpKH8v8EenopUTA0TIUXV
        WJu1TbCWHVO2YkzFRxpOSd3Keu5oQoCa1s/7
X-Google-Smtp-Source: AMsMyM7CzvIvGFcWSx+6ebHVvTIKLLDt53Qp9ih4SXZLRcyOp3JPzd5ZakbmUjvOg4NQYLNCvEhY9A==
X-Received: by 2002:a05:6638:138c:b0:364:4c3:eafc with SMTP id w12-20020a056638138c00b0036404c3eafcmr24641282jad.163.1666687553298;
        Tue, 25 Oct 2022 01:45:53 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id p17-20020a02b391000000b00374a9dbd061sm686273jan.73.2022.10.25.01.45.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 01:45:52 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id n73so9693569iod.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:45:51 -0700 (PDT)
X-Received: by 2002:a02:cc51:0:b0:36d:df36:fcb1 with SMTP id
 i17-20020a02cc51000000b0036ddf36fcb1mr8743541jaq.51.1666687551449; Tue, 25
 Oct 2022 01:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221025050450.1743072-1-pedro.guilherme@espectro.eng.br> <20221025050450.1743072-2-pedro.guilherme@espectro.eng.br>
In-Reply-To: <20221025050450.1743072-2-pedro.guilherme@espectro.eng.br>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 10:45:40 +0200
X-Gmail-Original-Message-ID: <CANiDSCs1pQEq73=vuNR9gymLMZFDkS3acDXRPNT=hc=eEvLzSA@mail.gmail.com>
Message-ID: <CANiDSCs1pQEq73=vuNR9gymLMZFDkS3acDXRPNT=hc=eEvLzSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] media: uvc_driver: fix assignment inside if condition
To:     Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 at 07:08, Pedro Guilherme Siqueira Moreira
<pedro.guilherme@espectro.eng.br> wrote:
>
> Fixes 'do not use assignment in if condition' errors issued by
> scripts/checkpatch.pl on drivers/media/usb/uvc/uvc_driver.c
>
> Signed-off-by: Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index b591ad823c66..7b6c97ad3a41 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1174,7 +1174,8 @@ static int uvc_parse_control(struct uvc_device *dev)
>                     buffer[1] != USB_DT_CS_INTERFACE)
>                         goto next_descriptor;
>
> -               if ((ret = uvc_parse_standard_control(dev, buffer, buflen)) < 0)
> +               ret = uvc_parse_standard_control(dev, buffer, buflen);
> +               if (ret < 0)
>                         return ret;
>
>  next_descriptor:
> @@ -2213,7 +2214,8 @@ static int uvc_probe(struct usb_interface *intf,
>         usb_set_intfdata(intf, dev);
>
>         /* Initialize the interrupt URB. */
> -       if ((ret = uvc_status_init(dev)) < 0) {
> +       ret = uvc_status_init(dev);
> +       if (ret < 0) {
>                 dev_info(&dev->udev->dev,
>                          "Unable to initialize the status endpoint (%d), status interrupt will not be supported.\n",
>                          ret);
> --
> 2.38.1
>


-- 
Ricardo Ribalda
