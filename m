Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A1463A3E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiK1JAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiK1JAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:00:17 -0500
X-Greylist: delayed 914 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Nov 2022 01:00:16 PST
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CB017640
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Vdt8u
        9zvqOSP/nM0l2OSHGSUIYvnzovrjlUR+LN6Jf8=; b=dVqpo5LHZVCPlcj8iE613
        EmZ71CcfnjK2UKadsNx4IwzU+15LXoQxa776c4Ka/Z1wZksBzJYzVJ0L+gzJcjwU
        L0tV3tJPoi2D1d5NNltHCFGRQgH41DQ3QhiWgHcTSjphw5zUi31WeqFkwQ3aiqOk
        b6rBG+qUjM7MblUeAnk3VQ=
Received: from localhost.localdomain (unknown [36.112.3.106])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wAHh0_mdIRjPgjhAA--.56577S4;
        Mon, 28 Nov 2022 16:44:34 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     ojeda@kernel.org, andriy.shevchenko@linux.intel.com,
        geert+renesas@glider.be
Cc:     linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] auxdisplay: hd44780: Fix potential memory leak in hd44780_remove()
Date:   Mon, 28 Nov 2022 16:44:21 +0800
Message-Id: <20221128084421.8626-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHh0_mdIRjPgjhAA--.56577S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrZryfAF4fuw1UAF4rZw4rAFb_yoW8Jr43pF
        sxWFWfKr4UXr1vgw1DGw1UuFWrC3W0ya4jg3s2kws3Z345JF1Iva48J3sFkrW3tFWfGa12
        qa12qrWfJFs2qFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR0PfJUUUUU=
X-Originating-IP: [36.112.3.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiWxfHjGI0XNaN-wAAsp
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hd44780_probe() allocates a memory chunk for hd with kzalloc() and
makes "lcd->drvdata->hd44780" point to it. When we call hd44780_remove(),
we should release all relevant memory and resource. But "lcd->drvdata
->hd44780" is not released, which will lead to a memory leak.

We should release the "lcd->drvdata->hd44780" in hd44780_remove() to fix
the memory leak bug.

Fixes: 41c8d0adf3c4 ("auxdisplay: hd44780: Fix memory leak on ->remove()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/auxdisplay/hd44780.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 8b2a0eb3f32a..f4800a946bd8 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -322,8 +322,10 @@ static int hd44780_probe(struct platform_device *pdev)
 static int hd44780_remove(struct platform_device *pdev)
 {
 	struct charlcd *lcd = platform_get_drvdata(pdev);
+	struct hd44780_common *hdc = (struct hd44780_common *)lcd->drvdata;
 
 	charlcd_unregister(lcd);
+	kfree(hdc->hd44780);
 	kfree(lcd->drvdata);
 
 	kfree(lcd);
-- 
2.25.1

