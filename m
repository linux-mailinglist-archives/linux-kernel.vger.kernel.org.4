Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4407473E946
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjFZSeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjFZSeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:34:03 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A533E8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oSueTiYMF138dSTfNnMKrmstGKw/e3IK9bYy1ze85L0=; b=VQDVxuCFQBdNcjmnjAju2cUvxx
        LdH3XwBHaGQt+dFtXZzyyu+W/1yGNAVjEAglYJbgQLXHkLJVlffMgBSq1vMLR2wF3dz42dSG8H7Ir
        TlTRAmLlOGgPkXEUMJl8rOUrZbyp1xefiLRLsyHc2zPNT79DoXwsAsD+yhYPtuKnIL6B/DeSBOa0z
        IRENLn6AMyTcHwfLAP3ArGvUvBZv2XLeN0YRVeHkd7DruLNqmwRQRguEnqcWCK/Mgph1JiXokoRmB
        Kgf2wWEq2dYg8ABzgTCFfV11DkZGwflzlbR9a71YIbqeJ+T4EIok1lB/svr/UCWLuWaB4ZjHGYyUZ
        ghykJ52g==;
Received: from [179.113.218.86] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qDr2E-0047zl-Ju; Mon, 26 Jun 2023 20:33:59 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 1/1] drm/doc: Document DRM device reset expectations
Date:   Mon, 26 Jun 2023 15:33:47 -0300
Message-ID: <20230626183347.55118-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626183347.55118-1-andrealmeid@igalia.com>
References: <20230626183347.55118-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a section that specifies how to deal with DRM device resets for
kernel and userspace drivers.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 Documentation/gpu/drm-uapi.rst | 68 ++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 65fb3036a580..25a11b9b98fa 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -285,6 +285,74 @@ for GPU1 and GPU2 from different vendors, and a third handler for
 mmapped regular files. Threads cause additional pain with signal
 handling as well.
 
+Device reset
+============
+
+The GPU stack is really complex and is prone to errors, from hardware bugs,
+faulty applications and everything in between the many layers. Some errors
+require resetting the device in order to make the device usable again. This
+section describes what is the expectations for DRM and usermode drivers when a
+device resets and how to propagate the reset status.
+
+Kernel Mode Driver
+------------------
+
+The KMD is responsible for checking if the device needs a reset, and to perform
+it as needed. Usually a hang is detected when a job gets stuck executing. KMD
+should keep track of resets, because userspace can query any time about the
+reset stats for an specific context. This is needed to propagate to the rest of
+the stack that a reset has happened. Currently, this is implemented by each
+driver separately, with no common DRM interface.
+
+User Mode Driver
+----------------
+
+The UMD should check before submitting new commands to the KMD if the device has
+been reset, and this can be checked more often if it requires to. After
+detecting a reset, UMD will then proceed to report it to the application using
+the appropriated API error code, as explained in the below section about
+robustness.
+
+Robustness
+----------
+
+The only way to try to keep an application working after a reset is if it
+complies with the robustness aspects of the graphical API that it is using.
+
+Graphical APIs provide ways to application to deal with device resets. However,
+there is no guarantee that the app will be correctly using such features, and
+UMD can implement policies to close the app if it is a repeating offender,
+likely in a broken loop. This is done to ensure that it does not keeps blocking
+the user interface from being correctly displayed. This should be done even if
+the app is correct but happens to trigger some bug in the hardware/driver.
+
+OpenGL
+~~~~~~
+
+Apps using OpenGL should use the available robust interfaces, like the
+extension ``GL_ARB_robustness`` (or ``GL_EXT_robustness`` for OpenGL ES). This
+interface tells if a reset has happened, and if so, all the context state is
+considered lost and the app proceeds by creating new ones. If is possible to
+determine that robustness is not in use, UMD will terminate the app when a reset
+is detected, giving that the contexts are lost and the app won't be able to
+figure this out and recreate the contexts.
+
+Vulkan
+~~~~~~
+
+Apps using Vulkan should check for ``VK_ERROR_DEVICE_LOST`` for submissions.
+This error code means, among other things, that a device reset has happened and
+it needs to recreate the contexts to keep going.
+
+Reporting resets causes
+-----------------------
+
+Apart from propagating the reset through the stack so apps can recover, it's
+really useful for driver developers to learn more about what caused the reset in
+first place. DRM devices should make use of devcoredump to store relevant
+information about the reset, so this information can be added to user bug
+reports.
+
 .. _drm_driver_ioctl:
 
 IOCTL Support on Device Nodes
-- 
2.41.0

