Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A596053A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiJSXDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiJSXCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:02:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D7CAF1B5;
        Wed, 19 Oct 2022 16:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EFEBB8261C;
        Wed, 19 Oct 2022 23:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ECCC433D7;
        Wed, 19 Oct 2022 23:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220528;
        bh=vujWVns8niceU8J6GOrbe2hSQ2hT3dNgCY4sagFnfUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DU1xdPkbmR2GUqEvEQdWc9lp1hJK1Wr+PgNK9PsFWosORJsgXkNWa+ITbm5esP9mv
         wXSPbrll5KmoM7exU8I7axoKSu+V5prGkjb+o9GAY8tvj4XONp3xhvcQTtfasgRMkk
         BQBMGjhXTxdHH8bpbBi2g+00U58ynlWk4O2723Ly1po3MTf7dxW7olZqdV6rJQJfcw
         uqXjx6DMjG3M43Tu6wSGm68eeTmlvK+t8vQHLQQ6Wy8LBz9CLhOCneDoj4+ebW0XZD
         SAvF8bFCH1PgR+fFBlBO1EdFqsEE/JOum6BLp81KdroaHUobYSOHnDlp02pxr0QO9J
         pBj7j/2KnLtHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EC4B15C0890; Wed, 19 Oct 2022 16:02:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 3/8] rcutorture: Make kvm-test-1-run-qemu.sh check for alternative output
Date:   Wed, 19 Oct 2022 16:02:01 -0700
Message-Id: <20221019230206.2501794-3-paulmck@kernel.org>
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

The kvm-again.sh script, when running locally, can place the QEMU output
into kvm-test-1-run-qemu.sh.out instead of kvm-test-1-run.sh.out.  This
commit therefore makes kvm-test-1-run-qemu.sh check both locations.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index 9da86e6cd1812..76f24cd5825be 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -108,7 +108,7 @@ do
 		if test $kruntime -lt $seconds
 		then
 			echo Completed in $kruntime vs. $seconds >> $resdir/Warnings 2>&1
-			grep "^(qemu) qemu:" $resdir/kvm-test-1-run.sh.out >> $resdir/Warnings 2>&1
+			grep "^(qemu) qemu:" $resdir/kvm-test-1-run*.sh.out >> $resdir/Warnings 2>&1
 			killpid="`sed -n "s/^(qemu) qemu: terminating on signal [0-9]* from pid \([0-9]*\).*$/\1/p" $resdir/Warnings`"
 			if test -n "$killpid"
 			then
-- 
2.31.1.189.g2e36527f23

