Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3778D62D951
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbiKQLWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiKQLWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:22:38 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2380C2F3B6;
        Thu, 17 Nov 2022 03:22:38 -0800 (PST)
Received: from frapeml100004.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NCcs62FtSz67bjw;
        Thu, 17 Nov 2022 19:20:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 12:22:36 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 11:22:35 +0000
Date:   Thu, 17 Nov 2022 11:22:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 07/11] cxl/mem: Trace Memory Module Event Record
Message-ID: <20221117112235.00003243@Huawei.com>
In-Reply-To: <Y3WNLtyZYLQNMZzj@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-8-ira.weiny@intel.com>
        <20221116153528.00005af7@Huawei.com>
        <Y3WNLtyZYLQNMZzj@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Wed, 16 Nov 2022 17:23:58 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Wed, Nov 16, 2022 at 03:35:28PM +0000, Jonathan Cameron wrote:
> > On Thu, 10 Nov 2022 10:57:54 -0800
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> > > 
> > > Determine if the event read is memory module record and if so trace the
> > > record.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >   
> > Noticed that we have a mixture of fully capitalized and not for flags.
> > With that either explained or tidied up:
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> > > +/*
> > > + * Device Health Information - DHI
> > > + *
> > > + * CXL res 3.0 section 8.2.9.8.3.1; Table 8-100
> > > + */
> > > +#define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
> > > +#define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
> > > +#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
> > > +#define show_health_status_flags(flags)	__print_flags(flags, "|",	   \
> > > +	{ CXL_DHI_HS_MAINTENANCE_NEEDED,	"Maintenance Needed"	}, \
> > > +	{ CXL_DHI_HS_PERFORMANCE_DEGRADED,	"Performance Degraded"	}, \
> > > +	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"Replacement Needed"	}  \  
> > 
> > Why are we sometime using capitals for flags (e.g patch 5) and not other times?  
> 
> Not sure what you mean.  Do you mean this from patch 5?
Nope

+#define CXL_DPA_VOLATILE			BIT(0)
+#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
+#define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
+	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
+	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
+)
+

Where they are all capitals.  I thought that was maybe a flags vs other fields
thing but it doesn't seem to be.


> 
> ...
>         { CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,         "Uncorrectable Event"   }, \
>         { CXL_GMER_EVT_DESC_THRESHOLD_EVENT,            "Threshold event"       }, \
>         { CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,       "Poison List Overflow"  }  \
> ...
> 
> Threshold event was a mistake.  This is the capitalization the spec uses.
> 
> Bit[0]: Uncorrectable Event: When set, indicates the reported event is
>         ^^^^^^^^^^^^^^^^^^^
> uncorrectable by the device. When cleared, indicates the reported
> event was corrected by the device.
> 
> Bit[1]: Threshold Event: When set, the event is the result of a
>         ^^^^^^^^^^^^^^^
> threshold on the device having been reached. When cleared, the event
> is not the result of a threshold limit.
> 
> Bit[2]: Poison List Overflow Event: When set, the Poison List has
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> overflowed, and this event is not in the Poison List. When cleared, the
> Poison List has not overflowed.
> 
> 
> I'll update this 'Event' in patch 5.  Probably need to add 'Event' to the
> Poison List...
> 
> Ira

