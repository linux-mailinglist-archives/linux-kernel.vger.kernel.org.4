Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A576E6C90
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjDRTCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjDRTCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:02:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF0EAD1E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 62-20020a250341000000b00b9505f220d4so2923809ybd.20
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681844515; x=1684436515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3f1EZFPL8iHspGFGaVTxk55voCz6/hxKfdvRSWrACZU=;
        b=c4zkBfftCqOGxIJfB9cQriVe/8h+ZPNmyfJOdK2vWCZJ2FY2PS3slFzP7qUWVUgOCO
         g3xzNpOdaDKxZJomDgGMM+sMCBb60KlfJqFcJbkbbjEKLCp73oaTNAs/fA0Sh+jE14ic
         9UsZd4nYf3ofU1ZDxyx2Db50ssQGkDhNSFV5wE8CR2/DVlefX7gxOtf33CCWur4DKsas
         2UcWpB8HKiCvO25zIln0pyDD7PoS42ITmu6WpyGPhZspjsXHZXwnDa4cX2ZDedqFbvCu
         UTFstZJwFFTSpROCCEr84N+7iD+LF2BceV20lBkZFUIO534srDc9R5H2tyyF6Iq8y9NL
         0lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681844515; x=1684436515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3f1EZFPL8iHspGFGaVTxk55voCz6/hxKfdvRSWrACZU=;
        b=P1+DDLHv40E4ZYmS3n2uSu74mF34DxcGgwuPO+KvXSB5hiXwzVv3Aabo91PAjjNu7y
         L5ZZQbWRZ5183y3EPMvxgw50LSp0wtiUTYTAecDGZdaEQeYzAExpW8pf47bJSSrhCppw
         nM8CnYHqguxMde3DTWFwUsliYgdg3bPZqp+d6I8V8tpmlFNGNKzq8iI4Y6YYbuCCjoSe
         5xTkI63GiNZnQ7Hpehq/G+wNWvfGcFjwJQWtp3auGgZsM0aRdEgRE0JmVPpwmebiU/jl
         Gy5TI9K4OmFjUL8F4KTnG3rJNrgY7x3oGwg85+o+IllQO9szjQIeVdsa9HtK+wfSNu0b
         oyJA==
X-Gm-Message-State: AAQBX9dYop3vw/NsHOPshM6vsUBDAQ6unx3uqvJkY4DNvZY4/Vu+e62h
        0dqpw5xxaCLpGCtHa8l7+mQimzWOlhcAsg==
X-Google-Smtp-Source: AKy350YCcbz1nJnmfXHYzGDZ/EdbGZdCqGLDcT2Qn5dSB5nMPvR+vtcQtQKi6ETPcVBjZgM5cUT+vcf8aLN3kQ==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a81:b304:0:b0:54f:b95f:8999 with SMTP id
 r4-20020a81b304000000b0054fb95f8999mr490174ywh.6.1681844515385; Tue, 18 Apr
 2023 12:01:55 -0700 (PDT)
Date:   Tue, 18 Apr 2023 19:01:00 +0000
In-Reply-To: <20230418190101.696345-1-pranavpp@google.com>
Mime-Version: 1.0
References: <20230418190101.696345-1-pranavpp@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418190101.696345-6-pranavpp@google.com>
Subject: [PATCH 5/6] scsi: pm80xx: Log port state during HW event
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshat Jain <akshatzen@google.com>

Log port state during PHY_DOWN event to understand reasoning for PHY_DOWNs.

