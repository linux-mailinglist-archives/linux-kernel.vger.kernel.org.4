Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C6F6F06D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbjD0NpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242993AbjD0NpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:45:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5033C0B;
        Thu, 27 Apr 2023 06:45:13 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682603111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/9VwzYujGkLmgAKT34TJhMb4kA3dkHKyhpPXWfaEMk=;
        b=Rdc8cSZ1Z9Gm6lo8OpkEQNVS7sbW2i4fFU7/rawBjfBgqGOb1PZlrJgXQy6dtmY0lJQrxx
        0m1I4Pkeg5JWVtBOYUVEbBE/udGNMOllL0k79zhv3XFlQlmH2mnQOURddOoj5EJpi2TCKM
        YyYwL8mth4oY0ztfZ14Im4nx4Y5mMS6UjR1KqdLhby7Mymh4mB/20dLmUaz6CMPAvvUTkq
        w4EZae8hnp5PKYM5fVITntTz+wSQmaUer09nizl6IW9xLhM8va3Dw6IhPK2mI3TK9FwfYT
        BRXLg6yl6t2DcGkbxPCn0AccHkDhKg1B2fQOEjfN3sLLmt0wnw1WjbzNNt5fcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682603111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/9VwzYujGkLmgAKT34TJhMb4kA3dkHKyhpPXWfaEMk=;
        b=C4EGNJlSWCzjxxRFjrxKs+UC2lwlwm3z7d0lsX1U4ZNRmBusnVaENfBppKn/B254qb4wef
        0Ffza/i61x0YPjDA==
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bouska, Zdenek" <zdenek.bouska@siemens.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
In-Reply-To: <19641ab0-ab6a-9af7-8c64-34030e187848@siemens.com>
References: <AS1PR10MB567534190B05A4493674173BEB659@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <87pm7qxrg6.ffs@tglx> <19641ab0-ab6a-9af7-8c64-34030e187848@siemens.com>
Date:   Thu, 27 Apr 2023 15:45:09 +0200
Message-ID: <871qk5782i.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu Apr 27 2023, Jan Kiszka wrote:
> On 26.04.23 23:29, Thomas Gleixner wrote:
>> On Wed, Apr 26 2023 at 12:03, Zdenek Bouska wrote:
>>> following patch is my current approach for fixing this issue. I introdu=
ced
>>> big_cpu_relax(), which uses Will's implementation [1] on ARM64 without
>>> LSE atomics and original cpu_relax() on any other CPU.
>>=20
>> Why is this interrupt handling specific? Just because it's the place
>> where you observed it?
>>=20
>> That's a general issue for any code which uses atomics for forward
>> progress. LL/SC simply does not guarantee that.
>>=20
>> So if that helps, then this needs to be addressed globaly and not with
>> some crude hack in the interrupt handling code.
>
> My impression is that the retry loop of irq_finalize_oneshot is
> particularly susceptible to that issue due to the high acquire/relax
> pressure and inter-dependency between holder and waiter it generates -
> which does not mean it cannot occur in other places.
>
> Are we aware of other concrete case where it bites? Even with just
> "normal" contented spin_lock usage?

Well, some years ago I've observed a similar problem with ARM64
spinlocks, cpu_relax() and retry loops (in the futex code). It also
generated latency spikes up to 2-3ms. Back then, it was easily
reproducible using stress-ng --ptrace 4.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmRKfGUTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzggoHEACMsWklttHdQxg1mAdw4DJQahKd0oB/
36cdl4TJeJ9BRcROss1tiaHyLzYsbYPbjdaG7CRI2AKAHMfI7+Fd55b2lOq59gM7
rUGNkTcGub7z6wvkMS8JrxJKeq1EAFZkOVwouOO+XNlvKLV7sj+2/tkL5iN5hwoh
9tOjCODa/MaQIy/+CmGVAj34yQok8P3x5mm54e4S8JZ/VtQzaoL1KiOUxzXNnj5m
g+zCF2nRQGpkTmXKcNT2uW1pbJ3XJLMU5JXzKrjS/rPoqznTzGyVrYUF/EeDjMOM
MEjcQeskgUT9G5I4J4CTH+eZ9XtjcnkebMgTuPGO+FppByycxEuSeff3x0JE0tKL
YEuVJdvCfuL9vQ+Gbjxmf8gYXpTqZXBR/69D95yu1yCtbPk8i3rqUYT9AEKceMvD
yEyJexbRSMcpJGuxBaQfhsfrTUALylgSft8uL0wM/ACRNZbNMay+2m3Ml39w7F1i
/34V8vnvpPuImcUBqW7wA+Nr5w8I8qW3mlJE06FyKu9b5QsNIo+euHUOkMM2flIO
WtM1q+rXyn23ZWYNM18Flc3nAMrvqbHca+lR23jsm0ArNISnkUOdZwZDtW9zkZWX
RYvvJa2bH+WJ+gfRwfx+kSPga33P9UMKcg191JONEWuJIN7d3DfPmPc0xgELijyE
eg2SNQ5F5MZlxQ==
=77G/
-----END PGP SIGNATURE-----
--=-=-=--
