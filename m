Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D76559DA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 12:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiLXLDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 06:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLXLDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 06:03:22 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F54F10B42
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 03:03:21 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-43ea87d0797so96323027b3.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 03:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wscqc2C27Eeh5FeH6qcDsPHlAH/sUr+ViavfKbnFGHc=;
        b=LwWziywdJQwYB9g0yUQ9icpLt6u+Cr4FiA2ZBk85IYMHET1ZVjouC9XVzrxd/NjSth
         wQ+MI4Ty9oifNntiIYGhw9FlLKO/3r50BP5FsZrAiBGBrCVEm5ITA+n1KovFZ47Bh+LB
         XHa7o8N7uMS99sG7iS1B+SEfCkuMlQlMCaJnelB0n5wkpyVca8jxYaVFDnwX+5+oSPjc
         PhpHYUwxtkb+KW9l3vpx7L1iBj6GY76QLALqk7uKarmgQ1N5SN9venCHK8n6445E1iC+
         GQdcpLcRPetwAPlT7L+8C9b7a8JS1WU4g3ODd8hmZHzR7SrJrwEjJ6hDIktMjv24QvoX
         Hs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wscqc2C27Eeh5FeH6qcDsPHlAH/sUr+ViavfKbnFGHc=;
        b=iIpPd+DOuASfqWF+OV3M+psbrbC/YLWW2Iq49fg5n8A3mTJNME+SWtvOsnbZsr+ikW
         Cc4HeMcmV78e5Kg/cTDUtL7Bdn4EpdOxcHPvv04ejb0KMMM3RAAutmLVUClg/xaXKPjR
         uPYgoS+cirwK6ZmSUhnKOtjEq4++pbk3k3lsqcPhEwi/4xS4mDkzpqqfgaS2yz2FQ4rh
         Mtuj8vevELbJ3Dm32yhVZ2esyC+PpHS92NXCsXcgJhu7ZMlqMQptSRyQv6l5WkBIcc5e
         PCKwbeJUR4/sLE9ugnjaxK7/o4PKFOAz4nNmmnIiT52ncu3CRQ8ACjpw9NPJpq6dHkQ2
         fYMw==
X-Gm-Message-State: AFqh2kqnQNunk4iBmbpML/VsWTRZfofmbiNEEBbk0K981XFRQRwaw76Z
        EEIa+cjDw2dkgr/q/dg4qewHYodvEEGlgsVmEMcitg==
X-Google-Smtp-Source: AMrXdXu6D08PplIiID9SMCkGNDJyskeH2mIep/a2zhdjuZ4jecR/HSzkQfPRduxZlxVHiF1IkHSnx71TNlwJSs2QMIQ=
X-Received: by 2002:a0d:f2c1:0:b0:3d6:2151:4038 with SMTP id
 b184-20020a0df2c1000000b003d621514038mr1216250ywf.418.1671879800394; Sat, 24
 Dec 2022 03:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20221223233200.26089-1-quic_wcheng@quicinc.com> <20221223233200.26089-5-quic_wcheng@quicinc.com>
In-Reply-To: <20221223233200.26089-5-quic_wcheng@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 24 Dec 2022 13:03:09 +0200
Message-ID: <CAA8EJprFD53zmECHJ44FpjztRjwsMym2QP_Gk-JWya-SL_ryHA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/14] sound: usb: card: Introduce USB SND vendor op callbacks
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com, quic_plai@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 24 Dec 2022 at 01:33, Wesley Cheng <quic_wcheng@quicinc.com> wrote:
>
> Allow for different vendors to be notified on USB SND connect/disconnect
> seqeunces.  This allows for vendor USB SND modules to properly initialize
> and populate internal structures with references to the USB SND chip
> device.

The commit message definitely needs some improvement. We do not notify
vendors on SND connect/disconnect events.


>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/card.c | 22 ++++++++++++++++++++++
>  sound/usb/card.h |  7 +++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 26268ffb8274..212f55a7683c 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -117,6 +117,21 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
>  static DEFINE_MUTEX(register_mutex);
>  static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
>  static struct usb_driver usb_audio_driver;
> +static struct snd_usb_vendor_ops *vendor_ops;
> +
> +int snd_usb_register_vendor_ops(struct snd_usb_vendor_ops *ops)

platform ops?

> +{
> +       vendor_ops = ops;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_register_vendor_ops);

What happens if several platforms try to register different ops? I saw
from the patch 09/14 that you register these ops unconditionally. If
other devices follow your approach there is an obvious conflict.

> +
> +int snd_usb_unregister_vendor_ops(void)
> +{
> +       vendor_ops = NULL;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_unregister_vendor_ops);
>
>  /*
>   * disconnect streams
> @@ -910,6 +925,10 @@ static int usb_audio_probe(struct usb_interface *intf,
>         usb_set_intfdata(intf, chip);
>         atomic_dec(&chip->active);
>         mutex_unlock(&register_mutex);
> +
> +       if (vendor_ops->connect_cb)
> +               vendor_ops->connect_cb(intf, chip);
> +
>         return 0;
>
>   __error:
> @@ -943,6 +962,9 @@ static void usb_audio_disconnect(struct usb_interface *intf)
>         if (chip == USB_AUDIO_IFACE_UNUSED)
>                 return;
>
> +       if (vendor_ops->disconnect_cb)
> +               vendor_ops->disconnect_cb(intf);
> +
>         card = chip->card;
>
>         mutex_lock(&register_mutex);
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index 40061550105a..a785bb256b0d 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -206,4 +206,11 @@ struct snd_usb_stream {
>         struct list_head list;
>  };
>
> +struct snd_usb_vendor_ops {
> +       void (*connect_cb)(struct usb_interface *intf, struct snd_usb_audio *chip);
> +       void (*disconnect_cb)(struct usb_interface *intf);
> +};
> +
> +int snd_usb_register_vendor_ops(struct snd_usb_vendor_ops *ops);
> +int snd_usb_unregister_vendor_ops(void);
>  #endif /* __USBAUDIO_CARD_H */



--
With best wishes

Dmitry
