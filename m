Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E39762A0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiKORyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiKORyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:54:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79E22723;
        Tue, 15 Nov 2022 09:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668534862; x=1700070862;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WKEV9ydlQaQuuFT8mPnI15am+R+Ht0YBx4C009zpyCI=;
  b=YkIb4vwXuK6T6GNYBrtEglTQPSgxEZl2dU6NDWrG9UwkrAw/4/yLo3o1
   thKfAEc+ptPSvDj4PzuprmNKu571yckS+/yOrEH4dCC/P2oZlT7WtRaXn
   a9iOxrsaxA7Wm6HXIt5rUxpaRYWEIRTn3SAkdF4R+y6ijzqGWFy85Hh/A
   4insqeqBofwxnZpuf5icq9ScY/YVSdDcSI2Q27eGDS6X8at9xTpZoQpwq
   gZIsHDcO8aSFjIxcTzltQCEJj+fGsTw04v8HmhOTZSixlMQqCTuSYY+Tv
   UWwjcviAFOGxQLDThmhdZAeG9p5X00K95jYMZFarJvDPQEnPM1ewUqoKI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="299844727"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="299844727"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 09:54:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="781436138"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="781436138"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2022 09:54:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 09:54:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 09:54:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 09:54:21 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 09:54:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMYLTIGdjp35D0P3kagv6O1ey7YLtpWDwc2hrBrAxarf4YmdumPu8XlnAPkETrK9H6GX2OPAdmwdXKynjMHtRxa2y6kZfuIk7rEswc93ZgO8UuwGYwT7bnplNLz1fKtWYS5mUB8zNTqbodSwmyg983BcQg/GviQRkUwL8TPt+Drg6QVxTxZ2Mp3RxHZO5JRXQNoObPOn8ofNQPBVst3bOWs/zvS5l/m35FhAtLCfAJcCZUnr4SCijwz0nhTCyjMbSlQ6npqJsVx6djcuSH05guajvHbi/Qb/6Zu1IkpLjirkhUdKSKza7gy9LWNds5tTOPM/RA2Z7c61p9T+/c4q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqY8dg34wur61VendnHVzU8iNDSWympe81wFEwjemME=;
 b=gjVUCYnh6Yu802WNlvqUA3Gm+qDh05DZIZJ+AkcVmZfBh82pZX3zRM7XUNtLEd7ntPhxS6zW2iIRPwOJzz4Ob9KS07LmyfIVM2Pc/IdzOcODvJXGwn1iEySADS7QxglKf/mWalEQXfFYbH7xtNeOUgy8HgVtDMHbp+xfSAos+/5Pg7ZwrlI640lgoGRMhAPY2NGEGLnTK7mCoVKkZACXQhjy8ecu4z7GDiKeyASJXDd2tr0lv8kvDefcYkGaZdGOm+GC+Kyr4N5PU+HWIMGp+wqkeer3+wk1kngaeSOqOXP0ZV+Xxg3PJY6wd7jprzEKqIdPzVlg7DdpuC16kvMK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6140.namprd11.prod.outlook.com
 (2603:10b6:930:28::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 17:54:18 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 17:54:18 +0000
Date:   Tue, 15 Nov 2022 09:54:16 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v3 2/9] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <6373d24866bc9_12cdff294e3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-3-rrichter@amd.com>
 <6372b35953580_12cdff294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ODbwk+12JvWyhJ@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3ODbwk+12JvWyhJ@rric.localdomain>
X-ClientProxiedBy: MW2PR2101CA0026.namprd21.prod.outlook.com
 (2603:10b6:302:1::39) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY5PR11MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d115c4-76ba-421d-d804-08dac7326ad9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKkGJXpkletCMAELxWzBs8jYGIOBjMaDoM9LiDQdLRzbXx8r7z4tXaKa98Ey1WuWeeHKkjMj2ni9ZIogP3+x0pwZhteude6v4WSNv3DkxAwdOTTwJvQuWkZPeiymbUNQXI8B4681hE9kQbrDufJeUPVB/FSq3AqjF5UbiCN/ouYsMRjFOXkfYsheDdTC5Oi/3LeC9Va+ywP1NrfHefR5vLQMEMMPvM8IOfA3DBiKD2bmOgUIofo0Rynjj7k6bw9cbrgCyRN+5W5CGiLVHifApA7ovbYMFZInoH2j8rrs7rtxR+U/l6xv0VOGkd65+1RR+wnUo+KVFVlX0zEyTAopRjgp9GWzD/ZsDK8G0kdlRHhxgT4SpB3320tuVExSTE/DepWwhG/FyaFvOdqGDR0dXhEEfSCb+xEGofCnst6n2xcLgtr+MXxwb1Gfp6V/26LjMrgdhJt+eRVljsgfZJEUGrE72Jl5jbZbooGfCAXTjFLFenMxtgUy2oUx+sOa8RRhVV9Xk04PhSnlRFnQwgbp7kKAxBAeErVHM6Fm9UYz9bFldkpHO2T3jD8eNft7dxjVcd2sySkSvBNaLfq1ohwPx225+r8M+UKf26puQo7yI34GEZzzhoXNWzsOEKHHe2mVLDNz1tryErNYBkfMH2Y4ZBzy76TCAMQZWrGSliFmxhochCYcBdHlQbGHaMf108zxlwjuo/FSEm+LU38ZCJtHUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(316002)(66556008)(110136005)(41300700001)(66476007)(66946007)(82960400001)(8676002)(4326008)(38100700002)(54906003)(478600001)(9686003)(26005)(6512007)(8936002)(6486002)(83380400001)(2906002)(86362001)(5660300002)(186003)(6506007)(53546011)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jaz0tRIr21qFulxO2T4fg3S+Es/kBcYLrIpahCHYZsO0GGY5gW8efQyi4aBN?=
 =?us-ascii?Q?CIEV+eyP0QHDEEtwZYBQOrp9tzypCgqNUauy4OTPnMNRECNpSumRAPEX6HTk?=
 =?us-ascii?Q?PmxJ8gAM223LG827eT1IwBroq0E/Nrhay1qGK0iJSnKoDdhTBGwyBob9wDUj?=
 =?us-ascii?Q?c/yjSu9WxZ1ki3jyLJtmU68B0cTykPJ4PIzSSKGT1mCqXqizh2/xiraDYWnq?=
 =?us-ascii?Q?nUycPK9O1MV8bMc+X7yupEl2cu0i/YGFSTHMCzouOhZ1lwhXayp/YKgpxWvI?=
 =?us-ascii?Q?VkZzR9q/3peGh0F+cWFwYmV9+DvjSGqK9cRSoz7oHZLDxkMOAHUGJ2cITnDj?=
 =?us-ascii?Q?e69ueB0pHhUJuxhEDHo77L6K/lw3AmbqhVL1YotXsjtOb+EdJBpNUfy8Vxr2?=
 =?us-ascii?Q?ULUSAhCeTrR/gWzDDDzEWNNHYk/NF4w6TikTX0GqHJJHHP0qzWtTv1dTDoCW?=
 =?us-ascii?Q?kxoXMoe6aLcrzGLoevYg+2NsiO407VTP8AURFk7ZbTESka7kmHz4Gh5s6sJ5?=
 =?us-ascii?Q?APxm07QGoJXPNCoMAwgg+HtxYyqb1ZxKo+JOtHazkjek5L4MU8FKbQ3w/hOR?=
 =?us-ascii?Q?OjlkwAuWB/AygF5Ll5QLM0i9BNUm1hjrpbpf3lZwPPJU/CKFCqOMvwoBfEpu?=
 =?us-ascii?Q?7tggzkrcapAb2zQACci90kMcDWmWnL1USCKPSPTJ/9aRfHN2aGJbpaOdJVk/?=
 =?us-ascii?Q?pGFyZSzJLTwDfz67hAxe3g3eew2cVxW82ne/1umdlU7est3+kEINWjVTN1BW?=
 =?us-ascii?Q?qHFfz1KO5gCgnQK7UeiADoOZsckP4P31CZDKgQbFZgsrznNVQcNItpmQOvJ5?=
 =?us-ascii?Q?12Ra3T2Za7F9GLqWgevmz1/aQ9xr3IhoF5SZnOctablCp89VxdOBRDyKsLLs?=
 =?us-ascii?Q?4AokDE775f4+mrODoStFu0H+bTPHM/QWHMJ5vRx+EGGOyM4GZqSosqP1psa0?=
 =?us-ascii?Q?sG0n3GQZF8UAV6w87BIkHk9+2idTYMbxHxuRr5ewQJaRhQuLS9n/OBX1Ks5Y?=
 =?us-ascii?Q?bc8psn4lIBHFE+84pisamSDK4Q04nqM50gI2DGantTEjHNh/ajUFgY7Jj/vE?=
 =?us-ascii?Q?C5XfF3fLgzgewPewVED/FrUr6doJ5AWlugrSNxLKmQva/RXNHKyI4TRaP8mf?=
 =?us-ascii?Q?Q+mCnNgwLspGQMJTfGhMIt0tL/EHCFebiulJCSB4/c4imMtbqd3m7SLWN1Ij?=
 =?us-ascii?Q?KchnAtKyKswh+VUUE5dEnf1FESb6f/aJp6JS5Y7Ffr0DvKEXEctLmAioRHHI?=
 =?us-ascii?Q?Bc/N7BlZWBYAMxgKf1B/ZeJFOXM0u1ysh+OxVxtG+CkhYmeIOmv65O5X0y11?=
 =?us-ascii?Q?JsiaNXh/KlOCJsBHr+MTFDCrfgF+JXjPoQa81ZD2tqBMls3ZqhZnSVLwP9Py?=
 =?us-ascii?Q?K6cAv3T9qi0fcbXabYATlMp2vHeUWjyuu6D+3jLebL5WpDkmrsSL5RqkEjXh?=
 =?us-ascii?Q?PFCxFn1MYvVvC3p1mbK9mR4ZvcAvhkAZaufdzmnRi67U+IdkNF9lHISJvE3s?=
 =?us-ascii?Q?7w8wGDzAiZIy6jofPCuHtmkk0sKMVZa7n8GkdBHlvWi+U1aZ8SL26nKvwqQq?=
 =?us-ascii?Q?UYx4Sm8PSRvLZDd/Mu+YdD4dAW7mVbLaQVBNj0/P+sMhIyOJJCYW6WMQnRwX?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d115c4-76ba-421d-d804-08dac7326ad9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 17:54:18.3331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lILmOl2P3/WF1kfN26YlpHGA78j0tSSJbmZUY7i3c9kvsaVMhOWV4wFX1PFB1fdt2KqUfrxDQHLWtjzisEwBY/lDFv9o/xD6n0On2fijt7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6140
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

Robert Richter wrote:
> On 14.11.22 13:30:01, Dan Williams wrote:
> > Robert Richter wrote:
> 
> > > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > > index ec178e69b18f..7a5bde81e949 100644
> > > --- a/drivers/cxl/core/regs.c
> > > +++ b/drivers/cxl/core/regs.c
> > > @@ -307,3 +307,49 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > >  	return -ENODEV;
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> > > +
> > > +resource_size_t cxl_rcrb_to_component(struct device *dev,
> > > +				      resource_size_t rcrb,
> > > +				      enum cxl_rcrb which)
> > > +{
> > > +	resource_size_t component_reg_phys;
> > > +	u32 bar0, bar1;
> > > +	void *addr;
> > > +
> > > +	if (which == CXL_RCRB_UPSTREAM)
> > > +		rcrb += SZ_4K;
> > > +
> > > +	/*
> > > +	 * RCRB's BAR[0..1] point to component block containing CXL
> > > +	 * subsystem component registers. MEMBAR extraction follows
> > > +	 * the PCI Base spec here, esp. 64 bit extraction and memory
> > > +	 * ranges alignment (6.0, 7.5.1.2.1).
> > > +	 */
> > 
> > A request_mem_region() is needed here to ensure ownership and expected
> > sequencing of accessing the RCRB to locate the component registers, and
> > accessing the RCRB to manipulate the component registers. It also helps
> > to sanity check that the BIOS mapped an exclusive range for the RCRB.
> 
> Right, that is missing.
> 
> > 
> > > +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
> > 
> > That PCI_BASE_ADDRESS_0 does not belong there. It ends up being benign
> > and forcing ioremap to map 12K instead of 8K, but it is a
> > config-register offset, not part of the RCRB size.
> 
> Note this is BAR0 + 8 bytes, not 8k, and it does not map the whole
> RCRB region but instead the first part of the config space up to
> including the 64 bit BAR.

Oh, sorry, yes, my mistake. However, there is not much value in mapping
less than 4K since all ioremap requests are rounded up to PAGE_SIZE.
Since an RCRB is only 4K per port lets just map the whole thing.

> > > +	if (!addr) {
> > > +		dev_err(dev, "Failed to map region %pr\n", addr);
> > > +		return CXL_RESOURCE_NONE;
> > > +	}
> > > +
> > > +	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
> > > +	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> > > +	iounmap(addr);
> > 
> > ...corresponding release_mem_region() would go here.
> > 
> > > +
> > > +	/* sanity check */
> > > +	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
> > > +		return CXL_RESOURCE_NONE;
> > 
> > I would have also expected:
> > 
> > - a sanity check for "Memory Space Enable" being set in the command
> >   register.
> 
> Ok.
> 
> > 
> > - an explicit check for 0xffffffff for the case when the upstream-port
> >   implements "no RCRB" mode.
> 
> Yes, I left support for this to a later patch, but it's better to
> check it here already and possibly fall back to reg loc DVSEC then.

Yeah, I think simply failing on 0xffffffff is sufficient for now.

> > 
> > - some check that BIOS initialized the BAR values post reset given these
> >   BARs are invisible to the PCI core resource assignment 
> 
> What check do you have in mind here? There is already the NULL check
> which would be the out-of-reset value.

I was thinking more along the lines of sanity checking that the
programmed RCRB range falls within the assigned MMIO space of the
host-bridge, but perhaps that is overkill since it would just be
validating self consistency between 2 BIOS provided values. Robustness
principle would say try to continue if those disagree.
