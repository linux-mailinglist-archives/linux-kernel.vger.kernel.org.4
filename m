Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0387F6477E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLHVWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLHVWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:22:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B69725E1;
        Thu,  8 Dec 2022 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670534536; x=1702070536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ff/+2tblImZK/RA95aX3/IFBUvrsHeGCHt+k4u6AqMo=;
  b=MZdLkLgOd8jL7yzdCLymn/Mw+oSzgsukotPM0ZuyaI5AtByL8+LpHXQr
   rzubmDetpDzxELoZnX+J0HBjjVgbiMi6kluxlkiLS0TKWkiW3OcCn7gU3
   7TH71MIwMJDYIBPfogua3WDnoNT0vWCkKB9qOj+JBPGmKR1ohu3itgpk4
   tdnh8K032EaZ8H5o5cNq3kSKpJU4toS6bbSs0Ikmv1buJqNO87y66kOxh
   LpwVbN7bc2sXFe87si5A5hvlTgx2COtuQhAb4uWmD3+wbsQ4WLgBo3egF
   3dvn9pysHWwwTM/QEEYsuHIMNyLNdRAzVyVT9Th13j9hU46jo11mSEbh9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="300726692"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="300726692"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 13:22:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="640789445"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="640789445"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 08 Dec 2022 13:22:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 8 Dec 2022 13:22:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 8 Dec 2022 13:22:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 8 Dec 2022 13:22:10 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 8 Dec 2022 13:22:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C18S6VFZxCpPK6T9z2zYgwP5EgqcY7ShcxxqgDDQWvqmU84OYdMgsDf6z/GyypGmJZ+Oe1C1HCydhuOzLDT9x38I9ClO1kZwGZbuS2jK2SAHO4U6XQtqG9/mTa6u7OdLzNaI4CLJw2FOWGEK5WNVFI56nIkYBOHFcBOyTbRrwcPQoj9GFPIqYxcvZSxDQkyqowICAyTLoBHRb72pvGSrZCVaZHrExXL3qET0cE6rDehVlEYKCMVdV1Pzhk/cCfd3IILLEF9FwpwrBGNEihZx8B70eZEBovxFpg2prPB/B0EQAR5aWNv/Pn/Oow5LxVjmnobYCjBf/vp3N7dOhZIiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuLksp6aTww0oQwEvkF8AL5COdJyTOqGALt0I3Wiohc=;
 b=mqzxo8xVGokt2/iPSzC7uPVAtc+UvVyJBFTVrBlHxui1f8xikiq8GxtPpvPiNhC/SjgJ6I1ZPLuw1Aza3Uo3vRXq2cE+Ev8T0zJWHL4BVN/AxqST839nKxMW0SdYfNRp6PHOg1jbAJ+jqMbfsdcx+tupvScN6OPDlMOSnkXuZrdpR2QM/5TrZyL7XzP7h8zx3wMOPkOnn2iHaSTDwAQYhqmUHqZ49cE6t+XRltuWnF9Vrhu2MQRq8zcuuBDgEM/k0b18oOkrW+Q0RfX3H2ejH+9yAPkUoY7BkvfHpzN1bQOYyP1/RJf3433V98Y9WzB0rFXaMVqkgOGVcWsacEyjew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS0PR11MB7926.namprd11.prod.outlook.com
 (2603:10b6:8:f9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 21:22:08 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 21:22:07 +0000
Date:   Thu, 8 Dec 2022 13:22:04 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Fan Ni <fan.ni@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix memdev reuse check
Message-ID: <6392557cc0aeb_3cbe02945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20221107212232uscas1p20a000834b76db7a7e459708b06638120@uscas1p2.samsung.com>
 <20221107212153.745993-1-fan.ni@samsung.com>
 <63699774d1af_18432294b8@dwillia2-xfh.jf.intel.com.notmuch>
 <20221207001852.GA2414318@bgt-140510-bm03>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221207001852.GA2414318@bgt-140510-bm03>
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DS0PR11MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e86a8b0-e694-4f1c-389a-08dad9624271
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/81OO8hfehSvECxhuOx6kVE8cid7S1red6WkLMKJoYRK5uYLiedRrdAEE0bm6tBEaO4iG+Flo7qi0hwM6E+0oKDH9DPDkc/BgJZ19J0I7lpI693bVwOBqUGMfa/EmsmRiItEleGhZr4Ey5xzXiA6vd749ni8sFNIlseDCox+BLMU20/vs2cvwm0fNlkjJ1639TeMLG4VEsUlp+TwKt7j9ZWNqR095fYWVH7gFr1KxK/UIHF0magjmGBVey8lh62RB6JIFmH4FMNA1QUl7TUr2USpyTW0ryG93knMp0Ak/Hdv8odZrkS1EZ604h+8AkAxz86TCHhiDUWIku+4hASCfiRGyjD+XPwyoszYYVP0qEyb1LC1SN7usKRRHxZ11jMrwfxUkx6f83jPiJuk0oLl3Z/2PtJ0X9D0R0iRgMyU5jNcR9X7H2db874RqiZqu8XhXHMgtr6GowBKu/YuRcsRI4NiT8UwjN4xNVo0GREG8yJ6YAtu1feR6KnK9QofY0NtkQEyzRhYgLUGqCQWAq7g8frccR2ZzOtUI3yn7TONglXnuSBeKLXqEJ/aJuQhoNGNfVDyhyRvZTnSpc4Lt/q/OWbTENi9uY9ullIBf04FuCnfNPbEL8pKKtWMzuBmTjUvzAHdogGpZbB51t6Lvm53g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(54906003)(8676002)(110136005)(41300700001)(4326008)(8936002)(66476007)(316002)(66556008)(66946007)(82960400001)(38100700002)(6486002)(478600001)(6666004)(9686003)(6506007)(86362001)(26005)(6512007)(186003)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GoAquaqOKp1WE4KnUs2wAL4z2T/uhmKcJF7EDhn2x6uTiJMFMywSF/NNjYo+?=
 =?us-ascii?Q?ISHUd7nFxGe6kBOLA7K/cCeTUbibtU8k1C1/ZwxaApbKcN5GODxnNUiYv2bh?=
 =?us-ascii?Q?j8+84uItax9Iyx3Fac0XxMkENJidKg1z+af1Jzqy4TOm2OuIRdinXX+s5E39?=
 =?us-ascii?Q?uo25jhQrZlzvEIAGcatxHLLOUHEupP3PJjorTmGq5aFOEGem4LlAotfrRqrN?=
 =?us-ascii?Q?5dzHy7F2ARrZZhfowUVoJrJ0nDpiIQcuhG5lWlRbugeJG7uKwsjklwZGjfhJ?=
 =?us-ascii?Q?0/XBnanYoayUvcVsSdpw/DpK5v+sWMR7Y+jcmvjqBNL1RI0Ra9PG34xsSU7i?=
 =?us-ascii?Q?+6KmaWxg7w9VSyGbf0M0drS2bEKzPBhmPuCRyvkQh+eMDyl+WFYt4Rz+MX7L?=
 =?us-ascii?Q?9Z2pD48dPCeSEYxE/V7D87ivk2W5QUFF/QkB6ogEqzumF0aXUshYEw9eLo7x?=
 =?us-ascii?Q?kkfqeG9m5T1umcrRtRAZm03tzrhf2QLCwr3UgllQke7znR9EWmAj9STnuiHx?=
 =?us-ascii?Q?S6xON48ypWY/i3V1+6Gw43BsY4eWPQ2VEvxTkHqEeu9iK6RTsp/JUB/z/zWk?=
 =?us-ascii?Q?0aHGpvg7zu7M6LCLCxi4FRAMytAV2KAVqu+I4zB2yQFGhixy7jq0N8tuOPjZ?=
 =?us-ascii?Q?hWxSKdMqhfrogwbUuw75lNAUpZ01xEUk1P+2xs8ywVCJ5jgeviI6+IjQ3Lw+?=
 =?us-ascii?Q?Rb3LxGFuY13iLSUUTlBqfecMssDVnin7JDDsAVN6Ziuk0C/Aub/uz5WKRYBf?=
 =?us-ascii?Q?6KYlk/cc+YHZkNXMDlQkONzDtQuRBLf5uVJhxIrSSE5A5l89zNEhtB8rp2+1?=
 =?us-ascii?Q?ODsrMUgjPGTTzz+e4m97/DAG+ttugI2jQ8KJFK3MzNM/cq05YAFb/eDWiupO?=
 =?us-ascii?Q?goMpCGCgRwsbGfNOBkH+fPAiIEiDblspsDjlm2IEeW5TTtlZ13XmNNlPbVzs?=
 =?us-ascii?Q?WoTAQ6lrkh+HqbzZ4YuimdGttRRqGH2HeEEXxE8MetbMi5kPB6vPYfUf5Slt?=
 =?us-ascii?Q?QB1WQfT0P+otclEzsqRVEENi+JHgYPuQlVq80caiirEJ17pkIbVCSrkqGkYP?=
 =?us-ascii?Q?LvpOpkLi7bcoZ0gEo0BfIAlLle+ooee+c82yLyEEUUD4AdouEKif+pRDoNuR?=
 =?us-ascii?Q?p5tW28lgETWlgS1GGOfjVGPE2k7LXfJZQK1C8nqa1uyXw/9C8ZmbT3r5fXnw?=
 =?us-ascii?Q?7x0q0NxljfK0JhtIR2NImWJoO89EMZi08edhexBwtNnjNIa9ECs7QTYriW45?=
 =?us-ascii?Q?20SYy5udBVGyoalWsImwraSSXTtI2j47krNzzeFGKTZyPqVVC8eJd4GMFvSI?=
 =?us-ascii?Q?q2PuVLb1FT2Gwfil7yhXPI9+WFfJh0CenosI3cZXJjPZwzBq5ZsRJbFDVhT4?=
 =?us-ascii?Q?XtmcmVCnqYYx6dS0cYmJrT2iKKadGJsxhRZmELiK3G8uVm4TEzMCbrBrM/K8?=
 =?us-ascii?Q?4TZniGRqtIBWwP39zwcq5YWsbi9bYB9ttd/wLs6KJC9n7aMjDpMMZ5HeO2b2?=
 =?us-ascii?Q?tw5mMmn00gFi8O4I78rztSTSdjM4xKWJgjvpiR6c14VgpQXFj15yIAa2xwRX?=
 =?us-ascii?Q?kspVashH2l/U3UQHBCWbSY/u0EEvjCjjD0v2Fr8dGitOiQl6PJcQ7wwHajXa?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e86a8b0-e694-4f1c-389a-08dad9624271
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 21:22:07.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZ1CWdboSPfjO67rXozNOhJodOKnkV5Gzy7nOBFq/5x/7hQPsmYzIdJbkkL2qU9zQ0QSGUsrq8BftPAuSVn9c/G8U4vjFYclim2RjmFMixk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7926
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fan Ni wrote:
> On Mon, Nov 07, 2022 at 03:40:36PM -0800, Dan Williams wrote:
> 
> > Fan Ni wrote:
> > > Memdev reuse in a region currently does not iterate over all of the
> > > interleave targets. Fix this by using existing iterator for memdev reuse
> > > check.
> > 
> > Not enough detail, what does this actually fix in practice? For example,
> > if an end user encountered this bug, what would they see as the
> > symptoms?  I could probably figure out, but for bugs I should not have
> > to, and more importantly downstream OSV kernel maintainers, who do not
> > have the same context as CXL developers, also need that information to
> > decide if this is a fix they want to backport into their kernel.
> > 
> 
> Hi Dan,
> Thanks for the feedback. Here are more details about the patch, and
> I will refine the patch.
> 
> cxlmd_target = cxled_to_memdev(cxled_target);
> if (cxlmd_target == cxlmd) {
> 	dev_dbg(&cxlr->dev,
> 			"%s already specified at position %d via: %s\n",
> 			dev_name(&cxlmd->dev), pos,
> 			dev_name(&cxled_target->cxld.dev));
> 	return -EBUSY;
> }
> 
> Before the patch, the check of whether or not a memdev has already been
> used as a target for the region (above code piece) will always be skipped.
> Given a memdev with more than one HDM decoder, an interleaved region can be
> created that maps multiple HPAs to the same DPA. According to CXL spec 3.0
> 8.1.3.8.4, "Aliasing (mapping more than one Host Physical Address (HPA) to a
> single Device Physical Address) is forbidden."
> 
> The CXL specification allows a device to have more than one HDM decoder
> ("The number of decoders implemented by a component are enumerated via the CXL
>  HDM Decoder Capability register (see Section 8.2.4.19.1"). If a CXL device
>  has multiple HDM decoders the current code allows to create memory regions
>  that map multiple HPAs to a single DPA.
> 
> Fan

Thanks for this explanation I folded this into the changelog and applied
it for v6.2.
