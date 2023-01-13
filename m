Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8E668F89
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjAMHtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjAMHtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:49:42 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8DF1A822;
        Thu, 12 Jan 2023 23:49:41 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id l22so20663095eja.12;
        Thu, 12 Jan 2023 23:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ki/D1WUy5ryn68f131sCexKZ8Uw0CRINUHMpMThw1h4=;
        b=MrZqIjlJU54cg2457lOD+lg384HK6gA1Nb9CBdGUiKfgYsB14QaQX61r9OtNwotQKB
         THMs47B1dqPWxYTr7sgoDSVTHBgACpbIVVlRD715H+brWuzh91B9W8j1cR3TIFJgGVk4
         lq4oEcRbrZIjFGCgcACACa7pmQA9hjXwKnhpL4wZ7lvSSniEIcS50+UyxUdlpY/+nx/K
         niXvF292CD8sS4XkYXPBxMNf2xgeYY9W3FderhTHx6nJkpsr75YA78XAgzXB+Ku21Cdn
         729M2KRBmulaAjdScbAqLBaR2faFc9g0J8W7vjpqnHrrQcHe8m71av87l8YRblaxALpj
         IxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ki/D1WUy5ryn68f131sCexKZ8Uw0CRINUHMpMThw1h4=;
        b=YN8T2x9KkPCciKokUiSYgsfc1LLsytuWb9PdalQ8aPaoAf1G2TEiueIOrPYxLo/AXB
         qScAIKA4kiuf+d+Es6XTeMV18BC7Hcy6mRLXURwvrKKidq9gPGC4X8DAMOMstkWi/ogJ
         di/P6B6dRUvRl+voK6OuywHFCF0UWU98A9eNbKM9DPmKOL0K2D9oT8nN+7VxE53LWpNw
         zSZ6KN097I8mL5wj5n5xfAQs2Mm7qet8gCpUVP+7ti0A78UTGd3a1EvFyh40KHS/qer7
         RmO9v7x/avwBlmWANpr43FXcf2AJIXt1ue2XUeH4dU7DCNe2zz5dpu5SzN6DO52OpDzY
         +3Hw==
X-Gm-Message-State: AFqh2kpX266Z54lfjM9XKKKDkP9U5DnsE8PtmvyBrQNxoxEffTFWdI3f
        WN/dqbhlOAz0hn1rGwDuQc8=
X-Google-Smtp-Source: AMrXdXvpYNAJ1hb/R8RykYrpD9NO6MRCwedsK48BgHEkt6XdgGobwficLiSe7Qyl0u7bzBTsagaFdA==
X-Received: by 2002:a17:907:c48d:b0:7c0:aafa:6dc0 with SMTP id tp13-20020a170907c48d00b007c0aafa6dc0mr52745239ejc.25.1673596179964;
        Thu, 12 Jan 2023 23:49:39 -0800 (PST)
Received: from felia.fritz.box (ipbcc1d920.dynamic.kabel-deutschland.de. [188.193.217.32])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906319200b007c1651aeeacsm8246555ejy.181.2023.01.12.23.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 23:49:39 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] crypto: atmel-i2c - avoid defines prefixed with CONFIG
Date:   Fri, 13 Jan 2023 08:47:15 +0100
Message-Id: <20230113074715.32016-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defines prefixed with "CONFIG" should be limited to proper Kconfig options,
that are introduced in a Kconfig file.

Here, a definition for the driver's configuration zone is named
CONFIG_ZONE. Rename this local definition to CONFIGURATION_ZONE to avoid
defines prefixed with "CONFIG".

No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Herbert, David, please pick this clean-up work into your crypto tree. Thanks.

 drivers/crypto/atmel-i2c.c | 2 +-
 drivers/crypto/atmel-i2c.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
index 55bff1e13142..66e27f71e37e 100644
--- a/drivers/crypto/atmel-i2c.c
+++ b/drivers/crypto/atmel-i2c.c
@@ -59,7 +59,7 @@ void atmel_i2c_init_read_cmd(struct atmel_i2c_cmd *cmd)
 	 * Read the word from Configuration zone that contains the lock bytes
 	 * (UserExtra, Selector, LockValue, LockConfig).
 	 */
-	cmd->param1 = CONFIG_ZONE;
+	cmd->param1 = CONFIGURATION_ZONE;
 	cmd->param2 = cpu_to_le16(DEVICE_LOCK_ADDR);
 	cmd->count = READ_COUNT;
 
diff --git a/drivers/crypto/atmel-i2c.h b/drivers/crypto/atmel-i2c.h
index 35f7857a7f7c..c1fdc04eac07 100644
--- a/drivers/crypto/atmel-i2c.h
+++ b/drivers/crypto/atmel-i2c.h
@@ -63,7 +63,7 @@ struct atmel_i2c_cmd {
 #define STATUS_WAKE_SUCCESSFUL		0x11
 
 /* Definitions for eeprom organization */
-#define CONFIG_ZONE			0
+#define CONFIGURATION_ZONE		0
 
 /* Definitions for Indexes common to all commands */
 #define RSP_DATA_IDX			1 /* buffer index of data in response */
-- 
2.17.1

