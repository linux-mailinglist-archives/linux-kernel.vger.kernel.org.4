Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498346891C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBCIP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBCIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B54365BE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675412074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RBSNvTzGGuF/AnMtphdz8gAhAXklpF3dQGWk2OV7ssc=;
        b=QP7oYfyO15EdW4bZHYjM7C7zrf60fgZ8Of75gzjSVNOflzB1fdQx6TtCMMXBH1nJnkLTDs
        dk+ILqggmpC6iJgo/UYNjtNL25h1pR/MGCzLpEZ8WxNXKc+il2dQruBJbtaG2pyQaDlFpV
        jh+CbfPzY8LA2JQvaq6npMh5xEAHnVo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-l3FW6DgbPKex1xa7QrdpRQ-1; Fri, 03 Feb 2023 03:14:33 -0500
X-MC-Unique: l3FW6DgbPKex1xa7QrdpRQ-1
Received: by mail-wm1-f70.google.com with SMTP id a20-20020a05600c349400b003dfecb98d38so165837wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBSNvTzGGuF/AnMtphdz8gAhAXklpF3dQGWk2OV7ssc=;
        b=Mpsm3aLt4AOpG7R627QlfzEDzhwqUGuZHd693A51aVglkTekKBcrWxxj9I3QtajdV6
         exmjnQL7jkyzs6FLkPMO7TGabgkeSEDPW9X+k5637OwWA9hQ8wlmtrZtGBPt5YyArATc
         oYJom75suQ7qPd9AkSA36eICeRVCoCYRtna9fF7FX6br9JNAlDkC73LDcZCZdq50/ZkC
         T911AcLzFiGU5MlyWAKk+/fc+y+oNcflo1b1+AVi9uw43K0VN+AJFWzrCZqWZymuS6U1
         92qxXqwg1kcsb1s9+pT16hHKH/G7Yhro+Y0pRzuWn719Fkj3NLutMMcWt8Wgs/2wW7k3
         HYWg==
X-Gm-Message-State: AO0yUKV18sVW2MRGZL0iuUI0zck1y5ue6vQP1d6Eom5BoebaJEVOZNEB
        n1F4su3Jx/DPA1TwSmEbSqm9ZaW0lG2JCCVgPGsTQcahEXJ1nYmQ406AWhJkELxCjdYq9H34vuw
        SzU4N6LZ1uMaj0gLZcRj2zXmr
X-Received: by 2002:a7b:ce11:0:b0:3dc:5302:ad9 with SMTP id m17-20020a7bce11000000b003dc53020ad9mr10452472wmc.27.1675412072421;
        Fri, 03 Feb 2023 00:14:32 -0800 (PST)
X-Google-Smtp-Source: AK7set9XLR1nt2yYDupc37z1u66lHeROwAvON4PoONn4AVsn75DKzjR5/jFjM4/qc6XCMKADet3/GQ==
X-Received: by 2002:a7b:ce11:0:b0:3dc:5302:ad9 with SMTP id m17-20020a7bce11000000b003dc53020ad9mr10452458wmc.27.1675412072183;
        Fri, 03 Feb 2023 00:14:32 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b003dfe549da4fsm1622359wmo.18.2023.02.03.00.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:14:31 -0800 (PST)
Date:   Fri, 3 Feb 2023 03:14:28 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] vdpa/mlx5: conditionally show MTU and STATUS in
 config space
Message-ID: <20230203030944-mutt-send-email-mst@kernel.org>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-7-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675207345-22328-7-git-send-email-si-wei.liu@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:22:24PM -0800, Si-Wei Liu wrote:
> The spec says:
>     mtu only exists if VIRTIO_NET_F_MTU is set
>     status only exists if VIRTIO_NET_F_STATUS is set
> 
> We should only show MTU and STATUS conditionally depending on
> the feature bits.
> 
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

so change the subject pls. it seems to say you are showing them
when you previously didn't, what's going on is something like:

	make MTU/status access conditional on feature bits

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3a6dbbc6..3d49eae 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3009,6 +3009,8 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>  	struct mlx5_vdpa_wq_ent *wqent;
>  
>  	if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
> +		if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_STATUS)))
> +			return NOTIFY_DONE;
>  		switch (eqe->sub_type) {
>  		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
>  		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
> @@ -3118,16 +3120,20 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  			goto err_alloc;
>  	}
>  
> -	err = query_mtu(mdev, &mtu);
> -	if (err)
> -		goto err_alloc;
> +	if (device_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
> +		err = query_mtu(mdev, &mtu);
> +		if (err)
> +			goto err_alloc;
>  
> -	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
> +		ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
> +	}
>  
> -	if (get_link_state(mvdev))
> -		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> -	else
> -		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> +	if (device_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
> +		if (get_link_state(mvdev))
> +			ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> +		else
> +			ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> +	}
>  
>  	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>  		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
> -- 
> 1.8.3.1

