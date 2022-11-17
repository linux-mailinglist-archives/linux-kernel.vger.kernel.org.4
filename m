Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9914E62D84E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiKQKnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKQKno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:43:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E62673;
        Thu, 17 Nov 2022 02:43:41 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NCbxX5ngPz6H6hX;
        Thu, 17 Nov 2022 18:38:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 11:43:39 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 10:43:38 +0000
Date:   Thu, 17 Nov 2022 10:43:37 +0000
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
Message-ID: <20221117104337.00001a3f@Huawei.com>
In-Reply-To: <Y3WEmMlLfPoYG1R5@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-3-ira.weiny@intel.com>
        <20221116151936.0000662f@Huawei.com>
        <Y3WEmMlLfPoYG1R5@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Wed, 16 Nov 2022 16:47:20 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Wed, Nov 16, 2022 at 03:19:36PM +0000, Jonathan Cameron wrote:
> > On Thu, 10 Nov 2022 10:57:49 -0800
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > CXL devices have multiple event logs which can be queried for CXL event
> > > records.  Devices are required to support the storage of at least one
> > > event record in each event log type.
> > > 
> > > Devices track event log overflow by incrementing a counter and tracking
> > > the time of the first and last overflow event seen.
> > > 
> > > Software queries events via the Get Event Record mailbox command; CXL
> > > rev 3.0 section 8.2.9.2.2.
> > > 
> > > Issue the Get Event Record mailbox command on driver load.  Trace each
> > > record found with a generic record trace.  Trace any overflow
> > > conditions.
> > > 
> > > The device can return up to 1MB worth of event records per query.  This
> > > presents complications with allocating a huge buffers to potentially
> > > capture all the records.  It is not anticipated that these event logs
> > > will be very deep and reading them does not need to be performant.
> > > Process only 3 records at a time.  3 records was chosen as it fits
> > > comfortably on the stack to prevent dynamic allocation while still
> > > cutting down on extra mailbox messages.
> > > 
> > > This patch traces a raw event record only and leaves the specific event
> > > record types to subsequent patches.
> > > 
> > > Macros are created to use for tracing the common CXL Event header
> > > fields.
> > > 
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > 
> > Hi Ira,
> > 
> > A question inline about whether some of the conditions you are checking
> > for can actually happen. Otherwise looks good to me.
> > 
> > Jonathan
> >   
> 
> [snip]
> 
> > > +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> > > +				    enum cxl_event_log_type type)
> > > +{
> > > +	struct cxl_get_event_payload payload;
> > > +	u16 pl_nr;
> > > +
> > > +	do {
> > > +		u8 log_type = type;
> > > +		int rc;
> > > +
> > > +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVENT_RECORD,
> > > +				       &log_type, sizeof(log_type),
> > > +				       &payload, sizeof(payload));
> > > +		if (rc) {
> > > +			dev_err(cxlds->dev, "Event log '%s': Failed to query event records : %d",
> > > +				cxl_event_log_type_str(type), rc);
> > > +			return;
> > > +		}
> > > +
> > > +		pl_nr = le16_to_cpu(payload.record_count);
> > > +		if (trace_cxl_generic_event_enabled()) {
> > > +			u16 nr_rec = min_t(u16, pl_nr, CXL_GET_EVENT_NR_RECORDS);  
> > 
> > Either I'm misreading the spec, or it can't be greater than NR_RECORDS.  
> 
> Well...  I could have read the spec wrong as well.  But after reading very
> carefully I think this is actually correct.
> 
> > "The number of event records in the Event Records list...."  
> 
> Where is this quote from?  I don't see that in the spec.

Table 8-50 Event Record Count (the field we are reading here).

> 
> > Event Records being the field inside this payload which is not big enough to
> > take more than CXL_GET_EVENT_NR_RECORDS and the intro to Get Event Records
> > refers to the number being restricted by the mailbox output payload provided.  
> 
> My understanding is that the output payload is only limited by the Payload Size
> reported in the Mailbox Capability Register.Payload Size.  (Section 8.2.8.4.3)
> 
> This can be up to 1MB.  So the device could fill up to 1MB's worth of Event
> Records while still being in compliance.  The generic mailbox code in the
> driver caps the data based on the size passed into cxl_mbox_send_cmd() however,
> the number of records reported is not changed.

Indeed I had that wrong.  I thought we passed in an output payload length whereas
we only provide "payload length" which is defined as being the input length in 8.2.8.4.5

> 
> > 
> > I'm in favor of defense against broken hardware, but don't paper over any
> > such error - scream about it.  
> 
> I don't think this is out of spec unless the device is trying to write more
> than 1MB and I think the core mailbox code will scream about that.
> 
> >   
> > > +			int i;
> > > +
> > > +			for (i = 0; i < nr_rec; i++)
> > > +				trace_cxl_generic_event(dev_name(cxlds->dev),
> > > +							type,
> > > +							&payload.record[i]);
> > > +		}
> > > +
> > > +		if (trace_cxl_overflow_enabled() &&
> > > +		    (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW))
> > > +			trace_cxl_overflow(dev_name(cxlds->dev), type, &payload);
> > > +
> > > +	} while (pl_nr > CXL_GET_EVENT_NR_RECORDS ||  
> > 
> > Isn't pl_nr > CXL_GET_EVENT_NR_RECORDS a hardware bug? It's the number in returned
> > payload not the total number.  
> 
> I don't think so.  The only value passed to the device is the _input_ payload
> size.  The output payload size is not passed to the device and is not included
> in the Get Event Records Input Payload.  (Table 8-49)
> 
> So my previous code was wrong.  Here is an example I think which is within the
> spec but would result in the more records flag not being set.
> 
> 	Device log depth == 10
> 	nr log entries == 7
> 	nr log entries in 1MB ~= (1M - hdr size) / 128 ~= 8000
> 
> Device sets Output Payload.Event Record Count == 7 (which is < 8000).  Common
> mailbox code truncates that to 3.  More Event Records == 0 because it sent all
> 7 that it had.
> 
> This code will clear 3 and read again 2 more times.
> 
> Am I reading that wrong?

I think this is still wrong, but for a different reason. :)
If we don't clear the records and more records is set, that means it didn't
fit in the mailbox payload (potentially 1MB)  then the next read
will return the next set of records from there.

