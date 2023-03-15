Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D306BB53D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjCONyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjCONyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEC615164;
        Wed, 15 Mar 2023 06:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6B4961D5F;
        Wed, 15 Mar 2023 13:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABAEC433EF;
        Wed, 15 Mar 2023 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678888453;
        bh=MeUXDq1IdFKnPC0Emxz8eivaGaiRcMqUYA0SAkpvH7M=;
        h=From:To:Cc:Subject:Date:From;
        b=kOqVUhOrBsS97XPXEH4mPaXOnze6wk6DENj5/ciEAbQqRH43FTcfX25SKJ1lVt9nE
         AvepeV56Se7O/Z1Yhq0tG6FVTzYhqrLC50gddTLerWCxOHsFLTmUJy+zU5gS0FBlpo
         QFjF8PCngkxGMN5grwRPfiFLmBOthskskDJb1UisHOGl/nSXClKcQNhI6ano0AGHOE
         KncDHxhRgX+HcghinIfdHFLxifvsdPLnCPBKJMgxvkDvcRR6n6ZpgH9DOCE1S8S3pX
         pc0P+2wmBB7kFSvT7PRWazkmLYwFC0jN/z4F0HfA3QXN/hHc+xsoWPWEDnyX2AIQEy
         AF5jUAKa8d/3Q==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Heinz Wiesinger <pprkut@slackware.com>, andersson@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, quic_rjendra@quicinc.com,
        quic_saipraka@quicinc.com, quic_sibis@quicinc.com
Subject: [PATCH v2] bootconfig: Fix testcase to increase max node
Date:   Wed, 15 Mar 2023 22:54:08 +0900
Message-Id: <167888844790.791176.670805252426835131.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 tools/bootconfig/test-bootconfig.sh |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index f68e2e9eef8b..a2c484c243f5 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -87,10 +87,14 @@ xfail grep -i "error" $OUTFILE
 
 echo "Max node number check"
 
-echo -n > $TEMPCONF
-for i in `seq 1 1024` ; do
-   echo "node$i" >> $TEMPCONF
-done
+awk '
+BEGIN {
+  for (i = 0; i < 26; i += 1)
+      printf("%c\n", 65 + i % 26)
+  for (i = 26; i < 8192; i += 1)
+      printf("%c%c%c\n", 65 + i % 26, 65 + (i / 26) % 26, 65 + (i / 26 / 26))
+}
+' > $TEMPCONF
 xpass $BOOTCONF -a $TEMPCONF $INITRD
 
 echo "badnode" >> $TEMPCONF

