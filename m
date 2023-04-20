Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7B6E8FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjDTKS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjDTKRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:17:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A67EE7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:16:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bbdbso682327a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681985790; x=1684577790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxQN4hZ4JVSgplNB9vM+TACxEqA37qdo6fBUY/Qfhug=;
        b=ZdhT1l/Ewnw8PJH9WHmYU66panGvAGmseKsA1QI14AcHKVjKMxVnU3LzsyflnJaSsT
         0SsaSKbcWs7WckSg27jljRg6VV3DwqhpTLP6IQGi/ukXFFUEFcPf77aJPNk1r6zWsAej
         9naiRVNvRcz5F/OBPqzOYQqWgb9MZD3r9qf94IrZh9CvL8ZXCvkjTR+YO2hbADbWUKv2
         ATvis3qRCxbidFKHfTut9rMBICDy00uRi9OXLFLIijGALI+2XDJdj8NJtdDDNAw5xgeF
         S4oFzhhbIZ37jr7lIrwpStGblZyQ9UE3jwRtyUfVymNzKv5D2vUZWLGXgfJtzCSOUzME
         rw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985790; x=1684577790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxQN4hZ4JVSgplNB9vM+TACxEqA37qdo6fBUY/Qfhug=;
        b=Xe580JwUB64SWe8DLyqvR+lI300/JbVwACVQstrkpjNfs/I/vdPAoS5eI/k/5I6C+o
         wJj8iRA5yOgyHL0Y8tQKuzdM2FBElcmjOxK6Z2lIWykrfT0HoW6CdJpdbEhqMlvsuveR
         oceqifwNbAOdMXs037QbgWI37PhcD06M/j19r2n5U1TnXua3n7/lECcnfPnmRqJd9wFK
         m+FaRWswLtWBOKptzmGW5ol2AfiT1v6Ibg7MLBsh3fAoiPU+yZFBb0f3sdTPZ3BDi93e
         ZOj/BpRr119Fgoez08D6QOb40OG5qvDLXKdrcSlg7ZK+BU0HWhWTK1wtFgeYAWw2Jswb
         213w==
X-Gm-Message-State: AAQBX9dlTjJwMQvEKQaGcgeuKgZ9RBgntE2KqCJ6feiGidDhXYn4L4CJ
        sfrfA0g1bLt4YmCqLJW01VJHU0FhW5FyvJ5UmkkgeQ==
X-Google-Smtp-Source: AKy350ZGpkQT2xEEpIlm7akllE9wiybPG/3gcFKmyhXXX82oydlx7HcP+cAwnEryxuxKBnISy8rfiQ==
X-Received: by 2002:aa7:d78d:0:b0:506:be3f:ebb5 with SMTP id s13-20020aa7d78d000000b00506be3febb5mr1365210edq.1.1681985790496;
        Thu, 20 Apr 2023 03:16:30 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id l22-20020aa7c3d6000000b00506be898998sm588954edr.29.2023.04.20.03.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:16:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Patrick Lai <quic_plai@quicinc.com>
Subject: [PATCH 6/6] soundwire: qcom: do not probe devices before bus/link init
Date:   Thu, 20 Apr 2023 12:16:17 +0200
Message-Id: <20230420101617.142225-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
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

Soundwire devices are supposed to be kept in reset state (powered off)
till their probe() or component bind() callbacks.  However if they are
already powered on, then they might enumerate before the master
initializes bus in qcom_swrm_init() leading to occasional errors like:

  qcom-soundwire 6d30000.soundwire-controller: Qualcomm Soundwire controller v2.0.0 Registered
  wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:4 (ops wcd938x_sdw_component_ops)
  wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:3 (ops wcd938x_sdw_component_ops)
  qcom-soundwire 6ad0000.soundwire-controller: swrm_wait_for_wr_fifo_avail err write overflow

The problem primarily lies in Qualcomm Soundwire controller probe() sequence:
1. request_threaded_irq()
2. sdw_bus_master_add() - which will cause probe() and component bind()
   of Soundwire devices, e.g. WCD938x codec drivers.  Device drivers
   might already start accessing their registers.
3. qcom_swrm_init() - which initializes the link/bus and enables
   interrupts.

Any access to device registers at (2) above, will fail because link/bus
is not yet initialized.

However the fix is not as simple as moving qcom_swrm_init() before
sdw_bus_master_add(), because this will cause early interrupt of new
slave attached.  The interrupt handler expects bus master (ctrl->bus.md)
to be allocated, so this would lead to NULL pointer exception.

Rework the init sequence and change the interrupt handler.  The correct
sequence fixing accessing device registers before link init is now:
1. qcom_swrm_init()
2. request_threaded_irq()
3. sdw_bus_master_add()
which still might cause early interrupts, if Soundwire devices are not
in powered off state before their probe.  This early interrupt issue is
fixed by checking if bus master (ctrl->bus.md) was allocated and if not,
scheduling delayed work for enumerating the slave device.  Since we
actually can handle early interrupt now, drop IRQF_TRIGGER_RISING flag
from the interrupt, because it is not really valid and driver should use
flags provided by DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Change context depends on:
https://lore.kernel.org/r/20230209131336.18252-3-srinivas.kandagatla@linaro.org
https://lore.kernel.org/all/20230418095447.577001-1-krzysztof.kozlowski@linaro.org/

Cc: Patrick Lai <quic_plai@quicinc.com>
---
 drivers/soundwire/qcom.c | 89 ++++++++++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 17 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 679990dc3cc4..802d939ce7aa 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -19,6 +19,7 @@
 #include <linux/slimbus.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
