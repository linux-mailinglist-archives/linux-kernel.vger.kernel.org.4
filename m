Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A586272D0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbjFLUrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjFLUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:46:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D651FC1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD9CF62B14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CFBC433D2;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=cN3q9iCF/gJ/uPtCwHUQPd6CHzRDYrNdYVOXcOrOK64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqJAR6cT6U5vORSu/lKpIHbxnWn4m/pIWbHlkeNzpTBxTFkJdovV1JOPilMWiMl1O
         duTEq89VRWTqGgBqAzCoFJo1UgJbtf91SlxQEzdtovckvGef3UrLFwxvnahYMEoBSo
         iCrWvfz0/pYDNZPsd7PvU40VZFk0bIOD0vdFTXz1/zcoUtF5+pY4EyrB9FkYSZAcTm
         jqjliWWDhhGei8kCVo27MVfhFfbBL1SCFi7/l6a0ttVs6eKb5VwMBD7qosMpjRB+MR
         f0NulZoYA2TplRnke1eXxQO7oUOUTfqzeDJDLpUDNledJVtK/FZvR7avJKgPirB7zu
         pZiuw0zReKz4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AF9C3CE3A1D; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>, Vincent Dagonneau <v@vda.io>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 03/53] tools/nolibc: fix build of the test case using glibc
Date:   Mon, 12 Jun 2023 13:44:24 -0700
Message-Id: <20230612204514.292087-3-paulmck@kernel.org>
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

Some extra tests for various integer types and limits were added by
commit d1209597ff00 ("tools/nolibc: add tests for the integer limits
in stdint.h"), but we forgot to retest with glibc. Stddef and stdint
are now needed for the program to build there.

Cc: Vincent Dagonneau <v@vda.io>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6f2f109569a3..1bafbd8da6af 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -34,6 +34,8 @@
 #include <sched.h>
 #include <signal.h>
 #include <stdarg.h>
+#include <stddef.h>
+#include <stdint.h>
 #include <unistd.h>
 #endif
 #endif
-- 
2.40.1

