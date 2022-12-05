Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99986429F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiLEN4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiLEN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:56:30 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16661257
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KsNzkwVwgR+cEA5X8iXb1kE6xx18RGkmAb0qmlWlRgg=; b=GjaCbrowCd99kPgE8d3uiGCQIr
        6lWgGfXrOvIJMSd6HmKjc3AEHsywMdG+njahJ4aK4JwBp7AoC1q1v2MAJVODBj0oAwa2KvZLEzoNi
        pQCUVZdwWcjupRhxNsTy2WZ40edBWOkF+hUebAkO81TGO9aIcwbV4JXZlxoPUnVtu1/+ERS4oWoKm
        ZkBMRuSyeoglvZ/aDZc3/Hpw9AHjZxvz+VBfCq8vviLl2pfRDXQj2F4Ic2rdpj1rGrWSwFMiho99u
        /ovJnDL6QqX9jR9CMu9gBYw3+9xKrr9TT4FtGOOAco3UCasbCk2Q4Q14HhAYNpCVyO+ErIZnF2MkL
        2WX8WtFw==;
Received: from [41.74.137.107] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1p2Bx7-00FUSn-1Q; Mon, 05 Dec 2022 14:56:13 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     emma@anholt.net, mwen@igalia.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maira Canal <mcanal@igalia.com>, kernel-dev@igalia.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/v3d: cleanup BOs properly when lookup_bos fails
Date:   Mon,  5 Dec 2022 12:55:37 -0100
Message-Id: <20221205135538.3545051-2-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221205135538.3545051-1-mwen@igalia.com>
References: <20221205135538.3545051-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When v3d_lookup_bos fails to `allocate validated BO pointers`,
job->bo_count was already set to args->bo_count, but job->bo points to
NULL. In this scenario, we must verify that job->bo is not NULL before
iterating on it to proper clean up a job. Also, drm_gem_object_put
already checks that the object passed is not NULL, doing the job->bo[i]
checker redundant.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 96af1cb5202a..31a37572c11d 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -363,11 +363,11 @@ v3d_job_free(struct kref *ref)
 	struct v3d_job *job = container_of(ref, struct v3d_job, refcount);
 	int i;
 
-	for (i = 0; i < job->bo_count; i++) {
-		if (job->bo[i])
+	if (job->bo) {
+		for (i = 0; i < job->bo_count; i++)
 			drm_gem_object_put(job->bo[i]);
+		kvfree(job->bo);
 	}
-	kvfree(job->bo);
 
 	dma_fence_put(job->irq_fence);
 	dma_fence_put(job->done_fence);
-- 
2.35.1

