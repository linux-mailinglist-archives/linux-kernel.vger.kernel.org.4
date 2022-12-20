Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13B6518F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 03:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiLTCom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 21:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTCok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 21:44:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3FF12D29;
        Mon, 19 Dec 2022 18:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BkBtj6+8JJfQ50Ok+f9pDixvDCZzWD7kJYCtgoKR9wc=; b=I8Z9FHoNOAuKlHDWk42AqrJ9KV
        r1NKhn/zMSDscGpZKKGvfdgjP/vhv2G+NFM8qb5qRPootNnSt4kUuYFZCIfHs02p+FsB+9JMuocBv
        l2U9VDoxJQ/3kGJ3PNlMPKJIyZSCVAvcoE6JB9JfkAOsIjeFKbSn3GLDTw37A3u/QfVBmCaRq11ex
        hIhUGulis+VRZPfhS4TTKF79kCxkKT064pnknKZ1/98BX+GWB3aiiww/tzeojnSt6CV5QPf6uTtSS
        pxCKf8ZX/cXZOo3HBjNgOWj05vwWGqk0/dLD03d9v5tVS9Ypt3DvlV0Sje5Ngh9FZMyojDsArseZ0
        aVgsJIKQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7ScF-007fgf-MJ; Tue, 20 Dec 2022 02:44:27 +0000
Date:   Mon, 19 Dec 2022 18:44:27 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave@stgolabs.net,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] cxl_test: upgrade as a first class citizen selftests
 capable driver
Message-ID: <Y6Ehi2ihIgQd/aoR@bombadil.infradead.org>
References: <20221217034947.1174795-1-mcgrof@kernel.org>
 <639d4bb71bada_b41e329452@dwillia2-xfh.jf.intel.com.notmuch>
 <Y6DDPGnwszUAiNh2@bombadil.infradead.org>
 <63a1015e6ec4a_1bf22944c@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a1015e6ec4a_1bf22944c@dwillia2-xfh.jf.intel.com.notmuch>
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

On Mon, Dec 19, 2022 at 04:27:10PM -0800, Dan Williams wrote:
> Luis Chamberlain wrote:
> > On Fri, Dec 16, 2022 at 08:55:19PM -0800, Dan Williams wrote:
> > > In other words the suggestion that the current
> > > organization ultimately leads to bit rot has not been substantiated in
> > > practice.
> > 
> > On top of this patch I just added a custom debug patch to my tree which
> > enables CXL_BUS and CXL_TEST by default when this is currently allowed
> > and it got quite a bit of kernel build warnings. Although some of these
> > are specific to my change, some of them do not seem to be related to
> > that and likely could benefit from fixing:
> > 
> > https://gist.github.com/mcgrof/73dce72939590c6edc9413b0384ae4c2
> > 
> > And so although you may not see some build warnings so far, it does not
> > negate my suggestion that having cxl_test as a proper upstream driver strategy
> > gets you more build testing / coverage.
> 
> If autobuild coverage of test components is the main concern then
> cxl_test can copy what nfit_test is doing with CONFIG_NVDIMM_TEST_BUILD.
> No need for disruptive redesign of how this facility is integrated.

I've itemized a list of gains of having this properly integrated. What
gains are there of this being an external module other than a few folks
are used to it and it been done before for other subsystems?

> > > The proposed direction to move tests out of the ndctl.git repo into the
> > > kernel solves the wrong problem.
> > 
> > That's not in any way what I suggested and is not the point to my patch.
> > 
> > The proposed patch does not suggest to ditch ndctl unit tests but to
> > *enable* also sefltests to make use of cxl_test using the selftests
> > framework, which is very different. It is not saying "abandon" ndctl
> > unit tests, but rather, "also enable linux kernel selftests for CXL with
> > cxl_test".
> 
> I think centralizing test scripts is a virtue, and right now the
> momentum is with those located ndctl.git. This is why I jumped to the
> conclusion that the long term direction would be to pick one location
> for maintainer regression tests.

That's fine for ndctl unit tests.

> > But more importantly, it looks for the value of proper kernel
> > integration and making use of kconfig for the actual dependencies
> > and requirements. This is of high value.
> > 
> > In addition to this, one possible area I see of value with this change is the
> > ability to also use the wrap feature later, even without cxl_test to enable
> > error injection. What would this look like? You simply replace one built in
> > routine as you do with another which has sprinkled in should_fail() calls,
> > which otherwise would be an eyesore upstream. This shold also then not
> > depend the rest of cxl_test stuff, but can make use of building
> > alternative wrap routines which could be replacement for upstream ones.
> > 
> > Another benefit of this strategy is you can also test cxl_test *without*
> > the need for for requiring modules, which some folks prefer for testing.
> > At LSFMM this came up for instance and one of the biggest grudges with
> > testing some frameworks was the dependency on modules.
> 
> I do think this is the void that QEMU CXL testing would attempt to fill.

Not for error injection support. You need proper kernel support for that.

  Luis
