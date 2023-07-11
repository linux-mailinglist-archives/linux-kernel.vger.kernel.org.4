Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5386774F9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGKVf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGKVft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:35:49 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D338127
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ddrjm27aI2mzONVUTJ28Yp+tdR9+PE1LPwDohpg9Dzo=; b=pTL/XLcfjoADLmvXjercNTTKr1
        f1hgqEGH9Jk6v+MtlrnR8mnSSM7DK3Z6BzYZNGmq80ZLBxGaYKNVChiD5sIOO8enRyAtXEBX5r9Td
        KmT3AEEudOVjBR/roOGGSf4EVN5SYcAELVWHxFNUyvrTML5H0g85t/UBkkCtvSaR9UKCj61X7ciBX
        3Bg+NIrva9TfY0d2M7dOWjFk/wuPKzJ4Zhq9Ft3d/QNm8c/gBBoRQ829jgR7MKxqPeKNmoI/2ta7t
        OFGjohehJYr6tx/pfpBG0aEzSiKTs9jorXaqMeZ/QOUQEFkndPXG+N0a6IdtbXuZKN5QrrGLy/gLj
        /zTQaLLA==;
Received: from [187.74.70.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qJL1O-00Cl0M-7n; Tue, 11 Jul 2023 23:35:46 +0200
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
Subject: [PATCH 2/6] drm/amdgpu: Mark contexts guilty for causing soft recoveries
Date:   Tue, 11 Jul 2023 18:34:57 -0300
Message-ID: <20230711213501.526237-3-andrealmeid@igalia.com>
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

If a DRM fence is set to -ENODATA, that means that this context was a
cause of a soft reset, but is never marked as guilty. Flag it as guilty
and log to user that this context won't accept more submissions.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 0dc9c655c4fb..fe8e47d063da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -459,6 +459,12 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 	ctx_entity = &ctx->entities[hw_ip][ring]->entity;
 	r = drm_sched_entity_error(ctx_entity);
 	if (r) {
+		if (r == -ENODATA) {
+			DRM_ERROR("%s (%d) context caused a reset,"
+				  "marking it guilty and refusing new submissions.\n",
+				  current->comm, current->pid);
+			atomic_set(&ctx->guilty, 1);
+		}
 		DRM_DEBUG("error entity %p\n", ctx_entity);
 		return r;
 	}
-- 
2.41.0

