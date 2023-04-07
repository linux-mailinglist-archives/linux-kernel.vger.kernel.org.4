Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE7C6DB413
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjDGTUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjDGTUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7765193E3;
        Fri,  7 Apr 2023 12:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D79651C1;
        Fri,  7 Apr 2023 19:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F0CC433D2;
        Fri,  7 Apr 2023 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680895225;
        bh=q5dnVJ5d9oLUI4mT3mEbI6LwM/18Yhn07DiCVUC50cI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CFYzkBIwEkL4zfap7yhKFg0gvJQ3ZEeZy9tJFgoeWvS4XGSb3kO+8rm9wwEkKuLzw
         6SsBNf0uHYaS943qRPRk75OTYUqQ48EWp8uaIHuTuuIlxeZLxVFnZK2xdJcu4zs2+H
         3b+iMYPsmeUkzE2bQ0ZagZo3+SHoahVhcp3pxe6DXESq+HxBaGHzlf09lKgdKm394a
         iwKx0qqyOKr0ice9W/jB2xro86BtK5ilkgJT/Ycmnb2gYTihJ2W8h3zy2mEVO/uZo5
         8GL9/O2nV6unyoZREFMuze4XMP2DXVjtY+gIEdBG7gsBkidAOtwRZzqUWVcGv8xKQQ
         ukEyrFFTWV2og==
Received: by mail-oi1-f169.google.com with SMTP id f14so18131162oiw.10;
        Fri, 07 Apr 2023 12:20:25 -0700 (PDT)
X-Gm-Message-State: AAQBX9fPzE0SE+jEY1t7A7tOi4+zAiKZswD/WJhp/Y2VbyOw69Bt1xjZ
        Qcqz8j0D+9s1Jm8GhW0WdOKIHF+VuSgUAOXw9iI=
X-Google-Smtp-Source: AKy350ZEO3pO4bGRoMifAXL2M8FXZOyAJAw9LICd53AHUuexmelkA2BtjIM6uvvYTmgSRY8mKWqRasUr2wddeWDeO1A=
X-Received: by 2002:a05:6808:cd:b0:389:72d5:f173 with SMTP id
 t13-20020a05680800cd00b0038972d5f173mr843515oic.11.1680895224546; Fri, 07 Apr
 2023 12:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230327174140.8169-1-quic_johmoo@quicinc.com> <20230327174140.8169-2-quic_johmoo@quicinc.com>
In-Reply-To: <20230327174140.8169-2-quic_johmoo@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 8 Apr 2023 04:19:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ26HVA-oMwOqAg-diZ7dRa_41hjmRb88Vcv-GcQsFfqg@mail.gmail.com>
Message-ID: <CAK7LNAQ26HVA-oMwOqAg-diZ7dRa_41hjmRb88Vcv-GcQsFfqg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] check-uapi: Introduce check-uapi.sh
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 2:42=E2=80=AFAM John Moon <quic_johmoo@quicinc.com>=
 wrote:
>
> While the kernel community has been good at maintaining backwards
> compatibility with kernel UAPIs, it would be helpful to have a tool
> to check if a commit introduces changes that break backwards
> compatibility.
>
> To that end, introduce check-uapi.sh: a simple shell script that
> checks for changes to UAPI headers using libabigail.
>
> libabigail is "a framework which aims at helping developers and
> software distributors to spot some ABI-related issues like interface
> incompatibility in ELF shared libraries by performing a static
> analysis of the ELF binaries at hand."
>
> The script uses one of libabigail's tools, "abidiff", to compile the
> changed header before and after the commit to detect any changes.
>
> abidiff "compares the ABI of two shared libraries in ELF format. It
> emits a meaningful report describing the differences between the two
> ABIs."
>
> The script also includes the ability to check the compatibility of
> all UAPI headers across commits. This allows developers to inspect
> the stability of the UAPIs over time.
>
> Signed-off-by: John Moon <quic_johmoo@quicinc.com>
> ---
>     - Refactored to exclusively check headers installed by make
>       headers_install. This simplified the code dramatically and removed
>       the need to perform complex git diffs.
>     - Removed the "-m" flag. Since we're checking all installed headers
>       every time, a flag to check only modified files didn't make sense.
>     - Added info message when usr/include/Makefile is not present that
>       it's likely because that file was only introduced in v5.3.
>     - Changed default behavior of log file. Now, the script will not
>       create a log file unless you pass "-l <file>".
>     - Simplified exit handler.
>     - Added -j $MAX_THREADS to make headers_install to improve speed.
>     - Cleaned up variable references.
>
>  scripts/check-uapi.sh | 488 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 488 insertions(+)
>  create mode 100755 scripts/check-uapi.sh
>

> +
> +# Save the current git tree state, stashing if needed
> +save_tree_state() {
> +       printf "Saving current tree state... "
> +       current_ref=3D"$(git rev-parse HEAD)"
> +       readonly current_ref
> +       if tree_is_dirty; then
> +               unstash=3D"true"
> +               git stash push --quiet
> +       fi
> +       printf "OK\n"
> +}
> +
> +# Restore the git tree state, unstashing if needed
> +restore_tree_state() {
> +       if [ -z "$current_ref" ]; then
> +               return 0
> +       fi
> +
> +       printf "Restoring current tree state... "
> +       git checkout --quiet "$current_ref"


This does not restore the original state.

I was on a branch before running this script.
After everything is finished, I am on a detached commit
because $current_ref is not a branch.






> +       if ! do_compile "$(get_header_tree "$past_ref")/include" "$past_h=
eader" "${past_header}.bin" 2> "$log"; then
> +               eprintf "error - couldn't compile version of UAPI header =
%s at %s\n" "$file" "$past_ref"
> +               cat "$log" >&2
> +               exit "$FAIL_COMPILE"
> +       fi
> +
> +       "$ABIDIFF" --non-reachable-types "${past_header}.bin" "${base_hea=
der}.bin" > "$log" && ret=3D"$?" || ret=3D"$?"


[bikeshed] I might want to write like this:

   ret=3D0
   "$ABIDIFF" --non-reachable-types "${past_header}.bin"
"${base_header}.bin" > "$log" || ret=3D"$?"







> +
> +
> +       if [ "$quiet" =3D "true" ]; then
> +               run "$base_ref" "$past_ref" "$abi_error_log" "$@" > /dev/=
null
> +       else
> +               run "$base_ref" "$past_ref" "$abi_error_log" "$@"
> +       fi



    if [ "$quiet" =3D "true" ]; then
            exec > /dev/null
    fi

    run "$base_ref" "$past_ref" "$abi_error_log" "$@"



is more elegant because this is the last line of main()
and exit_handler() does not print anything.






--=20
Best Regards
Masahiro Yamada
