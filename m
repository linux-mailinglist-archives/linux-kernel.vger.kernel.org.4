Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46D626D29
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 01:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiKMA4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 19:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKMA4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 19:56:45 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D457813D6E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 16:56:44 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id a13so12589715edj.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 16:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0SikHTdUbXQLGro61wDie+oPkKhps+RKTwvHMmIsLg=;
        b=mw93TmEeH1gUrFjBnB2pV2QBDf+ZR6rzwh3OIkxUlRatK4s7HhNKVu7jXkoEG09aTI
         P0f8HQJhWzi4/70jiM86jX48e4C0NlM+4mMwlHpBlY0CCHhwjWCfghuNrhdqnS0bb71Z
         aBn1hfjfVeIPNv8JtPUW28yCoaIFakVMmzyOD97hJ25M5B15btMtjPK5ArTH+EjbCKTI
         CYxaNhakK1gZCX0CkGti6gNXeM8B+rkzZNOCw2vhMW1F/37bUPkyR2IrlXaxLcxTXZrO
         Y94Acve50lqRZ3eBoKOkVHEQjrTeyaqk/uZLWoOvkMZjudhlccgnHQR+7zQK25PjLoW8
         5CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0SikHTdUbXQLGro61wDie+oPkKhps+RKTwvHMmIsLg=;
        b=xctt+fIuc4B1YlVd7L2CdNhZg0i3JdfIoQacFUjTN+C973IkjuSwibJEkcFrUFrQAF
         LGOzemOcx81rhP1mU/q75s/rnM9CnACEKynLHWSXJkqDJlpT9xfJypAO2A1k6c35V1jY
         G6mVYFfrZClXFmw8gRiSxGlZX7DU9PCQZ4V6wbllN+ldNOQnDx+U7QVTkpORzd7XNNUo
         1Oc0MeyHS57KKYEd+P5BD+W4obJOzfXS7kEm7QbmKBc5wAYSUuho9Hzx2Z1mDLWTNj3q
         MABxDNYy9hqai6yNjmRCF6Yzv/qAE/5lMKgKKlzVb02AWxjwJJHlHmGbfIkjKpd9zll+
         8gxg==
X-Gm-Message-State: ANoB5pmWPMHPrRim4NcEKJ2nPgNQW9QIjUkahS/s2wXTD1+8UqVakusF
        Dhl7bEO1etF5WQWEHiZobT8=
X-Google-Smtp-Source: AA0mqf6tPkb9QZNuvbeDhu+w2qQFk0kdlva83w34GrD+f50KhRRKfHfA71q565q1rM7fvZj/AKdyJA==
X-Received: by 2002:a50:9eaa:0:b0:461:86b7:7627 with SMTP id a39-20020a509eaa000000b0046186b77627mr6974061edf.180.1668301003339;
        Sat, 12 Nov 2022 16:56:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id p25-20020a17090653d900b00779a605c777sm2398728ejo.192.2022.11.12.16.56.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Nov 2022 16:56:42 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH] maple_tree: not necessary to filter MAPLE_PARENT_ROOT since it is not a root
Date:   Sun, 13 Nov 2022 00:56:18 +0000
Message-Id: <20221113005618.29679-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Root node is return at the beginning, so we are sure bit 0 is not set.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9aad98c24f3e..f8c4755e7c75 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -436,7 +436,7 @@ enum maple_type mte_parent_enum(struct maple_enode *p_enode,
 		return 0; /* Validated in the caller. */
 
 	p_type &= MAPLE_NODE_MASK;
-	p_type = p_type & ~(MAPLE_PARENT_ROOT | mte_parent_slot_mask(p_type));
+	p_type = p_type & ~mte_parent_slot_mask(p_type);
 
 	switch (p_type) {
 	case MAPLE_PARENT_RANGE64: /* or MAPLE_PARENT_ARANGE64 */
-- 
2.33.1

