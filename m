Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589DA70A628
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 09:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjETH3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 03:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjETH3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 03:29:52 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F93F7
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 00:29:50 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 0H2BqV9zozy2w0H2BqUapd; Sat, 20 May 2023 09:29:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684567788;
        bh=ID4WM8xku7YVOObLJl5OYwASYrgepFft1NaI5Zy1PNI=;
        h=From:To:Cc:Subject:Date;
        b=VmU0kId+aJ2dOQ4oUsxNlyGPlcgguYRiJ97KQDbabwsqqkP9HVq8RHBFL2mMS5dSP
         QdxM487/11CkfUKMVBAo0GX+dtyeJudmly5g7RL/p/jYeFSp1faJZ9NVWNgHljIGPA
         EXCirkDw9g1S7iP5vGjAQ8R9l6SBSj3kEbcCg+TqQBfyIUSwSzfBo/nhiIGaeuOr00
         3693OtpJyjGA+AdIHYEy7VUNP2w2J417ZHa/x9o3B/JE/0mB2u83wJ1toAnugLLTr1
         SWjBHXWgAD/S3e+Dx/DkS1izhU9s8I9xOJTqH5UuvP8+gm5xQ/6Sf3kDyfpYYxtz8I
         rTffN2ZNbXB9Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 09:29:48 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Kalle Valo <kvalo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org
Subject: [PATCH wireless] orinoco: Fix an error handling path in spectrum_cs_probe()
Date:   Sat, 20 May 2023 09:29:46 +0200
Message-Id: <c0bc0c21c58ca477fc5521607615bafbf2aef8eb.1684567733.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should spectrum_cs_config() fail, some resources need to be released as
already done in the remove function.

While at it, remove a useless and erroneous comment. The probe is
spectrum_cs_probe(), not spectrum_cs_attach().

Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/wireless/intersil/orinoco/spectrum_cs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/spectrum_cs.c b/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
index 291ef97ed45e..841d623c621a 100644
--- a/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
+++ b/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
@@ -157,6 +157,7 @@ spectrum_cs_probe(struct pcmcia_device *link)
 {
 	struct orinoco_private *priv;
 	struct orinoco_pccard *card;
+	int ret;
 
 	priv = alloc_orinocodev(sizeof(*card), &link->dev,
 				spectrum_cs_hard_reset,
@@ -169,8 +170,16 @@ spectrum_cs_probe(struct pcmcia_device *link)
 	card->p_dev = link;
 	link->priv = priv;
 
-	return spectrum_cs_config(link);
-}				/* spectrum_cs_attach */
+	ret = spectrum_cs_config(link);
+	if (ret)
+		goto err_free_orinocodev;
+
+	return 0;
+
+err_free_orinocodev:
+	free_orinocodev(priv);
+	return ret;
+}
 
 static void spectrum_cs_detach(struct pcmcia_device *link)
 {
-- 
2.34.1

