Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380D56E387B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjDPNIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjDPNIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:08:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EE02122;
        Sun, 16 Apr 2023 06:08:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-506767f97f8so2509105a12.1;
        Sun, 16 Apr 2023 06:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681650488; x=1684242488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CtBhR8YOpDqMIofOmWwuAA+9qpS9Sa8zpuzMOiM4dE=;
        b=rCDxLuBs4qW14s7jBjqt1SI/X2rWlsRnsEziv+Ob2RmEBzazeM/AEmaupxLE13hHSh
         1YBkOx5JAjb58cpFCk5ynqK4rx+rEiqT/iITAA/zuCKie09kmRIpLHbU8AedFhFGlZ1y
         5hTpHMFqX73OzZq2XeFyUsfcuHo4kaGBB9W6s8PqFl255+mS20E7vx8rTdTyD6y9XnyY
         ZUaWHuBR4EwLHvxpDHOh8qlKyKTDq2P2d9B8yaw4d7EIJyw13qWOdek1L6eemcu/mLcE
         MMpHmH5ZHqQNg8UE8HJCMRoABBjSi17oe8P5wKRmo3uKmQ4NLQVkS7gGykGG+frApBrW
         QuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681650488; x=1684242488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CtBhR8YOpDqMIofOmWwuAA+9qpS9Sa8zpuzMOiM4dE=;
        b=N6qrq+styDpViXFD6qcpTurxIFwgCnSyXlR9gtsJrtCx8AZdZVi2xXzEN8+dNQqLij
         FCe2J469DDzEiUfOl/nx4f5KOX5Gzhks6ytpmlCURKR+HPpCxYT31G1oegsr0fT7Mr/F
         GKobUJ/tPu7Av/yig2+jWfvF/Sqhz8T68VlB1CnCerR3kRdidHtn0hAWUeEtIU1/fRZ6
         ETlToFlmf4Sazkf8Dxd3R77m67qv82ERPEcKCDeyh0Dmlt/ZEvshHPklp1yThOn6A3du
         Rqr6mS3WrlRMJfamFfe+gFbajTRoceljoNz/QuUJTXHFwsWGgmrNFq0j0wKnjGzJVlS8
         PeiQ==
X-Gm-Message-State: AAQBX9c6/3jQ86+uJhyZpwrWVSFXYXCxYoAGipIeS7R+B/GRxBHfRA08
        ptPO4FmTbxlKH+LX6wbvjuk=
X-Google-Smtp-Source: AKy350aJzZAl31uqCqNRi9GrSrLwH3pnFr31orBUjbJJrDt7xf24JXIQWWiuHvlBD8gAnHReDdf0Pw==
X-Received: by 2002:a05:6402:2d0:b0:502:7767:3c73 with SMTP id b16-20020a05640202d000b0050277673c73mr10268337edx.22.1681650488479;
        Sun, 16 Apr 2023 06:08:08 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id l12-20020a056402344c00b00504803f4071sm4511609edc.44.2023.04.16.06.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:08:08 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v2 3/3] MAINTAINERS: Add entry for Samsung S6D7AA0 LCD panel controller driver
Date:   Sun, 16 Apr 2023 15:07:35 +0200
Message-Id: <20230416130735.30965-4-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416130735.30965-1-aweber.kernel@gmail.com>
References: <20230416130735.30965-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer of the Samsung S6D7AA0 panel driver.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..6a55e6e3ac59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6623,6 +6623,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
 F:	drivers/gpu/drm/panel/panel-samsung-s6d27a1.c
 
+DRM DRIVER FOR SAMSUNG S6D7AA0 PANELS
+M:	Artur Weber <aweber.kernel@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
+F:	drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
+
 DRM DRIVER FOR SITRONIX ST7703 PANELS
 M:	Guido Günther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
-- 
2.40.0

