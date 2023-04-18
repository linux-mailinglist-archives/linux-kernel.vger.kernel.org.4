Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEE96E6C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjDRTCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjDRTBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:01:55 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB4EAF1E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:54 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-246f13f35f1so1304791a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681844513; x=1684436513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q705pkA7pRJMTNZuDFlVqTXdHPjT6mc0BG+foW8FYi0=;
        b=GqaVpB2zVNhyjotwG0yVhTUD2FgvGT2em4z75cUO2Etv9n/147+YOqB1E8CyE4fiv3
         JEf8JAbdkea0iZPmSHSc15ndLOJ2IkC4Sj6HeYSJdQpMsdA78+IA0GK/IKQA0r9nncfo
         bXcfgRJkYIJuIlbUNqa2N8hn3g3CWMlgBLhbNelz093pW51MxIt4CGWlAhGz2OtZX43h
         TcjF0s+XJQYHIgn75hlKWOQhCzDd3pN5zXhBXhWHoqrc2U9lC+qvgvrQeyD4dAmbJHrE
         LP1INYSdOeVG/U2wmrnEflyUDg8+aZwcaTznM3pehyzxkLgbWsyrxgPH5e78ZwEaBeSA
         hAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681844513; x=1684436513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q705pkA7pRJMTNZuDFlVqTXdHPjT6mc0BG+foW8FYi0=;
        b=BYD0WAHFAPesJN8pZuRa22IY8xckS2O7H6E1aM01lAggT8ozQmlDAiQfqSicP+vteY
         RrZbbSL6WkWbjj5L3bAF3cVBOvwIryp+23C3oRkz+p3Se2oeN/bhjiRo5ZCcbNohFiHK
         TD3vxRUbMDCPQ2WLGdCdYvOv8xwsjuwpo41VEBJevshnJgKcEECmQNS9YppUNUvjLaIx
         /hkLyCLGNEPqu7/RmFkT7FPdY4M/W2Wy1mYSgXsLIx7WlX4GOhvo1CFib8dYUsZRCR3c
         6ePYovS8aNBKoBOsosGTWSk6GnVmB85UhXweEJk06cDZ96MCyQOhp6hya1rBnDAntISf
         OG9w==
X-Gm-Message-State: AAQBX9fI8fBBQ0cIjwfh+TF9VMlh8m3L1LQ9JszYBu9kmIc9Ynv/ZewU
        MnLDsExTN02/LYZk6M/nfItU8mtXELHR+g==
X-Google-Smtp-Source: AKy350ZW8H2ie7PJ0xF/7HLOgOBlt+IodZxdPo3Cfwds2kbkKdjUEWeiqhOD74s3vqCqGAqiKyXioEQv/u4PSQ==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a17:90a:3182:b0:247:11e6:f6ff with SMTP
 id j2-20020a17090a318200b0024711e6f6ffmr260224pjb.3.1681844513734; Tue, 18
 Apr 2023 12:01:53 -0700 (PDT)
Date:   Tue, 18 Apr 2023 19:00:59 +0000
In-Reply-To: <20230418190101.696345-1-pranavpp@google.com>
Mime-Version: 1.0
References: <20230418190101.696345-1-pranavpp@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418190101.696345-5-pranavpp@google.com>
Subject: [PATCH 4/6] scsi: pm80xx: Log phy_id and port_id in the device
 registration request
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

Print phy_id and port_id sent as part of device registration
request.

Signed-off-by: Akshat Jain <akshatzen@google.com>
Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index c5bf65d0ad14..8571f6222eb8 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4756,6 +4756,9 @@ static int pm80xx_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
 	memcpy(payload.sas_addr, pm8001_dev->sas_device->sas_addr,
 		SAS_ADDR_SIZE);
 
+	pm8001_dbg(pm8001_ha, INIT,
+		   "register device req phy_id 0x%x port_id 0x%x\n", phy_id,
+		   (port->port_id & 0xFF));
 	rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
 			sizeof(payload), 0);
 	if (rc)
-- 
2.40.0.634.g4ca3ef3211-goog

