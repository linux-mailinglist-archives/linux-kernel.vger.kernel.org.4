Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633BD6E6C87
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDRTBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjDRTBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:01:50 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4005FFB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:49 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-51f10b8b27dso568654a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681844509; x=1684436509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2+l5nGu/U3DhJVr26RDR7VgHp3VrT06TGinEZDtaPo=;
        b=K90yjW6lbljyadjV0UJ8p4j/Mt3hpNY1tOpdfG8MTeiBY75deOi153Pkgyk1DoRI1E
         KauCunGjIEicg8ES4Pn00k0CDq0IIMCjJRUx5wTLZ5hoXGbZy+WkHUsKpC8+JnQ12kn+
         EJ/atimtEQwLVKkeAz+HDJSx+HXx6Tyo/OYciCCxhhlalByTv/9jgXgJ60XAiw3nIhpj
         ZgKLR5MU532P2ZLixs500JSQr4QBnv0vmaWUnRps22iukd1CbLpk4ym7gXy87jbnDo42
         06u++dZrMZVU65bqio2cJBsNXOY3agTi1Huwa+aieVFQ8a4WS+d/VgfWbL/RN5IwR10p
         K8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681844509; x=1684436509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2+l5nGu/U3DhJVr26RDR7VgHp3VrT06TGinEZDtaPo=;
        b=fImZXbtOB9r5uEzEWGnSs+FTX/LbyWRwH8cQMvpLQIc11eijH8vGIvT2cvn3mxYBOc
         F5RZ64WzUT/jPniSYJ9ytEcIZX/l9HC/GTOnaz1GnYFJda2/x2WQ87H4dFJKax6pkAjZ
         PjbXYcXwa7jIYp9BaTuoiH17XJ/WwrR9qrwH8VbMSxFzfKmu/oICk18PwJMZ+NcG2Bip
         Z5Erxfr94HkJ5LC4v0OXXa1UfwF7XytOPlzTvm0cY41YHLaLxtP/44+HMZm7h1yQwO/y
         oSTL/pkslLciejyZzXpqF6gkUE0D6x5FqroRGqSxLMNSwogtLVL4XmPxi20DCEfBL2Iy
         lqyw==
X-Gm-Message-State: AAQBX9eyRn4b56uQ4NA4IqR/DheRrrQw6TNN2QVIIOTgpF2G3fHBSzsy
        l6QUwiAwvbhbdxe21oYlyUv35Du8BqmqoA==
X-Google-Smtp-Source: AKy350al4jRaJtUaxOxGMHFbkPtkTIazmcAR/oTLEX48WJA9+S9RRnXcjeUR5tprXhryROCmLYGtzQv3TiEzOA==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a63:1f1a:0:b0:50c:bde:50c7 with SMTP id
 f26-20020a631f1a000000b0050c0bde50c7mr886192pgf.12.1681844508984; Tue, 18 Apr
 2023 12:01:48 -0700 (PDT)
Date:   Tue, 18 Apr 2023 19:00:56 +0000
In-Reply-To: <20230418190101.696345-1-pranavpp@google.com>
Mime-Version: 1.0
References: <20230418190101.696345-1-pranavpp@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418190101.696345-2-pranavpp@google.com>
Subject: [PATCH 1/6] scsi: pm80xx: Log some HW events by default
From:   Pranav Prasad <pranavpp@google.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akshat Jain <akshatzen@google.com>,
        Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshat Jain <akshatzen@google.com>

Log the following hw_event logs under EVENT log severity
to help debug disk issues:
  HW_EVENT_LINK_ERR_INVALID_DWORD
  HW_EVENT_LINK_ERR_DISPARITY_ERROR
  HW_EVENT_LINK_ERR_CODE_VIOLATION
  HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH
  HW_EVENT_LINK_ERR_PHY_RESET_FAILED
  HW_EVENT_INBOUND_CRC_ERROR
  HW_EVENT_PHY_ERROR
  HW_EVENT_SAS_PHY_UP
  HW_EVENT_SATA_PHY_UP
  HW_EVENT_SATA_SPINUP_HOLD
  HW_EVENT_PHY_DOWN
  HW_EVENT_PORT_INVALID
  HW_EVENT_MALFUNCTION
  HW_EVENT_PORT_RESET_TIMER_TMO
  HW_EVENT_PORT_RECOVERY_TIMER_TMO
  HW_EVENT_HARD_RESET_RECEIVED
  HW_EVENT_ID_FRAME_TIMEOUT
  HW_EVENT_PORT_RECOVER

