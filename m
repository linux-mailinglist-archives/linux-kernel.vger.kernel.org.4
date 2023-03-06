Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BEA6AC5E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCFPt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCFPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:49:25 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A2C7DAB;
        Mon,  6 Mar 2023 07:49:21 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PVjfs0qMcz67Nm9;
        Mon,  6 Mar 2023 23:48:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 6 Mar
 2023 15:49:18 +0000
Date:   Mon, 6 Mar 2023 15:49:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Message-ID: <20230306154917.0000075e@Huawei.com>
In-Reply-To: <640218e217c80_5a3fc2947@iweiny-mobl.notmuch>
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
        <20230228224014.1402545-1-fan.ni@samsung.com>
        <346a8225-609e-0188-ec8a-4abe8d271a09@intel.com>
        <20230302062305.GA1444578@bgt-140510-bm03>
        <e10b60ab-f666-8124-eb8f-6a2da6c0f989@intel.com>
        <20230303143605.0000159a@Huawei.com>
        <640218e217c80_5a3fc2947@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
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

On Fri, 3 Mar 2023 07:57:22 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Thu, 2 Mar 2023 08:36:59 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> > > On 3/1/23 11:23 PM, Fan Ni wrote:  
> > > > On Wed, Mar 01, 2023 at 11:54:08AM -0700, Dave Jiang wrote:    
> > > >>    
> > > > Hi Dave,
> > > > Thanks for looking into this.    
> > > >>
> > > >> On 2/28/23 3:40 PM, Fan Ni wrote:    
> > > >>> Add COMMIT field check aside with existing COMMITTED field check during
> > > >>> hdm decoder initialization to avoid a system crash during module removal
> > > >>> after destroying a region which leaves the COMMIT field being reset while
> > > >>> the COMMITTED field still being set.    
> > > >>
> > > >> Hi Fan. Are you seeing this issue on qemu emulation or hardware? The    
> > > > I run into the issue with qemu emulation.    
> > > >> situation does not make sense to me. If we clear the COMMIT bit, then the
> > > >> COMMITTED bit should be cleared by the hardware shortly after right?    
> > > > 
> > > >  From the spec, I cannot find any statement saying clearing the COMMIT bit
> > > > will automatically clear the COMMITTED. If I have not missed the statement in
> > > > the spec, I assume we should not make the assumption that it will be
> > > > cleared automatically for real hardware. But you may be right, leaving the
> > > > COMMITTED bit set can potentially cause some issue? Need to check more.    
> > > 
> > > I have not been able to find direct verbiage that indicates this either. 
> > > However, logically it would make sense. Otherwise, the COMMITTED field 
> > > never clears and prevents reprogramming of the HDM decoders. The current 
> > > QEMU implementation is creating a situation where the HDM decoder is 
> > > always active after COMMIT bit is set the first time, regardless whether 
> > > COMMIT field has been cleared later on during a teardown. It does sound 
> > > like a bug with QEMU emulation currently.  
> > 
> > I agree that one sane interpretation is that unsetting commit should result in
> > the decoder being deactivated and hence the commit bit dropping.  However
> > I'm not sure that's the only sane interpretation.
> > 
> > There is no verbage that I'm aware of that says the committed bit being
> > set means that the current register values are in use.  It simply says that
> > when the commit bit was set, the HDM decoder was successfully committed
> > (using registers as set at that time).  There is a specific statement about
> > not changing the registers whilst checks are in progress, but those checks
> > are only required if lock on commit is set, so it doesn't cover this case.
> > 
> > Wonderfully there isn't actually anything says what a commit transition to 0
> > means.  Does that result in the decoder become uncommitted, or does that only
> > happen when the next 0 to 1 transition happens?
> > 
> > The only stuff we have is what happens when lock on commit = 1, which isn't
> > the case here.
> > 
> > So is there another valid implementation? I think yes.
> > In some implementations, there will be a complex state machine that is
> > triggered when commit is set.  That will then write some entirely invisible
> > internal state for decode logic based on the contents of the registers.
> > As such, once it's set committed, it typically won't look at the registers
> > again until another commit 0->1 transition happens.
> > At that point the
> > committed bit drops and raised again once the commit state machine finishes
> > (given QEMU doesn't emulate that delay the upshot is if you set commit then
> > check committed it will be set ;)  
> 
> I'm only barely following along so I wanted to make sure I understand...
> 
> Are you saying that at the instant commit 0->1 happens hardware will clear
> commited to 0 so that software can later check for commited vs error not
> commited?

yup.  That's what you'd see in such an implementation.

> 
> Ira
> 
> > 
> > In that implementation the commit 1->0 transition is an irrelevance and
> > it won't change the committed bit state.
> > 
> > So whilst the QEMU code is doing the less obvious implementation, I think
> > the spec still allows it.  I don't mind QEMU changing to the more obvious
> > one though if someone wants to send a patch.
> > 
> > Jonathan
> >   
> 
> [...]
> 

