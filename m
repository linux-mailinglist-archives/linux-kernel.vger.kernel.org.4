Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8F6EC7F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjDXIkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDXIkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:40:04 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ED8E4F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:40:01 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id qrjpp9pdVS2Yhqrjqpy8BT; Mon, 24 Apr 2023 10:39:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682325599;
        bh=vgMfnD5w8L8osmiEQCPKAcBxZ5zFalY5WsdQV5PqFVU=;
        h=From:To:Cc:Subject:Date;
        b=X9QChUa0hH2ybgHWlFRyPLmC5Dd0l0eKvnf5G6fJo66FWer4zD/ICt0pjXKSaN76J
         y/J8oE8QazQDRAZkQvMnNDELOuZq66MPu0VaRSnO45ebxzG1gTBVSf6vQqtMTiVdBq
         9xoBjg6jyAfzx8JfM3fWaXhAeOcm6qfWGI7jkifXS6CSNXBFJnF7KIusxzgwfWO70n
         HdvGnUzH2/g3MnX5YgfksRY636m0p6Tc/h4YufQzqyEsAhQ81hgMsLZCI6sYAyX0Zb
         eIrWarETpt4fDopYH99zjv38VHPTW4mYE60syRYxi45Sii3+sZccwAy4t3U2WATTOD
         uOREdSNVtKMWw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Apr 2023 10:39:59 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: typec: mux: Remove some unneeded includes
Date:   Mon, 24 Apr 2023 10:39:56 +0200
Message-Id: <1db1e8bd253cbb652835c0cef6a0a2bb9a4970eb.1682325582.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver includes many header files that are unneeded.
Remove them and add <linux/device.h> where devm_kzalloc() is defined.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Based on one of my script, this reduces the number of included files
during the build process of this file from 551 to 345.
---
 drivers/usb/typec/mux/gpio-sbu-mux.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
index f62516dafe8f..c07856069d43 100644
--- a/drivers/usb/typec/mux/gpio-sbu-mux.c
+++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
@@ -3,14 +3,11 @@
  * Copyright (C) 2022 Linaro Ltd.
  */
 
-#include <linux/bits.h>
-#include <linux/i2c.h>
-#include <linux/kernel.h>
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
 
-- 
2.34.1

