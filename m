Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5675F56D6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJEO43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJEO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:56:26 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF945722C;
        Wed,  5 Oct 2022 07:56:19 -0700 (PDT)
X-QQ-mid: bizesmtp74t1664981753tqxqhqzu
Received: from wuhui-virtual-machine.localdoma ( [58.60.63.196])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 05 Oct 2022 22:55:27 +0800 (CST)
X-QQ-SSF: 01400000002000F0U000B00A0000000
X-QQ-FEAT: vLOCICHxEeCEfF/1m3dYxSw0cSBxgr+1eS2IgZovlg8fwaP7DrqvylYTmDYZF
        byryxOB13Zmze9TU4BH6Xv3gPuZS7ljmVyf6tRQYdTvN81pio7LrpNAq8y2ssjZ0d5ZC30G
        HPXVJHiBqcT2VPaFEVmWNz+teRmVyUAWN6LzAg6thlNCrYub/vQg2jh/1fK+vS51o4kXB6/
        Yk/orL6q3G/INVic2hQSPI8xeaYyQwXUdw9rhjhOk5wuyiYqVhCG02FmAZ4VS1hHCstdlZ6
        q22SYmz64vkEn9UksEU9kQkSnVD+gO90R2FTP0jAcyYiDyZ9Ip/ENqKqlIL+5Bk9FnWQpHg
        8f3sDFYVzdtymvNuXDo8MFUmveViwGDlousZTIi5RxpG/LdxBzHwMvs1iDAS7uxfn6oQPn+
        PqN6ptO5bLA=
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     akiyks@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        skhan@linuxfoundation.org, yejiajian2018@email.szu.edu.cn,
        zhangyinan2019@email.szu.edu.cn,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH v4] Documentation/mm/page_owner.rst: delete frequently changing experimental data
Date:   Wed,  5 Oct 2022 22:55:25 +0800
Message-Id: <20221005145525.10359-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <89aed08f-1e0b-258c-516d-97a30fd02840@gmail.com>
References: <89aed08f-1e0b-258c-516d-97a30fd02840@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel size changes due to many factors, such as compiler
version, configuration, and the build environment. This makes
size comparison figures irrelevant to reader's setup.

Remove these figures and describe the effects of page owner
to the kernel size in general instead.

Thanks for Jonathan Corbet, Bagas Sanjaya and Mike Rapoport's
constructive suggestions.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 Documentation/mm/page_owner.rst | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
index f18fd8907049..127514955a5e 100644
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
+Although enabling page owner increases kernel size by several kilobytes,
+most of this code is outside page allocator and its hot path. Building
+the kernel with page owner and turning it on if needed would be great
+option to debug kernel memory problem.
 
 There is one notice that is caused by implementation detail. page owner
 stores information into the memory from struct page extension. This memory
-- 
2.17.1

