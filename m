Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392366E79C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjDSMbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjDSMbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:31:08 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8705CE50
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:31:06 -0700 (PDT)
Date:   Wed, 19 Apr 2023 12:30:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1681907464; x=1682166664;
        bh=LbKgikniMFbDyFN2g7zWAoErWCoMlEFPq1fVjDbUYh8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=W+vrUebuJp1hiaq5J6Yn0guavbN34v+IU5fOapkRumgszhzjBMXFFFHcpMEbT0G4C
         ZXKilDurS+3o5ptA5jQS/Mt0ddLeJJBmW66gZWd/IhQLVTt/XKOrWBEDEdp25Tzi+O
         d9L3k23CouM0jZ6YjIHmogFZOgMjFN2oIEiAgM+FYH5osEj8L3xQ19wsYl9Vzp96KQ
         kih/4GNsISO83sMmwiCenYVPMcDdca1S3NCmDJGv+ATJSXKPCGJzPOyNNtSM8BPwi6
         HtNPG/fSeY2uDPVpPbRM2d1B73iFMPTDYxCGPwS8TiyMojBNzdU1dYChuOMz6y7F6j
         pZtB11+AvOD4Q==
To:     Miguel Ojeda <ojeda@kernel.org>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jean Delvare <jdelvare@suse.de>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] .gitattributes: set diff driver for Rust source code files
Message-ID: <n1uzeazgD17rPkhbZbkXpMaba7JXVdm5YIzUzi18_8UKwUYtXOPgBBJePJ0VMMc4X8pEoLtA4ypsco4CQ1WPC_PIoPmQB9m1S3cAQOC5p_M=@proton.me>
In-Reply-To: <20230418233048.335281-1-ojeda@kernel.org>
References: <20230418233048.335281-1-ojeda@kernel.org>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.23 01:30, Miguel Ojeda wrote:
> Git supports a builtin Rust diff driver [1] since v2.23.0 (2019).
>=20
> It improves the choice of hunk headers in some cases, such as
> diffs within methods, since those are indented in Rust within
> an `impl` block, and therefore the default diff driver would
> pick the outer `impl` block instead (rather than the method
> where the changed code is).
>=20
> For instance, with the default diff driver:
>=20
>      @@ -455,6 +455,8 @@ impl fmt::Write for RawFormatter {
>               // Amount that we can copy. `saturating_sub` ensures we get=
 0 if `pos` goes past `end`.
>               let len_to_copy =3D core::cmp::min(pos_new, self.end).satur=
ating_sub(self.pos);
>=20
>      +        test_diff_driver();
>      +
>               if len_to_copy > 0 {
>                   // SAFETY: If `len_to_copy` is non-zero, then we know `=
pos` has not gone past `end`
>                   // yet, so it is valid for write per the type invariant=
s.
>=20
> With the Rust diff driver:
>=20
>      @@ -455,6 +455,8 @@ fn write_str(&mut self, s: &str) -> fmt::Result =
{
>               // Amount that we can copy. `saturating_sub` ensures we get=
 0 if `pos` goes past `end`.
>               let len_to_copy =3D core::cmp::min(pos_new, self.end).satur=
ating_sub(self.pos);
>=20
>      +        test_diff_driver();
>      +
>               if len_to_copy > 0 {
>                   // SAFETY: If `len_to_copy` is non-zero, then we know `=
pos` has not gone past `end`
>                   // yet, so it is valid for write per the type invariant=
s.
>=20
> Thus set the `rust` diff driver for `*.rs` source files.
>=20
> Link: https://git-scm.com/docs/gitattributes#_defining_a_custom_hunk_head=
er [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   .gitattributes | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/.gitattributes b/.gitattributes
> index c9ba5bfc4036..2325c529e185 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -2,3 +2,4 @@
>   *.[ch] diff=3Dcpp
>   *.dts diff=3Ddts
>   *.dts[io] diff=3Ddts
> +*.rs diff=3Drust
>=20
> base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
> --
> 2.40.0
> 
