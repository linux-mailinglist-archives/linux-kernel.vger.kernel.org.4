Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0E711011
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241592AbjEYPwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241871AbjEYPwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:52:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151FE1B4
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:52:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso2613063b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685029954; x=1687621954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B028AMgHgIkluZU0zuRGNx2AL7YCJmhMQ1JhCo1iuVI=;
        b=aNjbFnxBXnxByFTRM8dPMKH30Q/RAItyAVPrx2g23rtM7K5RWxj+jmeY6jXFFznBG8
         pZqa5Xzxd1RRC2cPJg3QGgjGxOjLvyujqb9O9tcPfbR593fGXpYl3mOh5ZMS70oGFBGx
         /kODJQcTOcwHEpMnyoc86lxFHBYsH/DD5AKNjW9UO2OsMqqQ2MWgTe01bSRUdSQhsbPO
         HwPjvWfdCJ2EOfQB47cDxADCc6pqDUoGCx5AXuAzBnna+gSSbl1TzveMRSHPcwsOMc9C
         wHzrhMVQZe5ZakVsucQjfNI9Kib8KYriF/UaUAqKAv8sC9wrGskiyYSbQvyoaQHzfDNc
         wOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685029954; x=1687621954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B028AMgHgIkluZU0zuRGNx2AL7YCJmhMQ1JhCo1iuVI=;
        b=WJHN4hzZTykcrgVZogZ/kKuz/VoqG7vkw28yW6N9NtUhiSNHw5F0UKY5YIUBSNGYtm
         gh1di4QAyTm+0uWwKF34W497NmYPVKpNEjGQqzVi4vkipjJG4G48q2Q06yL0g/WxYRUv
         6+OnKn7jp09onn7bg1E1R9e0YmM6XO5Oo5ujiyyj0I3cKYyqDIQLvObbLwkpBnCUH6pA
         jjxdcledSRcl0wjVWC52t6fTsaiQqg5eOQVaxRHNSFFqfHCKZTPLIK3dS1Bs6bOzbd6z
         jla2mprW6OJ84MOhaEUlnu5RMZDpSWii/oreAY5Bcc8ihFF1eq1UN97YebS26CnUfbtw
         jGYw==
X-Gm-Message-State: AC+VfDwWAyVOxPnTkB8Byqd5UhxyGCvVqTcHpLMTxRWK0BaSow46dy2w
        tQDIcCwancVYg7D6Xln6+v0=
X-Google-Smtp-Source: ACHHUZ7BKQyzScKNxtc9uAdkTbbH9pyva2m8zTt95GYPrMvfBGWVRwI16fpeyUdAfC7gPDigiNmWcw==
X-Received: by 2002:a05:6a00:10c4:b0:646:6cc3:4a52 with SMTP id d4-20020a056a0010c400b006466cc34a52mr8951192pfu.3.1685029954365;
        Thu, 25 May 2023 08:52:34 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id a17-20020a62bd11000000b0063b6bd2216dsm1335974pff.187.2023.05.25.08.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 08:52:33 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guchun Chen <guchun.chen@amd.com>,
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dave Airlie <airlied@redhat.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/amdgpu: Fix no-procfs build
Date:   Thu, 25 May 2023 08:52:24 -0700
Message-Id: <20230525155227.560094-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Fixes undefined symbol when PROC_FS is not enabled.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305251510.U0R2as7k-lkp@intel.com/
Fixes: 376c25f8ca47 ("drm/amdgpu: Switch to fdinfo helper")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1b46e7ac7cb0..c9a41c997c6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2795,21 +2795,23 @@ static const struct drm_driver amdgpu_kms_driver = {
 	    DRIVER_SYNCOBJ_TIMELINE,
 	.open = amdgpu_driver_open_kms,
 	.postclose = amdgpu_driver_postclose_kms,
 	.lastclose = amdgpu_driver_lastclose_kms,
 	.ioctls = amdgpu_ioctls_kms,
 	.num_ioctls = ARRAY_SIZE(amdgpu_ioctls_kms),
 	.dumb_create = amdgpu_mode_dumb_create,
 	.dumb_map_offset = amdgpu_mode_dumb_mmap,
 	.fops = &amdgpu_driver_kms_fops,
 	.release = &amdgpu_driver_release_kms,
+#ifdef CONFIG_PROC_FS
 	.show_fdinfo = amdgpu_show_fdinfo,
+#endif
 
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_import = amdgpu_gem_prime_import,
 	.gem_prime_mmap = drm_gem_prime_mmap,
 
 	.name = DRIVER_NAME,
 	.desc = DRIVER_DESC,
 	.date = DRIVER_DATE,
 	.major = KMS_DRIVER_MAJOR,
-- 
2.40.1

