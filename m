Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12A76E6C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjDRTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjDRTBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:01:53 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75293D7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:52 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5141c742deeso1368213a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681844512; x=1684436512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UH6ww4Tz5A/eOvsrLoChrvszKblTPJdXQlcphIuhfCY=;
        b=Xb4iQzwLgZfPoUAQ/odJ+uLwMle0vkgg1CXXGcy+pK4IK8a5OITSiML3yjC9GIz+vt
         LglJZm9VtSDzqZ6zL1EqEt//YrAIc9qzOjQ/2tZ4x7oofiN/UKfvvGMnN2CUSveDqTp6
         Y6qUOHeSTK7H8HaHkL7feME9f5tZs7Y8DwZU6DYL0318AK3qh4mgcbWpHQbX5KhiyX+O
         zYQQab4w/e+OfN5yF2Ok8eJA52iD/AwanOcagy49gu4uAoAf92SvPd5gx2lk/YadQ7fC
         sd9r05XEGj/lROATNCbm98AqauIDaEJBDeHgduuZza0Maqm4SQX/vyacsb0iuiGK5KI8
         Rfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681844512; x=1684436512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UH6ww4Tz5A/eOvsrLoChrvszKblTPJdXQlcphIuhfCY=;
        b=SSnRLX4hZpbPxt263YCj5XuV3pKwIBiR3xRBgSJHfZHr5pKBnnwQtDpii4Va4/ar8y
         3DgrPwuu4VeuDddS62l7OlPFLa2U3tEnEh6TVoFamSfGujTfT+xrKPtcPl3SNdS9XMAz
         QGbEweASgxkcVfGufqdjY/+gasODvNFyV2A+XwDJkCBfGfW26z5h9pfgCSmiuOH4WwKa
         Tw3qVkg4TLshkoyNkylIvMrEK1KjQbG6xHf2l9ovdYTDDcH41ggtK2t9g6ssL44/7BK4
         LPr+5YrCu2ArJGp1EycZ65SNMqptBLNqUF3NaGTKhHbiRQiaFdaXRQEm3/W51uU3f172
         Rwjg==
X-Gm-Message-State: AAQBX9d41vPavmmD/ifFlo0cL2p4Yk23tgIbzDn4bwtzBc+Oek8C/bdx
        w5FwmsGta+pZcr2gL+PY+8sufNR3zOfgcg==
X-Google-Smtp-Source: AKy350ahkWDCnkHAXgrxGxUl6RpviSG7+x8JdALBBOytT5BOZjwni8q2AuHP4V6HGxWCWoOKQscHCQMWeoHPkw==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a63:502:0:b0:520:6a0f:da2a with SMTP id
 2-20020a630502000000b005206a0fda2amr89585pgf.8.1681844512153; Tue, 18 Apr
 2023 12:01:52 -0700 (PDT)
Date:   Tue, 18 Apr 2023 19:00:58 +0000
In-Reply-To: <20230418190101.696345-1-pranavpp@google.com>
Mime-Version: 1.0
References: <20230418190101.696345-1-pranavpp@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418190101.696345-4-pranavpp@google.com>
Subject: [PATCH 3/6] scsi: pm80xx: Print port_id in HW events
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

Log port_id and phy_id along with the PHY_UP event.

Signed-off-by: Akshat Jain <akshatzen@google.com>
Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 58 ++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 61c1bf3d98a0..c5bf65d0ad14 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3426,30 +3426,35 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 
 	case HW_EVENT_SAS_PHY_UP:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_SAS_PHY_UP phyid:%#x\n", phy_id);
+			   "HW_EVENT_SAS_PHY_UP phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		hw_event_sas_phy_up(pm8001_ha, piomb);
 		break;
 	case HW_EVENT_SATA_PHY_UP:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_SATA_PHY_UP phyid:%#x\n", phy_id);
+			   "HW_EVENT_SATA_PHY_UP phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		hw_event_sata_phy_up(pm8001_ha, piomb);
 		break;
 	case HW_EVENT_SATA_SPINUP_HOLD:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_SATA_SPINUP_HOLD phyid:%#x\n", phy_id);
+			   "HW_EVENT_SATA_SPINUP_HOLD phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		sas_notify_phy_event(&phy->sas_phy, PHYE_SPINUP_HOLD,
 			GFP_ATOMIC);
 		break;
 	case HW_EVENT_PHY_DOWN:
-		pm8001_dbg(pm8001_ha, EVENT, "HW_EVENT_PHY_DOWN phyid:%#x\n",
-			   phy_id);
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_PHY_DOWN phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		hw_event_phy_down(pm8001_ha, piomb);
 		phy->phy_attached = 0;
 		phy->phy_state = PHY_LINK_DISABLE;
 		break;
 	case HW_EVENT_PORT_INVALID:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_PORT_INVALID phyid:%#x\n", phy_id);
