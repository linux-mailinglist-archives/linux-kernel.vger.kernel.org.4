Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8496053A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiJSXDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiJSXCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:02:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F421D6380;
        Wed, 19 Oct 2022 16:02:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A378B8262B;
        Wed, 19 Oct 2022 23:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DABAC43147;
        Wed, 19 Oct 2022 23:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220528;
        bh=dc1vemrXfCAsmBUyroVNDV5/ZP+1Wth1la2LR9X0DkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJmGcMOu5riSIpqeYWguClEiqqOm8+lczkDNSE2TyVYNXJtx+dWAxTBZoaoIipD1P
         Qb51+wlBXMZn9sBmH1CxZBoNGPsohK4Vrg0kb0mBmpUQlkAmwnciaFzHKm9qbnBTwV
         8mgXGrEseXsinuJ11ywycWKzavnBHFyN2YI8mZ7OhX76z45JFyqf0NjPrJbPqRLDsM
         qDPLSkrFg4oWeheFyqXtgEvptwkbTgXFTsDPRHifZhsXvQLc9wS/qAUSdaB/gqxqGE
         q5LawjqDLnGkQBiHhOaeSyfaCZwZ/SuCDt0vvrmXXvbgPL/sqjDRcdoDnxopl+IIif
         zFeFmVBlc7mGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 01CDB5C0B8F; Wed, 19 Oct 2022 16:02:08 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 8/8] torture: Make torture.sh create a properly formatted log file
Date:   Wed, 19 Oct 2022 16:02:06 -0700
Message-Id: <20221019230206.2501794-8-paulmck@kernel.org>
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

Currently, if the torture.sh allmodconfig step fails, this is counted as
an error (as it should be), but there is also an extraneous complaint
about a missing log file.  This commit therefore adds that log file,
which is hoped to reduce confused reactions to the error report.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 32 +++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index fc63539377147..ec3d8a2d513f1 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -330,20 +330,34 @@ then
 	echo " --- allmodconfig:" Start `date` | tee -a $T/log
 	amcdir="tools/testing/selftests/rcutorture/res/$ds/allmodconfig"
 	mkdir -p "$amcdir"
-	echo " --- make clean" > "$amcdir/Make.out" 2>&1
+	echo " --- make clean" | tee $amcdir/log > "$amcdir/Make.out" 2>&1
 	make -j$MAKE_ALLOTED_CPUS clean >> "$amcdir/Make.out" 2>&1
-	echo " --- make allmodconfig" >> "$amcdir/Make.out" 2>&1
-	cp .config $amcdir
-	make -j$MAKE_ALLOTED_CPUS allmodconfig >> "$amcdir/Make.out" 2>&1
-	echo " --- make " >> "$amcdir/Make.out" 2>&1
-	make -j$MAKE_ALLOTED_CPUS >> "$amcdir/Make.out" 2>&1
-	retcode="$?"
-	echo $retcode > "$amcdir/Make.exitcode"
-	if test "$retcode" == 0
+	retcode=$?
+	buildphase='"make clean"'
+	if test "$retcode" -eq 0
+	then
+		echo " --- make allmodconfig" | tee -a $amcdir/log >> "$amcdir/Make.out" 2>&1
+		cp .config $amcdir
+		make -j$MAKE_ALLOTED_CPUS allmodconfig >> "$amcdir/Make.out" 2>&1
+		retcode=$?
+		buildphase='"make allmodconfig"'
+	fi
+	if test "$retcode" -eq 0
+	then
+		echo " --- make " | tee -a $amcdir/log >> "$amcdir/Make.out" 2>&1
+		make -j$MAKE_ALLOTED_CPUS >> "$amcdir/Make.out" 2>&1
+		retcode="$?"
+		echo $retcode > "$amcdir/Make.exitcode"
+		buildphase='"make"'
+	fi
+	if test "$retcode" -eq 0
 	then
 		echo "allmodconfig($retcode)" $amcdir >> $T/successes
+		echo Success >> $amcdir/log
 	else
 		echo "allmodconfig($retcode)" $amcdir >> $T/failures
+		echo " --- allmodconfig Test summary:" >> $amcdir/log
+		echo " --- Summary: Exit code $retcode from $buildphase, see Make.out" >> $amcdir/log
 	fi
 fi
 
-- 
2.31.1.189.g2e36527f23

