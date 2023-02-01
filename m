Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C79686B49
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjBAQMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjBAQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:12:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691CB757AF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675267893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCNzhgbsT7harPHDgUVLPlkp85+yy8d8grMTrA+fNpY=;
        b=Zw7t1braPsbDmJ0muvAd3QD2iUvht0tuZENIwALL3VBRo8/kvSuhRHFllqog9amnXWIy5+
        7o9t0d7vJkWggvNCr1bBG13ypakFXMQtkHbsgTvfAdX3EZQc8LcM4hemsSUiY5IjnY/26u
        UMEHKLSFaf56eueG6Zf6wXe1SZA3SY0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-424--U_lS44VMsq5wO2y6GPlPg-1; Wed, 01 Feb 2023 11:11:32 -0500
X-MC-Unique: -U_lS44VMsq5wO2y6GPlPg-1
Received: by mail-wr1-f70.google.com with SMTP id i11-20020adff30b000000b002bfddf29578so2084526wro.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 08:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCNzhgbsT7harPHDgUVLPlkp85+yy8d8grMTrA+fNpY=;
        b=0GCbSTWJlSdMvJYFPLVI/qU8lKUD/SMTB8i3c/bY103ttCeaJzWrD71zIeBNdOSClD
         jh2M2YZxul6UxFph0DIcGBuKkUPp5dJxheLAm2dPUgLTRWIhXRs3M0v8lP9qODibCBhg
         pUUwmF2Z8AqXMA3+fbX0exrkLPClILf/WRfRP9H9axZGgIfz2D4NHKvhB/aatu7AWLSn
         IGYV7uKREeyTd7NvblCkXN1jD7rUr5bBwK7Kfx4dQQnbl1/7oP8CTZRR38BK4JiNYcYN
         0MH0Z0eRu0BM5x7K/CY/wkLCthAQ8r5wEwwhynOfq4VwuJW46nTV0tTJMlibXMwJpoU1
         UjvA==
X-Gm-Message-State: AO0yUKVR09rnS52aXt5trnDmwvhZJzWVDbrkmFlW96lySOha6GbwzZ4n
        fvATg2nnPWOe883eThe0m06hn5EQiO3D1jXP2+Pe5tRq8j7OYHnMCMZVNNXQjq4CzhL+yARuAdv
        PROgeK1vG1uImcxHGJSzGon8n
X-Received: by 2002:a5d:4bce:0:b0:2c3:24f3:8b47 with SMTP id l14-20020a5d4bce000000b002c324f38b47mr2849929wrt.31.1675267890485;
        Wed, 01 Feb 2023 08:11:30 -0800 (PST)
X-Google-Smtp-Source: AK7set++NDgUi9uhBvV1xDGEBywenU3gTcP+mOhc1EqOEjLk4Za/27YTUIix/oEOJhT7SgB8iFK/lw==
X-Received: by 2002:a5d:4bce:0:b0:2c3:24f3:8b47 with SMTP id l14-20020a5d4bce000000b002c324f38b47mr2849912wrt.31.1675267890249;
        Wed, 01 Feb 2023 08:11:30 -0800 (PST)
Received: from redhat.com ([2.52.144.173])
        by smtp.gmail.com with ESMTPSA id e28-20020a5d595c000000b002bfd8ad20a0sm13733573wri.44.2023.02.01.08.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:11:29 -0800 (PST)
Date:   Wed, 1 Feb 2023 11:11:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     leiyang@redhat.com, Laurent Vivier <lvivier@redhat.com>,
        sgarzare@redhat.com, jasowang@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org, lulu@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, alvaro.karsz@solid-run.com
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at
 vringh_init_iotlb
Message-ID: <20230201111108-mutt-send-email-mst@kernel.org>
References: <20230118164359.1523760-1-eperezma@redhat.com>
 <20230118164359.1523760-3-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230118164359.1523760-3-eperezma@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 05:43:59PM +0100, Eugenio Pérez wrote:
> Starting from an used_idx different than 0 is needed in use cases like
> virtual machine migration.  Not doing so and letting the caller set an
> avail idx different than 0 causes destination device to try to use old
> buffers that source driver already recover and are not available
> anymore.
> 
> While callers like vdpa_sim set avail_idx directly it does not set
> used_idx.  Instead of let the caller do the assignment, fetch it from
> the guest at initialization like vhost-kernel do.
> 
> To perform the same at vring_kernel_init and vring_user_init is left for
> the future.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>


So I applied 1/2 and dropped 2/2 for now, right?

> ---
>  drivers/vhost/vringh.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 33eb941fcf15..0eed825197f2 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1301,6 +1301,17 @@ static inline int putused_iotlb(const struct vringh *vrh,
>  	return 0;
>  }
>  
> +/**
> + * vringh_update_used_idx - fetch used idx from driver's used split vring
> + * @vrh: The vring.
> + *
> + * Returns -errno or 0.
> + */
> +static inline int vringh_update_used_idx(struct vringh *vrh)
> +{
> +	return getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vring.used->idx);
> +}
> +
>  /**
>   * vringh_init_iotlb - initialize a vringh for a ring with IOTLB.
>   * @vrh: the vringh to initialize.
> @@ -1319,8 +1330,18 @@ int vringh_init_iotlb(struct vringh *vrh, u64 features,
>  		      struct vring_avail *avail,
>  		      struct vring_used *used)
>  {
> -	return vringh_init_kern(vrh, features, num, weak_barriers,
> -				desc, avail, used);
> +	int r = vringh_init_kern(vrh, features, num, weak_barriers, desc,
> +				 avail, used);
> +
> +	if (r != 0)
> +		return r;
> +
> +	/* Consider the ring not initialized */
> +	if ((void *)desc == used)
> +		return 0;
> +
> +	return vringh_update_used_idx(vrh);
> +
>  }
>  EXPORT_SYMBOL(vringh_init_iotlb);
>  
> -- 
> 2.31.1

