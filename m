Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C626A574E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjB1K6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjB1K6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:58:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ECC23102
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677581800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nB/5iQA/ERrIuMdNnPUytn6rExVcHdy0T6L0a8hSUc0=;
        b=X4NT6p77MLlq2ML2oK+3RfUitWP1JJL9amtA9S4Q2L8bXcr8n3EYtTjci9VXFAf7NvC82m
        k8/CTu8S8KstFaxxohiyhBNnxOz81JvWXZLCSX0L5vEoqPGUUs8q37+oUWEub9BBZHAmVm
        1dNhu8VBwNCCNdfSsHqqIFoDPSlS0f4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-vrgYYktLOYKwwvbK6FYGRw-1; Tue, 28 Feb 2023 05:56:39 -0500
X-MC-Unique: vrgYYktLOYKwwvbK6FYGRw-1
Received: by mail-wm1-f72.google.com with SMTP id n15-20020a05600c500f00b003dd07ce79c8so4118533wmr.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nB/5iQA/ERrIuMdNnPUytn6rExVcHdy0T6L0a8hSUc0=;
        b=b7vzuNYkCsN+JdWhxE/3Eb2u+2mo1ocXPmaC2XODe9McKJX18FRKFpmwZnMqItF/MZ
         3fCf5qRruD0cD7ku5kR70dGztWGUWA0aRHah30JKEiRpc/FseTMH2vU/xbE1Tc+DbB/r
         r9MKtTbWOTShD20qidjUuyglZGfgyh6a+9a/Dk73xqdOGEDyAdexDsPX8JcnDCevMwUf
         AE0+GwFAjXl6AzsU/yHwJOgZ28zbDDN7LADIFrGSFUFh6jgh/Zt9hF/xN4Ili5aYrFWW
         T/vEOsBoyj1BAxwq4yferUoEn8/Owk0EDDk8EY2i0DSIi+H+vntcoF8MCXFJ86KU/Gtc
         iHeg==
X-Gm-Message-State: AO0yUKVk79A+PoQ2Z4MrM71vWXudrN+bjkVn3UdWEbimp/iRuBCIv4iY
        RPmbuIeoIMbbSECheY1W/x1Z1ln2nrTEDmA+gFO6DDvGLQ8iZnrpSAzoxSPkXrnFBBwRklljo6S
        W2txeRf1GTJKVmYgGE5v/bMbm
X-Received: by 2002:a05:600c:4da4:b0:3ea:e554:7808 with SMTP id v36-20020a05600c4da400b003eae5547808mr1859445wmp.19.1677581794988;
        Tue, 28 Feb 2023 02:56:34 -0800 (PST)
X-Google-Smtp-Source: AK7set8t5/GwTKlOQXUiSLsp1gpZsKknVKhWt62LvswyPXDef6Z7111tgcUhPxqtQuKzFkIe1Yy0Lg==
X-Received: by 2002:a05:600c:4da4:b0:3ea:e554:7808 with SMTP id v36-20020a05600c4da400b003eae5547808mr1859429wmp.19.1677581794668;
        Tue, 28 Feb 2023 02:56:34 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c4f1400b003e20cf0408esm12986061wmq.40.2023.02.28.02.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 02:56:34 -0800 (PST)
Date:   Tue, 28 Feb 2023 11:56:28 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc:     mst@redhat.com, lulu@redhat.com,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        leiyang@redhat.com, Gautam Dawar <gdawar@xilinx.com>,
        Eli Cohen <elic@nvidia.com>, longpeng2@huawei.com,
        parav@nvidia.com, linux-kernel@vger.kernel.org,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        alvaro.karsz@solid-run.com, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2] vdpa_sim: set last_used_idx as last_avail_idx in
 vdpasim_queue_ready
Message-ID: <20230228105628.lwd4l2nw6isfjc7c@sgarzare-redhat>
References: <20230203142501.300125-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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
>Starting from an used_idx different than 0 is needed in use cases like
>virtual machine migration.  Not doing so and letting the caller set an
>avail idx different than 0 causes destination device to try to use old
>buffers that source driver already recover and are not available
>anymore.
>
>Since vdpa_sim does not support receive inflight descriptors as a
>destination of a migration, let's set both avail_idx and used_idx the
>same at vq start.  This is how vhost-user works in a
>VHOST_SET_VRING_BASE call.
>
>Although the simple fix is to set last_used_idx at vdpasim_set_vq_state,
>it would be reset at vdpasim_queue_ready.  The last_avail_idx case is
>fixed with commit a09f493c ("vdpa_sim: not reset state in
>vdpasim_queue_ready").  Since the only option is to make it equal to
>last_avail_idx, adding the only change needed here.
>
>This was discovered and tested live migrating the vdpa_sim_net device.
>
>Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>---
>Cherry-picked from patch 2/2 of the series [1]. Differences are:
>* Set the value of used_idx at vdpasim_queue_ready instead of fetching
>  from the guest vring like vhost-kernel.
>
>v2: Actually update last_used_idx only at vdpasim_queue_ready.
>
>Note that commit id present in the patch text is not in master but in
>git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.
>
>[1] https://lkml.org/lkml/2023/1/18/1041
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 6a0a65814626..79ac585e40b9 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -68,6 +68,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
> 			  (uintptr_t)vq->device_addr);
>
> 	vq->vring.last_avail_idx = last_avail_idx;
>+	vq->vring.last_used_idx = last_avail_idx;
> 	vq->vring.notify = vdpasim_vq_notify;
> }
>
>-- 2.31.1
>

If you need to resend, I'd add a comment in the code following the 
commit description.

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

