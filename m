Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CED62028E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiKGWsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiKGWsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:48:42 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86192AE1D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=N58UJpNNAExktwhfZVLTshsZnQ2VVILEtn44kEC8lhE=; b=aBTAUl7EESx7XqVKDnD6YS7wbj
        8/vNDRacf5mqYJTrbPEn+ZEhFXJmKIZAq537t3odJDE2x9hKTX4hzTkK7xoRewIxuTHz8ZvfINQrM
        8trMpHc+FYEYh7MumOFYd1uACya663nsFCtK+imVa5c8s5MUnC/OMtBVwau/H2gHIgO72gc6C/R30
        0TIQq5EfB2xhLe/DIl5cY16ASG6VjyDD6zFlb2o3GUfMdcSSLVuaQJdyZ72u60AfEzfC6UG12gsOq
        nRz7jSuoVzZvGAH3/X8FK7M3fX26tTWljUqPeUX93a5wrs4tpIao/81IOQvcYU8lPh9l+dowMw558
        AvVFSEzA==;
Received: from [177.34.169.227] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1osAuz-00E9qX-5g; Mon, 07 Nov 2022 23:48:37 +0100
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     Melissa Wen <mwen@igalia.com>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        "Juan A . Suarez" <jasuarez@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 2/2] drm/v3d: add missing mutex_destroy
Date:   Mon,  7 Nov 2022 19:46:56 -0300
Message-Id: <20221107224656.278135-3-mcanal@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107224656.278135-1-mcanal@igalia.com>
References: <20221107224656.278135-1-mcanal@igalia.com>
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

v3d_perfmon_open_file() instantiates a mutex for a particular file
instance, but it never destroys it by calling mutex_destroy() in
v3d_perfmon_close_file().

Similarly, v3d_perfmon_create_ioctl() instantiates a mutex for a
particular perfmon, but it never destroys it by calling mutex_destroy()
in v3d_perfmon_destroy_ioctl().

So, add the missing mutex_destroy on both cases.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_perfmon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 48aaaa972c49..292c73544255 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -113,6 +113,7 @@ void v3d_perfmon_close_file(struct v3d_file_priv *v3d_priv)
 	idr_for_each(&v3d_priv->perfmon.idr, v3d_perfmon_idr_del, NULL);
 	idr_destroy(&v3d_priv->perfmon.idr);
 	mutex_unlock(&v3d_priv->perfmon.lock);
+	mutex_destroy(&v3d_priv->perfmon.lock);
 }
 
 int v3d_perfmon_create_ioctl(struct drm_device *dev, void *data,
@@ -177,6 +178,7 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 	if (!perfmon)
 		return -EINVAL;
 
+	mutex_destroy(&perfmon->lock);
 	v3d_perfmon_put(perfmon);
 
 	return 0;
-- 
2.38.1

