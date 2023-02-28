Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699FB6A58E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjB1MN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjB1MN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:13:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE56DBFC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677586387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hoxu+nGD6T923oeRrMSsGpCNCuS7fv2W8hkqbtX7YfY=;
        b=VWHim2UlRqVAocekxzriYavtLDgVZNVks0GsEbclAxCszshdr6KT2v47VH+R+f41xA941c
        bqd+NDHkUPf4O111GYv7IS6VJ1UMMrY2VnVvVH8hpevGSp0bu6iozjYL1fj8BAkuEYJsvq
        /ptbMJLbQdxgcujv8kNAkyKb5UjjBXA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-lehrA2N7OjeEkhKSUvfARA-1; Tue, 28 Feb 2023 07:13:06 -0500
X-MC-Unique: lehrA2N7OjeEkhKSUvfARA-1
Received: by mail-wm1-f72.google.com with SMTP id k20-20020a05600c1c9400b003e2249bd2b4so3546550wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677586384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoxu+nGD6T923oeRrMSsGpCNCuS7fv2W8hkqbtX7YfY=;
        b=SNwIPsIy8dmDv4J2VfkH5sK1Abasw1T1Qb2GHVC3r+aW+sGfNqmDR/qFPasaW4ymUk
         +8HyRfxcYCVGXgz5qSMVs6nR60ihzveaEiGEVOSFr1TvhZ10NGLyhCSAhf62QYNm2D1H
         thwoanS+cCplusi9TNGny4vBN77Tx22MGj2Lf1p/4DwcHscxLUHBx3UEqcACWJQX6Wyo
         7qD1pUE5AGy4w6DuU6WGpmfEahWXiDBrSk6M8D/3iJ7lJaCxIU9ZRuZp/lCQan3eP/Fs
         AhDZKgd+dxFC5mvrvVhpASl+LvHxnQRrD+0tequ8GFmtnGTV0ylUL8UVolrui9ohPEU7
         zilA==
X-Gm-Message-State: AO0yUKXd5OeamrIaQyfRv9k4ob/Y3OBpLOe6XXbmsZbXjHfY2ToW0CYI
        8cI8NRFQx/AJNd6cek6oIDwqEo2FKLM5gfF1ePP0wDLbEb7ycQiTbbq2/xf/k6B5Ef+TY93Namp
        kN9/OoZLY6saJ8fLohQQgWGbf
X-Received: by 2002:a05:600c:b8c:b0:3e2:2057:b9d6 with SMTP id fl12-20020a05600c0b8c00b003e22057b9d6mr8897288wmb.20.1677586384804;
        Tue, 28 Feb 2023 04:13:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/2iShf6XFmQ2DdHxYHI4OxYv/tx+ud/3W68x8DevBdyxg8dtxcKgmSO73oehT+Nr0/8lZ/8g==
X-Received: by 2002:a05:600c:b8c:b0:3e2:2057:b9d6 with SMTP id fl12-20020a05600c0b8c00b003e22057b9d6mr8897272wmb.20.1677586384455;
        Tue, 28 Feb 2023 04:13:04 -0800 (PST)
Received: from redhat.com ([2.52.141.194])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003e0238d9101sm13869495wmb.31.2023.02.28.04.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 04:13:03 -0800 (PST)
Date:   Tue, 28 Feb 2023 07:13:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     lulu@redhat.com, virtualization@lists.linux-foundation.org,
        si-wei.liu@oracle.com, leiyang@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, Eli Cohen <elic@nvidia.com>,
        longpeng2@huawei.com, parav@nvidia.com,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        alvaro.karsz@solid-run.com, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2] vdpa_sim: set last_used_idx as last_avail_idx in
 vdpasim_queue_ready
Message-ID: <20230228071109-mutt-send-email-mst@kernel.org>
References: <20230203142501.300125-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230203142501.300125-1-eperezma@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 03:25:01PM +0100, Eugenio Pérez wrote:
> Starting from an used_idx different than 0 is needed in use cases like
> virtual machine migration.  Not doing so and letting the caller set an
> avail idx different than 0 causes destination device to try to use old
> buffers that source driver already recover and are not available
> anymore.
> 
> Since vdpa_sim does not support receive inflight descriptors as a
> destination of a migration, let's set both avail_idx and used_idx the
> same at vq start.  This is how vhost-user works in a
> VHOST_SET_VRING_BASE call.
> 
> Although the simple fix is to set last_used_idx at vdpasim_set_vq_state,
> it would be reset at vdpasim_queue_ready.  The last_avail_idx case is
> fixed with commit a09f493c ("vdpa_sim: not reset state in
> vdpasim_queue_ready").  Since the only option is to make it equal to
> last_avail_idx, adding the only change needed here.
> 
> This was discovered and tested live migrating the vdpa_sim_net device.
> 
> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> Cherry-picked from patch 2/2 of the series [1]. Differences are:
> * Set the value of used_idx at vdpasim_queue_ready instead of fetching
>   from the guest vring like vhost-kernel.
> 
> v2: Actually update last_used_idx only at vdpasim_queue_ready.
> 
> Note that commit id present in the patch text is not in master but in
> git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.
> 
> [1] https://lkml.org/lkml/2023/1/18/1041


Can you post with a fixed hash please?

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 6a0a65814626..79ac585e40b9 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -68,6 +68,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>  			  (uintptr_t)vq->device_addr);
>  
>  	vq->vring.last_avail_idx = last_avail_idx;
> +	vq->vring.last_used_idx = last_avail_idx;
>  	vq->vring.notify = vdpasim_vq_notify;
>  }
>  
> -- 
> 2.31.1

