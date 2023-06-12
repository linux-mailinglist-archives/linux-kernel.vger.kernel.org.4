Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355A472D120
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbjFLUvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237708AbjFLUt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEFA1BF1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C9CE62F2E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757E5C433AC;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=fUMXY6pyixSpxlndYjLR4VYqCyPqno/RiVwO5z9bIu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CWZ76t1UE0jXqLcLWFJaQr3fM7S/jUG4p39IndUX7Nvpf5q3qh0YXTv8oWMJhLaPl
         2zcynq08acBH3UHNqKPMFc4TqQJjWPOnRl17fAMTaUfpG8/drblQNso8l30gXHoISJ
         Gm+OzY2e98bRKztzorGGlwn2NQGk2z/xfZM8k1VY6VNIjG2slWonTKTP7fP+p+7pqW
         ugM0X62bm2hRYNgvX4WfZuBbl3P/E41U9yuiG8+5tCUjowmezPw7n3k5DaPkvDM+mL
         LuKyV8H+RxwvpwdUYeacTZzWCLrR3wGy2sPb2IEjD5PUqiFW21DkJKjg4nTPTgAwFV
         /9EiLZZgzkjsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2D761CE3A95; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 53/53] selftests/nolibc: make sure gcc always use little endian on MIPS
Date:   Mon, 12 Jun 2023 13:45:14 -0700
Message-Id: <20230612204514.292087-53-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
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

From: Willy Tarreau <w@1wt.eu>

The test on MIPS stopped working after I upgraded some of my toolchains
to use the ones from kernel.org because the mips toolchain defaults to
big endian, even though it supports both endians. Let's just add an
explicit -EL to make sure it always succeeds like the kernel does.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 4a3a105e1fdf..1b7b3c82f8ad 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -77,6 +77,7 @@ Q=@
 endif
 
 CFLAGS_s390 = -m64
+CFLAGS_mips = -EL
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(call cc-option,-fno-stack-protector) \
-- 
2.40.1

