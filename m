Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FBB6ADD0E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCGLOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCGLNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:13:33 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC0974DD4;
        Tue,  7 Mar 2023 03:12:05 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PWCPv3tyMz6J9dv;
        Tue,  7 Mar 2023 19:09:23 +0800 (CST)
Received: from localhost (10.126.173.40) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 7 Mar
 2023 11:12:01 +0000
Date:   Tue, 7 Mar 2023 11:12:00 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     Dave Jiang <dave.jiang@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Message-ID: <20230307111200.0000419c@Huawei.com>
In-Reply-To: <20230306160422.00003633@Huawei.com>
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
        <20230228224014.1402545-1-fan.ni@samsung.com>
        <346a8225-609e-0188-ec8a-4abe8d271a09@intel.com>
        <20230302062305.GA1444578@bgt-140510-bm03>
        <e10b60ab-f666-8124-eb8f-6a2da6c0f989@intel.com>
        <20230303143605.0000159a@Huawei.com>
        <20230303172054.GA1478149@bgt-140510-bm03>
        <20230306160422.00003633@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.173.40]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Mon, 6 Mar 2023 16:04:22 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 3 Mar 2023 17:21:13 +0000
> Fan Ni <fan.ni@samsung.com> wrote:
> 
> > On Fri, Mar 03, 2023 at 02:36:05PM +0000, Jonathan Cameron wrote:
> >   
> > > On Thu, 2 Mar 2023 08:36:59 -0700
> > > Dave Jiang <dave.jiang@intel.com> wrote:
> > >     
> > > > On 3/1/23 11:23 PM, Fan Ni wrote:    
> > > > > On Wed, Mar 01, 2023 at 11:54:08AM -0700, Dave Jiang wrote:      
> > > > >>      
> > > > > Hi Dave,
> > > > > Thanks for looking into this.      
> > > > >>
> > > > >> On 2/28/23 3:40 PM, Fan Ni wrote:      
> > > > >>> Add COMMIT field check aside with existing COMMITTED field check during
> > > > >>> hdm decoder initialization to avoid a system crash during module removal
> > > > >>> after destroying a region which leaves the COMMIT field being reset while
> > > > >>> the COMMITTED field still being set.      
> > > > >>
> > > > >> Hi Fan. Are you seeing this issue on qemu emulation or hardware? The      
> > > > > I run into the issue with qemu emulation.      
> > > > >> situation does not make sense to me. If we clear the COMMIT bit, then the
> > > > >> COMMITTED bit should be cleared by the hardware shortly after right?      
> > > > > 
> > > > >  From the spec, I cannot find any statement saying clearing the COMMIT bit
> > > > > will automatically clear the COMMITTED. If I have not missed the statement in
> > > > > the spec, I assume we should not make the assumption that it will be
> > > > > cleared automatically for real hardware. But you may be right, leaving the
> > > > > COMMITTED bit set can potentially cause some issue? Need to check more.      
> > > > 
> > > > I have not been able to find direct verbiage that indicates this either. 
> > > > However, logically it would make sense. Otherwise, the COMMITTED field 
> > > > never clears and prevents reprogramming of the HDM decoders. The current 
> > > > QEMU implementation is creating a situation where the HDM decoder is 
> > > > always active after COMMIT bit is set the first time, regardless whether 
> > > > COMMIT field has been cleared later on during a teardown. It does sound 
> > > > like a bug with QEMU emulation currently.    
> > > 
> > > I agree that one sane interpretation is that unsetting commit should result in
> > > the decoder being deactivated and hence the commit bit dropping.  However
> > > I'm not sure that's the only sane interpretation.
> > > 
> > > There is no verbage that I'm aware of that says the committed bit being
> > > set means that the current register values are in use.  It simply says that
> > > when the commit bit was set, the HDM decoder was successfully committed
> > > (using registers as set at that time).  There is a specific statement about
> > > not changing the registers whilst checks are in progress, but those checks
> > > are only required if lock on commit is set, so it doesn't cover this case.
> > > 
> > > Wonderfully there isn't actually anything says what a commit transition to 0
> > > means.  Does that result in the decoder become uncommitted, or does that only
> > > happen when the next 0 to 1 transition happens?
> > > 
> > > The only stuff we have is what happens when lock on commit = 1, which isn't
> > > the case here.
> > > 
> > > So is there another valid implementation? I think yes.
> > > In some implementations, there will be a complex state machine that is
> > > triggered when commit is set.  That will then write some entirely invisible
> > > internal state for decode logic based on the contents of the registers.
> > > As such, once it's set committed, it typically won't look at the registers
> > > again until another commit 0->1 transition happens.  At that point the
> > > committed bit drops and raised again once the commit state machine finishes
> > > (given QEMU doesn't emulate that delay the upshot is if you set commit then
> > > check committed it will be set ;)
> > > 
> > > In that implementation the commit 1->0 transition is an irrelevance and
> > > it won't change the committed bit state.
> > > 
> > > So whilst the QEMU code is doing the less obvious implementation, I think
> > > the spec still allows it.  I don't mind QEMU changing to the more obvious
> > > one though if someone wants to send a patch.
> > > 
> > > Jonathan
> > >     
> > 
> > In current qemu emulation, when COMMITTED bit is set when the decoder is
> > committed and at the same time the COMMIT field will be cleared. Does
> > the following fix make sense?
> > 1. At qemu side, when the commit completes, just set the COMMITTED bit,
> > but leave the COMMIT bit as set, also check LOCK ON COMMIT bit,
> > if it is set, clear it, which will allow further reset of COMMIT bit.  
> 
> QEMU definitely can't do anything to the Commit bit, other than prevent it being
> cleared if lock on commit is set.
> Right now the QEMU emulation doesn't handle LOCK ON COMMIT at all.
> It would be sensible to add this support, but we don't have an
> open software stack that ever sets that yet so any testing is likely to be
> one time only via some hacks.
> 
> > 2. for the kernel side, if it needs to reprogram the decoder, it needs to
> > check the COMMITTED bit, if it is set, then OS need to reset COMMIT bit
> > first, which will also clear COMMITTED bit automatically at qemu side.  
> 
> Could do it that way, or simplify it by always clearing commit before setting
> it to make sure the transition happens.
> 
> Looks like commit is cleared in cxl_decoder_reset() already so this may
> already happen - I haven't checked the flow.
> 
> > 3. when the OS needs to reset the decoder, it does similar thing as 2 to
> > reset COMMIT bit and qemu will clear COMMITTED bit.  
> 
> No the point of the above argument is that the spec doesn't say anything
> about when committed is cleared. 2 options.
> 1) Hardware clears it when commit 1->0.
> 2) Hardware clears it when commit 0->1
> 
> Given that spec only talks about after a commit 0->1 transition whilst commit
> remains 1, the state after a commit 0->1 transition is implementation defined.
> 
> I think that closing that corner case requires a clarification to the spec.
> 
> Which leaves us with a sticky question of what to do...

