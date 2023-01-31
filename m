Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5A66833BA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjAaRVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjAaRVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:21:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C9B4A22D;
        Tue, 31 Jan 2023 09:21:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5206861536;
        Tue, 31 Jan 2023 17:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B305FC433D2;
        Tue, 31 Jan 2023 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675185647;
        bh=r5HSOmCvVYNNxPiGkzGPz8lmHaZtwKd1nkYw2uasuh0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nOrlEm327HlfV2/4+MvHP3sz0ArjTFWwW2tds+VmhoBANKxH+IsoZDzLneh1Ns5kL
         ONI0Ft0Zyha98TvkD+3wy0x/e8Dk3RzRq9u9fFsWg1XX0pVFgnxYtmhXU9VTP7imTy
         fXkkcIZSN+tHn/qRU0JuhLypwDt7J7pavhGSwNS5HQ9LGwSyOzk4kDKBt2CY2Ob9kg
         j11vUj8OCgdTxH/XSUYboWhtpujwLxRHdkbX5ssEEC2lkA/4qhToCtejxx8yvn0Q1J
         32pKinhpCmWXD4537rZIkiGBTJ4EG0K0DHk45xldWDOQXQvB8ENs1kBUaOlO8V9HtB
         hz00wqggo3HJg==
Received: by mail-oi1-f182.google.com with SMTP id r205so13413605oib.9;
        Tue, 31 Jan 2023 09:20:47 -0800 (PST)
X-Gm-Message-State: AO0yUKVuAYYtVCxG7eO0SAeICMQeM9B180uBJOir7VKaagQdGqcURGTJ
        7EgxwovmWBtWE4J3mcUDOOvMa7j6D7ISeQB2qg0=
X-Google-Smtp-Source: AK7set8s9Uc1E7rsTcTWzoO09LNHd2f7xHhFitp3tKUL6CPCc+/tJKgtZuujrSqdcLJiyZfDNBPrhERaMbGwG+t/fYQ=
X-Received: by 2002:aca:b604:0:b0:377:f944:a8b7 with SMTP id
 g4-20020acab604000000b00377f944a8b7mr615623oif.194.1675185646883; Tue, 31 Jan
 2023 09:20:46 -0800 (PST)
MIME-Version: 1.0
References: <20230131133253.1460560-1-masahiroy@kernel.org>
In-Reply-To: <20230131133253.1460560-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Feb 2023 02:20:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNATz5LiyGcV-dRtod8NobNRDqb2aAB_n=h=1zkfVDnWQuA@mail.gmail.com>
Message-ID: <CAK7LNATz5LiyGcV-dRtod8NobNRDqb2aAB_n=h=1zkfVDnWQuA@mail.gmail.com>
Subject: Re: [PATCH] setlocalversion: do not append git commit hash if
 localversion* exists
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:33 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Since commit dcfbcb1033bb ("setlocalversion: use only the correct
> release tag for git-describe"), KERNELRELEASE of linux-next is
> annoyingly long:
>
>   $ make kernelrelease
>   6.2.0-rc6-next-20230131-09515-g80bd9028feca
>
> The string '-09515-g80bd9028feca' is appended because git-describe now
> uses the v6.2.0 tag instead of the next-20230113 tag.

 v6.2.0  -> v6.2-rc6



>
> In linux-next, the 'localversion-next' file well specifies the local
> version, so the extra info from git is unneeded.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/setlocalversion | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index e2b2d492ac13..4219a0ca1e62 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -113,22 +113,23 @@ if [ -z "${KERNELVERSION}" ]; then
>         exit 1
>  fi
>
> -res="${KERNELVERSION}"
> -
>  # localversion* files in the build and source directory
> -res="${res}$(collect_files localversion*)"
> +file_localversion="$(collect_files localversion*)"
>  if test ! "$srctree" -ef .; then
> -       res="$res$(collect_files "$srctree"/localversion*)"
> +       file_localversion="${file_localversion}$(collect_files "$srctree"/localversion*)"
>  fi
>
> -# CONFIG_LOCALVERSION and LOCALVERSION (if set)
> +# CONFIG_LOCALVERSION
>  config_localversion=$(sed -n 's/^CONFIG_LOCALVERSION=\(.*\)$/\1/p' include/config/auto.conf)
> -res="${res}${config_localversion}${LOCALVERSION}"
>
>  # scm version string if not at the kernel version tag
> -if grep -q "^CONFIG_LOCALVERSION_AUTO=y$" include/config/auto.conf; then
> +if [ -n "${file_localversion}" ]; then
> +       # If localversion* files exist (like in linux-next), the version is
> +       # well specified. Do not append scm_version.
> +       scm_version=
> +elif grep -q "^CONFIG_LOCALVERSION_AUTO=y$" include/config/auto.conf; then
>         # full scm version string
> -       res="$res$(scm_version)"
> +       scm_version="$(scm_version)"
>  elif [ "${LOCALVERSION+set}" != "set" ]; then
>         # If the variable LOCALVERSION is not set, append a plus
>         # sign if the repository is not in a clean annotated or
> @@ -137,7 +138,7 @@ elif [ "${LOCALVERSION+set}" != "set" ]; then
>         #
>         # If the variable LOCALVERSION is set (including being set
>         # to an empty string), we don't want to append a plus sign.
> -       res="$res$(scm_version --short)"
> +       scm_version="$(scm_version --short)"
>  fi
>
> -echo "$res"
> +echo "${KERNELVERSION}${file_localversion}${config_localversion}${LOCALVERSION}${scm_version}"
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
