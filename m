Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D43473FEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjF0Op0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjF0Oop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:44:45 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7654F12C;
        Tue, 27 Jun 2023 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cW6FsUc372OgjCXWGlVTOpJDBn/sKhwbAV7MvUlsfDU=;
  b=jWt7EReJ5kDtaESX69GV8d4liYZONaNjYK6YwdVqiDhOrR+UO9w9kKRo
   +ywuVIwSPjmV/l3kagzTPaaXWEA08ystOtiHsidk5aXckj/9gzF9Rpoj3
   I1ITEQ51Rbp6KM/FiTv0VHqRI8yNXSJ9Lc78ZzS16NIIda7XjaWrQUZT3
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="114936318"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:43:51 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org
Subject: [PATCH v2 01/24] lib/test_vmalloc.c: use vmalloc_array and vcalloc
Date:   Tue, 27 Jun 2023 16:43:16 +0200
Message-Id: <20230627144339.144478-2-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230627144339.144478-1-Julia.Lawall@inria.fr>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vmalloc_array and vcalloc to protect against
multiplication overflows.

The changes were done using the following Coccinelle
semantic patch:

// <smpl>
@initialize:ocaml@
@@

let rename alloc =
  match alloc with
    "vmalloc" -> "vmalloc_array"
  | "vzalloc" -> "vcalloc"
  | _ -> failwith "unknown"

@@
    size_t e1,e2;
    constant C1, C2;
    expression E1, E2, COUNT, x1, x2, x3;
    typedef u8;
    typedef __u8;
    type t = {u8,__u8,char,unsigned char};
    identifier alloc = {vmalloc,vzalloc};
    fresh identifier realloc = script:ocaml(alloc) { rename alloc };
@@

(
      alloc(x1*x2*x3)
|
      alloc(C1 * C2)
|
      alloc((sizeof(t)) * (COUNT), ...)
|
-     alloc((e1) * (e2))
+     realloc(e1, e2)
|
-     alloc((e1) * (COUNT))
+     realloc(COUNT, e1)
|
-     alloc((E1) * (E2))
+     realloc(E1, E2)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
v2: Use vmalloc_array and vcalloc instead of array_size.
This also leaves a multiplication of a constant by a sizeof
as is.  Two patches are thus dropped from the series.

 lib/test_vmalloc.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff -u -p a/lib/test_vmalloc.c b/lib/test_vmalloc.c
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -156,7 +156,7 @@ static int random_size_alloc_test(void)
 
 	for (i = 0; i < test_loop_count; i++) {
 		n = get_random_u32_inclusive(1, 100);
-		p = vmalloc(n * PAGE_SIZE);
+		p = vmalloc_array(n, PAGE_SIZE);
 
 		if (!p)
 			return -1;
@@ -221,11 +221,11 @@ static int full_fit_alloc_test(void)
 	junk_length = fls(num_online_cpus());
 	junk_length *= (32 * 1024 * 1024 / PAGE_SIZE);
 
-	ptr = vmalloc(sizeof(void *) * junk_length);
+	ptr = vmalloc_array(junk_length, sizeof(void *));
 	if (!ptr)
 		return rv;
 
-	junk_ptr = vmalloc(sizeof(void *) * junk_length);
+	junk_ptr = vmalloc_array(junk_length, sizeof(void *));
 	if (!junk_ptr) {
 		vfree(ptr);
 		return rv;
@@ -271,7 +271,8 @@ static int fix_size_alloc_test(void)
 		if (use_huge)
 			ptr = vmalloc_huge((nr_pages > 0 ? nr_pages:1) * PAGE_SIZE, GFP_KERNEL);
 		else
-			ptr = vmalloc((nr_pages > 0 ? nr_pages:1) * PAGE_SIZE);
+			ptr = vmalloc_array(nr_pages > 0 ? nr_pages : 1,
+					    PAGE_SIZE);
 
 		if (!ptr)
 			return -1;

