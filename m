Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7EF69C09B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjBSOQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBSOQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:16:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF46E3AB;
        Sun, 19 Feb 2023 06:16:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 039E9B803F1;
        Sun, 19 Feb 2023 14:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BB0C433D2;
        Sun, 19 Feb 2023 14:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676816178;
        bh=mHhx5AehWJHYHcZ1xrAE18qXym1Yn6rcKDqM/8buz3s=;
        h=From:To:Cc:Subject:Date:From;
        b=INJl1Ttznv53s+8dfVHbD/3/M04BQRCYsZJx2Z8t9jg/AeBgQmESXbqcjd9IHzgWa
         cyJCzC6EKBCjfd8sg/o/mbStbqiWsnPnzDjISXS/QjsbmKEEA7maMxciJz9vNNllOh
         4nDD6KbEnzlkQZs3yHJCsd+4w3KBSRQi2Tur9/OZRCMMBINM/yszSzDKu8WxD/JPHL
         AwBzaothdRzBtp4L1z+c05AGRkcZov6qO9lBOtGiWlRu6ecaK+GYZOCcu/UJLbRdCa
         1rOb7VmEBZppNkEw/asfs80tqL0+vx2BC7LgmVTMycVYUu3dty9JMjV2+KG8FlE/Vg
         /7rLomjyjzVQA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: [PATCH 1/4] sh: fix -Wmissing-include-dirs warnings for various platforms
Date:   Sun, 19 Feb 2023 23:15:52 +0900
Message-Id: <20230219141555.2308306-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 0day bot reports a lot of warnings (or errors due to CONFIG_WERROR)
like this:

  cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]

Indeed, arch/sh/include/mach-hp6xx does not exist.

-Wmissing-include-dirs is W=1 warning, but it may be annoying
when CONFIG_BTRFS_FS is enabled because fs/btrfs/Makefile
unconditionally adds this warning option.

arch/sh/Makefile defines machdir-y for two purposes:

 - Build platform code in arch/sh/boards/mach-*/
 - Add arch/sh/include/mach-*/ to the header search path

For the latter, some platforms use arch/sh/include/mach-common/ instead
of having its own arch/sh/include/mach-*/.

Drop unneeded machdir-y to not include non-existing include directory.

To build arch/sh/boards/mach-*/, use the standard obj-y syntax in
arch/sh/boards/Makefile.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302190641.30VVXnPb-lkp@intel.com/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/Makefile        | 18 +-----------------
 arch/sh/boards/Makefile | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 5c8776482530..a9cad5137f92 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -116,31 +116,15 @@ export ld-bfd
 
 # Mach groups
 machdir-$(CONFIG_SOLUTION_ENGINE)		+= mach-se
-machdir-$(CONFIG_SH_HP6XX)			+= mach-hp6xx
 machdir-$(CONFIG_SH_DREAMCAST)			+= mach-dreamcast
 machdir-$(CONFIG_SH_SH03)			+= mach-sh03
-machdir-$(CONFIG_SH_RTS7751R2D)			+= mach-r2d
-machdir-$(CONFIG_SH_HIGHLANDER)			+= mach-highlander
 machdir-$(CONFIG_SH_MIGOR)			+= mach-migor
-machdir-$(CONFIG_SH_AP325RXA)			+= mach-ap325rxa
 machdir-$(CONFIG_SH_KFR2R09)			+= mach-kfr2r09
 machdir-$(CONFIG_SH_ECOVEC)			+= mach-ecovec24
-machdir-$(CONFIG_SH_SDK7780)			+= mach-sdk7780
 machdir-$(CONFIG_SH_SDK7786)			+= mach-sdk7786
 machdir-$(CONFIG_SH_X3PROTO)			+= mach-x3proto
-machdir-$(CONFIG_SH_SH7763RDP)			+= mach-sh7763rdp
-machdir-$(CONFIG_SH_SH4202_MICRODEV)		+= mach-microdev
 machdir-$(CONFIG_SH_LANDISK)			+= mach-landisk
-machdir-$(CONFIG_SH_LBOX_RE2)			+= mach-lboxre2
-machdir-$(CONFIG_SH_RSK)			+= mach-rsk
-
-ifneq ($(machdir-y),)
-core-y	+= $(addprefix arch/sh/boards/, \
-	     $(filter-out ., $(patsubst %,%/,$(machdir-y))))
-endif
-
-# Common machine type headers. Not part of the arch/sh/boards/ hierarchy.
-machdir-y	+= mach-common
+machdir-y					+= mach-common
 
 # Companion chips
 core-$(CONFIG_HD6446X_SERIES)	+= arch/sh/cchips/hd6446x/
diff --git a/arch/sh/boards/Makefile b/arch/sh/boards/Makefile
index 4002a22a7c40..b57219436ace 100644
--- a/arch/sh/boards/Makefile
+++ b/arch/sh/boards/Makefile
@@ -18,3 +18,22 @@ obj-$(CONFIG_SH_APSH4A3A)	+= board-apsh4a3a.o
 obj-$(CONFIG_SH_APSH4AD0A)	+= board-apsh4ad0a.o
 
 obj-$(CONFIG_SH_DEVICE_TREE)	+= of-generic.o
+
+obj-$(CONFIG_SOLUTION_ENGINE)	+= mach-se/
+obj-$(CONFIG_SH_HP6XX)		+= mach-hp6xx/
+obj-$(CONFIG_SH_DREAMCAST)	+= mach-dreamcast/
+obj-$(CONFIG_SH_SH03)		+= mach-sh03/
+obj-$(CONFIG_SH_RTS7751R2D)	+= mach-r2d/
+obj-$(CONFIG_SH_HIGHLANDER)	+= mach-highlander/
+obj-$(CONFIG_SH_MIGOR)		+= mach-migor/
+obj-$(CONFIG_SH_AP325RXA)	+= mach-ap325rxa/
+obj-$(CONFIG_SH_KFR2R09)	+= mach-kfr2r09/
+obj-$(CONFIG_SH_ECOVEC)		+= mach-ecovec24/
+obj-$(CONFIG_SH_SDK7780)	+= mach-sdk7780/
+obj-$(CONFIG_SH_SDK7786)	+= mach-sdk7786/
+obj-$(CONFIG_SH_X3PROTO)	+= mach-x3proto/
+obj-$(CONFIG_SH_SH7763RDP)	+= mach-sh7763rdp/
+obj-$(CONFIG_SH_SH4202_MICRODEV)+= mach-microdev/
+obj-$(CONFIG_SH_LANDISK)	+= mach-landisk/
+obj-$(CONFIG_SH_LBOX_RE2)	+= mach-lboxre2/
+obj-$(CONFIG_SH_RSK)		+= mach-rsk/
-- 
2.34.1

