Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB9E6B0F20
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCHQpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCHQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:45:19 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DF31B8613;
        Wed,  8 Mar 2023 08:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LYDzw
        PaZBIHTa29Hr5kYoaSLV3mHIy4tWwYKipSShZI=; b=AjdOHJTZTdofO4+vm5g8C
        FkJC3mdMJlkiJ1GVKX1kQbBoNaDLnkLG3QSeXTDBp/pUuI1OBZxyD0mU2BSwwP37
        APJn72/1rI0kXQiCKwCUCP1oOfBg3XwAsgGag6Lk40n9lhqWuXO8hW2kvdmU9GXl
        C1HgizWDqKtfo0rHzqDu48=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wCnHQKPuwhk3itfCg--.4202S2;
        Thu, 09 Mar 2023 00:45:03 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] Bluetooth: btsdio:  fix use after free bug in btsdio_remove due to race condition
Date:   Thu,  9 Mar 2023 00:45:01 +0800
Message-Id: <20230308164501.2734985-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnHQKPuwhk3itfCg--.4202S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyrZr18JF48ur1fWry5twb_yoW3ZFg_ua
        48ZryxCFyUCF17tF1UCF4qvry8tFnYq3WvgFnaqas5try7WrsxGr1DZFZ0q3Z7Wr1DKFy3
        Ar4rX3y8tw48ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKBMNUUUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzgwsU2I0XkYj5QABs0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In btsdio_probe, the data->work is bound with btsdio_work. It will be 
started in btsdio_send_frame.

If the btsdio_remove runs with a unfinished work, there may be a race 
condition that hdev is freed but used in btsdio_work. Fix it by 
canceling the work before do cleanup in btsdio_remove.

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/bluetooth/btsdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 795be33f2892..f19d31ee37ea 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -357,6 +357,7 @@ static void btsdio_remove(struct sdio_func *func)
 	if (!data)
 		return;
 
+	cancel_work_sync(&data->work);
 	hdev = data->hdev;
 
 	sdio_set_drvdata(func, NULL);
-- 
2.25.1

