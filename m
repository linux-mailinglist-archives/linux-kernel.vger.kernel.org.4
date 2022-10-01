Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70905F1D04
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJAO61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJAO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67C59AFE1
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664636295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1fIiBbsxPsWgr2hCdbsOLxx9Ccx02LRCRvLVngQsXXs=;
        b=boUNGgMRmdAXzxb+pMVxW4jPrldgD+R8oB6Q0GdgRbklEGxTyr9UfLFQFYVeHknVIjVn7R
        w73OTZ50rJL3EZYESCSAsxLIFznkjPrtXkGw83/nTFPRYpfHHvPKYlvIvRaq5M3LUB/dBG
        MDpKVtyfrUFwKr99Q1o9JwGKCKXQTE8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-518-VhHuRwvJMcOkA_KB4rQtfQ-1; Sat, 01 Oct 2022 10:58:09 -0400
X-MC-Unique: VhHuRwvJMcOkA_KB4rQtfQ-1
Received: by mail-ed1-f72.google.com with SMTP id f10-20020a0564021e8a00b00451be6582d5so5646694edf.15
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1fIiBbsxPsWgr2hCdbsOLxx9Ccx02LRCRvLVngQsXXs=;
        b=hwX4binnyjx/WOjNoT6r6U5Ls7y7BuinR9Npe5VjQUWSyOoBMHLLgeVibzPfgSNznX
         yddKYfGnnU0xbXwpF9RwT/HUwtI2AC3D9WlBeAGV/X7VE+3TkzVzLgDSD4NaYhaRHEtG
         8kYkvFOEzwdX8IPLryRAsgUDRg5ILaVvnhu8VRqIYwgtgW6BX5W9/DdaNDW+UE0AQzsC
         QClAHgz+KGw5A8qY0a8j41ogRAArmg1wbGvN9Khe5XQNHzROZXWTPqd2vwfwUz1SmJgF
         E4jW8sJtwcQIDfENhJXcCUQ/611s+WokX5tYxFo8s9iI0abUiF35ouAQ8yLA1afqRyux
         ZjSA==
X-Gm-Message-State: ACrzQf3nog+JMvAk4I0WSQHq8N9MfKqAwfG6sSNGjslgxQB6ew9wmuTc
        bop9uVt+Ed6yVpR8+EArwfHaL/b8eP26XsZbNYrHE9cA+62QDyL8QFx9CJB6GFti/YyBwOk5J40
        XuIuyeNzFDptBMwFEm2yDdp4m
X-Received: by 2002:a17:907:3f8c:b0:787:a14d:65a7 with SMTP id hr12-20020a1709073f8c00b00787a14d65a7mr10071933ejc.108.1664636287687;
        Sat, 01 Oct 2022 07:58:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6+8h0mVBCtRrOQLSmCUm7nhEj9yy+U9P5gKV6lpVmbRMHEq6q58DmFjmVSDYqzAjJYqtJRWg==
X-Received: by 2002:a17:907:3f8c:b0:787:a14d:65a7 with SMTP id hr12-20020a1709073f8c00b00787a14d65a7mr10071921ejc.108.1664636287474;
        Sat, 01 Oct 2022 07:58:07 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906041000b0078197a9421csm2797869eja.85.2022.10.01.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:58:07 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 0/9] drm/fsl-dcu: use drm managed resources
Date:   Sat,  1 Oct 2022 16:57:53 +0200
Message-Id: <20221001145802.515916-1-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series converts the driver to use drm managed resources to prevent
potential use-after-free issues on driver unbind/rebind and to get rid of the
usage of deprecated APIs.

Changes in v2:
  - While protecting critical sections with drm_dev_{enter,exit} I forgot to
    handle alternate return paths within the read-side critical sections, hence
    fix them.
  - Add a patch to remove explicit calls to drm_mode_config_cleanup() and switch
    to drmm_mode_config_init() explicitly.

Danilo Krummrich (9):
  drm/fsl-dcu: use drmm_* to allocate driver structures
  drm/fsl-dcu: replace drm->dev_private with drm_to_fsl_dcu_drm_dev()
  drm/fsl-dcu: crtc: use drmm_crtc_init_with_planes()
  drm/fsl-dcu: plane: use drm managed resources
  drm/fsl-dcu: use drm_dev_unplug()
  drm/fsl-dcu: plane: protect device resources after removal
  drm/fsl-dcu: crtc: protect device resources after removal
  drm/fsl-dcu: remove trailing return statements
  drm/fsl-dcu: remove calls to drm_mode_config_cleanup()

 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c  | 64 ++++++++++++++++-----
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c   | 47 ++++++---------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h   |  4 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c   | 20 ++++---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c | 58 ++++++++++---------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c   |  8 +--
 6 files changed, 116 insertions(+), 85 deletions(-)


base-commit: 08fb97de03aa2205c6791301bd83a095abc1949c
-- 
2.37.3

