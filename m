Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D396DB442
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjDGTdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDGTdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE465FCB;
        Fri,  7 Apr 2023 12:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 022E9611DB;
        Fri,  7 Apr 2023 19:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A41DC433A7;
        Fri,  7 Apr 2023 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680895714;
        bh=tLuYmZCaB6pcx1B5nefyV2H/zPduYUn1OkjtxTZ6xUI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xx6R3K6g48YPJPS3SQuaU7w4dWVg0aIVFEyFB5sypxj+ZMxEhcs2hnYMbqHK3mA4M
         Uf/GjjL/+FQoVet4YOm6DPhfxK47opiuocGz1ebCW/1h3k945Zx0E/GrdGYRSlRYEf
         5h3zWJTGZstvw0xkZED4reXmtWKAfibCLXUxIJlydrq2Bc8O2lGs39CzUEe9hPaQ9F
         CbXziaCjCoEPYkb+9Z7e9TfmEg5C1Vc/wX4JjGKNepREFEKuo5c9BG1tHLJLCHu4IH
         r7iI654GL8eUBRlpUwO2aH1tnz6p3uJUVnQdK2/UWH13vhTqo4ISFNirkjAR/Qal7b
         vG0GmxdlyU80A==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-18412684c50so2493696fac.5;
        Fri, 07 Apr 2023 12:28:34 -0700 (PDT)
X-Gm-Message-State: AAQBX9dwjNYr2PkQkuc2+VEUwtSNbls1e5L5336BXr00k3xIFQ3vWwVE
        /HeEw0fC3nGM2zJyXQmOcGEIcAQymhe2p718fU4=
X-Google-Smtp-Source: AKy350azdAeTKIOh6AAieg0U1LA6pQ4fhwORC4vZ1IKU8T02ZJdhn7IVZZ64dWW+v3eEGP8bDqzmA58YEn0kZuxzgO4=
X-Received: by 2002:a05:6870:1258:b0:17f:84f8:1f44 with SMTP id
 24-20020a056870125800b0017f84f81f44mr1570897oao.11.1680895713574; Fri, 07 Apr
 2023 12:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230327174140.8169-1-quic_johmoo@quicinc.com> <20230327174140.8169-2-quic_johmoo@quicinc.com>
In-Reply-To: <20230327174140.8169-2-quic_johmoo@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 8 Apr 2023 04:27:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFzdb37ZpOkYOP0rGBBjMhad6p76CXJg7kZsNkhpoBXg@mail.gmail.com>
Message-ID: <CAK7LNATFzdb37ZpOkYOP0rGBBjMhad6p76CXJg7kZsNkhpoBXg@mail.gmail.com>
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
> +# Install headers for both git refs
> +install_headers() {
> +       local -r base_ref=3D"$1"
> +       local -r past_ref=3D"$2"
> +
> +       DEVIATED_FROM_CURRENT_TREE=3D"false"
> +       for ref in "$base_ref" "$past_ref"; do
> +               if [ -n "$ref" ]; then
> +                       if [ "$DEVIATED_FROM_CURRENT_TREE" =3D "false" ];=
 then
> +                               save_tree_state
> +                               DEVIATED_FROM_CURRENT_TREE=3D"true"
> +                       fi
> +                       # This script ($0) is already loaded into memory =
at this point,
> +                       # so this operation is safe
> +                       git checkout --quiet "$(git rev-parse "$ref")"
> +               fi
> +
> +               printf "Installing sanitized UAPI headers from %s... " "$=
{ref:-dirty tree}"
> +               make -j "$MAX_THREADS" ARCH=3D"$ARCH" INSTALL_HDR_PATH=3D=
"${TMP_DIR}/${ref}/usr" headers_install > /dev/null 2>&1


You suppressed stderr.

If 'make headers_install' fails, users see a sudden death
with no clue.




--=20
Best Regards
Masahiro Yamada
