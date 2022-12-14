Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C47D64D2A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLNW54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLNW5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:57:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83D83FBA6;
        Wed, 14 Dec 2022 14:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2gX4sFjvDWEUwJpttM2Adg/eT+pwcThP0yvnDfnww2Y=; b=x/0Nk3J/dJheHJxjaXCg5CNcGR
        IlvArTmiOcPAEYl91M02roY0UXAO1BbSMvkn8DRmkZ8TCEfLViB12m1oJ8xGIX4oc8SL0z2eOTnFL
        5UIHmF8S2H5sjfAj50AePsL3TRvxMom3hgSjCTQDP2iPVMd6McjzrSMzAbQFmHFUdWJgT1O4d+lO6
        ZZBqx9igGDjrzsDx3DtO9jFDj8z+0c5RA8l0T7GAeGZQ3wiMFzuKGKe1WIEupkQVbcvQ1+vjng2Cc
        U/6cztuyPGwf129cMWtUCq3ezzye4XIJWLECN6G0UMsBZ/dphVxUC+bBxEYfIc+P4Nxd2dGH1tInS
        YEblS+PA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5agz-003xzW-HW; Wed, 14 Dec 2022 22:57:37 +0000
Date:   Wed, 14 Dec 2022 14:57:37 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave@stgolabs.net,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: fix null dereference on probe for missing
 ACPI_COMPANION()
Message-ID: <Y5pU4XTchSKVqkjx@bombadil.infradead.org>
References: <20221209062919.1096779-1-mcgrof@kernel.org>
 <63937afd72956_579c1294eb@dwillia2-xfh.jf.intel.com.notmuch>
 <6393a3a9d2882_579c1294b3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y5kAt3WRgncTj26x@bombadil.infradead.org>
 <63991ec886e85_b05d1294a6@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63991ec886e85_b05d1294a6@dwillia2-xfh.jf.intel.com.notmuch>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 04:54:32PM -0800, Dan Williams wrote:
