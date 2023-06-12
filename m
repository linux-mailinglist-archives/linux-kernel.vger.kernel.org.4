Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219E972D123
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbjFLUvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbjFLUtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:49:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500482106
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E5E262BED
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E690C43323;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=YSnDd8eIZWAVVkXrAR2iFLMVAjImLZBexFy3GV2smU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqPbOGExUPnvOck2RN1WO9wxecIiO7nVEipYAmWrLM6powvhfty5dd2arfDL8o8MK
         +rnU6nV/FKY19zKCzDsWkSXE6UYVNpsn6S7qpgOF8tmC2zYLG1iainbN3FyMQm2+GQ
         swvICHPmRQp/6/PWmXyRORqLAO/z97YwdosPE6+0ippOcXn3wfmL/2RniVpZurM0Yk
         GUzVjbI/A5s6waLiD7OXvNYdy8Fdh9dSRtJSyaqU5Q7pVkFfB03vmEETUyG8GzYxEK
         3pC5b7u8lReTcOx2+b0rqrvkoFUDwip9ZwcxnDGnC9eWQYQq8O5dvmejxGTmVW5X6I
         meIOnIg89Zmrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0423DCE3A7E; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 35/53] selftests/nolibc: prevent coredumps during test execution
Date:   Mon, 12 Jun 2023 13:44:56 -0700
Message-Id: <20230612204514.292087-35-paulmck@kernel.org>
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

From: Thomas Weißschuh <linux@weissschuh.net>

The child process forked during stackprotector tests intentionally gets
killed with SIGABRT. By default this will trigger writing a coredump.
The writing of the coredump can spam the systems coredump machinery and
take some time.

Timings for the full run of nolibc-test:
Before: 200ms
After:   20ms

This is on a desktop x86 system with systemd-coredumpd enabled.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6db788603a34..84a1b02eb6f9 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -831,6 +831,7 @@ static int run_protection(int min, int max)
 		close(STDOUT_FILENO);
 		close(STDERR_FILENO);
 
+		prctl(PR_SET_DUMPABLE, 0, 0, 0, 0);
 		smash_stack();
 		return 1;
 
-- 
2.40.1

