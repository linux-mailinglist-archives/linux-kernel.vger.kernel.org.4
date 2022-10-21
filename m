Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE286071CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJUIKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:10:26 -0400
X-Greylist: delayed 607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Oct 2022 01:10:21 PDT
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137DE143A7A;
        Fri, 21 Oct 2022 01:10:19 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri, 21 Oct 2022 10:00:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1666339207; bh=Abfw+d2JGvnwL2wwS4MezKuSIAL3W5ixCmweLNw8/zA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJdcCwutEZJ1VDisr+lxjtWwBjpacrE+GkIPq8Yasox0+9oe740wHRtilQrPIKQrL
         WRzG6si/TIhPvhMIDZudcqUJytOCCYk/qsfw0X7Fs99+2wUXFWpkA1ZbBFN/o8cVUQ
         82VFqlsY/umLZAULx7PwUx2/QPBleB3EuXQFeNxE=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id DCE86802E1;
        Fri, 21 Oct 2022 10:00:06 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id CF890181FCA; Fri, 21 Oct 2022 10:00:06 +0200 (CEST)
Date:   Fri, 21 Oct 2022 10:00:06 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com, corbet@lwn.net,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Documentation: kbuild: Add description of git for
 reproducible builds
Message-ID: <Y1JRhiAQ1bV/Dh7h@buildd.core.avm.de>
References: <20221020103823.31001-1-ashimida@linux.alibaba.com>
 <Y1FVphEyu23U0jho@debian.me>
 <8b2864bd-30b1-254f-ebd6-79967249da9b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b2864bd-30b1-254f-ebd6-79967249da9b@linux.alibaba.com>
X-purgate-ID: 149429::1666339206-2C7E6AFC-1139E621/0/0
X-purgate-type: clean
X-purgate-size: 2773
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:48:20PM -0700, Dan Li wrote:
> 
> 
> On 10/20/22 07:05, Bagas Sanjaya wrote:
> > On Thu, Oct 20, 2022 at 03:38:23AM -0700, Dan Li wrote:
> > > diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/kbuild/reproducible-builds.rst
> > > index 071f0151a7a4..13397f38c358 100644
> > > --- a/Documentation/kbuild/reproducible-builds.rst
> > > +++ b/Documentation/kbuild/reproducible-builds.rst
> > > @@ -119,6 +119,16 @@ To avoid this, you can make the vDSO different for different
> > >   kernel versions by including an arbitrary string of "salt" in it.
> > >   This is specified by the Kconfig symbol ``CONFIG_BUILD_SALT``.
> > > +Git
> > > +-----------------------
> > > +
> > > +Uncommitted changes or different commit ids in git can also lead
> > > +to different compilation results. For example, after executing
> > > +``git reset HEAD^``, even if the code is the same, the
> > > +``include/config/kernel.release`` generated during compilation
> > > +will be different, which will eventually lead to binary differences.
> > > +See ``scripts/setlocalversion`` for details.
> > > +
> > 
> > Briefly read the script, I don't see what the correlation between git
> > reset with LOCALVERSION thing is. Also, does the exact state of git
> > repository required for reproducible builds?
> > 
> 
> Hi Bagas,
> 
> The Makefile has the following code:
> filechk_kernel.release = \
>         echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
> 
> The output of setlocalversion affects kernel.release, while the output
> of setlocalversion is related to the state of git when the git repository
> exists (see function scm_version).
> 
> So changes in git state will result in changes to kernel.release, and
> this information will be included in the final output vmlinux/modules
> and in turn affect reproducible builds.
> 
> For example:
> $ git log
> commit 4cd155a93eec......
> $ make ...
> $ cat include/config/kernel.release
> 6.0.0-rc4-00025-g4cd155a93eec
> 
> $ git reset HEAD^
> $ git log
> commit 7b4d266b0c41......
> $ make ...
> $ cat include/config/kernel.release
> 6.0.0-rc4-00024-g7b4d266b0c41-dirty
> 
> 
> AFAICT, in the presence of a git repository, we can compile a reproducible
> build kernel in any git state, but we need to ensure that the git state is
> always the same between compilations (or the same from the perspective of
> the scm_version function).

yes, that definitely true.  Absence or presence of git tags can change
the output of setlocalversion even more drastically.

I think it is sensible to add a stanza about git in
Documentation/kbuild/reproducible-builds.rst.


Kind regards,
Nicolas
