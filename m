Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846EF714435
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjE2GVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjE2GVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:21:23 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD436B1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:21:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53f8da65701so386992a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685341282; x=1687933282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/cHDpwc28ZZjHBwUVLQXbchHSi6eHYMpanfKaLsNQE=;
        b=Byamjtd2kq7YFAJ6v1H6OE4Ifg2G2rAICj1mu49zs/QvpmtxO+V7Qi9lzuoQWQyfnK
         iVTbFe5qr1yNuRyLEiazUy6mewi3ij3bTViGFIlGl5SYXYAY3nTYQTxkj+XSdR4umfRs
         +eIhCi4rR7MiM5JCC48LNJ/101t5vgmu2KMhUgV7gCICTBkXqDFH9ATzDlDVh3pRxwjE
         IcGuOaFaBgJuKf7/GxmFQh6Glwwb2lvIBOh8R7I7HWavF4U1D1uKAC8tEB5qMWGQqum+
         Bl2wDYBOia4ABFzx8nM5u0404RAeDFVlraNy2jEUX8D+dz1N4QENmiyvFyWmjss1BQqU
         pKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685341282; x=1687933282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/cHDpwc28ZZjHBwUVLQXbchHSi6eHYMpanfKaLsNQE=;
        b=edBX3HH4Drayvc8YptQ85ksJhk9msjpByhxU+Dfp+HXXpGcI1EQc4H5KvbMy+E0Aer
         cm52Fr3YROD4J2MQIpy+8mK7/ebNX3fJqIf3DOQwUdmBQBQYxvY6JA+qhh/GsaSm8Gi9
         3BtLGj6UUL1HjGrnxJa6GIOGoJMO/peIELAgrASzcmQKoxYfMEo2j0RvYUOeBuAUirdI
         YtKVeE8tZ3vSA9G902BwmeqwEDpQin6AtkZh6V/6HXwNevbCFlnjlHnk8TOkWIUn47aC
         xDXUMunR4dp2gfpi+fFz2a25QegmPSzyCnKM1SHCnm69/ZXkcqMeGpB4nCw8kyc2pw84
         VTag==
X-Gm-Message-State: AC+VfDwb6N0Mc6VqzrTsgvDAoPU1u9n/ZhOo4/uQUP78GSDDB507r+aA
        rkjvtlr5ifquFaETepLA/RqXfx5Zu4B+PA==
X-Google-Smtp-Source: ACHHUZ4P2WxrMfDhodFYq8vsUgQtfS830xOFwaxK4jmDVUsSHPlkYiqivJtnVbs99ROKDHWM6qvc0Q==
X-Received: by 2002:a17:902:da82:b0:1b0:2cd0:af3b with SMTP id j2-20020a170902da8200b001b02cd0af3bmr6965807plx.6.1685341282325;
        Sun, 28 May 2023 23:21:22 -0700 (PDT)
Received: from localhost.localdomain ([45.43.34.98])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f7d400b001aaed55aff3sm2922270plw.137.2023.05.28.23.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:21:21 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
To:     rppt@kernel.org, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, anshuman.khandual@arm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yuwei Guan <ssawgyw@gmail.com>
Subject: [PATCH] memblock: Update nid info in memblock debugfs
Date:   Mon, 29 May 2023 14:20:02 +0800
Message-Id: <20230529062002.157-1-ssawgyw@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node id for memblock reserved regions will be wrong,
so let's show 'x' for reg->nid == MAX_NUMNODES in debugfs to keep it align.

Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
---
 mm/memblock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index c5c80d9bcea3..3d449aaba052 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2169,17 +2169,21 @@ static int memblock_debug_show(struct seq_file *m, void *private)
 {
 	struct memblock_type *type = m->private;
 	struct memblock_region *reg;
-	int i, j;
+	int i, j, nid;
 	unsigned int count = ARRAY_SIZE(flagname);
 	phys_addr_t end;
 
 	for (i = 0; i < type->cnt; i++) {
 		reg = &type->regions[i];
 		end = reg->base + reg->size - 1;
+		nid = memblock_get_region_node(reg);
 
 		seq_printf(m, "%4d: ", i);
 		seq_printf(m, "%pa..%pa ", &reg->base, &end);
-		seq_printf(m, "%4d ", memblock_get_region_node(reg));
+		if (nid != MAX_NUMNODES)
+			seq_printf(m, "%4d ", nid);
+		else
+			seq_printf(m, "%4c ", 'x');
 		if (reg->flags) {
 			for (j = 0; j < count; j++) {
 				if (reg->flags & (1U << j)) {
-- 
2.34.1

