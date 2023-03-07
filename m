Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709A76ADA8A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCGJlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCGJlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:41:15 -0500
X-Greylist: delayed 1811 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Mar 2023 01:41:12 PST
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40F174FF1C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KImqK
        5nEPPgYeY4hktI2AGPAI+mlkHUTNmsY0A04dxQ=; b=RhIFI3vKCAvpoUObTXnXZ
        iecpcNGNoguAdVVLYvIrR8ErIb8xAVB6yDoZcAjdW+ASG3IP7LfnxbKwgj2cJkxY
        Q590jlBcsbxOa19RugU4wA09sah43pEdBJmJhr+ItccD6nIDCts2vhrjj5sHQoLo
        ZxQwRMuXHnpqtJM+VG589o=
Received: from localhost.localdomain (unknown [113.91.40.179])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wBXNNkC_wZkgKzZAg--.44696S2;
        Tue, 07 Mar 2023 17:08:20 +0800 (CST)
From:   Xujun Leng <lengxujun2007@126.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xujun Leng <lengxujun2007@126.com>
Subject: [PATCH] mm: fix potential invalid pointer dereference in kmemdup()
Date:   Tue,  7 Mar 2023 17:03:58 +0800
Message-Id: <20230307090358.21346-1-lengxujun2007@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXNNkC_wZkgKzZAg--.44696S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1rur47Ar1DXrWxuFyUZFb_yoWxKrg_X3
        yrKryqvr45CFs7JayYvr47WrnIg3ykurW0ga4aqas3Ar98Cw40gayvvFZ8X39xCr18Wrs2
        k39Fvw1DGrnFkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_NeOPUUUUU==
X-Originating-IP: [113.91.40.179]
X-CM-SenderInfo: pohqw5hxmx0jqqqxqiyswou0bp/1tbiaQUrd1pEIwjs8gAAsb
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kmemdup() was called with src == NULL, then memcpy() source address
is fatal, and if kmemdup() was called with len == 0, kmalloc_track_caller()
will return ZERO_SIZE_PTR to variable p, then memcpy() destination address
is fatal. Both 2 cases will cause an invalid pointer dereference.

Signed-off-by: Xujun Leng <lengxujun2007@126.com>
---
 mm/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/util.c b/mm/util.c
index dd12b9531ac4..d1a3b3d2988e 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -128,6 +128,9 @@ void *kmemdup(const void *src, size_t len, gfp_t gfp)
 {
 	void *p;
 
+	if (!src || len == 0)
+		return NULL;
+
 	p = kmalloc_track_caller(len, gfp);
 	if (p)
 		memcpy(p, src, len);
-- 
2.25.1

