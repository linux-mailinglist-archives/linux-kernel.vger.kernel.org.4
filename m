Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D5E6BCFE4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCPMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCPMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:50:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060938F705;
        Thu, 16 Mar 2023 05:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E8B6B82162;
        Thu, 16 Mar 2023 12:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE81C433D2;
        Thu, 16 Mar 2023 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678971044;
        bh=7mEY4ThNrR4d9SfVLU5NdH1TAuWZeD2RHHiXtguFDZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7vKYfz9Mb3I3fmb4NkKjh+qnOZL6xljZCJx1DYm/HKTBwbkBvX+/Rim+nSdGcqTJ
         zXreopi9HNFfqdLN0ajgAFBt2vOlL8b4cWfw5JrfSVy4E1ykbmK93PJOmpax7CmFw2
         hON3EAsRRy0h2qHyzr22oaSS/kTSW+PFUlZjzxAyLYej3xu1pjJFrVFFmbsx68pvSA
         /yEr5s11ezH9WdvLCX5Et1aFBJ9Rxg7dh7VifXvPW63xqOT6H+BtHqEBqFGchs0pun
         S2gR1+CzbEsJAJJ4uZ5WfbmkdL8Do04JsImpZnTRYW8YH+AIOjvv1Me2anQQ8XTUrM
         DfwkfDf18FsHQ==
Date:   Thu, 16 Mar 2023 14:50:39 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>
Subject: Re: [PATCH 0/6] kbuild: fix some packaging issues, and use
 git-archive for source package
Message-ID: <20230316125039.GW36557@unreal>
References: <20230312200731.599706-1-masahiroy@kernel.org>
 <20230316102215.GA473089@unreal>
 <ZBL8d1odNuLPs4zy@bergen.fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBL8d1odNuLPs4zy@bergen.fjasle.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:24:39PM +0100, Nicolas Schier wrote:
> On Thu 16 Mar 2023 12:22:15 GMT, Leon Romanovsky wrote:
> > On Mon, Mar 13, 2023 at 05:07:25AM +0900, Masahiro Yamada wrote:
> > > This series fixes some bugs, then switch to 'git archive'
> > > for source package creation as suggested by Linus.
> > > 
> > > 
> > > 
> > > Masahiro Yamada (6):
> > >   kbuild: deb-pkg: make debian source package working again
> > >   kbuild: deb-pkg: do not take KERNELRELEASE from the source version
> > >   kbuild: deb-pkg: set CROSS_COMPILE only when undefined
> > >   kbuild: deb-pkg: split image and debug objects staging out into
> > >     functions
> > >   kbuild: deb-pkg: use dh_listpackages to know enabled packages
> > >   kbuild: use git-archive for source package creation
> > 
> > 
> > I tried this series and got the following error:
> > 11:05:53  Install lsb-release or set $KDEB_CHANGELOG_DIST explicitly
> > 11:05:53  dpkg-buildpackage: info: source package linux-upstream
> > 11:05:53  dpkg-buildpackage: info: source version 6.3.0-rc2-gdc71b1b23e6d-1
> > 11:05:53  dpkg-buildpackage: info: source distribution unstable
> > 11:05:53  dpkg-buildpackage: info: source changed by root <root@5621c2cf448d>
> > 11:05:53  dpkg-buildpackage: info: host architecture arm64
> > 11:05:53   dpkg-source --before-build .
> > 11:05:53  dpkg-source: info: using options from linux/debian/source/local-options: --diff-ignore --extend-diff-ignore=.*
> > 11:05:53  dpkg-checkbuilddeps: error: Unmet build dependencies: debhelper
> > 11:05:53  dpkg-buildpackage: warning: build dependencies/conflicts unsatisfied; aborting
> > 11:05:53  dpkg-buildpackage: warning: (Use -d flag to override.)
> > 11:05:53  make[1]: *** [scripts/Makefile.package:117: deb-pkg] Error 3
> > 11:05:53  make: *** [Makefile:1656: deb-pkg] Error 2
> > 
> > Thanks
> 
> Do you have debhelper available on your system?  As debhelper is a 
> build dependency, such a fail is expected if debhelper is not 
> available.

Yes, we don't have debhelper in our build container. The thing is that
we are using same container as we used before this series and never needed
debhelper.

Thanks

> 
> Kind regards,
> Nicolas


