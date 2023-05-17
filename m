Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27B97070E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjEQSgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEQSgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:36:42 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647B87D91;
        Wed, 17 May 2023 11:36:33 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6acc9273e3eso827673a34.2;
        Wed, 17 May 2023 11:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684348592; x=1686940592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcgddaFi9eIVKJHcNJHnZjvzuGSd2cAJphO5phJOGQ4=;
        b=blRaN0wfC/tMtFa6narQ0PHovL97wC/xpEJ3WhjFTq+zVqmWL9NZm/mn2O4BIQS3Qv
         X1wpSWpLYeLehNFzEFnRDzH90DeQ0atODnBU8HnO8dgCXz2afqrqdiGAxolIYRPxbtfr
         4apjok3YHlTwaKWqibV6NfJ43T+svCBF7zSzy/97oiN+fn6wrwoaTPLfY+2puuFkp1aP
         Gw2Z4BuCsCkB7mu+2Gp4Czk3spmTBTZJk9jXV0lSStpFmf5biLplIHDFxm9CdKLwopqT
         hFpe7YJfV5g4RnusIrtVHTUyIpauO4v4/4tqTLzkYGEh94nnBtejE/m8dPlSU+0hDTxJ
         mYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684348592; x=1686940592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcgddaFi9eIVKJHcNJHnZjvzuGSd2cAJphO5phJOGQ4=;
        b=IPO++a1NnRdsA11eli6x9eZFGbFfn4VZGt4vi916KL2q6Lu2i70+glH0eiCEqW9LRN
         AcUKQ+0cU5U+vrB1SIVBLp7vbgAAC89fleMrp+T/zd+DDKuMkOwKz/gFCaKKmhgfbZxX
         pxvMgbapcPCgB61WoEUP6Vet6pwIFnnlXfDDOboioGHRAMqDu4QSlN2uzaCnPhyrpJys
         6GjXlahfPtDS9gX4mqkIbcLWzJvvZEvbtDMOLdQ6nyjCBPAUmkrA+iJfFdLzaDIPIj9c
         bCwJeRKOSpnzSiwGEOe7uahMrnILKmPDaW6WPI6jYNNrN0DzCif+OxZj972DBNo27a/3
         cNhw==
X-Gm-Message-State: AC+VfDzMYAIN+jSLzLyiOEHltR5usmOSL2CcDU4G+83xD+0ia1U5vzL+
        2+QeeXRA0yOil724ToUOjeOeAssnO/8=
X-Google-Smtp-Source: ACHHUZ52yAAFIi4n8j8ONkqSZ/sJwDtCgn5mNLn3uNcO4RWP4qfrQ/EIgC92Bdx/BEa86iq8kRjCAQ==
X-Received: by 2002:a9d:7552:0:b0:6ab:133d:a3d7 with SMTP id b18-20020a9d7552000000b006ab133da3d7mr16445445otl.38.1684348592618;
        Wed, 17 May 2023 11:36:32 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id r14-20020a05683001ce00b006ac87b54ca4sm6161356ota.34.2023.05.17.11.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:36:32 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (oxp-sensors) Add new DMI match for OXP Mini
Date:   Wed, 17 May 2023 15:35:41 -0300
Message-Id: <20230517183540.187383-1-samsagax@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A newer BIOS version for the OneXPlayer Mini AMD modified vendor and
board name strings. Add those to the match table and set the same board
model as older OXP Mini AMD.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 drivers/hwmon/oxp-sensors.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 7828c1d36695..b52bf8c4768a 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -99,6 +99,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)oxp_mini_amd,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER mini A07"),
+		},
+		.driver_data = (void *)oxp_mini_amd,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
-- 
2.40.1

