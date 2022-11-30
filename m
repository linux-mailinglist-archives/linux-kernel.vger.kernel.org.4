Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF863D1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiK3Ja3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiK3Ja0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:30:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855244E427;
        Wed, 30 Nov 2022 01:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669800624; x=1701336624;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RbAcLWIAhm7Yujt8SvcfOnueIU2Fvtbyn6D7aItamHk=;
  b=l5fIksux0/H/+OaLfz5kCjaKwQtK85grW1xySR87NlxWPkc3Y3yr8sah
   isr8hWJWjv4jgPctoBb4/A4Fk50wuzEjnRoszqNJVSwKOHtnpB6m6N40L
   3LUDaN2G7v6vxXiNEwgjIdnpgorY9ecZmeuO6MMiwWE7eOrsyUtqF6C67
   uGV+bU8mfzMAd9BVSvQMQqaAMLg2Sg+sAPTQCO2vV5De98txtGUZNfIvN
   ePT5Xry7rwX3RDZTDqVJ0kmOtkHuIq2jqds7o5sFQqXiuBNsGn1njVK6m
   0BJdNUY43+lCCnmSzTeVj0Sz4U3ynL5UdViMqVNb2YOBYLxvWm55IG7b7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379629960"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="379629960"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 01:30:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="646262906"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="646262906"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 30 Nov 2022 01:30:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 01:30:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 01:30:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 01:30:20 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 01:30:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RU3l0He0iyXVa9yx1a6jY6jkKAhW+3pCIcoie8u/VYcuUIKBDk0YjhLcU902ac4Srea1V3uxJ+J3U2+GbMDxiBCylZGh5IVLH6eXFM+PyY7Bothx7PduK0n1UC7Vvw5wt9hS8ci29J0cNcw7pnD/nzxeYM2TzKppnlNMeR649EeApt4mTpGEWPeFzrd+ZvmlD12DK5QkxSPohYXIIEiWpkdyoLjMkjjeo7qcVtTjBvdWSLaefdIDvJeS6dr8/6x+Two5lUQ3Zo7bVUfieneo+P5MtfcaFhiXeNBIxzqc72jpBtHbfl0I7tWrWjnR3FkLc5XOw0DqSu3eggNihYfpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4n7ksRMW9Ugtxo2E0WiKkhguzPjtP4XGhXgJcu60Rw=;
 b=VPL3919dsvzBf3sKsUO87ffeZ1erpTvI/YzNiSbbn+5MjJCs/vF6jmcQVJ2scrVr1jWnFcXTpm+GbA7xKF2EFZ0qHVd07Ui/a+ycjNu30yi7HpJwE1RVV4EyhPIAhSuN+/yBqvdHMedTLmR5m06BeWAXdJeFr/OPVdmNEXff5OZ8obrPyrS2WLohqBelNi6D5ZznrHnzzSejGyN7UxjBHiXbPD3VryG/uYnSxR0j5NHVaw7ik4t2i0m1xSsitBoBi7f2a3dSkA+O17jvly+yMK85gs7QENsJe5DLhWE7ageLVEtjnUjF6v0zuKkC60fSauznsFqV+BHEP5plMtF9Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7333.namprd11.prod.outlook.com (2603:10b6:8:13e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 09:30:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 09:30:17 +0000
Date:   Wed, 30 Nov 2022 01:30:12 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 07/11] cxl/mem: Trace Memory Module Event Record
Message-ID: <Y4cipHMHN3s7EDEd@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-8-ira.weiny@intel.com>
 <20221116153528.00005af7@Huawei.com>
 <Y3WNLtyZYLQNMZzj@iweiny-desk3>
 <20221117112235.00003243@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221117112235.00003243@Huawei.com>
