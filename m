Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3418A6053A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiJSXDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiJSXCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:02:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E3F1D3A7A;
        Wed, 19 Oct 2022 16:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D583B82629;
        Wed, 19 Oct 2022 23:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404C5C433D6;
        Wed, 19 Oct 2022 23:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220528;
        bh=al9IGfgTo+phnGZ+G5WnJmjzW9Xtyv4OkdugthUrZOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6H+LTr4nboGTBgy1Vx6YGj5gNxX04QALStfJRWFJYNGV0CFtzC9WkLEJvmb7UX5e
         m4JVFyljrDsWGgPNw9I9baaiaDlc8lt8Ulm2mB7hKlSwfrJSFVvFxrhrQrkFuubz4X
         uaBB1TKJaHttQTn/2XvwwgcUeWPCvolDPRXrL0N5mf3uzXVI4f8PMJZLsHSSSLy6Fh
         Me+J5HIpmFF0dmLvXv1SR6xFwPcTZWApyk278tYslYJPLIARztb3xy5QT027wTHVCr
         2i57PdJhkzlg+f3UxtW6fHpBjZR3jF8nzJ7f7vgdNrC4nspfftaA9VNoxTs6TVcngk
         eOqCcvRxW1SLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EE2585C0920; Wed, 19 Oct 2022 16:02:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 4/8] rcutorture: Make kvm-recheck.sh export TORTURE_SUITE
Date:   Wed, 19 Oct 2022 16:02:02 -0700
Message-Id: <20221019230206.2501794-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019230203.GA2501612@paulmck-ThinkPad-P17-Gen-1>
References: <20221019230203.GA2501612@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it should, the kvm-recheck.sh script sets the TORTURE_SUITE bash
variable based on the type of rcutorture test being run.  However,
it does not export it.  Which is OK, at least until you try running
kvm-again.sh on either a rcuscale or a refscale test, at which point you
get false-positive "no success message, N successful version messages"
errors.  This commit therefore causes the kvm-recheck.sh script to export
TORTURE_SUITE, suppressing these false positives.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 0789c5606d2ab..1df7e695edf75 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -30,7 +30,7 @@ do
 			resdir=`echo $i | sed -e 's,/$,,' -e 's,/[^/]*$,,'`
 			head -1 $resdir/log
 		fi
-		TORTURE_SUITE="`cat $i/../torture_suite`"
+		TORTURE_SUITE="`cat $i/../torture_suite`" ; export TORTURE_SUITE
 		configfile=`echo $i | sed -e 's,^.*/,,'`
 		rm -f $i/console.log.*.diags
 		case "${TORTURE_SUITE}" in
-- 
2.31.1.189.g2e36527f23

