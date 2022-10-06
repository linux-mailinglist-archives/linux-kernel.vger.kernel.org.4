Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1C05F5FEA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJFEHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJFEHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:07:44 -0400
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED588A20;
        Wed,  5 Oct 2022 21:07:37 -0700 (PDT)
X-QQ-mid: bizesmtp78t1665029140tcrfg847
Received: from wuhui-virtual-machine.localdoma ( [58.251.166.8])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 06 Oct 2022 12:05:18 +0800 (CST)
X-QQ-SSF: 01400000000000F0U000000A0000000
X-QQ-FEAT: DQ0OCu3gog2jS1XCuga4iSoPGUC/H47sfmt8qhHpOqY8NW50ybQYpFP4i3KXM
        OKbzsNQoFCPP9vmRIpIaVbWqWl2Pyk4mTmvdqFckYH2gdZW2S22GxGrAYV/7o3W2ETszjo/
        Q2Jqr8wn6xRlVYPokNHAfJECon3BvOsuO1UQFCC2rIzMP0Kk30HqqdneZNP4wLudX0PhB9B
        Wh3cdGsnUMlE7+f6/7AmCQG8GdrVXSJ1d1opxvSZGwo3YzdUC4NsdjZwAzjb10JnD2EuJFt
        DgKkdPUbRXHFsPwVT5p4402zB3/F1ZN6PGAtPE3PdflfJFCI06NEdYQBt6PtsU/53DUzFkp
        3Cs6TTscg97q1y9lIf9nS1z7+rkf9XsQlj4fY9RaJt7U9T6g3s=
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     bagasdotme@gmail.com
Cc:     akiyks@gmail.com, akpm@linux-foundation.org,
        caoyixuan2019@email.szu.edu.cn, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rppt@kernel.org, skhan@linuxfoundation.org,
        yejiajian2018@email.szu.edu.cn, zhangyinan2019@email.szu.edu.cn
Subject: [PATCH v5] Documentation/mm/page_owner.rst: delete frequently changing experimental data
Date:   Thu,  6 Oct 2022 12:05:17 +0800
Message-Id: <20221006040517.19736-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <bf4b507a-f996-6aef-71e6-d73fcddc6163@gmail.com>
References: <bf4b507a-f996-6aef-71e6-d73fcddc6163@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

