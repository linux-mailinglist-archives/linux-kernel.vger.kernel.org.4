Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6876B7996
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCMN4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjCMN4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15B36B961;
        Mon, 13 Mar 2023 06:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75559612CE;
        Mon, 13 Mar 2023 13:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EEEC433D2;
        Mon, 13 Mar 2023 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678715773;
        bh=lwNDyirsOLX/1gzMo/KMEGrZVGoMdUl7WVD7PqcZeVk=;
        h=From:To:Cc:Subject:Date:From;
        b=SdAHjZD4Q+Xfpyh780M0HO/FZr+7H1jOadclJCst9hSAjktOqwq+/ZY53UXt3HGAs
         +tYNo18uBF3YoaNQ3P1d+VRDTea0qLyGZjcZwETWdnobaqtH0W46Bcifsd4NsJQtTJ
         cJTlEFQJHapbn/qw7h5Hm8Npvt9xUkhLq561I6G3FzHGEAQwzQacGC0wf6SCVcl0VC
         RZoMk7LrwZnCzBUCaQkGzwISzY3VlSKSdGAYq6Y48SlLtt2uyUx7THPuowSs81HmrA
         dlPXoRUUqrPsrJvhhljBD4kh93Hp8AmirXlAebQ3HezQnnpb9iK8ltMNQ7ZQTVJ4Ok
         PMURugHaB8y2w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Heinz Wiesinger <pprkut@slackware.com>, andersson@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, quic_rjendra@quicinc.com,
        quic_saipraka@quicinc.com, quic_sibis@quicinc.com
Subject: [PATCH] bootconfig: Fix testcase to increase max node
Date:   Mon, 13 Mar 2023 22:56:09 +0900
Message-Id: <167871576880.783280.2390717518955954275.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since commit 6c40624930c5 ("bootconfig: Increase max nodes of bootconfig
from 1024 to 8192 for DCC support") increased the max number of bootconfig
node to 8192, the bootconfig testcase of the max number of nodes fails.
To fix this issue, we can not simply increase the number in the test script
because the test bootconfig file becomes too big (>32KB). To fix that, we
can use a combination of three alphabets (26^3 = 17576). But with that,
we can not express the 8193 (just one exceed from the limitation) because
it also exceeds the max size of bootconfig. So, the first 26 nodes will just
use one alphabet.

With this fix, test-bootconfig.sh passes all tests.

Reported-by: Heinz Wiesinger <pprkut@slackware.com>
Link: https://lore.kernel.org/all/2463802.XAFRqVoOGU@amaterasu.liwjatan.org
Fixes: 6c40624930c5 ("bootconfig: Increase max nodes of bootconfig from 1024 to 8192 for DCC support")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/bootconfig/test-bootconfig.sh |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index f68e2e9eef8b..b1b77d76110d 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -14,10 +14,11 @@ ALIGN=4
 INITRD=`mktemp ${TESTDIR}/initrd-XXXX`
 TEMPCONF=`mktemp ${TESTDIR}/temp-XXXX.bconf`
 OUTFILE=`mktemp ${TESTDIR}/tempout-XXXX`
+AWKFILE=`mktemp ${TESTDIR}/temp-XXXX.awk`
 NG=0
 
 cleanup() {
-  rm -f $INITRD $TEMPCONF $OUTFILE
+  rm -f $INITRD $TEMPCONF $OUTFILE $AWKFILE
   exit $NG
 }
 
@@ -87,10 +88,16 @@ xfail grep -i "error" $OUTFILE
 
 echo "Max node number check"
 
-echo -n > $TEMPCONF
-for i in `seq 1 1024` ; do
-   echo "node$i" >> $TEMPCONF
-done
+cat > $AWKFILE << EOF
+BEGIN {
+  for (i = 0; i < 26; i += 1)
+      printf("%c\n", 65 + i % 26)
+  for (i = 26; i < 8192; i += 1)
+      printf("%c%c%c\n", 65 + i % 26, 65 + (i / 26) % 26, 65 + (i / 26 / 26))
+}
+EOF
+awk -f "$AWKFILE" > $TEMPCONF
+
 xpass $BOOTCONF -a $TEMPCONF $INITRD
 
 echo "badnode" >> $TEMPCONF

