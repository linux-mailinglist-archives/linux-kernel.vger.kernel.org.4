Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B46660AC3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjAGA3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjAGA3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:29:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617BD78A54;
        Fri,  6 Jan 2023 16:29:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04C2961FA5;
        Sat,  7 Jan 2023 00:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DD9C433D2;
        Sat,  7 Jan 2023 00:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673051386;
        bh=1qh4StPQoJHNaMEg5s/dkIyBI9C1tw3RS7081v3XOWw=;
        h=Date:From:To:Cc:Subject:From;
        b=KLIISFzNfw5gtTfwg9kmO+DXGIXmN3TuvnXCRVnLBtB2Ju9pqOr7aV8kJ9pK9k+JG
         9lHJEXnRo0fsAV1GXxTliEeyulo/dDOtkDN0wY2yNdD4iHti2W9MT+/1oyYFA0u6WJ
         Vb+d1WaPeB2cIqS6iRiVgz+rFsXNguKsvulObzstI08UjZKu8Jv8smlaZfmNVg/1Je
         fMDc0t3OwyfPehFdJDnHiqdyCPRuMaKsegu4fj6XODTzbDgYAK4FQL8S+gUKvU0PDn
         +vuVedYhvwtyCsvSpKvG9qGmi5UFApsqAGsCJvAaD9+VDxDcU6w6yGHi1hihhUDGyr
         QEHWHc7jY77RA==
Date:   Fri, 6 Jan 2023 17:29:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: nm vmlinux error in arch/arm reappears after upgrade to make 4.4
Message-ID: <Y7i8+EjwdnhHtlrr@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

My distribution recently updated their version of make to 4.4 from 4.3,
after which I notice the following error from nm when building ARCH=arm
kernels, which I thought that this was supposed to be resolved with
commit 3ec8a5b33dea ("kbuild: do not export LDFLAGS_vmlinux") but the
tree clearly has this and it is not visible while just running clean (I
have to build zImage to see it):

  $ git show -s --format='%h ("%s")'
  512dee0c00ad ("Merge tag 'x86-urgent-2023-01-04' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

  $ make --version | head -1
  GNU Make 4.4

  $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=build defconfig zImage
  arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux': No such file

vs.

  $ make --version | head -1
  GNU Make 4.3

  $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=build defconfig zImage

I bisected make to see what change causes this and I landed on
commit 98da874c ("[SV 10593] Export variables to $(shell ...)
commands") [1], which certainly seems like a reasonable commit to
blame but I am not sure how exactly it factors in here.

If you need any more information on reproducing this, I am happy to
provide it (CROSS_COMPILE is just the toolchains from kernel.org).

[1]: https://git.savannah.gnu.org/cgit/make.git/commit/?id=98da874c43035a490cdca81331724f233a3d0c9a

Cheers,
Nathan
