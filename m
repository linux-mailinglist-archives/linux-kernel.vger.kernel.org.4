Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F1D70A637
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 09:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjETHxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 03:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjETHxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 03:53:23 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFBD1BD
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 00:53:21 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 0HOvqGVAANhDH0HOvqRvZf; Sat, 20 May 2023 09:53:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684569199;
        bh=MDlJlO33FY7uj3rYCO/3V6AqX7RWZP0/+LeG854Chsc=;
        h=From:To:Cc:Subject:Date;
        b=jbenmieo8P8YlN9wS/QLbCsv9uEoQ7tJqUvY7qyi3nF6wSoyhO5PgDLIXXDUDyMjc
         jsYG1YuaOQgtBKopDT4Bb+5s+KWvYnIxNs0AxFdMRf2RDl004R3CdPhFfIT8KfFhL/
         P/kLYo6sJf1aQ+5VwNkW1vfzkl4fkL1xaYAR3iUdAyckZBXGpGrIufzgSK7jEAYQtu
         qDVqAz4ysyop4F0JdBzQunwfQPHY9ytaikY7ed3UVQXjoNCXbizRkF+PHnMbhGx3Cx
         oJCbeoZyYzLYd2ycq16z03kHWmi+V57IPBh4FSRIg11CxWWlgOcpv21Gd8XcKu+R/J
         nEegtuJT0KSeA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 09:53:19 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Simon Kelley <simon@thekelleys.org.uk>,
        Kalle Valo <kvalo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org
Subject: [PATCH wireless] atmel: Fix an error handling path in atmel_probe()
Date:   Sat, 20 May 2023 09:53:14 +0200
Message-Id: <1e65f174607a83348034197fa7d603bab10ba4a9.1684569156.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should atmel_config() fail, some resources need to be released as already
done in the remove function.

While at it, remove a useless and erroneous comment. The probe is
atmel_probe(), not atmel_attach().

Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/wireless/atmel/atmel_cs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/atmel/atmel_cs.c b/drivers/net/wireless/atmel/atmel_cs.c
index 453bb84cb338..58bba9875d36 100644
--- a/drivers/net/wireless/atmel/atmel_cs.c
+++ b/drivers/net/wireless/atmel/atmel_cs.c
@@ -72,6 +72,7 @@ struct local_info {
 static int atmel_probe(struct pcmcia_device *p_dev)
 {
 	struct local_info *local;
+	int ret;
 
 	dev_dbg(&p_dev->dev, "atmel_attach()\n");
 
@@ -82,8 +83,16 @@ static int atmel_probe(struct pcmcia_device *p_dev)
 
 	p_dev->priv = local;
 
-	return atmel_config(p_dev);
-} /* atmel_attach */
+	ret = atmel_config(p_dev);
+	if (ret)
+		goto err_free_priv;
+
+	return 0;
+
+err_free_priv:
+	kfree(p_dev->priv);
+	return ret;
+}
 
 static void atmel_detach(struct pcmcia_device *link)
 {
-- 
2.34.1

