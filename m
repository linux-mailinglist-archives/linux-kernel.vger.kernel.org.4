Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0F65F1DB4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJAQj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJAQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC10A11A15
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664642392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kevHGqHRgDKM3mYrZtA/oomTniNa4wxI28bq+wUQvvo=;
        b=V8NlbvtUmYMSvtS9AqGutmNKCu+VS+3ByJZBFesTMPhfLTs2zK8dPS4gfM1h3kkCX4bVcA
        IrTwmR2Rqhb/wnW3ay90ktk1FXR48kGgpy+NSg67aaUdItVmWT9JQjUv77D6UvZPqtNoEx
        yOCZHio9lZIH+iPRQFSn59Va3CjpTHA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-454-WHz0WDn2PZmgACg9R7DE_A-1; Sat, 01 Oct 2022 12:39:50 -0400
X-MC-Unique: WHz0WDn2PZmgACg9R7DE_A-1
Received: by mail-ed1-f72.google.com with SMTP id t13-20020a056402524d00b00452c6289448so5778294edd.17
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kevHGqHRgDKM3mYrZtA/oomTniNa4wxI28bq+wUQvvo=;
        b=3Kyy4g5Hjyp38kNK3ISY57lmZAlmy925kA7i743HNOUgGp+XG3wOG1yYuHF56bEELM
         tWaIXE7R7dYNyz3RG+3ezPTh2JiHH0z5FTED95w4JQO5MxDOCfe3ruVL+SSpRKj2mtjv
         pLGKKFoVH7hZ4xJLTeoFkwxt9/cznViGKf328Xdb50stdv5DZbjLf4BN7NYAR6F0Zocs
         V4+3XaV3NC+ZjptY5FpxfcdYWtImpjbDTd57ZHaoY6CXM1LtKcncybt/TAv8aIqzs99l
         57uhzCHy+nD007F1BO5SfXBd/K8gJoh5WNi4h6r7YhY2OjcXibKjlaTe8vQ0UJ0rX792
         xYTA==
X-Gm-Message-State: ACrzQf1kzW2deIOi4th5OwRY2k7ptAJ7U1u1yhuj2rm85C53U9a2TvIn
        aCOjEtSF1U0oLHMo1sUGNcyfXRMuAPmEMwkOtMxY1iEnbnpsdUdmg6TM6OkGovmxWX1ZhcwF3IZ
        LvkQtNolCWABdhBciPV6Lk6ea
X-Received: by 2002:a17:906:1350:b0:77f:76a7:a0f with SMTP id x16-20020a170906135000b0077f76a70a0fmr10017960ejb.503.1664642389699;
        Sat, 01 Oct 2022 09:39:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM54VV9uAb9qLqq3EX6B97VOEHTAE/Z26jvUB/CY4X2lB3nCbs30lRthPV6kqXyOMt5c7RlLzA==
X-Received: by 2002:a17:906:1350:b0:77f:76a7:a0f with SMTP id x16-20020a170906135000b0077f76a70a0fmr10017951ejb.503.1664642389485;
        Sat, 01 Oct 2022 09:39:49 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id n15-20020a056402514f00b00458b41d9460sm1554870edd.92.2022.10.01.09.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 09:39:49 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 0/9] drm/arm/malidp: use drm managed resources
Date:   Sat,  1 Oct 2022 18:39:37 +0200
Message-Id: <20221001163946.534067-1-dakr@redhat.com>
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
  drm/arm/malidp: use drmm_* to allocate driver structures
  drm/arm/malidp: replace drm->dev_private with drm_to_malidp()
  drm/arm/malidp: crtc: use drmm_crtc_init_with_planes()
  drm/arm/malidp: plane: use drm managed resources
  drm/arm/malidp: use drm_dev_unplug()
  drm/arm/malidp: plane: protect device resources after removal
  drm/arm/malidp: crtc: protect device resources after removal
  drm/arm/malidp: drv: protect device resources after removal
  drm/arm/malidp: remove calls to drm_mode_config_cleanup()

 drivers/gpu/drm/arm/malidp_crtc.c   | 68 +++++++++++++++++++------
 drivers/gpu/drm/arm/malidp_drv.c    | 78 ++++++++++++-----------------
 drivers/gpu/drm/arm/malidp_drv.h    |  2 +
 drivers/gpu/drm/arm/malidp_hw.c     | 10 ++--
 drivers/gpu/drm/arm/malidp_mw.c     |  6 +--
 drivers/gpu/drm/arm/malidp_planes.c | 45 ++++++++---------
 6 files changed, 117 insertions(+), 92 deletions(-)


base-commit: 08fb97de03aa2205c6791301bd83a095abc1949c
-- 
2.37.3

