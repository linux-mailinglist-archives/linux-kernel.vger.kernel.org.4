Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6EE6E6C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjDRTCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjDRTBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:01:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846548A46
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-552f169d85eso44888867b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681844510; x=1684436510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3M04/PVG/NW2ywLizOW6+L2fN0aG9yYd0DnDu5UetZk=;
        b=jg+iCQtwdF8xsttudTN/6DvOTpNp4mkmnjDOOLQnElAXlkSTlPdIIA2PKtJG7o6J8k
         Z5ZIc6nHuE629pFZDMqIMndfSHLVvTAjtrI6dcs8cyWnCHLZjkl6U+XX9oC1biQKyEQc
         s+xMXOR+KpQsABmTJZL595TnCs/MvZRoUR3InKPvoAUe8nf4RY0gY+Ex5HHroIZel8Fe
         3mpbtlZhJfAsTMZGCwt3488DtYArf9ovsAhjZ51Mt64qdcBG6h8fzSZMXeseLPSK6aX6
         mpBVOfcMHEDD8DmLqgowfyihlH4Kqj0SOvNuCWsJyKIrYuqoZDQELFQNU4Y9eGTUjdrI
         qMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681844510; x=1684436510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3M04/PVG/NW2ywLizOW6+L2fN0aG9yYd0DnDu5UetZk=;
        b=WAYI8YhPNUV0Msk2bQdUxyRuV8tUv3oUg5OPsLAGilTfhw2aTH8AkqwOXWIrq7WGSs
         J4zfNfAqR1fetvGOb87USfbM6GNqFTkZrJ13RmDxbOrwcIXBnovILgNvVJhJmo5Lu/ld
         DrpOMSwLgcV9vgeeZ9xlzg9ATcXRqM7Ad92cRWHPRHc7EEL1z8CvzAVo3ADo43Ox7qlg
         H//9OTkfEv/XC5yGBuWRVgkLK2uuo6d6CU0x57pyEiryDlYGSKbk/BxhYiIJabrNzuzD
         kyTPJt6P8qIeJMDMqp0LqFWIcmxqj1r7AWPi8V7kYoYr+KdZquVJjhxVJrv5Ix9fFD8P
         RlDQ==
X-Gm-Message-State: AAQBX9cH4BTOOI+lWffQSpCj4i35mb6CL02gMGnzQL9JVoIE1pfe1vah
        arxrRJZ5Frs00K06b6LBMWPLDV0+IbBcgQ==
X-Google-Smtp-Source: AKy350aDSqTsTQCebasG2cB6gB8hD1DfdBwJKUKWrYLTNz8UDhSK5dFMSgm3phdGYBYmENs5K9KUzTEzUrHlRw==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a81:bd4f:0:b0:54c:bf7:1853 with SMTP id
 n15-20020a81bd4f000000b0054c0bf71853mr499349ywk.6.1681844510798; Tue, 18 Apr
 2023 12:01:50 -0700 (PDT)
Date:   Tue, 18 Apr 2023 19:00:57 +0000
In-Reply-To: <20230418190101.696345-1-pranavpp@google.com>
Mime-Version: 1.0
References: <20230418190101.696345-1-pranavpp@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418190101.696345-3-pranavpp@google.com>
Subject: [PATCH 2/6] scsi: pm80xx: Enable init logging
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

Enable init logging to debug drive discovery issues.

Signed-off-by: Akshat Jain <akshatzen@google.com>
Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index d8dc629c0efb..041cdc41af80 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -44,7 +44,7 @@
 #include "pm80xx_hwi.h"
 
 static ulong logging_level = PM8001_FAIL_LOGGING | PM8001_IOERR_LOGGING |
-							 PM8001_EVENT_LOGGING;
+				PM8001_EVENT_LOGGING | PM8001_INIT_LOGGING;
 module_param(logging_level, ulong, 0644);
 MODULE_PARM_DESC(logging_level, " bits for enabling logging info.");
 
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index ce6a442d2418..61c1bf3d98a0 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4837,7 +4837,7 @@ static void mpi_set_phy_profile_req(struct pm8001_hba_info *pm8001_ha,
 	payload.tag = cpu_to_le32(tag);
 	payload.ppc_phyid =
 		cpu_to_le32(((operation & 0xF) << 8) | (phyid  & 0xFF));
-	pm8001_dbg(pm8001_ha, INIT,
+	pm8001_dbg(pm8001_ha, DISC,
 		   " phy profile command for phy %x ,length is %d\n",
 		   le32_to_cpu(payload.ppc_phyid), length);
 	for (i = length; i < (length + PHY_DWORD_LENGTH - 1); i++) {
-- 
2.40.0.634.g4ca3ef3211-goog

