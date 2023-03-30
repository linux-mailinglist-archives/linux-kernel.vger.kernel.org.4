Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AE66CF979
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjC3DO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjC3DO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:14:26 -0400
X-Greylist: delayed 1806 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Mar 2023 20:14:24 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A85049DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8d2RC
        YNDIXr6756GiCOcfx1vlYA1Qq3ORopeipaxK0Y=; b=NsLlgQhii0w4X/7Pqwqvp
        WrA93SHA853/GNqiwTV7UMQ/9Huja226YUzRhoWX6CVtBCHKfcQ5mRfVdtjshthG
        Tj4XtOSuUAodCYIkxT/d/z64E5vsdTnOzMc57XZ6jKVBhJZLmYSy/o4rqwpqJzXz
        e8C2pGBndm6w+qHil2Ybxk=
Received: from localhost.localdomain (unknown [119.3.119.21])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wD3kKNr9yRkNmERAw--.63589S2;
        Thu, 30 Mar 2023 10:43:56 +0800 (CST)
From:   Qiang Ning <qning0106@126.com>
To:     lee@kernel.org, qning0106@126.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MFD: dln2: fix memory leak in dln2_probe
Date:   Thu, 30 Mar 2023 10:43:53 +0800
Message-Id: <20230330024353.4503-1-qning0106@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3kKNr9yRkNmERAw--.63589S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw45ArWfWryxtFyrAry8AFb_yoWxZwbE9w
        n7uw47Xw4Dtr47Kry7ArZa9ryFqF1Fgrs7Arsaka9xJayYva45WFWqqay7Gr4rZFWUAFn8
        Jw1ktr1Sy3W5ZjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjnjjJUUUUU==
X-Originating-IP: [119.3.119.21]
X-CM-SenderInfo: xtql0waqrqlqqrswhudrp/1tbiuA5CmGJVmjYuSgAAsT
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dln2_setup_rx_urbs() in dln2_probe() fails, error out_free
forgets to call  usb_put_dev to decrease the refcount of
dln2->usb_dev.

Fix this by adding usb_put_dev() in the error handling code
of dln2_probe().

Signed-off-by: Qiang Ning <qning0106@126.com>
---
 drivers/mfd/dln2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 6cd0b0c752d6..c3149729cec2 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -827,6 +827,7 @@ static int dln2_probe(struct usb_interface *interface,
 	dln2_stop_rx_urbs(dln2);
 
 out_free:
+	usb_put_dev(dln2->usb_dev);
 	dln2_free(dln2);
 
 	return ret;
-- 
2.25.1