Signed-off-by: Akshat Jain <akshatzen@google.com>
Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 drivers/scsi/pm8001/pm8001_init.c |  3 +-
 drivers/scsi/pm8001/pm8001_sas.h  |  1 +
 drivers/scsi/pm8001/pm80xx_hwi.c  | 72 ++++++++++++++++++++-----------
 3 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 7e589fe3e010..d8dc629c0efb 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -43,7 +43,8 @@
 #include "pm8001_chips.h"
 #include "pm80xx_hwi.h"
 
-static ulong logging_level = PM8001_FAIL_LOGGING | PM8001_IOERR_LOGGING;
+static ulong logging_level = PM8001_FAIL_LOGGING | PM8001_IOERR_LOGGING |
+							 PM8001_EVENT_LOGGING;
 module_param(logging_level, ulong, 0644);
 MODULE_PARM_DESC(logging_level, " bits for enabling logging info.");
 
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index dc1f4d958e03..953572fc0d9e 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -71,6 +71,7 @@
 #define PM8001_DEV_LOGGING	0x80 /* development message logging */
 #define PM8001_DEVIO_LOGGING	0x100 /* development io message logging */
 #define PM8001_IOERR_LOGGING	0x200 /* development io err message logging */
+#define PM8001_EVENT_LOGGING	0x400 /* HW event logging */
 
 #define pm8001_info(HBA, fmt, ...)					\
 	pr_info("%s:: %s %d: " fmt,					\
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 9584cadc4201..ce6a442d2418 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3425,26 +3425,31 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	switch (eventType) {
 
 	case HW_EVENT_SAS_PHY_UP:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PHY_START_STATUS\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_SAS_PHY_UP phyid:%#x\n", phy_id);
 		hw_event_sas_phy_up(pm8001_ha, piomb);
 		break;
 	case HW_EVENT_SATA_PHY_UP:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_SATA_PHY_UP\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_SATA_PHY_UP phyid:%#x\n", phy_id);
 		hw_event_sata_phy_up(pm8001_ha, piomb);
 		break;
 	case HW_EVENT_SATA_SPINUP_HOLD:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_SATA_SPINUP_HOLD\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_SATA_SPINUP_HOLD phyid:%#x\n", phy_id);
 		sas_notify_phy_event(&phy->sas_phy, PHYE_SPINUP_HOLD,
 			GFP_ATOMIC);
 		break;
 	case HW_EVENT_PHY_DOWN:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PHY_DOWN\n");
+		pm8001_dbg(pm8001_ha, EVENT, "HW_EVENT_PHY_DOWN phyid:%#x\n",
+			   phy_id);
 		hw_event_phy_down(pm8001_ha, piomb);
 		phy->phy_attached = 0;
 		phy->phy_state = PHY_LINK_DISABLE;
 		break;
 	case HW_EVENT_PORT_INVALID:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PORT_INVALID\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_PORT_INVALID phyid:%#x\n", phy_id);
 		sas_phy_disconnected(sas_phy);
 		phy->phy_attached = 0;
 		sas_notify_port_event(sas_phy, PORTE_LINK_RESET_ERR,
@@ -3463,7 +3468,8 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			GFP_ATOMIC);
 		break;
 	case HW_EVENT_PHY_ERROR:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PHY_ERROR\n");
+		pm8001_dbg(pm8001_ha, EVENT, "HW_EVENT_PHY_ERROR phyid:%#x\n",
+			   phy_id);
 		sas_phy_disconnected(&phy->sas_phy);
 		phy->phy_attached = 0;
 		sas_notify_phy_event(&phy->sas_phy, PHYE_OOB_ERROR, GFP_ATOMIC);
@@ -3477,34 +3483,39 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			GFP_ATOMIC);
 		break;
 	case HW_EVENT_LINK_ERR_INVALID_DWORD:
-		pm8001_dbg(pm8001_ha, MSG,
-			   "HW_EVENT_LINK_ERR_INVALID_DWORD\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_LINK_ERR_INVALID_DWORD phyid:%#x\n",
+			   phy_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_LINK_ERR_INVALID_DWORD, port_id, phy_id, 0, 0);
 		break;
 	case HW_EVENT_LINK_ERR_DISPARITY_ERROR:
-		pm8001_dbg(pm8001_ha, MSG,
-			   "HW_EVENT_LINK_ERR_DISPARITY_ERROR\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_LINK_ERR_DISPARITY_ERROR phyid:%#x\n",
+			   phy_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_LINK_ERR_DISPARITY_ERROR,
 			port_id, phy_id, 0, 0);
 		break;
 	case HW_EVENT_LINK_ERR_CODE_VIOLATION:
-		pm8001_dbg(pm8001_ha, MSG,
-			   "HW_EVENT_LINK_ERR_CODE_VIOLATION\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_LINK_ERR_CODE_VIOLATION phyid:%#x\n",
+			   phy_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_LINK_ERR_CODE_VIOLATION,
 			port_id, phy_id, 0, 0);
 		break;
 	case HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH:
-		pm8001_dbg(pm8001_ha, MSG,
-			   "HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH phyid:%#x\n",
+			   phy_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH,
 			port_id, phy_id, 0, 0);
 		break;
 	case HW_EVENT_MALFUNCTION:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_MALFUNCTION\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_MALFUNCTION phyid:%#x\n", phy_id);
 		break;
 	case HW_EVENT_BROADCAST_SES:
 		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_BROADCAST_SES\n");
@@ -3515,25 +3526,29 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			GFP_ATOMIC);
 		break;
 	case HW_EVENT_INBOUND_CRC_ERROR:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_INBOUND_CRC_ERROR\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_INBOUND_CRC_ERROR phyid:%#x\n", phy_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_INBOUND_CRC_ERROR,
 			port_id, phy_id, 0, 0);
 		break;
 	case HW_EVENT_HARD_RESET_RECEIVED:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_HARD_RESET_RECEIVED\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_HARD_RESET_RECEIVED phyid:%#x\n", phy_id);
 		sas_notify_port_event(sas_phy, PORTE_HARD_RESET, GFP_ATOMIC);
 		break;
 	case HW_EVENT_ID_FRAME_TIMEOUT:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_ID_FRAME_TIMEOUT\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_ID_FRAME_TIMEOUT phyid:%#x\n", phy_id);
 		sas_phy_disconnected(sas_phy);
 		phy->phy_attached = 0;
 		sas_notify_port_event(sas_phy, PORTE_LINK_RESET_ERR,
 			GFP_ATOMIC);
 		break;
 	case HW_EVENT_LINK_ERR_PHY_RESET_FAILED:
