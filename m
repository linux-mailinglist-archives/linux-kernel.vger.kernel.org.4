Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232A169BE8C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 06:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBSF0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 00:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSF0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 00:26:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D402311EAC;
        Sat, 18 Feb 2023 21:26:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81E96B80967;
        Sun, 19 Feb 2023 05:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DDEC433EF;
        Sun, 19 Feb 2023 05:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676784395;
        bh=eNYU1Ixq0M5lCMRAUINMZYzWF6SrPRcZrOboXRRSPlI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sWclXBws9bBkY2tYCOMnXS1Mwygbp25Uo3EqtKybXlmFri/9ksNPVWOOB7JoYCyNb
         Zb1sjRRJW+VFwwF0SD4g4uF//ZxeM8LTWfoiPombEtzqA6hf8CnyBwL8etKENHX7wA
         l2TsySE4gF5SHgq8CTMOayBP0gIBNirMXgWZ/a6kzQEeGXuZ2ISLtitQpYsXUBgvw7
         OGhV9AExA8ei8GwKcTpfW0P5/kTvDh1FVQdSJmoPNthTR4Jcxy+Tfjuu2K7P1vYH+T
         SWPEkb/Cs/ndLdBd/MEO4bB7I2SpwFcJQFbyHRGoGf47soYkO6qWX8zMdT1q3g51Wo
         RmA7lyTONwzNQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-171ae29decdso2423741fac.1;
        Sat, 18 Feb 2023 21:26:35 -0800 (PST)
X-Gm-Message-State: AO0yUKUVfuB6OGdT5QjaKsBOq8NHBDuGMadRaScfI2hwmZwan9Uiw8vo
        Ykb5mRDFpKu/J5QAMFfM6FPrOBJjYi0xTyO3MT4=
X-Google-Smtp-Source: AK7set9KLSTdzRq29Dw0+NZpG98FduCSjJJZUUSmmZfTfgv0JVg5Bibe+yBjR6dai8ww1TGhYKSUpl+S5zXj7kc3c0M=
X-Received: by 2002:a05:6870:c1ce:b0:16e:9431:5c2e with SMTP id
 i14-20020a056870c1ce00b0016e94315c2emr419766oad.56.1676784394288; Sat, 18 Feb
 2023 21:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20230217202234.32260-1-quic_johmoo@quicinc.com> <20230217202234.32260-2-quic_johmoo@quicinc.com>
In-Reply-To: <20230217202234.32260-2-quic_johmoo@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Feb 2023 14:25:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNASf_RQGM6QYwvUN+FLq-v3jK66Pk5jW9M-vM1V4K0xH8g@mail.gmail.com>
Message-ID: <CAK7LNASf_RQGM6QYwvUN+FLq-v3jK66Pk5jW9M-vM1V4K0xH8g@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/1] check-uapi: Introduce check-uapi.sh
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, Jordan Crouse <jorcrous@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 5:23 AM John Moon <quic_johmoo@quicinc.com> wrote:
>
> While the kernel community has been good at maintaining backwards
> compatibility with kernel UAPIs, it would be helpful to have a tool
> to check if a patch introduces changes that break backwards
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
> changed header before and after the patch to detect any changes.
>
> abidiff "compares the ABI of two shared libraries in ELF format. It
> emits a meaningful report describing the differences between the two
> ABIs."
>
> Signed-off-by: John Moon <quic_johmoo@quicinc.com>




BTW, the patch is prefixed with 'RESEND', but it contains
several diff lines against the previous submission [1].

People would submit this as v2 with changes mentioned under '---'.


[1]: https://patchwork.kernel.org/project/linux-kbuild/patch/20230217202234.32260-2-quic_johmoo@quicinc.com/






diff --git a/scripts/check-uapi.sh b/scripts/check-uapi.sh
index 209c6793a4d0..b9cd3a2d7805 100755
--- a/scripts/check-uapi.sh
+++ b/scripts/check-uapi.sh
@@ -3,6 +3,7 @@

 # Script to check a patch for UAPI stability
 set -o errexit
+set -o pipefail

 print_usage() {
        name=$(basename "$0")
@@ -34,7 +35,7 @@ get_header() {

        if [ ! -x "${KERNEL_SRC}/scripts/unifdef" ]; then
                if ! make -C "${KERNEL_SRC}/scripts" unifdef; then
-                       echo 'error - failed to build required
dependency "scripts/unifdef"'
+                       errlog 'error - failed to build required
dependency "scripts/unifdef"'
                        exit 1
                fi
        fi
@@ -111,7 +112,7 @@ check_changed_files() {

        total=$((passed + failed))
        if [ "$total" -eq 0 ]; then
-               errlog "No changes to UAPI headers detected"
+               errlog "No changes to UAPI headers detected in most
recent commit"
        else
                errlog "${passed}/${total} UAPI header file changes
are backwards compatible"
        fi
@@ -190,16 +191,15 @@ check_deps() {
                errlog "error - abidiff not found!"
                errlog "Please install abigail-tools (version 1.7 or greater)"
                errlog "See:
https://sourceware.org/libabigail/manual/libabigail-overview.html"
-               exit 2
+               exit 1
        fi

-       local -r abidiff_maj=$("$ABIDIFF" --version | cut -d ' ' -f 2
| cut -d '.' -f 1)
-       local -r abidiff_min=$("$ABIDIFF" --version | cut -d ' ' -f 2
| cut -d '.' -f 1)
+       read -r abidiff_maj abidiff_min _ < <("$ABIDIFF" --version |
cut -d ' ' -f 2 | tr '.' ' ')
        if [ "$abidiff_maj" -lt 1 ] || ([ "$abidiff_maj" -eq 1 ] && [
"$abidiff_min" -lt 7 ]); then
-               errlog "error - installed abidiff version too old:
$("$ABIDIFF" --version)"
+               errlog "error - abidiff version too old: $("$ABIDIFF"
--version)"
                errlog "Please install abigail-tools (version 1.7 or greater)"
                errlog "See:
https://sourceware.org/libabigail/manual/libabigail-overview.html"
-               exit 2
+               exit 1
        fi
 }

@@ -220,13 +220,18 @@ main() {
        check_deps

        tmp_dir=$(mktemp -d)
-       #trap 'rm -rf $tmp_dir' EXIT
+       trap 'rm -rf $tmp_dir' EXIT

        if [ -z "$KERNEL_SRC" ]; then
                KERNEL_SRC="$(realpath "$(dirname "$0")"/..)"
        fi
        export KERNEL_SRC

+       if ! (cd "$KERNEL_SRC" && git rev-parse --is-inside-work-tree
> /dev/null 2>&1); then
+               errlog "error - this script requires the kernel tree
to be initialized with Git"
+               exit 1
+       fi
+
        export ARCH
        export CC
        export CROSS_COMPILE






-- 
Best Regards
Masahiro Yamada
