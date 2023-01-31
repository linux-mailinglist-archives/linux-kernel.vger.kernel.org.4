Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737E36829D7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjAaKC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAaKCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:02:24 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8794B4B6;
        Tue, 31 Jan 2023 02:02:19 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q5so13703645wrv.0;
        Tue, 31 Jan 2023 02:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQtD71MCuqdoYLyEkwguINUig+I6UC5jBNAWlEZAE74=;
        b=Xzw2nzSO1P6ENTdTvBc3HZWqUOTvaXqkGqa5xZniFKIVjoPM47DLx5iUVdPoYU0ePl
         /Y5UbUPocgpxeqkM1GodWs70YnnETJs7dJuicE4kGMZFK/i+fyETSyykEP2/KtrjITMv
         0qc++SMkUW7f9bz+HWY0AKGSmyWQcsQo3EWo99D5MDCWVELxnjEtyZYNNpugniWW4cjE
         LYhpqtwWuRT3M+cpMGZEY6Ty+qaIWSHB24UFR7up1AjAZzvjYXaN1PaAI1eXMGb5y8GB
         pBWhxFTMNXdqPwIoixuz5okvjoZBA3igr47ZS7oaa+JHk9XVm3uUnmHu4mq1pA4/rPND
         pevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQtD71MCuqdoYLyEkwguINUig+I6UC5jBNAWlEZAE74=;
        b=BdpxY5pHLzUzSZqRBEx1ztDbIRbJtKBlT7QAITJAITqgdN4zDxDwuBAeqVs6cZm9sh
         j+hRvyT7qUMMtHrQJcdJ5OYVNg4E1PsLOvZCk+6QBpJEXV7FaU5qiRbegY/1jeFDOX1u
         Z2097V6xRq7OYEo9/EURH/T82rsoDVq7fJ0po2lt4GUHAVC/B+BQAplbuyg2f2MPtnj4
         kol1XO7545FKODJcY79KerbR97vqfDd2vh9dw7OwmbvokBFWrO2IkuR699VEtHm/y7uj
         eEk+WXwavvcOwIsMWgK0ZUGGXkAfbsqUcy29TFjA9GofZa13mJmiVDJF/NWqu5R7Hp/Z
         ZDBA==
X-Gm-Message-State: AO0yUKVWT11QNZErgVxYdsPKyiAp9G/kW7fCM1khWaz0TxuKkx5R96Yc
        ilZcYgYpZ0kz1pE0L6BKyg4=
X-Google-Smtp-Source: AK7set99zuDW29NEW4bzQ7VrmGv4iF1XLdL3T9STAFE1oa1tmi3iLOxWH3RviNrVkdbl73H2weHuug==
X-Received: by 2002:adf:dd84:0:b0:27a:d81:1137 with SMTP id x4-20020adfdd84000000b0027a0d811137mr2379364wrl.38.1675159338147;
        Tue, 31 Jan 2023 02:02:18 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y3-20020adff143000000b002be546f947asm14353360wro.61.2023.01.31.02.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 02:02:17 -0800 (PST)
Date:   Tue, 31 Jan 2023 13:02:13 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] ALSA: pci: lx6464es: fix a debug loop
Message-ID: <Y9jnJTis/mRFJAQp@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This loop accidentally reuses the "i" iterator for both the inside and
the outside loop.  The value of MAX_STREAM_BUFFER is 5.  I believe that
chip->rmh.stat_len is in the 2-12 range.  If the value of .stat_len is
4 or more then it will loop exactly one time, but if it's less then it
is a forever loop.

It looks like it was supposed to combined into one loop where
conditions are checked.

Fixes: 8e6320064c33 ("ALSA: lx_core: Remove useless #if 0 .. #endif")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
v2: In the first version I just deleted the outside loop but that was
not the correct fix.  Combine the conditions instead.

 sound/pci/lx6464es/lx_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index d3f58a3d17fb..b5b0d43bb8dc 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -493,12 +493,11 @@ int lx_buffer_ask(struct lx6464es *chip, u32 pipe, int is_capture,
 		dev_dbg(chip->card->dev,
 			"CMD_08_ASK_BUFFERS: needed %d, freed %d\n",
 			    *r_needed, *r_freed);
-		for (i = 0; i < MAX_STREAM_BUFFER; ++i) {
-			for (i = 0; i != chip->rmh.stat_len; ++i)
-				dev_dbg(chip->card->dev,
-					"  stat[%d]: %x, %x\n", i,
-					    chip->rmh.stat[i],
-					    chip->rmh.stat[i] & MASK_DATA_SIZE);
+		for (i = 0; i < MAX_STREAM_BUFFER && i < chip->rmh.stat_len;
+		     ++i) {
+			dev_dbg(chip->card->dev, "  stat[%d]: %x, %x\n", i,
+				chip->rmh.stat[i],
+				chip->rmh.stat[i] & MASK_DATA_SIZE);
 		}
 	}
 
-- 
2.35.1

