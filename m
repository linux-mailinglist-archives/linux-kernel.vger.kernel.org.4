Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF2A7341EC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjFQPd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjFQPd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:33:56 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C20173A;
        Sat, 17 Jun 2023 08:33:55 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b162127472so1673684a34.0;
        Sat, 17 Jun 2023 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687016035; x=1689608035;
        h=in-reply-to:references:message-id:to:from:subject:cc:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIrXu2yfb9Pam+bpdsMdAx2WWEzIapMDlsAs1QsbBws=;
        b=RBZwfxwyvUmlx7gfaQja0EIyLztHe3BBUZtCltHvzg1JOEml2iTtCdo/pr3V/Dnua9
         qGM2FmKPCVsX2/2Fjbs60I8YYyMvq7C5o4kKo+/q3YpC3GveuIiQeGTD/FMg6w+RKqFV
         0ebDTbFibZEMMgur9SAVFAvLlQ26gZaWVfFMPHY9BW8SA+G8spyrFul4hiZpMBAzVI65
         o1FXpATjrIN6T0ClfgpDB5AO4pZ8kZSoKTTvazBlFmmtG5JLQs02am/UbfWrr/jFgAt5
         kTGr2pRP76Z2JCS31DazLoSsJK+EpcNhxhSSSY4v5EssrtM6dvZx6LYGOIgGCYLwF1qE
         RAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687016035; x=1689608035;
        h=in-reply-to:references:message-id:to:from:subject:cc:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eIrXu2yfb9Pam+bpdsMdAx2WWEzIapMDlsAs1QsbBws=;
        b=NwFNtfcs0DjFU+KEYnVvaoL//pptuIVnnR3+rj8P626huU83wE5aoPlcI1a+kNfQ2P
         dasrgSrl9Em4xzsNH/Fe4rDK/WoZD2hvhmQ9R/QqI8qs4wdIiwKPZcY6DRjeffnPwIRI
         of3N/dKj5WvQHHSsseX9RdyDOJ+/38HY0gl+mbetccze2c9Mx8NGiOcCVAGHO8LXYcgA
         DAuab3BvdcNpOmqyOW26yzS13LojQT0GKQ3gyddBXGVGBxcifziNQz3uGergvMZsSgp3
         RCEi5iJ1pVBgxdGsjvb04U3U6yrDzcXzV+iTQRZ94bwvEALHqS9LggGkR6rfRDeab7n5
         /tSg==
X-Gm-Message-State: AC+VfDyZvHeFgL51EjkcyMaZ45QPZxzZOZMFRXaIsPDKspMJ1/EI7kxw
        cY6ND+2WOgjCAgNR1ruEN4I=
X-Google-Smtp-Source: ACHHUZ4cTukZlbOT2Rzej4qrlx/YeNZFj5PqAaaj504WWtITW+WCdZ/wmMf5sdoXCfsGaSEUg7HjFw==
X-Received: by 2002:a05:6830:43:b0:6ac:86bf:f621 with SMTP id d3-20020a056830004300b006ac86bff621mr2754731otp.7.1687016034741;
        Sat, 17 Jun 2023 08:33:54 -0700 (PDT)
Received: from localhost ([2600:1700:f3b0:64c0::35])
        by smtp.gmail.com with ESMTPSA id k1-20020a056830168100b006addf2a4110sm8614459otr.55.2023.06.17.08.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 08:33:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 17 Jun 2023 10:33:51 -0500
Cc:     "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Alice Ryhl" <aliceryhl@google.com>,
        "Andreas Hindborg" <nmi@metaspace.dk>,
        <linux-kbuild@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        "Jordan Isaacs" <mail@jdisaacs.com>,
        "Tiago Lam" <tiagolam@gmail.com>
Subject: Re: [PATCH v2 07/11] kbuild: rust_is_available: fix confusion when
 a version appears in the path
From:   "Ethan D. Twardy" <ethan.twardy@gmail.com>
To:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Alex Gaynor" <alex.gaynor@gmail.com>
Message-Id: <CTF19P8FLNUZ.3OA1ANA7IUG87@hackbook>
X-Mailer: aerc 9999
References: <20230616001631.463536-1-ojeda@kernel.org>
 <20230616001631.463536-8-ojeda@kernel.org>
In-Reply-To: <20230616001631.463536-8-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jun 15, 2023 at 7:16 PM CDT, Miguel Ojeda wrote:
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
>  bindgen_libclang_version=3D$( \
>  	echo "$bindgen_libclang_output" \
> -		| grep -F 'clang version ' \
> -		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
> -		| head -n 1 \
> +		| sed -nE 's:.*clang version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
>  )
>  bindgen_libclang_min_version=3D$($min_tool_version llvm)
>  bindgen_libclang_cversion=3D$(get_canonical_version $bindgen_libclang_ve=
rsion)

Reviewed-By: Ethan Twardy <ethan.twardy@gmail.com>
Tested-By: Ethan Twardy <ethan.twardy@gmail.com>
