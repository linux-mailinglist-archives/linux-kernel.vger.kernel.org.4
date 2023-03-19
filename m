Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8325C6BFF53
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 05:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCSElq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 00:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCSElm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 00:41:42 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23E1A1F4A5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 21:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6PuUO
        bMV7JIE67n7ZYn2PDpczkWggqfJ67CwHqi7hzc=; b=LvmB74/4HTVMbBDqcqTx/
        maxVgR7swG6ad+8qhlvVzGljUBU6BQ1AI9dKShopQnCA4WTCY76DcBPefzgsX/o/
        jKJSaC0bBgfoMsC3w6DqMYeMfNP0glgnuQvF+AZchShYPLYknsacdmhcYX2PhQsY
        lyfOj/tJlK3OuPfYdm8zio=
Received: from lizhe.. (unknown [120.245.132.192])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wC3XMFmkhZk7yf1AQ--.13750S4;
        Sun, 19 Mar 2023 12:41:30 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org, Lizhe <sensor1010@163.com>
Subject: [PATCH v1] w1/w1.c : Remove driver match function
Date:   Sun, 19 Mar 2023 12:41:07 +0800
Message-Id: <20230319044107.311555-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3XMFmkhZk7yf1AQ--.13750S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1kAr4DGr47Kr1kAF4xWFg_yoWDWwc_C3
        47Zr97Xrn8Ka4rtFnagFsrZFWIga1vqr48XanYq39aq3W3Xw1rur4UZrsrt34UZrWxJFsI
        k34DXr4I9r40qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZ4SO5UUUUU==
X-Originating-IP: [120.245.132.192]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBlxs3q2I0YaFeJQAAs9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no driver match function, the driver core assumes that each
candidate pair (driver, device) matches, see driver_match_device().

Drop the bus's match function that always returned 1 and so
implements the same behaviour as when there is no match function

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/w1/w1.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 9d199fed9628..e7e42f9dabf4 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -58,11 +58,6 @@ MODULE_PARM_DESC(slave_ttl,
 DEFINE_MUTEX(w1_mlock);
 LIST_HEAD(w1_masters);
 
-static int w1_master_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
 static int w1_master_probe(struct device *dev)
 {
 	return -ENODEV;
@@ -174,7 +169,6 @@ static int w1_uevent(const struct device *dev, struct kobj_uevent_env *env);
 
 static struct bus_type w1_bus_type = {
 	.name = "w1",
-	.match = w1_master_match,
 	.uevent = w1_uevent,
 };
 
-- 
2.34.1

