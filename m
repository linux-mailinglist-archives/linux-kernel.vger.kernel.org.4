Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ADB733134
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbjFPM2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjFPM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:28:22 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375E01FFF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:28:20 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9003A3F36A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686918498;
        bh=7aIuaUbJc/mQS9T0aBfOHsiM7MOxneztv9jcxZlcdiI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=gmkAFbkAgV36mjnQXD+lL00eadH3cL2iws4TOzpi7053Tf2wJt5nulPlls1Ezb015
         bAcmkX8kwYpCATpZkQgAo03SXmLbksUkX7zMAbwF86Inur98lYzEZXUEm4wwBh9u1O
         lSPAsJjPW+vv/bNL4gO6HgJeeg3FttkBE+e5dioK2qGIflTkUAJQtuTwrm3vEkLIcC
         qBbOhaiHn8OjnoBDfaPTyKTvE1g3dcN17VY4Z0d7h49+wZhutkHC47JnDS2PhGPNon
         JOssCEYQT6kU9Aecm/ismeMLrOBu+5tpfcGB3N7A/C2ZeCE4UGZUc0xxCBeC70tyMp
         vDs9UQTkt8hKA==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e4d11a413so840726f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686918498; x=1689510498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aIuaUbJc/mQS9T0aBfOHsiM7MOxneztv9jcxZlcdiI=;
        b=g3E5IqbTwE4SH02OrStMsZeUMrk3qlzKi9cbEMwe/oXHicC81V95RjoaiyvEVg7bCB
         DYC+Nh5tnw1wJN1GbV7/hw3VliiTV/eIaO9q8xKqEXvz1CpAm/PfNnu2ROrQoTRS9qIe
         c1cN4elrAfaSVlPic89r+lsvpVCKHUkPdB6KDTp48EjyK0VcB15cRS+jViL25RdQwP7+
         Gupo3+wiTQQP5RbjY9hDH9MlpGGkC3obneU7MC0jJzAmsWCJKwm4tNPe+WkmdTiM49/w
         IVYNe8hwnpu2Lq9grLeohaNdigaKmaqJ7Ye1aTu846oA8T7K25GyUUt52z7LlmfRtHXf
         Qy/g==
X-Gm-Message-State: AC+VfDxluLmvbk9fCgBnyK0S0Cs42Cqh1b2umtO344OhrSe792Nlwvwy
        ibIiWLeMsC8vGo01fCDaErispOscvRP7BySq/hd1E0jes51h34l6Muyl7cr8rGBzaC2UHHZ1N51
        mIBT8LYGaQE4hl8iKX5LBTiJQmHOLpXfvU5xINpQdpBYxNsq2Lxh3
X-Received: by 2002:a5d:540a:0:b0:30f:b0de:f100 with SMTP id g10-20020a5d540a000000b0030fb0def100mr1688698wrv.23.1686918497894;
        Fri, 16 Jun 2023 05:28:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7unBLWvn7eu+/rOTRKqs5JmWynktPc0fpo3fUsOeWbUBSx9ckKi/1QQo/F4AC7I4VtmMb2rQ==
X-Received: by 2002:a5d:540a:0:b0:30f:b0de:f100 with SMTP id g10-20020a5d540a000000b0030fb0def100mr1688671wrv.23.1686918497538;
        Fri, 16 Jun 2023 05:28:17 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id cr4-20020a05600004e400b003063a92bbf5sm23726788wrb.70.2023.06.16.05.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:28:17 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        konrad.dybcio@linaro.org, quic_akhilpo@quicinc.com,
        ribalda@chromium.org, joel@joelfernandes.org,
        juerg.haefliger@canonical.com
Subject: [PATCH] drm/msm/adreno: Update MODULE_FIRMWARE macros
Date:   Fri, 16 Jun 2023 14:28:15 +0200
Message-Id: <20230616122815.1037425-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing MODULE_FIRMWARE macros and remove some for firmwares that
the driver no longer references.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 23 ++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 8cff86e9d35c..9f70d7c1a72a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -364,17 +364,32 @@ MODULE_FIRMWARE("qcom/a330_pm4.fw");
 MODULE_FIRMWARE("qcom/a330_pfp.fw");
 MODULE_FIRMWARE("qcom/a420_pm4.fw");
 MODULE_FIRMWARE("qcom/a420_pfp.fw");
+MODULE_FIRMWARE("qcom/a506_zap.mdt");
+MODULE_FIRMWARE("qcom/a508_zap.mdt");
+MODULE_FIRMWARE("qcom/a512_zap.mdt");
 MODULE_FIRMWARE("qcom/a530_pm4.fw");
 MODULE_FIRMWARE("qcom/a530_pfp.fw");
 MODULE_FIRMWARE("qcom/a530v3_gpmu.fw2");
 MODULE_FIRMWARE("qcom/a530_zap.mdt");
-MODULE_FIRMWARE("qcom/a530_zap.b00");
-MODULE_FIRMWARE("qcom/a530_zap.b01");
-MODULE_FIRMWARE("qcom/a530_zap.b02");
+MODULE_FIRMWARE("qcom/a540_gpmu.fw2");
+MODULE_FIRMWARE("qcom/a540_zap.mdt");
+MODULE_FIRMWARE("qcom/a615_zap.mdt");
 MODULE_FIRMWARE("qcom/a619_gmu.bin");
 MODULE_FIRMWARE("qcom/a630_sqe.fw");
 MODULE_FIRMWARE("qcom/a630_gmu.bin");
-MODULE_FIRMWARE("qcom/a630_zap.mbn");
+MODULE_FIRMWARE("qcom/a630_zap.mdt");
+MODULE_FIRMWARE("qcom/a640_gmu.bin");
+MODULE_FIRMWARE("qcom/a640_zap.mdt");
+MODULE_FIRMWARE("qcom/a650_gmu.bin");
+MODULE_FIRMWARE("qcom/a650_sqe.fw");
+MODULE_FIRMWARE("qcom/a650_zap.mdt");
+MODULE_FIRMWARE("qcom/a660_gmu.bin");
+MODULE_FIRMWARE("qcom/a660_sqe.fw");
+MODULE_FIRMWARE("qcom/a660_zap.mdt");
+MODULE_FIRMWARE("qcom/leia_pfp_470.fw");
+MODULE_FIRMWARE("qcom/leia_pm4_470.fw");
+MODULE_FIRMWARE("qcom/yamato_pfp.fw");
+MODULE_FIRMWARE("qcom/yamato_pm4.fw");
 
 static inline bool _rev_match(uint8_t entry, uint8_t id)
 {
-- 
2.37.2

