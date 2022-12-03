Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F35B641477
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiLCGRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLCGRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:17:21 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EF1C0556;
        Fri,  2 Dec 2022 22:17:19 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NPKNF1BcVz4xq1v;
        Sat,  3 Dec 2022 14:17:17 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 2B36HEQM087245;
        Sat, 3 Dec 2022 14:17:14 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Sat, 3 Dec 2022 14:17:16 +0800 (CST)
Date:   Sat, 3 Dec 2022 14:17:16 +0800 (CST)
X-Zmail-TransId: 2b04638ae9ec672f7cfb
X-Mailer: Zmail v1.0
Message-ID: <202212031417162803709@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <tsbogend@alpha.franken.de>
Cc:     <julia.lawall@inria.fr>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIE1JUFM6IE9DVEVPTjogY3ZteC1ib290bWVtOiB1c2Ugc3Ryc2NweSgpIHRvIGluc3RlYWQgb2YKIHN0cm5jcHkoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B36HEQM087245
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638AE9ED.000 by FangMail milter!
X-FangMail-Envelope: 1670048237/4NPKNF1BcVz4xq1v/638AE9ED.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638AE9ED.000/4NPKNF1BcVz4xq1v
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index 306cee07ce3f..334bf8e577e5 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -780,9 +780,8 @@ int64_t cvmx_bootmem_phy_named_block_alloc(uint64_t size, uint64_t min_addr,
 	if (addr_allocated >= 0) {
 		named_block_desc_ptr->base_addr = addr_allocated;
 		named_block_desc_ptr->size = size;
-		strncpy(named_block_desc_ptr->name, name,
+		strscpy(named_block_desc_ptr->name, name,
 			cvmx_bootmem_desc->named_block_name_len);
-		named_block_desc_ptr->name[cvmx_bootmem_desc->named_block_name_len - 1] = 0;
 	}

 	if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
-- 
2.15.2
