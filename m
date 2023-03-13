Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD26B7373
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCMKKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCMKKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:10:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB159400;
        Mon, 13 Mar 2023 03:10:17 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PZslV2Wh0z6J9fJ;
        Mon, 13 Mar 2023 18:07:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 13 Mar
 2023 10:10:14 +0000
Date:   Mon, 13 Mar 2023 10:10:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Fan Ni <fan.ni@samsung.com>, Dave Jiang <dave.jiang@intel.com>,
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
Message-ID: <20230313101013.00007a07@Huawei.com>
In-Reply-To: <6407740ff0ce_a37b8294a3@iweiny-mobl.notmuch>
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
        <20230228224014.1402545-1-fan.ni@samsung.com>
        <346a8225-609e-0188-ec8a-4abe8d271a09@intel.com>
        <20230302062305.GA1444578@bgt-140510-bm03>
        <e10b60ab-f666-8124-eb8f-6a2da6c0f989@intel.com>
        <20230303143605.0000159a@Huawei.com>
        <20230303172054.GA1478149@bgt-140510-bm03>
        <20230306160422.00003633@Huawei.com>
        <20230307111200.0000419c@Huawei.com>
        <6407740ff0ce_a37b8294a3@iweiny-mobl.notmuch>
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

On Tue, 7 Mar 2023 09:27:43 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Mon, 6 Mar 2023 16:04:22 +0000
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> > > On Fri, 3 Mar 2023 17:21:13 +0000
> > > Fan Ni <fan.ni@samsung.com> wrote:
> > >   
> > > > On Fri, Mar 03, 2023 at 02:36:05PM +0000, Jonathan Cameron wrote:
> > > >     
> > > > > On Thu, 2 Mar 2023 08:36:59 -0700
> > > > > Dave Jiang <dave.jiang@intel.com> wrote:
> > > > >       
> > > > > > On 3/1/23 11:23 PM, Fan Ni wrote:      
> > > > > > > On Wed, Mar 01, 2023 at 11:54:08AM -0700, Dave Jiang wrote:        
> > > > > > >>        
> > > > > > > Hi Dave,
> > > > > > > Thanks for looking into this.        
> > > > > > >>
> > > > > > >> On 2/28/23 3:40 PM, Fan Ni wrote:        
> > > > > > >>> Add COMMIT field check aside with existing COMMITTED field check during
> > > > > > >>> hdm decoder initialization to avoid a system crash during module removal
> > > > > > >>> after destroying a region which leaves the COMMIT field being reset while
> > > > > > >>> the COMMITTED field still being set.        
> > > > > > >>
> > > > > > >> Hi Fan. Are you seeing this issue on qemu emulation or hardware? The        
> > > > > > > I run into the issue with qemu emulation.        
> > > > > > >> situation does not make sense to me. If we clear the COMMIT bit, then the
> > > > > > >> COMMITTED bit should be cleared by the hardware shortly after right?        
> > > > > > > 
> > > > > > >  From the spec, I cannot find any statement saying clearing the COMMIT bit
> > > > > > > will automatically clear the COMMITTED. If I have not missed the statement in
> > > > > > > the spec, I assume we should not make the assumption that it will be
> > > > > > > cleared automatically for real hardware. But you may be right, leaving the
> > > > > > > COMMITTED bit set can potentially cause some issue? Need to check more.        
> > > > > > 
> > > > > > I have not been able to find direct verbiage that indicates this either. 
> > > > > > However, logically it would make sense. Otherwise, the COMMITTED field 
> > > > > > never clears and prevents reprogramming of the HDM decoders. The current 
> > > > > > QEMU implementation is creating a situation where the HDM decoder is 
> > > > > > always active after COMMIT bit is set the first time, regardless whether 
> > > > > > COMMIT field has been cleared later on during a teardown. It does sound 
> > > > > > like a bug with QEMU emulation currently.      
> > > > > 
> > > > > I agree that one sane interpretation is that unsetting commit should result in
> > > > > the decoder being deactivated and hence the commit bit dropping.  However
> > > > > I'm not sure that's the only sane interpretation.
> > > > > 
> > > > > There is no verbage that I'm aware of that says the committed bit being
> > > > > set means that the current register values are in use.  It simply says that
> > > > > when the commit bit was set, the HDM decoder was successfully committed
> > > > > (using registers as set at that time).  There is a specific statement about
> > > > > not changing the registers whilst checks are in progress, but those checks
> > > > > are only required if lock on commit is set, so it doesn't cover this case.
> > > > > 
> > > > > Wonderfully there isn't actually anything says what a commit transition to 0
> > > > > means.  Does that result in the decoder become uncommitted, or does that only
> > > > > happen when the next 0 to 1 transition happens?
> > > > > 
> > > > > The only stuff we have is what happens when lock on commit = 1, which isn't
> > > > > the case here.
> > > > > 
> > > > > So is there another valid implementation? I think yes.
> > > > > In some implementations, there will be a complex state machine that is
> > > > > triggered when commit is set.  That will then write some entirely invisible
> > > > > internal state for decode logic based on the contents of the registers.
> > > > > As such, once it's set committed, it typically won't look at the registers
> > > > > again until another commit 0->1 transition happens.  At that point the
> > > > > committed bit drops and raised again once the commit state machine finishes
> > > > > (given QEMU doesn't emulate that delay the upshot is if you set commit then
> > > > > check committed it will be set ;)
> > > > > 
> > > > > In that implementation the commit 1->0 transition is an irrelevance and
> > > > > it won't change the committed bit state.
> > > > > 
> > > > > So whilst the QEMU code is doing the less obvious implementation, I think
> > > > > the spec still allows it.  I don't mind QEMU changing to the more obvious
> > > > > one though if someone wants to send a patch.
> > > > > 
> > > > > Jonathan
> > > > >       
> > > > 
> > > > In current qemu emulation, when COMMITTED bit is set when the decoder is
> > > > committed and at the same time the COMMIT field will be cleared. Does
> > > > the following fix make sense?
> > > > 1. At qemu side, when the commit completes, just set the COMMITTED bit,
> > > > but leave the COMMIT bit as set, also check LOCK ON COMMIT bit,
> > > > if it is set, clear it, which will allow further reset of COMMIT bit.    
> > > 
> > > QEMU definitely can't do anything to the Commit bit, other than prevent it being
> > > cleared if lock on commit is set.
> > > Right now the QEMU emulation doesn't handle LOCK ON COMMIT at all.
> > > It would be sensible to add this support, but we don't have an
> > > open software stack that ever sets that yet so any testing is likely to be
> > > one time only via some hacks.
> > >   
> > > > 2. for the kernel side, if it needs to reprogram the decoder, it needs to
> > > > check the COMMITTED bit, if it is set, then OS need to reset COMMIT bit
> > > > first, which will also clear COMMITTED bit automatically at qemu side.    
> > > 
> > > Could do it that way, or simplify it by always clearing commit before setting
> > > it to make sure the transition happens.
> > > 
> > > Looks like commit is cleared in cxl_decoder_reset() already so this may
> > > already happen - I haven't checked the flow.
> > >   
> > > > 3. when the OS needs to reset the decoder, it does similar thing as 2 to
> > > > reset COMMIT bit and qemu will clear COMMITTED bit.    
> > > 
> > > No the point of the above argument is that the spec doesn't say anything
> > > about when committed is cleared. 2 options.
> > > 1) Hardware clears it when commit 1->0.
> > > 2) Hardware clears it when commit 0->1
> > > 
> > > Given that spec only talks about after a commit 0->1 transition whilst commit
> > > remains 1, the state after a commit 0->1 transition is implementation defined.
> > > 
> > > I think that closing that corner case requires a clarification to the spec.
> > > 
> > > Which leaves us with a sticky question of what to do...  
> > 
> > Thinking a little more on this and another close look at spec.
> > The committed bit definition calls out "Indicates a decoder is active"
> > so if it is not cleared when commit 1->0 then we may have a problem with
> > multiple decoders and the clear only on commit 0->1 option
> > 
> > Let us first setup decoders as.
> > decoder 0 -> HPA X to X + N1 (then commit)
> > decoder 1 -> HPA X + N1 to X + N1 + M1 (then commit)
> > 
> > Now we want to change them without passing through a situation where we have
> > overlap so that we have N2 > N1. There is a route to doing this but it's
> > not very intuitive.  
> 
> I'm a bit unclear on the variables here.
> 
> We have 2 ranges A and B and we want to add C?

