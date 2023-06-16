Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83587326DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbjFPFxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjFPFxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:53:05 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F212D58
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:53:03 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 88E131A06B6;
        Fri, 16 Jun 2023 07:43:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 260A41A05B8;
        Fri, 16 Jun 2023 07:43:04 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 21477181D0C0;
        Fri, 16 Jun 2023 13:43:03 +0800 (+08)
From:   Alison Wang <alison.wang@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com, Alison Wang <alison.wang@nxp.com>
Subject: [PATCH 3/8] ethosu: Add inference type option for model and op
Date:   Fri, 16 Jun 2023 13:59:08 +0800
Message-Id: <20230616055913.2360-4-alison.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616055913.2360-1-alison.wang@nxp.com>
References: <20230616055913.2360-1-alison.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds inference type option for model and op.

Signed-off-by: Feng Guo <feng.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/ethosu/ethosu_core_interface.h |  6 +++++-
 drivers/firmware/ethosu/ethosu_inference.c      | 14 +++++++++++++-
 drivers/firmware/ethosu/ethosu_inference.h      |  1 +
 drivers/firmware/ethosu/ethosu_rpmsg.c          |  4 +++-
 drivers/firmware/ethosu/ethosu_rpmsg.h          |  3 ++-
 drivers/firmware/ethosu/uapi/ethosu.h           | 11 ++++++++++-
 6 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/ethosu/ethosu_core_interface.h b/drivers/firmware/ethosu/ethosu_core_interface.h
