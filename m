Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA166DF78
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjAQNx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjAQNxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:53:04 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B1A3C2A3;
        Tue, 17 Jan 2023 05:52:12 -0800 (PST)
Date:   Tue, 17 Jan 2023 13:52:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1673963530;
        bh=3rWEGZOUr60uGBv8riGkTZ/UN/j6SPZdmfmhK0SEaZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMfmUovDF3e2N8f2jfQJ+AZV9Ba5ItyUVHG253dDNK0QMuxDhlc1DFuSeRjp/HVDa
         cudbwzK6hLNQMNfHTX/+DKHP/arFWKO62LwsSVH7f9O8Q73v62WIojRJZQWsyVgB5S
         eYGAzif4b1GHCTUOv+OcD46XEkaNxp4u9YWZ+Pqo=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Nicolas Schier <n.schier@avm.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kernel/.gitignore: ignore temporary kheaders_data
 directory
Message-ID: <20230117135208.pyyziocg7kc25vfy@t-8ch.de>
References: <20230117-kernel-kheaders-gitignore-v1-1-2a3a070efd0d@weissschuh.net>
 <Y8ZdGIDj+0nSqjkF@buildd.core.avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8ZdGIDj+0nSqjkF@buildd.core.avm.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:34:01AM +0100, Nicolas Schier wrote:
> On Tue, Jan 17, 2023 at 05:15:25AM +0000, Thomas Weiﬂschuh wrote:
> > If the kheaders archive generation is interrupted then this directory
> > may be left. Ignore it, it will be deleted by the next run of
> > kernel/gen_kheaders.sh.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > ---
> >  kernel/.gitignore | 1 +
> >  1 file changed, 1 insertion(+)
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
> 
> What about removing the temporary directory on failure instead?  E.g.:
> 
> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index 473036b43c83..c656b72a3cdc 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -61,6 +61,8 @@ echo "  GEN     $tarfile"
>  rm -rf $cpio_dir
>  mkdir $cpio_dir
>  
> +trap "rm -rf ${cpio_dir}" EXIT
> +
>  if [ "$building_out_of_srctree" ]; then
>         (
>                 cd $srctree
> 
> 
> Otherwise, I'd suggest to extent this .gitignore patch by also adding
> 
>    clean-files += kheaders_data.tar.xz.tmp/
> 
> to kernel/Makefile.

Thanks for the suggestions.
I went with the clean-files aproach.
This allows the introspection of the directory on errors and seems to
match what is done elsewhere.

Thomas
