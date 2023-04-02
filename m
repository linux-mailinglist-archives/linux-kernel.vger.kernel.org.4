Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA16D3567
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 05:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDBDhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 23:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDBDhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 23:37:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2906518FB6
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 20:37:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3323bU3u028074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Apr 2023 23:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1680406651; bh=qAsrzmj7/kad1P6cbuZ6kJUzmtGwZZtOex6p18MMEME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lJfWxuqoKoGx6cQg0ESsATw8eYJnWBYqyOJHaV1hB86WOTK4bJ98HEVCu0x8ninox
         sGgLb0ZO+O8dBFG/MUKinZyYFYhVeEbaybWGIXGJRIZwnLvL63+pPBa9oqkZfWMsBY
         gL3MFbjHhNiOWEVJMewuR+99cC1pN20uqHJTowTfH+tz/RFB4xZj04FBlamHHU/C+R
         4LcPlqwpxegHytBCUTLn2mtQihzNg9Nh1K/BxrgRKwQy245cnXkRrmUCM/Lke18XXH
         9yyZMMtaigCHcaiF4LiBHBPkWixYp+3VAc33cZZ8H/ctTREhYS7GWcYulZTepgrYEO
         RtOabtD/58+pw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D4E3F15C5253; Sat,  1 Apr 2023 23:37:29 -0400 (EDT)
Date:   Sat, 1 Apr 2023 23:37:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Change in kernel debian packages between -rc2 and -rc3
Message-ID: <20230402033729.GA619325@mit.edu>
References: <20230325143122.GA409315@mit.edu>
 <CAK7LNARndpbtzRAW1kEiqyNBmAxdqJKiTquvY9bW08LYTTMiOg@mail.gmail.com>
 <20230326121118.GB323408@mit.edu>
 <CAK7LNARcUSsjzi7UV+rHHaQU1X-XJ0jN0sLAw2m=SypTQTCHKA@mail.gmail.com>
 <20230328040917.GC108653@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328040917.GC108653@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've worked around this in xfstests-bld.

					- Ted

commit e3309f769882397e605f956755dfec30f1f3f196
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sat Apr 1 23:22:09 2023 -0400

    kernel-build: work around backwards incompatible change in "make bindeb-pkg"
    
    Starting in v6.3-rc3, "make bindeb-pkg" made an incompatible change in
    how the debian package version is constructed, by dropping
    CONFIG_LOCALVERSION from the package version.  This might make sense
    given that Debian and Ubuntu try to adhere to Stable ABI nonsense with
    their Distribution kernels, but the default version chosen by "make
    bindeb-pkg" isn't compatible with the stable ABI nonsense versioning
    scheme in any case, so the change just breaks upstream developers for
    no good reason.
    
    Fix this by overriding the package version using KDEB_PKGVERSION,
    which is not documented, but hopefully it won't also incompatibly
    change in the future.  :-(
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/kernel-build/kbuild b/kernel-build/kbuild
index 16dfb7cd..4ab9ea28 100755
--- a/kernel-build/kbuild
+++ b/kernel-build/kbuild
@@ -153,7 +153,25 @@ rm -f "$BLD_DIR/linux-image.deb" "$BLD_DIR/linux-image-dbg.deb" \
 if test -n "$DO_DPKG" ; then
     $NO_ACTION make "${MAKE_ARGS[@]}" prepare
     REL=$(make "${MAKE_ARGS[@]}" kernelrelease | grep -v ^make)
-    $NO_ACTION time nice make "KDEB_SOURCENAME=linux-${REL}" "${MAKE_ARGS[@]}" \
+    MAJOR=$(echo $REL | awk -F. '{print $1}')
+    MINOR=$(echo $REL | awk -F. '{print $2}')
+    if test -f "$BLD_DIR/.version" ; then
+	NUM=$(cat "$BLD_DIR/.version")
+	# Starting in 6.1, how "make bindeb-pkg" handled the
+	# .version numbering randomly changed; accomodate that
+	# here.   Things are broken starting in 6.1-rc1 until 6.1-rc6
+	# but we won't worry about that here.  See commit
+	# 5db8face97f8 ("kbuild: Restore .version auto-increment behaviour
+	# for Debian packages") which fixed the problem but in a way
+	# which was different compared to how 6.0 and earlier kernels
+	# handled things.
+	if test "$MAJOR" -ge 6 -a "$MINOR" -ge 1 ; then
+	    NUM=$(( $NUM + 1 ))
+	fi
+    else
+	NUM=1
+    fi
+    $NO_ACTION time nice make "KDEB_PKGVERSION=$REL-$NUM" "KDEB_SOURCENAME=linux-${REL}" "${MAKE_ARGS[@]}" \
 	 bindeb-pkg "$@"
     err=$?
     d="$BLD_DIR/.."