Signed-off-by: Akshat Jain <akshatzen@google.com>
Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 43 ++++++++++++++++----------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 8571f6222eb8..85908068b8d7 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3239,9 +3239,9 @@ hw_event_sata_phy_up(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	struct pm8001_port *port = &pm8001_ha->port[port_id];
 	struct pm8001_phy *phy = &pm8001_ha->phy[phy_id];
 	unsigned long flags;
-	pm8001_dbg(pm8001_ha, DEVIO,
-		   "port id %d, phy id %d link_rate %d portstate 0x%x\n",
-		   port_id, phy_id, link_rate, portstate);
+	pm8001_dbg(pm8001_ha, EVENT,
+		   "HW_EVENT_SATA_PHY_UP phyid:%#x port_id:%#x link_rate:%d portstate:%#x\n",
+		   phy_id, port_id, link_rate, portstate);
 
 	phy->port = port;
 	port->port_id = port_id;
@@ -3291,10 +3291,14 @@ hw_event_phy_down(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	phy->phy_attached = 0;
 	switch (portstate) {
 	case PORT_VALID:
+		pm8001_dbg(pm8001_ha, EVENT,
+			"HW_EVENT_PHY_DOWN phyid:%#x port_id:%#x portstate: PORT_VALID\n",
+			phy_id, port_id);
 		break;
 	case PORT_INVALID:
-		pm8001_dbg(pm8001_ha, MSG, " PortInvalid portID %d\n",
-			   port_id);
+		pm8001_dbg(pm8001_ha, EVENT,
+			"HW_EVENT_PHY_DOWN phyid:%#x port_id:%#x portstate: PORT_INVALID\n",
+			phy_id, port_id);
 		pm8001_dbg(pm8001_ha, MSG,
 			   " Last phy Down and port invalid\n");
 		if (port_sata) {
@@ -3306,18 +3310,21 @@ hw_event_phy_down(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		sas_phy_disconnected(&phy->sas_phy);
 		break;
 	case PORT_IN_RESET:
-		pm8001_dbg(pm8001_ha, MSG, " Port In Reset portID %d\n",
-			   port_id);
+		pm8001_dbg(pm8001_ha, EVENT,
+			"HW_EVENT_PHY_DOWN phyid:%#x port_id:%#x portstate: PORT_IN_RESET\n",
+			phy_id, port_id);
 		break;
 	case PORT_NOT_ESTABLISHED:
-		pm8001_dbg(pm8001_ha, MSG,
-			   " Phy Down and PORT_NOT_ESTABLISHED\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			"HW_EVENT_PHY_DOWN phyid:%#x port_id:%#x portstate: PORT_NOT_ESTABLISHED\n",
+			phy_id, port_id);
 		port->port_attached = 0;
 		break;
 	case PORT_LOSTCOMM:
-		pm8001_dbg(pm8001_ha, MSG, " Phy Down and PORT_LOSTCOMM\n");
-		pm8001_dbg(pm8001_ha, MSG,
-			   " Last phy Down and port invalid\n");
+		pm8001_dbg(pm8001_ha, EVENT,
+			"HW_EVENT_PHY_DOWN phyid:%#x port_id:%#x portstate: PORT_LOSTCOMM\n",
+			phy_id, port_id);
+		pm8001_dbg(pm8001_ha, MSG, " Last phy Down and port invalid\n");
 		if (port_sata) {
 			port->port_attached = 0;
 			phy->phy_type = 0;
@@ -3328,9 +3335,9 @@ hw_event_phy_down(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		break;
 	default:
 		port->port_attached = 0;
-		pm8001_dbg(pm8001_ha, DEVIO,
-			   " Phy Down and(default) = 0x%x\n",
-			   portstate);
+		pm8001_dbg(pm8001_ha, EVENT,
+			"HW_EVENT_PHY_DOWN phyid:%#x port_id:%#x portstate:%#x\n",
+			phy_id, port_id, portstate);
 		break;
 
 	}
@@ -3431,9 +3438,6 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		hw_event_sas_phy_up(pm8001_ha, piomb);
 		break;
 	case HW_EVENT_SATA_PHY_UP:
-		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_SATA_PHY_UP phyid:%#x port_id:%#x\n",
-			   phy_id, port_id);
 		hw_event_sata_phy_up(pm8001_ha, piomb);
 		break;
 	case HW_EVENT_SATA_SPINUP_HOLD:
@@ -3444,9 +3448,6 @@ static int mpi_hw_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			GFP_ATOMIC);
 		break;
 	case HW_EVENT_PHY_DOWN:
-		pm8001_dbg(pm8001_ha, EVENT,
-			   "HW_EVENT_PHY_DOWN phyid:%#x port_id:%#x\n",
-			   phy_id, port_id);
 		hw_event_phy_down(pm8001_ha, piomb);
 		phy->phy_attached = 0;
 		phy->phy_state = PHY_LINK_DISABLE;
-- 
2.40.0.634.g4ca3ef3211-goog

