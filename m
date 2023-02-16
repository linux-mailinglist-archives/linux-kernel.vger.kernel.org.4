Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42EB699426
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBPMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBPMSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:18:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAED474CD;
        Thu, 16 Feb 2023 04:18:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7DB1B824B3;
        Thu, 16 Feb 2023 12:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB81C433D2;
        Thu, 16 Feb 2023 12:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676549881;
        bh=DPESuOOr7V0LeGavGf6dXtvT3qVHvt0gYIZ5AS49RxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YLWbyTWM0ow9c7+XpUpV8vqI6GPN87f3U+j2q5tkOuWw10cQBUZbeWnJ/kotw1Dr8
         1AgKLzGM+o8dWBYGVeQXGsGInCve9tuoIDhd7eD5rNPiXvwB7l50LuQWPhu53hrGve
         FxdTkkmRXlRpg/1bd/Y01rOKh0qdkTGAdib+CxxXiHCoqvlRKaaqG7nw7tsChOe96k
         qns4NY6j2RJS0CLXw4sEXGzCpCgPKzk6RqVC52dEU6PlgDaKSlU6vYSZTEFigV8Yza
         w3HiapqakEXP+SvdNcVnLw5dS+bihIa/gWygmmGfbXneZNRiu3Elyyq4chSXuKmGbV
         +b/FuiUDOaZaQ==
Received: by mail-oi1-f181.google.com with SMTP id bi19so1471893oib.2;
        Thu, 16 Feb 2023 04:18:01 -0800 (PST)
X-Gm-Message-State: AO0yUKV0I87ROO5nc/D9cx61EfbNPlGttgIp1ydy8ycQapU5qVys/WOe
        cg83KlOaJiW1X96M/rU2R2iSkwqU2WZHQIRWs14=
X-Google-Smtp-Source: AK7set9RyPqNmZf9Zjs0/eojM/pEzcwyuIJE3CPwhxFpdlUO52eA+VuJrlP2bi03Jhf70K5bxPA7um/8dtShdpBdDgc=
X-Received: by 2002:a05:6808:1888:b0:37b:8b8e:5e71 with SMTP id
 bi8-20020a056808188800b0037b8b8e5e71mr104048oib.194.1676549880809; Thu, 16
 Feb 2023 04:18:00 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230208130800eucas1p2fbcba741dbd7483bb0a9b2d4b6c6dbfd@eucas1p2.samsung.com>
 <20230208130732.63172-1-l.stelmach@samsung.com>
In-Reply-To: <20230208130732.63172-1-l.stelmach@samsung.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 16 Feb 2023 21:17:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNASjsRYyRCAy_EujsX1o2ybR3KUQRA2HuPxeN=ppUpBa_A@mail.gmail.com>
Message-ID: <CAK7LNASjsRYyRCAy_EujsX1o2ybR3KUQRA2HuPxeN=ppUpBa_A@mail.gmail.com>
Subject: Re: [PATCH v2] merge_config.sh: do not report some differencess
 between input and output
To:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 10:08 PM =C5=81ukasz Stelmach <l.stelmach@samsung.co=
m> wrote:
>
> If an input config file contains CONFIG_FOO=3Dn the output one
> will contain a line '# CONFIG_FOO is not set'. merge_config.sh
> should not report it as difference because the end result of
> CONFIG_FOO being disabled is achieved.
>
> Inexistence of CONFIG_FOO (because of unment dependencies) in case
> CONFIG_FOO=3Dn is requested, should also be ignored.
>
> Change-Id: I129f3a0b4205a76d8c42020f8adb72b1889d75fb
> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> ---
> Changes in v2:
> - suppress reports reports if an option was "not set" in input files
>   but is missing from the filnal .config due to unmet dependecies.
> - apply the same logic to suppress some reports during the merging
>   phase
>
> BTW. Do you think adding "| sort -u" after "grep -w" to avoid reports
> about repeated entries may make sense or do you want such reports to
> be printed.
>
>  scripts/kconfig/merge_config.sh | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_conf=
ig.sh
> index e5b46980c22a..1086bdc7abf2 100755
> --- a/scripts/kconfig/merge_config.sh
> +++ b/scripts/kconfig/merge_config.sh
> @@ -144,12 +144,17 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
>                         echo
>                         BUILTIN_FLAG=3Dtrue
>                 elif [ "x$PREV_VAL" !=3D "x$NEW_VAL" ] ; then
> -                       echo Value of $CFG is redefined by fragment $ORIG=
_MERGE_FILE:
> -                       echo Previous  value: $PREV_VAL
> -                       echo New value:       $NEW_VAL
> -                       echo
> -                       if [ "$STRICT" =3D "true" ]; then
> -                               STRICT_MODE_VIOLATED=3Dtrue
> +                       if [ \( "x$PREV_VAL" !=3D "x$CFG=3Dn" -a \
> +                               "x$PREV_VAL" !=3D "x# $CFG is not set" \)=
 -o \
> +                            \( "x$NEW_VAL" !=3D "x"  -a \



In which case does $NEW_VAL become empty?

I think it is opposite.
$PREV_VAL might be empty, $NEW_VAL may specified as =3Dn.









> +                               "x$NEW_VAL" !=3D "x# $CFG is not set" \) =
]; then
> +                               echo Value of $CFG is redefined by fragme=
nt $ORIG_MERGE_FILE:
> +                               echo Previous  value: $PREV_VAL
> +                               echo New value:       $NEW_VAL
> +                               echo
> +                               if [ "$STRICT" =3D "true" ]; then
> +                                       STRICT_MODE_VIOLATED=3Dtrue
> +                               fi
>                         fi
>                 elif [ "$WARNREDUN" =3D "true" ]; then
>                         echo Value of $CFG is redundant by fragment $ORIG=
_MERGE_FILE:
> @@ -196,9 +201,14 @@ for CFG in $(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_C=
ONFIG_EXP2" $TMP_FILE); do
>         REQUESTED_VAL=3D$(grep -w -e "$CFG" $TMP_FILE)
>         ACTUAL_VAL=3D$(grep -w -e "$CFG" "$KCONFIG_CONFIG" || true)
>         if [ "x$REQUESTED_VAL" !=3D "x$ACTUAL_VAL" ] ; then
> -               echo "Value requested for $CFG not in final .config"
> -               echo "Requested value:  $REQUESTED_VAL"
> -               echo "Actual value:     $ACTUAL_VAL"
> -               echo ""
> +               if [ \( "x$REQUESTED_VAL" !=3D "x$CFG=3Dn" -a \
> +                       "x$REQUESTED_VAL" !=3D "x# $CFG is not set" \) -o=
 \
> +                    \( "x$ACTUAL_VAL" !=3D "x"  -a \
> +                       "x$ACTUAL_VAL" !=3D "x# $CFG is not set" \) ]; th=
en
> +                       echo "Value requested for $CFG not in final .conf=
ig"
> +                       echo "Requested value:  $REQUESTED_VAL"
> +                       echo "Actual value:     $ACTUAL_VAL"
> +                       echo ""
> +               fi
>         fi
>  done
> --
> 2.30.2
>


--=20
Best Regards
Masahiro Yamada
