Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67AA7363BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjFTGqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFTGqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:46:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C141810C1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41E2D60E76
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089F0C433C8;
        Tue, 20 Jun 2023 06:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687243575;
        bh=qhJnpldHx9Ngi30rgQn2pavbmqnfNpLSyIzKTRd2o8U=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=kIXbQPANILwo9Y1wWYt6q3ChJF4DSI7gO8abNzUByovnraJeG4frzARCO/h7w2vGG
         OdEwN7cDxxo0Nsy/aL9GTigRykijhUklQZJdeYIOACEfIJ0kUVzetlw/Pck5EGtn/s
         pRFsD2QihkqL2ihuog8Hi/IBR9Tt0JBfyJHxiTInIWhESa2FbPXgPKvNM4tXEkVciA
         ASsWswm4RFzo/SeZz43SmoPhwDUI2cOwxMLj7ko6Dr6maWzspK77D3gs7yee8/kXyL
         +Jov0Fq6U99iC6vfw41o6yPWlCBdbbfxOyf0OaHG94EakuAWOPE4Pd/pUDs88bIVRR
         CHOcb2bbxILjg==
Date:   Tue, 20 Jun 2023 12:10:23 +0530
From:   Naveen N Rao <naveen@kernel.org>
Subject: Re: [RFC PATCH v1 2/3] powerpc: Mark all .S files invalid for objtool
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1686922583.git.christophe.leroy@csgroup.eu>
        <17feb760a05edd372984bdf148c760c6f279b401.1686922583.git.christophe.leroy@csgroup.eu>
        <1687240339.ekhpozhevo.naveen@kernel.org>
        <185a1734-80a3-08fd-18d2-08b24acace37@csgroup.eu>
In-Reply-To: <185a1734-80a3-08fd-18d2-08b24acace37@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/0.16.0 (https://github.com/astroidmail/astroid)
Message-Id: <1687242440.kuukzoknou.naveen@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
>=20
>=20
> Le 20/06/2023 =C3=A0 08:04, Naveen N Rao a =C3=A9crit=C2=A0:
>> Christophe Leroy wrote:
>>> A lot of work is required in .S files in order to get them ready
>>> for objtool checks.
>>>
>>> For the time being, exclude them from the checks.
>>>
>>> This is done with the script below:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0#!/bin/sh
>>> =C2=A0=C2=A0=C2=A0=C2=A0DIRS=3D`find arch/powerpc -name "*.S" -exec dir=
name {} \; | sort |=20
>>> uniq`
>>> =C2=A0=C2=A0=C2=A0=C2=A0for d in $DIRS
>>> =C2=A0=C2=A0=C2=A0=C2=A0do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pushd $d
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo >> Makefile
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for f in *.S
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo=
 "OBJECT_FILES_NON_STANDARD_$f :=3D y" | sed s/"\.S"/".o"/g
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done >> Makefile
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 popd
>>> =C2=A0=C2=A0=C2=A0=C2=A0done
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>> =C2=A0arch/powerpc/boot/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++++
>>> =C2=A0arch/powerpc/crypto/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++++++
>>> =C2=A0arch/powerpc/kernel/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 44 +++++++++++++++++++++=
+
>>> =C2=A0arch/powerpc/kernel/trace/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++
>>> =C2=A0arch/powerpc/kernel/vdso/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++
>>> =C2=A0arch/powerpc/kexec/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
>>> =C2=A0arch/powerpc/kvm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ++++++=
+
>>> =C2=A0arch/powerpc/lib/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 25 ++++++=
++++++
>>> =C2=A0arch/powerpc/mm/book3s32/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>>> =C2=A0arch/powerpc/mm/nohash/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>>> =C2=A0arch/powerpc/perf/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
>>> =C2=A0arch/powerpc/platforms/44x/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +
>>> =C2=A0arch/powerpc/platforms/52xx/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 3 ++
>>> =C2=A0arch/powerpc/platforms/83xx/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +
>>> =C2=A0arch/powerpc/platforms/cell/spufs/Makefile |=C2=A0 3 ++
>>> =C2=A0arch/powerpc/platforms/pasemi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +
>>> =C2=A0arch/powerpc/platforms/powermac/Makefile=C2=A0=C2=A0 |=C2=A0 3 ++
>>> =C2=A0arch/powerpc/platforms/powernv/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=
 3 ++
>>> =C2=A0arch/powerpc/platforms/ps3/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +
>>> =C2=A0arch/powerpc/platforms/pseries/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 +
>>> =C2=A0arch/powerpc/purgatory/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>>> =C2=A0arch/powerpc/sysdev/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>>> =C2=A0arch/powerpc/xmon/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>>> =C2=A023 files changed, 168 insertions(+)
>>>
>>=20
>> I think it might be better to have a config option so that architectures=
=20
>> can opt-in to skip objtool on asm files. We can then do:
>=20
> Well, the idea here was to initially opt out every file in order to=20
> quickly add support for objtool uaccess checking, and then opt-in back=20
> files one by one once they are ready for it.

That was my initial thought too.

>=20
> In most files,all we have to do is to replace all _GLOBAL() by=20
> SYM_FUNC_START(), add a SYM_FUNC_END() at the end of the function, then=20
> do the same with SYM_FUNC_START_LOCAL() with all non global functions.
>=20
> That's easy to do and worth it but it takes time, hence the idea of an=20
> incremental approach.

Right. But until that's done, I am not sure it is worth the churn to the=20
Makefiles.

Besides, it isn't clear to me that the existing features we are=20
targeting for objtool on powerpc need objtool to run on asm files (so,=20
an incremental approach may not really get us much). Objtool --mcount=20
doesn't care about .S files.  I suppose uaccess validation also doesn't=20
need it. It's likely just stack validation (should we choose to enable=20
it) that needs objtool to be run on asm files.

The first patch series converting much of our .S files can drop the=20
config option and exclude the remaining files.


- Naveen

