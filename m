Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52530605665
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJTEiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 00:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiJTEil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BC5161FFD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666240718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kyv8nGXj9Ah4DccAJThYdzgEzvLEuADjYtSpDgDrIrY=;
        b=ilkpoW9OgrBvWHcesYY8J8Oi3kgJKhLM3r9aQcu/78Y9Z8Fr3d97pA23XDyjcT2PuQPHVS
        6yd1a4+nmg2kTT5sMvXJeySBteQ02J/7QPnnLrsBPPWAsNzh5gQ4Ef/LM+KOYkK98fLHdc
        0kYXVb9k/U1oSU19U3tRQ3WAkPLzEqQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-UG4APNjgNX2bVfojPeyamw-1; Thu, 20 Oct 2022 00:38:36 -0400
X-MC-Unique: UG4APNjgNX2bVfojPeyamw-1
Received: by mail-ed1-f72.google.com with SMTP id s8-20020a056402520800b0045cab560d5eso15477631edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kyv8nGXj9Ah4DccAJThYdzgEzvLEuADjYtSpDgDrIrY=;
        b=6gjVknf69cGEB5yVETBktraJEm6dWY50v/q0wPTYFr8zw6HZTC3Q8Gl7KMG4Ez+Xmw
         SF4UARC8uPkxGk8ONrCx5yV1l81sTrqRnKojSp7ojQxHitq0USqbVAzPtFHDBQd3dfCD
         rsECYUAq+RqZAqONQhfAXKG3BCUHYTdlZ24nH6U3PHQVWN0fceXw5cFEYCC1vqwg/Ai9
         itudkrEfAZ7FrUMCR0r3SGmsoVkH+MHbwJ5XVs08bupIxmIfMFS2HOfXyvmGa1vvcAx0
         3/jDT4N4/nm36j6XZf2mts6qwoJRqUScz63qF5/fgR3hkgDGt8YPQgiujfJ01w3lKMUH
         mNsQ==
X-Gm-Message-State: ACrzQf3iTuPJujxupaosiarNJ8Y7fwJM/r6RD41/NPqtO45BJlX3ey5n
        D2CXnIsOcugbbttZlsL6aMv0MAPGWdbe178pXl3dg4GINxqpQkWSQx1/7wYeC8tjX9rAh0HO038
        Bu/BfVHyinNeDPoTFN/btW0BHnSTEyHTqpNC3KraD
X-Received: by 2002:a17:906:8a62:b0:78d:a05c:c37f with SMTP id hy2-20020a1709068a6200b0078da05cc37fmr9268197ejc.159.1666240715759;
        Wed, 19 Oct 2022 21:38:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ZwOFEZM8doQCzml9WL1ee9yuCrqJnl7mDRSvjurlf1Q90Jp73KqKd+JTzUxzcUph64t0ai8+bt62iwoatemI=
X-Received: by 2002:a17:906:8a62:b0:78d:a05c:c37f with SMTP id
 hy2-20020a1709068a6200b0078da05cc37fmr9268186ejc.159.1666240715492; Wed, 19
 Oct 2022 21:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com> <1666137032-28192-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666137032-28192-2-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 20 Oct 2022 12:38:22 +0800
Message-ID: <CACGkMEv_fKZa9qN+ytnViCdvcR4Cbr8KyT71UnWzWjrtsFMyBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] vdpa: save vdpa_dev_set_config in struct vdpa_device
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
> In order to allow live migration orchestration software to export the
> initial set of vdpa attributes with which the device was created, it
> will be useful if the vdpa tool can report the config on demand with
> simple query. This will ease the orchestration software implementation
> so that it doesn't have to keep track of vdpa config change, or have
> to persist vdpa attributes across failure and recovery, in fear of
> being killed due to accidental software error.
>
> This commit attempts to make struct vdpa_device contain the struct
> vdpa_dev_set_config, where all config attributes upon vdpa creation
> are carried over. Which will be used in subsequent commits.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  include/linux/vdpa.h | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4..f1838f5 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -58,6 +58,16 @@ struct vdpa_vq_state {
>         };
>  };
>
> +struct vdpa_dev_set_config {
> +       u64 device_features;
> +       struct {
> +               u8 mac[ETH_ALEN];
> +               u16 mtu;
> +               u16 max_vq_pairs;
> +       } net;

Not for this patch but I think there should be a union container for
this structure to make it usable for other types of devices.

> +       u64 mask;
> +};
> +
>  struct vdpa_mgmt_dev;
>
>  /**
> @@ -77,6 +87,8 @@ struct vdpa_vq_state {
>   * @nvqs: maximum number of supported virtqueues
>   * @mdev: management device pointer; caller must setup when registering device as part
>   *       of dev_add() mgmtdev ops callback before invoking _vdpa_register_device().
> + * @vdev_cfg: initial device config on vdpa creation; useful when instantiate with
> + *            the exact same config is needed.

Not a native speaker, but I guess it should be better named as "init_cfg"?

Thanks

>   */
>  struct vdpa_device {
>         struct device dev;
> @@ -91,6 +103,7 @@ struct vdpa_device {
>         struct vdpa_mgmt_dev *mdev;
>         unsigned int ngroups;
>         unsigned int nas;
> +       struct vdpa_dev_set_config vdev_cfg;
>  };
>
>  /**
> @@ -103,16 +116,6 @@ struct vdpa_iova_range {
>         u64 last;
>  };
>
> -struct vdpa_dev_set_config {
> -       u64 device_features;
> -       struct {
> -               u8 mac[ETH_ALEN];
> -               u16 mtu;
> -               u16 max_vq_pairs;
> -       } net;
> -       u64 mask;
> -};
> -
>  /**
>   * Corresponding file area for device memory mapping
>   * @file: vma->vm_file for the mapping
> --
> 1.8.3.1
>

