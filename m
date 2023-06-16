Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54D373373F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346113AbjFPROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346039AbjFPRN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F847E76;
        Fri, 16 Jun 2023 10:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B93637BC;
        Fri, 16 Jun 2023 17:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B792C433C8;
        Fri, 16 Jun 2023 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686935636;
        bh=Pesfpugu1m5Zpka38aqim0Y2Y1lOWubaTxEXngDwuKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UxbK+SBdj+FhLENdi7KPoFsRtLaW0h7dfdIHdjLii45JWfXmnZIyWMNN6NZlBjTkw
         rJV46Vqc9PMVmFBnO2G0Fyfw/epdQOlp2FZfRgXuhYWTVopO1XgUH/h1DKfWO+uTzj
         nievbKIqhuIvX9J9LNFrBv8APprwPh938rPnzvK4/qsnr1jMuEDdFT1Yc53EL/eAKR
         bQWD3Bj+XNaN9usSkMm/3m/POzwPdSsQItLz18LH1tRrv+q1dlL0Vw1prMCJq6lJ+R
         faK1IwQsFHlgYb9/aQnor0Ll5EM3O8eXKsJeqLo773Lyg/mjSVJqBNte3kaRVvngYN
         p5ewAMwIkescQ==
Date:   Fri, 16 Jun 2023 10:13:53 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Jordan Isaacs <mail@jdisaacs.com>,
        "Ethan D . Twardy" <ethan.twardy@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>
Subject: Re: [PATCH v2 07/11] kbuild: rust_is_available: fix confusion when a
 version appears in the path
Message-ID: <20230616171353.GF3474164@dev-arch.thelio-3990X>
References: <20230616001631.463536-1-ojeda@kernel.org>
 <20230616001631.463536-8-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616001631.463536-8-ojeda@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 02:16:27AM +0200, Miguel Ojeda wrote:
> `bindgen`'s output for `libclang`'s version check contains paths, which
> in turn may contain strings that look like version numbers [1][2]:
> 
>     .../6.1.0-dev/.../rust_is_available_bindgen_libclang.h:2:9: warning: clang version 11.1.0  [-W#pragma-messages], err: false
> 
> which the script will pick up as the version instead of the latter.
> 
> It is also the case that versions may appear after the actual version
> (e.g. distribution's version text), which was the reason behind `head` [3]:
> 
>     .../rust-is-available-bindgen-libclang.h:2:9: warning: clang version 13.0.0 (Fedora 13.0.0-3.fc35) [-W#pragma-messages], err: false
> 
> Thus instead ask for a match after the `clang version` string.
> 
> Reported-by: Jordan Isaacs <mail@jdisaacs.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/942 [1]
> Reported-by: Ethan D. Twardy <ethan.twardy@gmail.com>
> Closes: https://lore.kernel.org/rust-for-linux/20230528131802.6390-2-ethan.twardy@gmail.com/ [2]
> Reported-by: Tiago Lam <tiagolam@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/pull/789 [3]
> Fixes: 78521f3399ab ("scripts: add `rust_is_available.sh`")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/rust_is_available.sh | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> index 7e0368babe64..810691af66eb 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -157,9 +157,7 @@ fi
>  # of the `libclang` found by the Rust bindings generator is suitable.
>  bindgen_libclang_version=$( \
>  	echo "$bindgen_libclang_output" \
> -		| grep -F 'clang version ' \
> -		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
> -		| head -n 1 \
> +		| sed -nE 's:.*clang version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
>  )
>  bindgen_libclang_min_version=$($min_tool_version llvm)
>  bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)
> -- 
> 2.41.0
> 
