Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE0165DD17
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbjADTtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjADTt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:49:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF2A1C923;
        Wed,  4 Jan 2023 11:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5h44GyxCWISniKktCT90cH4QhD6riOrQVWIwvRCxzbw=; b=ZQWgrJE4XgyLf6kvLMp/aZLcVg
        sGN9Ds1J7FGcfssdBslD+0I7rd6hM5mADayyRpwSDX42lg1nBSGdc+b1D2hpcvM9Q/sIQvTEyj6LB
        ctHITxUAIWkYntx80OxJkYQcc2jZRkmYX1FiCYVmUmim5nghGSqocsmZzTRtnAh4njj02i9LDClIQ
        IU7Fy7nDrLR9nHtayba1dlYlVIteer6RXQi5GVbD/BtVEvwIM5EFnhFEa/6AjqCxdF0E344Jkgi2W
        yM/mDbl0YJ6GLEZZxQCAg/Ln/Z/l6ktv3IWnumLjal8QfJtJ2qrGHv0TJW38eA9vNEEk1vgJN7YwA
        ccWYdFEg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pD9lB-00BZm4-Qf; Wed, 04 Jan 2023 19:49:13 +0000
Date:   Wed, 4 Jan 2023 11:49:13 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave@stgolabs.net,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] cxl_test: upgrade as a first class citizen selftests
 capable driver
Message-ID: <Y7XYOfYjDM0v2SAy@bombadil.infradead.org>
References: <20221217034947.1174795-1-mcgrof@kernel.org>
 <639d4bb71bada_b41e329452@dwillia2-xfh.jf.intel.com.notmuch>
 <Y6DDPGnwszUAiNh2@bombadil.infradead.org>
 <63a1015e6ec4a_1bf22944c@dwillia2-xfh.jf.intel.com.notmuch>
 <Y6Ehi2ihIgQd/aoR@bombadil.infradead.org>
 <63a2124db0877_1bf229440@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a2124db0877_1bf229440@dwillia2-xfh.jf.intel.com.notmuch>
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

On Tue, Dec 20, 2022 at 11:51:41AM -0800, Dan Williams wrote:
> Luis Chamberlain wrote:
> > On Mon, Dec 19, 2022 at 04:27:10PM -0800, Dan Williams wrote:
> > > Luis Chamberlain wrote:
> > > > On Fri, Dec 16, 2022 at 08:55:19PM -0800, Dan Williams wrote:
> > > > > In other words the suggestion that the current
> > > > > organization ultimately leads to bit rot has not been substantiated in
> > > > > practice.
> > > > 
> > > > On top of this patch I just added a custom debug patch to my tree which
> > > > enables CXL_BUS and CXL_TEST by default when this is currently allowed
> > > > and it got quite a bit of kernel build warnings. Although some of these
> > > > are specific to my change, some of them do not seem to be related to
> > > > that and likely could benefit from fixing:
> > > > 
> > > > https://gist.github.com/mcgrof/73dce72939590c6edc9413b0384ae4c2
> > > > 
> > > > And so although you may not see some build warnings so far, it does not
> > > > negate my suggestion that having cxl_test as a proper upstream driver strategy
> > > > gets you more build testing / coverage.
> > > 
> > > If autobuild coverage of test components is the main concern then
> > > cxl_test can copy what nfit_test is doing with CONFIG_NVDIMM_TEST_BUILD.
> > > No need for disruptive redesign of how this facility is integrated.
> > 
> > I've itemized a list of gains of having this properly integrated. What
> > gains are there of this being an external module other than a few folks
> > are used to it and it been done before for other subsystems?
> 
> Your crash report is a prime example of why this needs to stay an
> external module. 

The crash *can* be avoided completely *iff* the semantics over the
requirements are expressed clearly through kconfig. My follow up patch
to the top level Makefile INSTALL_MOD_DIR to use "updates" instead of
"extra" essentially exposed anyone other than folks using a specific
version of RHEL or Fedora *easily* can end up crashing with cxl_test.
That's I think a far much worse predicament.

> Any redefinition of what a symbol does via --wrap= is a
> fragile proposition.

It is what cxl_test does though. Supporting it as a module Vs built-in
has no difference except as exposing semantics and requirements clearly.

> The fact that crash signatures with cxl_test loaded
> have the external module taint flag set is a feature.

I helped review the patch that added the taint flag for all testing
modules, that it does not mean we can't add it for built-in. This can
easily be done for instance with a kconfig symbol which pegs the taint
for any test module as built-in. In fact if we're not tainint built-in
test modules that change should happen anyway.

Having a test module be built-in or not shoud in no way shape or form
affect your testing. If the driver *happens* to rely on module load
and unload to any clean state machine -- that should be fixed given
the slew of bugs I have found other test modules which follow similar
logic.

> The --wrap= option
> has no business within the main tree 

If --wrap is really unreliable, the unreliable aspects should be
documented, however it seems in this case it is just seems for cxl
its only used for testing. And whether or not you test with built-in
or modules should have no effect over --wrap.

> because it violates the valid
> assumptions of other cxl_test-innocent developers.

By having cxl_test be a proper upstream driver you define the
requirements clearly, and the kconfig symbols enabled are sufficient
to only let that module be built if folks are ready to shoot themseves
on the foot. Today the semantics are not clear, and in fact relies on
a old distro INSTALL_MOD_DIR assumption.

> The benefit that resonated with me during this discussion was more
> compile test coverage for cxl_test components.

Those benefits still stand.

> However, that is achieved
> by tools/testing/cxl/ adopting the same compile coverage scheme that
> tools/testing/nvdimm/ has with CONFIG_NVDIMM_TEST_BUILD.

That does not by any means mean that CONFIG_NVDIMM_TEST_BUILD can also
be converted to allow built-in. In fact I'd argue the same for that too.
The same benefits applies there too.

  Luis
