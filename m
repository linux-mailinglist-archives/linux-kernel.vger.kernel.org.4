Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310FB63F35D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiLAPNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLAPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:13:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77BB9953F;
        Thu,  1 Dec 2022 07:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669907612; x=1701443612;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eZl63vgJcKyX15rt1Tw+xTKWpRZWboUDjb3fIMJ2INI=;
  b=lEgGM3gO+r8LX6bzw6adyFGyAeFeTVZ3/92xMZTWel/GKafyN02RXv6m
   DYKCUtjr6EFheXINyTAJaZDGw6+7GR0PoMfymKU+E6169FU+SY28EVxP2
   Zm5e3JydxSmJQf+MXvxX0WOuwqFSbjkZjrueu4tw6kMLH3OjK2DvMsJz0
   lJGcp5HLWSUCDP2reP3PJShhOEcblmEbbkNXyoNMiM5QH/T36hffhXmXY
   jeEVPAqOE9qik97arojGuGiDxH4HCIWqKTXSZ2dAmggxu3h8EBK327JGI
   bJZ4QsS21rKnrnKuda2qA95ZqkjhEFuTdsRpPO11Z94WUzfhNHmcH3BhE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="295401198"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="295401198"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 07:11:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="638417253"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="638417253"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 01 Dec 2022 07:11:09 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 07:11:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 07:11:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 07:11:08 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 07:11:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX5Yo/JBg3HMRRFFdFqf5czw7zpOekKHARrLGFsUNex9CKK3guh5WdABVKEJdbArfsIIra68liFfP7Iim05JF+vgDMfajujOKT9LTlM1Vy+JibiPkoKcjkaytfGguoBOI1m13rEIBx4VOTOIqg+8D0sY2k+rTuzZ3dpGGYRRRrwKInOoH6AEabZdQrPzDB894EH+tcUTDSsjYW5i2m8EhYIHe6V3l6nu/JWCqrpUyArM7KvhR48h8tWDtXu0HctKcvS82G8d+xrkfFD7Ek9SLvll/tBbfgAPIztiWTPFl5OQzZqkt183hIT1osPqnzkQo9aH6lNZ/vfnYuP5s7HLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDE4pK6cYI714tR5497q1d0cga8e8B2iGGPxw88tgvI=;
 b=httN8r6layfwpJuFdiG0HI5fxQ8nI93YYcff2H/gjt3+JPj9/otYDaV/bT4GJeBCExQ4XtT5fXtDMT9mgXZI1sXF6Vs/Nj1AzDDCLDyHNt+X6/wd5gwefixrrQ332hG1fTHPoek6tkc9ZVjUMcWG13pgXxjGRL/acRR+LHtE1be6bkcfNH1KHSjC2GDr5DA66wTz9lY3VabWQWlchu3qM/cSJo90TsBpHyKKbgAOz+6FUqaMTKFFNFmoPUVx7ROGMM5+Qkt5h9wTBxinR76GKpX18/mGgP6V2b7haI9Dm1XXWIM/QJ4XJjbehlnasxFzQCG9vwaghUyrsWFjlxUA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6124.namprd11.prod.outlook.com (2603:10b6:208:3ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 15:11:04 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 15:11:04 +0000
Date:   Thu, 1 Dec 2022 07:10:59 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <Y4jEA5Q/GU0EeBnf@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-3-ira.weiny@intel.com>
 <20221201130650.00007f3d@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201130650.00007f3d@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c5270c-0c07-4186-0d16-08dad3ae43db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJgfBLyi6OVnGiTvhgGq+fsYhnDGvgP/gf3ZVnU1zmDSAJVAGinftaxdE0fJvz8lYNC+km07u6S0IiK3LMjjpzDFKOIjm3GN5CUqqvUp0SD1++FEDuDryhL1RuMDlDCIVuWmwWhlz6Qp7hMB5vkvSvLYhe1N/5j8Wh1E5bFCkdi+NLgE1Up5f6iFd2rhJJdcdZDUJZYcQTi1SPBbNq8w2cdRnO9P7UxVtZwKtijQWrU1WANuPD/PHYAezQtlUm6J8i1IX3kVAyZTC4suL8JQuUbtYvPG2+U229f9nYeI+0UO2fnDaq7DLyYAezlan76fp4PJDrg0QOg5OQIURnHJ6wlq7l1HpHU70XdmHjt4Q/O1x+z2xl/uSaOSY8pTLipcMedxDtkE9I/WZc8pvtwxAgjRsdK7Z3NzhkUShVipx5z1FwIbyq3q9/dOZpQkQwb2UdUlKRCbEYPJfJohPm05KIwk3smg95wDsKTB9+g9+BynNvlEf6RvhrjAcUAr6XB+zTjNxj/5HsUnFBZOC6NLH/ddcJSgfyvxiu36xKJC/eip33HOkkaq/AXZyNm7CfHSJzBIlMIFMFTR3ZHd04O/aVmtTIL2VkUUyqs/dRnhsph8s3AA3nuE4VUO2ih4y4jZl3oM4Kknb4KuZmAB/6VDlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(83380400001)(2906002)(6486002)(33716001)(41300700001)(186003)(478600001)(26005)(38100700002)(86362001)(6506007)(82960400001)(6666004)(8676002)(8936002)(4326008)(54906003)(44832011)(6916009)(9686003)(316002)(6512007)(66556008)(66946007)(66476007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LbaynqE6MkwXaN/Hn+RNkLrLw4ekc4DRP8xBnxPSZyeQZCLb6WBZlHDRjUmr?=
 =?us-ascii?Q?/s7G2dfl+6pigX/P/en3B9+9m7jZFJ03pR37h6v3+whPjjEvbwLDT+Y2Kx9v?=
 =?us-ascii?Q?kOQ9iZj4IDQzgsardEOSmlf0/EwjZQuS+knV32uU4/2QGNuXM2ftHIcuMobj?=
 =?us-ascii?Q?3xACtNbesgQVssh+qmpM677B0yyHUpIzsFQrz4C9oTKtt9t1nQ3v4ygeaCEl?=
 =?us-ascii?Q?D6QkSEyPa57P+nouIEkIwaSXrZtQEO3A6cRCWN/bxkQzZTdejje48ePyHxV6?=
 =?us-ascii?Q?wuc3Y/wSI5te3puxAbQOG/2xI+ok2Kt2dh1RCBm4ApmvyyJvwnnMAxwnKQN/?=
 =?us-ascii?Q?WSxga4h+2i92EQIFYLxaJa/beiuROO5C0tZCiZuQbpCAYa3ptgW+W0sIfmYd?=
 =?us-ascii?Q?YTQXmrnEbBuM5gZ9trte3HjHYvHu4ct28OZS2mbEiyRimOYDpfoq/9UmKAQo?=
 =?us-ascii?Q?l7zq6Km87IjvT4RNd7AtTYJkaR+agSPUyim+1yJvE4FYhfq3MGTZRluydra4?=
 =?us-ascii?Q?i6BcihxSVkk5W7nDwsXXEna10p2UzgA7H8SV3ppuWh053MINuGbsaf9pa0Cs?=
 =?us-ascii?Q?mcCRvmXMFnGMIFnmNrX497R9G9xgc5fYgtfCbhSWE74YjtaPpXIFUKf9/bbA?=
 =?us-ascii?Q?JYiJVYvIhpsh5mammd4DlWezyJXiOE9sB2qPs+dWjDnwDVqQbEMU6PQphTNR?=
 =?us-ascii?Q?YsplOf4JREXjAhkLGOzF9jRaKRLn/AvcdnUyiwKWLnXz5YsWqb1ZNG3xZfOn?=
 =?us-ascii?Q?N/xtScJZP5rL13bAQDZHZsPRvgJegzTcTW/M8nzfVqSYOb4Iyi+w+/Pe5NeT?=
 =?us-ascii?Q?NXUOhiNu+w/MJnjuIbbT4V9xd8moaR+x0PEnoaJ/z9+tNcEYsMv2gXQcYDlQ?=
 =?us-ascii?Q?G2U0AmH6LShS4HjGF2q8sUp6jeeVT7n20OcdN8ygrW9AJizptI1nKrF0TS+g?=
 =?us-ascii?Q?gCu2DGvd5/U/QQ4Ebi8j97FmQjFArTGPc5XzJjQJmm7X3Yt+633ENW8KBoiN?=
 =?us-ascii?Q?P/fQ4orFCYEeR5mxKnwL7kiqJQl10mt1FVDlFVJM2IJT47tyvomzniP9yapB?=
 =?us-ascii?Q?t52W6iIJso/ub/saSJQvPrHfG4uzZVk5kq67NEgHR+jcD+QHUYi72YD9EScJ?=
 =?us-ascii?Q?OYms2F6qB1xR5x8q+jqO6jr3U3FzUhrG1HsXXtg7hycu4l3FFwMQX8jA3JX9?=
 =?us-ascii?Q?qqPKnY0tp1dKrtFYE1P0KVOFAnVMLgDlTGIxCVsbXptCS45xf6a8zH9EdlVu?=
 =?us-ascii?Q?f9hc1syQABz85nwwHX5SAfA/N0X+2udoCIr0hIRi/5ukjCTbvAa9sW/x4Wm3?=
 =?us-ascii?Q?EpXiYOgkUwjAe+XkIbAjDTflk5xFpPNZXnJjGbmC//fyFPiBbCLaNhN/b2iW?=
 =?us-ascii?Q?Gi1IunPwP267W8DB2yNN4ubFw2V3JPdJ1FqnZfER8ssKe3HipIgpm2/oqp1O?=
 =?us-ascii?Q?92IY66Vx+zgUw9KJDtRq4lzadbxf61c5b35ElnZB9739j6E7WjQA0cJTIdDe?=
 =?us-ascii?Q?dgX+bWsBh7qGLUuBfQ8qu1BhTR8fks0KFAOHhnuftG/F+1Y1rcTjZqptVPEU?=
 =?us-ascii?Q?3GBGaVhzZnCNBZlufoppwrmsBwiPO27pBgujzNEr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c5270c-0c07-4186-0d16-08dad3ae43db
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:11:04.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9McDf2zChbdY6xhK/Ov8I95506ndZAxm/9JQYki+5kBmL92iN02NAk+us0CF0/vnmyFw6Pk1Uju60axzWU4Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 01:06:50PM +0000, Jonathan Cameron wrote:
> On Wed, 30 Nov 2022 16:27:10 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL devices have multiple event logs which can be queried for CXL event
> > records.  Devices are required to support the storage of at least one
> > event record in each event log type.
> > 
> > Devices track event log overflow by incrementing a counter and tracking
> > the time of the first and last overflow event seen.
> > 
> > Software queries events via the Get Event Record mailbox command; CXL
> > rev 3.0 section 8.2.9.2.2.
> > 
> > Issue the Get Event Record mailbox command on driver load.  Trace each
> > record found with a generic record trace.  Trace any overflow
> > conditions.
> > 
> > The device can return up to 1MB worth of event records per query.
> > Allocate a shared large buffer to handle the max number of records based
> > on the mailbox payload size.
> > 
> > This patch traces a raw event record only and leaves the specific event
> > record types to subsequent patches.
> > 
> > Macros are created to use for tracing the common CXL Event header
> > fields.
> > 
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Hi Ira,
> 
> Looks good to me.  A few trivial suggestions inline. Either way,
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 16176b9278b4..70b681027a3d 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -7,6 +7,9 @@
> 
> ...
> 
> > +
> > +static void cxl_mem_free_event_buffer(void *data)
> > +{
> > +	struct cxl_dev_state *cxlds = data;
> > +
> > +	kvfree(cxlds->event_buf);
> 
> Trivial, but why not just pass in the event_buf?

Just following the pattern that 'cxl_mem_*' functions take a cxlds parameter.
<shrug>

I'm going to leave this because it is tested.

> 
> > +}
> > +
> > +/*
> > + * There is a single buffer for reading event logs from the mailbox.  All logs
> > + * share this buffer protected by the cxlds->event_buf_lock.
> > + */
> > +static struct cxl_get_event_payload *alloc_event_buf(struct cxl_dev_state *cxlds)
> > +{
> > +	struct cxl_get_event_payload *buf;
> > +
> > +	dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> > +		cxlds->payload_size);
> > +
> > +	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> 
> huh. I assumed there would be a devm_kvmalloc() but apparently not..  Ah well

Nope I've learned my lesson and checked first!

> - whilst it might makes sense to add one, let's not tie that up with this series.

Yep I did not want to hold this up for something like that.

> 
> > +	if (buf && devm_add_action_or_reset(cxlds->dev,
> > +			cxl_mem_free_event_buffer, cxlds))
> > +		return NULL;
> 
> Trivial, but I'd go for a more wordy but more conventional pattern of
> 	if (!buf)
> 		return NULL;
> 
> 	if (devm_add_action_or_reset())
> 		return NULL

I've been beat up in the past for not combining statements before.  So I've a
bad habit sometimes.

This pattern is a bit more clear.  Since I'm adding the comment below I'll
change it.

> 	
> 	return buff;
> 	
> > +	return buf;
> > +}
> > +
> 
> ...
> 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index cd35f43fedd4..55d57f5a64bc 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -4,6 +4,7 @@
> >  #define __CXL_MEM_H__
> >  #include <uapi/linux/cxl_mem.h>
> >  #include <linux/cdev.h>
> > +#include <linux/uuid.h>
> >  #include "cxl.h"
> >  
> >  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> > @@ -250,12 +251,16 @@ struct cxl_dev_state {
> >  
> >  	bool msi_enabled;
> >  
> > +	struct cxl_get_event_payload *event_buf;
> Whilst it is obvious (and document at point of allocation),
> I think one of the static checkers still warns that all locks must
> have comments.  Probably easier to add one now than wait for the
> inevitable warning report.

Well 0-day did not complain.  :-/  But I know there are other checkers out
there; better to add now, thanks.

Thanks for the review,
Ira

> 
> > +	struct mutex event_buf_lock;
> > +
> >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> >  };
> >  
> 
> 
