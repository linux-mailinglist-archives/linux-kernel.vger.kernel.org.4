Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6529C660782
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjAFUAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjAFUAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:00:14 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11CD77AD7
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:00:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso4312954wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 12:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PgDgCbalZVja6CJHZ1jEM9FmYuFNNbjDnPRPmmyR01o=;
        b=d3pgh8KLydQizYACXbm3xigjagcrLhYky+dtaJxgm0ZmF86PT3UfRqOmBWhD5akBOj
         anijEtMC9Zt+I57QREM0oknwQNrlOn1OqqNLnEcTH+ABvN2W6XcglaDv7/ZIfYRZhYaT
         O0h/JzAVISV+NiOLXwjsNscvo+o3iXdPkm+z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgDgCbalZVja6CJHZ1jEM9FmYuFNNbjDnPRPmmyR01o=;
        b=b+MlWXwsLdItjmF1nsT8DEcRmQhC4EIvEwJcIQco0Y1TgkqQGufAOrN2ssMzIhLb6z
         kzDU2gZi4iULd+qvagWXodq+lumWOEGb7vIFkG2IPNI0bT57IbMH4Duq45y5uxR+2NIk
         W0zWoARwOusAzSwvYR47b3fmGYyDM99173SrDqrizsPou9AYC+TBPVifsU2JPv65SsI8
         wk/xApzgQ9bqLJ2ME132ZClabh8YGM6kQ355E420c6lp3ddxAleSz00stBVfs6+b8uhR
         Roso/BLFsufxbRpGHYB+hbRzEK3+7cMNjMvf6MY4vr3Tzr/uiPVFFUA4qJcoj647muIT
         KWnQ==
X-Gm-Message-State: AFqh2kpO+9u0ip02RyLWNjHt9vxz0oDGcm/PYpRqCYeXh9uY0h6O53kg
        9rxGWOkUCKr0dYi6Srt3+7kd/w==
X-Google-Smtp-Source: AMrXdXvmeln0PW9RNUr4xA4+Ywh45d/Cf6OvVymTMeVjSZk9Ccy4c622NhtXTByCJ+SQRDV9rCjt6Q==
X-Received: by 2002:a05:600c:6007:b0:3cf:4ec9:385d with SMTP id az7-20020a05600c600700b003cf4ec9385dmr39663654wmb.19.1673035212237;
        Fri, 06 Jan 2023 12:00:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id bg23-20020a05600c3c9700b003d1de805de5sm3315612wmb.16.2023.01.06.12.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:00:11 -0800 (PST)
Date:   Fri, 6 Jan 2023 21:00:08 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Melissa Wen <mwen@igalia.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, noralf@tronnes.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Emma Anholt <emma@anholt.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Tomi Valkeinen <tomba@kernel.org>
Subject: Re: [PATCH 9/9] drm/qxl: use new debugfs device-centered functions
Message-ID: <Y7h9yD+4cpEPttX9@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Melissa Wen <mwen@igalia.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, noralf@tronnes.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Emma Anholt <emma@anholt.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Tomi Valkeinen <tomba@kernel.org>
References: <20221226155029.244355-1-mcanal@igalia.com>
 <20221226155029.244355-10-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221226155029.244355-10-mcanal@igalia.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 12:50:29PM -0300, Maíra Canal wrote:
