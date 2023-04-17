Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DE46E4F77
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjDQRms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDQRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:42:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3ED6E93;
        Mon, 17 Apr 2023 10:42:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2fa36231b1cso662577f8f.2;
        Mon, 17 Apr 2023 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753359; x=1684345359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIDH6QLW9GMl0SUIgFXpcL60wep3vko9cwbetNFih7Q=;
        b=hnZdPQ4bSnn7IM8OzetvjfY2BXRKa7KvAD32v0r1j4vHr6zQ/fo3vz25ufxSghM4FK
         TGiF9r8hUN3SJJxjj1v+CEteYAcnl5jtnABWOmagTdog0heWPB6OpJHpH5OOwFSj48+1
         IvLFwyylUzEuV/qqJGUF/i0plTiLfnFiw7ZppVPYaBqkUPJiEvd7M2wq05v3e8L+uOyf
         qN16CUGNuettXdrR5t0SHdfyZGuIV4Yizs/zfk1brEtR2cO+DNnQJyjVlUXikNvRQHGO
         LmVz54SWxenhz0ItD8BndOOMKVMN2ZGpM7xpQTuSRTs8yUoHTRHM1CrJ8mPR1E8f1Vsp
         OfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753359; x=1684345359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIDH6QLW9GMl0SUIgFXpcL60wep3vko9cwbetNFih7Q=;
        b=S8RSinLsRV+h/RlSkLIoxm1TYQ3goAbocbGpYtPIOfVswYi3ItAqKGCjYlB75VB9bz
         cqg8pd7aZ2/cOQr0gdvjploCETR/BAd2A/PKAqthtFL3wwQJhqTULnRADEgLqRji/FiN
         P6eT9BZyMKxwddUeq67W7aAl6WiOTUAuy4kWiHQbg94VNt7KIPgOHxVGjKraa7CE+qhu
         xCgnUnyNkzbolNDqDk34a/Qij2AG9LJGUcK9J2viBsRlJ1XXqyYxk717qHVvM92JvTSK
         7u82obonoPQ6C/xHzFiwfxxJ+9VqlR+snp9UmKGI2Jos96jDL6agHYppG1tY00GyU2bH
         sY2A==
X-Gm-Message-State: AAQBX9fQjJgasMGGg9VRc+iH6TzYQ83rycfcF/JfS5CaybkJf7/ksuab
        tNGBGydPLL7p+hdpwnPkJ6c=
X-Google-Smtp-Source: AKy350aIJeioHbqYsZwsjs2wu7mqk/RIk0YjL7wRrWriUPu2VJKeMsMLs0JBPaKIE17WoXikYfOlwA==
X-Received: by 2002:adf:f5c3:0:b0:2fb:be8b:133b with SMTP id k3-20020adff5c3000000b002fbbe8b133bmr912525wrp.25.1681753359042;
        Mon, 17 Apr 2023 10:42:39 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d4911000000b002e55cc69169sm11024585wrq.38.2023.04.17.10.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:42:38 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/pm: Fix spelling mistake "aquire" -> "acquire"
Date:   Mon, 17 Apr 2023 18:42:37 +0100
Message-Id: <20230417174237.52638-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in the smu_i2c_bus_access prototype. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 5ce433e2c16a..f1580a26a850 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -359,7 +359,7 @@ struct pp_hwmgr_func {
 	int (*set_ppfeature_status)(struct pp_hwmgr *hwmgr, uint64_t ppfeature_masks);
 	int (*set_mp1_state)(struct pp_hwmgr *hwmgr, enum pp_mp1_state mp1_state);
 	int (*asic_reset)(struct pp_hwmgr *hwmgr, enum SMU_ASIC_RESET_MODE mode);
-	int (*smu_i2c_bus_access)(struct pp_hwmgr *hwmgr, bool aquire);
+	int (*smu_i2c_bus_access)(struct pp_hwmgr *hwmgr, bool acquire);
 	int (*set_df_cstate)(struct pp_hwmgr *hwmgr, enum pp_df_cstate state);
 	int (*set_xgmi_pstate)(struct pp_hwmgr *hwmgr, uint32_t pstate);
 	int (*disable_power_features_for_compute_performance)(struct pp_hwmgr *hwmgr,
-- 
2.30.2

