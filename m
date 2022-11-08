Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DEA621B3B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiKHRy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbiKHRyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:54:49 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308561AD8F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ukvrU4BRwqv/hi5Lb7tXJdxSLVociGC6eZ07IJrOiWk=; b=qwnYcD7/yDMEdogFwt4kmfJ7RC
        isnolX2gNmqTtIvI30j0dAzZ0o+jKxkr2PwN3KWbziKiPJmiuXLSHaEcbtPlUX7a1hvQlCZCFZ/VQ
        S9JBnxjOVY5QCpObtqQ0Nx0twHYNZJomXyotVgYqdB3MTHV4/dVlm/DomTXkv4okcQP5X39SstZIl
        cV+V+GIvtH+rUgAVwxu/aLNlcSR1HIMV6nIOwDAAPWjB3Mn/fUER2n2R5/tYmF5hPf//HDvuLrc/7
        DDXmJnepWBKtzAJ6g+PNLpHJiWQy7Fi32ghmYjvpgYkeFq1xY3+45LwlmBAg0z3bkbmNsCP2NPEYj
        bVq4ydIw==;
Received: from [177.34.169.227] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1osSo5-00EVxA-ED; Tue, 08 Nov 2022 18:54:42 +0100
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     Melissa Wen <mwen@igalia.com>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        "Juan A . Suarez" <jasuarez@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2 2/2] drm/v3d: add missing mutex_destroy
Date:   Tue,  8 Nov 2022 14:54:25 -0300
Message-Id: <20221108175425.39819-3-mcanal@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108175425.39819-1-mcanal@igalia.com>
References: <20221108175425.39819-1-mcanal@igalia.com>
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
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/v3d/v3d_perfmon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 48aaaa972c49..e1be7368b87d 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -17,8 +17,10 @@ void v3d_perfmon_get(struct v3d_perfmon *perfmon)
 
 void v3d_perfmon_put(struct v3d_perfmon *perfmon)
 {
-	if (perfmon && refcount_dec_and_test(&perfmon->refcnt))
+	if (perfmon && refcount_dec_and_test(&perfmon->refcnt)) {
+		mutex_destroy(&perfmon->lock);
 		kfree(perfmon);
+	}
 }
 
 void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
@@ -113,6 +115,7 @@ void v3d_perfmon_close_file(struct v3d_file_priv *v3d_priv)
 	idr_for_each(&v3d_priv->perfmon.idr, v3d_perfmon_idr_del, NULL);
 	idr_destroy(&v3d_priv->perfmon.idr);
 	mutex_unlock(&v3d_priv->perfmon.lock);
+	mutex_destroy(&v3d_priv->perfmon.lock);
 }
 
 int v3d_perfmon_create_ioctl(struct drm_device *dev, void *data,
@@ -154,6 +157,7 @@ int v3d_perfmon_create_ioctl(struct drm_device *dev, void *data,
 	mutex_unlock(&v3d_priv->perfmon.lock);
 
 	if (ret < 0) {
+		mutex_destroy(&perfmon->lock);
 		kfree(perfmon);
 		return ret;
 	}
-- 
2.38.1

