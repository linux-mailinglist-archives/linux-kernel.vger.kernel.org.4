Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBBA6C7752
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjCXF0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjCXFZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:25:34 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0DD11C5BC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8PuRO
        ycIaintbBO8Gz+e23AedvlGXHAFLlGqQ+rvl0Q=; b=lq37kYFvwhX1c9BBZkA4I
        3/u3EDrSg6Jei/jrFeaLaVAt2B+OfiC/36VUKZewyMfGSCJKMr8X8qqwy4lKJhav
        1lucxZODgXx+vqHr6g8OyXIip6XHZv9qDSvgRtV8yfEq923akVBEgZe+kygpX6AH
        ldRahxf8g6Zk/ExBf56A0Y=
Received: from localhost.localdomain (unknown [113.105.127.219])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wAH1eHxMx1k5BH_AA--.26874S2;
        Fri, 24 Mar 2023 13:24:03 +0800 (CST)
From:   Hongbin Ji <jhb_ee@163.com>
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hongbin Ji <jhb_ee@163.com>
Subject: [PATCH] memblock: Correct calculation method for overflowing range @size
Date:   Fri, 24 Mar 2023 13:23:51 +0800
Message-Id: <20230324052351.31106-1-jhb_ee@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAH1eHxMx1k5BH_AA--.26874S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF18Wr1UJFyxZry5Xw17trb_yoWfCrb_Wa
        18tr4xCw1kJr4YkrySv3y0kF4Iq3yftF95ZF17Jr17ZFW5J3WrW3WxWryxX390k3WUX398
        Ca1DWry7ZF1fKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtq2NJUUUUU==
X-Originating-IP: [113.105.127.219]
X-CM-SenderInfo: 5mkesvrh6rljoofrz/1tbiShA4fGI0XGYvewABsn
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memblock users to specify range where @base + @size overflows
and automatically cap it at maximum, The new size should be
PHYS_ADDR_MAX - @base + 1.

Assuming that base is 0, PHYS_ADDR_MAX is 0xff, which is 255 in decimal,
then @size should be 256 instead of 255

Signed-off-by: Hongbin Ji <jhb_ee@163.com>
---
 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 25fd0626a9e7..f1683d1dae65 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -169,7 +169,7 @@ static enum memblock_flags __init_memblock choose_memblock_flags(void)
 /* adjust *@size so that (@base + *@size) doesn't overflow, return new size */
 static inline phys_addr_t memblock_cap_size(phys_addr_t base, phys_addr_t *size)
 {
-	return *size = min(*size, PHYS_ADDR_MAX - base);
+	return *size = min(*size, PHYS_ADDR_MAX - base + 1);
 }
 
 /*
-- 
2.34.1

