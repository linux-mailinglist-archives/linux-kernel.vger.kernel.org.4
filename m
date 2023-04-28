Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BD56F127A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbjD1Hhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345542AbjD1HhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:37:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88BC30D2;
        Fri, 28 Apr 2023 00:37:06 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682667425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9WgFT6n38IbKIlQOmRg7Aj71yFL8oXTEMGMk9PC1UU=;
        b=4cSn329b8crefnSTA47d1YI2emkxVXGgguXlqtN2Wp8x7S3EABWu4LPYFv2FEPTDSsjyHD
        WTy0bAEotQqU5tSC5Yw06aKQ7l3Ro954/ZW65469u6ZVnTEjirukDvNVsPAaXvRQoNElGf
        4OtiAsL+w0qYioL1IMZ9WoLPoO/QfXG/BvIdvCHIurH27LAl4HrpLIrfkr5icm7Uo/9hYJ
        uyKhw23ef9gNCNy3Kwtn4SbJ8Eue6eT3jYW2/vWc4nrBXvZG93FIa0IghYP+v5YbyGY+/n
        vFRXlNO0NvulCqVw53OLVxXW8OIwziwfom4zFMlTrubMKeufkL2piiHlXZjfMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682667425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9WgFT6n38IbKIlQOmRg7Aj71yFL8oXTEMGMk9PC1UU=;
        b=0NVjNxMxzO/mkLIYy1+la/dShvTTc27qDJDa4p65qQm2vG+r0BixN76776jRsYB/0q1n5R
        /TENqNceTv5iILAQ==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bouska, Zdenek" <zdenek.bouska@siemens.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
In-Reply-To: <20230428073016.YfrIGGoN@linutronix.de>
References: <AS1PR10MB567534190B05A4493674173BEB659@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <87pm7qxrg6.ffs@tglx> <19641ab0-ab6a-9af7-8c64-34030e187848@siemens.com>
 <871qk5782i.fsf@kurt> <20230428073016.YfrIGGoN@linutronix.de>
Date:   Fri, 28 Apr 2023 09:37:03 +0200
Message-ID: <87wn1wv4o0.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri Apr 28 2023, Sebastian Andrzej Siewior wrote:
> On 2023-04-27 15:45:09 [+0200], Kurt Kanzenbach wrote:
>> > Are we aware of other concrete case where it bites? Even with just
>> > "normal" contented spin_lock usage?
>>=20
>> Well, some years ago I've observed a similar problem with ARM64
>> spinlocks, cpu_relax() and retry loops (in the futex code). It also
>> generated latency spikes up to 2-3ms. Back then, it was easily
>> reproducible using stress-ng --ptrace 4.
>
> That was fixed by
> 	https://patchwork.kernel.org/project/linux-arm-kernel/patch/1399528508-2=
806-1-git-send-email-arjun.kv@samsung.com
>
> if my memory serves me well.

We've had a different processor, but yes, we configured CPUACTLR_EL1[31]
to 1 in U-Boot to avoid any kernel modifications. Maybe it helps here
too?

Thanks,
Kurt

[1] - https://developer.arm.com/documentation/100095/0003/way1382037666700

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmRLd58THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzghlXD/9HotVNhvqmh29BsoK7Zt1eNEca4+Tq
PNmh6Z/fPe9JXwJEiGem1AChnVN7gCao2L+C5nk7ebRqMGyfeHbHqnRz5Fa39efr
OqZcnmhMMQXLWDt5uu/5t7pdqoOfk1IxHS+FtV7G6IxRuxg/Dp/0t08g0vGJ+PmB
I/NvybCd3A4SiUWHuykMyGRl8T/xdqCCtbA8zJae+nfDDo+2lTzGBdZ6u6muB3E8
rWFPXyGH2aULr0Kg3YZvnwVAH8220dRP5LDMxRaxpbmsJcLHvXeJVdAw4A1Mlz0K
6Wl0JUn6SLwQOS26sjEhpVobiKs6g21Dbau0+edD277rIu0VbT6lPi59QwuPQXyI
X6pbw+rOe29Gm6fbIuqRzjzzw87AOXw/I0sVc6JvqdT0jWw+YR74IJjD0wsT5/I7
7cn0dMrDcnH5clLWiHZtvbsyjgRmzxYNOrQIuhg86fM3T6N7AY0RXgUk+1WpWjYY
h7CG63oQ+RxONCrlpuZyDQSZsdVT7dRbC8Dbr1Avl/zrecrT7AjX4brxNnsSVyVb
5Jr+J1x+QNu4uBkZCoFQ6rZmI+nOsvOXt5M55+sfAuAZx3OZ79CsNlD8GdfHCC3d
PGezbfQQzNqgNv/QvFnBSCnQ1tC1exWIrgaJKwsNO80vX/Fya8wjWqUZWchw8skb
XakiSUjjvjgN/A==
=1+7y
-----END PGP SIGNATURE-----
--=-=-=--
