Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1655B65043C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 18:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiLRRow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 12:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiLRRo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 12:44:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43CBD6CA3;
        Sun, 18 Dec 2022 08:46:25 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NZnlw0Q8Bz67Q1W;
        Mon, 19 Dec 2022 00:07:08 +0800 (CST)
Received: from localhost (10.81.208.178) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 18 Dec
 2022 16:08:28 +0000
Date:   Sun, 18 Dec 2022 16:08:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cxl_test: upgrade as a first class citizen selftests
 capable driver
Message-ID: <20221218160824.0000583d@Huawei.com>
In-Reply-To: <639d4bb71bada_b41e329452@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221217034947.1174795-1-mcgrof@kernel.org>
        <639d4bb71bada_b41e329452@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.208.178]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 20:55:19 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Luis Chamberlain wrote:
> > To unit test CXL today we make use of the ndctl meson test suite but
> > this requires the cxl_test driver. There is however is no kconfig option
> > for this driver as its required to be built as an external driver. To
> > debug CXL with this framework is not inuitive as it departs itself from
> > typical Linux kernel development debugging processes, requiring an
> > external module build which also happens to *rebuild* all CXL related
> > production drivers with some new magic incantations, and replacing
> > your production CXL modules with the new ones.
> > 
> > This is quite complex, departs ourselves from the typical build/boot
> > debugging process most folks are used to, and requires a manual error-prone
> > process which in some kernels / configurations can leads up to a kernel
> > crash [0].
> > 
> > We can replace this by having the requirements be defined through proper
> > kconfig symbols and having the cxl_test driver and requirements also become
> > part of the standard Linux kernel build process. This matches most other
> > kernel kernel debugging frameworks for subsystems, which don't require any
> > external modules.
> > 
> > Let's review the current strategy today, first, so nothing is lost:
> > 
> >   * one must manually *build*, and then as a second step install
> >     the cxl_test driver as an external modules:
> > 
> >     make M=tools/testing/cxl/
> >     sudo M=tools/testing/cxl/ modules_install
> > 
> >     Provided your depmod.d was configured correctly on your Linux
> >     distribution you will end up with a complete set of CXL production
> >     modules and cxl_test mock drivers to let you now use the ndctl
> >     test suite. To be clear, you will not only end up with cxl_test
> >     but also with a complete set of module replacements for your CXL
> >     environment.
> > 
> >     This works by:
> > 
> >     a) allowing the external module to re-define the __mock macro
> >        to __weak, used on to_cxl_host_bridge() and allows the mock driver
> >        to provide a replacement for that single call.
> > 
> >     b) the external module build process *rebuilds* all production
> >        modules *again* but uses the the binutils --wrap=symbol
> >        feature [0] [1] to let the production CXL code use the mocked up
> >        CXL features.
> > 
> > We can simplify all this considerably and do away with the external
> > modules requirements. The __mock stuff is raplaced by addressing the
> > to_cxl_host_bridge() mapping using a define based on your kernel
> > configuration. If using the production code you use the produciton
> > __to_cxl_host_bridge(), otherwise mock_to_cxl_host_bridge() will be
> > used. This is the *only* eyesore in the CXL code to enable use of the
> > mock driver.
> > 
> > The magic --wrap=symbol incantations are also just tucked in a new
> > production drivers/cxl/Makefile.mock which is only read when the kernel
> > has been configured for debugging using the CXl mock framework.
> > 
> > The last bit of work left is to move as built-in code shared code
> > between a production environment (non-debugging) and between what is
> > needed for the same code to run when doing mock debugging. Today the
> > requirements are small:
> > 
> >   * The code to implement to_cxl_host_bridge()
> >   * When mock debugging is enabled, just the code we need to
> >     support mock_to_cxl_host_bridge()
> > 
> > For both cases this is needed you have CXL_ACPI enabled.
> > 
> > In the future if we wanted to then now use the kernel selftests,
> > for example a tools/testing/sefltests/cxl/ directory, we can easily
> > do so. This also enables us to separate out unit tests out from the
> > ndctl tree and allow unit tests to also be developed and written
> > upstream on the kernel.
> > 
> > Another benefit of this approach is that there is no bit rot,
> > in the sense that now bots can go willy nilly test building this
> > code, whereas before only those who knew the proper incantations
> > actually were building this code and loading it properly.
> > 
> > [0] https://lkml.kernel.org/r/20221209062919.1096779-1-mcgrof@kernel.org
> > [1] https://sourceware.org/binutils/docs-2.23.1/ld/Options.html#index-g_t_002d_002dwrap_003d_0040var_007bsymbol_007d-263
> > [2] https://lwn.net/Articles/558106/
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> > 
> > What do folks think?
> > 
> > The test results:
> > 
> > https://gist.github.com/mcgrof/2ab7f1601141faa5ac7b16240b4ea652
> > 
> > The summary of test results:
> > 
> > Summary of Failures:
> > 
> > 1/5 ndctl:cxl / cxl-topology.sh      FAIL             0.50s   exit status 1
> > 2/5 ndctl:cxl / cxl-region-sysfs.sh  FAIL             0.44s   exit status 1
> > 5/5 ndctl:cxl / cxl-xor-region.sh    FAIL             0.45s   exit status 1  
> 
> At least for me the presented rationale and these results leaves me
> cold. Yes, there are sharp edges but 0day groks this scheme when it runs
> tools/testing/nvdimm/ (nfit_test) tests. The run_qemu script automates
> cxl_test and nfit_test this as well. So the complexity has not proven
> prohibitive. In the case of tools/testing/nvdimm/ it has not proven
> prohibitive for years. In other words the suggestion that the current
> organization ultimately leads to bit rot has not been substantiated in
> practice.
> 
> The proposed direction to move tests out of the ndctl.git repo into the
> kernel solves the wrong problem. It overlooks the fact that the tests
> are more tightly coupled to libcxl changes than kernel changes. So in
> terms of benefits of code being colocated, tests + libcxl + tools in the
> same repo is more impactful than tests + kernel in the same repo.
> 
> I know Jonathan has some latent ideas about building up a CXL regression
> suite on top of QEMU, but even there it's not clear that would benefit
> from being developed in linux.git given the tight coupling to QEMU.git.

