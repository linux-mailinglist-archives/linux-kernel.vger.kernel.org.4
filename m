Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E293670FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjARBQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjARBQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:16:28 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF5239B93;
        Tue, 17 Jan 2023 17:10:35 -0800 (PST)
Date:   Wed, 18 Jan 2023 00:58:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1674004232;
        bh=vSIvUTO8Ecy+YVZDc735PIohw7OmPBpjpkNA56jGcvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsvV0jKYPh5T2Rq9prQC7YVsAy1Pfnjb9SECmVUp17CuHSI53oV/sCUDWXFy3mM3Z
         aa9fKcMG7+93n07vi/3o2K6Vdx0d3VOdsKinaQ9STgmVmIvQiliPnDY5yrT3muRsgM
         P4rYLyqaxxjUBJ4RlyucvyM+rni79NQY3NZxF8Xo=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nicolas Schier <n.schier@avm.de>
Subject: Re: [PATCH v2] kheaders: ignore and clean temporary kheaders_data
 directory
Message-ID: <20230118005830.pqupfqnwwkd64q3g@t-8ch.de>
References: <20230117-kernel-kheaders-gitignore-v2-1-1c29b3adf04a@weissschuh.net>
 <CAK7LNARi8Gm7n0nRidyf++YmW9zZ1qv7huN8nP3MCNzWGK42Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARi8Gm7n0nRidyf++YmW9zZ1qv7huN8nP3MCNzWGK42Cg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 11:24:47PM +0900, Masahiro Yamada wrote:
> On Tue, Jan 17, 2023 at 10:50 PM Thomas Weiﬂschuh <linux@weissschuh.net> wrote:
> >
> > If the kheaders archive generation is interrupted then this directory
> > may be left.
> > Ignore it, it will be deleted by the next run of kernel/gen_kheaders.sh.
> > Also add it to clean-files so it can be cleaned up by make.
> >
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> 
> Or, just rename the temporary directory.
> For example,
> 
>   cpio_dir=$outdir/$(dirname $tarfile)/.tmp_cpio_dir
> 
> 
> 
> Dot files are ignored.
> 'make clean' removes the .tmp_* pattern.

This sounds great.

Unfortunately 'make clean' only cleans files and not directories based
on this pattern.

Should it be extended?

> > ---
> > Changes in v2:
> > - Also add the directory to clean-files
> > - Link to v1: https://lore.kernel.org/r/20230117-kernel-kheaders-gitignore-v1-1-2a3a070efd0d@weissschuh.net
> > ---
> >  kernel/.gitignore | 1 +
> >  kernel/Makefile   | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/.gitignore b/kernel/.gitignore
> > index c6b299a6b786..57ab1d703763 100644
> > --- a/kernel/.gitignore
> > +++ b/kernel/.gitignore
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  /config_data
> >  /kheaders.md5
> > +/kheaders_data.tar.xz.tmp/
> > diff --git a/kernel/Makefile b/kernel/Makefile
> > index 10ef068f598d..f3535944f635 100644
> > --- a/kernel/Makefile
> > +++ b/kernel/Makefile
> > @@ -156,4 +156,4 @@ quiet_cmd_genikh = CHK     $(obj)/kheaders_data.tar.xz
> >  $(obj)/kheaders_data.tar.xz: FORCE
> >         $(call cmd,genikh)
> >
> > -clean-files := kheaders_data.tar.xz kheaders.md5
> > +clean-files := kheaders_data.tar.xz kheaders.md5 kheaders_data.tar.xz.tmp
> >
> > ---
> > base-commit: d532dd102151cc69fcd00b13e5a9689b23c0c8d9
> > change-id: 20230117-kernel-kheaders-gitignore-f0d73456cb6b
> >
> > Best regards,
> > --
> > Thomas Weiﬂschuh <linux@weissschuh.net>
