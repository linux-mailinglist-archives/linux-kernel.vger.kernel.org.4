Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9CF69D626
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 23:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjBTWKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 17:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjBTWKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 17:10:45 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF0BBA1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:10:44 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id f1so3526424qvx.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THHRayynm5AbgmOQpvB3lJW0friOEzmgv0B/wGzZtaA=;
        b=cd4XXa3fNnrg4LJTnbDxcbv3CN5vQu9dFW7K/yevG1ESO+5qoiYifACic1FvzLTahl
         70UcW1Q8xLIUxahrwD9L377EfRLCR0pWCU2uAdgU42SY+ar3FPPzQ82ksKDUsmgOfys/
         IbntLfDc5qgbr7YeEqCz4BOLKCAOqjoptTEp5cpYWumbWaSYLgUAlx3qC1irSU7kAso1
         lfUCy0ei8319yKCts5WXcg3IHl13OvAH87QidFj9QXgrri/5mSp9e7voGdC5tU+DfFhH
         tSSObiPjVWneoPSyWLHE1OZWO5Wz308RjFowk7hzjgqlzzHyYOXuinnidDaVeDhYL4t9
         dvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THHRayynm5AbgmOQpvB3lJW0friOEzmgv0B/wGzZtaA=;
        b=h2KDsRmQ4/H6gAEO91exnO8X6lUjV2YH7nhJ/wUZjVGGK5MHiNx3BJaWXTv9Ze3kAy
         D6Ka7sjZAji9t0HFXGb0mEcVoTQ538aCNWV9DOPs/fSfcSDa5pXoJP/bKf9PE9CCQn3N
         xvDIqHQ1+x1sMxL4wlzFlIUQQNhXyk192MssLX5V9v2rzYOIGKg1r2E/OpXze6h82X3y
         iBP+wCGmClnSXLMq12zpy8SQMkXHDphWlzvF1N6E5JD2QzqkUwIO2rqkRDCw+VX5HfHN
         LF3zcvCMvJ+yGY3nqQ/tosCJIBhGBmXvzwRg/0WGwIQo/tB5cGCL88PUyAwEgchQCK2u
         Tk/A==
X-Gm-Message-State: AO0yUKU58HrJ1pblMhm3T6xITVt37VuDzAwERNhq39XM4DbOrUn9IRq8
        V8wjC1pQ6/risjJMJAZ2vvWfQQ==
X-Google-Smtp-Source: AK7set9k8VGbxQBwp63BLeFM6sBGZ9Dgy6JIHVTflubD0lj+FqQd0anGtxp8/ti9qlstxkTSB7LYcw==
X-Received: by 2002:a05:6214:400c:b0:570:ee5c:2953 with SMTP id kd12-20020a056214400c00b00570ee5c2953mr5529273qvb.11.1676931043469;
        Mon, 20 Feb 2023 14:10:43 -0800 (PST)
Received: from [127.0.1.1] (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a024d00b006f9ddaaf01esm9766986qkn.102.2023.02.20.14.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:10:43 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
Date:   Mon, 20 Feb 2023 17:10:34 -0500
Subject: [PATCH v3 2/3] drm/bridge: tfp410: Fix logic to configured polled
 HPD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-tfp410_i2c-v3-2-a85d5f0f50f1@criticallink.com>
References: <20230125-tfp410_i2c-v3-0-a85d5f0f50f1@criticallink.com>
In-Reply-To: <20230125-tfp410_i2c-v3-0-a85d5f0f50f1@criticallink.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>,
        Jonathan Cormier <jcormier@criticallink.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=mvqilqhA2ozv8fVrZmSQf6YxF7B70T7NT6GdEuGjaz8=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBj8+/gQc8xd6ZnX+LNtCrbMa8giQdgnGzf3ueFThk4
 LUUWk/CJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCY/Pv4AAKCRDc1/0uCzbrqqiKEA
 CrUHS+hGQ+sFkAozQQYuVP4QYluZf5P9PCTtwe447h+TIRNyzmn2K5oc8gx5VNI4HAWreqeJoAsm8H
 A+4DbWgt+2ms6pIcgx4qiSrRWYxYjIT47n0HLdrwgZSGtlm94K8B72xhxZjf+3qD0b/xz73/6pgDtH
 IcfH+CZsGWuXNuxeDWK3S6YoqR5BUB3qrp78nJj/gajYET/ny5SfWja0R//ev6VCVP41cVL8az4LRi
 P58udsLnAufv/JcNxd24LfVhf6gaDbjYpI62vgzihCgRhL95hrWYW7KYRWkkRaS5BgcvIZiS9eyg6f
 8XXkijOqjKykbMnTCPVFm5eTzANa8CHekSHZFpx3mL/coXKb249QMED+ug9Osuwes3Gj8KDRqVKUwj
 b2MiTbIouWH/5GVDm8BWsqkj/x3LVbeB8pXiKbRkOMP+mlr9s8jNuc0OScUp3f/IRzAYuJbTd/xorf
 3ttPy7RS2QM2jYgZuZOzKh3dZ4fNqMo/GXY/T2n2sV6bEfxlYkIufxhoIradqG6nioT6Zn+9ebQ9AU
 9UitqfVXvj2toe0IHPVu/Qh4cS+icyCBhJuQG+3RMeDFPrUrR9MCzQylUfXPhGfzuGS68VzwoNLfuq
 VvV3a/oAwQ86bi+J3vTeE0BGC7m005ilVTDoeNjE0fBX6Ot/DF6nuhyQV7Ag==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Williamson <michael.williamson@criticallink.com>

The logic to configure polling (vs async/irq notification) of hot-plug
events was not correct.  If the connected bridge requires polling,
then inform the upstream bridge we also require polling.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index bb3f8d0ff207..41007d05d584 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -155,7 +155,7 @@ static int tfp410_attach(struct drm_bridge *bridge,
 		return -ENODEV;
 	}
 
-	if (dvi->next_bridge->ops & DRM_BRIDGE_OP_DETECT)
+	if (dvi->next_bridge->ops & DRM_BRIDGE_OP_HPD)
 		dvi->connector.polled = DRM_CONNECTOR_POLL_HPD;
 	else
 		dvi->connector.polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;

-- 
2.25.1