Thinking a little more on this and another close look at spec.
The committed bit definition calls out "Indicates a decoder is active"
so if it is not cleared when commit 1->0 then we may have a problem with
multiple decoders and the clear only on commit 0->1 option

Let us first setup decoders as.
decoder 0 -> HPA X to X + N1 (then commit)
decoder 1 -> HPA X + N1 to X + N1 + M1 (then commit)

Now we want to change them without passing through a situation where we have
overlap so that we have N2 > N1. There is a route to doing this but it's
not very intuitive.

1. Unset commit on both decoders
2. Update decoder 1 first and commit.  Have to do it in this order as
   decoder 0 is still committed (in use) so we can't overlap with it.
3. Update decoder 0 second and commit. 

If N1 < N2 need to reverse the order.

1. Unset commit on both decoders
2. Update decoder 0 first and commit. Avoids overlap with still committed decoder 1.
3. Update decoder 1 and commit.

So I think there is a path to make it work but it's nasty.

I'll raise a query with CXL SSWG chair (off list but referring to this thread)

Jonathan 


> 
> > 
> > Fan
> >   
> > > >
> > > > DJ
> > > >     
> > > > > 
> > > > > Fan
> > > > >       
> > > > >> Otherwise, how would one reprogram the decoder if the decoder is indicating
> > > > >> to be active?
> > > > >>
> > > > >> DJ
> > > > >>      
> > > > >>>
> > > > >>> In current kernel implementation, when destroying a region (cxl
> > > > >>> destroy-region),the decoders associated to the region will be reset
> > > > >>> as that in cxl_decoder_reset, where the COMMIT field will be reset.
> > > > >>> However, resetting COMMIT field will not automatically reset the
> > > > >>> COMMITTED field, causing a situation where COMMIT is reset (0) while
> > > > >>> COMMITTED is set (1) after the region is destroyed. Later, when
> > > > >>> init_hdm_decoder is called (during modprobe), current code only check
> > > > >>> the COMMITTED to decide whether the decoder is enabled or not. Since
> > > > >>> the COMMITTED will be 1 and the code treats the decoder as enabled,
> > > > >>> which will cause unexpected behaviour.
> > > > >>>
> > > > >>> Before the fix, a system crash was observed when performing following
> > > > >>> steps:
> > > > >>> 1. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
> > > > >>> 2. cxl create-region -m -d decoder0.0 -w 1 mem0 -s 256M
> > > > >>> 3. cxl destroy-region region0 -f
> > > > >>> 4. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core
> > > > >>> 5. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem (showing
> > > > >>> "no CXL window for range 0x0:0xffffffffffffffff" error message)
> > > > >>> 6. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core (kernel
> > > > >>> crash at cxl_dpa_release due to dpa_res has been freed when destroying
> > > > >>> the region).
> > > > >>>
> > > > >>> The patch fixed the above issue, and is tested based on follow patch series:
> > > > >>>
> > > > >>> [PATCH 00/18] CXL RAM and the 'Soft Reserved' => 'System RAM' default
> > > > >>> Message-ID: 167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com
> > > > >>>
> > > > >>> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > > > >>> ---
> > > > >>>    drivers/cxl/core/hdm.c | 8 +++++---
> > > > >>>    1 file changed, 5 insertions(+), 3 deletions(-)
> > > > >>>
> > > > >>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > > >>> index 80eccae6ba9e..6cf854c949f0 100644
> > > > >>> --- a/drivers/cxl/core/hdm.c
> > > > >>> +++ b/drivers/cxl/core/hdm.c
> > > > >>> @@ -695,6 +695,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> > > > >>>    	struct cxl_endpoint_decoder *cxled = NULL;
> > > > >>>    	u64 size, base, skip, dpa_size;
> > > > >>>    	bool committed;
> > > > >>> +	bool should_commit;
> > > > >>>    	u32 remainder;
> > > > >>>    	int i, rc;
> > > > >>>    	u32 ctrl;
> > > > >>> @@ -710,10 +711,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> > > > >>>    	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
> > > > >>>    	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
> > > > >>>    	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> > > > >>> +	should_commit = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMIT);
> > > > >>>    	cxld->commit = cxl_decoder_commit;
> > > > >>>    	cxld->reset = cxl_decoder_reset;
> > > > >>> -	if (!committed)
> > > > >>> +	if (!should_commit || !committed)
> > > > >>>    		size = 0;
> > > > >>>    	if (base == U64_MAX || size == U64_MAX) {
> > > > >>>    		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
> > > > >>> @@ -727,7 +729,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> > > > >>>    	};
> > > > >>>    	/* decoders are enabled if committed */
> > > > >>> -	if (committed) {
> > > > >>> +	if (should_commit && committed) {
> > > > >>>    		cxld->flags |= CXL_DECODER_F_ENABLE;
> > > > >>>    		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> > > > >>>    			cxld->flags |= CXL_DECODER_F_LOCK;
> > > > >>> @@ -772,7 +774,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> > > > >>>    		return 0;
> > > > >>>    	}
> > > > >>> -	if (!committed)
> > > > >>> +	if (!should_commit || !committed)
> > > > >>>    		return 0;
> > > > >>>    	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);      
> > >    
> 
> 

