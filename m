Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EF75EC514
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiI0N4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiI0N4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:56:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ED989CF4;
        Tue, 27 Sep 2022 06:56:27 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4McLjX2qPPz68967;
        Tue, 27 Sep 2022 21:55:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 27 Sep 2022 15:56:24 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 14:56:24 +0100
Date:   Tue, 27 Sep 2022 14:56:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 7/9] cxl/test: Add generic mock events
Message-ID: <20220927145623.0000040d@huawei.com>
In-Reply-To: <YzIcKFSRtXHiuG0+@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-8-ira.weiny@intel.com>
        <20220825123119.00000705@huawei.com>
        <YyN0qY5yaXwTwLDF@iweiny-desk3>
        <20220920171748.00001260@huawei.com>
        <YzIcKFSRtXHiuG0+@iweiny-desk3>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
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

On Mon, 26 Sep 2022 14:39:52 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Sep 20, 2022 at 09:17:48AM -0700, Jonathan Cameron wrote:
> > On Thu, 15 Sep 2022 11:53:29 -0700
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> > > On Thu, Aug 25, 2022 at 12:31:19PM +0100, Jonathan Cameron wrote:  
> > > > On Fri, 12 Aug 2022 22:32:41 -0700
> > > > ira.weiny@intel.com wrote:
> > > >     
> > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > 
> > > > > Facilitate testing basic Get/Clear Event functionality by creating
> > > > > multiple logs and generic events with made up UUID's.
> > > > > 
> > > > > Data is completely made up with data patterns which should be easy to
> > > > > spot in trace output.    
> > > > Hi Ira,
> > > > 
> > > > I'm tempted to hack the QEMU emulation for this in with appropriately
> > > > complex interface to inject all the record types...    
> > > 
> > > Every time I look at the QEMU code it makes my head spin.  :-(  
> > 
> > You get used to it ;)`  
> 
> I'm trying...  :-/
> 
> Question though:
> 
> Is there a call in qemu which is equivalent to cpu_to_leXX()?  The
> exec/cpu-all.h is having compilation issues for me because the
> TARGET_BIG_ENDIAN is not defined (it is defined in a meson generated header).
> 
> So I'm afraid that the tswapXX() calls are not what I'm supposed to use.  Is
> this true?  Are those some sort of internal call?
I'm confused.  There is cpu_to_le16 in "qemu/bswap.h"

I suspect we've played a bit fast and loose with endianness in a few places in
current qemu code and should probably check all that sometime.

Jonathan



> 
> Ira

