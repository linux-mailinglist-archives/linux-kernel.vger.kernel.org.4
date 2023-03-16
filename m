Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418C16BCAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCPJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCPJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:34:34 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C2C6EA9;
        Thu, 16 Mar 2023 02:34:13 -0700 (PDT)
Date:   Thu, 16 Mar 2023 09:33:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1678959248; x=1679218448;
        bh=ySIfXFt6Xi6R7YaroHVL2o7033EHtToARDDqQVRsMyQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=f/Jy8j02JZSc3nrQHu0gMVGP50bKj7qWX4p9h0keACRF+b/nzKFFG5Xc02OaZK4sa
         ZQ/5cX7hBWB48YyrEZJjIvIOIRkqGexRDzdRwRdtZ2UDRcCvQpso11yFX815A8Fs80
         eJGc3bKGZm+XwIErvHOg+3ieANnU1hVnJCUYPwvbb6lIzGF+Nqwgf8meG49fydhSO/
         CWGCYxYy9DVS3z+VT0wxhm4sP3YEqA81hbtKiFSp6b6J+agibtsGMcvPavtCWBSdo5
         otNY4QQK9OayXfLaeQv2MJ7aOF0BwPh1pYqzJfIQjnixvyRzPQ1RhVTNrkAfmh+VKZ
         ROUsjF4hLS8ZA==
To:     Boqun Feng <boqun.feng@gmail.com>
From:   y86-dev <y86-dev@protonmail.com>
Cc:     "ojeda@kernel.org" <ojeda@kernel.org>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "wedsonaf@gmail.com" <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v1 1/3] rust: macros: add `quote!` macro
Message-ID: <rwLWkKoa4chEtf0rqg_7vYX5cTjKz4etynZ-i5wG_JCvF_O-6vf2I2cc205cZHFId2DJswFm_5FjpN5-8SYuF-FEdkCxMTPh_R9UCEB5fJA=@protonmail.com>
In-Reply-To: <ZA9BfSEjAQ9xnZD7@Boquns-Mac-mini.local>
References: <u9FrnEbtGtyUPp-CmzAQIv--8hmKwHdIIPiq-3IHJPcHdaJi_VXuDdVR2Js2GzvtWgCNrBLp4PhQs3tTlWNVDBZfIStCHiS9SoMtsDgc4oM=@protonmail.com> <ZA9BfSEjAQ9xnZD7@Boquns-Mac-mini.local>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 13th, 2023 at 16:30, Boqun Feng <boqun.feng@gmail.com> wro=
te:
> On Mon, Mar 13, 2023 at 01:23:18AM +0000, y86-dev wrote:
>
> > From: Gary Guo gary@garyguo.net
> >
> > Add the `quote!` macro for creating `TokenStream`s directly via the
> > given Rust tokens. It also supports repetitions using iterators.
> >
> > It will be used by the pin-init API proc-macros to generate code.
> >
> > Signed-off-by: Gary Guo gary@garyguo.net
> > Signed-off-by: Benno Lossin y86-dev@protonmail.com
>
>
> Not sure whether I missed any sutble details, but the macros look
> straight-forward. One thing could be improved is having a doc describing
> what `quote!` does, a link to the quote crate will do the trick.
>
> Anyway, the code looks good to me.
>
> Acked-by: Boqun Feng boqun.feng@gmail.com
>
>
> Regards,
> Boqun

Sure, will put it in v2!

Regards,
Benno
