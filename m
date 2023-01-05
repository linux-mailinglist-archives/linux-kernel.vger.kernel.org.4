Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4232965E206
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjAEAw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAEAwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:52:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C00544D3;
        Wed,  4 Jan 2023 16:46:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57EAF61886;
        Thu,  5 Jan 2023 00:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB19C433F2;
        Thu,  5 Jan 2023 00:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879615;
        bh=c6V6DbhuE4+firCE/FA3UYYFAiKBd4cZRSXMN0/e5IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ab+fbb00PMpfmqflnV9aEEPvtIkxFRxpVVNJ2GnxPr3pBpsd0PPQ9hHaDZgBwNmJz
         M8lQJbk81l/DdbkuVD8GF2561llf6XP0VCxg1KFrCmDf/SwVxH6WRrfJYripJ/hRLk
         AbCsZOqKgjSrGMqKaNjPuOYxiS3xsNoLYTYVATkH3vIu2+OAPPdmvpsp90dYB5a1/G
         8kaQUW99q/Dsi7Hk28d0VnflV6WqoQeycnq0zWFK3u2bTBntnA4oSJS3jgXBwH3xtM
         m1mOJsTiKalUX0yqraLNs6LF/suMEXyUEMVPmt1TKgScGx14zrdbr+4iy1VyfwyFT3
         Wvsz76jZhSzkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6240A5C1456; Wed,  4 Jan 2023 16:46:55 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/4] rcu: Permit string-valued Kconfig options in kvm.sh
Date:   Wed,  4 Jan 2023 16:46:52 -0800
Message-Id: <20230105004652.1771676-4-paulmck@kernel.org>
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

This commit upgrades the kvm.sh script's --kconfig parameter to accept
string-valued Kconfig options with double-quoted string values.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 3025a949bc99e..62f3b0f56e4d7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -186,7 +186,7 @@ do
 		fi
 		;;
 	--kconfig|--kconfigs)
-		checkarg --kconfig "(Kconfig options)" $# "$2" '^CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\( CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\)*$' '^error$'
+		checkarg --kconfig "(Kconfig options)" $# "$2" '^CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\|"[^"]*"\)\( CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\|"[^"]*"\)\)*$' '^error$'
 		TORTURE_KCONFIG_ARG="`echo "$TORTURE_KCONFIG_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
 		shift
 		;;
-- 
2.31.1.189.g2e36527f23

