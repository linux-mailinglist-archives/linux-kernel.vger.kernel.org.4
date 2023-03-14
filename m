Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319D36B9C51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCNQ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCNQ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:57:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D27EB1B15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:57:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p20so17230519plw.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678813040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LB8MWU2Hm0ZiL9jPwlOLKYQoV05YgDk89LehIOOmSjM=;
        b=IIU1BhgNFxlf2ziyTy8PzecK/9HchT9bH4w0LbY5+cOeFVsDTsvUqWFaKPBXBEYHtA
         ZkgO/V0Gr0KeGGFhN7cFjEPBg3dmnAMWC4QUJ7Bv4S/BDoa9dHNnE3YWhEwOqYurtCGr
         pmh4cBzvm4hem9Piz0a5aJMtt+yFE15yT3oOep6UvP1GR7CTk/DD0Nl5ywOnkb1KmJFn
         Nnb2e8Yx+kre2sC4o30GYR1q1YHxb1xnoUdBIp8k13GjcT14TDrwTBTVM7SO3P7zfaDu
         O6jtddKufx8QMRfqiaF2u3sVI4R8YHh+EUQJo2HEUALbFb9hqkFL+6Ig6o5QY33AMex/
         ZDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678813040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LB8MWU2Hm0ZiL9jPwlOLKYQoV05YgDk89LehIOOmSjM=;
        b=wrCQR7hbbWOHF15fP8j4NJq8o83B4c/800vHAIOFtaOlZy+jnJ0ObUwJYSH7IdBD2E
         TKLfGblOjRy7x9490fCU7Z0tmNGdBfLoHzqHkWa93+jJViqZRBllPXZwGkgSfy0nn6SE
         8c4aw5IDTUx1OkZewe2oLtMHKd9bYX33CD47GMb8m0T3nAF4n9SY+UuKgveACAYLeTpi
         INHEq8NJkXvQdiv9M0Lz+SMNpoBy/lZnc0PvtdNqFOs56qEw6HBfaq1pivJvJWnX3FLA
         yCk1sEq7TkqkCJw0ESh3ZztgUC5V7ZMLroPD3Mx/YAWV5tO9P/41mWDmPFR7QioyPGOy
         rh+Q==
X-Gm-Message-State: AO0yUKXUOzIO6uVncKaaoDXdQERT85cJRhScKcxmRXTBFwONZ91Dlbrp
        xi0p887bJKYVjFES+9W3+po=
X-Google-Smtp-Source: AK7set+jfaxHUgf05hZano5aRwyEzdwpVZsZU4gNfr7/moh7OsLMfGd1Est7CaPK7BPESRxumz0NMQ==
X-Received: by 2002:a05:6a21:78a8:b0:d4:5d11:8ca7 with SMTP id bf40-20020a056a2178a800b000d45d118ca7mr8415447pzc.31.1678813040265;
        Tue, 14 Mar 2023 09:57:20 -0700 (PDT)
Received: from localhost.localdomain ([183.157.110.65])
        by smtp.gmail.com with ESMTPSA id c26-20020aa78e1a000000b005809d382016sm1869658pfr.74.2023.03.14.09.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 09:57:19 -0700 (PDT)
From:   Bang Li <libang.linuxer@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bang Li <libang.linuxer@gmail.com>
Subject: [PATCH] mtdblock: tolerate corrected bit-flips
Date:   Wed, 15 Mar 2023 00:56:53 +0800
Message-Id: <20230314165653.252673-1-libang.linuxer@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtd_read() may return -EUCLEAN in case of corrected bit-flips.This
particular condition should not be treated like an error.

Signed-off-by: Bang Li <libang.linuxer@gmail.com>
---
 drivers/mtd/mtdblock_ro.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdblock_ro.c b/drivers/mtd/mtdblock_ro.c
index 7c51952ce55d..66ffc9f1ead2 100644
--- a/drivers/mtd/mtdblock_ro.c
+++ b/drivers/mtd/mtdblock_ro.c
@@ -16,8 +16,10 @@ static int mtdblock_readsect(struct mtd_blktrans_dev *dev,
 			      unsigned long block, char *buf)
 {
 	size_t retlen;
+	int err;
 
-	if (mtd_read(dev->mtd, (block * 512), 512, &retlen, buf))
+	err = mtd_read(dev->mtd, (block * 512), 512, &retlen, buf);
+	if (err && !mtd_is_bitflip(err))
 		return 1;
 	return 0;
 }
-- 
2.25.1

