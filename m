Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4445F576E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiJEP2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJEP15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:27:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985871B9DB;
        Wed,  5 Oct 2022 08:27:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so1237640wmq.1;
        Wed, 05 Oct 2022 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=C7yvq5LaxDRVj3NEoiYSWWej3JSDSWFXj9nJXuRBqoc=;
        b=YZ798TqbwpLOO6C28mdHIbZElgraed18HA55DIqLKNEFshX3QhR2+OVzWCC9eCMmXM
         6XxKwfWCwo3XNO+I2K1xbigOL8lvDMCT7elaubtjjBINqjlPheG6ZXUMvwQtwOQJ8SXY
         ekOfNhRCpnVpRrx5wdEzz2qpXVx/DAXu3sZ6d0d6+2PI7K+QLLapeHUFNe4iDhO2lWct
         A55+e879ushKEX6lbrQycLk2FVYUVVvDthZN1ndBzTgFIt1Gf+gcgxscFaTBUys9KQ/S
         wf6EtDRxY6lfzKr5gNH1NuGTUHyN2sWjE9xeFavwT0BMkkEU3EEZDBgwq2jHm3nV5YZr
         tGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=C7yvq5LaxDRVj3NEoiYSWWej3JSDSWFXj9nJXuRBqoc=;
        b=M4zaacqyA+lgxPGFwLPSfZx9U9rRCUtooGGhY6l2kiy3KL7sXrQ70u8QkgHtpLwETI
         uU0di21tF5MGi9brEEDtf1IRhBovsr90GN0Heva1M/HVBPsn5mDwUmuGG5JMRYMSc1HO
         QspyGipZp2Z2zAy5PbMVOEn3iMxUkIcZn20iXfjC/Zqgw9j71xWTZmQrO7cq+rRQuYgP
         Rjm0ux+uV3QPlN/mIXUQEXwaFjrWCv+KNF9lwd7Npa5vE3h2dRxcCJRKRrSSzj10hEZt
         BshYE9kECMebv+3hgOevMb1nOgocZOUqJ9aEnth6bju39egw2v7qVoLjasPoaWorAntK
         sunA==
X-Gm-Message-State: ACrzQf21CDgyDWuiAZsfN+64JcGjEPbK2ieKec5C6+i6wqncwkrj6ze0
        o/MXaAFzE/RBPu9Z2Cp1+TQ=
X-Google-Smtp-Source: AMsMyM6xK2SSnjDn/YKWGJKsL61fVXSPWob9GQtiMk/14t8FGXGByZN41Og7RAceclSnHyt9997YYg==
X-Received: by 2002:a05:600c:1f15:b0:3b4:8600:fd7e with SMTP id bd21-20020a05600c1f1500b003b48600fd7emr3867225wmb.40.1664983674091;
        Wed, 05 Oct 2022 08:27:54 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d4986000000b0022ccae2fa62sm3369480wrq.22.2022.10.05.08.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 08:27:53 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (fschmd) Make const arrays static const
Date:   Wed,  5 Oct 2022 16:27:52 +0100
Message-Id: <20221005152752.318493-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only const arrays names and watchdog_minors
on the stack but instead make them static const. Also makes the
object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hwmon/fschmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index 0a77d6161928..e1f426e86f36 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -1083,9 +1083,9 @@ static int fschmd_detect(struct i2c_client *client,
 static int fschmd_probe(struct i2c_client *client)
 {
 	struct fschmd_data *data;
-	const char * const names[7] = { "Poseidon", "Hermes", "Scylla",
+	static const char * const names[7] = { "Poseidon", "Hermes", "Scylla",
 				"Heracles", "Heimdall", "Hades", "Syleus" };
-	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
+	static const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
 	int i, err;
 	enum chips kind = i2c_match_id(fschmd_id, client)->driver_data;
 
-- 
2.37.3

