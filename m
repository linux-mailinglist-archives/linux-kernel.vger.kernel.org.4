Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079D7609D02
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJXIng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJXInb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B4036877
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666601009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EBlUPB1Dnp0ElzXkc2Q3P+CryDXBiZoMR2HhVEPoizo=;
        b=HtE8QnpQAJkj3keQ8i+vW9mG3TvKHASStspNpN1nY7L8khvTm8gaN2JmhMw5zWhvJEWxM1
        tX9vQZB4GN+tIRFJWJbaz+G1jg2DE5ZLtrk4ygNc2/J9vUmPlTO+05Ftr1Gkltjhxb/+if
        jXujFmEk25W3HqntEmNGcNVrUnobIc4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-155-oC0XPpgrPCOMKoezyrDXSg-1; Mon, 24 Oct 2022 04:43:28 -0400
X-MC-Unique: oC0XPpgrPCOMKoezyrDXSg-1
Received: by mail-oo1-f69.google.com with SMTP id o2-20020a4a3842000000b004808060499dso4287536oof.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBlUPB1Dnp0ElzXkc2Q3P+CryDXBiZoMR2HhVEPoizo=;
        b=HeSK7oWDdlmVzpPsphpovQMpeD7uNi1ohfLcx4Eg/Qb7h7xUXcXJd1kokZ9My3/kJX
         GH+GGYNHsN/kW98/Ye+MFGMwlhycCOltfWuKqJwbo39zJd49CQVs5bjyI/nfikLsEZep
         Ur1ASZ4e1xOsON8Vd6z5wU1dmJ7kuXIoKx5EaVGqPOhnIIQ+N8YUCVhS+R+Wmv1/sER8
         Te1GdbEjMTKFf4iPo5QuXyu19qIp67pp3e//na0iLOOtNlik4BnujNROXxOFkUv2mn76
         T9iq4UZDVyD5HCOnsYx0pE8h/Yx+UZTO/u+YF/mJhoqck8j2Fxkrk3tkQ0rChwqPnf7b
         rJ9w==
X-Gm-Message-State: ACrzQf0lUQrHwmPZGSnGbSiQAGCAQaEAii6gL3n0TUa2fII7+/Wj/yHh
        7W9WxdDKCG9TeRWBz0GOv5cE8O/4hdRlgbsPtH02WrJl5iTj4YM83hh6HTkLbiE7JYbJ6vNyGUU
        uSr/mRBa+UTdpCwg/9KU2FTXQsurrzO6VrAAY7gd0
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id eo40-20020a056870eca800b00132df465c66mr19808366oab.280.1666601007326;
        Mon, 24 Oct 2022 01:43:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Zb3Orw6wWrAZqEE2L4Qxj7bg42maeF5Lhl/j9tCMcEzX9D2AU5Ii/raMPDKVRJlXIuPk+u3Usv21pTZYHLDc=
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id
 eo40-20020a056870eca800b00132df465c66mr19808358oab.280.1666601007098; Mon, 24
 Oct 2022 01:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com> <1666392237-4042-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666392237-4042-5-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 24 Oct 2022 16:43:15 +0800
Message-ID: <CACGkMEvuExLpzOEDJN_dq+t3MBDNgpnkapyk13xtWBF4nKxutg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] vdpa: fix improper error message when adding vdpa dev
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
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
> index bfb8f54..2638565 100644
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

