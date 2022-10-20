Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B124A6056E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiJTFkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJTFku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAC9143A47
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666244446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3cLm9HnF52RPDChT7zvm6M4NNF+pwOpLfcF1b46hwk4=;
        b=NxYAwD5K7VIgaTi3+C9zhvuIanJX0Hiz/hEmhbVWO9TFWdyLrqcMZ4DS63xi1g2U2vJKpN
        wlOE0WO5J0HWSxpje6A6znZscfva/CdWsAwXPdCXWDtU3djQ/f4DFpB1+zZDcVd/bwQDjH
        d4CiCwzYufa9akU+Pi8tDdQlOKeHvBw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-iG5NECX0MZGtsG3VvbciQw-1; Thu, 20 Oct 2022 01:40:45 -0400
X-MC-Unique: iG5NECX0MZGtsG3VvbciQw-1
Received: by mail-oi1-f197.google.com with SMTP id c23-20020a544e97000000b0035468a53d49so8404161oiy.19
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cLm9HnF52RPDChT7zvm6M4NNF+pwOpLfcF1b46hwk4=;
        b=ulFiK47tS8d2UWn9HC73EAVennInKoEOo7iHFXnh5xnpGwD80o8GJcwziiXfUebAUf
         nFO07FPLjhEyksAPDM7m/a3IXU2yhREo0kzQ+LfNUbYhCOpzAAvz1gYQkbZP2Q9Uz2QN
         223SvM6vgva0sVjOQgXGxJpvSGysRx3ptAWRfpOGwkIErgQ/3zZL7FSUVkJ/91587Kar
         WLmQY13QL9OJCqCLlwmk96xFVmq7r7yApTQVZ15lILgzW9dg67ifhdGpIWqIhmrfbXB/
         sU3DlH+3OS2nJxrPwtEJhP38AZiDfqktZ/B7og1dqrMtlOnG77UCB+6QObuNKQDv53Xa
         kHZg==
X-Gm-Message-State: ACrzQf21QzCGFye76mZgCG4f0/gS4Qa9Z/bn/dhXlcHMaSQJauWWALvA
        bmcXi8G9QBja/MRU9sJCQprmvEOV/vNDJYS9JhQSPhSUcIOykPnOZ9Eh7ckeJizBu84wB8eeQPN
        RAAkx3caVnPp2VtidvH7BOBHX3HhhuZzKJIMgagKB
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id k15-20020a9d7dcf000000b00661dc250ba0mr6006238otn.201.1666244444378;
        Wed, 19 Oct 2022 22:40:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4KOnL5N1u6m6VXP6xpqvCTdnJWSdwlGbLkZlRfz6DwviF2O1N/QP25F1zjvuTZ8UH3pFNQC3QvWeykzR4PRL8=
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr6006229otn.201.1666244444153; Wed, 19
 Oct 2022 22:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com> <1666137032-28192-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666137032-28192-5-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 20 Oct 2022 13:40:32 +0800
Message-ID: <CACGkMEtV_amYoz7JqpJyyUMDnsZuPJYfXk8bP9Yb1oyJrhpY8w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] vdpa: fix improper error message when adding vdpa dev
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> In below example, before the fix, mtu attribute is supported
> by the parent mgmtdev, but the error message showing "All
> provided are not supported" is just misleading.
>
> $ vdpa mgmtdev show
> vdpasim_net:
>   supported_classes net
>   max_supported_vqs 3
>   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
> Error: vdpa: All provided attributes are not supported.
> kernel answers: Operation not supported
>
> After fix, the relevant error message will be like:
>
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
> Error: vdpa: Some provided attributes are not supported.
> kernel answers: Operation not supported
>
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 max_vqp 2
> Error: vdpa: All provided attributes are not supported.
> kernel answers: Operation not supported
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 91eca6d..ff15e0a 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -629,13 +629,20 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>                 err = PTR_ERR(mdev);
>                 goto err;
>         }
> -       if ((config.mask & mdev->config_attr_mask) != config.mask) {
> +       if (config.mask && (config.mask & mdev->config_attr_mask) == 0) {
>                 NL_SET_ERR_MSG_MOD(info->extack,
>                                    "All provided attributes are not supported");
>                 err = -EOPNOTSUPP;
>                 goto err;
>         }
>
> +       if ((config.mask & mdev->config_attr_mask) != config.mask) {
> +               NL_SET_ERR_MSG_MOD(info->extack,
> +                                  "Some provided attributes are not supported");
> +               err = -EOPNOTSUPP;
> +               goto err;
> +       }
> +
>         err = mdev->ops->dev_add(mdev, name, &config);
>  err:
>         up_write(&vdpa_dev_lock);
> --
> 1.8.3.1
>

