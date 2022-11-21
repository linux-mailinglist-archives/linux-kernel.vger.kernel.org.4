Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE52631EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiKUKrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiKUKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:47:20 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B517991F;
        Mon, 21 Nov 2022 02:47:18 -0800 (PST)
Received: from frapeml100004.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NG3qd3pLTz6H6kR;
        Mon, 21 Nov 2022 18:42:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 11:47:16 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 10:47:15 +0000
Date:   Mon, 21 Nov 2022 10:47:14 +0000
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
Message-ID: <20221121104714.00003bab@Huawei.com>
In-Reply-To: <Y3gUmSuR3OxUwkDm@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-3-ira.weiny@intel.com>
        <20221116151936.0000662f@Huawei.com>
        <Y3WEmMlLfPoYG1R5@iweiny-desk3>
        <20221117104337.00001a3f@Huawei.com>
        <Y3gUmSuR3OxUwkDm@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Fri, 18 Nov 2022 15:26:17 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Thu, Nov 17, 2022 at 10:43:37AM +0000, Jonathan Cameron wrote:
> > On Wed, 16 Nov 2022 16:47:20 -0800
> > Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> >   
> 
> [snip]
> 
> > >   
> > > >     
> > > > > +			int i;
> > > > > +
> > > > > +			for (i = 0; i < nr_rec; i++)
> > > > > +				trace_cxl_generic_event(dev_name(cxlds->dev),
> > > > > +							type,
> > > > > +							&payload.record[i]);
> > > > > +		}
> > > > > +
> > > > > +		if (trace_cxl_overflow_enabled() &&
> > > > > +		    (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW))
> > > > > +			trace_cxl_overflow(dev_name(cxlds->dev), type, &payload);
> > > > > +
> > > > > +	} while (pl_nr > CXL_GET_EVENT_NR_RECORDS ||    
> > > > 
> > > > Isn't pl_nr > CXL_GET_EVENT_NR_RECORDS a hardware bug? It's the number in returned
> > > > payload not the total number.    
> > > 
> > > I don't think so.  The only value passed to the device is the _input_ payload
> > > size.  The output payload size is not passed to the device and is not included
> > > in the Get Event Records Input Payload.  (Table 8-49)
> > > 
> > > So my previous code was wrong.  Here is an example I think which is within the
> > > spec but would result in the more records flag not being set.
> > > 
> > > 	Device log depth == 10
> > > 	nr log entries == 7
> > > 	nr log entries in 1MB ~= (1M - hdr size) / 128 ~= 8000
> > > 
> > > Device sets Output Payload.Event Record Count == 7 (which is < 8000).  Common
> > > mailbox code truncates that to 3.  More Event Records == 0 because it sent all
> > > 7 that it had.
> > > 
> > > This code will clear 3 and read again 2 more times.
> > > 
> > > Am I reading that wrong?  
> > 
> > I think this is still wrong, but for a different reason. :)  
> 
> I hope not...  :-/
> 
> > If we don't clear the records and more records is set, that means it didn't
> > fit in the mailbox payload (potentially 1MB)  then the next read
> > will return the next set of records from there.  
> 
> That is not how I read the Get Event Records command:
> 
> From 8.2.9.2.2 Get Event Records
> 
> ... "Devices shall return event records to the host in the temporal order the
> device detected the events in. The event occurring the earliest in time, in the
> specific event log, shall be returned first."
> 
> If item 3 below is earlier than 4 then it must be returned if we have not
> cleared it.  At least that is how I read the above.  :-/

In general that doesn't work.  Imagine we cleared no records.
In that case we'd return 4 despite there being earlier records.
There is no language to cover this particular case of clearing
part of what was returned.  The device did return the records
in temporal order, we just didn't notice some of them.

The wonders of slightly loose spec wording.  Far as I can tell
we are stuck with having to come with all things that could be
read as being valid implementations.

