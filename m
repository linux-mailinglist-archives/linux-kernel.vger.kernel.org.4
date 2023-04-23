Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF26EBFEB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjDWOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjDWOMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:12:12 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0FE127
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=t2oXYPnyQYeafj80rDPPBk4DJ8Bih7Zw8inrjzwVK2k=; b=aP6aQ5wQasUVq+wLWIjGodQt00
        LxejcRVm0NGApRky08NWdEeUpFtwqFGXZfG1nFO+TauDItvUKPJRf4yCfAHbqZI8qYIEhweQNuAZs
        e2PLcbfp7TVVKU3ZcyHGOl72JvMeTc5Qm5FPNTzGdGWbDtWZ8XSr2FqwIykOJrbQz2CaR9WsQma54
        5DUODHpMMNwr+CNxJPFDVcIAq0sWsEWcq2cASJvjU51Dt697lL0odeA0v97oRsyGj3YvynKp/EeG8
        3CGyaECE2hrwsRGd1wZtCOcoA67uI+hnGrVSX2jH5VuebhzdRABy7cjpsiXFDDSU//wlF63/I3guE
        WxIN7RFQ==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaRe-00ANVs-Kv; Sun, 23 Apr 2023 16:12:02 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        Melissa Wen <mwen@igalia.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/40] drm/amd/display: introduce Steam Deck color features to AMD display driver
Date:   Sun, 23 Apr 2023 13:10:15 -0100
Message-Id: <20230423141051.702990-4-mwen@igalia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423141051.702990-1-mwen@igalia.com>
References: <20230423141051.702990-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are enabling a large set of color calibration features to enhance KMS
color mgmt but these properties are specific of AMD display HW, and
cannot be provided by other vendors. Therefore, set a config option to
enable AMD driver-private properties used on Steam Deck color mgmt
pipeline.

Co-developed-by: Joshua Ashton <joshua@froggi.es>
Signed-off-by: Joshua Ashton <joshua@froggi.es>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 06b438217c61..c45a8deb1098 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -53,5 +53,11 @@ config DRM_AMD_SECURE_DISPLAY
             of crc of specific region via debugfs.
             Cooperate with specific DMCU FW.
 
+config STEAM_DECK
+	bool "Enable color calibration features for Steam Deck"
+	depends on DRM_AMD_DC
+	help
+	  Choose this option if you want to use AMDGPU features for broader
+	  color management support on Steam Deck.
 
 endmenu
-- 
2.39.2