> Luis Chamberlain wrote:
> > On Fri, Dec 09, 2022 at 01:07:53PM -0800, Dan Williams wrote:
> > > Dan Williams wrote:
> > > > Luis Chamberlain wrote:
> > > > > Simply loading cxl_test ends up triggering a null pointer dereference
> > > > > on next-20221207, 
> > >
> > > Ok, my 6.1.0-rc8-next-20221208 build passed.
> > > 
> > > # meson test -C build --suite cxl
> > > ninja: Entering directory `/root/git/ndctl/build'
> > > [109/109] Linking target ndctl/ndctl
> > > 1/5 ndctl:cxl / cxl-topology.sh             OK              11.84s
> > > 2/5 ndctl:cxl / cxl-region-sysfs.sh         OK               6.82s
> > > 3/5 ndctl:cxl / cxl-labels.sh               OK              10.14s
> > > 4/5 ndctl:cxl / cxl-create-region.sh        OK              18.32s
> > > 5/5 ndctl:cxl / security-cxl.sh             OK               3.35s
> > 
> > What branch of ndctl do you use?
> 
> Yeah, somewhat unfair of me to say "works for me" with patches that had
> not yet been posted to the list. That's fixed now with this posting:
> 
> http://lore.kernel.org/r/167097752151.1189953.3189708700022130101.stgit@dwillia2-xfh.jf.intel.com

I b4 am'd this after my branch reset to the latest pending today.

> ...and this one that is now on the pending branch:
> 
> http://lore.kernel.org/r/167053487710.582963.17616889985000817682.stgit@dwillia2-xfh.jf.intel.com

Groovy thanks. Progress, but still fails now on the cxl-xor-region.sh line 29

https://gist.github.com/mcgrof/aeac639365a651bd77f143cf38eb7493

> > > So, what I suspect is happening is
> > 
> > <-- snip -->
> > 
> > Yes you're right.
> > 
> > > From 93bf2c04cd3a708c73c0e4ad7a4121505a0698da Mon Sep 17 00:00:00 2001
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > Date: Fri, 9 Dec 2022 13:04:26 -0800
> > > Subject: [PATCH] tools/testing/cxl: Prevent cxl_test from confusing production
> > >  modules
> > > 
> > > The cxl_test machinery builds modified versions of the modules in
> > > drivers/cxl/ and intercepts some of their calls to allow cxl_test to
> > > inject mock CXL topologies for test.
> > > 
> > > However, if cxl_test attempts the same with production modules,
> > > fireworks ensue as Luis discovered [1]. Prevent that scenario by
> > > arranging for cxl_test to check for a "watermark" symbol in each of the
> > > modules it expects to be modified before the test can run. This turns
> > > undefined runtime behavior or crashes into a safer failure to load the
> > > cxl_test module.
> > > 
> > > Link: http://lore.kernel.org/r/20221209062919.1096779-1-mcgrof@kernel.org [1]
> > > Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > 
> > Indeed that fixes the same crash. However that highlights a few other
> > issues.
> > 
> > 1) ndcl unit tests still fail once you do get the right driver loaded:
> >    a) pending branch fails on the first test and stops there
> >    b) main branch fails at the first test and continues and passes on
> >    the rest of the tests. What is with the discrepancy?
> > 
> > 2) The instructions on ndctl to use an external module are easily
> > misguiding folks on how to use external replacement modules, I'd like
> > to suggest a fix below.
> > 
> > Details below.
> [..]
> > 
> > Anyway I think we should simplify the ndctl README.md to just use
> > INSTALL_MOD_DIR follows, thoughts?
> 
> Hmm, but scripts/Makefile.modinst already has this:
> 
> INSTALL_MOD_DIR ?= extra
> 
> ...are you not getting these modules deployed in the "$modules/extra"
> directory, or is your distro not priortizing modules in that directory
> over the others? Fedora seems to have this policy by default, but it
> seems at least Ubuntu does not. That's what led to the discussion of a
> modprobe "override" policy in the Troubleshooting section of the README. 

I figured this was the assumption behind made. I'll very well *aware* of
this situation, and no, developers *should not* assume everyone pegs
"extra" with for example a /etc/depmod.d/dist.conf with:

search updates extra built-in weak-updates

That is a distribution specific policy. The *updates* however *is*
picked up by upstream kmod *by default*, and so stuffing things into
extra just ensures ensures folks don't break things now by using extra...
unless they are on these distros that do use that...

But it was *only* redhat derivatives that used it. Fedora's cloud
vagrant image *does* not use it. And no developer should assume this
generally for all Linux distributions.

The *real* sensible thing to do would be to be very explicit about this
and have say:

/etc/depmod.d/cxl-mock.conf
search mock built-in

*But* then that would mean ndctl would have to carry installing this
*if* CXL tests are enabled. That also leave folks *not* using ndctl
without any clue about this issue and so if we wanted to just be super
lazy, we just use updates as that is built-in to the C code for depmod.c
on kmod.git *ifff* the distribution lacked *any* depmod.d file:

https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/tree/tools/depmod.c#n867

This has been there since the start on kmods since 2012. It's good
enough for me, as old tools likely would not be used for CXL capable
systems. Except maybe Android.

And so using "INSTALL_MOD_DIR=updates" seems better than having us get
ndctl into the business of installing a /etc/depmod.d/cxl-mock.conf.

This would also allow experimentations to see if the cxl_test mock
driver strategy could be replaced by a proper upstream kernel sefltests
driver.

> My concern with changing the INSTALL_MOD_PATH recommendation is whether
> having modules in "$modules/updates" is guaranteed to work in all
> distros. Otherwise we're just shuffling which distros need a custom
> override workaround.

All Linux distributions without *any* depmod.d file will work that use kmod.
Most Linux distributions has phased old module-utils for kmod a long time ago,
11 ago, the code for the old crap module-init-toolls hasn't been updated
for 11 years and specifically mentioned being replaced with libkmod
usage which is how kmod got started.

https://git.kernel.org/pub/scm/utils/kernel/module-init-tools/module-init-tools.git/

This is enough justification for me to simply replace the upstream
scripts/Makefile.modinst to default to updates instead of extra as well 
so I'll go ahead and just do that now and CC the list on the patch.

> > But this also raises the question of *if* using ndctl and linux-next
> > shoudl one use the main branch or the pending branch? Can there be
> > issues with synchronizing ? Or should the main branch always work,
> > and the pending should just have the latest and greatest and *can*
> > fail?
> 
> This falls into the category of a "good problem to have" in the sense
> that I never had to worry before about others wanting to reproduce unit
> test results this early in the dev cycle, so I appreciate the nudge
> here.

Oh groovy, glad this is a step forward then :)

I know folks have been using run-qemu for a while and have mentioned how
it is still a bit difficult to ramp up with CXL, and so the goal here was
reduce barrier to entry even further by automating the hell out of the
entire process with modern automation tooling. Since kdevops did that
well for complex testing such as filesystem testing and block layer
testing I figured it'd be a good match to bring parity with CXL.

So this also should now enable folks who want to say, run tests with
qemu specific topologies too. It'd just be another guest on when
spawing, and so tests can be run in parallel for each different
topology.

> As to what to do about it, I am open to suggestions. The typical flow
> has some lag between upstream tools/testing/cxl/ changes and when the
> corresponding ndctl/cxl changes land. This is because the tool enabling
> does not start until after it is clear that the kernel changes are going
> to land. After that it's another round of review to settle on the tool
> changes. The ndctl/pending branch should usually be up to date by the
> time -rc1 arrives. Is that sufficient?

I think it would make sense to always assume that using the latest
tooling will not break anything and we should then be able to always
rely on it for all automationf or bleeding edge linux-next based
testing.

Tests however should then always look to see if a feature is available
and gracefully skip if not available / supported by the target kernel
being tested. This would then allow the *latest* ndctl and pending
branch to be relied on to test also even older kernels. That way, new
tests, but which can be useful for testing old kernels, can *also*
be enabled to test things on those old kernels.

And so the latest testing userspace scripts should *always* work with
*any* kernel. It should not assume you have the latest and greatest
respective cxl_test driver. Is that something we can count on today?

Then as a developer, one can assume / expect the latest and greatest
both tooling / testing will work regardless of the kernel.

That would mimic the experience with using tools/testing/selftests ,
even linux-next selftests are supposed to work on older kernels. The
respective old selftest modules would just be used if they were enabled
for the older kernel.

Then, a few questions, but while we're at it:

Do we have enough experience at this point to say what things should be
tested with the pair cxl_test / ndctl test suite and say what things
instead are probably better tested using qemu?

Are there tests, part of ndctl test suite which likely would be useful
for non cxl_test.ko usages, but rather run on spawned qemu / bare metal
CXL enabled systems, so one can just hammer on them?

  Luis