X-ClientProxiedBy: BYAPR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: c7926cdf-2d8b-4227-0c81-08dad2b57e0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GgOH+3qAK81QZPxwFQ1pzo1kwMTWQ+XuPgYoUIVd7ptBJqU3Cu0mk0/KUtOZmG2aLcRiMI817gruZRJ5OZ/TaqBMsifw+f5vAiJ+ouhpRMp9h6rLGRerTRXYt2ao2gUYyJRa98Sv9p6BX9YbuBUDpsHgw2ibpMCi8ez+aUhwrVyfmJWPMQeM57QbRKi7uW1hYRrc2KHXuRQtY+BGd3z6lG8MxcZNfrc4+CtEMPLbLcsQr0qQ9ME1ZLN3d5Ptiel46zf2o1BQyrUUg8y52rj6M+nd14k+TyIC4ObRZyDSVXZSsmjpEAsVOmLiwcAN1FHw9z6XcjkbncIwKgXZxFlnbRsAWiKoupYgJ/J8TGA0Lo0LGkBLP4QsrURVopiN95Nl0IjXwIaqaAKBCiRtW9wQh8BFuyiNJjHvb+kvVdcXxF2Os9avC7ylM0IhM8NHIX63aXO2/1+NpGT7ohc5ko8HzHw6UQ3RI6y+pc7mZsYp59RlfqPGkIYdrk/diWsDle/0xpu/unusmNpgaBCQ2R40mACjVfYQU+ln4XwydG+1EAtixM1tPkui3Y7t+7w+PzJtZLSY9rdVyUasbhlK7wsXbvmnA3CpJK2+5rYyj58To6K7vmtKwdSzb/IZxJb8Zpv+L/EhSr7FYLAX9HCqGnb5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(26005)(4326008)(6666004)(8676002)(44832011)(66946007)(82960400001)(66476007)(86362001)(66556008)(6506007)(6916009)(8936002)(54906003)(38100700002)(41300700001)(9686003)(6512007)(186003)(316002)(5660300002)(83380400001)(2906002)(33716001)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tvERXdelwdaY7sldpjY32/ED3J2uq28AGXIhzWlef4tF0pPJRS9AS+chWsxR?=
 =?us-ascii?Q?8d6pRIuqNzRa+qYbh5GP0jZN86dArL+9T/BKcjBlwSDdbInH1h3g0EBeu7tq?=
 =?us-ascii?Q?HNDlxChBAsWR2nibwUg6/vMkujnL+L2/l0FyhZxSy4lyasGJi5JPfhhdHijY?=
 =?us-ascii?Q?xf0+1LYj+p0Wf2uVmtViu2wX5myTJtcsNHUqKeGl/t2/iO6v1znVBE4iAYAn?=
 =?us-ascii?Q?VBR6Towmc9mb5UGYjjJeWmUIV40ttSNK/1P2NyQRCRQLsafmlRJp7t+apkJo?=
 =?us-ascii?Q?qZYO7CwXrhc5RVchED8AQpc7dc0/yp/3WqQz7yviUr0T0Z0a4LR1feM4Dfme?=
 =?us-ascii?Q?Hp/4fsl7Azug51Nt8/Z51DGchnvvSU/nLz6JL/X8c3dmHCj8M8Dow74otJpY?=
 =?us-ascii?Q?QoeqQqebvFH+fWVoXqCufc1b7vPJKXDhgIkd2wD/nT+y4SBj3w6mbbwsaSZE?=
 =?us-ascii?Q?za4CdEdO1b+ZH+aVrkZnY+YIX5uV5BZ4mqQARjHi5HjBAnmkk21XT4tO4uMa?=
 =?us-ascii?Q?nr1B8n0CxNNrIY05JtYs1YizCnIUy8nge9nVFkfg+pjIuYeBQoVGfRE5BORE?=
 =?us-ascii?Q?OQlS7tArUfsbu7vE1fZqAoI5NhV3Spg2sWG6V/XusMW5Hm3Qa3hhH4FevAoI?=
 =?us-ascii?Q?VfwnhFMrwoN3Sq4iTEtMiAV5zIm8PUeQpE+7NiX9QYnHuyazyODs+jf4mZOi?=
 =?us-ascii?Q?uHpgKrNHxVVwZDI/+UY9ylCjMLzEk3TY6owxKpIosL/jSSg3aK0tnY4jOImN?=
 =?us-ascii?Q?vWfpXLxHTrF7pgqryn1K5F+M4nQriO03RTeOItOI6tze3uT6WM7GqRd04+RQ?=
 =?us-ascii?Q?rioAUbM7yqvAZlRbsUcQ8kPrQhGYAbsL2u6g3f7x4wsbq1Wln8s1ak0KKm5m?=
 =?us-ascii?Q?rvKj+gW2+dR1rzTDnlCJv327strIiymTml/PXj+y5g9yT6+ArFs/Pk1zmLqC?=
 =?us-ascii?Q?n1YisR9YV1eEdiM6wJfENMU3m29hVBg3We3cjfSH0QVTswqfOVxFMFNbky3O?=
 =?us-ascii?Q?21khyAqwk63MSyA6e/p3O6QtTZw0y8An3V2heDVHGW1TdsHep/wbdI5bZJdX?=
 =?us-ascii?Q?iMce/fv+hxwN+iHnMZ8BVz5AdUfdJCGwR9YU4amR3igbZEWmiuSj3JQ12t93?=
 =?us-ascii?Q?s1fwYuyDWTXIXygHAPa+atKkd6rFVQiiTeGciQ5ERwzq/WrzwtX4oPK3029p?=
 =?us-ascii?Q?7utpwO5sTdli4OywFqu79QQgkTXCveKp9kbTGKp3fdjTdQ1hheJbeftZVVT9?=
 =?us-ascii?Q?AQo2Twg7UtXuKKsyNMMNBKidAcN+KcXh63wydjHDoiQzj/zcPY0QmfUbRJKh?=
 =?us-ascii?Q?GdRJ+uMc7Zzw1XnawcrbJW5Sq8/sr8FVHMBmSWaSDkQTmq2xS/DMIZ81K649?=
 =?us-ascii?Q?XFicoDNzA63XoVxlmSxwdrBj0R+l3Sc1lEeNRqmC2ztET8wkCKxSJnvYTiID?=
 =?us-ascii?Q?elATeFwn6opI+Zaq/NBXIImwgoICJyyQ+tEKZoHhhlTDQLEwKEp94QEKKKzh?=
 =?us-ascii?Q?c93ukkoqQKSM1Vx//TMCDIPvS2T8lZjPlPl9hF7vV0GDBPo0l3e+yGIPV0Hb?=
 =?us-ascii?Q?Tjx1LHEF6yv8FlSo6l0sTfVIAPgzNa8tCy0O550p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7926cdf-2d8b-4227-0c81-08dad2b57e0c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 09:30:17.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDg8ZPlG5IGn++EhQ2dTtpjsNPMbRkF7bkemWFq8NPiYDLyZxK65Q1GD6Cp8gjZO2ndgNisl2ORPtsa2H0EjEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7333
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:22:35AM +0000, Jonathan Cameron wrote:
> On Wed, 16 Nov 2022 17:23:58 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Wed, Nov 16, 2022 at 03:35:28PM +0000, Jonathan Cameron wrote:
> > > On Thu, 10 Nov 2022 10:57:54 -0800
> > > ira.weiny@intel.com wrote:
> > >   
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> > > > 
> > > > Determine if the event read is memory module record and if so trace the
> > > > record.
> > > > 
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > >   
> > > Noticed that we have a mixture of fully capitalized and not for flags.
> > > With that either explained or tidied up:
> > > 
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >   
> > > > +/*
> > > > + * Device Health Information - DHI
> > > > + *
> > > > + * CXL res 3.0 section 8.2.9.8.3.1; Table 8-100
> > > > + */
> > > > +#define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
> > > > +#define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
> > > > +#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
> > > > +#define show_health_status_flags(flags)	__print_flags(flags, "|",	   \
> > > > +	{ CXL_DHI_HS_MAINTENANCE_NEEDED,	"Maintenance Needed"	}, \
> > > > +	{ CXL_DHI_HS_PERFORMANCE_DEGRADED,	"Performance Degraded"	}, \
> > > > +	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"Replacement Needed"	}  \  
> > > 
> > > Why are we sometime using capitals for flags (e.g patch 5) and not other times?  
> > 
> > Not sure what you mean.  Do you mean this from patch 5?
> Nope
> 
> +#define CXL_DPA_VOLATILE			BIT(0)
> +#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
> +#define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
> +	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
> +	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
> +)
> +
> 
> Where they are all capitals.  I thought that was maybe a flags vs other fields
> thing but it doesn't seem to be.

I've not made all flags capital on this and other patches.

Ira

> 
> 
> > 
> > ...
> >         { CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,         "Uncorrectable Event"   }, \
> >         { CXL_GMER_EVT_DESC_THRESHOLD_EVENT,            "Threshold event"       }, \
> >         { CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,       "Poison List Overflow"  }  \
> > ...
> > 
> > Threshold event was a mistake.  This is the capitalization the spec uses.
> > 
> > Bit[0]: Uncorrectable Event: When set, indicates the reported event is
> >         ^^^^^^^^^^^^^^^^^^^
> > uncorrectable by the device. When cleared, indicates the reported
> > event was corrected by the device.
> > 
> > Bit[1]: Threshold Event: When set, the event is the result of a
> >         ^^^^^^^^^^^^^^^
> > threshold on the device having been reached. When cleared, the event
> > is not the result of a threshold limit.
> > 
> > Bit[2]: Poison List Overflow Event: When set, the Poison List has
> >         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > overflowed, and this event is not in the Poison List. When cleared, the
> > Poison List has not overflowed.
> > 
> > 
> > I'll update this 'Event' in patch 5.  Probably need to add 'Event' to the
> > Poison List...
> > 
> > Ira
> 
