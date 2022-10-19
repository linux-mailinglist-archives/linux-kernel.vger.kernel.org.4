Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370416053A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiJSXDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiJSXCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:02:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D111D20DE;
        Wed, 19 Oct 2022 16:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 290F4619EF;
        Wed, 19 Oct 2022 23:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA11C43146;
        Wed, 19 Oct 2022 23:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220528;
        bh=53szEup4hjdcWI9Azzzq4yiaAkzJ587FLazGGLmL35A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhG4U6UCinBnXe16hT7wyq9VdsjvWs58hsfo0agBdGhinwDXsVImyfnBtXxkN+4vN
         D29up0IyrPFqCrCnF77qJkRfVDp6zdftgKFx4bhy7P4ViUWLtJDrebFIV7LJuZfVw8
         op8ubtBmgJJzHAtCcYqgmch0K8+4aMBRGxvhncuWFfM9YAired30QvZeaFRFOO75PX
         iU5hsYo2LdHefazQZrGJeTJTythxLoiSYVyEP7zw7a7jQqoTaHBYCf0+mBtD0tWlV6
         T/pq/QxIABFNw6D5ntPc0cLf5dGSgQHd6cw4huhk05qoNlOlHmTjxbR7HWajjMZzBR
         zibkwiYlm6wnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F41FA5C0AC5; Wed, 19 Oct 2022 16:02:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 7/8] rcutorture: Avoid torture.sh compressing identical files
Date:   Wed, 19 Oct 2022 16:02:05 -0700
Message-Id: <20221019230206.2501794-7-paulmck@kernel.org>
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

Currently, torture.sh will compress the vmlinux files for KASAN and
KCSAN runs.  But it will compress all of the files, including those
copied verbatim by the kvm-again.sh script.  Compression takes around ten
minutes, so this is not a good thing.  This commit therefore compresses
only one of a given set of identical vmlinux files, and then hard-links
it to the directories produced by kvm-again.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index b376688fe280a..fc63539377147 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -536,7 +536,10 @@ if test -n "$tdir" && test $compress_concurrency -gt 0
 then
 	# KASAN vmlinux files can approach 1GB in size, so compress them.
 	echo Looking for K[AC]SAN files to compress: `date` > "$tdir/log-xz" 2>&1
-	find "$tdir" -type d -name '*-k[ac]san' -print > $T/xz-todo
+	find "$tdir" -type d -name '*-k[ac]san' -print > $T/xz-todo-all
+	find "$tdir" -type f -name 're-run' -print | sed -e 's,/re-run,,' |
+		grep -e '-k[ac]san$' > $T/xz-todo-copy
+	sort $T/xz-todo-all $T/xz-todo-copy | uniq -u > $T/xz-todo
 	ncompresses=0
 	batchno=1
 	if test -s $T/xz-todo
@@ -568,6 +571,22 @@ then
 			echo Waiting for final batch $batchno of $ncompresses compressions `date` | tee -a "$tdir/log-xz" | tee -a $T/log
 		fi
 		wait
+		if test -s $T/xz-todo-copy
+		then
+			echo Linking vmlinux.xz files to re-use scenarios `date` | tee -a "$tdir/log-xz" | tee -a $T/log
+			dirstash="`pwd`"
+			for i in `cat $T/xz-todo-copy`
+			do
+				cd $i
+				find "$i" -name vmlinux -print > $T/xz-todo-copy-vmlinux
+				for v in `cat $T/xz-todo-copy-vmlinux`
+				do
+					rm -f "$v"
+					cp -l "$i/$v".xz "`dirname "$v"`"
+				done
+				cd "$dirstash"
+			done
+		fi
 		echo Size after compressing $n2compress files: `du -sh $tdir | awk '{ print $1 }'` `date` 2>&1 | tee -a "$tdir/log-xz" | tee -a $T/log
 		echo Total duration `get_starttime_duration $starttime`. | tee -a $T/log
 	else
-- 
2.31.1.189.g2e36527f23

