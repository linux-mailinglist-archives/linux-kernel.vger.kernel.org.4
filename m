Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EC573CB6D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjFXOkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 10:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFXOkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 10:40:39 -0400
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE7A1BF8;
        Sat, 24 Jun 2023 07:40:36 -0700 (PDT)
Date:   Sat, 24 Jun 2023 14:40:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687617634; x=1687876834;
        bh=KXzwJWjam5pejAKUAARKT/aBF+7atZ+NTYFZhNmBVB4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dcxktkmHMQlLIVVJYFFDmjRWti0jFTyBQ6AtqFgM08bnP9bAzDe0c62LD/Q/cD3jf
         ZDnFxORwnn1jILORBCjEVNA/Cc/8Q5gzb1sOFNfQbFItY2WLQEFstZY6BpCDkQoQA3
         97BrSANDY2xiRcj95xb/nQ1TdnKJ12B5dVus0segjA9e7+jYabcY4W9dsVFqLIDGD8
         TiBnn/XBDJpxpZIMXMqlWLfMVIQYQONGlf4uliLsLOQIk4PFBKnvX/lOiUeFPPIBe5
         IS/Gdo/md2/x5x3UGSyC8CGAXFPLi2QHBxCtgfdOOrkz3LQChQ0EefXmA1gCTRnYUZ
         pEFufdnq7fQ8w==
To:     Boqun Feng <boqun.feng@gmail.com>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: alloc: Add realloc and alloc_zeroed to the GlobalAlloc impl
Message-ID: <R7bIOWHPBelVxutK-V8lFrSCh_diCIJtJxP-HbOJDV0i2VaKriARSwBRv8TaTevuT06lySKkBALLFJ8S_7q2Qzzr2fH4eceYXYO1_kp1jnI=@protonmail.com>
In-Reply-To: <ZJXXxEfzVza5Jzxj@boqun-archlinux>
References: <20230622-global_alloc_methods-v1-1-3d3561593e23@protonmail.com> <ZJXXxEfzVza5Jzxj@boqun-archlinux>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 23rd, 2023 at 19:35, Boqun Feng <boqun.feng@gmail.com> wrot=
e:

> On Thu, Jun 22, 2023 at 09:24:40PM +0200, Bj=C3=B6rn Roy Baron via B4 Rel=
ay wrote:
>=20
> > From: Bj=C3=B6rn Roy Baron bjorn3_gh@protonmail.com
> >=20
> > While there are default impls for these methods, using the respective C
> > api's is faster. Currently neither the existing nor these new
> > GlobalAlloc method implementations are actually called. Instead the
> > _rust* function defined below the GlobalAlloc impl are used. With
> > rustc 1.71 these functions will be gone and all allocation calls will g=
o
> > through the GlobalAlloc implementation.
> >=20
> > Link: https://github.com/Rust-for-Linux/linux/issues/68
>=20
>=20
> Nice! Although I think we need to do the simialr size adjustment as:
>=20
> =09https://lore.kernel.org/rust-for-linux/20230613164258.3831917-1-boqun.=
feng@gmail.com/
>=20
> so I applied your patch onto my patch and came up with the following:

Right. That patch LGTM.

Cheers,
Bj=C3=B6rn
