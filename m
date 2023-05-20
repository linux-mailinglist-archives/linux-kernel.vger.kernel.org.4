Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A2B70A646
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 10:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjETIFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 04:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjETIFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 04:05:13 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080C51AC
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 01:05:11 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 0HaPqGwrCcjUo0HaPqpKsf; Sat, 20 May 2023 10:05:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684569910;
        bh=FbFOTo7bbOqLCpse5mxCwFCHaJIvxu1hx1VMbc9WcyM=;
        h=From:To:Cc:Subject:Date;
        b=qdMsTmyonGN4tbdfAOPFZbo+BSHaTAIcTWJzN2NC6vs4YHHkOyEkNkY4XoDQg3JDs
         3Jrwx6PbOR+8JAyxXuxaNTZ1CjT29AYgT4obgLcaCy6vpUXF7gaNRgJfKl31kOQ15z
         HE/fFAysTZ8iN5Bl1m79+DZO3hujEUMEIMyDLzEn75CZOJ9IgIlZTBS+boHFKzbR1T
         VYVeRs/bOElY2UI0AiCoth7u2WAmrxeAwMbDon39eAcHDngCKycr9bot5/JmsOEywx
         7bStQcNkoXiMv6h5vkHwClIsk5rEJznzt37cALRrE1HgXWoOHKHItV9GU5zeQLtC07
         +VcWt7T5QjsLA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 10:05:10 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Kalle Valo <kvalo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org
Subject: [PATCH wireless] wl3501_cs: Fix an error handling path in wl3501_probe()
Date:   Sat, 20 May 2023 10:05:08 +0200
Message-Id: <7cc9c9316489b7d69b36aeb0edd3123538500b41.1684569865.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should wl3501_config() fail, some resources need to be released as already
done in the remove function.

Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/wireless/legacy/wl3501_cs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/legacy/wl3501_cs.c b/drivers/net/wireless/legacy/wl3501_cs.c
index 7fb2f9513476..c45c4b7cbbaf 100644
--- a/drivers/net/wireless/legacy/wl3501_cs.c
+++ b/drivers/net/wireless/legacy/wl3501_cs.c
@@ -1862,6 +1862,7 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 {
 	struct net_device *dev;
 	struct wl3501_card *this;
+	int ret;
 
 	/* The io structure describes IO port mapping */
 	p_dev->resource[0]->end	= 16;
@@ -1873,8 +1874,7 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 
 	dev = alloc_etherdev(sizeof(struct wl3501_card));
 	if (!dev)
-		goto out_link;
-
+		return -ENOMEM;
 
 	dev->netdev_ops		= &wl3501_netdev_ops;
 	dev->watchdog_timeo	= 5 * HZ;
@@ -1887,9 +1887,15 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 	netif_stop_queue(dev);
 	p_dev->priv = dev;
 
-	return wl3501_config(p_dev);
-out_link:
-	return -ENOMEM;
+	ret = wl3501_config(p_dev);
+	if (ret)
+		goto out_free_etherdev;
+
+	return 0;
+
+out_free_etherdev:
+	free_netdev(dev);
+	return ret;
 }
 
 static int wl3501_config(struct pcmcia_device *link)
-- 
2.34.1