index ef63c3b55352..b60508e4792f 100644
--- a/drivers/firmware/ethosu/ethosu_core_interface.h
+++ b/drivers/firmware/ethosu/ethosu_core_interface.h
@@ -35,13 +35,16 @@ namespace EthosU {
 #define ETHOSU_CORE_BUFFER_MAX 16
 
 /** Maximum number of PMU counters to be returned for inference */
-#define ETHOSU_CORE_PMU_MAX 8
+#define ETHOSU_CORE_PMU_MAX 4
 
 #define ETHOSU_CORE_MSG_MAGIC 0x41457631
 #define ETHOSU_CORE_MSG_VERSION_MAJOR 0
 #define ETHOSU_CORE_MSG_VERSION_MINOR 2
 #define ETHOSU_CORE_MSG_VERSION_PATCH 0
 
+#define ETHOSU_CORE_INFERENCE_MODEL 0
+#define ETHOSU_CORE_INFERENCE_OP    1
+
 /**
  * enum ethosu_core_msg_type - Message types
  *
@@ -107,6 +110,7 @@ struct ethosu_core_inference_req {
 	struct ethosu_core_buffer network;
 	uint8_t                   pmu_event_config[ETHOSU_CORE_PMU_MAX];
 	uint32_t                  pmu_cycle_counter_enable;
+	uint32_t                  inference_type;
 };
 
 struct ethosu_core_inference_rsp {
diff --git a/drivers/firmware/ethosu/ethosu_inference.c b/drivers/firmware/ethosu/ethosu_inference.c
index 853947a2334e..b5e94e19bce0 100644
--- a/drivers/firmware/ethosu/ethosu_inference.c
+++ b/drivers/firmware/ethosu/ethosu_inference.c
@@ -92,7 +92,8 @@ static int ethosu_inference_send(struct ethosu_inference *inf)
 				       inf->net->buf,
 				       inf->pmu_event_config,
 				       ETHOSU_PMU_EVENT_MAX,
-				       inf->pmu_cycle_counter_enable);
+				       inf->pmu_cycle_counter_enable,
+				       inf->inference_type);
 	if (ret)
 		return ret;
 
@@ -233,6 +234,17 @@ int ethosu_inference_create(struct ethosu_device *edev,
 	inf = devm_kzalloc(edev->dev, sizeof(*inf), GFP_KERNEL);
 	if (!inf)
 		return -ENOMEM;
+	switch (uapi->inference_type) {
+	case ETHOSU_UAPI_INFERENCE_MODEL:
+		inf->inference_type = ETHOSU_CORE_INFERENCE_MODEL;
+		break;
+	case ETHOSU_UAPI_INFERENCE_OP:
+		inf->inference_type = ETHOSU_CORE_INFERENCE_OP;
+		break;
+	default:
+		inf->inference_type = ETHOSU_CORE_INFERENCE_MODEL;
+		break;
+	}
 
 	inf->edev = edev;
 	inf->net = net;
diff --git a/drivers/firmware/ethosu/ethosu_inference.h b/drivers/firmware/ethosu/ethosu_inference.h
index 07370ca01f22..8414eadbda92 100644
--- a/drivers/firmware/ethosu/ethosu_inference.h
+++ b/drivers/firmware/ethosu/ethosu_inference.h
@@ -74,6 +74,7 @@ struct ethosu_inference {
 	uint32_t                pmu_event_count[ETHOSU_PMU_EVENT_MAX];
 	uint32_t                pmu_cycle_counter_enable;
 	uint64_t                pmu_cycle_counter_count;
+	uint32_t                inference_type;
 	struct list_head        list;
 };
 
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.c b/drivers/firmware/ethosu/ethosu_rpmsg.c
index cb7e4556f635..e4cf398468e4 100644
--- a/drivers/firmware/ethosu/ethosu_rpmsg.c
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.c
@@ -107,7 +107,8 @@ int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
 			   struct ethosu_buffer *network,
 			   uint8_t *pmu_event_config,
 			   uint8_t pmu_event_config_count,
-			   uint8_t pmu_cycle_counter_enable)
+			   uint8_t pmu_cycle_counter_enable,
+			   uint32_t inference_type)
 {
 	struct ethosu_core_msg msg = {
 		.magic  = ETHOSU_CORE_MSG_MAGIC,
@@ -132,6 +133,7 @@ int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
 	req.ifm_count = ifm_count;
 	req.ofm_count = ofm_count;
 	req.pmu_cycle_counter_enable = pmu_cycle_counter_enable;
+	req.inference_type = inference_type;
 
 	for (i = 0; i < ifm_count; i++)
 		ethosu_core_set_size(ifm[i], &req.ifm[i]);
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.h b/drivers/firmware/ethosu/ethosu_rpmsg.h
index dd08e0d7945b..a4a639997a26 100644
--- a/drivers/firmware/ethosu/ethosu_rpmsg.h
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.h
@@ -63,7 +63,8 @@ int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
 			   struct ethosu_buffer *network,
 			   uint8_t *pmu_event_config,
 			   uint8_t pmu_event_config_count,
-			   uint8_t pmu_cycle_counter_enable
+			   uint8_t pmu_cycle_counter_enable,
+			   uint32_t inference_type
 			   );
 
 int ethosu_rpmsg_init(struct ethosu_rpmsg *erp,
diff --git a/drivers/firmware/ethosu/uapi/ethosu.h b/drivers/firmware/ethosu/uapi/ethosu.h
index 903316dff7b3..c4a0df67336c 100644
--- a/drivers/firmware/ethosu/uapi/ethosu.h
+++ b/drivers/firmware/ethosu/uapi/ethosu.h
@@ -62,7 +62,7 @@ namespace EthosU {
 #define ETHOSU_FD_MAX                   16
 
 /* Maximum number of PMUs available */
-#define ETHOSU_PMU_EVENT_MAX             8
+#define ETHOSU_PMU_EVENT_MAX             4
 
 /****************************************************************************
  * Types
@@ -173,6 +173,14 @@ struct ethosu_uapi_device_capabilities {
 	__u32                            driver_major_rev;
 };
 
+/**
+ * enum ethosu_uapi_inference_type - Inference type
+ */
+enum ethosu_uapi_inference_type {
+	ETHOSU_UAPI_INFERENCE_MODEL = 0,
+	ETHOSU_UAPI_INFERENCE_OP
+};
+
 /**
  * struct ethosu_uapi_inference_create - Create network request
  * @ifm_count:		Number of IFM file descriptors
@@ -185,6 +193,7 @@ struct ethosu_uapi_inference_create {
 	__u32                         ifm_fd[ETHOSU_FD_MAX];
 	__u32                         ofm_count;
 	__u32                         ofm_fd[ETHOSU_FD_MAX];
+	enum ethosu_uapi_inference_type inference_type;
 	struct ethosu_uapi_pmu_config pmu_config;
 };
 
-- 
2.17.1

