Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223A06E1517
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDMTTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDMTTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:19:22 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F594EEC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:19:01 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id z3so7013085qvs.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681413535; x=1684005535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tW0Gt1r0g4k2K6ZdZ463Ef3Kv7HUGKoVv34mqVCJvuA=;
        b=jh/TAtYWti9xKU1XRJWHWFQtAwlydQNhkC6355HtwquNGCcMBwXTq+/OqkZTZqq1Fg
         DDXKK2S2mRuuaCzrJHdaf0fQwuVF7WKW211tLNW7ZwPvk+hHDjgn4OvF2U3BfTzeq4R6
         y3rxKvhvzSdFGuxF+3DIhpL+JFQMZ7k167dlHRGCh07UDyyUbe7+GQ2+Bi6NUwrQfGFO
         AVhIDyNnP4WmHpB34y3AZ2WlyQsb3nw6ubQhCaGtL9GBybyUlxI3WMs7d7T+dHD7JyII
         ok6IjcsOpDMAxJWkpDOwsp7ShDg72XfPthwA/HS9A75y8bxwCePwv2wLkYydgE8okXCL
         wi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681413535; x=1684005535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tW0Gt1r0g4k2K6ZdZ463Ef3Kv7HUGKoVv34mqVCJvuA=;
        b=Dr9nrw79ihEhyg5E1az2ZyRirH+Hd8He+eTr9xTuJ5BI9LR3N4ggVA0Fs4R9EUmt/j
         iTMRCq1HrRWLtwa4BITCh/2KdLFTqH1nURHeAEVkqKHqESC1BuEuraHywGPZivqZaWBi
         ARdrBlmN7zM882RQ3OIHlt/n4/HVmnz9ysPCRJUAtGOblNvoyn8lo+5cKU5UktvwBNvR
         9nFpNrDo/prv6lR4KLqM3mws4dc9kSRSVO7pTWzFv/5s3hOThKpjupG42w83aDjTwIVH
         tWUJu0jCLkUw8vKui9av+YeD33nd0pzWAIlaAOt0yVXJ1kgjROoy53afxTfK72t3sgRI
         XLyQ==
X-Gm-Message-State: AAQBX9fWIWWz4drwqcVINVEL3mr7liXoJ8mngxwQbokpOvqjz9+wOg59
        FCfAiKZYrwnaZ7iu6JCnGAL+VSDNaMRfVw==
X-Google-Smtp-Source: AKy350a7TX+7/dt7geJe+ymge3tp1h1MZdsV+J38vCFWTk/+hDg6M/yz3uR4uIEDwnXErZ2JCvpY0g==
X-Received: by 2002:a05:6214:494:b0:5ef:486a:505e with SMTP id pt20-20020a056214049400b005ef486a505emr5920164qvb.41.1681413535123;
        Thu, 13 Apr 2023 12:18:55 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z17-20020a0cf251000000b005e90a67a687sm617855qvl.65.2023.04.13.12.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:18:54 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Florian Fainelli <f.fainelli@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] firmware_loader: Strip off \n from customized path
Date:   Thu, 13 Apr 2023 12:17:57 -0700
Message-Id: <20230413191757.1949088-1-f.fainelli@gmail.com>
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

Having helped an user recently figure out why the customized path being
specified was not taken into account landed on a subtle difference
between using:

echo "/xyz/firmware" > /sys/module/firmware_class/parameters/path

which inserts an additional newline which is passed as is down to
fw_get_filesystem_firmware() and ultimately kernel_read_file_from_path()
and fails.

Strip off \n from the customized firmware path such that users do not
run into these hard to debug situations.

Link: https://lore.kernel.org/all/20230402135423.3235-1-f.fainelli@gmail.com/
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/base/firmware_loader/main.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 017c4cdb219e..10b7d8fc5d07 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -493,9 +493,9 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 					     const void *in_buffer))
 {
 	size_t size;
-	int i, len;
+	int i, len, maxlen = 0;
 	int rc = -ENOENT;
-	char *path;
+	char *path, *nt = NULL;
 	size_t msize = INT_MAX;
 	void *buffer = NULL;
 
@@ -518,8 +518,17 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		if (!fw_path[i][0])
 			continue;
 
-		len = snprintf(path, PATH_MAX, "%s/%s%s",
-			       fw_path[i], fw_priv->fw_name, suffix);
+		/* strip off \n from customized path */
+		maxlen = strlen(fw_path[i]);
+		if (i == 0) {
+			nt = strchr(fw_path[i], '\n');
+			if (nt)
+				maxlen = nt - fw_path[i];
+		}
+
+		len = snprintf(path, PATH_MAX, "%.*s/%s%s",
+			       maxlen, fw_path[i],
+			       fw_priv->fw_name, suffix);
 		if (len >= PATH_MAX) {
 			rc = -ENAMETOOLONG;
 			break;
-- 
2.34.1

