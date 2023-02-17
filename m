Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F0A69AC59
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBQNYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQNYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:24:40 -0500
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C2267452;
        Fri, 17 Feb 2023 05:24:36 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 17 Feb
 2023 16:24:34 +0300
Received: from KANASHIN1.fintech.ru (10.0.253.125) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 17 Feb
 2023 16:24:34 +0300
From:   Natalia Petrova <n.petrova@fintech.ru>
To:     Andreas Noever <andreas.noever@gmail.com>
CC:     Natalia Petrova <n.petrova@fintech.ru>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
Subject: [PATCH] thunderbolt_tb: add check for return value of 'tb_switch_find_port'
Date:   Fri, 17 Feb 2023 16:24:32 +0300
Message-ID: <20230217132432.487106-1-n.petrova@fintech.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.125]
X-ClientProxiedBy: Ex16-01.fintech.ru (10.0.10.18) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return value of 'tb_switch_find_port' has to be checked to avoid
null pointer dereferences in functions tb_tunnel_alloc_dma() and
tb_port_info().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 386e5e29d81c ("thunderbolt: Make tb_find_port() available to other files")
Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
---
 drivers/thunderbolt/tb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 9853f6c7e81d..5d6cded68d46 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1156,6 +1156,8 @@ static int tb_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd,
 	sw = tb_to_switch(xd->dev.parent);
 	dst_port = tb_port_at(xd->route, sw);
 	nhi_port = tb_switch_find_port(tb->root_switch, TB_TYPE_NHI);
+	if (!nhi_port)
+		return -EIO;
 
 	mutex_lock(&tb->lock);
 	tunnel = tb_tunnel_alloc_dma(tb, nhi_port, dst_port, transmit_path,
-- 
2.34.1

