Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1115B9205
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiIOBKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIOBKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:10:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF928A1F5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:10:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z13so10786759edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=C8YX0mpn5wJvdRMjC0H+NlN1/cczuzhRDrtXSWr5rfs=;
        b=OSdzypJlB8eJgARh0kcN8YDg2KlP8r6ObxReEKiRm6qU6aDraRoJ8+whXJsRbghfKg
         Bsz5NUu4vHnA+I8qATPtyiBkFPuKGbAUXebUUwOpxnE/RSpRlhjmAmvRpgxCu8EBNcpm
         crcaZVc1SC5MnjjA+e8BT9AbrnCO6RtvElLp2lYILDSDKKHTL4+l5V+lGmEvlRNRj7HS
         2n+s6M+MFew9hwLiVfAcHjIGi3F5mot6WwHdB2BGxhYgzYFkXXRTS5NTjvfWkVoJS19L
         5JUCK6KCzTscFYCmVTqGyPDc5cnnWLaz0JtKDZ5f/kHDMxzt2G94N2t1uYl4Wd6rhEwi
         5iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=C8YX0mpn5wJvdRMjC0H+NlN1/cczuzhRDrtXSWr5rfs=;
        b=JYafDxRYGuBfPrxGnispN0hW1Gok1xYddJfWDcnA9MJkNGsS/+DFPPlbF32HskYZfX
         mZEABfXP+WwhV3vvG6GYTa9DjJj1qagf+EPFq0IbMrk7Cxt9e5XzCv6UK3erSD0XnYYF
         Dy4MwGetWlbojbUO4dQD0DPKCLnc8jAjpg8SvpOYQwWAumn0KE7bv4QwaouRFfSMailP
         MwB5xPNTz6210Kn73Y40KVcQFlig2SjrQTJYZs7GmNI999XqmK7JUvMpsXLQG0tKC9bl
         HYFJ2sx93MnFyahDWsQg5hiS+2PGQkdJD3Y+r6R5xcguVgEVhQiFbP6jaX+KfBzDhoPn
         0CSw==
X-Gm-Message-State: ACgBeo3xhY9j2I5NGxu4h6WOoMphp9n4S/8ES8FutFtlF3PkJWBRbkYq
        hITv4U8DPRBCfOq7vLmqog0fUVUp+PvztQ==
X-Google-Smtp-Source: AA6agR4p8n8f899XACXY1vIl8JB5u31hvFH/z5t9QYXlwjC0aXC5I+jff2/OvdLFs+4cWOTWCy+rwA==
X-Received: by 2002:aa7:d34e:0:b0:44e:8d4b:6e02 with SMTP id m14-20020aa7d34e000000b0044e8d4b6e02mr33454254edr.306.1663204218057;
        Wed, 14 Sep 2022 18:10:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090653da00b00779a605c777sm8296291ejo.192.2022.09.14.18.10.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Sep 2022 18:10:17 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org, richard.weiyang@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [Patch v2 1/2] XArray: make xa_dump output more friendly to read
Date:   Thu, 15 Sep 2022 01:09:56 +0000
Message-Id: <20220915010957.25506-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220912124647.17164-1-richard.weiyang@gmail.com>
References: <20220912124647.17164-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch helps to adjust xa_dump output by:

  * add an index to each entry
  * add indent to each entry

Then the output would look like:

[ 0]0-4095: node ffff938e16539b60 max 19 parent 0000000000000000 shift 6 count 48 values 48 array ffffffffc05e1280 list ffff938e16539b78 ffff938e16539b78 marks 0 0 0
  [ 0]0-63: value 0 (0x0) [0000000000000001]
  [ 1]64-127: sibling (slot 0)
  [ 2]128-191: sibling (slot 0)
  [ 3]192-255: sibling (slot 0)
  [ 4]256-319: sibling (slot 0)
  [ 5]320-383: sibling (slot 0)
  [ 6]384-447: sibling (slot 0)
  [ 7]448-511: sibling (slot 0)
  [ 8]512-575: sibling (slot 0)
  [ 9]576-639: sibling (slot 0)
  [10]640-703: sibling (slot 0)
  [11]704-767: sibling (slot 0)
  [12]768-831: sibling (slot 0)
  [13]832-895: sibling (slot 0)
  [14]896-959: sibling (slot 0)
  [15]960-1023: sibling (slot 0)
  [32]2048-2111: value 2048 (0x800) [0000000000001001]
  [33]2112-2175: sibling (slot 32)
  [34]2176-2239: sibling (slot 32)
  [35]2240-2303: sibling (slot 32)
  [36]2304-2367: sibling (slot 32)
  [37]2368-2431: sibling (slot 32)
  [38]2432-2495: sibling (slot 32)
  [39]2496-2559: sibling (slot 32)
  [40]2560-2623: sibling (slot 32)
  [41]2624-2687: sibling (slot 32)
  [42]2688-2751: sibling (slot 32)
  [43]2752-2815: sibling (slot 32)
  [44]2816-2879: sibling (slot 32)
  [45]2880-2943: sibling (slot 32)
  [46]2944-3007: sibling (slot 32)
  [47]3008-3071: sibling (slot 32)

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/xarray.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 1ddcfa8c86ac..ed50a26d97a3 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -2235,19 +2235,22 @@ void xa_dump_node(const struct xa_node *node)
 
 void xa_dump_index(unsigned long index, unsigned int shift)
 {
+	pr_cont("[%2lu]", (index >> shift) & XA_CHUNK_MASK);
 	if (!shift)
-		pr_info("%lu: ", index);
+		pr_cont("%lu: ", index);
 	else if (shift >= BITS_PER_LONG)
-		pr_info("0-%lu: ", ~0UL);
+		pr_cont("0-%lu: ", ~0UL);
 	else
-		pr_info("%lu-%lu: ", index, index | ((1UL << shift) - 1));
+		pr_cont("%lu-%lu: ", index, index | ((1UL << shift) - 1));
 }
 
-void xa_dump_entry(const void *entry, unsigned long index, unsigned long shift)
+void xa_dump_entry(const void *entry, unsigned long index, unsigned long shift,
+			int level)
 {
 	if (!entry)
 		return;
 
+	pr_info("%*s", level * 2, level ? " " : "");
 	xa_dump_index(index, shift);
 
 	if (xa_is_node(entry)) {
@@ -2259,7 +2262,8 @@ void xa_dump_entry(const void *entry, unsigned long index, unsigned long shift)
 			xa_dump_node(node);
 			for (i = 0; i < XA_CHUNK_SIZE; i++)
 				xa_dump_entry(node->slots[i],
-				      index + (i << node->shift), node->shift);
+				      index + (i << node->shift), node->shift,
+				      level + 1);
 		}
 	} else if (xa_is_value(entry))
 		pr_cont("value %ld (0x%lx) [%px]\n", xa_to_value(entry),
@@ -2286,6 +2290,6 @@ void xa_dump(const struct xarray *xa)
 			xa_marked(xa, XA_MARK_1), xa_marked(xa, XA_MARK_2));
 	if (xa_is_node(entry))
 		shift = xa_to_node(entry)->shift + XA_CHUNK_SHIFT;
-	xa_dump_entry(entry, 0, shift);
+	xa_dump_entry(entry, 0, shift, 0);
 }
 #endif
-- 
2.33.1

