Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6266E362A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjDPIrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjDPIrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DF319BB;
        Sun, 16 Apr 2023 01:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C444360917;
        Sun, 16 Apr 2023 08:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3300BC433D2;
        Sun, 16 Apr 2023 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681634821;
        bh=ykTbrtCxaexjaWHwrikTbnMFcEtZrSTpBGKTGVgmWqU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=db+XKWlUb6bzzDmWmgehxuEq3JTMcGcnnOxGJ00sx8h1Sz4oYXe+V7Z95ixzuHQtE
         lGdAVH86jcvHedtNDiPuffeoFxL2n+ffP4RjZqEHroUxnmM3LcTdS4uFTadF9QzIPk
         FuN2s5kApHo/azNEyWouzS+VQN+5A7nvvVKqTD/DfhMTCE2HXoPaZZnrKWxJgHPmVE
         Gj0W1OugiwOuhhHm/tPPbIg0A8mXtjB0hmE6bLWg17M8CzEIIh0y3bVluNWo7zItXi
         NR47/5FsRIIspRhKYk1QwlcZid9zA5y+z+vdBta/zO/lTu5uqkP1p7nO1Rui9aic36
         pzVqrxCC725pw==
Received: by mail-ot1-f48.google.com with SMTP id cg19-20020a056830631300b0069f922cd5ceso10832706otb.12;
        Sun, 16 Apr 2023 01:47:01 -0700 (PDT)
X-Gm-Message-State: AAQBX9dgaSjDQI55cAa48ombKaKCASvzBFZQED0dGjltdBtxaeesU7ZB
        hneKN/tNDrVMFep3r+1irPlZIG4MoTJOXc/Gr5o=
X-Google-Smtp-Source: AKy350aMaAn+2yfTFNWChZ8b48glK+PeYD9l9ZpU3zWgIO5LvdT5BfgPwzWZvpqZV/pNI41Ic73xfvFuCSV2vZNTfyQ=
X-Received: by 2002:a05:6830:e85:b0:6a5:dfa8:ff8b with SMTP id
 dp5-20020a0568300e8500b006a5dfa8ff8bmr258482otb.1.1681634820458; Sun, 16 Apr
 2023 01:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230320040839.660475-1-bgray@linux.ibm.com>
In-Reply-To: <20230320040839.660475-1-bgray@linux.ibm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 16 Apr 2023 17:46:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR8g246Zvy78mEFN5c_NLWSMNajF52tPLbtkLuiY_Xn7A@mail.gmail.com>
Message-ID: <CAK7LNAR8g246Zvy78mEFN5c_NLWSMNajF52tPLbtkLuiY_Xn7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] initramfs: Check negative timestamp to prevent broken
 cpio archive
To:     Benjamin Gray <bgray@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 1:09=E2=80=AFPM Benjamin Gray <bgray@linux.ibm.com>=
 wrote:
>
> Similar to commit 4c9d410f32b3 ("initramfs: Check timestamp to prevent
> broken cpio archive"), except asserts that the timestamp is
> non-negative. This can happen when the KBUILD_BUILD_TIMESTAMP is a value
> before UNIX epoch, which may be set when making reproducible builds that
> don't want to look like they use a valid date.
>
> While support for dates before 1970 might not be supported, this is more
> about preventing undetected CPIO corruption. The printf's use a minimum
> length format specifier, and will happily make the field longer than 8
> characters if they need to.
>
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
>
> ---

Applied to linux-kbuild.   (only 1/2)
Thanks.




>
> Ran into this when setting KBUILD_BUILD_TIMESTAMP=3D0000-01-01. The kerne=
l
> builds and boots to an initramfs just fine, but inexplicably failed to
> load any root disks. It was a pain to debug, because the first sign of
> an issue was so deep into the boot sequence.
> ---
>  usr/gen_init_cpio.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> index ee01e40e8bc6..61230532fef1 100644
> --- a/usr/gen_init_cpio.c
> +++ b/usr/gen_init_cpio.c
> @@ -353,6 +353,12 @@ static int cpio_mkfile(const char *name, const char =
*location,
>                 buf.st_mtime =3D 0xffffffff;
>         }
>
> +       if (buf.st_mtime < 0) {
> +               fprintf(stderr, "%s: Timestamp negative, clipping.\n",
> +                       location);
> +               buf.st_mtime =3D 0;
> +       }
> +
>         if (buf.st_size > 0xffffffff) {
>                 fprintf(stderr, "%s: Size exceeds maximum cpio file size\=
n",
>                         location);
> @@ -602,10 +608,10 @@ int main (int argc, char *argv[])
>         /*
>          * Timestamps after 2106-02-07 06:28:15 UTC have an ascii hex tim=
e_t
>          * representation that exceeds 8 chars and breaks the cpio header
> -        * specification.
> +        * specification. Negative timestamps similarly exceed 8 chars.
>          */
> -       if (default_mtime > 0xffffffff) {
> -               fprintf(stderr, "ERROR: Timestamp too large for cpio form=
at\n");
> +       if (default_mtime > 0xffffffff || default_mtime < 0) {
> +               fprintf(stderr, "ERROR: Timestamp out of range for cpio f=
ormat\n");
>                 exit(1);
>         }
>
>
> base-commit: 065ffaee73892e8a3629b4cfbe635697807a3c6f
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
