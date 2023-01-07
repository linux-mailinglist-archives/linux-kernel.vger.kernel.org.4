Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B42660D2D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjAGJSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjAGJSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:18:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271F984616;
        Sat,  7 Jan 2023 01:18:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3CF160A09;
        Sat,  7 Jan 2023 09:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE6AC433D2;
        Sat,  7 Jan 2023 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673083108;
        bh=fj9DjQEVF1RKNJP+CRcGEz388dyhnFsoR6WMjCFOqHU=;
        h=From:To:Cc:Subject:Date:From;
        b=fsnwGHOwZfHklgbqUSUyhatDVeC/fUYvpEDJMNQxgVOQa4EYHFlP0FZ7ZRauoYCdX
         IpGQN1psHERmx+1zIf9RLUp06ul2FFJFOa2eUDhX4gI85FnQ2rCBWYYCOZC1hQ/1oZ
         8uKJHkCfJPT+833hRcyH1DiXBY5hddItC9XZVAtJ7cAhFyQdCjwZKFwVJ+xAW8gxa4
         Pj9mide8PomsgUFps2lGfhH26NNnh8eLALU3cH/n8GiNkcOlTiUuFo6cZW1sfFx9k+
         90YmPES4SXDPNTCbLzspB3O5hvamFGeGjRxr9lH5jnPlltDtwPLN+QrNx/pGzG1c9I
         BgoOAey0DXt4g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2 1/7] kbuild: refactor host*_flags
Date:   Sat,  7 Jan 2023 18:18:14 +0900
Message-Id: <20230107091820.3382134-1-masahiroy@kernel.org>
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

Remove _host*_flags.

This will change the -Wp,-MMD,$(depfile) order in the command line
but no functional change is intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 scripts/Makefile.host | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index da133780b751..dea494ef55d5 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -80,25 +80,21 @@ host-rust	:= $(addprefix $(obj)/,$(host-rust))
 #####
 # Handle options to gcc. Support building with separate output directory
 
-_hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
-                 $(HOSTCFLAGS_$(target-stem).o)
-_hostcxx_flags = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
-                 $(HOSTCXXFLAGS_$(target-stem).o)
-_hostrust_flags = $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
-                  $(HOSTRUSTFLAGS_$(target-stem))
+hostc_flags    = $(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
+                 $(HOSTCFLAGS_$(target-stem).o) -Wp,-MMD,$(depfile)
+hostcxx_flags  = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
+                  $(HOSTCXXFLAGS_$(target-stem).o) -Wp,-MMD,$(depfile)
+hostrust_flags = $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
+                 $(HOSTRUSTFLAGS_$(target-stem))
 
 # $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
 ifdef building_out_of_srctree
-_hostc_flags   += -I $(objtree)/$(obj)
-_hostcxx_flags += -I $(objtree)/$(obj)
+hostc_flags   += -I $(objtree)/$(obj)
+hostcxx_flags += -I $(objtree)/$(obj)
 endif
 endif
 
-hostc_flags    = -Wp,-MMD,$(depfile) $(_hostc_flags)
-hostcxx_flags  = -Wp,-MMD,$(depfile) $(_hostcxx_flags)
-hostrust_flags = $(_hostrust_flags)
-
 #####
 # Compile programs on the host
 
-- 
2.34.1

