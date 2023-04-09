Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1E6DBFE7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 14:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDIMtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 08:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDIMtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 08:49:15 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8040040CA;
        Sun,  9 Apr 2023 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Mhjvh
        SjVLfAU4UiAkgI/PW9/PMmXYNymW2/ysFGQTpo=; b=POvRWspsvdXHf9ZZxP6sL
        vQMPPqgjgC2hwTlYavzS4by3jzR2mkqvw36xdW5pLWeyy4IP3QSLjLHkYsxxqhAF
        D2GHbgdR08gWc9aEMfCWuiGO5B7NFkqG6obBpw9YjIp6e4OQM9Q3y30VJwvKgMa/
        G+1HZ+DTW4NFvaGn7Oowb8=
Received: from ubuntu.localdomain (unknown [115.156.140.143])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wDXaJQVtDJkoV3tAw--.6869S4;
        Sun, 09 Apr 2023 20:48:22 +0800 (CST)
From:   Xinyi Hou <Y_Ashley@163.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Xinyi Hou <Y_Ashley@163.com>, Dongliang Mu <dzm91@hust.edu.cn>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: mchp_pci1xxxx: mchp_pci1xxxx_gp: add unwind goto
Date:   Sun,  9 Apr 2023 20:48:15 +0800
Message-Id: <20230409124816.36137-1-Y_Ashley@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXaJQVtDJkoV3tAw--.6869S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWfAF1kWr1rKr4DKFWUtwb_yoW8XF1kpF
        9ayFy7ZrW8twnrKw4xZ3WUtF4fCw40k34YgrZFv39I93ZxJF17Kry0grn0vw1DWFWUt3W3
        tr1jyFWrCa1UZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piqg4fUUUUU=
X-Originating-IP: [115.156.140.143]
X-CM-SenderInfo: p1bd2xxoh1qiywtou0bp/1tbiShhMxGI0XssOZwAAsw
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reported:

drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:73 gp_aux_bus_probe() warn:
missing unwind goto?

In gp_aux_bus_probe(), when the allocation of
aux_bus->aux_device_wrapper[1] fails, it needs to clean up the allocated
resources.

Fix this by revising the return statement to a goto statement.

Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.")
Signed-off-by: Xinyi Hou <Y_Ashley@163.com>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
The issue is found by static analysis, and the patch remains untest.
---

 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
index 32af2b14ff34..2c64b6b3cd9c 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
@@ -69,8 +69,10 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	aux_bus->aux_device_wrapper[1] = kzalloc(sizeof(*aux_bus->aux_device_wrapper[1]),
 						 GFP_KERNEL);
-	if (!aux_bus->aux_device_wrapper[1])
-		return -ENOMEM;
+	if (!aux_bus->aux_device_wrapper[1]) {
+		retval = -ENOMEM;
+		goto err_aux_dev_add_0;
+	}
 
 	retval = ida_alloc(&gp_client_ida, GFP_KERNEL);
 	if (retval < 0)
-- 
2.25.1

