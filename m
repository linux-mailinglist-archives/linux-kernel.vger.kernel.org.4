Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001BF67EAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjA0QUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjA0QT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:19:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94209AD17;
        Fri, 27 Jan 2023 08:19:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F30261CC3;
        Fri, 27 Jan 2023 16:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D360C433EF;
        Fri, 27 Jan 2023 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674836397;
        bh=dWkUXrk0g8ak0BjqJ52KwIBrpaKr1aFEKuCxJYYFurI=;
        h=From:To:Cc:Subject:Date:From;
        b=t7xEkFKOfRPsnN5oKe3OF1cn9OhAJNwfDcM7cj1tjE1WBrPQ775VJ33ZDoJNKcyAA
         2V3sAhAq5z61UBLNFKR91E8oYX47DUOb8lukaG2yV+UmJtrLSOF7XQ3ajeiIZopY2n
         DeuUmfr1Hcl2DD/zTAXwtoG/pzk6Rd4kyqp/cTa5BIWa8BJa3r9EFPkQqNQ0Mdeh3p
         ueBP6QLSk4PZp8AO4ImuDE6DIJhGKYLd7ZWsXF/ynUeEY0IctBAQE6KlHWK/4xdcgH
         if/0alOp1fDItKnLt5FsNPM4bmGDOodR0R59PJWkjuymV3ciGne4Z0NDKkQuYlYf6Z
         BOrDUWCm74JQQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: save overridden KERNELRELEASE in include/config/kernel.release
Date:   Sat, 28 Jan 2023 01:19:42 +0900
Message-Id: <20230127161942.543483-1-masahiroy@kernel.org>
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

${KERNELRELEASE} is used as a part of the installation path.
(INSTALL_DTBS_PATH, MODLIB, etc.)

When KERNELRELEASE is overridden from the command line, it should be
saved in include/config/kernel.release, so that it will be consistently
used for the installation steps.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

This patch will replace the buggy
 https://lore.kernel.org/linux-kbuild/20230122141428.115372-6-masahiroy@kernel.org/T/#u

 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 203b86e95197..aeea900eff71 100644
--- a/Makefile
+++ b/Makefile
@@ -1258,7 +1258,11 @@ vmlinux: vmlinux.o $(KBUILD_LDS) modpost
 # make sure no implicit rule kicks in
 $(sort $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)): . ;
 
+ifeq ($(origin KERNELRELEASE),file)
 filechk_kernel.release = $(srctree)/scripts/setlocalversion $(srctree)
+else
+filechk_kernel.release = echo $(KERNELRELEASE)
+endif
 
 # Store (new) KERNELRELEASE string in include/config/kernel.release
 include/config/kernel.release: FORCE
-- 
2.34.1

