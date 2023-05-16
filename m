Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D86705588
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjEPR5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjEPR5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:57:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4B1187
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:57:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba802c775caso3685378276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684259863; x=1686851863;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XYAsynXy0qhLt31JsQGFwwPdGuXbkEfsjf2hEcVOFMI=;
        b=HNQtLQVZkKAmG0RuWXNB3Qfs6Eknt+JgqrGmCUosMrev8RfpdcLgxRUtrYSf9HU6Aq
         NBpVag0+ymzcHg4V12fzNfN3ZgY968fkjq+n5QSSCnSeU+88CH1J3BL+qm35cU33Z8Yp
         SG4MVflqYKiwZ/pRq9HbS4v5Oy2Jlhg+geg+Z4LKKKHUYjmVIq1qovsL6nawLruy+U/j
         TRGh/0aneBFevtqdV0ID7PCOYMUv163Qh0zm3oFc33lE2/0cgDxlesyDqbwVFHHTWkFU
         5+X+NhfuAziXHZN7KLQbC5lMue6Xetsw9xSulVJj0UBsucSLUrjpaTfjrwKoIiPtGL+M
         qkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684259863; x=1686851863;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYAsynXy0qhLt31JsQGFwwPdGuXbkEfsjf2hEcVOFMI=;
        b=VpyYIK9c1Z3W7+Np8D1eC2liZ+OzTvDTfKohoJODSZ1/0C5rVL+DGcW/IfXLcOu2uL
         qlkR80WzJwJtcRStIjS9ZT9IzYtZAkDzhlf4xwyA2xUkYX6R+MAWfy/+fjOK1BPWpll7
         bIy3I+cEZbfW2ukc4XKjEQnL9bSPaOEHwxGC2yAJrfgXOU1hjjYaBXMurnZoL6l8M16p
         RuZKv1LltsQGafER2z/aJc9cPO9bO/fAjGPWAgEs7yw0hEWii7c8e2CNWHjo1N7Niqb7
         IBYA6tozzkMrBXuv6qn5X604QXZxk5X8NEt6toSPlhdYqB3Tg6Nm9xVkKovArOkble8u
         EzVQ==
X-Gm-Message-State: AC+VfDzpvM6yYtaupAvw25kiJXd7Edtl4nUa2GqXlVX38ihdVES++ZbP
        t1LRb7WRoW8oO6ZTmMACLuMbo3DI8egLVQ==
X-Google-Smtp-Source: ACHHUZ6vT+g1sIVdxaiODXjnAKnpgOo7aXFzFwkzqdbwsc/WeEp/ry6zgCaDmFgGXU9H1Utt4ULX94e/Ts3pQQ==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a25:1bd4:0:b0:ba7:85fd:9d38 with SMTP id
 b203-20020a251bd4000000b00ba785fd9d38mr6534719ybb.4.1684259863386; Tue, 16
 May 2023 10:57:43 -0700 (PDT)
Date:   Tue, 16 May 2023 17:57:37 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516175737.1831575-1-pranavpp@google.com>
Subject: [PATCH] scsi: pm80xx: Set phy_attached to zero when device is gone
From:   Pranav Prasad <pranavpp@google.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Pylypiv <ipylypiv@google.com>,
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

From: Igor Pylypiv <ipylypiv@google.com>

Set phy_attached to zero when device is gone.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index e5673c774f66..c57fc671509d 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -706,6 +706,7 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 			spin_lock_irqsave(&pm8001_ha->lock, flags);
 		}
 		PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
+		pm8001_ha->phy[pm8001_dev->attached_phy].phy_attached = 0;
 		pm8001_free_dev(pm8001_dev);
 	} else {
 		pm8001_dbg(pm8001_ha, DISC, "Found dev has gone.\n");
-- 
2.40.1.606.ga4b1b128d6-goog

