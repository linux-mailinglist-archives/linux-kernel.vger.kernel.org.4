Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783C46BFF51
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 05:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCSEfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 00:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCSEfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 00:35:53 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C20AB1C32B;
        Sat, 18 Mar 2023 21:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cG/Pz
        LjXs6S3d9LvCwdUbAsZr8iqDclBzL43h6uvg28=; b=SmmJJxBx/HJmOnCTkKDeG
        DO6GWIiJlLXQUCGH7dcRDmVt5lbh8PURHOUz/H+WqzixjsaFNROk7AV26CAvpvNT
        2ph6xP2T4orbEfSvHFQhWREFl1uo8feRxzpiGo7DSfJvQMkWpko7k9d7f+prdUdX
        RykagRXgN9lFhV7u/1D8Dg=
Received: from lizhe.. (unknown [120.245.132.192])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wAXrjIHkRZka1HqAQ--.60798S4;
        Sun, 19 Mar 2023 12:35:40 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     yangyingliang@huawei.com, michael.chritie@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhe <sensor1010@163.com>
Subject: [PATCH] scsi:target:tcm_loop:Remove redundant driver match function
Date:   Sun, 19 Mar 2023 12:35:18 +0800
Message-Id: <20230319043518.297490-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXrjIHkRZka1HqAQ--.60798S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1kAr4Dtr43CFyDXFWkJFb_yoWkCFX_Cr
        yxZrn7urn7u3WFyFsxu3y3ZryfKF1xWFn5KF4Fq393Kw47JryFvw4jqrnxJ3s8Zr1rJas0
        93srXr1xAryftjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNZ2-DUUUUU==
X-Originating-IP: [120.245.132.192]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiKAg3q17WMXCwVQAAsQ
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no driver match function, the driver core assumes that each
candidate pair (driver, device)matches, see driver_match_device()

Drop the bus's match function that always returned 1 and so
implements the same behaviour as when there is no match function.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/target/loopback/tcm_loop.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 139031ccb700..92475972acae 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -83,15 +83,8 @@ static int tcm_loop_show_info(struct seq_file *m, struct Scsi_Host *host)
 static int tcm_loop_driver_probe(struct device *);
 static void tcm_loop_driver_remove(struct device *);
 
-static int pseudo_lld_bus_match(struct device *dev,
-				struct device_driver *dev_driver)
-{
-	return 1;
-}
-
 static struct bus_type tcm_loop_lld_bus = {
 	.name			= "tcm_loop_bus",
-	.match			= pseudo_lld_bus_match,
 	.probe			= tcm_loop_driver_probe,
 	.remove			= tcm_loop_driver_remove,
 };
-- 
2.34.1

