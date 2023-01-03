Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D465C4D5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbjACRM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbjACRM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:12:28 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 396D9DF89;
        Tue,  3 Jan 2023 09:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=O4rnvdDDpajkGG7+Qi
        rOiKaOcHU3GFAj6R1dSdlfTWE=; b=ererlTOdzCFPlDlgxm/CQyHMaw6ONUxmrP
        djlksrRdCBk7Wox0S3b/OF/TKJxIaTz7xHytxoR95cT7Fg+RFtOHSvSvZCjrwSGJ
        3lrOWjqdY4yGyc+aWin5HRqZdvH6xNO0eQqPDylMkP8vN9nVDA2kF3bJeZvFJgEy
        ZIDsACK7k=
Received: from localhost.localdomain (unknown [36.4.209.174])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wDXM4VfYbRjveN8AA--.3535S4;
        Wed, 04 Jan 2023 01:10:29 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     jirislaby@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizhe <sensor1010@163.com>
Subject: [PATCH v2] serial: linflexuart: remove redundant uart type _assignment_
Date:   Tue,  3 Jan 2023 09:09:48 -0800
Message-Id: <20230103170948.3777-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDXM4VfYbRjveN8AA--.3535S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4rAw47XF48uw13Jr1fJFb_yoW3uFb_Cw
        1DA34xWr109FWayFnrJFyYkrZagrsYvF48AF40vasaqw4DZa1fXryIqrZruwsrA3y8X3sr
        G3yxWF4ayrsrXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN5l17UUUUU==
X-Originating-IP: [36.4.209.174]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiKAXrq17WLufu+QABs6
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	in linflex_config_port() the member variable type will be
assigned again. see linflex_connfig_port()

Signed-off-by: lizhe <sensor1010@163.com>
Acked-by: Jiri Slaby <jslaby@suse.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 6fc21b6684e6..34400cc6ac7f 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -837,7 +837,6 @@ static int linflex_probe(struct platform_device *pdev)
 		return PTR_ERR(sport->membase);
 
 	sport->dev = &pdev->dev;
-	sport->type = PORT_LINFLEXUART;
 	sport->iotype = UPIO_MEM;
 	sport->irq = platform_get_irq(pdev, 0);
 	sport->ops = &linflex_pops;
-- 
2.17.1

