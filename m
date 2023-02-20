Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF3169D1E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjBTRLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjBTRLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:11:17 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0920549
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:11:15 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id w3so1097329iom.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEOyqyX16+a0s8LVg/pF7pxqSztYrWWhg38vHHBi3tk=;
        b=Es+PiD554nf4b0lw9BenSHvyrbUQvjUaddCdjlFQzviROGfsy+bH6ztbIzUJj8HN3D
         kPFalkX9vL9YMjqz+RQVaezLe3n/aWJABu/mKRnRsZo/vKgmoFbWvroh6JVpowJoBHGr
         ouIETH64oNwmqNZtENWIe7zqF1yBoI9U+pI2+rgWa0wIwTubNonQomcCnOuI+qJ1Bgyb
         c5z1Hq8/EpN92SQK6JIMTTvJqi37WvromkSXSCfimYdo4Cphf5I8fw2JhNUTYXlvXl1y
         1ylrOYnpce4/fJktTg6YdKuj1QoRl2oV/CPtP27vQ5fjr4KMO/oZ0fCrGc1WANg5I610
         tb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEOyqyX16+a0s8LVg/pF7pxqSztYrWWhg38vHHBi3tk=;
        b=8JaRYchSBgBBaBl/IsMH9LnUL9ousPcoAVE32WccmmiAxpIzrsPUqAZ1yPRJGmqSb+
         7Ou7MYt9KuSlRSo0p1qEFk0qNwXWvqH0el//fUhnYVeCR12dFZCII02Izlsr/NcULRZ2
         yLiwerfpI3lsB21abOCMOhGZByXC2/z4swFtRLjcyDYN2XxNV9l+0qhEdWPVeNYlGJRn
         1/IgOGwrjYD0Vd5jbJU8Usm8LeFIUza+q0srgH8BGNpNwjLVxvFZsrlf51dxI9IzbyLW
         xvw/hg48nRHK0qEeAcxgHoUV1jSBavN3QKE6+cqAebb9eVvORhrPVN4VPMXIvfZC6cdH
         7qeg==
X-Gm-Message-State: AO0yUKUbQDTrI5Qq1MbQGMLmneN+mWEw7/6aR8M6EZDcitfvBC1ICGQ8
        QKmYeDtZ2w9yrRI9Ca7E9LmmLnYvmJgpABr659pSpw==
X-Google-Smtp-Source: AK7set+503zOSFCrMzUFKu9VpHP1CxTcABe7Y2qzNdRVr4GS9RE0Nr+Aep7G/9QRg/X7y9lOZcCc6YFmXuu71RYiegk=
X-Received: by 2002:a6b:6207:0:b0:71c:479d:741a with SMTP id
 f7-20020a6b6207000000b0071c479d741amr2462205iog.38.1676913075061; Mon, 20 Feb
 2023 09:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20230126031424.14582-1-quic_wcheng@quicinc.com> <20230126031424.14582-13-quic_wcheng@quicinc.com>
In-Reply-To: <20230126031424.14582-13-quic_wcheng@quicinc.com>
From:   Albert Wang <albertccwang@google.com>
Date:   Tue, 21 Feb 2023 01:11:04 +0800
Message-ID: <CANqn-rhAWKVrSGKkoDCC+Jy6qdceSqo22KYb-5k+haHpcgQJaA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/22] sound: usb: card: Introduce USB SND platform
 op callbacks
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, broonie@kernel.org,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com, quic_plai@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-16.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wesley,

It looks like your audio offload driver will fetch the required
resources for a stream enable request. But we have different designs.
In the integration with your patch set, we found we still need a call
back function in card.c when the usb set interface is done, in which
we would call the new API, xhci_get_xfer_resource(), to get the EP
transfer ring address. Of course, we will try the
platform_ops->connect_cb() first to see if it is able to cover what we
need or not.


Thanks,
Albert Wang

Albert Wang | Pixel USB Software  | albertccwang@google.com | +886-918-695-245


On Thu, Jan 26, 2023 at 11:16 AM Wesley Cheng <quic_wcheng@quicinc.com> wrote:
>
> Allow for different platforms to be notified on USB SND connect/disconnect
> seqeunces.  This allows for platform USB SND modules to properly initialize
> and populate internal structures with references to the USB SND chip
> device.
>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/card.c | 28 ++++++++++++++++++++++++++++
>  sound/usb/card.h | 20 ++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 26268ffb8274..803230343c16 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -117,6 +117,24 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
>  static DEFINE_MUTEX(register_mutex);
>  static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
>  static struct usb_driver usb_audio_driver;
> +static struct snd_usb_platform_ops *platform_ops;
> +
> +int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops)
> +{
> +       if (platform_ops)
> +               return -EEXIST;
> +
> +       platform_ops = ops;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_register_platform_ops);
> +
> +int snd_usb_unregister_platform_ops(void)
> +{
> +       platform_ops = NULL;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);
>
>  /*
>   * disconnect streams
> @@ -910,6 +928,10 @@ static int usb_audio_probe(struct usb_interface *intf,
>         usb_set_intfdata(intf, chip);
>         atomic_dec(&chip->active);
>         mutex_unlock(&register_mutex);
> +
> +       if (platform_ops->connect_cb)
> +               platform_ops->connect_cb(intf, chip);
> +
>         return 0;
>
>   __error:
> @@ -943,6 +965,9 @@ static void usb_audio_disconnect(struct usb_interface *intf)
>         if (chip == USB_AUDIO_IFACE_UNUSED)
>                 return;
>
> +       if (platform_ops->disconnect_cb)
> +               platform_ops->disconnect_cb(intf);
> +
>         card = chip->card;
>
>         mutex_lock(&register_mutex);
> @@ -1087,6 +1112,9 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
>                 chip->system_suspend = chip->num_suspended_intf;
>         }
>
> +       if (platform_ops->suspend_cb)
> +               platform_ops->suspend_cb(intf, message);
> +
>         return 0;
>  }
>
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index 40061550105a..2249c411c3a1 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -206,4 +206,24 @@ struct snd_usb_stream {
>         struct list_head list;
>  };
>
> +struct snd_usb_platform_ops {
> +       void (*connect_cb)(struct usb_interface *intf, struct snd_usb_audio *chip);
> +       void (*disconnect_cb)(struct usb_interface *intf);
> +       void (*suspend_cb)(struct usb_interface *intf, pm_message_t message);
> +};
> +
> +#if IS_ENABLED(CONFIG_SND_USB_AUDIO)
> +int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops);
> +int snd_usb_unregister_platform_ops(void);
> +#else
> +int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +int snd_usb_unregister_platform_ops(void)
> +{
> +       return -EOPNOTSUPP;
> +}
> +#endif /* IS_ENABLED(CONFIG_SND_USB_AUDIO) */
>  #endif /* __USBAUDIO_CARD_H */
