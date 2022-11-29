Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2063BB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiK2IQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiK2IQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:16:41 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C98045A27
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8lfUT
        btt/lnQSOBZjkdp/PK/8/wp02RYgakBDUnJPyQ=; b=fjbRPVHCa2XGpvODDQXmj
        XGLvFc86RJap6evvMeBIS43ukXeKx7AddHIY0zAn5tDWkQu0OJe6jNZ40Hxfh/Fw
        qHuzBp3h+WHFmh4H7eow/2kZ/g2ftrSb9yiHQVpisTrRNf07Kl5TJsJEEtLnKXd1
        gLtgP694y36Y0ns6EzjXtc=
Received: from localhost.localdomain (unknown [36.112.3.106])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wCXDUKvv4VjdrtIAA--.23448S4;
        Tue, 29 Nov 2022 16:16:01 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     ojeda@kernel.org, andriy.shevchenko@linux.intel.com,
        geert+renesas@glider.be
Cc:     linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] auxdisplay: hd44780: Fix potential memory leak in hd44780_remove()
Date:   Tue, 29 Nov 2022 16:15:42 +0800
Message-Id: <20221129081542.5890-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXDUKvv4VjdrtIAA--.23448S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrZryfAF4fuw1UAF4rZw4rAFb_yoW8JF1kpF
        W7WaySgr1UXryvgr1DGw1UuFWrC3W0ya4jgasFywn3u345JFyIya4rJ3s2krZxtFWfGa1I
        qa12qrWxJFs2yFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR0PfJUUUUU=
X-Originating-IP: [36.112.3.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/xtbBOQbIjF-PQRCQkwAAs5
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

Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/auxdisplay/hd44780.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 8b2a0eb3f32a..d56a5d508ccd 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -322,8 +322,10 @@ static int hd44780_probe(struct platform_device *pdev)
 static int hd44780_remove(struct platform_device *pdev)
 {
 	struct charlcd *lcd = platform_get_drvdata(pdev);
+	struct hd44780_common *hdc = lcd->drvdata;
 
 	charlcd_unregister(lcd);
+	kfree(hdc->hd44780);
 	kfree(lcd->drvdata);
 
 	kfree(lcd);
-- 
2.25.1

