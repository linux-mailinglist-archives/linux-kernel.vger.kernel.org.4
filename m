Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CD1662158
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjAIJV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbjAIJV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:21:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3410E9B;
        Mon,  9 Jan 2023 01:19:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7CF04CE0B56;
        Mon,  9 Jan 2023 09:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE62C433D2;
        Mon,  9 Jan 2023 09:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673255969;
        bh=uKoGDZevx+gVbLfmMYY5TwRvq3hzb+5W3E7t3luGh1A=;
        h=From:To:Cc:Subject:Date:From;
        b=cu0bjgAitfPvflSUJnHrp6QmYi0GE/Ivp/cLcHFBiYYCZKJzzmqa30YoiR8gOknta
         jrmVw1Ts/hSx96TAliBUqVSE1XnU5rYiYhfXDeUlK56Qt/0utykZPeB/gXztTW1fPt
         6Z/NzC6gGjKYvl0WnZ3M8sK/PcENnLcYRmHhz2nI4+Ta/xxybuob9quCnkbi+05I45
         br3CJQkTOPj7oVTTD2c3vdS8EaLKA04i3X+SQdJyNd9HizbYP+lFR5j6S/GFxNgkzv
         RRY2rJXNc3TgNWGPjrjbEelogtX5u/XFGOBvIFLrWibkYgZe46j23F6kP51feUQfg6
         w22Gm8VsjsuKQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH] tomoyo: remove a temporary output file
Date:   Mon,  9 Jan 2023 18:19:18 +0900
Message-Id: <20230109091919.3160916-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Commit 8ab5bc40aad4 ("tomoyo: Omit use of bin2c") was locally modified
on top of the patch I submitted.

I recommend writing to the target directly.

If the recipe command fails, Kbuild will automatically delete the target
because scripts/Kbuild.include defines .DELETE_ON_ERROR.

If the recipe command is interrupted, GNU Make will automatically
delete the target if it has been partially updated. There was a corner
case where the target was not cleaned up, but it was fixed by Commit
a7f3257da8a8 ("kbuild: remove the target in signal traps when
interrupted").

Since this is a general problem, you can leave it to Kbuild instead
of introducing unneeded complexity.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

If it is not too late, please squash this.

 security/tomoyo/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/Makefile b/security/tomoyo/Makefile
index 458cf5e2fa25..884ff155edc3 100644
--- a/security/tomoyo/Makefile
+++ b/security/tomoyo/Makefile
@@ -9,7 +9,7 @@ quiet_cmd_policy = POLICY  $@
 	printf 'static char tomoyo_builtin_$x[] __initdata =\n'; \
 	sed -e 's/\\/\\\\/g' -e 's/\"/\\"/g' -e 's/\(.*\)/\t"\1\\n"/' -- $(firstword $(filter %/$x.conf %/$x.conf.default, $^) /dev/null);  \
 	printf '\t"";\n';) \
-	} > $@.tmp && mv $@.tmp $@
+	} > $@
 
 $(obj)/builtin-policy.h: $(wildcard $(obj)/policy/*.conf $(srctree)/$(src)/policy/*.conf.default) FORCE
 	$(call if_changed,policy)
-- 
2.34.1