+#include <linux/workqueue.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "bus.h"
@@ -187,6 +188,7 @@ struct qcom_swrm_ctrl {
 #endif
 	struct completion broadcast;
 	struct completion enumeration;
+	struct delayed_work new_slave_work;
 	/* Port alloc/free lock */
 	struct mutex port_lock;
 	struct clk *hclk;
@@ -606,6 +608,37 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
 	return 0;
 }
 
+static void qcom_swrm_new_slave(struct work_struct *work)
+{
+	struct qcom_swrm_ctrl *ctrl = container_of(work, struct qcom_swrm_ctrl,
+						   new_slave_work.work);
+
+	/*
+	 * All Soundwire slave deviecs are expected to be in reset state (powered down)
+	 * during sdw_bus_master_add().  The slave device should be brougth
+	 * from reset by its probe() or bind() function, as a result of
+	 * sdw_bus_master_add().
+	 * Add a simple check to avoid NULL pointer except on early interrupts.
+	 * Note that if this condition happens, the slave device will not be
+	 * enumerated. Its driver should be fixed.
+	 *
+	 * smp_load_acquire() paired with sdw_master_device_add().
+	 */
+	if (!smp_load_acquire(&ctrl->bus.md)) {
+		dev_err(ctrl->dev,
+			"Got unexpected, early interrupt, device will not be enumerated\n");
+		return;
+	}
+
+	clk_prepare_enable(ctrl->hclk);
+
+	qcom_swrm_get_device_status(ctrl);
+	qcom_swrm_enumerate(&ctrl->bus);
+	sdw_handle_slave_status(&ctrl->bus, ctrl->status);
+
+	clk_disable_unprepare(ctrl->hclk);
+};
+
 static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
 {
 	struct qcom_swrm_ctrl *ctrl = dev_id;
@@ -668,9 +701,17 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 					dev_dbg(ctrl->dev, "Slave status not changed %x\n",
 						slave_status);
 				} else {
-					qcom_swrm_get_device_status(ctrl);
-					qcom_swrm_enumerate(&ctrl->bus);
-					sdw_handle_slave_status(&ctrl->bus, ctrl->status);
+					unsigned long delay = 0;
+
+					/*
+					 * See qcom_swrm_new_slave() for
+					 * explanation. smp_load_acquire() paired
+					 * with sdw_master_device_add().
+					 */
+					if (!smp_load_acquire(&ctrl->bus.md))
+						delay = 10;
+					schedule_delayed_work(&ctrl->new_slave_work,
+							      delay);
 				}
 				break;
 			case SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET:
@@ -780,6 +821,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 
 	ctrl->intr_mask = SWRM_INTERRUPT_STATUS_RMSK;
 	/* Mask soundwire interrupts */
+
 	if (ctrl->version < SWRM_VERSION_2_0_0)
 		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
 				SWRM_INTERRUPT_STATUS_RMSK);
@@ -1485,6 +1527,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	mutex_init(&ctrl->port_lock);
 	init_completion(&ctrl->broadcast);
 	init_completion(&ctrl->enumeration);
+	INIT_DELAYED_WORK(&ctrl->new_slave_work, qcom_swrm_new_slave);
 
 	ctrl->bus.ops = &qcom_swrm_ops;
 	ctrl->bus.port_ops = &qcom_swrm_port_ops;
@@ -1514,9 +1557,10 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 
 	ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &ctrl->version);
 
+	qcom_swrm_init(ctrl);
+
 	ret = devm_request_threaded_irq(dev, ctrl->irq, NULL,
 					qcom_swrm_irq_handler,
-					IRQF_TRIGGER_RISING |
 					IRQF_ONESHOT,
 					"soundwire", ctrl);
 	if (ret) {
@@ -1524,18 +1568,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	ctrl->wake_irq = of_irq_get(dev->of_node, 1);
-	if (ctrl->wake_irq > 0) {
-		ret = devm_request_threaded_irq(dev, ctrl->wake_irq, NULL,
-						qcom_swrm_wake_irq_handler,
-						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-						"swr_wake_irq", ctrl);
-		if (ret) {
-			dev_err(dev, "Failed to request soundwire wake irq\n");
-			goto err_init;
-		}
-	}
-
 	pm_runtime_set_autosuspend_delay(dev, 3000);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_mark_last_busy(dev);
@@ -1549,7 +1581,18 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	qcom_swrm_init(ctrl);
+	ctrl->wake_irq = of_irq_get(dev->of_node, 1);
+	if (ctrl->wake_irq > 0) {
+		ret = devm_request_threaded_irq(dev, ctrl->wake_irq, NULL,
+						qcom_swrm_wake_irq_handler,
+						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+						"swr_wake_irq", ctrl);
+		if (ret) {
+			dev_err(dev, "Failed to request soundwire wake irq\n");
+			goto err_init;
+		}
+	}
+
 	wait_for_completion_timeout(&ctrl->enumeration,
 				    msecs_to_jiffies(TIMEOUT_MS));
 	ret = qcom_swrm_register_dais(ctrl);
@@ -1589,6 +1632,18 @@ static int qcom_swrm_remove(struct platform_device *pdev)
 {
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
 
+	/*
+	 * Mask interrupts to be sure no delayed work can be scheduler after
+	 * removing Soundwire bus master.
+	 */
+	if (ctrl->version < SWRM_VERSION_2_0_0)
+		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
+				0);
+	if (ctrl->mmio)
+		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
+				0);
+
+	cancel_delayed_work_sync(&ctrl->new_slave_work);
 	sdw_bus_master_delete(&ctrl->bus);
 	clk_disable_unprepare(ctrl->hclk);
 
-- 
2.34.1

