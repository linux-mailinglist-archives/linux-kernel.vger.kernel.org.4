Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54F5ECC02
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiI0SRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiI0SQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:16:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCA7DF73;
        Tue, 27 Sep 2022 11:16:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0B5061ADE;
        Tue, 27 Sep 2022 18:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71636C433C1;
        Tue, 27 Sep 2022 18:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664302614;
        bh=yBmLVeYuwO9SPGn3sVc/WFiOlCFKTla9PdQObzOz11Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Yqoyza1RJIbYJKx0MOumj/Yr/WHVG1sepV9t85gBanYExG3tsXR49qmhUAI/d5OLs
         ApHLJA2f37Gq8GBnEnoqpwbZX9waP4D4Zy96LhTGZafucT3jTynUov4DflKYt+LzQo
         wTpo5DDjrW/UcY8xcWb9Ki8CZfAtIOxxq+p44dZc4lhqRirdj2scaTZ3ATyLlBjV5w
         tj6Vp7+VhjeGGN8oLrWVJqp0bshi8o9naoSUvDzv6j/azES50Avj3NRIwrsmPX8qBT
         kml4z8++hEzqKMNrS/tTZ1nLReIYJlOOY6cu1HwE/2uYFU2m542sfm57pKCQSQwxI4
         6KBuFgnE2xRCQ==
From:   broonie@kernel.org
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with the kbuild tree
Date:   Tue, 27 Sep 2022 19:16:47 +0100
Message-Id: <20220927181647.487727-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the rust tree got a conflict in:

  Makefile

between commit:

  0cc1b22fa606e ("kbuild: list sub-directories in ./Kbuild")
  ca5f20da2ffcb ("kbuild: move .vmlinux.objs rule to Makefile.modpost")

from the kbuild tree and commit:

  d64ddbd68af8f ("Kbuild: add Rust support")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc Makefile
index 2b4980490ecb2,c759ee3152544..0000000000000
--- a/Makefile
+++ b/Makefile
@@@ -789,7 -862,11 +861,10 @@@ KBUILD_CFLAGS += $(stackp-flags-y
  
  KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
  KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
 -KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
  
+ KBUILD_RUSTFLAGS-$(CONFIG_WERROR) += -Dwarnings
+ KBUILD_RUSTFLAGS += $(KBUILD_RUSTFLAGS-y)
+ 
  ifdef CONFIG_CC_IS_CLANG
  KBUILD_CPPFLAGS += -Qunused-arguments
  # The kernel builds with '-std=gnu11' so use of GNU extensions is acceptable.
@@@ -1098,9 -1182,16 +1179,8 @@@ export MODORDER := $(extmod_prefix)modu
  export MODULES_NSDEPS := $(extmod_prefix)modules.nsdeps
  
  ifeq ($(KBUILD_EXTMOD),)
 -core-y			+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
 -core-$(CONFIG_BLOCK)	+= block/
 -core-$(CONFIG_IO_URING)	+= io_uring/
 -core-$(CONFIG_RUST)	+= rust/
 -
 -vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, \
 -		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 -		     $(libs-y) $(libs-m)))
--
 -vmlinux-alldirs	:= $(sort $(vmlinux-dirs) Documentation \
 +build-dir	:= .
 +clean-dirs	:= $(sort . Documentation \
  		     $(patsubst %/,%,$(filter %/, $(core-) \
  			$(drivers-) $(libs-))))
  
@@@ -1497,7 -1585,7 +1581,8 @@@ endif # CONFIG_MODULE
  # Directories & files removed with 'make clean'
  CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
  	       modules.builtin modules.builtin.modinfo modules.nsdeps \
- 	       compile_commands.json .thinlto-cache .vmlinux.objs
 -	       compile_commands.json .thinlto-cache rust/test rust/doc
++	       compile_commands.json .thinlto-cache .vmlinux.objs \
++	       rust/test rust/doc
  
  # Directories & files removed with 'make mrproper'
  MRPROPER_FILES += include/config include/generated          \
diff --git a/Kbuild b/Kbuild
index 8a37584d1fd6b..5f4a23fc87b63 100644
--- a/Kbuild
+++ b/Kbuild
@@ -91,6 +91,7 @@ obj-$(CONFIG_BLOCK)	+= block/
 obj-$(CONFIG_IO_URING)	+= io_uring/
 obj-y			+= $(ARCH_LIB)
 obj-y			+= drivers/
+obj-$(CONFIG_RUST)	+= rust/
 obj-y			+= sound/
 obj-$(CONFIG_SAMPLES)	+= samples/
 obj-$(CONFIG_NET)	+= net/
