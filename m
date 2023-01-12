Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEAB666AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 06:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbjALFcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 00:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjALFco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 00:32:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F3B1B9F9;
        Wed, 11 Jan 2023 21:32:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A972261F69;
        Thu, 12 Jan 2023 05:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9F9C43392;
        Thu, 12 Jan 2023 05:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673501562;
        bh=qCsLq3Gwfs2hFBNeQ4DQLdXWHTbkhZv7LAbRhhLeMbo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nX+zL4aM18oi3+MFVqnmFJLrPk5GuX57Fz+7L+/q2rotOT0Jt2+0K8V9DEdKljjAH
         /ZqVrLaJANiko11hSmwWSdEbPH8nTe9uCPdDvwb8+nr3yC9fMq+t7CeXefzuO3ZDlw
         loE8cdycXnhOSXBcve5BTuwKRRo94qNGOGSCxKkgS915zBssWNy8K5RPL8kUtMp7ZI
         fAKImse67IcjMnhhVRnNcEUrHqNUm4x/LHVE++F5ZwGKumuTcHlJl+EvnLGrfJcnlp
         7kiVOVkhX/Ed8zMfnh1uWnERaCdx/BXe4RTzAR9she1piVKHES4ADw6RIpRevy7YhQ
         3QeZ4FgthPTgQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-142b72a728fso17820963fac.9;
        Wed, 11 Jan 2023 21:32:42 -0800 (PST)
X-Gm-Message-State: AFqh2kpGm2H6GqKcRN28hc0EQJ8ICxqZeohpLruPzMNgVj887gtLPLGm
        kSlYKkhoJOwBuH3G0ksBdLlLog8AcM3Zfcz7vzE=
X-Google-Smtp-Source: AMrXdXvMYsQlRfQmsM5yLj5gL55H1a42aLVk7psPfzHi9/X9tv8YeMLsx1ZTVcH0glclCT5vN0v1xms57X24VqdBGzM=
X-Received: by 2002:a05:6870:514c:b0:150:7e4a:2f00 with SMTP id
 z12-20020a056870514c00b001507e4a2f00mr2614641oak.194.1673501561332; Wed, 11
 Jan 2023 21:32:41 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-5-ojeda@kernel.org>
In-Reply-To: <20230109204520.539080-5-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 Jan 2023 14:32:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQj_WykFWcrj=L3wJYxDhOCGs+JHPB4E2vzWcx8y_at0w@mail.gmail.com>
Message-ID: <CAK7LNAQj_WykFWcrj=L3wJYxDhOCGs+JHPB4E2vzWcx8y_at0w@mail.gmail.com>
Subject: Re: [PATCH 5/6] kbuild: rust_is_available: fix confusion when a
 version appears in the path
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 5:46 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> `bindgen`'s output for `libclang`'s version check contains paths, which
> in turn may contain strings that look like version numbers [1]:
>
>     .../6.1.0-dev/.../rust_is_available_bindgen_libclang.h:2:9: warning: clang version 11.1.0  [-W#pragma-messages], err: false
>
> which the script will pick up as the version instead of the latter.
>
> It is also the case that versions may appear after the actual version
> (e.g. distribution's version text), which was the reason behind `head` [2]:
>
>     .../rust-is-available-bindgen-libclang.h:2:9: warning: clang version 13.0.0 (Fedora 13.0.0-3.fc35) [-W#pragma-messages], err: false
>
> Thus instead ask for a match after the `clang version` string.
>
> Reported-by: Jordan (@jordanisaacs)
> Link: https://github.com/Rust-for-Linux/linux/issues/942 [1]
> Link: https://github.com/Rust-for-Linux/linux/pull/789 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/rust_is_available.sh | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> index 0c082a248f15..a86659410e48 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -141,9 +141,7 @@ fi
>  # of the `libclang` found by the Rust bindings generator is suitable.
>  bindgen_libclang_version=$( \
>         echo "$bindgen_libclang_output" \
> -               | grep -F 'clang version ' \
> -               | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
> -               | head -n 1 \
> +               | sed -nE 's:.*clang version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
>  )
>  bindgen_libclang_min_version=$($min_tool_version llvm)
>  bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)
> --
> 2.39.0
>



You do not need to fork sed.




diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index 1f478d7e0f77..ebe427e27379 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -137,14 +137,9 @@ fi

 # `bindgen` returned successfully, thus use the output to check that
the version
 # of the `libclang` found by the Rust bindings generator is suitable.
-bindgen_libclang_version=$( \
-       echo "$bindgen_libclang_output" \
-               | grep -F 'clang version ' \
-               | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
-               | head -n 1 \
-)
+set -- ${bindgen_libclang_output#**clang version}
+bindgen_libclang_cversion=$(get_canonical_version $1)
 bindgen_libclang_min_version=$($min_tool_version llvm)
-bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)
 bindgen_libclang_min_cversion=$(get_canonical_version
$bindgen_libclang_min_version)
 if [ "$bindgen_libclang_cversion" -lt "$bindgen_libclang_min_cversion" ]; then
        echo >&2 "***"






-- 
Best Regards
Masahiro Yamada
