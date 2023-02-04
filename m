Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6022C68AAFF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 16:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjBDPrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 10:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBDPrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 10:47:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394BE19F10
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 07:47:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81A0660C69
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 15:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D32C433D2;
        Sat,  4 Feb 2023 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675525639;
        bh=4c3vnPf5GRh9YHWyKGNEsvavDpComXQ5lkh7VdPCeEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TvEok09dWMynxhcYYPk+07t9ROiZNF00O/UsGFV997Tqj475XEsGkBCBn2XlSina1
         z/8GzJIp7ENMilH7L1vMBCFJqDZbGxeMg0agWNsFIiGMD2BnQNcHnrIz4OqWlY/Q+U
         /277jGk9YYz9EYodXtszMKahk4hf2g5IzsswDurn9Ih5q/tbCPpMyg96kL4hIUgIfO
         HUHwRejkdgeKf9qIQHP9DOZpVEexvZSI5BT71V5cA2lQahlT/w6LHQC8Ne3MkjDCvU
         pd8nClqrn2vWpEnYMK0MOldlBp5Tx5B/HQ2Sh+Fy9u1+3oawvrG1JAbfx23Xp42S5V
         0infUhuw3NCeQ==
Date:   Sat, 4 Feb 2023 07:47:17 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>
Subject: Re: [PATCH v2 15/16] objtool/powerpc: Enable objtool to be built on
 ppc
Message-ID: <20230204154717.w3gef6jbuhpyardp@treble>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-16-sv@linux.ibm.com>
 <33924523-5437-eb9a-116a-8e249ce99bd2@csgroup.eu>
 <b1079e99-c7ae-71f1-d578-80270adf44e7@infradead.org>
 <756321f5-9417-2d78-679a-1847fa18ff8a@infradead.org>
 <b212bec9-27c5-6be0-d33e-e23978a322a2@infradead.org>
 <20d2e88f-f543-2b46-8b2d-e6ac31462847@csgroup.eu>
 <98bda5ff-3249-fd2b-1a51-57c781aad56f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98bda5ff-3249-fd2b-1a51-57c781aad56f@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 02:10:34PM +0100, Christophe Leroy wrote:
> Ok, got the same problem as you with next-20230203
> 
>   DESCEND objtool
> <stdin>:1:10: fatal error: libelf.h: No such file or directory
> compilation terminated.
>   HOSTCC  /home/chleroy/linux-powerpc/tools/objtool/fixdep.o
>   HOSTLD  /home/chleroy/linux-powerpc/tools/objtool/fixdep-in.o
>   LINK    /home/chleroy/linux-powerpc/tools/objtool/fixdep
>   CC      /home/chleroy/linux-powerpc/tools/objtool/libsubcmd/exec-cmd.o
>   CC      /home/chleroy/linux-powerpc/tools/objtool/libsubcmd/help.o
>   CC      /home/chleroy/linux-powerpc/tools/objtool/libsubcmd/pager.o
>   CC /home/chleroy/linux-powerpc/tools/objtool/libsubcmd/parse-options.o
>   CC      /home/chleroy/linux-powerpc/tools/objtool/libsubcmd/run-command.o
>   CC      /home/chleroy/linux-powerpc/tools/objtool/libsubcmd/sigchain.o
>   CC /home/chleroy/linux-powerpc/tools/objtool/libsubcmd/subcmd-config.o
>   LD /home/chleroy/linux-powerpc/tools/objtool/libsubcmd/libsubcmd-in.o
>   AR      /home/chleroy/linux-powerpc/tools/objtool/libsubcmd/libsubcmd.a
>   INSTALL libsubcmd_headers
>   CC      /home/chleroy/linux-powerpc/tools/objtool/arch/powerpc/decode.o
>   CC      /home/chleroy/linux-powerpc/tools/objtool/arch/powerpc/special.o
>   LD /home/chleroy/linux-powerpc/tools/objtool/arch/powerpc/objtool-in.o
>   CC      /home/chleroy/linux-powerpc/tools/objtool/weak.o
>   CC      /home/chleroy/linux-powerpc/tools/objtool/check.o
>   CC      /home/chleroy/linux-powerpc/tools/objtool/special.o
>   CC      /home/chleroy/linux-powerpc/tools/objtool/builtin-check.o
>   CC      /home/chleroy/linux-powerpc/tools/objtool/elf.o
> elf.c: In function 'read_sections':
> elf.c:273:9: error: 'elf_getshnum' is deprecated
> [-Werror=deprecated-declarations]
>   273 |         if (elf_getshdrnum(elf->elf, &sections_nr)) {
>       |         ^~

This should be fixed with the latest tip/objtool/core which was rebased
today.  Here's the diff:

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 29a8cd7449bf..83b100c1e7f6 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -36,7 +36,7 @@ OBJTOOL_CFLAGS := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBE
 OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
-elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
+elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(HOSTCC) $(OBJTOOL_CFLAGS) -x c -E - | grep elf_getshdr)
 OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
 # Always want host compilation.
