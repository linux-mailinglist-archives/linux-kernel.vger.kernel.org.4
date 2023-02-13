Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F42B69535C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjBMVsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjBMVsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:48:08 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1A3166FF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:48:07 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id b81so6993941vkf.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S3obMmlZQYaGRz/X7lxV778PRHC7QpUlV9JI6kMs3aI=;
        b=FC1McpksbJo1OWPJfmFPFoBTApwDonUMQk4mGUWl5F0CbuAEMsjumwh3hGu/1JBVpK
         Iye8KHJ5yy+0R82YMbXfycQm5GVzBjjUwQX0HVeZ9KXzvlhpXpnE9icUTNOXr+X7cINk
         ZhY8hFETETqjEJEygxs6P8Cgki17dTkSKCurBYNbitq9GSh9u2sr+YD8s1pLZQsFUq7N
         Blj8KeOagLyESkIgzgUTy2iyYzgqmZIim2GC9xEqHcqx23V+KYCQY4tVwlwPP/Lecsqw
         m3TCyK5qGCI+hXTGgB2wo7x0vis8G/AMbDoHAfiEikGgtKy//75+1OVPlN2+9S6ppC7G
         Xc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3obMmlZQYaGRz/X7lxV778PRHC7QpUlV9JI6kMs3aI=;
        b=TEshjL1IJQ4x3Gyj7EcKVX0whHY7HfsBpV5R603QqbgKedMVbZH1IOgIy2jPgLQbV7
         NhZMNMWDEO1g8ZYkOfyeg/2vL/CVGFvSaG4Rs35iSTcDVXG8vqMQccrWDnlAk1AjE5JJ
         CQ80asHpX4mXaphoIQOb4tRwBtHepVRv94uyPkt0Cu8LDsr89GCcNg7SW0kjHlNOvNDj
         kWJKHYRov5Nse9SbiI8wJElerbgWW85z9EhT19jONupCOr/ADr8tU1Sjw+2fMSP3v2D8
         Et4ccK0BQOmlt7ZEOCyToEuXniPFpMxnfYcgJTR1LeGB5yx5UZmIPn1LTqnA0ERQn/nS
         A1lA==
X-Gm-Message-State: AO0yUKVLHsjh48dQwM+OxTJNn4Nh/KPwIw13HFskSCX9Sfr15C+GNUdg
        yyQKExG+cJqnd8DuI11nutW5v1SYvG6FB4qeKwhLmQ==
X-Google-Smtp-Source: AK7set9HKIO2aDRBpW9el5kRiOlDiAxD3gxwAa16FMDcKG30HHhfU5/GrCumWG+i9Mtm3FnDIYK9ZkLFfuXG6rv8CRk=
X-Received: by 2002:a1f:23d4:0:b0:3e7:295d:64d8 with SMTP id
 j203-20020a1f23d4000000b003e7295d64d8mr4345228vkj.35.1676324886552; Mon, 13
 Feb 2023 13:48:06 -0800 (PST)
MIME-Version: 1.0
References: <20230212175659.4480-1-quic_kriskura@quicinc.com>
In-Reply-To: <20230212175659.4480-1-quic_kriskura@quicinc.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Mon, 13 Feb 2023 13:47:54 -0800
Message-ID: <CANP3RGerSsUPhzdExrok_sc2jst2firjsEkaLepHDgt_sFmO4w@mail.gmail.com>
Subject: Re: [RFC] usb: gadget: ncm: Add support to configure wMaSegmentSize
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't a review per say - just some loose comments.

On Sun, Feb 12, 2023 at 9:57 AM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
> Currently the NCM driver restricts wMasxSegmentSize that indicates

there's a number of spelling mistakes, here, and in the commit title

> the datagram size coming from network layer to 1514. However the
> spec doesn't have any limitation.
>
> Add support to configure this value before configfs symlink is
> created. Also since the NTB Out/In buffer sizes are fixed at 16384
> bytes, limit the segment size to an upper cap of 8192 bytes so that
> at least 2 packets can be aggregated.

I've experimented with increasing mtu to boost performance before
(have some half-baked patches/scripts somewhere).
And while it did improve point-to-point performance, it wasn't
actually useful for any real world use cases,
as internet mtu is simply never above 1500.

Note that you cannot simply receive, aggregate (lro/gro) and forward
aggregated packets without splitting them back up.

A change like this to be useful would require negotiating some sort of
gso capabilities between the two devices
(and thus extending the NCM standard).  I've been meaning to do
this... but time...

> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/gadget/function/f_ncm.c | 55 +++++++++++++++++++++++++++++
>  drivers/usb/gadget/function/u_ncm.h |  1 +
>  2 files changed, 56 insertions(+)
>
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
> index 424bb3b666db..1969e276017f 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -118,6 +118,12 @@ static inline unsigned ncm_bitrate(struct usb_gadget *g)
>  /* Delay for the transmit to wait before sending an unfilled NTB frame. */
>  #define TX_TIMEOUT_NSECS       300000
>
> +/*
> + * Currently the max NTB Buffer size is set to 16384. For atleast 2 packets
> + * to be aggregated, the size of datagram must at max be 8192.
> + */
> +#define MAX_DATAGRAM_SIZE      8192

From what I recall, there's a fair bit of overhead, and 8192 x2
doesn't actually fit in 16384...
That said... is it reasonable to require 2 to fit?  why? what's wrong
with 15000?

> +
>  #define FORMATS_SUPPORTED      (USB_CDC_NCM_NTB16_SUPPORTED |  \
>                                  USB_CDC_NCM_NTB32_SUPPORTED)
>
> @@ -1440,6 +1446,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>          */
>         if (!ncm_opts->bound) {
>                 mutex_lock(&ncm_opts->lock);
> +               ncm_opts->net->mtu = (ncm_opts->max_segment_size - 14);

this should use a constant, ETH_HLEN probably

>                 gether_set_gadget(ncm_opts->net, cdev->gadget);
>                 status = gether_register_netdev(ncm_opts->net);
>                 mutex_unlock(&ncm_opts->lock);
> @@ -1484,6 +1491,8 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>
>         status = -ENODEV;
>
> +       ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
> +

Curious... wasn't this set previously?

>         /* allocate instance-specific endpoints */
>         ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
>         if (!ep)
> @@ -1586,11 +1595,56 @@ USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
>  /* f_ncm_opts_ifname */
>  USB_ETHERNET_CONFIGFS_ITEM_ATTR_IFNAME(ncm);
>
> +static ssize_t ncm_opts_max_segment_size_show(struct config_item *item,
> +                                               char *page)
> +{
> +       struct f_ncm_opts *opts = to_f_ncm_opts(item);
> +       u32 segment_size;
> +
> +       mutex_lock(&opts->lock);
> +       segment_size = opts->max_segment_size;
> +       mutex_unlock(&opts->lock);
> +
> +       return sprintf(page, "%u\n", segment_size);
> +}
> +
> +static ssize_t ncm_opts_max_segment_size_store(struct config_item *item,
> +                                               const char *page, size_t len)
> +{
> +       struct f_ncm_opts *opts = to_f_ncm_opts(item);
> +       int ret;
> +       u32 segment_size;
> +
> +       mutex_lock(&opts->lock);
> +       if (opts->refcnt) {
> +               ret = -EBUSY;
> +               goto out;
> +       }
> +
> +       ret = kstrtou32(page, 0, &segment_size);
> +       if (ret)
> +               goto out;
> +
> +       if (segment_size > MAX_DATAGRAM_SIZE) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       opts->max_segment_size = segment_size;
> +       ret = len;
> +out:
> +       mutex_unlock(&opts->lock);
> +       return ret;
> +}
> +
> +CONFIGFS_ATTR(ncm_opts_, max_segment_size);
> +
>  static struct configfs_attribute *ncm_attrs[] = {
>         &ncm_opts_attr_dev_addr,
>         &ncm_opts_attr_host_addr,
>         &ncm_opts_attr_qmult,
>         &ncm_opts_attr_ifname,
> +       &ncm_opts_attr_max_segment_size,
>         NULL,
>  };
>
> @@ -1633,6 +1687,7 @@ static struct usb_function_instance *ncm_alloc_inst(void)
>                 kfree(opts);
>                 return ERR_CAST(net);
>         }
> +       opts->max_segment_size = cpu_to_le16(ETH_FRAME_LEN);
>         INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
>
>         descs[0] = &opts->ncm_os_desc;
> diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
> index 5408854d8407..fab99d997476 100644
> --- a/drivers/usb/gadget/function/u_ncm.h
> +++ b/drivers/usb/gadget/function/u_ncm.h
> @@ -31,6 +31,7 @@ struct f_ncm_opts {
>          */
>         struct mutex                    lock;
>         int                             refcnt;
> +       u32                             max_segment_size;
>  };
>
>  #endif /* U_NCM_H */
> --
> 2.39.0
>
