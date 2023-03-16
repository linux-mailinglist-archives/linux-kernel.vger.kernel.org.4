Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981266BCCA8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjCPKYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjCPKYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:24:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD43C0839;
        Thu, 16 Mar 2023 03:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BAFD9CE1C19;
        Thu, 16 Mar 2023 10:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A7AC433EF;
        Thu, 16 Mar 2023 10:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678962139;
        bh=XycJsbQwQZu2+13LdXuNxAbfzBQS0vn5LqFbRiamWNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C85VM08oPm1N4YoszKWsBP9Go1Fbbbls7frCMrYy3jZQJ+m0+fFVj2IFC0lGkPMTB
         RXP8IlDv9H4KeuQgOQAjwf2Ro3nHC5bwKIcqXZJ2wy3jE27HR/oqtan/9WqOM1wIB9
         oACQonyljOduyNiNKn5+fjUe8QPo20EdGz8FlheuI1Cyk8tDTcSvWcJXWmeFzCotuY
         1UkmVxeS8hCLHw75HCrFIw+VWCd0nUD/7GrO4IzktdHYcZZO1pVUwIXNPGols7/sfe
         cj5xuhXSukwOn8X/Zbv+b4NK5+tqIkxRCQJ33G9szxlCf1HEub23gi2bi43ob2k8Ew
         saBv5tnj6KbFA==
Date:   Thu, 16 Mar 2023 12:22:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 0/6] kbuild: fix some packaging issues, and use
 git-archive for source package
Message-ID: <20230316102215.GA473089@unreal>
References: <20230312200731.599706-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230312200731.599706-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 05:07:25AM +0900, Masahiro Yamada wrote:
> This series fixes some bugs, then switch to 'git archive'
> for source package creation as suggested by Linus.
>=20
>=20
>=20
> Masahiro Yamada (6):
>   kbuild: deb-pkg: make debian source package working again
>   kbuild: deb-pkg: do not take KERNELRELEASE from the source version
>   kbuild: deb-pkg: set CROSS_COMPILE only when undefined
>   kbuild: deb-pkg: split image and debug objects staging out into
>     functions
>   kbuild: deb-pkg: use dh_listpackages to know enabled packages
>   kbuild: use git-archive for source package creation


I tried this series and got the following error:
11:05:53  Install lsb-release or set $KDEB_CHANGELOG_DIST explicitly
11:05:53  dpkg-buildpackage: info: source package linux-upstream
11:05:53  dpkg-buildpackage: info: source version 6.3.0-rc2-gdc71b1b23e6d-1
11:05:53  dpkg-buildpackage: info: source distribution unstable
11:05:53  dpkg-buildpackage: info: source changed by root <root@5621c2cf448=
d>
11:05:53  dpkg-buildpackage: info: host architecture arm64
11:05:53   dpkg-source --before-build .
11:05:53  dpkg-source: info: using options from linux/debian/source/local-o=
ptions: --diff-ignore --extend-diff-ignore=3D.*
11:05:53  dpkg-checkbuilddeps: error: Unmet build dependencies: debhelper
11:05:53  dpkg-buildpackage: warning: build dependencies/conflicts unsatisf=
ied; aborting
11:05:53  dpkg-buildpackage: warning: (Use -d flag to override.)
11:05:53  make[1]: *** [scripts/Makefile.package:117: deb-pkg] Error 3
11:05:53  make: *** [Makefile:1656: deb-pkg] Error 2

Thanks


>=20
>  .gitignore                       |    1 +
>  Makefile                         |    9 +-
>  scripts/.gitignore               |    1 -
>  scripts/Makefile                 |    2 +-
>  scripts/Makefile.package         |  113 ++--
>  scripts/check-git                |   14 +
>  scripts/list-gitignored.c        | 1057 ------------------------------
>  scripts/package/builddeb         |  269 ++++----
>  scripts/package/deb-build-option |   14 +-
>  scripts/package/gen-diff-patch   |   44 ++
>  scripts/package/mkdebian         |   24 +-
>  scripts/package/mkspec           |   17 +-
>  scripts/setlocalversion          |   45 +-
>  13 files changed, 335 insertions(+), 1275 deletions(-)
>  create mode 100755 scripts/check-git
>  delete mode 100644 scripts/list-gitignored.c
>  create mode 100755 scripts/package/gen-diff-patch
>=20
> --=20
> 2.34.1
>=20
