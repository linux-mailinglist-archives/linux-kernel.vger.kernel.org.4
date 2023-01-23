Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5548D6787BD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjAWU1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjAWU1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:27:48 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFDF210F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7CaXIdoI8n3ZxHPPdx/samyORw/Wg8sXLQapZ/RBkNE=; b=fCiKDcxtbjDgmimIhRvRxngTgb
        85ecoNKuvlffUrBzca6OUqFTCOLG0GS7Y/xSl3W/9hbE+t0B2gyqmJSYiQuk2LBwWEegoZ3e1Beyv
        xgJQf92lfA0BDtJdh3VXEeAxhCTdb0SiB9pBHldjMxitNCo+e34ZQXEWuVcZ4CCgM4vOBcvQYSIhW
        biBOMXlXcpU/lrG4Mtc3zEEXRurpxjeAYqCxY5cs/Dp9scqHc3FsoQLXbr7lS2AIQfZTUxUN1f9wV
        qm1N6tVbRNqHdsnV/TnFYpgiZceWEIwPCtUflMN62LJnBvC709vFP0uHsyDCThSSeWu6mrVSc4kBS
        ACFvJknQ==;
Received: from [177.102.82.39] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pK3Pt-00GEfP-7R; Mon, 23 Jan 2023 21:27:45 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        contactshashanksharma@gmail.com, amaranath.somalapuram@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RFC PATCH] drm: Create documentation about device resets
Date:   Mon, 23 Jan 2023 17:26:46 -0300
Message-Id: <20230123202646.356592-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123202646.356592-1-andrealmeid@igalia.com>
References: <20230123202646.356592-1-andrealmeid@igalia.com>
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

Create a document that specifies how to deal with DRM device resets for
kernel and userspace drivers.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 Documentation/gpu/drm-reset.rst | 51 +++++++++++++++++++++++++++++++++
 Documentation/gpu/index.rst     |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/gpu/drm-reset.rst

diff --git a/Documentation/gpu/drm-reset.rst b/Documentation/gpu/drm-reset.rst
new file mode 100644
index 000000000000..0dd11a469cf9
--- /dev/null
+++ b/Documentation/gpu/drm-reset.rst
@@ -0,0 +1,51 @@
+================
+DRM Device Reset
+================
+
+The GPU stack is really complex and is prone to errors, from hardware bugs,
+faulty applications and everything in the many layers in between. To recover
+from this kind of state, sometimes is needed to reset the GPU. Unproper handling
+of GPU resets can lead to an unstable userspace. This page describes what's the
+expected behaviour from DRM drivers to do in those situations, from usermode
+drivers and compositors as well.
+
+Robustness
+----------
+
+First of all, application robust APIs, when available, should be used. This
+allows the application to correctly recover and continue to run after a reset.
+Apps that doesn't use this should be promptly killed when the kernel driver
+detects that it's in broken state. Specifically guidelines for some APIs:
+
+- OpenGL: During a reset, KMD kill processes that haven't ARB Robustness
+  enabled, assuming they can't recover.
+- Vulkan: Assumes that every app is able to deal with ``VK_ERROR_DEVICE_LOST``,
+  so KMD doesn't kill any. If it doesn't do it right, it's considered a broken
+  application and UMD will deal with it.
+
+Kernel mode driver
+------------------
+
+The KMD should be able to detect that something is wrong with the application
+and that a reset is needed to take place to recover the device (e.g. an endless
+wait). It needs to properly track the context that is broken and mark it as
+dead, so any other syscalls to that context should be further rejected. The
+other contexts should be preserved when possible, avoid crashing the rest of
+userspace. KMD can ban a file descriptor that keeps causing resets, as it's
+likely in a broken loop.
+
+User mode driver
+----------------
+
+During a reset, UMD should be aware that rejected syscalls indicates that the
+context is broken and for robust apps the recovery should happen for the
+context. Non-robust apps would be already terminated by KMD. If no new context
+is created for some time, it is assumed that the recovery didn't work, so UMD
+should terminate it.
+
+Compositors
+-----------
+
+(In the long term) compositors should be robust as well to properly deal with it
+errors. Init systems should be aware of the compositor status and reset it if is
+broken.
diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
index b99dede9a5b1..300b2529bd39 100644
--- a/Documentation/gpu/index.rst
+++ b/Documentation/gpu/index.rst
@@ -9,6 +9,7 @@ Linux GPU Driver Developer's Guide
    drm-mm
    drm-kms
    drm-kms-helpers
+   drm-reset
    drm-uapi
    drm-usage-stats
    driver-uapi
-- 
2.39.1

