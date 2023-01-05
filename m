Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25C865E204
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjAEAwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjAEAwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:52:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD004544C3;
        Wed,  4 Jan 2023 16:46:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4616861890;
        Thu,  5 Jan 2023 00:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5455C433EF;
        Thu,  5 Jan 2023 00:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879615;
        bh=G9iXV2wVbhOZbCfZMGnwzoNe/h9I0GEx2kSS1ZeTvUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ow9MundN2/lILLz2oSpNKiNUXSdqapyFA+EwxubE6Vy5Dw2+gLM6Hjjvjd1PAjrrU
         fJDGWAXzw9tGXM8gr94auGGEofcwi5GmVEuy1IjCDOJCpjjez1Q71L1s7UoHmdr9Lr
         UNZzsliOyazP328TukuEZ0jmCK0FvjIYSyuBeYmK0lm4nLT/dfRcNd+Va55qHPkNmQ
         q+vD7f/ql8fY9ZcqakmQeemgAG09W4sVhH1kxv365LtAXDgr1wtYcMlALz/7bnjex+
         KdeIeMd1PWSa8vtB5li2/CHBffifSdXlqg04R+AzYTWjB3O8Jy0zpTkzEdO3j6dD8d
         bLjNz5QlwtEtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 604EA5C08E5; Wed,  4 Jan 2023 16:46:55 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/4] torture: Permit double-quoted-string Kconfig options
Date:   Wed,  4 Jan 2023 16:46:51 -0800
Message-Id: <20230105004652.1771676-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105004646.GA1771551@paulmck-ThinkPad-P17-Gen-1>
References: <20230105004646.GA1771551@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the presence of any quoted-string Kconfig option in the
scenario files or the CFcommon file (aside from the special-cased
CONFIG_INITRAMFS_SOURCE option) will result in an "improperly set"
diagnostic.  This commit updates configcheck.sh to strip double quotes
in order to permit string-valued Kconfig options to be handled correctly.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/configcheck.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/configcheck.sh b/tools/testing/selftests/rcutorture/bin/configcheck.sh
index 83fac1852ab23..b92dfeb7fbbfe 100755
--- a/tools/testing/selftests/rcutorture/bin/configcheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/configcheck.sh
@@ -10,10 +10,9 @@
 T="`mktemp -d ${TMPDIR-/tmp}/configcheck.sh.XXXXXX`"
 trap 'rm -rf $T' 0
 
-cat $1 > $T/.config
+sed -e 's/"//g' < $1 > $T/.config
 
-cat $2 | sed -e 's/\(.*\)=n/# \1 is not set/' -e 's/^#CHECK#//' |
-grep -v '^CONFIG_INITRAMFS_SOURCE' |
+sed -e 's/"//g' -e 's/\(.*\)=n/# \1 is not set/' -e 's/^#CHECK#//' < $2 |
 awk	'
 {
 		print "if grep -q \"" $0 "\" < '"$T/.config"'";
-- 
2.31.1.189.g2e36527f23