Always 2 ranges, aim is to move the boundary between them
in one direction or the other.  It's the simplest dance
I could think of that makes things complex.


> 
> Size of A is N1? 
Yes
> Size of B is M1?
Yes
> 
> Then Size of C is N2?
> 
> Or is N2 a new size of N1?  So the size of A is changing?

This one. I indeed failed to define N2. Oops.

> 
> > 
> > 1. Unset commit on both decoders
> > 2. Update decoder 1 first and commit.  Have to do it in this order as
> >    decoder 0 is still committed (in use) so we can't overlap with it.
> > 3. Update decoder 0 second and commit. 
> > 
> > If N1 < N2 need to reverse the order.
> > 
> > 1. Unset commit on both decoders
> > 2. Update decoder 0 first and commit. Avoids overlap with still committed decoder 1.
> > 3. Update decoder 1 and commit.  
> 
> If the size of A is changing then yes I think this is required.  But I
> don't think it has anything to do with the commit bit.  I think we have to
> program decoders in order anyway so this was required all along.  Wasn't
> it?

Snag is that the decodering is based not on the commit bit, but on the state
of the committed bit.  If the spec provides no way to 'unset' that short
of committing new settings for a given decoder, the dance becomes 'exciting'.

If we can just reset it then a resize like the above just means uncommitting
the two regions then building them again as if nothing ever existed.

> 
> > 
> > So I think there is a path to make it work but it's nasty.  
> 
> Not nice no...  :-(
> 
> > 
> > I'll raise a query with CXL SSWG chair (off list but referring to this thread)  
> 
> Not a bad idea.  I'm no expert on this I'm just going off of what I have
> heard/remember/read on the fly...

In progress.

Note that I'm fine to just change QEMU to do the 'obvious' option.  We can revisit
the pathological cases if it turns out to be necessary.
Good to identify this fun corner case though ;)

Jonathan

> 
> Ira
> 

