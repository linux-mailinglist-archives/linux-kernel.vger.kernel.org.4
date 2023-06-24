Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA3E73C68B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 05:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFXD0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 23:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFXD0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 23:26:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC371B9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 20:26:30 -0700 (PDT)
X-QQ-mid: bizesmtp73t1687577181tb6gbdfh
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 24 Jun 2023 11:26:20 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: ZdHcY4j9T+LMhqKHibX+gEym75LAizUeDwYPbOc+hBMYZZB/hIeGJqbOmbemd
        GsBRNduMYrhwB+Xycx9/oc+AAULh/ZqzZFZiHvkWNiRlIbIz9vJo5vlY0JUL6pb9mqEiAD5
        kCkzc7DWNUOMMZzRoPnkMR9fzdjkXRTUWyMc3o6vsVYx1Ti99jvbu5x0q2Szc1TiQ51TnfJ
        HfJPWZlVwFAQRgdDxDxvtIExDf2AWqdBgfWQ+dO20QXI//G9Cek12DyLYSAMYLKbFvBh6+7
        F93bCs6F4+YtB0sUj8DH0gr3LX119iyO7F5ZNfWr5ZwwYk0DmYzRIK0xitJAe3JVGMrvIiW
        rFGqVFNNqufSVbVbgU=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14577591654747292187
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH] memblock: report failures when memblock_can_resize is not set
Date:   Sat, 24 Jun 2023 11:26:07 +0800
Message-Id: <20230624032607.921173-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers of memblock_reserve() do not check the return value
presuming that memblock_reserve() always succeeds, but there are
cases where it may fail.

Having numerous memblock reservations at early boot where
memblock_can_resize is unset may exhaust the INIT_MEMBLOCK_REGIONS sized
memblock.reserved regions array and an attempt to double this array via
memblock_double_array() will fail and will return -1 to the caller.

When this happens the system crashes anyway, but it's hard to identify
the reason for the crash.

Add a panic message to memblock_double_array() to aid debugging of the
cases when too many regions are reserved before memblock can resize
memblock.reserved array.

Link: https://lore.kernel.org/linux-kernel/20230614131746.3670303-1-songshuaishuai@tinylab.org/
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 3feafea06ab2..1b8e902490e5 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -419,7 +419,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 	 * of memory that aren't suitable for allocation
 	 */
 	if (!memblock_can_resize)
-		return -1;
+		panic("memblock: cannot resize %s array\n", type->name);
 
 	/* Calculate new doubled size */
 	old_size = type->max * sizeof(struct memblock_region);
-- 
2.20.1

