Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40DF6BFF54
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 05:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCSEse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 00:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCSEsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 00:48:31 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B58C522DD7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3Prsu
        7D2KQBP4G5c2iSTA7jTUpywbihS7wu+b9c1Iis=; b=on2MgYbtd3b9nE73RE50e
        7TCsvg8FKBAX7IKZet14VqDrlb1wCXD/+sJtjUmwEcx0DWrnjlofaNCOAL30TDb/
        xQo2vDL4Hi6qv51JLcLDjtd9wLY77ewruAdSnPrU7R6Zbb+JMZmhy9yaHeR4nQAC
        3fLB6ep3yVAZ77cG+AKqsY=
Received: from lizhe.. (unknown [120.245.132.192])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wCHtzfnkxZkBrnyAQ--.4626S4;
        Sun, 19 Mar 2023 12:47:55 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Lizhe <sensor1010@163.com>
Subject: [PATCH v1] ALSA:ac97: Remove redundant driver match function
Date:   Sun, 19 Mar 2023 12:47:33 +0800
Message-Id: <20230319044733.327091-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHtzfnkxZkBrnyAQ--.4626S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1kAr4DtrykWF4rKF4rXwb_yoWkWrg_Ca
        y7ZFs7Xr17KF1fJw4fXw47AF97Ka1qvw1kKrs5t398KFyfXw4UWw4kJrsxAFn5urn2yFsx
        WryUXrWIy347XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNmhFDUUUUU==
X-Originating-IP: [120.245.132.192]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBohw3q1aEHrnIhQAAsa
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no driver match function, the driver core assumes that each
candidate pair (driver, device) matches, see driver_match_device()

Drop the bus's match function that always returned 1 and so
implements the same behaviour as when there is no match function.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 sound/ac97_bus.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/ac97_bus.c b/sound/ac97_bus.c
index b4685c53ff11..c7aee8c42c55 100644
--- a/sound/ac97_bus.c
+++ b/sound/ac97_bus.c
@@ -75,19 +75,8 @@ int snd_ac97_reset(struct snd_ac97 *ac97, bool try_warm, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(snd_ac97_reset);
 
-/*
- * Let drivers decide whether they want to support given codec from their
- * probe method. Drivers have direct access to the struct snd_ac97
- * structure and may  decide based on the id field amongst other things.
- */
-static int ac97_bus_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
 struct bus_type ac97_bus_type = {
 	.name		= "ac97",
-	.match		= ac97_bus_match,
 };
 
 static int __init ac97_bus_init(void)
-- 
2.34.1

