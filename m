Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BBC658ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiL2JPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiL2JPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:15:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4907B878;
        Thu, 29 Dec 2022 01:15:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C35761736;
        Thu, 29 Dec 2022 09:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349E8C433F1;
        Thu, 29 Dec 2022 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672305310;
        bh=eWNkQZA1QG5UrTZIG/e9yXi6rO1HLZ2+3IAAewb9dNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=od+ifUeGcuIM05gq4YB+UpsmTXjM2YP4OJJnk54ZAHgO/usJ1qKAD3qtgV7iXV3H4
         NBiScj9r7wWrJO2r6v13M15DzHMVV4yLI6NZE0mJ2jxWsesitknhwFNsWS/z23lmxt
         vMRS/TY31GaPBX/C/gr7nM4uPIG9+mnnEyLUstQOJK7Y68f2A4SU4EDPNeSROyjnHJ
         b+aODD7Z11nTTwWwcC+6VL/j5xUI4ANJQAsdPY+g+JqKIbcYQTP94k4ekGnCpomr4b
         AMRfdtt5wJnLxgstVw/gN63sVkpAvPRtU+54xnQjN0coJP7yGQFEmcVX7iPy9egkK3
         qtf/vew5vN4sg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/2] kbuild: add more comments for KBUILD_NOCMDDEP=1
Date:   Thu, 29 Dec 2022 18:15:01 +0900
Message-Id: <20221229091501.916296-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229091501.916296-1-masahiroy@kernel.org>
References: <20221229091501.916296-1-masahiroy@kernel.org>
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

The cmd-check for KBUILD_NOCMDDEP=1 may not be clear until you see
commit c4d5ee13984f ("kbuild: make KBUILD_NOCMDDEP=1 handle empty
built-in.o").

When a phony target (i.e. FORCE) is the only prerequisite, Kbuild
uses a tricky way to detect that the target does not exist.

Add more comments.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Kbuild.include | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 1a7514f49089..4648ab8f11d4 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -170,9 +170,13 @@ cmd = @$(if $(cmd_$(1)),set -e; $($(quiet)log_print) $(delete-on-interrupt) $(cm
 ifneq ($(KBUILD_NOCMDDEP),1)
 # Check if both commands are the same including their order. Result is empty
 # string if equal. User may override this check using make KBUILD_NOCMDDEP=1
+# If the target does not exist, the *.cmd file should not be included so
+# $(savedcmd_$@) gets empty. Then, target will be built even if $(newer-prereqs)
+# happens to become empty.
 cmd-check = $(filter-out $(subst $(space),$(space_escape),$(strip $(savedcmd_$@))), \
                          $(subst $(space),$(space_escape),$(strip $(cmd_$1))))
 else
+# We still need to detect missing targets.
 cmd-check = $(if $(strip $(savedcmd_$@)),,1)
 endif
 
@@ -186,6 +190,8 @@ make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst $$,$$$$,$(cmd_$(1))))
 
 # Find any prerequisites that are newer than target or that do not exist.
 # PHONY targets skipped in both cases.
+# If there is no prerequisite other than phony targets, $(newer-prereqs) becomes
+# empty even if the target does not exist. cmd-check saves this corner case.
 newer-prereqs = $(filter-out $(PHONY),$?)
 
 # It is a typical mistake to forget the FORCE prerequisite. Check it here so
-- 
2.34.1

