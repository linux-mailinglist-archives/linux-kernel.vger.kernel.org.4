Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CB96E6C92
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjDRTC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjDRTCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:02:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB41AC147
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f69fb5cafso211707887b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681844516; x=1684436516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpvX6zUZ3jJSuVnzz4zMHHsJJxYIrejED2Kgcd4VmHE=;
        b=lrLE+nDGD3TZMrxvhsLtTXo+MNZ85rg5PEI9Nq6nxIGe6cjQJsYwtEVVtXsZvhPACp
         I+clHOcIZHU3sn0gZwgImhOcecFYUu2CF3TDngh8xKkpf839M9bc5GGFLd72Bhb0TvMc
         qz+OBU8XG1j8DkyljpLzjQh8qHIm8UpTufz0UUz7eEjof9zws82ra68q99kqYl8kMP/r
         uII2BDiN1wlpPZzd5POZ6XwzrbF1n3XYQZza6YnLSHtFX95okvT1Wpo07CrT5DzU0Fos
         QxTT/dNYmSHv1mQVBqX32MQ0+ebXb5Hq04VriTzYf+nyGMgXHDF15TEk2wKSiWl7Pi1J
         hUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681844516; x=1684436516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpvX6zUZ3jJSuVnzz4zMHHsJJxYIrejED2Kgcd4VmHE=;
        b=DmwG4kDQQU5woqqIQaeGMtN00MnOzz4JfpKQsvXiovl+p4hffJjW8K7g0AbxKI/P2j
         QI157QNa6j/S5xWTBWH8m62lzB1OrPSmAwOlf8qVLP+3u1daBbMDDQMogsbaq7yWXhpK
         vfSh3EhRnvU4zIeTIN8/MJscOKBu/8sTzRIqQ1NRdn3pTm9XZ0hbCr+4hhmn8TAg/NJk
         NuJjm1C4gj9gqDJYlUQnYqKXeNKc4VNzHUea9Xw/OpH/30SHFJwwRsEcGloF7E8R0tvJ
         QIEOsoAEeL3srCTitksEh/usA9EMtAHnFOVKMQ4PzzgPduqfnDuagbpCAvfd4FCeO/Cs
         4ZmA==
X-Gm-Message-State: AAQBX9cLRz3mOL4wiOh1DfECOoiC5oWYahajF7tTRaoGiaOoXg52ZsN8
        UbOy5tLu0vxctQRkR7NpbSGECB/0ftNqKA==
X-Google-Smtp-Source: AKy350bXiQoDmPFoIvILcrY2f0FNpLfWJ8niTeLDqT0R6Tk4Kel0fOd1zG2mwdLPANkMv7K8WZNnBU3DE4e+1A==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a25:df41:0:b0:b8b:eea7:525e with SMTP id
 w62-20020a25df41000000b00b8beea7525emr12896039ybg.5.1681844516750; Tue, 18
 Apr 2023 12:01:56 -0700 (PDT)
Date:   Tue, 18 Apr 2023 19:01:01 +0000
In-Reply-To: <20230418190101.696345-1-pranavpp@google.com>
Mime-Version: 1.0
References: <20230418190101.696345-1-pranavpp@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418190101.696345-7-pranavpp@google.com>
Subject: [PATCH 6/6] scsi: pm80xx: Update PHY state after hard reset
From:   Pranav Prasad <pranavpp@google.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>,
        Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changyuan Lyu <changyuanl@google.com>

Update phy_attached, phy_state, and port_state to correct values
after a hard rest. Without this patch, after a successful hard reset,
phy_attached is still 0, as a result, any following hard reset will
cause a PHY START to be issued first.

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 85908068b8d7..39a12ee94a72 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3417,6 +3417,7 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	u8 port_id = (u8)(lr_status_evt_portid & 0x000000FF);
 	u8 phy_id =
 		(u8)((phyid_npip_portstate & 0xFF0000) >> 16);
+	u8 portstate = (u8)(phyid_npip_portstate & 0x0000000F);
 	u16 eventType =
 		(u16)((lr_status_evt_portid & 0x00FFFF00) >> 8);
 	u8 status =
@@ -3449,7 +3450,6 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		break;
 	case HW_EVENT_PHY_DOWN:
 		hw_event_phy_down(pm8001_ha, piomb);
-		phy->phy_attached = 0;
 		phy->phy_state = PHY_LINK_DISABLE;
 		break;
 	case HW_EVENT_PORT_INVALID:
@@ -3567,14 +3567,15 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		break;
 	case HW_EVENT_PORT_RESET_TIMER_TMO:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_PORT_RESET_TIMER_TMO phyid:%#x port_id:%#x\n",
-			   phy_id, port_id);
+			   "HW_EVENT_PORT_RESET_TIMER_TMO phyid:%#x port_id:%#x portstate:%#x\n",
+			   phy_id, port_id, portstate);
 		if (!pm8001_ha->phy[phy_id].reset_completion) {
 			pm80xx_hw_event_ack_req(pm8001_ha, 0, HW_EVENT_PHY_DOWN,
 				port_id, phy_id, 0, 0);
 		}
 		sas_phy_disconnected(sas_phy);
 		phy->phy_attached = 0;
+		port->port_state = portstate;
 		sas_notify_port_event(sas_phy, PORTE_LINK_RESET_ERR,
 			GFP_ATOMIC);
 		if (pm8001_ha->phy[phy_id].reset_completion) {
@@ -3608,14 +3609,17 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		break;
 	case HW_EVENT_PORT_RESET_COMPLETE:
 		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_PORT_RESET_COMPLETE phyid:%#x port_id:%#x\n",
-			   phy_id, port_id);
+			   "HW_EVENT_PORT_RESET_COMPLETE phyid:%#x port_id:%#x portstate:%#x\n",
+			   phy_id, port_id, portstate);
 		if (pm8001_ha->phy[phy_id].reset_completion) {
 			pm8001_ha->phy[phy_id].port_reset_status =
 					PORT_RESET_SUCCESS;
 			complete(pm8001_ha->phy[phy_id].reset_completion);
 			pm8001_ha->phy[phy_id].reset_completion = NULL;
 		}
+		phy->phy_attached = 1;
+		phy->phy_state = PHY_STATE_LINK_UP_SPCV;
+		port->port_state = portstate;
 		break;
 	case EVENT_BROADCAST_ASYNCH_EVENT:
 		pm8001_dbg(pm8001_ha, MSG, "EVENT_BROADCAST_ASYNCH_EVENT\n");
-- 
2.40.0.634.g4ca3ef3211-goog

