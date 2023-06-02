Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF747209BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbjFBTWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbjFBTWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:22:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B093D1BC;
        Fri,  2 Jun 2023 12:22:08 -0700 (PDT)
Date:   Fri, 02 Jun 2023 19:22:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685733726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThsPPSvvi0NQuDbE3V2XkRsox2z+4m2CiOPtkRH1F7w=;
        b=PyxJvpgrfSc+7RQ+v9un/vJOraVQL5Wj49KBWiagvT+LfqxbJCKpbd4QEKI6pBa0S3RgGI
        1B1WRV3TkdlDkBaMhKczjBQbHBI1WXrXUF6bDc2sU/oAUsKKXjJWUK49gXCP1ChFyzwbMd
        bWse7C3qA6jzIdgb35OAzsredZqRA81IVHH1t815UloN4JIdIKSVc4Bgtq+3xnvBaoZlOn
        PkqYULmLDAAQ23lYlMXzazRTYx8PawTBXiot6huh6XnHFm6ox8RyFHAJAMa0bEyOB2tuB/
        oM6Ut59fdaiLQNuYkEjU+d7HQtLll8mk3zjzGzxnbGIrwkGqxh/6dTOljAXg6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685733726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThsPPSvvi0NQuDbE3V2XkRsox2z+4m2CiOPtkRH1F7w=;
        b=qAqjZDruE0UXn2lqVEHDwTiOWV1JwVjiiFfhCY4jUA5FACpr/k7F0snb+GuWf7Cy/8obty
        2guLfndcUNMSg8DQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add __kunit_abort() to noreturns
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230602175453.swsn3ehyochtwkhy@treble>
References: <20230602175453.swsn3ehyochtwkhy@treble>
MIME-Version: 1.0
Message-ID: <168573372607.404.6955816775416345418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ff9a6459bbec06df7da2545020d7383aba13b3fb
Gitweb:        https://git.kernel.org/tip/ff9a6459bbec06df7da2545020d7383aba13b3fb
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 02 Jun 2023 10:54:53 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jun 2023 21:12:24 +02:00

objtool: Add __kunit_abort() to noreturns

Fixes a bunch of warnings like:

  drivers/input/tests/input_test.o: warning: objtool: input_test_init+0x1cb: stack state mismatch: cfa1=4+64 cfa2=4+56
  lib/kunit/kunit-test.o: warning: objtool: kunit_log_newline_test+0xfb: return with modified stack frame
  ...

Fixes: 260755184cbd ("kunit: Move kunit_abort() call out of kunit_do_failed_assertion()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230602175453.swsn3ehyochtwkhy@treble
---
 tools/objtool/noreturns.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index cede606..1514e84 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -7,6 +7,7 @@
  * Yes, this is unfortunate.  A better solution is in the works.
  */
 NORETURN(__invalid_creds)
+NORETURN(__kunit_abort)
 NORETURN(__module_put_and_kthread_exit)
 NORETURN(__reiserfs_panic)
 NORETURN(__stack_chk_fail)
