Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F0065F48B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbjAETd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjAETde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:33:34 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C97A5FC2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1HKiKe9373ka0mN6FKm4s+rwzUKEimlYW6GYpQhj2R0=; b=BP1CBMV6B67FIuqRybXYKOA2B+
        ukIVpCrzPqF55wKxlPxuZVlPMtVL75I18T3ifxC4IVzFi8RB0jd+XwvBnLU9OQOGas67ACHz79RRd
        WEiLzTZWTiP82i9293zQ3NDHbNo2AQbWYvZ9doknOM2OutUvtqn9RHmCbIpO1tCBHhaSEwq7OP7pK
        LYYo+C/K+Jg80OTA675SJ2PjIYFaoPql2tZFETHAN8Xybq+cOJKoWuX8o/yhxqFGgx8o0t3dUvjMp
        bFFaf9yj+kjcg1GnPgR1KP9Hj2a2OeCdm9u3LAEJer6GZy5GYAb8H80gEg/ENEa73QjuVK/SkuqxK
        9fSdN8kg==;
Received: from [187.36.234.139] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pDVx4-000Kcs-UY; Thu, 05 Jan 2023 20:30:59 +0100
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Melissa Wen <mwen@igalia.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 2/2] drm/debugfs: add descriptions to struct parameters
Date:   Thu,  5 Jan 2023 16:30:39 -0300
Message-Id: <20230105193039.287677-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105193039.287677-1-mcanal@igalia.com>
References: <20230105193039.287677-1-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structs drm_debugfs_info and drm_debugfs_entry don't have
descriptions for their parameters, which is causing the following warnings:

include/drm/drm_debugfs.h:93: warning: Function parameter or member
'name' not described in 'drm_debugfs_info'
include/drm/drm_debugfs.h:93: warning: Function parameter or member
'show' not described in 'drm_debugfs_info'
include/drm/drm_debugfs.h:93: warning: Function parameter or member
'driver_features' not described in 'drm_debugfs_info'
include/drm/drm_debugfs.h:93: warning: Function parameter or member
'data' not described in 'drm_debugfs_info'
include/drm/drm_debugfs.h:105: warning: Function parameter or member
'dev' not described in 'drm_debugfs_entry'
include/drm/drm_debugfs.h:105: warning: Function parameter or member
'file' not described in 'drm_debugfs_entry'
include/drm/drm_debugfs.h:105: warning: Function parameter or member
'list' not described in 'drm_debugfs_entry'

Therefore, fix the warnings by adding descriptions to all struct
parameters.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 include/drm/drm_debugfs.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
index 53b7297260a5..7616f457ce70 100644
--- a/include/drm/drm_debugfs.h
+++ b/include/drm/drm_debugfs.h
@@ -86,9 +86,22 @@ struct drm_info_node {
  * core.
  */
 struct drm_debugfs_info {
+	/** @name: File name */
 	const char *name;
+
+	/**
+	 * @show:
+	 *
+	 * Show callback. &seq_file->private will be set to the &struct
+	 * drm_debugfs_entry corresponding to the instance of this info
+	 * on a given &struct drm_device.
+	 */
 	int (*show)(struct seq_file*, void*);
+
+	/** @driver_features: Required driver features for this entry. */
 	u32 driver_features;
+
+	/** @data: Driver-private data, should not be device-specific. */
 	void *data;
 };
 
@@ -99,8 +112,13 @@ struct drm_debugfs_info {
  * drm_debugfs_info on a &struct drm_device.
  */
 struct drm_debugfs_entry {
+	/** @dev: &struct drm_device for this node. */
 	struct drm_device *dev;
+
+	/** @file: Template for this node. */
 	struct drm_debugfs_info file;
+
+	/** @list: Linked list of all device nodes. */
 	struct list_head list;
 };
 
-- 
2.39.0

