Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82F26B8B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCNGb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCNGbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:31:24 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F3BE38EB1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
        Content-Type; bh=lBS2JKJIvNxqYm+evdt62IxdrtgP2kCBI/hwsgUC8a0=;
        b=PnOWvV+xg2a0MVMwkT+bzOflHbR6A5eFs29KVJMa6d/OZPS5aTf1TaAZFiR270
        DNHgETphgGgw1Z/99F0j+5Qd+lyrK5vZVDiOfi2EhSeEPqZGuROL96X9LeZZ9/HT
        LNDPeg8KVjoSQv+EylqUIVMcSaLPVgFu9N5j9/IfgzUP0=
Received: from localhost.localdomain (unknown [111.8.73.49])
        by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wD3XdmjFBBku1VFAA--.48506S2;
        Tue, 14 Mar 2023 14:30:59 +0800 (CST)
From:   hqp1203 <hqp1203hqp@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     hqp1203 <hqp1203hqp@163.com>
Subject: [PATCH] drivers: fix keyboard not working under some laptops
Date:   Tue, 14 Mar 2023 22:30:57 +0800
Message-Id: <20230314143057.4368-1-hqp1203hqp@163.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3XdmjFBBku1VFAA--.48506S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF45uw4kKw1kCF4DAr1fZwb_yoWkKrXE93
        WqqFyfJayjyFnrCF10yrs8uFyYyw4xWF95GFy2qayS9w1xXwnrArnxZw1fur1xuFy7Grsx
        Jwnrtr1S9ry5ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiYFCUUUUUU==
X-Originating-IP: [111.8.73.49]
X-CM-SenderInfo: pktsijmqtk11i6rwjhhfrp/1tbivxAyaFWB35-WhgAAsx
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On that Linux kernel, my laptop's built-in keyboard isn't working. It is
suspected that the architecture of higher vresion of AMD's chip(the spec
ific CPU model is 7735h)conflicts with IRQ of the current Linux Kernel.
The solution is to add my laptop model number under drivers/acpi/resourc-
e.c to skip IRQ overrides. After modification, it was found that the key-
board worked properly.
My laptop model is the ASUS TUF Gaming A15, specifically FA507NV.

Signed-off-by: hqp1203 <hqp1203hqp@163.com>

要提交的变更：
	修改：     drivers/acpi/resource.c
---
 linux-master/drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/linux-master/drivers/acpi/resource.c b/linux-master/drivers/acpi/resource.c
index 7c9125df5..0a4909dc1 100644
--- a/linux-master/drivers/acpi/resource.c
+++ b/linux-master/drivers/acpi/resource.c
@@ -453,6 +453,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
 		},
 	},
+	{
+		.ident = "Asus TUF Gaming A15 FA507NV",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "FA507NV"),
+		},
+	},
 	{ }
 };
 
-- 
2.39.2

