Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8E66AB722
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCFHdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCFHd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:33:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F841C593
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678087957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3OsqXLKNd2dBJmm8rJgq17jFb+t8dN7wBJ5vGDrT1jE=;
        b=HwwQ473svI0+imMWkmTG4d2au8suSI2ydO+rweG8bX+7lmK2fTD12TZzT8BSzaVqxhAaVb
        JdYSx8VPyVz+5LqH1dgE77V31zLpNr6zw3wgDL6qPQDWtkaGjPscmI5DYBut2W2z/fDua8
        IH+Se92cEr0mYjbgfEfPsEGxc/kL1O8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-kBwuc6YxM4-fE9t2ts8G2w-1; Mon, 06 Mar 2023 02:32:32 -0500
X-MC-Unique: kBwuc6YxM4-fE9t2ts8G2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B23E1C04322;
        Mon,  6 Mar 2023 07:32:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85BE540C83B6;
        Mon,  6 Mar 2023 07:32:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 32FAE1800613; Mon,  6 Mar 2023 08:32:30 +0100 (CET)
Date:   Mon, 6 Mar 2023 08:32:30 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Ryan Neph <ryanneph@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@redhat.com>, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v1] drm/virtio: Fix handling CONFIG_DRM_VIRTIO_GPU_KMS
 option
Message-ID: <20230306073230.cka4j44sdteqrpao@sirius.home.kraxel.org>
References: <20230304220510.964715-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304220510.964715-1-dmitry.osipenko@collabora.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -45,9 +45,11 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
>  	if (events_read & VIRTIO_GPU_EVENT_DISPLAY) {
>  		if (vgdev->has_edid)
>  			virtio_gpu_cmd_get_edids(vgdev);
> -		virtio_gpu_cmd_get_display_info(vgdev);
> -		virtio_gpu_notify(vgdev);
> -		drm_helper_hpd_irq_event(vgdev->ddev);
> +		if (vgdev->num_scanouts) {
> +			virtio_gpu_cmd_get_display_info(vgdev);
> +			virtio_gpu_notify(vgdev);
> +			drm_helper_hpd_irq_event(vgdev->ddev);
> +		}

I'd suggest to make the edid lines conditional too.

> -	if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) || !vgdev->num_scanouts) {
> +	if (!IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) || !vgdev->num_scanouts) {
>  		DRM_INFO("KMS disabled\n");
>  		vgdev->num_scanouts = 0;
>  		vgdev->has_edid = false;

Doesn't make a difference because has_edid gets set to false here,
but IMHO it is less confusing that way.

take care,
  Gerd

