Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A426917C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjBJEw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjBJEv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:51:56 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E91A77145;
        Thu,  9 Feb 2023 20:51:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u9so5299679plr.9;
        Thu, 09 Feb 2023 20:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p6GNpoWLwqRjkpemdg8r3B7YOn9VfnVEzWKh2GHgSQ=;
        b=mEtjIioleyGxYaWuQJaM9p/AxjJefiyXu8LvsMl3AaQryOfcQO+xfqyhuhj365eu1a
         VUd0vp9Y82wY4p5q7ciGrkQb3Q0pe2zuRNz7mpYuIUfypr4gKRJiSwcVFEEp3ROamt7m
         f2o0mcQ3EgkUlGtesmnyMPr6HrhJJA2Ruprd1ynnLyufZgZtgemKhsi3eDuODbrrNhHB
         mA/8oAfhdOG9+uUcSsPvyLanaDiqNIXatrwJlPNq1j9BVApCRbxk9iwtk5wWoRGELver
         8DpVkbsJHDyhJi8Zb+iXnkLj1W5w3xGyD/F6OSgWf+nDQkwi/NcMbz19PXiTc5stxZbr
         dchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/p6GNpoWLwqRjkpemdg8r3B7YOn9VfnVEzWKh2GHgSQ=;
        b=Te+QXIZLCwDQ8Cjsy/Yzi+1iRunLX9DmVgQXINzGqaK141irQHvDZr1rgScOHdKlMo
         WzIfWPanQu7C7NYlUNw6iS80ilpsOXPzojJzFDzvXXmERNSD4+/lNnKec/j/VtaF3oNW
         hFcn3sTpF0Xu9kCrlfxICv6FJxhF86JgU/udjV2GbUvqUwVorR7kvpcrTU4MTsDbOQIb
         SUHPzMh7vXB+nB5DvXUmYmP0UsTrxe3FaBz4pN7P2m/T5tHPa0E4I4ylf3UBwIKGUxy5
         3qg2FtExRp+tN2klACSidWd94bbtlyg2B4lF68YYznATvDTDeLxVcOowySim0PftM7Yu
         DbCw==
X-Gm-Message-State: AO0yUKWN92ZdK8GJ5sAQlGSbJ/NQ0UPe8cmhlQjzZ0Ngh3d0xvEAbdIz
        Opu7WvZoM86y2bFcLAtsQ1KiirvuHXUzdQ==
X-Google-Smtp-Source: AK7set8jSnGNm0tfiKRiMixhQZ/VY+kgsPUh9U4OTggadOBbCV4OPfkKzZmoBDm/AM7I3UA3B9lqiA==
X-Received: by 2002:a05:6a20:8f04:b0:bc:c07a:f6c with SMTP id b4-20020a056a208f0400b000bcc07a0f6cmr18379114pzk.16.1676004686432;
        Thu, 09 Feb 2023 20:51:26 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 20:51:26 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Evan Quan <evan.quan@amd.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [RFC PATCH 9/9] drm/amdgpu: register a vga_switcheroo client for all GPUs that are not thunderbolt attached
Date:   Fri, 10 Feb 2023 15:48:26 +1100
Message-Id: <20230210044826.9834-10-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210044826.9834-1-orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kerem Karabay <kekrby@gmail.com>

Commit 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and
vga_switcheroo") made amdgpu only register a vga_switcheroo client for
GPU's with PX, however AMD GPUs in dual gpu Apple Macbooks do need to
register, but don't have PX. Instead of AMD's PX, they use apple-gmux.

Revert to the old logic of registering for all non-thunderbolt gpus,
like radeon and nouveau.

Fixes: 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and vga_switcheroo")
Signed-off-by: Kerem Karabay <kekrby@gmail.com>
[Orlando Chamberlain <orlandoch.dev@gmail.com>: add commit description]
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f28a8c02f64..0bb553a61552 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3919,12 +3919,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
 
-	if (amdgpu_device_supports_px(ddev)) {
-		px = true;
-		vga_switcheroo_register_client(adev->pdev,
-					       &amdgpu_switcheroo_ops, px);
+	px = amdgpu_device_supports_px(ddev);
+
+	if (!pci_is_thunderbolt_attached(adev->pdev))
+		vga_switcheroo_register_client(adev->pdev, &amdgpu_switcheroo_ops, px);
+
+	if (px)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
-	}
 
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
@@ -4048,10 +4049,13 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 	kfree(adev->bios);
 	adev->bios = NULL;
-	if (amdgpu_device_supports_px(adev_to_drm(adev))) {
+
+	if (!pci_is_thunderbolt_attached(adev->pdev))
 		vga_switcheroo_unregister_client(adev->pdev);
+
+	if (amdgpu_device_supports_px(adev_to_drm(adev)))
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
-	}
+
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_unregister(adev->pdev);
 
-- 
2.39.1

