Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA86C977F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 20:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjCZSnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 14:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCZSnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 14:43:12 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12296A42
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 11:42:53 -0700 (PDT)
Date:   Sun, 26 Mar 2023 13:42:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1679856171; bh=IPj/8OLqvqRQ+lEtwXmv1w2gCjxoYulj0dH4FXY72C0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nCXrPh3csxykwCAPxhzyCeeSU2sHquZJzj+dL1PSmFpJmRRPYvOVWvHksk97CayOt
         iUdUDdcbqzQ/caCrKIhkXnEayC3mlKYke9sUQidxEwkXwKiZRFK1tgYeb0IN0qkyiD
         9zNSIdELThEQdnm/J3z8PLu+7XXzAk+/ZITsTkYk=
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Message-ID: <8e156377-e7d9-48ec-a7ee-292aba002201@t-8ch.de>
In-Reply-To: <89a960c7-0c9b-43ab-9fc8-a68405f7ed6a@p183>
References: <89a960c7-0c9b-43ab-9fc8-a68405f7ed6a@p183>
Subject: Re: [PATCH 6/8] tools/nolibc: tests: add test for -fstack-protector
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <8e156377-e7d9-48ec-a7ee-292aba002201@t-8ch.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mar 26, 2023 13:30:21 Alexey Dobriyan <adobriyan@gmail.com>:

> Willy Tarreau wrote:
>> #if defined(__clang__)
>> __attribute__((optnone))
>> #elif defined(__GNUC__)
>> __attribute__((optimize("O0")))
>> #endif
>> static int smash_stack(void)
>> {
>> =C2=A0=C2=A0=C2=A0 char buf[100];
>>
>> =C2=A0=C2=A0=C2=A0 for (size_t i =3D 0; i < 200; i++)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf[i] =3D 'P';
>>
>> =C2=A0=C2=A0=C2=A0 return 1;
>> }
>
> If you want to corrupt the stack, corrupt the stack!

I do!

> asm(
> ".globl f\n"
> "f:\n"
> "movq $0, (%rsp)\n"
> "ret\n"
> ".type f,@function\n"
> ".size f,.-f"
> );
> > No problems with optimisation levels.

Wouldn't this be architecture-specific?