> 
> > 
> > Taking this patch only, let's say the mailbox takes 4 records.
> > Read 1: Records 0, 1, 2, 3 More set.
> >    We handle 0, 1, 2
> > Read 2: Records 4, 5, 6 More not set.
> >    We handle 4, 5, 6
> > 
> > Record 3 is never handled.
> > 
> > If we add in clearing as happens later in the series,  
> 
> I suppose I should squash the patches as this may not work without the
> clearing.  :-/
> 
> > the current
> > assumption is that if we clear some records a subsequent read will
> > start again.  I'm not sure that is true. If it is spec reference needed.
> > 
> > So assumption is
> > Read 1: Records 0, 1, 2, 3 More set
> >   Clear 0, 1, 2
> > Read 2: Records 3, 4, 5, 6
> >   Clear 3, 4, 5 More not set, but catch it with the condition above.
> > Read 3: 6 only
> >   Clear 6
> > 
> > However, I think a valid implementation could do the following
> > (imagine a ring buffer with a pointer to the 'next' record to read out and
> >  each record has a 'valid' flag to deal with corner cases around
> >  sequences such as read log once, start reading again and some
> >  clears occur using handles obtained from first read - not that
> >  case isn't ruled out by the spec as far as I can see).  
> 
> I believe this is a violation because the next pointer can't be advanced until
> the record is cleared.  Otherwise the device is not returning items in temporal
> order based on what is in the log.

Ah. This is where we disagree.  The temporal order is (potentially?) unconnected
from the clearing.  The device did return them in temporal order, we just didn't
take any novice of record 3 being returned.
A valid reading of that temporal order comment is actually the other way around
that the device must not reset it's idea of temporal order until all records
have been read (reading 3 twice is not in temporal order - imagine we had
read 5 each time and it becomes more obvious as the read order becomes
0,1,2,3,4,3,4,5,6,7 etc which is clearly not in temporal order by any normal
reading of the term. The more I read this, the more I think the current implementation
is not compliant with the specification at all.

I'm not seeing a spec mention of 'reseting' the ordering on clearing records
(which might have been a good thing in the first place but too late now).

> 
> > 
> > Read 1: Records 0, 1, 2, 3 More set.  'next' pointer points to record 4.
> >   Clear 0, 1, 2
> > Read 2: Records 4, 5, 6 More not set. 'next' pointer points to record 7.
> >   Clear 4, 5, 6
> > 
> > Skipping record 3.
> > 
> > So I think we have to absorb the full mailbox payload each time to guarantee
> > we don't skip events or process them out of order (which is what would happen
> > if we relied on a retry loop - we aren't allowed to clear them out of
> > order anyway 8.2.9.2.3 "Events shall be cleared in temporal order. The device
> > shall verify the event record handles specified in the input payload are in
> > temporal order. ... "). 
> > Obviously that temporal order thing is only relevant if we get my second
> > example occurring on real hardware.  I think the spec is vague enough
> > to allow that implementation.  Would have been easy to specify this originally
> > but it probably won't go in as errata so we need to cope with all the
> > flexibility that is present.  
> 
> :-(  Yea coulda, woulda, shoulda...  ;-)
> 
> > 
> > What fun and oh for a parameter to control how many records are returned!  
> 
> Yea.  But I really don't think there is a problem unless someone really take
> liberty with the spec.  I think it boils down to how one interprets _when_ a
> record is removed from the log.

This is nothing to do with removal. The wording we have is just about reading
and I think a strict reading of the spec would say your assumption of a reset of the
read pointer on clear is NOT a valid implementation.  There is separate wording
about clears being in temporal order, but that doesn't effect the Get Event
Records handling.

> 
> If the record is removed when it is returned (as in your 'next' pointer
> example) then why have a clear at all?

Because if your software crashes, you don't have a handshake to reestablish
state.  If that happens you read the whole log until MORE is not set and
then read it again to get a clean list.  It's messy situation that has
been discussed before for GET POISON LIST which has the same nasty handing
of MORE.  (look in appropriate forum for resolution to that one that we can't
yet discuss here!)

Also, allows for non destructive readback (debugging tools might take a look
having paused the normal handling).

> If my interpretation is correct then
> the next available entry is the one which has not been cleared.

If that is the case the language in "More Event Records" doesn't work
"The host should continue to retrieve records using this command, until
this indicator is no longer set by the device"

With your reading of the spec, if we clear nothing, we'd keep getting the
first set of records and only be able to read more by clearing them...


>  Therefore in
> your example 'next' is not incremented until clear has been called.  I think
> that implementation is also supported by the idea that records must be cleared
> in temporal order.  Otherwise I think devices would get confused.

Not hard for device to do this (how I now read the spec) properly.

Two pointers:
1) Next to clear: CLEAR
2) Next to read:  READ

Advance the the READ pointer on Get Event Records
For CLEAR, check that the requested clears are handled in order and that
they are before the READ pointer.

Maybe we should just take it to appropriate spec forum to seek a clarification?

Jonathan

> 
> FWIW the qemu implementation is based on my interpretation ATM.
> 
> Ira
> 
> > 
> > Jonathan
> > 
> >   
> > >   
> > > >     
> > > > > +		 payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
> > > > > +}    
> > > >   
> >   
> > >   
> >   

