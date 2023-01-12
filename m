Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955F6667DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbjALSTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbjALSSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:18:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41FFDAE;
        Thu, 12 Jan 2023 09:49:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F0F662099;
        Thu, 12 Jan 2023 17:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477C1C433EF;
        Thu, 12 Jan 2023 17:49:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="H4O9hc5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1673545787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7DMh06CMcFgJjStpStxXavfvThQkXamahLt/MITO4I=;
        b=H4O9hc5OvySji42+gvOMAbWZESvbt+Vllxz/9xWfnRC46BhUorqgcDEKJV2gWWYuuXVbTL
        /nV/1oRzeaugbj+6jWFyt+ncc3ay+9O1+MpydkWVqjwkNjkzjSrgs298kcBtGUqqk0ZZSV
        NQRfBs8l2tBGOKeR0+Pr6yywPPaK0iE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0fbd866a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 12 Jan 2023 17:49:47 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-4d4303c9de6so100050977b3.2;
        Thu, 12 Jan 2023 09:49:45 -0800 (PST)
X-Gm-Message-State: AFqh2krFGOwvM8sYPitTZejs4XqYMGBNpgQ+k3a1Pf9I7/mYrpUeLtSr
        pySsAZs6MWX8sKkRN+02MbWxMhKakxZE7cpNS8M=
X-Google-Smtp-Source: AMrXdXv3v3wwoofXvAn0i52oE2wu2AesOkpt83M/5nj367cjSEvCBYHr8Y4YqbcwKFmIgh2cUc6UeGILBC523DmLEIM=
X-Received: by 2002:a0d:d552:0:b0:368:e6b8:77f1 with SMTP id
 x79-20020a0dd552000000b00368e6b877f1mr2520323ywd.414.1673545784796; Thu, 12
 Jan 2023 09:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-8-Jason@zx2c4.com>
 <2bee307f-182f-c556-d136-8451b490d74e@csgroup.eu>
In-Reply-To: <2bee307f-182f-c556-d136-8451b490d74e@csgroup.eu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 12 Jan 2023 18:49:34 +0100
X-Gmail-Original-Message-ID: <CAHmME9oGY88EXimqj6E6k1FuprMLTmxbzZ3THA7k7iWKyexgUA@mail.gmail.com>
Message-ID: <CAHmME9oGY88EXimqj6E6k1FuprMLTmxbzZ3THA7k7iWKyexgUA@mail.gmail.com>
Subject: Re: [PATCH v14 7/7] x86: vdso: Wire up getrandom() vDSO implementation
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thanks for the review.

On Thu, Jan 12, 2023 at 6:27 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 01/01/2023 =C3=A0 17:29, Jason A. Donenfeld a =C3=A9crit :
> > Hook up the generic vDSO implementation to the x86 vDSO data page. Sinc=
e
> > the existing vDSO infrastructure is heavily based on the timekeeping
> > functionality, which works over arrays of bases, a new macro is
> > introduced for vvars that are not arrays.
> >
> > The vDSO function requires a ChaCha20 implementation that does not writ=
e
> > to the stack, yet can still do an entire ChaCha20 permutation, so
> > provide this using SSE2, since this is userland code that must work on
> > all x86-64 processors. There's a simple test for this code as well.
>
> As far as I understand the test is not dependent on the architecture,
> can it be a separate patch ?

The test is dependent on architectures for which there's a vDSO
implementation. I could move it to a patch before or after this one,
though, if you think it'd be better to keep this commit as a template
commit for other architectures.

> Also, as the chacha implementation is standalone and can be tested by
> the above mentionned simple test, can it be a separate patch as well ?

No, that actually needs to be part of this one, as it's part and
parcel of the x86 implementation.

> Then the last patch only has the glue to wire-up getrandom VDSO to the
> architecture, and can be used as a reference for other architectures.

This is part of the required glue, so no, it belongs in this one.
> > + *   rdx: 8-byte counter input/output
>
> Why a 8-byte counter ? According to RFC 7539, chacha20 takes:
> Are you mixing up the upper part of the counter with the nonce ? In that
> case you can't say you use a 0 nonce, can you ?

No, I'm not mixing anything up. This is the same algorithm that
random.c uses. And wireguard, for that matter. 8 byte nonce, 8 byte
block counter. In this case, the nonce is 0.

> > +#include <sodium/crypto_stream_chacha20.h>
>
> Is that standard ? Every distribution has sodium ?

As far as I can tell, yes.

Jason
