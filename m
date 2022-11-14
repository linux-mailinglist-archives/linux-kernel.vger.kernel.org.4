Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443286282DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbiKNOkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbiKNOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:39:43 -0500
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8872B1AC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:39:35 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:39:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668436773; x=1668695973;
        bh=3kJuGS5uVSVzPLoxWGsOQFBiLJ7HrhLDmqmpBDrS0NA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=fJTfY+Pn+ZqZee+nMnAaJCbwPHTnfoPKAv/qf7IIWScErzoVWFnp2pfEWWeIFYhHd
         ///1e33rt6sdUzzuUe9+FtQ2p9DcwSKdhrUMH0FM9GMCj2FyjgJAp1RBwMIMM5lLLd
         9Z2mTknOdkKuJ48KpYoZXOUu1/xeqRMTXofjDXyQr3NKCJdWslgHUqF6o0wemlOuCC
         4r/B5htHpS8e3qV84LYyr1rgRYnE9kDI+LwfV/rEm6nbpLBVPCVrAfduasdn6Aw3h3
         +eDyPYWqDP53CMbqT2lf/u9usEzh3NIpuemJWp1X5En+NX3QApYb/0WIhvnpjDoQv6
         tZwLblJRB2kDA==
To:     Gary Guo <gary@garyguo.net>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 05/28] rust: macros: add `concat_idents!` proc macro
Message-ID: <_CF9aCGri4-OVipaa-ZySoRbBu17nlThYL3fGiHugcWQNAjgtE-ZBcekhmg_pM6uNGWsSuqoke-pGPgB7ZlGCI1Iyo_bl4RhtzfbdI0Z18g=@protonmail.com>
In-Reply-To: <20221114142611.2a21d4e9@GaryWorkstation>
References: <20221110164152.26136-1-ojeda@kernel.org> <20221110164152.26136-6-ojeda@kernel.org> <20221114142611.2a21d4e9@GaryWorkstation>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 14th, 2022 at 15:26, Gary Guo <gary@garyguo.net> wrote:


> On Thu, 10 Nov 2022 17:41:17 +0100
> Miguel Ojeda ojeda@kernel.org wrote:
>=20
> > +pub(crate) fn concat_idents(ts: TokenStream) -> TokenStream {
> > + let mut it =3D ts.into_iter();
> > + let a =3D expect_ident(&mut it);
> > + assert_eq!(expect_punct(&mut it), ',');
> > + let b =3D expect_ident(&mut it);
> > + assert!(it.next().is_none(), "only two idents can be concatenated");
> > + let res =3D Ident::new(&(a.to_string() + &b.to_string()), b.span());
>=20
>=20
> Probably clearer to write `Ident::new(&format!("{a}{b}"), b.span())`
> here?
>=20
> Best,
> Gary

I agree that is clearer. I hadn't considered that Ident implements Display =
when I wrote it.

Cheers,
Bj=C3=B6rn
