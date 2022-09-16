Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBE5BAD4C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiIPMVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiIPMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:21:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1352EB14EF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r5-20020a1c4405000000b003b494ffc00bso1071858wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WYL9uktQw+E6TpQrhcglD7TIXo7ivPZytGIQ69aZMX8=;
        b=CXThsYmuRM/z/jgjLcmBOhoKRvZ6zo7AklrAcdISwHJrYlhkAPQYvl/molFH1SwBgK
         N72Jb/YDdQeGj6MsGqoFwHBjb/0fCqvMjAkhvUB1201tplBtcd9+r4iRxhFazgYCTJBg
         3A8tg2HMpPtz0Fg95VbdW3RPRG7OWbROOSeyCkNNvN4th8pJ5h9B5rZbCoVxH4exdGXD
         bGvaTTeY1epmMoqCdrlDt2myBtMprnbHe2MwfeOWJ764ih4YpU0cPXLBY+PSncuCy9JC
         S0rOEULMmRuQroN7x5DXoRGEMULQ+7UIzyjPFnDypeMM1GS0zU85MR0F2PDTi4GOg+Q7
         jo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WYL9uktQw+E6TpQrhcglD7TIXo7ivPZytGIQ69aZMX8=;
        b=i/xpxXVmTcdyiyEJHKAEc63nTCZtdm3saTyVuJOJ/Us3UqbsUlBQBrAVMHXNZDq49U
         RaKYQ+frN71bVYkM0Nk91/owiyjg99FF/zdkjKIesIvaxUnuPHTzqkqfqBEFaQvwK9EB
         oYKz9LJNz35oRRDz9ToLNQ9j8gGF2fVrXFkvQPpPZH9eA38pMWupR2d4KAWfrk2wMVz9
         wzQSHOhAiLOUv3krzcu++iMNVotyjkENbPf85JmVdRM8qC4kO4ZpWe25dfKvgIk2Y8+j
         IRcS6crH4v5UhVU9ThOS1Vr2FynA/+WNYguofcIp6nJrw2Q1fvYgAtmbkceMSPf7gfzk
         ia4Q==
X-Gm-Message-State: ACrzQf0j0YLDBTpej/vLytXbusXOP8dh96SELBOZtXIIYIu8HFt7e/uf
        JcbmhzLXZJNr/wyk1be6GQ41SA==
X-Google-Smtp-Source: AMsMyM64HxponcHUGMjXJ2wz8YnVoCUKgUAmjDYW/TzDdojHdBjw96rScNzlYL5FkZYXWLa1dpveXA==
X-Received: by 2002:a05:600c:46c6:b0:3b4:61ad:17df with SMTP id q6-20020a05600c46c600b003b461ad17dfmr3231489wmo.107.1663330868409;
        Fri, 16 Sep 2022 05:21:08 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b0022add371ed2sm1540015wri.55.2022.09.16.05.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:21:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/13] mtd: allow getting MTD device associated with a specific DT node
Date:   Fri, 16 Sep 2022 13:20:49 +0100
Message-Id: <20220916122100.170016-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

MTD subsystem API allows interacting with MTD devices (e.g. reading,
writing, handling bad blocks). So far a random driver could get MTD
device only by its name (get_mtd_device_nm()). This change allows
getting them also by a DT node.

This API is required for drivers handling DT defined MTD partitions in a
specific way (e.g. U-Boot (sub)partition with environment variables).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mtd/mtdcore.c   | 28 ++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index a9b8be9f40dc..e3bee273595e 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1217,6 +1217,34 @@ int __get_mtd_device(struct mtd_info *mtd)
 }
 EXPORT_SYMBOL_GPL(__get_mtd_device);
 
+/**
+ * of_get_mtd_device_by_node - obtain an MTD device associated with a given node
+ *
+ * @np: device tree node
+ */
+struct mtd_info *of_get_mtd_device_by_node(struct device_node *np)
+{
+	struct mtd_info *mtd = NULL;
+	struct mtd_info *tmp;
+	int err;
+
+	mutex_lock(&mtd_table_mutex);
+
+	err = -EPROBE_DEFER;
+	mtd_for_each_device(tmp) {
+		if (mtd_get_of_node(tmp) == np) {
+			mtd = tmp;
+			err = __get_mtd_device(mtd);
+			break;
+		}
+	}
+
+	mutex_unlock(&mtd_table_mutex);
+
+	return err ? ERR_PTR(err) : mtd;
+}
+EXPORT_SYMBOL_GPL(of_get_mtd_device_by_node);
+
 /**
  *	get_mtd_device_nm - obtain a validated handle for an MTD device by
  *	device name
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 955aee14b0f7..6fc841ceef31 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -677,6 +677,7 @@ extern int mtd_device_unregister(struct mtd_info *master);
 extern struct mtd_info *get_mtd_device(struct mtd_info *mtd, int num);
 extern int __get_mtd_device(struct mtd_info *mtd);
 extern void __put_mtd_device(struct mtd_info *mtd);
+extern struct mtd_info *of_get_mtd_device_by_node(struct device_node *np);
 extern struct mtd_info *get_mtd_device_nm(const char *name);
 extern void put_mtd_device(struct mtd_info *mtd);
 
-- 
2.25.1

