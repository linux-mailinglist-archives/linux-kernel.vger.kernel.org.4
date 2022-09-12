Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20865B5A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiILMxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:53:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188452F016
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:53:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so19876816ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tOIlfPq2ElXkUCEyu7N3MrXzejnmLtvuNl3d7obAAww=;
        b=VDqqWhb5ylht++1mGBIcektHyAi39C14PUmnBmfipT81ZE0GKP0mYt+ByPYWhh9TIA
         mS+6lii3yMInlQjzKVjZG+YoOvEORPwGOclbIrp1rjL8i8fcSKLUKoYet4oc5L/tG/i+
         1kUP2+uwVAiA0DpzU7N5NMAufs1621515n/gLBF+9o4G1d0IJN6/jtM463W3YJVQCm2j
         9mnG9+37ZHyGu8ilEKCsH2CI66t2xJJgj8/VBCFzoNLEX2oeIyV5Vjb4CaGlDMb50RLc
         uQe6K8iZHu03npo2fnkHpShdGGqsc36NMhWxF4i0YYDwVA+F+p17++fKOip6j7TG1QSP
         aA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tOIlfPq2ElXkUCEyu7N3MrXzejnmLtvuNl3d7obAAww=;
        b=YdLCExsH+EH04XKQDSZzYf1MeRL4Wumg0RsNiaKnRXbKuNsR7DeAiMbW5cWvZScCvo
         mDqEha8wE6l3kuh87lH9lKqT2zH6nZyeSgCG4x7CnMF5E7xLqMyz273Hdq3lhxiflK0s
         1/uG1JChZ5rMnnp3fxCsHoe2x6ex2QIDpNaHW9iY/sg88eRNuVt28VQQZ07Ds3T/EGEL
         Exx8ZW91x8zsPWzEZQvPvHdFs63IdfznirHjB8dRtRnrZ908vtL6Q3mibmSJcDCfkODu
         M7sTVDIBSZdrkOi9wMlZZR6E11JzAjgyXz7V2Qx4oBpty+ynr6fYdjcA+mgJRJFN5L9r
         Qa/w==
X-Gm-Message-State: ACgBeo3l17rNJGudXU5d4/Tp9BMKrgWijW+3xpXyL/vwl4VmVcewMN5R
        Xrl+/TRe8fKLdvJ53hbwLuwf5yClNug9og==
X-Google-Smtp-Source: AA6agR5QGV0R9nshpLwUMT4VuaykUqJh7cLtlG1AagueobJig4jwhSX+l4qD3RzKLW04aXTC2NRCZw==
X-Received: by 2002:a17:906:cc50:b0:777:5a19:2264 with SMTP id mm16-20020a170906cc5000b007775a192264mr13318732ejb.130.1662987180521;
        Mon, 12 Sep 2022 05:53:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id ku5-20020a170907788500b00773f3cb67ffsm4393119ejc.28.2022.09.12.05.52.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Sep 2022 05:52:59 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/2] XArray: make xa_dump output more friendly to read
Date:   Mon, 12 Sep 2022 12:46:46 +0000
Message-Id: <20220912124647.17164-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
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
index ea9ce1f0b386..326b73bb9811 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -2249,19 +2249,22 @@ void xa_dump_node(const struct xa_node *node)
 
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
@@ -2273,7 +2276,8 @@ void xa_dump_entry(const void *entry, unsigned long index, unsigned long shift)
 			xa_dump_node(node);
 			for (i = 0; i < XA_CHUNK_SIZE; i++)
 				xa_dump_entry(node->slots[i],
-				      index + (i << node->shift), node->shift);
+				      index + (i << node->shift), node->shift,
+				      level + 1);
 		}
 	} else if (xa_is_value(entry))
 		pr_cont("value %ld (0x%lx) [%px]\n", xa_to_value(entry),
@@ -2300,6 +2304,6 @@ void xa_dump(const struct xarray *xa)
 			xa_marked(xa, XA_MARK_1), xa_marked(xa, XA_MARK_2));
 	if (xa_is_node(entry))
 		shift = xa_to_node(entry)->shift + XA_CHUNK_SHIFT;
-	xa_dump_entry(entry, 0, shift);
+	xa_dump_entry(entry, 0, shift, 0);
 }
 #endif
-- 
2.33.1

