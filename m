Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7BA6410B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiLBWea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiLBWeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:34:14 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBF2FB88C;
        Fri,  2 Dec 2022 14:33:49 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ha10so14700296ejb.3;
        Fri, 02 Dec 2022 14:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/p1+V/z+oR39h38nh1M5hCwPSL3t8Y/qdykCOeejV0=;
        b=a+50oLwNxjPhsywArY16tosqg875B9DBC57M3kQPZvQ+ach28oR8C+aEWIz01Ccabg
         JRJNW+YyvhAS29M1sSxSY4AP8LPgHVzlv/sfvH7AR2FLW+JDImaeGzMEO6OdqHIdam8f
         fVjwEog2vr3o+97yDA8vz5/rWSdFeYl+qS4DvtnXZ6L30K8tFX9nZeasfF3VQ5AX0og1
         0mN/BQ8vzzaMM4spCCz58L9rnWSD85eshQgniJqcPMoVCeDlUbTu3JT+WibZ/5S+P1cK
         Y8TCh6+uSiz3UCAIw1PwWtH023IO6f7z+foESvBcwVXWWTJFRhLNO/Z8li4EA9hkc1JK
         e4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/p1+V/z+oR39h38nh1M5hCwPSL3t8Y/qdykCOeejV0=;
        b=Xv1b/LuYLayVNGEFBXSGhVGLBNYGiepNRo9Ua3H05rftwJHamKS6Ofrf6/4En13pvQ
         w10VegqAxV/yYxryzwVoJzdQUNH9fGgumOtQglZjeC5p6Pe6aqEZNJYAgIz4YyV9d+Sz
         lc3XcjHLivwHqArmynfeILg0zQtgqajVOvjbQPTc7XEBiL8foEGmLCGBZKeViY4aIy1p
         wV46P29OtPD4+vQmBuZWAuI8Sv4RVyCep+ghAvsdtra4oCoaz6sv2Xc2xn/wL8pqUSOA
         YpuvHHNrsUKLNgq4+u1omXAwHGVRoZetWYr0ihRVSBRZdurv9jjPU9Z3e3GeZt3s4E51
         3yGg==
X-Gm-Message-State: ANoB5pnHRjFnIGEwV6lFOfiE0p/uL14BbqIGRPxG6DAdCxWRyh9I6pWo
        VBwR6BPhC68H0kzTJotzWHBJY7F+b6PhXg==
X-Google-Smtp-Source: AA0mqf4BHmpLiknHAc13V79dFatrRncPt6Rt7EdPxLr6NgmamON5IQzNkObb/askcObyCVkvHs2aSA==
X-Received: by 2002:a17:907:d60b:b0:7bc:dbd8:184b with SMTP id wd11-20020a170907d60b00b007bcdbd8184bmr31632110ejc.110.1670020428205;
        Fri, 02 Dec 2022 14:33:48 -0800 (PST)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b007c0d0dad9c6sm575340ejg.108.2022.12.02.14.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:33:47 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] platform/surface: aggregator_registry: Fix target-ID of base-hub
Date:   Fri,  2 Dec 2022 23:33:27 +0100
Message-Id: <20221202223327.690880-10-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202223327.690880-1-luzmaximilian@gmail.com>
References: <20221202223327.690880-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target ID of the base hub is currently set to KIP (keyboard/
peripherals). However, even though it manages such devices with the KIP
target ID, the base hub itself is actually accessed via the SAM target
ID. So set it accordingly.

Note that the target ID of the hub can be chosen arbitrarily and does
not directly correspond to any physical or virtual component of the EC.
This change is only a code improvement intended for consistency and
clarity, it does not fix an actual bug.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_hub.c      | 2 +-
 drivers/platform/surface/surface_aggregator_registry.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_hub.c b/drivers/platform/surface/surface_aggregator_hub.c
index 6abd1efe2088..8b8b80228c14 100644
--- a/drivers/platform/surface/surface_aggregator_hub.c
+++ b/drivers/platform/surface/surface_aggregator_hub.c
@@ -349,7 +349,7 @@ static const struct ssam_hub_desc kip_hub = {
 
 static const struct ssam_device_id ssam_hub_match[] = {
 	{ SSAM_VDEV(HUB, SAM, SSAM_SSH_TC_KIP, 0x00), (unsigned long)&kip_hub  },
-	{ SSAM_VDEV(HUB, KIP, SSAM_SSH_TC_BAS, 0x00), (unsigned long)&base_hub },
+	{ SSAM_VDEV(HUB, SAM, SSAM_SSH_TC_BAS, 0x00), (unsigned long)&base_hub },
 	{ }
 };
 MODULE_DEVICE_TABLE(ssam, ssam_hub_match);
diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 023f126121d7..296f72d52e6a 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -46,7 +46,7 @@ static const struct software_node ssam_node_hub_kip = {
 
 /* Base device hub (devices attached to Surface Book 3 base). */
 static const struct software_node ssam_node_hub_base = {
-	.name = "ssam:00:00:02:11:00",
+	.name = "ssam:00:00:01:11:00",
 	.parent = &ssam_node_root,
 };
 
-- 
2.38.1

