Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B699567F7CD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 13:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjA1MY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 07:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjA1MY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 07:24:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C241CACB
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674908649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=03GFZKsTOOOpaDJp/S3NzI8t/p2gCtQxJMJc4T/9yBg=;
        b=MEDAkj/d07bAHG5tGDSh9Xj6srnUq5YDXKbtDenX1P13k9nQRXDiPflVeOJQSFee5rTVD6
        dPkgE53TX8aC5aBS3l3Y/GPIyc0iCAIp2acxDOwzT6MpKjinI1OdUmHo3Z+rR7AKzRQ0TV
        FDWlzuLNgKeorX/Xr83t5bOtf9TreF4=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-404-2E3GrnyEP2i-PYIB-25DEw-1; Sat, 28 Jan 2023 07:24:08 -0500
X-MC-Unique: 2E3GrnyEP2i-PYIB-25DEw-1
Received: by mail-ua1-f71.google.com with SMTP id c30-20020ab04861000000b00419afefbe3eso2826625uad.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03GFZKsTOOOpaDJp/S3NzI8t/p2gCtQxJMJc4T/9yBg=;
        b=dGptodqo8InUQzgK8cnyoCu0phJAhRAAjWJzGkr1sqyJBUxxwViy3T8pt+uRTa4ZgS
         9pPqMczK/uaj8vZ4s2SdxJr/hcRsAEr6F7JtI7/mYOePR1KHBIkjiKJV9o0pXOQimE/5
         jwW7DJbRlTUZ/KzVsNuHRrOt8AxSgiReCjYyul+HBViUxq98ZucjhdH1/MDN3aczLN87
         otWMURlymgT+vEeQhyXuW1Hie3cvt3w1MJiTMwzofzCkNIc2ntjRWABTQtCEpZgBkKlN
         IOw8MIaWrtUo9HSkx54wRcMrpt6tb0ef5Kj84VOtTc5EijbfQ8XECRjsa4y/fbfCGT0v
         BArw==
X-Gm-Message-State: AFqh2kpRea4rG9aBlnTrYtSmKmcK5z33DBxjdaf5Pmo5PUGk+rjVdAN7
        p3cLDmOg4o8Pg8U1104xP2qkvdEQhWgmeCEHZvyBBHGbeo5i5Nnjv4jVvH/UqrCXScaiYtwjUJ6
        nOPBSwJkj9QJbGbBpkEMZz0y4XK3wLXRT1AHiyeqO
X-Received: by 2002:a67:ea04:0:b0:3d3:ec78:1d72 with SMTP id g4-20020a67ea04000000b003d3ec781d72mr6956103vso.13.1674908647625;
        Sat, 28 Jan 2023 04:24:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXujUr3nmTvR4IYft+VhWLaB9CaLr0rUquJiWtbPKQVgUOJtr2ccTZPeu3VmmCd7OwP4b9ukbqxY7/EVlW27Z14=
X-Received: by 2002:a67:ea04:0:b0:3d3:ec78:1d72 with SMTP id
 g4-20020a67ea04000000b003d3ec781d72mr6956096vso.13.1674908647381; Sat, 28 Jan
 2023 04:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20230128113532.94651-1-sven@svenpeter.dev>
In-Reply-To: <20230128113532.94651-1-sven@svenpeter.dev>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Sat, 28 Jan 2023 12:23:51 +0000
Message-ID: <CAOgh=Fw5FXPKde9PtTRRVeJ9eos8wqt72F_TLe_2XjWpKmCZ-A@mail.gmail.com>
Subject: Re: [PATCH] iommu/dart: Fix apple_dart_device_group for PCI groups
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2023 at 11:43, Sven Peter <sven@svenpeter.dev> wrote:
>
> pci_device_group() can return an already existing IOMMU group if the PCI
> device's pagetables have to be shared with another one due to bus
> toplogy, isolation features and/or DMA alias quirks.
> apple_dart_device_group() however assumes that the group has just been
> created and overwrites its iommudata which will eventually lead to
> apple_dart_release_group leaving stale entries in sid2group.
> Fix that by merging the iommudata if the returned group already exists.
>
> Fixes: f0b636804c7c ("iommu/dart: Clear sid2group entry when a group is freed")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

>  drivers/iommu/apple-dart.c | 51 ++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 7 deletions(-)
>
> This won't apply cleanly to iommu/fixes as it's based on the t8110 DART
> changes since the USB4/Thunderbolt DART itself also depends on those.
> That's not a big deal though since it's not possible to run into this
> bug without complex PCI bus topologies which can only be created using
> USB4/Thunderbolt on these SoCs and there's no support for that upstream
> yet.
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index a1304ba3639b..02f7a1740b14 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -840,6 +840,29 @@ static void apple_dart_release_group(void *iommu_data)
>         mutex_unlock(&apple_dart_groups_lock);
>  }
>
> +static int apple_dart_merge_master_cfg(struct apple_dart_master_cfg *dst,
> +                                      struct apple_dart_master_cfg *src)
> +{
> +       /*
> +        * We know that this function is only called for groups returned from
> +        * pci_device_group and that all Apple Silicon platforms never spread
> +        * PCIe devices from the same bus across multiple DARTs such that we can
> +        * just assume that both src and dst only have the same single DART.
> +        */
> +       if (src->stream_maps[1].dart)
> +               return -EINVAL;
> +       if (dst->stream_maps[1].dart)
> +               return -EINVAL;
> +       if (src->stream_maps[0].dart != dst->stream_maps[0].dart)
> +               return -EINVAL;
> +
> +       bitmap_or(dst->stream_maps[0].sidmap,
> +                 dst->stream_maps[0].sidmap,
> +                 src->stream_maps[0].sidmap,
> +                 dst->stream_maps[0].dart->num_streams);
> +       return 0;
> +}
> +
>  static struct iommu_group *apple_dart_device_group(struct device *dev)
>  {
>         int i, sid;
> @@ -881,14 +904,28 @@ static struct iommu_group *apple_dart_device_group(struct device *dev)
>         if (!group)
>                 goto out;
>
> -       group_master_cfg = kmemdup(cfg, sizeof(*group_master_cfg), GFP_KERNEL);
> -       if (!group_master_cfg) {
> -               iommu_group_put(group);
> -               goto out;
> -       }
> +       group_master_cfg = iommu_group_get_iommudata(group);
> +       if (group_master_cfg) {
> +               int ret;
>
> -       iommu_group_set_iommudata(group, group_master_cfg,
> -               apple_dart_release_group);
> +               ret = apple_dart_merge_master_cfg(group_master_cfg, cfg);
> +               if (ret) {
> +                       dev_err(dev, "Failed to merge DART IOMMU grups.\n");
> +                       iommu_group_put(group);
> +                       res = ERR_PTR(ret);
> +                       goto out;
> +               }
> +       } else {
> +               group_master_cfg = kmemdup(cfg, sizeof(*group_master_cfg),
> +                                          GFP_KERNEL);
> +               if (!group_master_cfg) {
> +                       iommu_group_put(group);
> +                       goto out;
> +               }
> +
> +               iommu_group_set_iommudata(group, group_master_cfg,
> +                       apple_dart_release_group);
> +       }
>
>         for_each_stream_map(i, cfg, stream_map)
>                 for_each_set_bit(sid, stream_map->sidmap, stream_map->dart->num_streams)
> --
> 2.25.1
>
>

