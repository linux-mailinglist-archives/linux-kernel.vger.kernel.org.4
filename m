Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E83772D111
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjFLUvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbjFLUsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F91AD3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D714262F1F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595BBC43334;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=DzYPgHEaJn6SEGOBtodqcjbqpjhlzL55/SWXEc/knwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvGcN0gxBTT+XU2HPuSuQbXLjG+mnfG6Q2psrHCyj64CJyKcNhq3l8g7t3qrX5Trf
         urpV9lf7GROl1/e9QkDepjlU2BOWAFxgJDMIKjDXwKZbneGGgs5DIJkjAI49FwTf4o
         jBSeGtpaMmUqAUfM9nHW46ijV7OB8OKpbjpXQPwoFKzR6OUb0wAIP1DDD0bjKDA4vU
         oZMjP8K/MbvkJPB9XdJ95CS1swF7bZeArSWyyncVLAbKIozkSiEmAPnmnWFulrgK6d
         acSczQw5J0xzYsFvUtcwPFbl+/PYAnXE+D9ZrIVq6Sj5YVYqEcLfol8CX3kTW7WLD9
         CfPCd+QC/EcnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 193E9CE3A8B; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 44/53] selftests/nolibc: fix up compile warning with glibc on x86_64
Date:   Mon, 12 Jun 2023 13:45:05 -0700
Message-Id: <20230612204514.292087-44-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhangjin Wu <falcon@tinylab.org>

Compiling nolibc-test.c with gcc on x86_64 got such warning:

tools/testing/selftests/nolibc/nolibc-test.c: In function ‘expect_eq’:
tools/testing/selftests/nolibc/nolibc-test.c:177:24: warning: format ‘%lld’ expects argument of type ‘long long int’, but argument 2 has type ‘uint64_t’ {aka ‘long unsigned int’} [-Wformat=]
  177 |  llen += printf(" = %lld ", expr);
      |                     ~~~^    ~~~~
      |                        |    |
      |                        |    uint64_t {aka long unsigned int}
      |                        long long int
      |                     %ld

It because that glibc defines uint64_t as "unsigned long int" when word
size (means sizeof(long)) is 64bit (see include/bits/types.h), but
nolibc directly use the 64bit "unsigned long long" (see
tools/include/nolibc/stdint.h), which is simpler, seems kernel uses it
too (include/uapi/asm-generic/int-ll64.h).

use a simple conversion to solve it.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/linux-riscv/20230529130449.GA2813@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index cfc7b270c397..dcb0bd079d15 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -174,7 +174,7 @@ static int expect_eq(uint64_t expr, int llen, uint64_t val)
 {
 	int ret = !(expr == val);
 
-	llen += printf(" = %lld ", expr);
+	llen += printf(" = %lld ", (long long)expr);
 	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
-- 
2.40.1

