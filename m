Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EE667ABC5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjAYIcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjAYIcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:32:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F267DAC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:31:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1xs33lGPz4xZb;
        Wed, 25 Jan 2023 19:31:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1674635511;
        bh=RijxhIRRoJPT60iN7+sO/FMf5qceHAshwUEPvlc0unI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=oSCu283IAi1f/b8+XX/irxWfR02z3kE2hV8HUJBZ4WOFfChIAHCsZ2BdLtIN5rTdF
         QhxChafOYGqg344/ccP6Rewg66ECzdPYzPYj/1apU8wLPvKrEH02pFXscMMr50PiJw
         x1C60vUKuDt4/oJ8ufhNLzazm8cBHPAGEHBaNK2+fuTO8px0Ba8m9LgDXNan9EZ72S
         BgCgyWk5xdbYckG9Lblhq9t5hF/wI3C7vWyN3FJepus0iMusQsDIgklya0IAQWBHZd
         eQaFw9fU0PFUaFoxAgDvHXGoqFQCUPVB5PQz0E0ZTvKmf/9a0v3tEoK/DKnD2Vev8Q
         rTsPf04LcJJaQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        kernel test robot <lkp@intel.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Subject: Re: arch/powerpc/kernel/head_85xx.o: warning: objtool:
 .head.text+0x1a6c: unannotated intra-function call
In-Reply-To: <1674631223.9e09lbzzb6.naveen@linux.ibm.com>
References: <202301161955.38kK6ksW-lkp@intel.com>
 <b2273730-f885-7658-7ec4-12fb5bfc515b@linux.ibm.com>
 <1674631223.9e09lbzzb6.naveen@linux.ibm.com>
Date:   Wed, 25 Jan 2023 19:31:46 +1100
Message-ID: <87v8kvow0d.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> Sathvika Vasireddy wrote:
>>=20
>>>>> arch/powerpc/kvm/booke.o: warning: objtool: kvmppc_fill_pt_regs+0x30:=
 unannotated intra-function call
>>=20
>> As an attempt to fix it, I tried expanding ANNOTATE_INTRA_FUNCTION_CALL=
=20
>> macro to indicate that the branch target is valid. It then threw another=
=20
>> warning (arch/powerpc/kvm/booke.o: warning: objtool:=20
>> kvmppc_fill_pt_regs+0x38: intra_function_call not a direct call). The=20
>> below diff just removes the warnings for me, but I'm not very sure if=20
>> this is the best way to fix the objtool warnings seen with this=20
>> particular file. Please let me know if there are any better ways to fix =
it.
>>=20
>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>> index 0dce93ccaadf..b6a413824b98 100644
>> --- a/arch/powerpc/kvm/booke.c
>> +++ b/arch/powerpc/kvm/booke.c
>> @@ -917,7 +917,9 @@ static void kvmppc_fill_pt_regs(struct pt_regs *regs)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm("mr %0, 1" : "=3Dr"(r1));
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm("mflr %0" : "=3Dr"(lr));
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm("mfmsr %0" : "=3Dr"(msr)=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm(".pushsection .discard.intra_f=
unction_calls; .long 999f;=20
>> .popsection; 999:");
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm("bl 1f; 1: mflr %0" : "=
=3Dr"(ip));
>
> I don't think you can assume that there won't be anything in between two=
=20
> asm statements.

Yeah, compiler could interleave something theoretically.

> Even if that works, I don't think it is good to expand the macro here.=20=
=20
> That asm statement looks to be trying to grab the current nip. I don't=20
> know enough about that code, and someone who knows more about KVM may be=
=20
> able to help, but it looks like we should be able to simply set 'ip' to=20
> the address of kvmppc_fill_pt_regs()?

There is _THIS_IP_ which should be sufficient.

cheers
