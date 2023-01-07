Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD70A660CCD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 08:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjAGHr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 02:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAGHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 02:47:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1352848CD;
        Fri,  6 Jan 2023 23:47:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD3B608C3;
        Sat,  7 Jan 2023 07:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5AAC433D2;
        Sat,  7 Jan 2023 07:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673077675;
        bh=ePoHU4GENwIfAdeBcPaqU+CazliNAW/mfkD74kveQSE=;
        h=From:To:Cc:Subject:Date:From;
        b=EARISaexCJgsuI1qYC7HkNS6XgtOzyD2kMMUX93hH15nIeJuIURFAkLiPjsDmfJlU
         JXVymnYlboNjuQb+asz7oHo5XxbVnkaR8KovfE7B7ctrMMxm077UQ9dgzc4JoJCaWA
         QUYnburKZuINVt5PNTg4Ur4YYvH5WDX3X6tuh+FYUk/tlUCNQLVY4teitmnvLEUDDb
         ILBFLtQ5zZ6QEpunjc+HNRaVlDHykUL0Q2AX53F+vjb5jmrRz388DQbC/s/dIAH4kb
         nm9060g5Lzkd5THkKaXfY3/jOmsj5cfS+XYsvCYFht+N2uUTGO73qq1RiPe3RtGgLU
         ryiLS1qHG60Sw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        James Morris <jmorris@namei.org>,
        Michal Marek <mmarek@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH 1/3] tomoyo: fix broken dependency on *.conf.default
Date:   Sat,  7 Jan 2023 16:47:41 +0900
Message-Id: <20230107074743.3352242-1-masahiroy@kernel.org>
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

If *.conf.default is updated, builtin-policy.h should be rebuilt,
but this does not work when compiled with O= option.

[Without this commit]

  $ touch security/tomoyo/policy/exception_policy.conf.default
  $ make O=/tmp security/tomoyo/
  make[1]: Entering directory '/tmp'
    GEN     Makefile
    CALL    /home/masahiro/ref/linux/scripts/checksyscalls.sh
    DESCEND objtool
  make[1]: Leaving directory '/tmp'

[With this commit]

  $ touch security/tomoyo/policy/exception_policy.conf.default
  $ make O=/tmp security/tomoyo/
  make[1]: Entering directory '/tmp'
    GEN     Makefile
    CALL    /home/masahiro/ref/linux/scripts/checksyscalls.sh
    DESCEND objtool
    POLICY  security/tomoyo/builtin-policy.h
    CC      security/tomoyo/common.o
    AR      security/tomoyo/built-in.a
  make[1]: Leaving directory '/tmp'

$(srctree)/ is essential because $(wildcard ) does not follow VPATH.

Fixes: f02dee2d148b ("tomoyo: Do not generate empty policy files")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 security/tomoyo/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/Makefile b/security/tomoyo/Makefile
index cca5a3012fee..221eaadffb09 100644
--- a/security/tomoyo/Makefile
+++ b/security/tomoyo/Makefile
@@ -10,7 +10,7 @@ endef
 quiet_cmd_policy  = POLICY  $@
       cmd_policy  = ($(call do_policy,profile); $(call do_policy,exception_policy); $(call do_policy,domain_policy); $(call do_policy,manager); $(call do_policy,stat)) >$@
 
-$(obj)/builtin-policy.h: $(wildcard $(obj)/policy/*.conf $(src)/policy/*.conf.default) FORCE
+$(obj)/builtin-policy.h: $(wildcard $(obj)/policy/*.conf $(srctree)/$(src)/policy/*.conf.default) FORCE
 	$(call if_changed,policy)
 
 $(obj)/common.o: $(obj)/builtin-policy.h
-- 
2.34.1

