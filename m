Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6A3668F47
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjAMHds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbjAMHc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:32:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09E66ADB4;
        Thu, 12 Jan 2023 23:29:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C71B62284;
        Fri, 13 Jan 2023 07:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BF9C433D2;
        Fri, 13 Jan 2023 07:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673594967;
        bh=HdORwliAlKDZ7stnWASrQZfLjLba57MqkREEv8VnFOE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IvFiucuSA8G58gtqGIuOWHE1qA0kFBMPY4senDM9SN8MFgYa6frko4U8Q438g4y6P
         4e6dGJ0y+tvRGTZWiIHfycrPhH3m78o/XwQ35nRpJISUXDmAjFWiWQ6824bEJNfKFM
         hpzKrKxmZRAZv47PSzUl64oU01Ac10vYkuXAtqQ9/17L7X/7LDSwxhOHnzJ9T7rJRh
         hTxA969ZocRidZTpFvBIRFQ9yyNHwI/ttvRIPB7ozN7TN1gyJxA0/4mHfItjUVhLKC
         bdtIqNulreXoqfs8CYGtCSTCOHxwdCHZ5Gctc1DkVAklBq6eZrUe+LlhaWK6Hlr0Lt
         phKEV7Sap5Qnw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-15ee27bb0a8so1074335fac.7;
        Thu, 12 Jan 2023 23:29:27 -0800 (PST)
X-Gm-Message-State: AFqh2kos1/nsrgantSKt7JCYAlR24IriE3CjCGdOlRJWfVKy9Xr40Zgo
        DsPOh2AHH2QCPo3fmcFhxeUOSkeQNLPhrfhdzhg=
X-Google-Smtp-Source: AMrXdXtO1vzWs5t7LoWwnKsfx6fseeW3edgtD6OcSrFb38X8vczRhtOinccHS7mabN4Ncknm4BitWaYFDCoim7QFND8=
X-Received: by 2002:a05:6870:50a:b0:15b:9941:ac30 with SMTP id
 j10-20020a056870050a00b0015b9941ac30mr1497533oao.287.1673594967147; Thu, 12
 Jan 2023 23:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20230111-kconfig-v2-1-b000fb6bc902@pefoley.com>
In-Reply-To: <20230111-kconfig-v2-1-b000fb6bc902@pefoley.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 Jan 2023 16:28:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNASjw1QR-6=Zmf5v=4yv8S81wzeBCOgpsuG7e1Q4GSapeA@mail.gmail.com>
Message-ID: <CAK7LNASjw1QR-6=Zmf5v=4yv8S81wzeBCOgpsuG7e1Q4GSapeA@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: Update all declared targets
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 1:24 PM Peter Foley <pefoley2@pefoley.com> wrote:
>
> Currently qconf-cfg.sh is the only script that touches the "-bin"
> target, even though all of the conf_cfg rules declare that they do.
> Make the recipe unconditionally touch all declared targets to avoid
> incompatibilities with upcoming versions of GNU make:
> https://lists.gnu.org/archive/html/info-gnu/2022-10/msg00008.html
>
> e.g.
> scripts/kconfig/Makefile:215: warning: pattern recipe did not update peer target 'scripts/kconfig/nconf-bin'.
> scripts/kconfig/Makefile:215: warning: pattern recipe did not update peer target 'scripts/kconfig/mconf-bin'.
> scripts/kconfig/Makefile:215: warning: pattern recipe did not update peer target 'scripts/kconfig/gconf-bin'.
>
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>

Applied to linux-kbuild/fixes.
Thanks!


> ---
> Changes in v2:
> - Update pattern rule to touch -bin instead of each script.
> - Add missing gitignore entries.
> - Link to v1: https://lore.kernel.org/r/20230111-kconfig-v1-1-a921f03670f0@pefoley.com
> ---
>  scripts/kconfig/.gitignore | 2 +-
>  scripts/kconfig/Makefile   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
> index c8a3f9cd52f0..f8bdf0cf4662 100644
> --- a/scripts/kconfig/.gitignore
> +++ b/scripts/kconfig/.gitignore
> @@ -3,5 +3,5 @@
>  /[gmnq]conf
>  /[gmnq]conf-cflags
>  /[gmnq]conf-libs
> -/qconf-bin
> +/[gmnq]conf-bin
>  /qconf-moc.cc
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 0b1d15efaeb0..af1c96198f49 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -209,7 +209,7 @@ $(obj)/gconf: | $(obj)/gconf-libs
>  $(obj)/gconf.o: | $(obj)/gconf-cflags
>
>  # check if necessary packages are available, and configure build flags
> -cmd_conf_cfg = $< $(addprefix $(obj)/$*conf-, cflags libs bin)
> +cmd_conf_cfg = $< $(addprefix $(obj)/$*conf-, cflags libs bin); touch $(obj)/$*conf-bin
>
>  $(obj)/%conf-cflags $(obj)/%conf-libs $(obj)/%conf-bin: $(src)/%conf-cfg.sh
>         $(call cmd,conf_cfg)
>
> ---
> base-commit: e8f60cd7db24f94f2dbed6bec30dd16a68fc0828
> change-id: 20230111-kconfig-e59c6154f506
>
> Best regards,
> --
> Peter Foley <pefoley2@pefoley.com>



-- 
Best Regards
Masahiro Yamada
