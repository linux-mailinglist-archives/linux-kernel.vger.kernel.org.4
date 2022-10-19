Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A66A60539D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiJSXCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiJSXCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2021D79B1;
        Wed, 19 Oct 2022 16:02:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3D44619DA;
        Wed, 19 Oct 2022 23:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467C7C43470;
        Wed, 19 Oct 2022 23:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220528;
        bh=NECyAiA/pg8kY8mVrs9nuK9e2kelW/ljznF/KmY6HlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWhR0Lqd2mxFc9XgnYi5vFn+458E53pCha0l023bS/m9fnvTSP3xwKxCcjOvHVqk9
         6/f+cnilDYiL32Ly9N4GK3gQPJe/bOXTP0YxmQS3k6xpqKyueViAtVepOISQ/do/VL
         27b0bVgwABiB2JFi7uLvrKq/ZTR7Pz0XTTjd95kY2Wes5Zy65gDAifhVXnKRqGnAZ0
         t4CUK83Erktp30aKqFTvQoR59faL1E5wC932S3lNH8Kj14YxTK12MvTHuhtf/lXk21
         Zwj+OnB6oFhmcXFx4IQHGp7dePPNG5tWBdOp9Z98516YqTa1LThSGDK574ya6o+guM
         q8ltpYJ3JZEKg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F05425C0A04; Wed, 19 Oct 2022 16:02:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 5/8] rcutorture: Add --datestamp parameter to kvm-again.sh
Date:   Wed, 19 Oct 2022 16:02:03 -0700
Message-Id: <20221019230206.2501794-5-paulmck@kernel.org>
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

This commit adds a --datestamp parameter to kvm-again.sh, which, in
contrast to the existing --rundir argument, specifies only the last
segments of the pathname.  This addition enables torture.sh to use
kvm-again.sh in order to avoid redundant kernel builds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-again.sh     | 37 +++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 20941c1051087..8a968fbda02c9 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -54,7 +54,10 @@ bootargs=
 dryrun=
 dur=
 default_link="cp -R"
-rundir="`pwd`/tools/testing/selftests/rcutorture/res/`date +%Y.%m.%d-%H.%M.%S-again`"
+resdir="`pwd`/tools/testing/selftests/rcutorture/res"
+rundir="$resdir/`date +%Y.%m.%d-%H.%M.%S-again`"
+got_datestamp=
+got_rundir=
 
 startdate="`date`"
 starttime="`get_starttime`"
@@ -62,11 +65,13 @@ starttime="`get_starttime`"
 usage () {
 	echo "Usage: $scriptname $oldrun [ arguments ]:"
 	echo "       --bootargs kernel-boot-arguments"
+	echo "       --datestamp string"
 	echo "       --dryrun"
 	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
 	echo "       --link hard|soft|copy"
 	echo "       --remote"
 	echo "       --rundir /new/res/path"
+	echo "Command line: $scriptname $args"
 	exit 1
 }
 
@@ -78,6 +83,23 @@ do
 		bootargs="$bootargs $2"
 		shift
 		;;
+	--datestamp)
+		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._/-]*$' '^--'
+		if test -n "$got_rundir" || test -n "$got_datestamp"
+		then
+			echo Only one of --datestamp or --rundir may be specified
+			usage
+		fi
+		got_datestamp=y
+		ds=$2
+		rundir="$resdir/$ds"
+		if test -e "$rundir"
+		then
+			echo "--datestamp $2: Already exists."
+			usage
+		fi
+		shift
+		;;
 	--dryrun)
 		dryrun=1
 		;;
@@ -119,6 +141,12 @@ do
 		;;
 	--rundir)
 		checkarg --rundir "(absolute pathname)" "$#" "$2" '^/' '^error'
+		if test -n "$got_rundir" || test -n "$got_datestamp"
+		then
+			echo Only one of --datestamp or --rundir may be specified
+			usage
+		fi
+		got_rundir=y
 		rundir=$2
 		if test -e "$rundir"
 		then
@@ -128,8 +156,11 @@ do
 		shift
 		;;
 	*)
-		echo Unknown argument $1
-		usage
+		if test -n "$1"
+		then
+			echo Unknown argument $1
+			usage
+		fi
 		;;
 	esac
 	shift
-- 
2.31.1.189.g2e36527f23

