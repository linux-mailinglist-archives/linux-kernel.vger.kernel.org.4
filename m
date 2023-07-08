Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DC374BFFF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 01:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjGHXd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHXd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 19:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDD3E43;
        Sat,  8 Jul 2023 16:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6334B60B3A;
        Sat,  8 Jul 2023 23:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEDDC433C7;
        Sat,  8 Jul 2023 23:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688859235;
        bh=c7YAN05o/7u4ZuTezbA7EQz+CckXWvrgMuBtkeN7qoc=;
        h=From:To:Cc:Subject:Date:From;
        b=ccJ3VdkgiLo6S8x4jMomQTR0IpxahgKdZYUqLbArnCVD9vwbBAeA46fY5D4yvP3Hu
         rE0LhcRJz7D2TWe/LSZMxONyp3+mrpyPjp3db1QJWHr1+xQCmxjTFAESV4eIBlNnO2
         jZX+QUOoLZYMJrZBUjFpnG8y6ufrq7vHbdWfH+dbtHUQJXl+C9WOr+zSEX2Fjr0lyR
         U2Uu74MPBhBrgFEPqLcLKiy5p1IQxD6SiLFHoJIHEJHWyJLKsMar+VnkVqw/2kMPAX
         ew960hq4okBxJ1M33xQ2A3e57zb1eEmIuoyo9cGY578nXtf8cNUAkG+aFglkr/Z8W2
         fCi1aLZKUCW2A==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH] prctl: move PR_GET_AUXV out of PR_MCE_KILL
Date:   Sun,  9 Jul 2023 01:33:44 +0200
Message-ID: <20230708233344.361854-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow PR_GET_AUXV got added into PR_MCE_KILL's switch when
the patch was applied [1].

Thus move it out of the switch, to the place the patch added it.

In the recently released v6.4 kernel some user could, in
principle, be already using this feature by mapping the right
page and passing the PR_GET_AUXV constant as a pointer:

    prctl(PR_MCE_KILL, PR_GET_AUXV, ...)

So this does change the behavior for users. We could keep the bug
since the other subcases in PR_MCE_KILL (PR_MCE_KILL_CLEAR and
PR_MCE_KILL_SET) do not overlap.

However, v6.4 may be recent enough (2 weeks old) that moving
the lines (rather than just adding a new case) does not break
anybody? Moreover, the documentation in man-pages was just
committed today [2].

Fixes: ddc65971bb67 ("prctl: add PR_GET_AUXV to copy auxv to userspace")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/d81864a7f7f43bca6afa2a09fc2e850e4050ab42.1680611394.git.josh@joshtriplett.org/ [1]
Link: https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=8cf0c06bfd3c2b219b044d4151c96f0da50af9ad [2]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 kernel/sys.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 339fee3eff6a..a36a27ebac33 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2529,11 +2529,6 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			else
 				return -EINVAL;
 			break;
-	case PR_GET_AUXV:
-		if (arg4 || arg5)
-			return -EINVAL;
-		error = prctl_get_auxv((void __user *)arg2, arg3);
-		break;
 		default:
 			return -EINVAL;
 		}
@@ -2688,6 +2683,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SET_VMA:
 		error = prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
+	case PR_GET_AUXV:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = prctl_get_auxv((void __user *)arg2, arg3);
+		break;
 #ifdef CONFIG_KSM
 	case PR_SET_MEMORY_MERGE:
 		if (arg3 || arg4 || arg5)

base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
-- 
2.41.0

