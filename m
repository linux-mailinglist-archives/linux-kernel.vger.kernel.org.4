Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287D6654C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiLWG3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLWG3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:29:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5965F8D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671776903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d+WPSmc09NBkvcoLHciePhR5uOL76wqGBtt7DhnGavw=;
        b=i1sDHe3fV6snO0gsmgBrPBSHxw0XlNvj5nrqHYvOV3LVNNh66EoPiJ59Rles8uk1MEcEkJ
        B8yd6/JDQUsbMoKo1zCyYpoioP3XS0/HI4lru/XbSORBorXXUYYtrP//0daV9yOMIWm3YW
        lMSijW/yd4nMvh6bdbhnTuSv0/iHZmw=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-389-Wr-1KZNnOSuR653LhN9CMg-1; Fri, 23 Dec 2022 01:28:22 -0500
X-MC-Unique: Wr-1KZNnOSuR653LhN9CMg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1441866fa6cso2058379fac.22
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+WPSmc09NBkvcoLHciePhR5uOL76wqGBtt7DhnGavw=;
        b=7awbdr2jQ+DhaSf/bbpPnaQH67wuvFexgvbBpX9SHNmEq7wP2Q8VYPeYq00fT6FR1F
         cAV+aoDSfSbY9jCd46KZI+tHVfWGUfVIpFIAXX7nH7IHtmULuEAs3EH+hB8Q5iIHu+tK
         qxoIuygNF+47g4pS8Cez4TdTlQ9hnNNDzsg1TsUWdkMWHd24HgurNDchup0pMvt6LlTl
         CuBBeA2bqfJq8kO65zPXVAGkwVED5nbSFUNpYjekb6Ul7yf8yWnMLytAIUbxL+XAwmo6
         KHyjKLr3E9XwGiC9YrrBocC1X1g6OdL6A2KscOJrh0xBJoC+EydKtuxWrhaWcLvdn+kg
         dlnQ==
X-Gm-Message-State: AFqh2koYz03JX26w2Oj+4lwhuoZ4v55orBTlRyVGcFoqFl1f+dVFddVF
        FhIJV1pUu34wzhkbZLkl8xcjrKD7HSgOzAG0R4lk4tjYRaLSNJoFRUhSvdy4ahBL6ySe7MJyjqh
        XGdMoYhcau7+AY9tr6GK+5/l02XKwMIcE7L11CfTs
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id c3-20020a9d7843000000b006781eb43406mr520499otm.237.1671776901588;
        Thu, 22 Dec 2022 22:28:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvCyTF0iGCkFN/1nmqABJszPQHoPYz50tbJpkeRQsl43VUbwWnc16mtfHlwMFUc3WtPbLOU7JxUEqY7DULu4RE=
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr520497otm.237.1671776901377; Thu, 22 Dec
 2022 22:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20221222193214.55146-1-mst@redhat.com>
In-Reply-To: <20221222193214.55146-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 23 Dec 2022 14:28:10 +0800
Message-ID: <CACGkMEtayXtio4OVDdtWXM3v4giGncT9MCybiYbJoZAGmK=Ppw@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: mark all zone fields LE
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org
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

On Fri, Dec 23, 2022 at 3:32 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> zone is a virtio 1.x feature so all fields are LE,
> they are handled as such, but have mistakenly been labeled
> __virtioXX in the header.  This results in a bunch of sparse warnings.
>
> Use the __leXX tags to make sparse happy.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  include/uapi/linux/virtio_blk.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index f4d5ee7c6f30..ec3c3779406f 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -141,11 +141,11 @@ struct virtio_blk_config {
>
>         /* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
>         struct virtio_blk_zoned_characteristics {
> -               __virtio32 zone_sectors;
> -               __virtio32 max_open_zones;
> -               __virtio32 max_active_zones;
> -               __virtio32 max_append_sectors;
> -               __virtio32 write_granularity;
> +               __le32 zone_sectors;
> +               __le32 max_open_zones;
> +               __le32 max_active_zones;
> +               __le32 max_append_sectors;
> +               __le32 write_granularity;
>                 __u8 model;
>                 __u8 unused2[3];
>         } zoned;
> @@ -245,11 +245,11 @@ struct virtio_blk_outhdr {
>   */
>  struct virtio_blk_zone_descriptor {
>         /* Zone capacity */
> -       __virtio64 z_cap;
> +       __le64 z_cap;
>         /* The starting sector of the zone */
> -       __virtio64 z_start;
> +       __le64 z_start;
>         /* Zone write pointer position in sectors */
> -       __virtio64 z_wp;
> +       __le64 z_wp;
>         /* Zone type */
>         __u8 z_type;
>         /* Zone state */
> @@ -258,7 +258,7 @@ struct virtio_blk_zone_descriptor {
>  };
>
>  struct virtio_blk_zone_report {
> -       __virtio64 nr_zones;
> +       __le64 nr_zones;
>         __u8 reserved[56];
>         struct virtio_blk_zone_descriptor zones[];
>  };
> --
> MST
>

