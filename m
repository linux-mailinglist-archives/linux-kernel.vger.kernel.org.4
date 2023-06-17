Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA87341E6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjFQPai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjFQPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E25F1FD7;
        Sat, 17 Jun 2023 08:30:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9991560FA0;
        Sat, 17 Jun 2023 15:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62639C433C8;
        Sat, 17 Jun 2023 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687015833;
        bh=5iL1FxKNMlL/BSu7pumyfvfaweoKYzZMLOet3Mrh+B8=;
        h=From:To:Cc:Subject:Date:From;
        b=JKwE4ZuWdpep3jsmBWR6/OStT781HZs+JeLHr6Gj8JdPqnFoNuC88C/wjDniaqWor
         Eu0EylBuoewFFPFcFhp1Z1bK5RoL067rBj1l0mQ+ORGhXqokEnNR8fmzdIAb6q3H5e
         9ksyD+6gPr5i8SBz18Qfeb2tUCK4ZEqgwaeizqTtFCua3U2g5Ql04lLwP3EQkigWZy
         idl7nfcsjpXO54AZ8fjAuBMtqx7Xd5DucsjdiWX2Vrt1YmdsI5bKgbKqOx5VhMhL2h
         u33MKHY2esIj/rms6ACTtJkkJC4S4nLFi1KYY22ptQmdbO1BldHJbhqeqOrcvSH3yZ
         jQe+bji+zDKcw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH] kbuild: make clean rule robust against too long argument error
Date:   Sun, 18 Jun 2023 00:30:25 +0900
Message-Id: <20230617153025.1653851-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Commit cd968b97c492 ("kbuild: make built-in.a rule robust against too
long argument error") made a build rule robust against "Argument list
too long" error.

Eugeniu Rosca reported the same error occurred when cleaning an external
module.

The $(obj)/ prefix can be a very long path for external modules.

Apply a similar solution to 'make clean'.

Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.clean | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index 3649900696dd..235408a44f90 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -37,8 +37,9 @@ __clean-files   := $(wildcard $(addprefix $(obj)/, $(__clean-files)))
 
 # ==========================================================================
 
+# Use xargs to make this robust against "Argument list too long" error
 quiet_cmd_clean = CLEAN   $(obj)
-      cmd_clean = rm -rf $(__clean-files)
+      cmd_clean = printf '$(obj)/%s ' $(patsubst $(obj)/%,%,$(__clean-files)) | xargs rm -rf
 
 __clean: $(subdir-ymn)
 ifneq ($(strip $(__clean-files)),)
-- 
2.39.2

