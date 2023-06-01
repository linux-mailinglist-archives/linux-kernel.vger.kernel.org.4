Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B547199AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjFAK1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjFAK0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:26:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C70171D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:25:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f850b32caso91517866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685615128; x=1688207128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Biydlf7PIGQ7H2/3MOSbK0GWIW8cjwIGbXqmPIt7ZJ8=;
        b=gmeGoT8OHlZgbn+14JgZQxDwt4oFmVtRUNaFe9JQFXp11mJL0oa7mHcHcMHdcLoWWU
         6GeY4xGQ7rX8jKxEGb8XOlqxV3drixKvl4jyK9ziTlW8RwLo7EIYRMjLhb4QLzLWKids
         MhSkPlaF50xsVbywzC1461158Ea86YsxyPuxlXGmvsM4ZJpXRXRhOwcWrOkPwEkoVU09
         z13bpTcElB3Tv5tW4qDW5e+8S/699KeSHrRT5JVrAc8FDAZ+toX3Yvbp+4DZreCAIMnN
         vo3DeqtKpXZL8sMhUKtPN+3iDcr3E0JR9kaTj0oDGou+ntk1dBJMb7PexIOH4vQoYrnh
         SqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685615129; x=1688207129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Biydlf7PIGQ7H2/3MOSbK0GWIW8cjwIGbXqmPIt7ZJ8=;
        b=TT5E11xE8znJyUkYKibyf46TbQat/BAwZJbLkyIibERpxgZ0ZR11NZygW9QeUedviU
         d269ZVWt+5AkkBdTkQF33JoXGpRwiiSZf7ZBYZDw9VVrsPnok7s4tvIGb/RNpIgYdCoq
         L7eLS3lD4JWUWwI92tXXu4UrPz6YFFSqql0k5WBZGcNNVdiq4IYPLSrDbuaxXPgt7qYN
         qV83AMPWCk/7KMZweB1wGETmafVTlQOCP5IBngEEp6+NKRmiqvVyI2sB68lav0VHuXC5
         epLYBcA77e/x56RM0OhzOArAz+MPLoYTXaxoqz9RYOmEQapV8Rl5rhvdWf9jzS/wfz4H
         ipHA==
X-Gm-Message-State: AC+VfDxb2OkM0xHg474CnftBJ6vG0vYGwaItgS9eaGjgoGkaLkwqtgS7
        C1YjOZ3hBxOZP1FeOR3R1tMg2A==
X-Google-Smtp-Source: ACHHUZ5m3bbTuSL6NcGE8tNmlnw3gV+4MJQV0FHwNUM7U8AKi7QylF5r3rjXHxygr3xpmsbU/xYORw==
X-Received: by 2002:a17:906:fd8b:b0:96a:3e39:f567 with SMTP id xa11-20020a170906fd8b00b0096a3e39f567mr7427867ejb.47.1685615128682;
        Thu, 01 Jun 2023 03:25:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id dk5-20020a170906f0c500b00965b2d3968csm10247758ejb.84.2023.06.01.03.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 03:25:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] soundwire: qcom: fix storing port config out-of-bounds
Date:   Thu,  1 Jun 2023 12:25:25 +0200
Message-Id: <20230601102525.609627-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'qcom_swrm_ctrl->pconfig' has size of QCOM_SDW_MAX_PORTS (14),
however we index it starting from 1, not 0, to match real port numbers.
This can lead to writing port config past 'pconfig' bounds and
overwriting next member of 'qcom_swrm_ctrl' struct.  Reported also by
smatch:

  drivers/soundwire/qcom.c:1269 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14

Fixes: 9916c02ccd74 ("soundwire: qcom: cleanup internal port config indexing")
Cc: <stable@vger.kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202305201301.sCJ8UDKV-lkp@intel.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/qcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 7cb1b7eba814..88a772075907 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -202,7 +202,8 @@ struct qcom_swrm_ctrl {
 	u32 intr_mask;
 	u8 rcmd_id;
 	u8 wcmd_id;
-	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
+	/* Port numbers are 1 - 14 */
+	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS + 1];
 	struct sdw_stream_runtime *sruntime[SWRM_MAX_DAIS];
 	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	int (*reg_read)(struct qcom_swrm_ctrl *ctrl, int reg, u32 *val);
-- 
2.34.1

