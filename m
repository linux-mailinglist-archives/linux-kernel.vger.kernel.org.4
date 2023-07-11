Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243D974F9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjGKVgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGKVf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:35:58 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F40171E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WH7Cm3VveDbv6D+GxRpXLNfTbvl+zR6aYn4to7mM5e0=; b=o6ZCvMVtkCfTreopWJ0LzaVhuw
        BpyVOSfP1bMdVfWrbafOBb2fOdFbsHfTlv+klJvaVKoNt6j3iQ/0q/U8Og+M9LC5pEtMURUGNXGS5
        fci8b6lrQ20/F99S8foYZPyG7KGKd97Vm2vwFlvIS9P3x7TmIqXSz5qApGZSfoSxF/ybGn1g27XgN
        /GgLePM+/Pov1YFOnw5OzewKz2tl6pvAUqSs2SslC5GucnwcfaPCBXtBqXd+PSDBYKQH/tNr2AbsH
        ACHoxrtQT1Ejq5c4nTQIJ5w2Jx86RrCBUSKlWkC90wYL/0RBPnxrGi5l0G9RqT32rEBh1acgWAyQi
        SIpq0c1g==;
Received: from [187.74.70.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qJL1U-00Cl0M-Ph; Tue, 11 Jul 2023 23:35:53 +0200
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
Subject: [PATCH 4/6] drm/amdgpu: Limit info in coredump for kernel threads
Date:   Tue, 11 Jul 2023 18:34:59 -0300
Message-ID: <20230711213501.526237-5-andrealmeid@igalia.com>
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

If a kernel thread caused the reset, the information available to be
logged will be limited, so return early in the dump function.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 23b9784e9787..7449aead1e13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4988,10 +4988,14 @@ static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
 	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
 	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
 	drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec, coredump->reset_time.tv_nsec);
-	if (coredump->reset_task_info.pid)
+	if (coredump->reset_task_info.pid) {
 		drm_printf(&p, "process_name: %s PID: %d\n",
 			   coredump->reset_task_info.process_name,
 			   coredump->reset_task_info.pid);
+	} else {
+		drm_printf(&p, "GPU reset caused by a kernel thread\n");
+		return count - iter.remain;
+	}
 
 	if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
-- 
2.41.0

