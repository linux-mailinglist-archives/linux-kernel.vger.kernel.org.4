Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4F45F51A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJEJPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJEJPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:15:00 -0400
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C331617073;
        Wed,  5 Oct 2022 02:14:44 -0700 (PDT)
X-QQ-mid: bizesmtp68t1664961107tmhp7r4d
Received: from wuhui-virtual-machine.localdoma ( [58.60.63.196])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 05 Oct 2022 17:10:55 +0800 (CST)
X-QQ-SSF: 01400000000000F0U000B00A0000000
X-QQ-FEAT: RLrSOnjbvYHanfcWNWotMrIevse8c9gRjknWz5sa77wzjFzO03sE56NVIf3gJ
        8jzGgH5lDKmrVcFKYtWVgghOml3BqX8ECqnI6FunVrUZFBCOa4dbob60K+3r1OT4j0wWYEA
        8kbtHptiVqZngtTXGbF7YFjIun4IHYvoMZX5r66ojTQSHhgZ3cBgrCfDUkgE2y72p8Xb2Hl
        qSVjWZqkx0su4YVN64yt6C0OyMh4GfYPvkVEFg3hnWD9BIqG36lCKM3QZ3CZ0zs/WMMVDtV
        6DsWEEMlyZfiyxQTb2H3zAThe62LOyn/795WxEgUs6kaPhCXZOFpqPC8WykHNEHyzYV3P2q
        UUiGiKRD9dG885GT2kzA8qpokiJe5Bd+1T6iv9rY9fp19vlavw=
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     rppt@kernel.org
Cc:     akiyks@gmail.com, akpm@linux-foundation.org, bagasdotme@gmail.com,
        caoyixuan2019@email.szu.edu.cn, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, yejiajian2018@email.szu.edu.cn,
        zhangyinan2019@email.szu.edu.cn
Subject: [PATCH v2] Documentation/mm/page_owner.rst: delete frequently changing experimental data
Date:   Wed,  5 Oct 2022 17:10:52 +0800
Message-Id: <20221005091052.6631-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YwhJDJQkymdN0E2N@kernel.org>
References: <YwhJDJQkymdN0E2N@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for Jonathan Corbet, Bagas Sanjaya and Mike Rapoport's
constructive suggestions. Notice that the size(1) output is
changing frequently, I remove the two tables and describe them
in a general way. Doing so avoids having to repeatedly maintain
the two tables due to kernel changes.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 Documentation/mm/page_owner.rst | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
index f18fd8907049..1b661ad85647 100644
--- a/Documentation/mm/page_owner.rst
+++ b/Documentation/mm/page_owner.rst
@@ -38,22 +38,10 @@ not affect to allocation performance, especially if the static keys jump
 label patching functionality is available. Following is the kernel's code
 size change due to this facility.
 
-- Without page owner::
-
-   text    data     bss     dec     hex filename
-   48392   2333     644   51369    c8a9 mm/page_alloc.o
-
-- With page owner::
-
-   text    data     bss     dec     hex filename
-   48800   2445     644   51889    cab1 mm/page_alloc.o
-   6662     108      29    6799    1a8f mm/page_owner.o
-   1025       8       8    1041     411 mm/page_ext.o
-
-Although, roughly, 8 KB code is added in total, page_alloc.o increase by
-520 bytes and less than half of it is in hotpath. Building the kernel with
-page owner and turning it on if needed would be great option to debug
-kernel memory problem.
+Although, enabling page owner increases kernel size by several kilobytes,
+most of this code is outside page allocator and its hot path. Building 
+the kernel with page owner and turning it on if needed would be great
+option to debug kernel memory problem.
 
 There is one notice that is caused by implementation detail. page owner
 stores information into the memory from struct page extension. This memory
-- 
2.17.1

