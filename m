Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CBE5BE503
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiITL4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiITL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:56:27 -0400
X-Greylist: delayed 334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 04:56:25 PDT
Received: from mail.shift-gmbh.com (mail.shift-gmbh.com [85.10.195.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F4972B6F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:56:25 -0700 (PDT)
From:   Alexander Martinz <amartinz@shiftphones.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shiftphones.com;
        s=2018; t=1663674647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JdCKIiMawSXSr/ZxXwJIlTkA59Lh2PFjI0W5CYJC9RA=;
        b=Oy25ZJFAPBlITWreVJNBxwVorcY09ry9IH4vuAk9eXuQmo7WvUkUljXdxXkKsiLzgrK1Oj
        mtj1iKxA77CpbD+di4xO2M3SBW1nMSYv7zLqp7oY5SqRrXC7LR77JNyOdERsuvlnot9bC6
        dwL1CorJcZ3XcATKLg6dVRc5niJQS+v+FI5WTo610UeNFz1+UM7lnh9x6sjhgXqTRnL774
        fOEn7VLneK9INT42/oux/Vb811cndcg6Q9uiPx1vbdLpoky73U6vGvaNERFkwfEgLRudmz
        q7Iagwe6+0WMflIEg2XtSaeDvA/fw7FdnfTnhbV1kjGxSk+m4tngUnSSQi5TCw==
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Alexander Martinz <amartinz@shiftphones.com>
Subject: [PATCH] ASoC: codecs: tfa989x: fix register access comments
Date:   Tue, 20 Sep 2022 13:50:14 +0200
Message-Id: <20220920115014.952062-1-amartinz@shiftphones.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=amartinz@shiftphones.com smtp.mailfrom=amartinz@shiftphones.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comments regarding register access based on review feedback[1].

[1]: https://lore.kernel.org/all/YppQ7BiqlBDMNsuc@gerhold.net/

Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
---
 sound/soc/codecs/tfa989x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tfa989x.c b/sound/soc/codecs/tfa989x.c
index 1c27429b9af6..b853507e65a8 100644
--- a/sound/soc/codecs/tfa989x.c
+++ b/sound/soc/codecs/tfa989x.c
@@ -193,7 +193,7 @@ static int tfa9890_init(struct regmap *regmap)
 {
 	int ret;
 
-	/* unhide keys to allow updating them */
+	/* temporarily allow access to hidden registers */
 	ret = regmap_write(regmap, TFA989X_HIDE_UNHIDE_KEY, 0x5a6b);
 	if (ret)
 		return ret;
@@ -203,7 +203,7 @@ static int tfa9890_init(struct regmap *regmap)
 	if (ret)
 		return ret;
 
-	/* hide keys again */
+	/* hide registers again */
 	ret = regmap_write(regmap, TFA989X_HIDE_UNHIDE_KEY, 0x0000);
 	if (ret)
 		return ret;
-- 
2.37.3