Taking this patch only, let's say the mailbox takes 4 records.
Read 1: Records 0, 1, 2, 3 More set.
   We handle 0, 1, 2
Read 2: Records 4, 5, 6 More not set.
   We handle 4, 5, 6

Record 3 is never handled.

If we add in clearing as happens later in the series, the current
assumption is that if we clear some records a subsequent read will
start again.  I'm not sure that is true. If it is spec reference needed.

So assumption is
Read 1: Records 0, 1, 2, 3 More set
  Clear 0, 1, 2
Read 2: Records 3, 4, 5, 6
  Clear 3, 4, 5 More not set, but catch it with the condition above.
Read 3: 6 only
  Clear 6

However, I think a valid implementation could do the following
(imagine a ring buffer with a pointer to the 'next' record to read out and
 each record has a 'valid' flag to deal with corner cases around
 sequences such as read log once, start reading again and some
 clears occur using handles obtained from first read - not that
 case isn't ruled out by the spec as far as I can see).

Read 1: Records 0, 1, 2, 3 More set.  'next' pointer points to record 4.
  Clear 0, 1, 2
Read 2: Records 4, 5, 6 More not set. 'next' pointer points to record 7.
  Clear 4, 5, 6

Skipping record 3.

So I think we have to absorb the full mailbox payload each time to guarantee
we don't skip events or process them out of order (which is what would happen
if we relied on a retry loop - we aren't allowed to clear them out of
order anyway 8.2.9.2.3 "Events shall be cleared in temporal order. The device
shall verify the event record handles specified in the input payload are in
temporal order. ... "). 
Obviously that temporal order thing is only relevant if we get my second
example occurring on real hardware.  I think the spec is vague enough
to allow that implementation.  Would have been easy to specify this originally
but it probably won't go in as errata so we need to cope with all the
flexibility that is present.

What fun and oh for a parameter to control how many records are returned!

Jonathan


> 
> >   
> > > +		 payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
> > > +}  
> > 

> 