-		pm8001_dbg(pm8001_ha, MSG,
-			   "HW_EVENT_LINK_ERR_PHY_RESET_FAILED\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_LINK_ERR_PHY_RESET_FAILED phyid:%#x\n",
+			   phy_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_LINK_ERR_PHY_RESET_FAILED,
 			port_id, phy_id, 0, 0);
@@ -3543,7 +3558,9 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			GFP_ATOMIC);
 		break;
 	case HW_EVENT_PORT_RESET_TIMER_TMO:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PORT_RESET_TIMER_TMO\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_PORT_RESET_TIMER_TMO phyid:%#x\n",
+			   phy_id);
 		if (!pm8001_ha->phy[phy_id].reset_completion) {
 			pm80xx_hw_event_ack_req(pm8001_ha, 0, HW_EVENT_PHY_DOWN,
 				port_id, phy_id, 0, 0);
@@ -3560,8 +3577,9 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		}
 		break;
 	case HW_EVENT_PORT_RECOVERY_TIMER_TMO:
-		pm8001_dbg(pm8001_ha, MSG,
-			   "HW_EVENT_PORT_RECOVERY_TIMER_TMO\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_PORT_RECOVERY_TIMER_TMO phyid:%#x\n",
+			   phy_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_PORT_RECOVERY_TIMER_TMO,
 			port_id, phy_id, 0, 0);
@@ -3575,11 +3593,15 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		}
 		break;
 	case HW_EVENT_PORT_RECOVER:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PORT_RECOVER\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_PORT_RECOVER phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		hw_event_port_recover(pm8001_ha, piomb);
 		break;
 	case HW_EVENT_PORT_RESET_COMPLETE:
-		pm8001_dbg(pm8001_ha, MSG, "HW_EVENT_PORT_RESET_COMPLETE\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_PORT_RESET_COMPLETE phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		if (pm8001_ha->phy[phy_id].reset_completion) {
 			pm8001_ha->phy[phy_id].port_reset_status =
 					PORT_RESET_SUCCESS;
-- 
2.40.0.634.g4ca3ef3211-goog

