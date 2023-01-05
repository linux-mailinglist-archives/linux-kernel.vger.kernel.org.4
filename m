Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B1765E5AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjAEGlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAEGlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:41:23 -0500
X-Greylist: delayed 1808 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 22:41:20 PST
Received: from m126.mail.126.com (m126.mail.126.com [123.126.96.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25FB530575
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 22:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+CTu0
        102GyOYgF0oKjGnxfGyVDGf5Sg9WI0zhsJQK00=; b=N/uffnJb3jesSZ6MbdXyP
        nvzvyhOFdRHbl9X3t34j5z1h9glaSMcUGeegsJNaCtKI9VG2Y+EEbyAB1M8ES13I
        RqQJu8Q0pVd+OMVtjhGlkulQk5qjDCTRMXbjzC0mVARAdzn2ejxeyYAfHC3zpg/1
        48kbr8pkwlmc2wjq8HCDXo=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp14 (Coremail) with SMTP id fuRpCgBXGZnyabZjSb09AA--.36535S2;
        Thu, 05 Jan 2023 14:10:59 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     lee@kernel.org, ckeepax@opensource.cirrus.com,
        patches@opensource.cirrus.com, windhl@126.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] mfd: arizona: Use pm_runtime_resume_and_get() to prevent refcnt leak
Date:   Thu,  5 Jan 2023 14:10:55 +0800
Message-Id: <20230105061055.1509261-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: fuRpCgBXGZnyabZjSb09AA--.36535S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1fury8trWrZFyUJF45Awb_yoWfKFc_Ca
        98Wr43Cr4Fgrn7Ka1xX3yFv34IkFy8XF43Zw4vvFy3JF4jka17XryDXFyDArnrZ3y5AF90
        gr4qyryfZ3Z8ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRWE__7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi5hPtF2Ixk+pFKwAAsL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In arizona_clk32k_enable(), we should use pm_runtime_resume_and_get()
as pm_runtime_get_sync() will increase the refcnt even when it
returns an error.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:
 v1: add missing pm_runtime_put_sync()
 v2: use pm_runtime_resume_and_get()

 drivers/mfd/arizona-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index cbf1dd90b70d..b1c53e040771 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -45,7 +45,7 @@ int arizona_clk32k_enable(struct arizona *arizona)
 	if (arizona->clk32k_ref == 1) {
 		switch (arizona->pdata.clk32k_src) {
 		case ARIZONA_32KZ_MCLK1:
-			ret = pm_runtime_get_sync(arizona->dev);
+			ret = pm_runtime_resume_and_get(arizona->dev);
 			if (ret != 0)
 				goto err_ref;
 			ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK1]);
-- 
2.25.1

