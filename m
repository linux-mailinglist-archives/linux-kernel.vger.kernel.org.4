Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90F66E093
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjAQO1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjAQO1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:27:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8D041B4B;
        Tue, 17 Jan 2023 06:25:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05C60B81645;
        Tue, 17 Jan 2023 14:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC48CC433D2;
        Tue, 17 Jan 2023 14:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673965524;
        bh=IWV28HSU4fBLUXf9X0yhOZll1WPSFzOCcO7uiHdu1lU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FoEDfyp4E4eXjTTECRpWjrFTcTA26N+qzKjzKRme4zXvkMcJCe20df8kl9wKb9684
         7SrGICWRPXw04mO+XnD7fBdb9w4vMIzFNi47rPwajQviFnlCIxwqUm7HwxsoJoP5JI
         oBdEIhzBO/PYNC3zQ+qvz7wlS4wLNl1N7FDBl60eh+dPLn0fp6siXWT3ttFrL2aOP4
         iqKi0D4cREXbjZ8TrkrRDSL8zdENWNsUmcy+N/kOECN5FZTm1lxh6a2NxJ5xOSpMS4
         hg6RbinJfoa2dcCOE0giF7xtSJkuUjRYI+ujfh69CKUVqHt1Q3mxaG8r/goo51Sbzj
         iWYlOtamcLVTA==
Received: by mail-oi1-f171.google.com with SMTP id s66so25345715oib.7;
        Tue, 17 Jan 2023 06:25:24 -0800 (PST)
X-Gm-Message-State: AFqh2kqoxQJrlLECf+SMYDArQcpwAdHMkWD47Jg7Q0fwHYHOXMK8MEbb
        R/xGdi4riYKX3B0YOZVSy3Ftb57hcFh63sYG13k=
X-Google-Smtp-Source: AMrXdXthV9CQpAhHODShubzPL709xBw1U0u2Z7Hly6nbLi+5jmNc8O+iHZx7/6X7CsQTgubx0RD+c6MQK4Z6ViXAgvg=
X-Received: by 2002:a05:6808:1786:b0:35e:7c55:b015 with SMTP id
 bg6-20020a056808178600b0035e7c55b015mr199411oib.287.1673965523913; Tue, 17
 Jan 2023 06:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20230117-kernel-kheaders-gitignore-v2-1-1c29b3adf04a@weissschuh.net>
In-Reply-To: <20230117-kernel-kheaders-gitignore-v2-1-1c29b3adf04a@weissschuh.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Jan 2023 23:24:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARi8Gm7n0nRidyf++YmW9zZ1qv7huN8nP3MCNzWGK42Cg@mail.gmail.com>
Message-ID: <CAK7LNARi8Gm7n0nRidyf++YmW9zZ1qv7huN8nP3MCNzWGK42Cg@mail.gmail.com>
Subject: Re: [PATCH v2] kheaders: ignore and clean temporary kheaders_data directory
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nicolas Schier <n.schier@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:50 PM Thomas Wei=C3=9Fschuh <linux@weissschuh.ne=
t> wrote:
>
> If the kheaders archive generation is interrupted then this directory
> may be left.
> Ignore it, it will be deleted by the next run of kernel/gen_kheaders.sh.
> Also add it to clean-files so it can be cleaned up by make.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>


Or, just rename the temporary directory.
For example,

  cpio_dir=3D$outdir/$(dirname $tarfile)/.tmp_cpio_dir



Dot files are ignored.
'make clean' removes the .tmp_* pattern.




> ---
> Changes in v2:
> - Also add the directory to clean-files
> - Link to v1: https://lore.kernel.org/r/20230117-kernel-kheaders-gitignor=
e-v1-1-2a3a070efd0d@weissschuh.net
> ---
>  kernel/.gitignore | 1 +
>  kernel/Makefile   | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/.gitignore b/kernel/.gitignore
> index c6b299a6b786..57ab1d703763 100644
> --- a/kernel/.gitignore
> +++ b/kernel/.gitignore
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  /config_data
>  /kheaders.md5
> +/kheaders_data.tar.xz.tmp/
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 10ef068f598d..f3535944f635 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -156,4 +156,4 @@ quiet_cmd_genikh =3D CHK     $(obj)/kheaders_data.tar=
.xz
>  $(obj)/kheaders_data.tar.xz: FORCE
>         $(call cmd,genikh)
>
> -clean-files :=3D kheaders_data.tar.xz kheaders.md5
> +clean-files :=3D kheaders_data.tar.xz kheaders.md5 kheaders_data.tar.xz.=
tmp
>
> ---
> base-commit: d532dd102151cc69fcd00b13e5a9689b23c0c8d9
> change-id: 20230117-kernel-kheaders-gitignore-f0d73456cb6b
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>


--
Best Regards


Masahiro Yamada
