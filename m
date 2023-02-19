Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9EE69C099
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBSOQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBSOQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:16:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EC4E3BF;
        Sun, 19 Feb 2023 06:16:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D7EF60C1E;
        Sun, 19 Feb 2023 14:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6175C4339B;
        Sun, 19 Feb 2023 14:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676816180;
        bh=BqvNL4z/UoB9dOUirlrYrge5KkBaM56X6vW7byxa1NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eh9g1i6ltIJaKeZXIFwrhYBOVzbBH+s9K5nOu/rEnBU6ihKJpvfiFj6jd0oqV/kGi
         tdgKxBc2d2ui0a/g1q4xXzE8rv9wHdHHl5czwzztpttn+3DxDErdE3oCkW5c2UbIyz
         89Fk+OZkAqGZZovU6ZGPe+bvLq0wD0ltzBfj8meuiiV1nm2LX+uNSB1kzEQaz2jPp6
         aCapvZnrsli7QqfgivSeLm73M6gH3N7x46ctYe3rRceiAZWoIcTWqjpQ4ht42RlapX
         /ERBCENd2fvXn/kD1Uyn9cfl9AKqLm1Tckwp0WZA3uzOo5oNVZ9Yg4DvxTsLCRXFnA
         1oTtxU+hTTEWg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: [PATCH 2/4] sh: move build rule of cchips/hd6446x/ to arch/sh/Kbuild
Date:   Sun, 19 Feb 2023 23:15:53 +0900
Message-Id: <20230219141555.2308306-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219141555.2308306-1-masahiroy@kernel.org>
References: <20230219141555.2308306-1-masahiroy@kernel.org>
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

This is the last user of core-y in ARCH=sh.

Use the standard obj-y syntax.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/Kbuild   | 2 ++
 arch/sh/Makefile | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sh/Kbuild b/arch/sh/Kbuild
index be171880977e..056efec72c2a 100644
--- a/arch/sh/Kbuild
+++ b/arch/sh/Kbuild
@@ -3,5 +3,7 @@ obj-y				+= kernel/ mm/ boards/
 obj-$(CONFIG_SH_FPU_EMU)	+= math-emu/
 obj-$(CONFIG_USE_BUILTIN_DTB)	+= boot/dts/
 
+obj-$(CONFIG_HD6446X_SERIES)	+= cchips/hd6446x/
+
 # for cleaning
 subdir- += boot
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index a9cad5137f92..0625796cfe7f 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -126,9 +126,6 @@ machdir-$(CONFIG_SH_X3PROTO)			+= mach-x3proto
 machdir-$(CONFIG_SH_LANDISK)			+= mach-landisk
 machdir-y					+= mach-common
 
-# Companion chips
-core-$(CONFIG_HD6446X_SERIES)	+= arch/sh/cchips/hd6446x/
-
 #
 # CPU header paths
 #
-- 
2.34.1

