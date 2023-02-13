Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E8D6945AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBMMUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjBMMUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:20:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1B84C33
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676290758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDnt5PK/UegV16aqc8u4iwm5wDCJSMDwfzgLnt/OavA=;
        b=eB+TtQJP/Gj1SFodBPYTNnghKkM6e4lztc48qyktkfKmaS0q0/zdf76xFp7bJ9+yOp0Foi
        BK1nhf2EB2LdTPbRchwmpPzMPyjrFyVPK29unJRwT+k6yIlX+pfOtNIP9xVJMjJpEeFzUa
        GICJY8ylGPrmxdNgeD7gtadX0vHzdJY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-gt55VD69MI6e6Zc4ZUsxjw-1; Mon, 13 Feb 2023 07:19:16 -0500
X-MC-Unique: gt55VD69MI6e6Zc4ZUsxjw-1
Received: by mail-wr1-f70.google.com with SMTP id c14-20020a5d528e000000b002c3f54b828bso2369122wrv.21
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDnt5PK/UegV16aqc8u4iwm5wDCJSMDwfzgLnt/OavA=;
        b=1SwkHmfJ/jMF4QPG6b0+Cw1zqqb+iAufxmB0A4RYMjShkzLtXCCIZEvFNXQrlpf9k4
         SPE/Wqp8KCm4RQ+xdTodHKOvqWzEfEptwagb0/66kYNYiDEZhzlrJBNdj/e1n6Nfqfwp
         IWB4bQybC6DI3fwrBHBbqqdtKCuDsWK8cIE3Lcg0gmNd9PPJKb7Fsmwyi5Uh13C/LQrR
         KkefJVeiooUXyiZrV9mj6qzOaCbgGVej/0aaNyhxTJFV61/VT2eBZvat30pGNbfakkMc
         nJN3NT+ATTgR91CfaHZm0dE/Pe3t2UXZn03xrAcJ1l5QLdtG3ofbC4E1FB27X+fab9jy
         Eu2Q==
X-Gm-Message-State: AO0yUKVctw25xKz9MOCpgKaW0llZ28opSE6ng7hkOOWjxvuVAMttop0f
        fP0/lNhEiZZmZGMBvRJhy+R7mGMwYjx4fGvw0HrSxRKu+QepeMNPPCLKA4izVMpqTCCNlcwb1xP
        wADys7kMx13S7NwaFZ9hjToi1
X-Received: by 2002:a5d:5588:0:b0:2c5:6046:9244 with SMTP id i8-20020a5d5588000000b002c560469244mr513119wrv.53.1676290755868;
        Mon, 13 Feb 2023 04:19:15 -0800 (PST)
X-Google-Smtp-Source: AK7set+xU34cCOOirxqXp6rIcvtao8qZMReQ7svnyFJcAZ1hW0XVm6jaz4gWG87NqrJrnIeiNihewA==
X-Received: by 2002:a5d:5588:0:b0:2c5:6046:9244 with SMTP id i8-20020a5d5588000000b002c560469244mr513107wrv.53.1676290755666;
        Mon, 13 Feb 2023 04:19:15 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id q1-20020a05600000c100b002c54d8b89efsm6389678wrx.26.2023.02.13.04.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:19:15 -0800 (PST)
Date:   Mon, 13 Feb 2023 07:19:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, si-wei.liu@oracle.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vdpa/mlx5: Initialize CVQ iotlb spinlock
Message-ID: <20230213071855-mutt-send-email-mst@kernel.org>
References: <20230206122016.1149373-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206122016.1149373-1-elic@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 02:20:16PM +0200, Eli Cohen wrote:
> Initialize itolb spinlock.
> 
> Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

threading was broken here but whatevs.

> ---
>  drivers/vdpa/mlx5/core/resources.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> index 45ad41287a31..d5a59c9035fb 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -233,6 +233,7 @@ static int init_ctrl_vq(struct mlx5_vdpa_dev *mvdev)
>  	if (!mvdev->cvq.iotlb)
>  		return -ENOMEM;
>  
> +	spin_lock_init(&mvdev->cvq.iommu_lock);
>  	vringh_set_iotlb(&mvdev->cvq.vring, mvdev->cvq.iotlb, &mvdev->cvq.iommu_lock);
>  
>  	return 0;
> -- 
> 2.38.1

