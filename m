Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDE0739E68
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjFVKUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjFVKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:20:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66681BE5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E6CA617B6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EF0C433C8;
        Thu, 22 Jun 2023 10:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687429242;
        bh=AWFPWNjgq8nDENgHhyxRM1ln3/MFL4dH5rZ97ud8+z4=;
        h=From:To:Cc:Subject:Date:From;
        b=lr5YgX/5QzEp2HSY7IaidtJuiAoPY0Sdmn1yD8o2RR7TCKFENJqN98bbcvWyw8QL9
         dfiQV0eAQMuoDCNzDowXK3NNXkywINA+rE7Seabeig6ooXd5hBLA3d7CNvGCjDQrYg
         P8+6MAVeTnpurC0pJf5E3yAVtcJgispoud0+yPICWVtfdoNgVZgXIlIaPErK+SMu1s
         UYsEXR1vvuBUfD/mGPhMoc8vu+ZaHMi3jZbIIEyJxEt5SN6DK6GFRO0nVZONaPXLIn
         Uz1UmlHVPC+fzNv/xT6h4PkELS+4KVMHuBbwNOQQL7fwk43+7yIKrreShY1PPuew8L
         3wrBu96nixZnw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Wenhui Sheng <Wenhui.Sheng@amd.com>,
        Guchun Chen <Guchun.Chen@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Tong Liu01 <Tong.Liu01@amd.com>,
        Yiqing Yao <yiqing.yao@amd.com>,
        ZhenGuo Yin <zhenguo.yin@amd.com>,
        Jonatas Esteves <jntesteves@gmail.com>,
        Kent Russell <kent.russell@amd.com>,
        Kun Liu <Kun.Liu2@amd.com>, Asad Kamal <asad.kamal@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix building without DEBUG_FS
Date:   Thu, 22 Jun 2023 12:20:26 +0200
Message-Id: <20230622102035.3552643-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The debugfs file is defined unconditionally, but the registration is hidden
in an #ifdef, which causes a warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c:110:37: error: unused variable 'amdgpu_rap_debugfs_ops' [-Werror,-Wunused-const-variable]
static const struct file_operations amdgpu_rap_debugfs_ops = {
                                    ^

in amdgpu_pm.c, the same thing happens with the clocks[] variable:

drivers/gpu/drm/amd/pm/amdgpu_pm.c:38:34: error: unused variable 'clocks' [-Werror,-Wunused-const-variable]
static const struct cg_flag_name clocks[] = {
                                 ^

Since debugfs_create_file() does nothing when debugfs is disabled, removing
the ifdefs makes the code more readable and also avoids both warnings.

Fixes: a4322e1881bed ("drm/amdgpu: add debugfs interface for RAP test")
Fixes: e098bc9612c2b ("drm/amd/pm: optimize the power related source code layout")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302200339.Whql7Emr-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c | 2 --
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
index 12010c988c8b5..123bcf5c2bb13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
@@ -116,7 +116,6 @@ static const struct file_operations amdgpu_rap_debugfs_ops = {
 
 void amdgpu_rap_debugfs_init(struct amdgpu_device *adev)
 {
-#if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 
 	if (!adev->psp.rap_context.context.initialized)
@@ -124,5 +123,4 @@ void amdgpu_rap_debugfs_init(struct amdgpu_device *adev)
 
 	debugfs_create_file("rap_test", S_IWUSR, minor->debugfs_root,
 				adev, &amdgpu_rap_debugfs_ops);
-#endif
 }
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index a57952b93e73f..ec39805b762e6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3565,8 +3565,6 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 /*
  * Debugfs info
  */
-#if defined(CONFIG_DEBUG_FS)
-
 static void amdgpu_debugfs_prints_cpu_info(struct seq_file *m,
 					   struct amdgpu_device *adev) {
 	uint16_t *p_val;
@@ -3768,11 +3766,8 @@ static const struct file_operations amdgpu_debugfs_pm_prv_buffer_fops = {
 	.llseek = default_llseek,
 };
 
-#endif
-
 void amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
 {
-#if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 	struct dentry *root = minor->debugfs_root;
 
@@ -3789,5 +3784,4 @@ void amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
 					 adev->pm.smu_prv_buffer_size);
 
 	amdgpu_dpm_stb_debug_fs_init(adev);
-#endif
 }
-- 
2.39.2

