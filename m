Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CCB6523E9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiLTPqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLTPq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:46:26 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B52C5;
        Tue, 20 Dec 2022 07:46:24 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nc19M0047z6H6hp;
        Tue, 20 Dec 2022 23:44:54 +0800 (CST)
Received: from localhost (10.81.208.216) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 15:46:21 +0000
Date:   Tue, 20 Dec 2022 15:46:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cxl_test: upgrade as a first class citizen selftests
 capable driver
Message-ID: <20221220154620.000003b2@Huawei.com>
In-Reply-To: <Y6Crh5DiGPPzKoYp@bombadil.infradead.org>
References: <20221217034947.1174795-1-mcgrof@kernel.org>
        <639d4bb71bada_b41e329452@dwillia2-xfh.jf.intel.com.notmuch>
        <20221218160824.0000583d@Huawei.com>
        <Y6Crh5DiGPPzKoYp@bombadil.infradead.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.208.216]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Mon, 19 Dec 2022 10:20:55 -0800
Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Sun, Dec 18, 2022 at 04:08:24PM +0000, Jonathan Cameron wrote:
> > QEMU based CI should go two ways:
> > 1) QEMU CI would typically pin particular kernel version and verify that
> >    QEMU changed don't break that. If we need new features for a new test,
> >    we move that kernel version used.  Existing tests should never break
> >    against a fixed kernel version as that's a regression in QEMU (or
> >    maybe a bug elsewhere) Ultimately we should have this running in the
> >    normal QEMU gitlab CI.  
> 
> Sounds sensible.
> 
> > 2) Kernel CI against QEMU would typically pin particular QEMU version
> >    and check that kernel changes don't break.  This will have rough edges
> >    for a while yet as we are still adding mandatory features to the QEMU
> >    emulation (e.g. events support).  Again, as we add new features / tests
> >    may need to move the QEMU version forwards to support them.  
> 
> Sure - but for this today other than ensuring a kernel does not crash upon
> bootup we also have cxl_test, but not much else.
> 
> We'll want to exand a set of target tests on CXL enabled nodes, without
> cxl_test. Other than verifying the topology matches, we'll want to start
> mimicking actual use cases / performance stuff.

Definitely good to mimic usecases, but in using the QEMU emulation,
performance is probably not sensible as there are some horrible slow
paths in the emulation such as how we do interleaving.  Could be
improved with some caching of look ups, but the result wouldn't look
much like real devices.

Doing it on a limited set of hardware is viable, but it'll be a while
before we have all the fun options available.

> 
> > I don't think we much care about backwards compatibility so once we've
> > moved the pinned element forwards in the above, we won't care about the
> > old version.   
> 
> Making tests simply skip if the feature is not available doens't take
> much effort but forward thinking.
> 
> > The aim here isn't really to ensure no regressions when
> > running on QEMU (though that CI is nice to have), but more that we have
> > no problems in kernel side of things.  
> 
> Sure.
> 
> > This is a way off yet.  Not seeing this as being part of linux.git.
> > The QEMU CI stuff will be in the qemu.git and Kernel CI stuff probably
> > sit out of tree - there shouldn't be a tight coupling beyond new tests
> > wanting to check available features etc. I might ask a friendly
> > CI project to add this to their normal runs.  
> 
> OK in case it helps, cxl-enabled qemu building bringup / ndctl building
> and install is all now automated and integratead as part of kdevops so
> patches welcomed to expand that coverage.

Excellent.  I'll take a look at kdevops sometime next year.

> 
> > I don't have strong feelings on cxl_test. Tend not to use it myself
> > and haven't yet contributed to it.  
> 
> Thanks, this is useful information.

Different approaches. I can appreciate cxl_tests usecase, but I've mostly been hacking
on the corners that are tricky to test with a mocking driver and
it's easy to hack stuff into the QEMU emulation (for me - now :)

Jonathan

> 
>   Luis

