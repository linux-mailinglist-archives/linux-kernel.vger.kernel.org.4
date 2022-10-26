Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B460DF29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiJZLCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiJZLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:02:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1EB5FCC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:02:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y10so9957848wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Icdth5bW06+FTiDoc6hzh4mTVqW0L169qAB+NpMSMiM=;
        b=VrUr1NCqQmWFyAAU8xzsnEdntA2wopK+LECDVycJpX4G8I9suVjN5U2pA/sRjdlQc2
         AjUMKsTseDp1cTKb1O1il6+2kxcppqLOqrhR2Ekv8lQ6m4TiO991UyalYak5OxK99zxg
         vmDbHoZcft+3vVRz0QmX4tZ+OC4vGw0x8naTY/mvyBGMcamwAWU6wF34wlFy9Hq43MBU
         /CoIuijMweor3KlcVb3yXz+0rM8lBIjOcuoFhvfeeBlxtllk7oO4x9IYtwfM/P9Wsg2O
         YpmcQwBpz/U/JByaWi/jllXHminB/nirn90SXxjbZyaeacCUzDKP/Ui1sT5WIDh/3icv
         KJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Icdth5bW06+FTiDoc6hzh4mTVqW0L169qAB+NpMSMiM=;
        b=FNsU33i/zgen/fBZ2bi3RbsI3dAZF6FizXjj+raVf7J5Yz0quTazQAsvguAURP8ov+
         dS5nwZYwtDP66L4hlV7E3KyWPEJvPIAN1HyHjPwVeEH2QccdaTwFtGQ+PnS0jFBQIQmz
         z3tAGlIm99Yi0yUMyAK+QATsHoTI0s30qwTbwJTjpk5Gcz9yxtHWp3UXSvJ6Be067Bzv
         XD8s8LONn68SV/jNv5lo6Kni0M9Wj6ufzQMEzKY8F+3Td8k0WpY/m95ema/tRTPrAo/Q
         tDs7Xk8vjecT0j5LN31gNYETp2h+t3kU+xo9C/j7VbwOnmmWNLlurB+1fPlNES0tpmPx
         Vy6w==
X-Gm-Message-State: ACrzQf1+q595XqTeoEAv/zjp9uMczqeXc8jeS1EjxIb3ffYoC81E0C4V
        HktcaDRQqdquVN8Nde68uw+MiA==
X-Google-Smtp-Source: AMsMyM4q4OHE6RmbiZDYRwiXOXmCru6tDJV/srJq2vODKrrYg75XoI6m51lSA+DN0/3zGGraIQKS0A==
X-Received: by 2002:a05:600c:3d8a:b0:3c6:f241:cb36 with SMTP id bi10-20020a05600c3d8a00b003c6f241cb36mr1993088wmb.115.1666782145763;
        Wed, 26 Oct 2022 04:02:25 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d44c7000000b0023672104c24sm5237415wrr.74.2022.10.26.04.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:02:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 3/6] soundwire: qcom: remove unused SWRM_SPECIAL_CMD_ID
Date:   Wed, 26 Oct 2022 12:02:07 +0100
Message-Id: <20221026110210.6575-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
References: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index cee2b2223141..7bc8cd0e906b 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -104,7 +104,6 @@
 #define SWRM_REG_VAL_PACK(data, dev, id, reg)	\
 			((reg) | ((id) << 16) | ((dev) << 20) | ((data) << 24))
 
-#define SWRM_SPECIAL_CMD_ID	0xF
 #define MAX_FREQ_NUM		1
 #define TIMEOUT_MS		100
 #define QCOM_SWRM_MAX_RD_LEN	0x1
-- 
2.21.0

