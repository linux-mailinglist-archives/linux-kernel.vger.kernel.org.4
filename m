Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3786F781F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjEDV3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjEDV3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:29:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4A21386B;
        Thu,  4 May 2023 14:29:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aad55244b7so7417455ad.2;
        Thu, 04 May 2023 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683235776; x=1685827776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YigFI0J8gEeJ9cS/4TbGx1mSqvxtVecjV4VaaynehVs=;
        b=r1MJoYdfVTxCFUkhk4kqzogB35WzJWaXdMwR0kF2naomGKBzqaFz6BMb+Hj+jVYKSF
         5pXHwjnfyHm9aYOp1CZYXfA/3K4U8lmduHliEi9wxFGdSBGNtRS3Syz2vnISXcwaT2iO
         RIjq0yG/4FCs3RY2C9wrvWhKXoRU1KEarLEpk/1CGqHMASZqDoizbxDoLftBF9oy1yFe
         tkK5h7EUNXOI7xaRi3XEuTbtM4JjUIuLZlZYqrgLNjODd/49zSEPfdhT8xiB1vNSO1i6
         KZPlFsSqrKx4NUpneUzgGGdp5I0cOQAt+4WIVsJd6B0idgQiyM8Rfu5z4+JCUJTPVDFO
         b+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683235776; x=1685827776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YigFI0J8gEeJ9cS/4TbGx1mSqvxtVecjV4VaaynehVs=;
        b=DYwciOSsP0v8kV31lsdl+r06B8BZ0WeBOdYifvEJFuDDbUeGomCJQbgbZF/2/DL7qr
         wJ74ezuRHRRjUhOnGIgWH/bmj+o6jB1Y3odGknenk4gNtrEQzmOHVMSCPgRJGv+zz8vO
         rzgmraj+dR3sJxUF7TyMXD4BHK9zmIKsBRkOJpBnY55vWq2qE4Y0EvSwRh5ojUi/LubG
         1L2XoKcSDA2Ta7UoxzzbN5ePprSg8rqKGpcTktijfU8fbgQydTfzgYW1R/f1uMvDZj5E
         u0FgNq+uMGEH+Ci+X7FmxriN186KmHHVjfGpdT2YzbEpcfKGUyImcW56NH77V/n0kDj9
         snOg==
X-Gm-Message-State: AC+VfDwJ0mkmXaCQJOvReI9GYqOZRlGZHzMO0hTD5WKYaJS0vVCy8hnQ
        ajTZxPY16YBa8H609/oOyEmohsv+x6t2/w==
X-Google-Smtp-Source: ACHHUZ5yfp4qg3v5Ax3aZrMPEBASyRDzdpKUZaf2hCWJbtmWyHvnskvhy/DKRKComyvrbLMOVrpC7w==
X-Received: by 2002:a17:902:f68f:b0:1aa:ec83:e1ac with SMTP id l15-20020a170902f68f00b001aaec83e1acmr5963791plg.53.1683235776025;
        Thu, 04 May 2023 14:29:36 -0700 (PDT)
Received: from localhost.localdomain ([2600:8801:9701:6a00:daec:5eff:fea8:3a31])
        by smtp.gmail.com with ESMTPSA id z1-20020a17090a8b8100b00247a2498075sm11527121pjn.48.2023.05.04.14.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:29:35 -0700 (PDT)
From:   Dan Gora <dan.gora@gmail.com>
Cc:     Dan Gora <dan.gora@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations.
Date:   Thu,  4 May 2023 14:28:44 -0700
Message-Id: <20230504212843.18519-1-dan.gora@gmail.com>
X-Mailer: git-send-email 2.35.1.102.g2b9c120970
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing MODULE_FIRMWARE declarations for firmware referenced in
btrtl.c.

Signed-off-by: Dan Gora <dan.gora@gmail.com>
---
 drivers/bluetooth/btrtl.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 2915c82d719d..d978e7cea873 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1367,14 +1367,30 @@ MODULE_FIRMWARE("rtl_bt/rtl8723cs_vf_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723cs_vf_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723cs_xx_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723cs_xx_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723d_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723d_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761b_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761b_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761bu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8821a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8821a_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8821c_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8821c_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8821cs_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8821cs_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8822b_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8822b_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822cs_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822cs_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822cu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822cu_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8851bu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8851bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852au_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bs_fw.bin");
@@ -1383,5 +1399,3 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8851bu_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8851bu_config.bin");
-- 
2.35.1.102.g2b9c120970

