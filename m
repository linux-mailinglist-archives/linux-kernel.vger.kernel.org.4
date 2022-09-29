Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2495EF3D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiI2LDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiI2LC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:02:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3208E0FE;
        Thu, 29 Sep 2022 04:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 131DD60EF5;
        Thu, 29 Sep 2022 11:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F08C433C1;
        Thu, 29 Sep 2022 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664449374;
        bh=1VKWcQeDFKoJAmUYEj0cP+tUilaieyXVJciTnlHebk0=;
        h=From:To:Cc:Subject:Date:From;
        b=q+73VmIrJSKTOrXEXCR//Hmhd8F9RT7ay/M9j1lNH382HTIx4DS/lfnw6yCCZz6KQ
         C9QYo70W6DutBh8eHnqn9XKIbKWV6BXOTgq+RkWj6aZYmhLsC6TV8hC3uBagA3Gh8n
         b8yxcIiVq3ZjtB/aYb3W1uChmUDW14XfbvgYyzyTLpevyvSr2LcOxLlflPV+ul/677
         CK5GHm9iMVdPCkpiIyZ/3reUMa4PMCxnDLO+8VkkAcNOELJSwgMXKzUPUnOUogs80Q
         4SFw0mZLnJvhn1zkrHWjxsnC+uqvBLXMlfeo1MgKUkEVQu2z8W9B9Fb09qgBEiWacH
         o6Mb9+69fTJGA==
From:   broonie@kernel.org
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: linux-next: manual merge of the powerpc tree with the kbuild tree
Date:   Thu, 29 Sep 2022 12:02:48 +0100
Message-Id: <20220929110248.39712-1-broonie@kernel.org>
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

Today's linux-next merge of the powerpc tree got conflicts in:

  arch/powerpc/Makefile
  arch/powerpc/kernel/Makefile

between commits:

  4f62512adbe9a ("kbuild: use obj-y instead extra-y for objects placed at the head")
  0f17eda6118db ("kbuild: remove head-y syntax")

from the kbuild tree and commits:

  dfc3095cec27f ("powerpc: Remove CONFIG_FSL_BOOKE")
  688de017efaab ("powerpc: Change CONFIG_E500 to CONFIG_PPC_E500")
  3e7318584dfec ("powerpc: Remove CONFIG_PPC_FSL_BOOK3E")
  6556fd1a1e9fc ("powerpc: Cleanup idle for e500")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/powerpc/Makefile
index 89c27827a11fb,19470d29de163..0000000000000
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
diff --cc arch/powerpc/kernel/Makefile
index ad3decb9f20ba,1f121c1888051..0000000000000
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@@ -118,12 -116,12 +116,12 @@@ obj-$(CONFIG_PPC_E500)		+= cpu_setup_e5
  obj-$(CONFIG_PPC_DOORBELL)	+= dbell.o
  obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
  
 -extra-$(CONFIG_PPC64)		:= head_64.o
 -extra-$(CONFIG_PPC_BOOK3S_32)	:= head_book3s_32.o
 -extra-$(CONFIG_40x)		:= head_40x.o
 -extra-$(CONFIG_44x)		:= head_44x.o
 -extra-$(CONFIG_PPC_85xx)	:= head_85xx.o
 -extra-$(CONFIG_PPC_8xx)		:= head_8xx.o
 +obj-$(CONFIG_PPC64)		+= head_64.o
 +obj-$(CONFIG_PPC_BOOK3S_32)	+= head_book3s_32.o
 +obj-$(CONFIG_40x)		+= head_40x.o
 +obj-$(CONFIG_44x)		+= head_44x.o
- obj-$(CONFIG_FSL_BOOKE)		+= head_fsl_booke.o
++obj-$(CONFIG_PPC_85xx)		+= head_85xx.o
 +obj-$(CONFIG_PPC_8xx)		+= head_8xx.o
  extra-y				+= vmlinux.lds
  
  obj-$(CONFIG_RELOCATABLE)	+= reloc_$(BITS).o
