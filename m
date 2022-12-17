Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D7A64FB12
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 17:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiLQQkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 11:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLQQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 11:40:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D88F11C15;
        Sat, 17 Dec 2022 08:40:27 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NZBSK39Yjz67kFH;
        Sun, 18 Dec 2022 00:36:33 +0800 (CST)
Received: from localhost (10.81.207.254) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 17 Dec
 2022 16:40:24 +0000
Date:   Sat, 17 Dec 2022 16:40:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 3/9] cxl/mem: Wire up event interrupts
Message-ID: <20221217164023.00007597@Huawei.com>
In-Reply-To: <Y5zjBD6j4b3dBreR@iweiny-desk3>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
        <20221212070627.1372402-4-ira.weiny@intel.com>
        <20221216142438.00006588@Huawei.com>
        <20221216184215.000015dd@Huawei.com>
        <Y5zjBD6j4b3dBreR@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.207.254]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Fri, 16 Dec 2022 13:28:36 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Fri, Dec 16, 2022 at 06:42:15PM +0000, Jonathan Cameron wrote:
> > On Fri, 16 Dec 2022 14:24:38 +0000
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> > > On Sun, 11 Dec 2022 23:06:21 -0800
> > > ira.weiny@intel.com wrote:
> > >   
> > > > From: Davidlohr Bueso <dave@stgolabs.net>
> > > > 
> > > > Currently the only CXL features targeted for irq support require their
> > > > message numbers to be within the first 16 entries.  The device may
> > > > however support less than 16 entries depending on the support it
> > > > provides.
> > > > 
> > > > Attempt to allocate these 16 irq vectors.  If the device supports less
> > > > then the PCI infrastructure will allocate that number.  Upon successful
> > > > allocation, users can plug in their respective isr at any point
> > > > thereafter.
> > > > 
> > > > CXL device events are signaled via interrupts.  Each event log may have
> > > > a different interrupt message number.  These message numbers are
> > > > reported in the Get Event Interrupt Policy mailbox command.
> > > > 
> > > > Add interrupt support for event logs.  Interrupts are allocated as
> > > > shared interrupts.  Therefore, all or some event logs can share the same
> > > > message number.
> > > > 
> > > > In addition all logs are queried on any interrupt in order of the most
> > > > to least severe based on the status register.
> > > > 
> > > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > > >     
> > >   
> > > > +/**
> > > > + * Event Interrupt Policy
> > > > + *
> > > > + * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
> > > > + */
> > > > +enum cxl_event_int_mode {
> > > > +	CXL_INT_NONE		= 0x00,
> > > > +	CXL_INT_MSI_MSIX	= 0x01,
> > > > +	CXL_INT_FW		= 0x02
> > > > +};
> > > > +struct cxl_event_interrupt_policy {
> > > > +	u8 info_settings;
> > > > +	u8 warn_settings;
> > > > +	u8 failure_settings;
> > > > +	u8 fatal_settings;    
> > > 
> > > This is an issue for your QEMU code which has this set at 5 bytes.
> > > Guess our handling of record lengths needs updating now we have two different
> > > spec versions to support and hence these can have multiple lengths.
> > > 
> > > Btw, do you have an updated version of the QEMU patches you can share?  
> > 
> > Note that I'm happy to take your QEMU series forwards, just don't want to duplicate
> > stuff you have already done!  
> 
> I do have updates to handle more than 3 records at a time which I was polishing
> until I saw your review.

Great. I'll work on other stuff in the meantime and hopefully we can get all the
error emulation upstream this QEMU cycle.

> 
> I was getting all geared up to respin the patches but I'm not sure there is an
> issue now that I look at it.
> 
> I'm still investigating.
> 
> Ira
> 
> > 
> > Jonathan
> >   
> > > I was planning on just doing the AER type RAS stuff for the first pull this cycle
> > > but given this set means we never reach that code I probably need to do QEMU
> > > support for this and the stuff to support those all in one go - otherwise
> > > no one will be able to test it :)  We rather optimistically have the OSC set
> > > to say the OS can have control of these, but upstream code doesn't emulate
> > > anything yet. Oops. Should have pretended the hardware was handling them
> > > until we had this support in place in QEMU.
> > > 
> > > Jonathan
> > >   
> > > > +} __packed;
> > > > +
> > > >  /**
> > > >   * struct cxl_event_state - Event log driver state
> > > >   *
> > > > @@ -288,6 +305,8 @@ enum cxl_opcode {
> > > >  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> > > >  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> > > >  	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> > > > +	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
> > > > +	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
> > > >  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> > > >  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> > > >  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,    
> >   

