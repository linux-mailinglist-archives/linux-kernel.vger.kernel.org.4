Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA6C637694
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKXKhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXKhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:37:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D59FFA9A;
        Thu, 24 Nov 2022 02:37:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NHvZF2rbqz4xGK;
        Thu, 24 Nov 2022 21:37:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1669286230;
        bh=qw+Z/V+WEes04qNv/mzj8igXJLhyM6g0KYA314bdhzs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WTQM3TmvCQjU8d1/xLc6gcRqiJ82JqVe8B0saYWpj+F2ImP+TrxQknHUto7rgp/9A
         DKVXcKEsYhxN/RKsQqzpKcRPu4FmJ5eN4D84ltSBeQ3JCoNcxc27/Z0rghjisSq52Y
         VcW7n+6rAi5pyFqupaSQ4YSjARQAXDJDAvCDngWERMunE0odEKMZiDSO7Zqdpy3UUx
         Fgr/Blk+ViSvMHXUBjz3md6spYizJ+4aJMdIyed79zn2H57k+w7EeFfgKOWiT8pZKs
         Sk4kiJU9FzD4r60dLhTY7/9qA1OFyscvJJH3/Ols9/t+opFXTGYHhOkB6iaq9TLwo+
         Hodp0cB3S3O/A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the
 powerpc-objtool tree
In-Reply-To: <de806b36-2b5c-3040-22c2-129bc9b5ddd4@csgroup.eu>
References: <20221124122931.266df8c7@canb.auug.org.au>
 <de806b36-2b5c-3040-22c2-129bc9b5ddd4@csgroup.eu>
Date:   Thu, 24 Nov 2022 21:37:06 +1100
Message-ID: <878rk0d4fh.fsf@mpe.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 24/11/2022 =C3=A0 02:29, Stephen Rothwell a =C3=A9crit=C2=A0:
>> Hi all,
>>=20
>> Today's linux-next merge of the tip tree got a conflict in:
>>=20
>>    tools/objtool/check.c
>>=20
>> between commit:
>>=20
>>    efb11fdb3e1a ("objtool: Fix SEGFAULT")
>>=20
>> from the powerpc-objtool tree and commit:
>>=20
>>    dbcdbdfdf137 ("objtool: Rework instruction -> symbol mapping")
>>=20
>> from the tip tree.
>>=20
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>=20
>
> Maybe it would be better to perform the check of insn inside the new=20
> insn_func() then ?

I don't think it would.

Many of the other uses of insn_func() know that insn is not NULL,
because they've already checked it or have dereferenced some other
member of insn before the call. So in those cases checking it in
insn_func() would be redundant.

But ultimately up to the objtool maintainers.

cheers
