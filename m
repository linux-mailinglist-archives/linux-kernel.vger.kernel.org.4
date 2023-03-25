Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE62E6C8ED9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 15:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCYObg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 10:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjCYObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 10:31:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906D893E1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 07:31:31 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32PEVM7C019916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 10:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679754683; bh=E/Q0Dns4Xprje0tWgO+Ep/MJNHz4yFU8nAFLlBYNasc=;
        h=Date:From:To:Cc:Subject;
        b=gAI1hShRvKaLuwrG5ybuKXj3wEbd0VNTFRhMLUKadhiC6DKRcEHm+gDcDRk+04Yfs
         Bk3rmMmPoxNIt7foUCeGtGOdA79DrDonhMSRw+Iy1T/1LZSHFJ+4hiKI3QsPeP8osv
         kG/Pj1bM2hH11QemoUrhYP7VLUSoHiuXIf92NHHxK6sAHp6pFv0ntc8R+FPxE0b4ke
         bByDiqpJqSuhE6v+w+bawUX+OV7hYq800pjq6F0mXS5tA7quIXXKcoOSqdDqooBgLL
         ByrGKoMYCIcW/+DEEWGR8d+OjoStUHOtRMygd46dgNDkEUV2TNKAghqS/JUetkHlfa
         ZYixnX+9YsFXA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 70D7615C46FF; Sat, 25 Mar 2023 10:31:22 -0400 (EDT)
Date:   Sat, 25 Mar 2023 10:31:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Change in kernel debian packages between -rc2 and -rc3
Message-ID: <20230325143122.GA409315@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

It appears that there is a backwards-incompatible (and, I believe,
incorrect) change in the package version used when generated Debian
packages between 6.2-rc2 and 6.2-rc3.

I have CONFIG_LOCALVERSION set in my .config:

   CONFIG_LOCALVERSION="-xfstests"

As a result, the uname -a of a kernel that I build contains -xfstests,
e.g:

root@kvm-xfstests:~# uname -r
6.3.0-rc3-xfstests-00043-g463f2e46bf7c

Previously this would be correctly reflected in the Debian package
version:

% dpkg -I /build/linux-image-6.3.0-rc2-xfstests_6.3.0-rc2-xfstests-1016_amd64.deb 
...
 Package: linux-image-6.3.0-rc2-xfstests
 Source: linux-6.3.0-rc2-xfstests
 Version: 6.3.0-rc2-xfstests-1016
...

However, after -rc3, the CONFIG_LOCALVERSION is no longer present in the package version:

% dpkg -I /build/linux-image-6.3.0-rc3-xfstests-00043-g463f2e46bf7c_6.3.0-rc3-00043-g463f2e46bf7c-1017_amd64.deb 
...
 Package: linux-image-6.3.0-rc3-xfstests-00043-g463f2e46bf7c
 Source: linux-6.3.0-rc3-xfstests-00043-g463f2e46bf7c
 Version: 6.3.0-rc3-00043-g463f2e46bf7c-1017
...

Note the missing "-xfstests" in the above Version.  This also shows up
in the name of the .deb file which is generated, and this is breaking
my kernel build script[1].

[1] https://github.com/tytso/xfstests-bld/blob/master/kernel-build/kbuild

I assume the problem is caused by one of these two commits:

36862e14e316 ("kbuild: deb-pkg: use dh_listpackages to know enabled packages")
b611daae5efc ("kbuild: deb-pkg: split image and debug objects staging out into functions")

As these are the two commits which touch the builddeb script.

Could you please take a look?

Many thanks,

						- Ted
