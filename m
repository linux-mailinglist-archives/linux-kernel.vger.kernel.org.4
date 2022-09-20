Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDC75BEAE1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiITQLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiITQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:11:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64576C10F;
        Tue, 20 Sep 2022 09:11:37 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MX62B2hLwz67bhp;
        Wed, 21 Sep 2022 00:09:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 20 Sep 2022 18:11:35 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 17:11:35 +0100
Date:   Tue, 20 Sep 2022 17:11:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 6/9] cxl/mem: Trace Memory Module Event Record
Message-ID: <20220920171134.000033a9@huawei.com>
In-Reply-To: <YyJE2uuPZQqqpVew@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-7-ira.weiny@intel.com>
        <20220825115842.000049a0@huawei.com>
        <YyJE2uuPZQqqpVew@iweiny-desk3>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
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

On Wed, 14 Sep 2022 14:17:14 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Thu, Aug 25, 2022 at 11:58:42AM +0100, Jonathan Cameron wrote:
> > On Fri, 12 Aug 2022 22:32:40 -0700
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > CXL v3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> > > 
> > > Determine if the event read is memory module record and if so trace the
> > > record.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > Similar comments to on previous patches around using
> > get_unaligned_le*()  
> 
> Yep...
> 
> [snip]
> 
> > >  
> > > +/*
> > > + * Get Health Info Record
> > > + * CXL v3.0 section 8.2.9.8.3.1; Table 8-100
> > > + */
> > > +struct cxl_get_health_info {
> > > +	u8 health_status;
> > > +	u8 media_status;
> > > +	u8 add_status;
> > > +	u8 life_used;
> > > +	u16 device_temp;  
> > 
> > As previous - even though they aren't aligned, I'd have thought
> > __le16 etc will still work.  The unaligned accessors are fine
> > taking __le16 * for example.  
> 
> Ok my bad on using u16 here and I will change it.  I 100% agree that these
> should be __le16/__le32.  That said there is no need to use the unaligned
> accessors for the 16/32 bit fields.
> 
> The unaligned accessors cast the pointer to a __le16/__le32 type and no
> architecture redefines those.  So using le{16,32}_to_cpu() should work just
> fine on all archs.

If they are unaligned, make sure to use the unaligned accessors.

Key is that it's not a simple cast, but rather a cast to a packed
structure.  The C spec guarantees that those will be handled correctly
even on platforms that don't do unaligned accesses - it will have to
use multiple instructions to construct the unaligned access from
a set of small aligned ones.
The C Spec doesn't guarantee the same for a simple cast to an __le16.

There are some hints on this in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/asm-generic/unaligned.h?id=778aaefb8e864fc61f850539ea479554dd4caea1

I recall a full explanation of why this worked, but no idea where
to find that now - might be the thread referred to in that patch from
Arnd.

Jonathan


> 
> [snip]
> 
> > > +
> > > +	TP_fast_assign(
> > > +		/* Common */
> > > +		__assign_str(dev_name, dev_name);
> > > +		memcpy(__entry->id, &rec->hdr.id, UUID_SIZE);
> > > +		__entry->log = log;
> > > +		__entry->flags = le32_to_cpu(rec->hdr.flags_length) >> 8;
> > > +		__entry->handle = le16_to_cpu(rec->hdr.handle);
> > > +		__entry->related_handle = le16_to_cpu(rec->hdr.related_handle);
> > > +		__entry->timestamp = le64_to_cpu(rec->hdr.timestamp);
> > > +
> > > +		/* Memory Module Event */
> > > +		__entry->event_type = rec->event_type;
> > > +
> > > +		/* Device Health Info */
> > > +		__entry->health_status = rec->info.health_status;
> > > +		__entry->media_status = rec->info.media_status;
> > > +		__entry->life_used = rec->info.life_used;
> > > +		__entry->dirty_shutdown_cnt = le32_to_cpu(rec->info.dirty_shutdown_cnt);
> > > +		__entry->cor_vol_err_cnt = le32_to_cpu(rec->info.cor_vol_err_cnt);  
> > 
> > I've lost track, but my guess is some / all of these need the unaligned_get_le32()
> > etc rather than aligned form.  Maybe just be lazy and use the unaligned versions
> > even when things happen to be aligned - then we don't have to think about it
> > when reviewing :)  
> 
> See above.  I think the 16/32 bit fields work as intended except for my lack of
> using the correct type.
> 
> Ira

