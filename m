Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9186A2F18
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 11:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBZKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 05:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZKXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 05:23:48 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C1AC656;
        Sun, 26 Feb 2023 02:23:48 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id bh1so3849855plb.11;
        Sun, 26 Feb 2023 02:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wi2xVqzSevhJpXDSWkdsF+oMBiFQhK5PRJ0HvFg4vlU=;
        b=XVsyQL5PSgI1Bs57Jf0fpotc041iuxQGTzEalwWqck+/0/DLnF/HYIjP3S413PkD46
         4YS5FAR9dyNcebTBt0pUxja4xIQPbhcpHEpS2P445I1SzBjmawPEndyKyoF/NxzcLW/N
         ziQSzVGCMkzOOIlYXu0BgSA1S5oWPG4S1Qi6igpQnAHUjJ95DKb8ajnCN1RY5znOofDZ
         s+6bCOlVJ6NOGqNrt951Jhpz1LeJltQ9oRVgw4AJF6obIm2Enzl+0zSb99ZAf1M7Gh9S
         VoOmkbJ3F4jhihG0fc6nwgzf623JnLQzkoAV7EQH3AuWioew9q6lOImZ1e+O502tTNPj
         DRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wi2xVqzSevhJpXDSWkdsF+oMBiFQhK5PRJ0HvFg4vlU=;
        b=z5D8hh6giwI610mRLBsarvfPi2+lqIfM2OoAp4/A9fxR2RbdyqXyBdL/I1qFVzYmyB
         1qRaPuvfFawfZjEdWDxOFFk6hdi1TYBMXi/2HqqyE6/97hmWFF/CKiqHb5FbrZjlaI5s
         k7Rob+UZw51gMGptFFYLPSKDPcCOSjv5FBVY/tYIL/eA4zJwMMyrPVGT7mx1KL0OvSbo
         uPk7wHwFmhSJyPHD8KT8l6EVwiSV2WAnwKSiiR2wJquCCk92Gl+f35HMZ4k7pCa/gKQ4
         B6X7dzE95S2a+lpg6zVqYLQ3tWJpLxz9Z/EC7+/J7f3R5D823CA5tgkcOkg/rvR6olBj
         SKMQ==
X-Gm-Message-State: AO0yUKVRTJAkwsG6WpSJT29aXoIstonG+T5ak2cD/iU8I82GxYbf3TA5
        NCRAGYgtJZEIiYdrEzqixCzkwypIzhpQlKhk
X-Google-Smtp-Source: AK7set8fOwUHoXXIC2sCunIL7TGItqvkkxWcvg76HdDyFcZROi5Xwn0/6ZQnpJu8Q9DV1M4Oqh9jRQ==
X-Received: by 2002:a05:6a20:4298:b0:c7:6c6f:7722 with SMTP id o24-20020a056a20429800b000c76c6f7722mr29478842pzj.7.1677407027552;
        Sun, 26 Feb 2023 02:23:47 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79052000000b005d6999eec90sm2263051pfo.120.2023.02.26.02.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 02:23:47 -0800 (PST)
From:   Kang Chen <void0red@gmail.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kang Chen <void0red@gmail.com>
Subject: [PATCH] scsi: lpfc: add null check of kzalloc in lpfc_sli4_cgn_params_read
Date:   Sun, 26 Feb 2023 18:23:38 +0800
Message-Id: <20230226102338.3362585-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc may fails, pdata might be null and it may cause
null pointer dereference later.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 6eb4085a3..54134d782 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7291,6 +7291,8 @@ lpfc_sli4_cgn_params_read(struct lpfc_hba *phba)
 	/* Find out if the FW has a new set of congestion parameters. */
 	len = sizeof(struct lpfc_cgn_param);
 	pdata = kzalloc(len, GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 	ret = lpfc_read_object(phba, (char *)LPFC_PORT_CFG_NAME,
 			       pdata, len);
 
-- 
2.34.1

