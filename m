Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E985B52E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 05:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiILDfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 23:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiILDdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 23:33:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9622A29CAC;
        Sun, 11 Sep 2022 20:30:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l10so7326368plb.10;
        Sun, 11 Sep 2022 20:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=sKbomRMGom70krm78pjOhP3vYpEjxELi8i1q/e0SlpY=;
        b=ZYw3ZzYbu5vDHbMg9BQC0jtdwdYGnkNYBLtlJ433hzRXIIhH7mP5TErdP64efnHF02
         +MVuI8NG9NmvMrzZPt58tjXrW1ZO/xSUQDLk5lpTzyWE/Rw3s1BnCjVe7yJi3AcjY5CI
         8NF7FlGxmVeR4+9zKxpwxM04PdAdf2JqyF24eJMKpn1tqVCH8rlP8uyLNcaZbOkwERu0
         NqaqP2/GzaDsLWg0n9X9GfCyaOH/tX8KeB2+5rKrIr0yClzPXv6AbpUTVoXN/y9yWf4G
         55DQV9QmwfkDwxyMHJDoIpbJobjM9LEt8NTAPPuPVxuPMuhZAmwbEkxDtB2vn4riXTxo
         leOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=sKbomRMGom70krm78pjOhP3vYpEjxELi8i1q/e0SlpY=;
        b=Q1d+0Cdb1HmFFOOgbPr7B4PSPaagc7rKMq0TfWYR/QAkMkcuWpG+lRZZ1bMetXytXL
         4H8E31Zkc9smfv1/FplKbZtTid1Y8o3tMhcPSxwE9xHa8ZRqN8qm8euTDimS2+ZN5IEZ
         fcWTg36XPKLjAwxZdo9KjMjR51PQGpYTrllrQcmlaVb/Pb+qVbwJTblQl9VW159WGPCi
         gNiMP1FSRi8YmvkfhX0dwmERQ51Q1huCBoJCDBYV20nUWVgGfhu6gNCnCDI2Sk0bHDei
         3it7+E980+YGYSf4ATRnOA+FUtw7PK70BcFzjtGrkYdIJM32dzeYS/o7auwAtGx/RAAd
         i27w==
X-Gm-Message-State: ACgBeo3discVrs6+dgugq13+fJO1abVey/q8qJqEWSuqDl0050qvisAJ
        G/1TaxWxb3bTzyYagOGIP7s=
X-Google-Smtp-Source: AA6agR5mMcNSUN0ubuaXtcptrlA41MCJ15Q5xLlOytiB6BZptyu+5PtC2H1EOaddT+BL13/1OuOgrA==
X-Received: by 2002:a17:90b:2704:b0:1fd:aaa9:6d0b with SMTP id px4-20020a17090b270400b001fdaaa96d0bmr21605086pjb.128.1662953437873;
        Sun, 11 Sep 2022 20:30:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a13cf00b00200de8ebc2bsm4062811pjf.13.2022.09.11.20.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 20:30:37 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com,cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, sumit.semwal@linaro.org, Felix.Kuehling@amd.com,
        jonathan.kim@amd.com, Philip.Yang@amd.com, nirmoy.das@amd.com,
        rajneesh.bhardwaj@amd.com, zackr@vmware.com,
        Arunpravin.PaneerSelvam@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/ttm: remove duplicate included header files
Date:   Mon, 12 Sep 2022 03:30:22 +0000
Message-Id: <20220912033021.16320-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

drm/drm_drv.h is included more than once.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b1c455329023..c659d4535ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -43,7 +43,6 @@
 #include <linux/sizes.h>
 #include <linux/module.h>

-#include <drm/drm_drv.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
-- 
2.15.2

