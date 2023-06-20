Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF6736366
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjFTGGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjFTGGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B95D10C7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2D2961008
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7812BC433C8;
        Tue, 20 Jun 2023 06:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687241175;
        bh=7p04urdhVL/vDoH4p/S4/xKQGCuV22rFwM8xbFUKSMQ=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=GOz3afpXEx+Ylkp/ORnzsKThtqNE7h9DkY/jQezs8DZEuLLk03CyLoEqQwidAG2J7
         dUxiYdZOWZa7F9Jh53hRNPeHfsor7fVGZQZpjWqimVDFkxlzdvKgQowoed15enaaxm
         9O4wviAanDStf+T/pdsld1+F2Juwi4Bn9HTO83AYCk5pjEtiCM3+vATPLh4q1v3xj5
         E0u/JZHEj9252LmqS/KjxEnI6S5kRZG7Yb/p88F1OfUUrvRZAt13tC7sJBuF+iSOPV
         wUqEHNuMbCZvvnxm2sanyzc1zQtgCV8n5bgNJeYnTPWgIXmIbAUk+XnOQpIHIpcQIa
         eZ11TPWr+7z2g==
Date:   Tue, 20 Jun 2023 11:34:34 +0530
From:   Naveen N Rao <naveen@kernel.org>
Subject: Re: [RFC PATCH v1 2/3] powerpc: Mark all .S files invalid for objtool
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1686922583.git.christophe.leroy@csgroup.eu>
        <17feb760a05edd372984bdf148c760c6f279b401.1686922583.git.christophe.leroy@csgroup.eu>
In-Reply-To: <17feb760a05edd372984bdf148c760c6f279b401.1686922583.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/0.16.0 (https://github.com/astroidmail/astroid)
Message-Id: <1687240339.ekhpozhevo.naveen@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> A lot of work is required in .S files in order to get them ready
> for objtool checks.
>=20
> For the time being, exclude them from the checks.
>=20
> This is done with the script below:
>=20
> 	#!/bin/sh
> 	DIRS=3D`find arch/powerpc -name "*.S" -exec dirname {} \; | sort | uniq`
> 	for d in $DIRS
> 	do
> 		pushd $d
> 		echo >> Makefile
> 		for f in *.S
> 		do
> 			echo "OBJECT_FILES_NON_STANDARD_$f :=3D y" | sed s/"\.S"/".o"/g
> 		done >> Makefile
> 		popd
> 	done
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/boot/Makefile                 | 17 +++++++++
>  arch/powerpc/crypto/Makefile               | 13 +++++++
>  arch/powerpc/kernel/Makefile               | 44 ++++++++++++++++++++++
>  arch/powerpc/kernel/trace/Makefile         |  4 ++
>  arch/powerpc/kernel/vdso/Makefile          | 11 ++++++
>  arch/powerpc/kexec/Makefile                |  2 +
>  arch/powerpc/kvm/Makefile                  | 13 +++++++
>  arch/powerpc/lib/Makefile                  | 25 ++++++++++++
>  arch/powerpc/mm/book3s32/Makefile          |  3 ++
>  arch/powerpc/mm/nohash/Makefile            |  3 ++
>  arch/powerpc/perf/Makefile                 |  2 +
>  arch/powerpc/platforms/44x/Makefile        |  2 +
>  arch/powerpc/platforms/52xx/Makefile       |  3 ++
>  arch/powerpc/platforms/83xx/Makefile       |  2 +
>  arch/powerpc/platforms/cell/spufs/Makefile |  3 ++
>  arch/powerpc/platforms/pasemi/Makefile     |  2 +
>  arch/powerpc/platforms/powermac/Makefile   |  3 ++
>  arch/powerpc/platforms/powernv/Makefile    |  3 ++
>  arch/powerpc/platforms/ps3/Makefile        |  2 +
>  arch/powerpc/platforms/pseries/Makefile    |  2 +
>  arch/powerpc/purgatory/Makefile            |  3 ++
>  arch/powerpc/sysdev/Makefile               |  3 ++
>  arch/powerpc/xmon/Makefile                 |  3 ++
>  23 files changed, 168 insertions(+)
>

I think it might be better to have a config option so that architectures=20
can opt-in to skip objtool on asm files. We can then do:

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9f94fc83f08652..878027cf4faf37 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -359,7 +359,11 @@ $(obj)/%.s: $(src)/%.S FORCE
        $(call if_changed_dep,cpp_s_S)
=20
 quiet_cmd_as_o_S =3D AS $(quiet_modtag)  $@
+ifndef CONFIG_ARCH_OBJTOOL_SKIP_ASM
       cmd_as_o_S =3D $(CC) $(a_flags) -c -o $@ $< $(cmd_objtool)
+else
+      cmd_as_o_S =3D $(CC) $(a_flags) -c -o $@ $<
+endif
=20
 ifdef CONFIG_ASM_MODVERSIONS
=20


- Naveen