+			   "HW_EVENT_PORT_INVALID phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		sas_phy_disconnected(sas_phy);
 		phy->phy_attached = 0;
 		sas_notify_port_event(sas_phy, PORTE_LINK_RESET_ERR,
@@ -3468,8 +3473,9 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			GFP_ATOMIC);
 		break;
 	case HW_EVENT_PHY_ERROR:
-		pm8001_dbg(pm8001_ha, EVENT, "HW_EVENT_PHY_ERROR phyid:%#x\n",
-			   phy_id);
+		pm8001_dbg(pm8001_ha, EVENT,
+			   "HW_EVENT_PHY_ERROR phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		sas_phy_disconnected(&phy->sas_phy);
 		phy->phy_attached = 0;
 		sas_notify_phy_event(&phy->sas_phy, PHYE_OOB_ERROR, GFP_ATOMIC);
@@ -3484,31 +3490,31 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		break;
 	case HW_EVENT_LINK_ERR_INVALID_DWORD:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_LINK_ERR_INVALID_DWORD phyid:%#x\n",
-			   phy_id);
+			   "HW_EVENT_LINK_ERR_INVALID_DWORD phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_LINK_ERR_INVALID_DWORD, port_id, phy_id, 0, 0);
 		break;
 	case HW_EVENT_LINK_ERR_DISPARITY_ERROR:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_LINK_ERR_DISPARITY_ERROR phyid:%#x\n",
-			   phy_id);
+			   "HW_EVENT_LINK_ERR_DISPARITY_ERROR phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_LINK_ERR_DISPARITY_ERROR,
 			port_id, phy_id, 0, 0);
 		break;
 	case HW_EVENT_LINK_ERR_CODE_VIOLATION:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_LINK_ERR_CODE_VIOLATION phyid:%#x\n",
-			   phy_id);
+			   "HW_EVENT_LINK_ERR_CODE_VIOLATION phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_LINK_ERR_CODE_VIOLATION,
 			port_id, phy_id, 0, 0);
 		break;
 	case HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH phyid:%#x\n",
-			   phy_id);
+			   "HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_LINK_ERR_LOSS_OF_DWORD_SYNCH,
 			port_id, phy_id, 0, 0);
@@ -3527,7 +3533,8 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		break;
 	case HW_EVENT_INBOUND_CRC_ERROR:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_INBOUND_CRC_ERROR phyid:%#x\n", phy_id);
+			   "HW_EVENT_INBOUND_CRC_ERROR phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_INBOUND_CRC_ERROR,
 			port_id, phy_id, 0, 0);
@@ -3547,8 +3554,8 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		break;
 	case HW_EVENT_LINK_ERR_PHY_RESET_FAILED:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_LINK_ERR_PHY_RESET_FAILED phyid:%#x\n",
-			   phy_id);
+			   "HW_EVENT_LINK_ERR_PHY_RESET_FAILED phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_LINK_ERR_PHY_RESET_FAILED,
 			port_id, phy_id, 0, 0);
@@ -3559,8 +3566,8 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		break;
 	case HW_EVENT_PORT_RESET_TIMER_TMO:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_PORT_RESET_TIMER_TMO phyid:%#x\n",
-			   phy_id);
+			   "HW_EVENT_PORT_RESET_TIMER_TMO phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		if (!pm8001_ha->phy[phy_id].reset_completion) {
 			pm80xx_hw_event_ack_req(pm8001_ha, 0, HW_EVENT_PHY_DOWN,
 				port_id, phy_id, 0, 0);
@@ -3578,8 +3585,8 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		break;
 	case HW_EVENT_PORT_RECOVERY_TIMER_TMO:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_PORT_RECOVERY_TIMER_TMO phyid:%#x\n",
-			   phy_id);
+			   "HW_EVENT_PORT_RECOVERY_TIMER_TMO phyid:%#x port_id:%#x\n",
+			   phy_id, port_id);
 		pm80xx_hw_event_ack_req(pm8001_ha, 0,
 			HW_EVENT_PORT_RECOVERY_TIMER_TMO,
 			port_id, phy_id, 0, 0);
@@ -3613,8 +3620,9 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		pm8001_dbg(pm8001_ha, MSG, "EVENT_BROADCAST_ASYNCH_EVENT\n");
 		break;
 	default:
-		pm8001_dbg(pm8001_ha, DEVIO, "Unknown event type 0x%x\n",
-			   eventType);
+		pm8001_dbg(pm8001_ha, DEVIO,
+			   "Unknown event portid:%d phyid:%d event:0x%x status:0x%x\n",
+			   port_id, phy_id, eventType, status);
 		break;
 	}
 	return 0;
-- 
2.40.0.634.g4ca3ef3211-goog

