Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33301729ACD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbjFIM4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241266AbjFIM4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:56:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0892E2D74
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:56:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qd1KQ2t5Qz4x3x;
        Fri,  9 Jun 2023 22:55:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1686315355;
        bh=6hU42edEeCSuu+D9dpO9GvNrSsgyCJqWaGuZfm40wB0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EwB3F//8pFCLNpmDUVeIo8piNUnx0Gt2G0w+0UXSMJrP1U57KHSECjtlTuFqAYtZc
         L+mvTbBkg/fnsaZ34YaMSb09wNzpJfePZNiPn518SIurg50xsYo5FIesgQldwcalbo
         0javXPbZ1zQjFhXDiPPtmTttttkc3QYUc8dhiGvBO71eaQcOr4UUgB3MD891tkir1Z
         xWzMVc/ot7HOLiZ0VIkY9jiO92sW7gQk/WZTIrHIwnHgvYrtHAw5ZwZyPyLoB28Ig6
         ZKaHSoEHZaLDlAKDJA/gEfmY7sPUuranAuGb+v8HPgmOy/vAcB5oZJONcLz0LdoMMW
         tuBc+47MFsM6g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Rohan McLure <rmclure@linux.ibm.com>
Subject: Re: [PATCH 1/3] kcsan: Don't expect 64 bits atomic builtins from 32
 bits architectures
In-Reply-To: <662d074e-58cf-3bde-f454-e58d04803f34@csgroup.eu>
References: <cover.1683892665.git.christophe.leroy@csgroup.eu>
 <d9c6afc28d0855240171a4e0ad9ffcdb9d07fceb.1683892665.git.christophe.leroy@csgroup.eu>
 <CANpmjNMm-2Tdhp6rDzA7CYvotmmGmLUnZnA_35yLUvxHB=7s0g@mail.gmail.com>
 <662d074e-58cf-3bde-f454-e58d04803f34@csgroup.eu>
Date:   Fri, 09 Jun 2023 22:55:49 +1000
Message-ID: <877cschk16.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 12/05/2023 =C3=A0 18:09, Marco Elver a =C3=A9crit=C2=A0:
>> On Fri, 12 May 2023 at 17:31, Christophe Leroy
>> <christophe.leroy@csgroup.eu> wrote:
>>>
>>> Activating KCSAN on a 32 bits architecture leads to the following
>>> link-time failure:
>>>
>>>      LD      .tmp_vmlinux.kallsyms1
>>>    powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic6=
4_load':
>>>    kernel/kcsan/core.c:1273: undefined reference to `__atomic_load_8'
>>>    powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic6=
4_store':
>>>    kernel/kcsan/core.c:1273: undefined reference to `__atomic_store_8'
...
>>>
>>> 32 bits architectures don't have 64 bits atomic builtins. Only
>>> include DEFINE_TSAN_ATOMIC_OPS(64) on 64 bits architectures.
>>>
>>> Fixes: 0f8ad5f2e934 ("kcsan: Add support for atomic builtins")
>>> Suggested-by: Marco Elver <elver@google.com>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>=20
>> Reviewed-by: Marco Elver <elver@google.com>
>>=20
>> Do you have your own tree to take this through with the other patches?
>
> I don't have my own tree but I guess that it can be taken by Michael for=
=20
> 6.5 via powerpc tree with acks from you and Max.
>
> Michael is that ok for you ?

Yeah I can take it.

cheers
