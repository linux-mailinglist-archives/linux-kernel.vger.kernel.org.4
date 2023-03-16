Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B001C6BC6A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjCPHMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCPHMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:12:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9D5AE118;
        Thu, 16 Mar 2023 00:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FC2DB81F97;
        Thu, 16 Mar 2023 07:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05DCC433EF;
        Thu, 16 Mar 2023 07:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678950652;
        bh=pDFZd/3lMU4AigRONP+Aw8yH34433TzuxG5TNmkmRSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0qA/OpIpWpj3LiLXqqh3b0MNidwt9PVW7EIoa5Q+HBk0bo/Y/CfZ8x/yc/Z0413q
         Opo7a0+fPSsOi88Bsp2nKZ6WpzOrDKXSDYis3RKPMaMJio1M7/nNuhjc3A/A25x6IN
         H8FF7TvutH/L5NA/pKWpKG1bg0zaTivCbmdy27VEhtQE0KUU3/P67dngEn+PMhSPco
         8ZsbknMxg+rEFYo7rbRzVtAmbUOxU4FeTzbXurB31qtJKcWX4lpLEvXLAJiXvQVvLD
         dnV3QpY1HWP+HqUovlrzflnEhU+2GkPrRR0NPRHPoBlwM2uaIP1I3kaGzbOeV1VP0Y
         XpxYgy6QIgKNw==
Date:   Thu, 16 Mar 2023 09:10:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riad Abo Raed <riada@nvidia.com>
Subject: Re: [PATCH -rc] kbuild: properly exclude linux.tar.gz from tar
 archive
Message-ID: <20230316071047.GU36557@unreal>
References: <e0b06d9aa9f37156c4317f9915a7a0e247edb70f.1678907179.git.leon@kernel.org>
 <ZBIoACq0+FGN4752@bergen.fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBIoACq0+FGN4752@bergen.fjasle.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 09:18:08PM +0100, Nicolas Schier wrote:
> On Wed 15 Mar 2023 21:09:33 GMT, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Attempt to build rpm-pkg randomly fails in tar stage, with same error
> > as was reported by Nicolas [1]
> > 
> > tar -c -f linux.tar.gz -I pigz --exclude=./linux.tar.gz --exclude-from=.tmp_filelist_exclude --owner=0 --group=0 --sort=name --transform 's:^\.:linux:S' -C . .
> > tar: .: file changed as we read it
> > make[1]: *** [scripts/Makefile.package:58: linux.tar.gz] Error 1
> > make[1]: *** Deleting file 'linux.tar.gz'
> > make: *** [Makefile:1657: rpm-pkg] Error 2
> > 
> > The reason to it that tar is dependent on order of command line
> > arguments and needs to have excluded file before creating it. So as a
> > solution, touch that file to create it and move --exclude list before
> > any tar arguments.
> 
> thanks for digging into and proposing a solution!  I'm afraid it will 
> not be taken because of [2] will make the whole cmd_tar definition 
> redundant due to the use of 'git archive'.

OK, good to know.

> 
> Nevertheless, this works for me.
> 
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

Thanks

> 
> Kind regards,
> Nicolas
> 
> 
> [2]: https://lore.kernel.org/linux-kbuild/20230312200731.599706-7-masahiroy@kernel.org/
> 
> > [1] https://lore.kernel.org/all/Y%2Fk+v%2FYj8VQ6q32H@fjasle.eu/
> > Cc: Nicolas Schier <nicolas@fjasle.eu>
> > Fixes: 7bf4582d7aad ("kbuild: deb-pkg: create source package without cleaning")
> > Signed-off-by: Riad Abo Raed <riada@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  scripts/Makefile.package | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> > index b941e6341b36..be4623481ca2 100644
> > --- a/scripts/Makefile.package
> > +++ b/scripts/Makefile.package
> > @@ -44,7 +44,7 @@ filechk_filelist = \
> >  # ---------------------------------------------------------------------------
> >  
> >  quiet_cmd_tar = TAR     $@
> > -      cmd_tar = tar -c -f $@ $(tar-compress-opt) $(tar-exclude-opt) \
> > +      cmd_tar = touch ./$@ && tar $(tar-exclude-opt) -c -f $@ $(tar-compress-opt) \
> >                  --owner=0 --group=0 --sort=name \
> >                  --transform 's:^\.:$*:S' -C $(tar-rootdir) .
> >  
> > -- 
> > 2.39.2
> 
> -- 
> Nicolas Schier
>  
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> ↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --


