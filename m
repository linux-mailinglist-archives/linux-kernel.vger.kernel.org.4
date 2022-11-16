Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F421062CF15
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiKPXtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiKPXtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:49:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC48424F16;
        Wed, 16 Nov 2022 15:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668642538; x=1700178538;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vT8ss5VTS1uEKBDjcGV+klz5xg2oF17SGKsc0ydfIfk=;
  b=IVjO+mhA/SYqrQw59l46xXStchmMo5hzpSCoIKxgGs4+IsKz5lraWz9Y
   wHbLsoB9tRF+UOeOkW3Q6XkUrz/OVjYDvwfaceOtZwIeilHqMaZAkam2W
   SiZ+VdGNs7oH80HBVQRWFEmkorpoYF4n97AIyIxeYB06F0PRyYEwsZF5x
   RoAPIvO3Rk3s+PoKTiimBk7qhm7XsZO4u8D78+W12nfV1w7KCFl962BIB
   wi0qFiTNilm0+kzQXmKRSgw/7I7BBK8rAbDT9t2pIF5g8vi0Bg4ULxZi2
   IK0dlGSHuH5kzjCoX/KWxSyBQh/EepLci7BbLSqbMhiO5Ie4Bt1BWk4Ts
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="313849386"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="313849386"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 15:48:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="703080824"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="703080824"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 16 Nov 2022 15:48:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 15:48:57 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 15:48:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 15:48:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 15:48:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfJaAm2BwrUeNWV9S9VTP7sX972J0JCdym5+weDVdUCbsevSRO0+z2FSidPQ+C9GanoAE8evk/Bp7bOdUSfNFrtQYhdGsZeoLFKdTFW+YuBFn/MaJMaY55Qumel8l+eNuiRTvOW7AhFYXnAq26BbCXPluXewa4tDfznrdENHxq1236k3wyRh5i+50BJ+Ucq/LUGeIscY2fQd11xtD923UdBMWAT4F6S8cpKfwKwZeUdAUnrgq8FwpIo3IudUCMLATx5mNWlNkS8aZp2stcRy5so/6kD389GO28fQ7Z6ad68sS5LKVDHvOYKcy600IQe9oODikKqwwvyD15NUN+YvdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6hfCfNlbu7aCLsUS+JzCl8f/GfbErZ/f0Q8Jmifj5Y=;
 b=T0O599nDwIOXDfTbOEY/BXhdHsQrnuyEc9HKqG3B9SGg0ICq0nn1PTKK5k7Z9kVkZ279ox2xac53tg6tqSQ0pHGGXi+SX4Es5v0QRihoPpZPsImx5gKYtsWH50403n/1/HhcWDUMZv3gCMM7Og6LBbodQ5P2qrkXaxyaaWtDBwp2xk3QZn9DWNdGyzS3fWP06gHBxTuksWdMCMIX5HKSRGo26nbc/KTMea+9yS5geVUH1MQVpfx7s6EDObkiGfe213VTRTQ5QJdcVtO8GvpCnJ2MsAyl0Kff8XU/R+Hoekb8i9RMBtb6082rqx2z3CPMxT5fmtt4r0+WTRDKtvxCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV2PR11MB6021.namprd11.prod.outlook.com (2603:10b6:408:17e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 23:48:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 23:48:53 +0000
Date:   Wed, 16 Nov 2022 15:48:48 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 01/11] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <Y3V24PrgL0aN9P08@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-2-ira.weiny@intel.com>
 <20221116145341.00006411@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116145341.00006411@Huawei.com>
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV2PR11MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 943fc4ce-4d50-4657-3de6-08dac82d1e38
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/LulyycB26WGikZg6wmwSSyJ07W9m/6PLcRS6CoJzlD1zidS69iPZQLpJoC05J/QQlRHkQ4ZsntrsWoz1WxELNDrNR2kVDhORlRq+8LReQtpQUsSsLHbkwF7+/PqP93o1np0CwW2kpj2QI67FxqijD0zENixRu8+hcmLC/eQXa6XtsSaqyAcMYGs0B32kshVlAtqa4lcfIZL2WT7QWp872sHRUPge3HUssf0UMRPyaWMACzrNYYwlLdeAL8pIGQ4VO+OvwaqWtJcLy6xz/dUIfwAwqiWIhJtgNaaZV2UADSFySi9nyTW36arVj36wZLkujzQgIB7iWOCduEzXznGpmTF7ZyPwN696tbLuuOzdtL9GGru3vJ/ak1/1FLAv8INYECAKvvtV1dyGH68nCIcr/QUisRTERZ+YZdppiXaJX6y6n+3cubCdRh053i3Y/ARBsFJZntAHEk9yAUJLlXxPmdbeQF5ydmjWgw5zkX7QXzEJrlnT0dt+TAZRe5OHzur2RWAShJc6HtOAsnXFKYx/Chxmkor5WavJqmrRceOrUujuqKK6GuBJAEKPZUcqUxBJohl4vTKDJGmqW1E1QTByyVaxdMbhQMEmRS39M5zZ00ZEd+kQTZCvqf1sCypRiK0+rr+QbNGMMI/Rya8FyJd1JC6u90HVsTsX3NG7yLJfzhLJgzZn92h9pswRYVLHjjaFcPKKogF3NIK3O9UINY7vKn06uLF8p7vF7xg4VTXwceSg6X1S7sr1G8cLxuIM0R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(82960400001)(9686003)(26005)(6506007)(6512007)(6486002)(8676002)(4326008)(66556008)(66946007)(66476007)(83380400001)(478600001)(6666004)(5660300002)(86362001)(41300700001)(186003)(44832011)(8936002)(33716001)(2906002)(38100700002)(316002)(6916009)(54906003)(66899015)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Z4BfdDQ2CIm2A/fXq3ZnbCyGO5a7Ikb0s1kK/fIuMI/4BxG4Nm4eANHhCe7?=
 =?us-ascii?Q?/8cj8gXL3XjxIGm6K1LtRfngl8ftswPZQ4QiR6vDJxz/G32OakkGkr5n1wl2?=
 =?us-ascii?Q?+rGFNVikrNzZ1ksLqcgCwp9H9AiqUAPr9LqXNxiAMsyW3viFTf4yHJ9GNDHJ?=
 =?us-ascii?Q?QS+QaOE+NNUFnMjXoBd2qd4WESSmKcGBECsTSgjAyJwbAgL3/+aJXFFsaIiH?=
 =?us-ascii?Q?aHYH2CisQ0VYRAylyV9ZYGVk9n7mJv+1HoVmkSzyDo56dcEtSjBHvpdXLP+p?=
 =?us-ascii?Q?c/pkqhMhTsN/PfnHgNHidg3uPBfgRWI5Par+0csaAFA14vhK12SRBZFQfW6Y?=
 =?us-ascii?Q?yrUx/R60MOkR0rKDvpsHVB5jlSWorPZtP/hhse6WGif9gYHRsv4KU6ciqzHi?=
 =?us-ascii?Q?JRfHUbahNndY2nygB4oXHVuhlrgA87tFUcfn+i/TISPEqcmWD80f841J/amt?=
 =?us-ascii?Q?15ScXhIG9STh1OtysbONbe4ohH17zD4bpyY0Z8NbP0vUEU8jWapMEXHrtW7O?=
 =?us-ascii?Q?EmmscPvwyCgWbjxwTnjyRPPQrh4McGFEg0HkYnyJswX01MGYMWx6C4RSfKN9?=
 =?us-ascii?Q?cFyedtWkbx+8VL0eNnY4ga2hmsjCJ6hZa+p2wog5vjhOWJOcvcuCx6KbkdNC?=
 =?us-ascii?Q?D7wTXPgIfhS5pw+50L42iegVAYMUM+2Bxw5ZnNfw7hD2H9GPKNFNfD6QUmIL?=
 =?us-ascii?Q?V34OAcHEuo0vxqI/ahH4/rbRMbZAfh+7uQ6yKIEHzsAkPYSEKv3FaO3Hzeir?=
 =?us-ascii?Q?ABS5eUDiDw+HvU6ERd1mvE850Rb9O8y0YqoPDNtfl4ZyP4xortOplhkY1iNp?=
 =?us-ascii?Q?5Ew0J6gWUFYh2MGxJBkyjNDzJDgmxBP3RyemZC3q4vgEHq/eSgPgWM/k0kKY?=
 =?us-ascii?Q?ikW2PVJIdP7xEVxgRMsSSzGex1EhDvZFYj0bPCrpCR0jyII24cpsUbSUIVJ1?=
 =?us-ascii?Q?yCmj0CvKFAhWEE0Tx29cMYz1ke4lCYsNLURDvYnWaW9lmViNYqSowbGTfdch?=
 =?us-ascii?Q?5UsI58+zsvE0I5cogQ9HE3xXnRazbt88AZOOGHf1663d32Z3sIQvZdqZBPv3?=
 =?us-ascii?Q?65mIk8JUGIwpXtuYzG2Ko3Ot7ri+uRZz+VDufZlyWsCO1jFzELrAS8MHbcJR?=
 =?us-ascii?Q?eZIh+ptZTdO5Rn1XNJ3qqRa6p8J6R14Uawc1tshmL6O7k8Eunn1R/jKUMIFz?=
 =?us-ascii?Q?vi6egHCvmfRx4AjX4U5I7/kEzott98BcysQHvbd3qlrniN2Na4gVmvCFoSLi?=
 =?us-ascii?Q?BMtyrwD0JMxg6J1vfQhWvtRsJLJmFkws0eeGz6EC92vRCQmK9KXnk92S4CaN?=
 =?us-ascii?Q?GgaOBx/9wRMsTjlh4tu/0czIBnjVKix8IWN5QhW3xN+YTjS/T4jsNc7IPFtG?=
 =?us-ascii?Q?TUZQh09Rz8B6U2zvXlpi+30sn5HIsv+yuoqRtb+tvyBuZc1yjfaYMLNWAaHx?=
 =?us-ascii?Q?VJ9hzS8ZUbxKsNqU55DnKzwfOaSEaLjyeYaSBp28cOCuJv3qoggssXnuKUpC?=
 =?us-ascii?Q?sACS3g9LREDRouwiGK3Jdz+cRQ8DmAHZ2R8Zg8jv6SzSOhEfQtCV2c3jXKC/?=
 =?us-ascii?Q?HmI4Qy87kLXcrUgU7WQaxCzQtaw6z1hYKVV69+Ga?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 943fc4ce-4d50-4657-3de6-08dac82d1e38
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 23:48:53.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1t5lzvJSnMpQWv+ObqUVnaCMdEandkc0j/6R6FNuVYfVb5M9y0d8dzG3ZFKEvL0nBHI2VXPkRxwRHMZtDwRo6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6021
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:53:41PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Nov 2022 10:57:48 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Davidlohr Bueso <dave@stgolabs.net>
> > 
> > Currently the only CXL features targeted for irq support require their
> > message numbers to be within the first 16 entries.  The device may
> > however support less than 16 entries depending on the support it
> > provides.
> > 
> > Attempt to allocate these 16 irq vectors.  If the device supports less
> > then the PCI infrastructure will allocate that number.  Store the number
> > of vectors actually allocated in the device state for later use
> > by individual functions.
> See later patch review, but I don't think we need to store the number
> allocated because any vector is guaranteed to be below that point

Only as long as we stick to those functions which are guaranteed to be under
16.  If a device supports more than 16 and code is added to try and enable that
irq this base support will not cover that.

> (QEMU code is wrong on this at the momemt, but there are very few vectors
>  so it hasn't mattered yet).

How so?  Does the spec state that a device must report at least 16 vectors?

> 
> Otherwise, pcim fun deals with some of the cleanup you are doing again
> here for us so can simplify this somewhat. See inline.

Yea it is broken.

> 
> Jonathan
> 
> 
> 
> > 
> > Upon successful allocation, users can plug in their respective isr at
> > any point thereafter, for example, if the irq setup is not done in the
> > PCI driver, such as the case of the CXL-PMU.
> > 
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > 
> > ---
> > Changes from Ira
> > 	Remove reviews
> > 	Allocate up to a static 16 vectors.
> > 	Change cover letter
> > ---
> >  drivers/cxl/cxlmem.h |  3 +++
> >  drivers/cxl/cxlpci.h |  6 ++++++
> >  drivers/cxl/pci.c    | 32 ++++++++++++++++++++++++++++++++
> >  3 files changed, 41 insertions(+)
> > 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 88e3a8e54b6a..b7b955ded3ac 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
> >   * @info: Cached DVSEC information about the device.
> >   * @serial: PCIe Device Serial Number
> >   * @doe_mbs: PCI DOE mailbox array
> > + * @nr_irq_vecs: Number of MSI-X/MSI vectors available
> >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> >   *
> >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > @@ -247,6 +248,8 @@ struct cxl_dev_state {
> >  
> >  	struct xarray doe_mbs;
> >  
> > +	int nr_irq_vecs;
> > +
> >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> >  };
> >  
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index eec597dbe763..b7f4e2f417d3 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -53,6 +53,12 @@
> >  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
> >  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
> >  
> > +/*
> > + * NOTE: Currently all the functions which are enabled for CXL require their
> > + * vectors to be in the first 16.  Use this as the max.
> > + */
> > +#define CXL_PCI_REQUIRED_VECTORS 16
> > +
> >  /* Register Block Identifier (RBI) */
> >  enum cxl_regloc_type {
> >  	CXL_REGLOC_RBI_EMPTY = 0,
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index faeb5d9d7a7a..62e560063e50 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -428,6 +428,36 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> >  	}
> >  }
> >  
> > +static void cxl_pci_free_irq_vectors(void *data)
> > +{
> > +	pci_free_irq_vectors(data);
> > +}
> > +
> > +static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int nvecs;
> > +	int rc;
> > +
> > +	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_REQUIRED_VECTORS,
> > +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> > +	if (nvecs < 0) {
> > +		dev_dbg(dev, "Not enough interrupts; use polling instead.\n");
> > +		return;
> > +	}
> > +
> > +	rc = devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> The pci managed code always gives me a headache because there is a lot of magic
> under the hood if you ever called pcim_enable_device() which we did.
> 
> Chasing through
> 
> pci_alloc_irq_vectors_affinity()->
> either
> 	__pci_enable_msix_range()
> or
> 	__pci_enable_msi_range()
> 
> they are similar
> 	pci_setup_msi_context()
> 		pci_setup_msi_release()
> 			adds pcmi_msi_release devm action.
> and that frees the vectors for us.
> So we don't need to do it here.

:-/

So what is the point of pci_free_irq_vectors()?  This is very confusing to have
a function not called pcim_* [pci_alloc_irq_vectors()] do 'pcim stuff'.

Ok I'll drop this extra because I see it now.

> 
> 
> > +	if (rc) {
> > +		dev_dbg(dev, "Device managed call failed; interrupts disabled.\n");
> > +		/* some got allocated, clean them up */
> > +		cxl_pci_free_irq_vectors(pdev);
> We could just leave them lying around for devm cleanup to sweep up eventually
> or free them as you have done here.

And besides this extra call is flat out broken.  cxl_pci_free_irq_vectors() is
already called at this point if devm_add_action_or_reset() failed...  But I see
this is not required.

I do plan to add a big ol' comment as to why we don't need to mirror the call
with the corresponding 'free'.

I'll respin,
Ira

> 
> > +		return;
> > +	}
> > +
> > +	cxlds->nr_irq_vecs = nvecs;
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct cxl_register_map map;
> > @@ -494,6 +524,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > +	cxl_pci_alloc_irq_vectors(cxlds);
> > +
> >  	cxlmd = devm_cxl_add_memdev(cxlds);
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> 
