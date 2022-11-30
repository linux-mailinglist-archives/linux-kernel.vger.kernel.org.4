Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326CB63D78A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiK3OFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiK3OFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:05:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE623E0BF;
        Wed, 30 Nov 2022 06:05:32 -0800 (PST)
Received: from frapeml100006.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMgvP1hsxz686wm;
        Wed, 30 Nov 2022 22:05:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 15:05:29 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 14:05:28 +0000
Date:   Wed, 30 Nov 2022 14:05:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <20221130140527.00006778@Huawei.com>
In-Reply-To: <Y4blpk/esXJMe79Y@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-3-ira.weiny@intel.com>
        <20221116151936.0000662f@Huawei.com>
        <Y3WEmMlLfPoYG1R5@iweiny-desk3>
        <20221117104337.00001a3f@Huawei.com>
        <Y3gUmSuR3OxUwkDm@iweiny-desk3>
        <20221121104714.00003bab@Huawei.com>
        <Y4VEhNNTbXj5EwOm@iweiny-desk3>
        <20221129122620.00002cf0@Huawei.com>
        <Y4blpk/esXJMe79Y@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Tue, 29 Nov 2022 21:09:58 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Nov 29, 2022 at 12:26:20PM +0000, Jonathan Cameron wrote:
> > On Mon, 28 Nov 2022 15:30:12 -0800
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> 
> [snip]
> 
> > > > A valid reading of that temporal order comment is actually the other way around
> > > > that the device must not reset it's idea of temporal order until all records
> > > > have been read (reading 3 twice is not in temporal order - imagine we had
> > > > read 5 each time and it becomes more obvious as the read order becomes
> > > > 0,1,2,3,4,3,4,5,6,7 etc which is clearly not in temporal order by any normal
> > > > reading of the term.    
> > > 
> > > Well I guess.  My reading was that it must return the first element temporally
> > > within the list at the time of the Get operation.
> > > 
> > > So in this example since 3 is still in the list it must return it first.  Each
> > > read is considered atomic from the others.  Yes as long as 0 is in the queue it
> > > will be returned.
> > > 
> > > But I can see it your way too...  
> > 
> > That pesky text under More Event Records flag doesn't mention clearing when it
> > says "The host should continue to retrieve 
> > records using this command, until this indicator is no longer set by the 
> > device."
> > 
> > I wish it did :(
> >   
> 
> As I have reviewed these in my head again I have come to the conclusion that
> the More Event Records flags is useless.  Let me explain:
> 
> The Clear all Records flag is useless because if an event which occurs between the
> Get and Clear all operation will be dropped without the host having seen it.

Can still be used to get a known clean sheet if you don't care about a bunch
of records on initial boot because no data in flight yet etc.
Agreed it is no use if you care about content of the records.

Make sure interrupts are enabled before re-checking if there are new records
to close that race.

> 
> However, while clearing records based on the handles read, additional events
> could come in.  Because of the way the interrupts are specified the host can't
> be sure that those new events will cause a zero to non-zero transition.  This
> is because there is no way to guarantee all the events were cleared at the
> moment the events came in.
> 
> I believe this is what you mentioned in another email about needing an 'extra
> read' at the end to ensure there was nothing more to be read.  But based on
> that logic the only thing that matters is the Get Event.Record
> Count.  If it is not 0 keep on reading because while the host is clearing the
> records another event could come in.
> 
> In other words, the only way to be sure that all records are seen is to do a
> Get and see the number of records equal to 0.  Thus any further events will
> trigger an interrupt and we can safely exit the loop.

Agreed - standard race to close when ever we have a FIFO with edge interrupts
on how full it is.

More records is useful for a different potential pattern of non destructive
read and later clear.  Or for a debug non destructive read.


	int nr_rec;
	<list>

round_we_go:
	do {
		... <for each record trace and add to list...> ...	
		... 
	} while (!MORE);

	for_each_list_entry() {
		clear records one at a time.
	}

	nr_rec = le16_to_cpu(payload->record_count);
	if (nr_rec)
		goto round_we_go;

	...

> 
> Ira
> 
> Basically the loop looks like:
> 
> 	int nr_rec;
> 
> 	do {
> 		... <Get Events> ...
> 
> 		nr_rec = le16_to_cpu(payload->record_count);
> 
> 		... <for each record trace> ...
> 		... <for each record clear> ...
> 
> 	} while (nr_rec);
> 

