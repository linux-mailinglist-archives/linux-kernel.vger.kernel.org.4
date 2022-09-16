Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CBD5BAEA3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiIPNyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiIPNyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:54:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D67AE87F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:53:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r5-20020a1c4405000000b003b494ffc00bso1236963wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=VyGv9vQBQ1xkHEaxOJIptX4tbCMnxfIpZYjINCvRYgM=;
        b=JBQnB7TWIBIwF9Lw0s2MP3HKz7duEZi8DDiZEqmm+5O2d1a/3PccKRGMefwnZK4hxA
         grI6/ptDhYWBbo/8uMXmoV2+CXV0EofMC8LM5thFf1r0ne0yr5Gxr0SK+8E02t7Yb/Zf
         zo0NSapqKJ/Ogy6YFSCpoVYXspbPulPf8bEWe+wpOCpmpbMCT6AuoEfECm3RNwTu/VFX
         pql62QumkOU8VuOlvi5H2U9d1MsP7tBOayQJSKcaHJETs81nzH3rDHyf8sER7DOMlHxR
         GiB4/M3s4fS6cGCKA5n4bpujXgaYrIlGPdjbD3yMTHuao0oxR+fTE8adsTEutK1uRZ9S
         2BSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=VyGv9vQBQ1xkHEaxOJIptX4tbCMnxfIpZYjINCvRYgM=;
        b=EJxocVfuPFIndzj3lYiXXiN2jEdEP57ezauENSHSOjrO0x3wQkzQeceLaOqgC4RVmD
         UmKiy/lcpoFR58MMVlWEZz1Qxk+6zAeGSthOqyNQGYH4OjMeHtS+N+Ej1nlovO1Vj3A1
         h4uZvdzT7fv619VbybvrXOqlmIvjpQkJqlnPX8wjVEjSfLz+9EG/P+UchzeoNEaWXJ3I
         dO4PtwlHhGG/elHl3vJqK75Zp1bDu0BAq/0Zx9CEjy3reqJiA36dnD9Srn+638zuoU71
         tTRD6ARwOhvvWEOHL/ft1hdgQCz7x5KwjrXRZz0DyGVmgclfuAEHpqQP6NQx1+ivA6ZZ
         RkXQ==
X-Gm-Message-State: ACrzQf08h8ls+gPt4LsmsmLl8Qyq9LCqDvU7topTIQpVdTFp5R6aDZ2W
        lfp9dbAXIlpU4h5xhbdEjPaIDw==
X-Google-Smtp-Source: AMsMyM5F1iDDMpOc25/B4rrtE9piDv1R7mtcHiPz7EsAWBn3EJ3+mS9oezISk77bPzq6/GOb+nAodA==
X-Received: by 2002:a05:600c:114f:b0:3b4:9a0a:6204 with SMTP id z15-20020a05600c114f00b003b49a0a6204mr3490349wmz.132.1663336434900;
        Fri, 16 Sep 2022 06:53:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id m2-20020a7bce02000000b003b483000583sm2084767wmc.48.2022.09.16.06.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:53:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/2] soundwire: qcom: update status from device id 1
Date:   Fri, 16 Sep 2022 14:53:51 +0100
Message-Id: <20220916135352.19114-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default autoenumeration is enabled on QCom SoundWire controller
which means the core should not be dealing with device 0 w.r.t enumeration.

During Enumeration if SoundWire core sees status[0] as SDW_SLAVE_ATTACHED and
start programming the device id, however reading DEVID registers return zeros
which does not match to any of the slaves in the list and the core attempts
to park this device to Group 13.  This results in adding SoundWire device
with enumeration address 0:0:0:0

Fix this by not passing device 0 status to SoundWire core.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	- updated change log and split patch in to two as suggested by Pierre

 drivers/soundwire/qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index e7f95c41eb70..d3ce580cdeaf 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -448,7 +448,7 @@ static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
 	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
 	ctrl->slave_status = val;
 
-	for (i = 0; i <= SDW_MAX_DEVICES; i++) {
+	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
 		u32 s;
 
 		s = (val >> (i * 2));
-- 
2.21.0

