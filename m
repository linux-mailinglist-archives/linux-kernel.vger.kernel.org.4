Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6C74F9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjGKVgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGKVgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:36:07 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9131BC1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ejZZEKDMhXw4j4IEg03PtvfMno8w3phoXuomv3p/hio=; b=QndCUJKuerndBPoYHtUjBNEcos
        GQ7EXlnjZy4EXgWbIjj8nfcxW3mC1bRxp1kYNq6sIxSNSWYdnCtGIXuxHDqNKY6UIKRGwNubxO01s
        ptcPNA3QnDDmaLn/DWoD+xqEIXBBPl+6UECjVZh2xYqSH96BnkdySGfaNC62C3eMEbAXynN8Pt3h2
        Se+CyKHmMFfaStfnYJhcxTkMWa8ZcfVL3D6V8+PmpDTrpi8t07INoGsaKBp3HsKyd39lyqhruGjKN
        3oZDedRAohu3tn8QbB021EvmxQjnaHfz5hWyy7Ziski5TQPpZZeom/tO0UjESD4VKBr+yKcud6QbF
        H35d/Uhw==;
Received: from [187.74.70.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qJL1b-00Cl0M-DU; Tue, 11 Jul 2023 23:35:59 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
        michel.daenzer@mailbox.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 6/6] drm/amdgpu: Create version number for coredumps
Date:   Tue, 11 Jul 2023 18:35:01 -0300
Message-ID: <20230711213501.526237-7-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711213501.526237-1-andrealmeid@igalia.com>
References: <20230711213501.526237-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if there's nothing currently parsing amdgpu's coredump files, if
we eventually have such tools they will be glad to find a version field
to properly read the file.

Create a version number to be displayed on top of coredump file, to be
incremented when the file format or content get changed.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cfeaf93934fd..905574acf3a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1081,6 +1081,9 @@ struct amdgpu_device {
 };
 
 #ifdef CONFIG_DEV_COREDUMP
+
+#define AMDGPU_COREDUMP_VERSION "1"
+
 struct amdgpu_coredump_info {
 	struct amdgpu_device		*adev;
 	struct amdgpu_task_info         reset_task_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 38d03ca7a9fc..7b448e189717 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4985,6 +4985,7 @@ static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
 	p = drm_coredump_printer(&iter);
 
 	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
+	drm_printf(&p, "version: " AMDGPU_COREDUMP_VERSION "\n");
 	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
 	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
 	drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec, coredump->reset_time.tv_nsec);
-- 
2.41.0