QEMU based CI should go two ways:
1) QEMU CI would typically pin particular kernel version and verify that
   QEMU changed don't break that. If we need new features for a new test,
   we move that kernel version used.  Existing tests should never break
   against a fixed kernel version as that's a regression in QEMU (or
   maybe a bug elsewhere) Ultimately we should have this running in the
   normal QEMU gitlab CI.
2) Kernel CI against QEMU would typically pin particular QEMU version
   and check that kernel changes don't break.  This will have rough edges
   for a while yet as we are still adding mandatory features to the QEMU
   emulation (e.g. events support).  Again, as we add new features / tests
   may need to move the QEMU version forwards to support them.

I don't think we much care about backwards compatibility so once we've
moved the pinned element forwards in the above, we won't care about the
old version.  The aim here isn't really to ensure no regressions when
running on QEMU (though that CI is nice to have), but more that we have
no problems in kernel side of things.

This is a way off yet.  Not seeing this as being part of linux.git.
The QEMU CI stuff will be in the qemu.git and Kernel CI stuff probably
sit out of tree - there shouldn't be a tight coupling beyond new tests
wanting to check available features etc. I might ask a friendly
CI project to add this to their normal runs.

I don't have strong feelings on cxl_test. Tend not to use it myself
and haven't yet contributed to it.

Jonathan

> 
> > 
> > Ok:                 2   
> > Expected Fail:      0   
> > Fail:               3   
> > Unexpected Pass:    0   
> > Skipped:            0   
> > Timeout:            0  
> > 
> > I don't quite get the failures yet, but hey it's a start.
> > This commit depends on Dan's patch:
> > 
> > https://lkmll.kernel.org/r/6393a3a9d2882_579c1294b3@dwillia2-xfh.jf.intel.com.notmuch
> > 
> > But I can build another RFC if folks want without it.
> > 
> >  drivers/cxl/Kconfig                           | 23 +++++++
> >  drivers/cxl/Makefile                          |  2 +
> >  drivers/cxl/Makefile.mock                     | 15 +++++
> >  drivers/cxl/acpi.c                            | 13 ----
> >  drivers/cxl/core/Makefile                     |  4 ++
> >  drivers/cxl/core/acpi.c                       | 30 +++++++++
> >  drivers/cxl/cxl.h                             | 19 +++---
> >  lib/Kconfig.debug                             |  8 +++
> >  lib/Makefile                                  |  1 +
> >  lib/test_cxl/Makefile                         | 13 ++++
> >  lib/test_cxl/acpi.c                           | 28 +++++++++
> >  lib/test_cxl/core.c                           | 37 +++++++++++
> >  .../testing/cxl/test => lib/test_cxl}/cxl.c   |  7 ---
> >  .../testing/cxl/test => lib/test_cxl}/mem.c   |  0
> >  .../testing/cxl/test => lib/test_cxl}/mock.c  | 30 ---------
> >  .../testing/cxl/test => lib/test_cxl}/mock.h  |  0  
>  
> I do not think cxl_test is suitable to ship as an in-tree capability, it
> is intentionally second class to keep test logic distinct from
> production code.