> Replace the use of drm_debugfs_create_files() with the new
> drm_debugfs_add_files() function, which center the debugfs files
> management on the drm_device instead of drm_minor. Moreover, remove the
> debugfs_init hook and add the debugfs files directly on qxl_pci_probe(),
> before drm_dev_register().
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>  drivers/gpu/drm/qxl/qxl_debugfs.c | 18 ++++++++----------
>  drivers/gpu/drm/qxl/qxl_drv.c     |  5 ++---
>  drivers/gpu/drm/qxl/qxl_drv.h     |  2 +-
>  3 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_debugfs.c b/drivers/gpu/drm/qxl/qxl_debugfs.c
> index bdfce1a8f006..fd18a7b193b3 100644
> --- a/drivers/gpu/drm/qxl/qxl_debugfs.c
> +++ b/drivers/gpu/drm/qxl/qxl_debugfs.c
> @@ -38,8 +38,8 @@
>  static int
>  qxl_debugfs_irq_received(struct seq_file *m, void *data)
>  {
> -	struct drm_info_node *node = (struct drm_info_node *) m->private;
> -	struct qxl_device *qdev = to_qxl(node->minor->dev);
> +	struct drm_debugfs_entry *entry = m->private;
> +	struct qxl_device *qdev = to_qxl(entry->dev);
>  
>  	seq_printf(m, "%d\n", atomic_read(&qdev->irq_received));
>  	seq_printf(m, "%d\n", atomic_read(&qdev->irq_received_display));
> @@ -52,8 +52,8 @@ qxl_debugfs_irq_received(struct seq_file *m, void *data)
>  static int
>  qxl_debugfs_buffers_info(struct seq_file *m, void *data)
>  {
> -	struct drm_info_node *node = (struct drm_info_node *) m->private;
> -	struct qxl_device *qdev = to_qxl(node->minor->dev);
> +	struct drm_debugfs_entry *entry = m->private;
> +	struct qxl_device *qdev = to_qxl(entry->dev);
>  	struct qxl_bo *bo;
>  
>  	list_for_each_entry(bo, &qdev->gem.objects, list) {
> @@ -76,21 +76,19 @@ qxl_debugfs_buffers_info(struct seq_file *m, void *data)
>  	return 0;
>  }
>  
> -static struct drm_info_list qxl_debugfs_list[] = {
> +static struct drm_debugfs_info qxl_debugfs_list[] = {
>  	{ "irq_received", qxl_debugfs_irq_received, 0, NULL },
>  	{ "qxl_buffers", qxl_debugfs_buffers_info, 0, NULL },
>  };
>  #define QXL_DEBUGFS_ENTRIES ARRAY_SIZE(qxl_debugfs_list)
>  #endif
>  
> -void
> -qxl_debugfs_init(struct drm_minor *minor)
> +void qxl_debugfs_init(struct drm_device *drm)
>  {
>  #if defined(CONFIG_DEBUG_FS)

Again since it's all in the same file I'd drop the #ifdef and use
__maybe_unused. Either way

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

You could do the same trick for omap drm too I guess, but since it's a bit
across files it's a bit more annoying (and you'd have one cross-file
function call left but *meh*). For the other patches without review yet:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'd wait another week (because holiday break) for any maintainer feedback
and then push.
-Daniel

> -	struct qxl_device *dev = to_qxl(minor->dev);
> +	struct qxl_device *dev = to_qxl(drm);
>  
> -	drm_debugfs_create_files(qxl_debugfs_list, QXL_DEBUGFS_ENTRIES,
> -				 minor->debugfs_root, minor);
> +	drm_debugfs_add_files(drm, qxl_debugfs_list, QXL_DEBUGFS_ENTRIES);
>  
>  	qxl_ttm_debugfs_init(dev);
>  #endif
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index a3b83f89e061..3ae2db78f671 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -116,6 +116,8 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (ret)
>  		goto unload;
>  
> +	qxl_debugfs_init(&qdev->ddev);
> +
>  	drm_kms_helper_poll_init(&qdev->ddev);
>  
>  	/* Complete initialization. */
> @@ -287,9 +289,6 @@ static struct drm_driver qxl_driver = {
>  
>  	.dumb_create = qxl_mode_dumb_create,
>  	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
> -#if defined(CONFIG_DEBUG_FS)
> -	.debugfs_init = qxl_debugfs_init,
> -#endif
>  	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>  	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>  	.gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
> index 0868d5d2a839..cb84a3bebcec 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.h
> +++ b/drivers/gpu/drm/qxl/qxl_drv.h
> @@ -397,7 +397,7 @@ int qxl_garbage_collect(struct qxl_device *qdev);
>  
>  /* debugfs */
>  
> -void qxl_debugfs_init(struct drm_minor *minor);
> +void qxl_debugfs_init(struct drm_device *drm);
>  void qxl_ttm_debugfs_init(struct qxl_device *qdev);
>  
>  /* qxl_prime.c */
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
