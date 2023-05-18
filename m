Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3931708450
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjEROz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjEROz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E74F119
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3585964FDB
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831C3C433D2;
        Thu, 18 May 2023 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684421723;
        bh=cN3q9iCF/gJ/uPtCwHUQPd6CHzRDYrNdYVOXcOrOK64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nIszTSbiME0wYc4lQI+izSXixJxHzChuLf1c44BLHb0D/luq4shcZvg3I3ene9INJ
         W7nZZsO8avz6UWnWwKnZ/MZIpC+GSkFTdu+8ix8oN1Ooubl9aPlO0k316F5C+Xtl56
         f4WcwcAR2W0vcwTWrnd2IM7rCO6jn8Z2Mu8pPokfpNT/MHgv8hjwWuYLXHu0WHFa1K
         FIWjcWaGyfaxECLgmLQKnxLe0PclvkpCtPsmeSrWhsfn6fOzCGsN7BUUq0FqnjNcLh
         Ax6NSN+g5QQ5ytfwCRf1WwPZHwzWhJqop1vBBtA8d1THkhjadn6IfRNCsYUjrivOmi
         noHbkT1fB3jOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 17F46CE0FED; Thu, 18 May 2023 07:55:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>, Vincent Dagonneau <v@vda.io>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 03/15] tools/nolibc: fix build of the test case using glibc
Date:   Thu, 18 May 2023 07:55:09 -0700
Message-Id: <20230518145521.3806117-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
References: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

