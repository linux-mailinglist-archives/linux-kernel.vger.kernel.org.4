Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582D26FE59E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbjEJUvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbjEJUvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:51:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F6C9009;
        Wed, 10 May 2023 13:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 848246408D;
        Wed, 10 May 2023 20:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B480DC4339C;
        Wed, 10 May 2023 20:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683751809;
        bh=93lgawgCO2gOMpWhpKKpaOV53cDVxF7QwQnOJtQb0gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F30MMBJ0N9ODjnQya76KxLSs/GXj4jrzFso8CApCYPAYBLYBnWEusbyzIahmcjpZV
         8UOmo/18qqGs4QR4AevIn0SNInSU2ZuquU2eZbJBpT1eQzg3WTlDkmGrBxKS+UsKuR
         zGUguQjw1ilzeKdLTcUFDJIbSKMC2eNShYNTtTi3qyBLH1SwDCVqPeUsjUosEcMeKV
         0w6+lv0TFSsrKsz4K07LxevDMtWyQ2ERvcrkLec7rTd3IfVoleJGm8qyz2DrNZzchn
         atrOI0XzLEywNY4CdRhTSIgDGjd9IVqKxCHGavS2nX6DJdIsxfReR4DQTrEs8V4yQ9
         K+8cy8mb9sgHQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        agross@kernel.org, andersson@kernel.org,
        yung-chuan.liao@linux.intel.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 2/4] soundwire: qcom: gracefully handle too many ports in DT
Date:   Wed, 10 May 2023 16:50:06 -0400
Message-Id: <20230510205008.104981-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510205008.104981-1-sashal@kernel.org>
References: <20230510205008.104981-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 2367e0ecb498764e95cfda691ff0828f7d25f9a4 ]

There are two issues related to the number of ports coming from
Devicetree when exceeding in total QCOM_SDW_MAX_PORTS.  Both lead to
incorrect memory accesses:
1. With DTS having too big value of input or output ports, the driver,
   when copying port parameters from local/stack arrays into 'pconfig'
   array in 'struct qcom_swrm_ctrl', will iterate over their sizes.

2. If DTS also has too many parameters for these ports (e.g.
   qcom,ports-sinterval-low), the driver will overflow buffers on the
   stack when reading these properties from DTS.

Add a sanity check so incorrect DTS will not cause kernel memory
corruption.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230222144412.237832-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 500035a1fd460..e76d4cee5e7f4 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1142,6 +1142,9 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	ctrl->num_dout_ports = val;
 
 	nports = ctrl->num_dout_ports + ctrl->num_din_ports;
+	if (nports > QCOM_SDW_MAX_PORTS)
+		return -EINVAL;
+
 	/* Valid port numbers are from 1-14, so mask out port 0 explicitly */
 	set_bit(0, &ctrl->dout_port_mask);
 	set_bit(0, &ctrl->din_port_mask);
-- 
2.39.2

