Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2504170841A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjEROmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjEROma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:42:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850FF1B8;
        Thu, 18 May 2023 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684420941; x=1715956941;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1dDk2w9nVCsfwQXSXvjnX7tHEsi3ciT/fsURglcGYeo=;
  b=MOB4zSfMtDSU0NjLeekZdID+k8UvRmVkFtlKs32DZtNSaJminU2LCLDU
   KN61WcCeHTgjHXJFFP3VDpCCNOoGxeO28/r/kfeARCjPoBBiEpf8NABH3
   2K6Z0wn5o/AEPlpOn1S0kIXYrqA/Cw6bqU/H+YWt3Ccr95mameDu4vcBK
   KdrluL67j81/niRwioQ0NbzHPQh6r7MNMMBEsWv2i4bZNaR2srnQZ/E10
   XxPIWygDUaZ0ZfnTZ/hmr5bdt4gnmn5PTQu11ywR9wEPugrBdOSZtz8lk
   x3d1aCn3rMrDmRyIZEAP6JjVfnvOzvQj71O39xSYaaNSYbxucyHzoteNT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="350918047"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="350918047"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 07:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="705213341"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="705213341"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 18 May 2023 07:42:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 07:42:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 07:42:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 07:42:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 07:42:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lyo6LGAaQq0bFDnXPNpOAvPEuIoDQznG0yMxCka0Wv2A6y3PVXF4Ck0bW/V2Rlye7hydl0qrE43VHyShhkuoW2qVErqUEXbB1KBubxIWBxxP8t8QJTUf0jsGuGJYBYOOEMTAUO3Js+HCz/nWc7WfyvzVfc3Z2/XHidTUYMRHSmfQTx0Yf1lo436uedcpkWw5ShTSP/UpNMzjI4Z2t4ONaePHcVRTdoG9sGqx+g/1NTStRFlmnL0y7eVuxSpH8pjfNVYPx8TokZQIzqv97GsapFsLKpC6sKDXVG0TS0fzQ47Jk4WYlT20mv0Flo07XxL2Y9VhayN3v8k2kG3Z3fyFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iUmFBcs+1pU2L2KS143LhnPUUkwm5fkiQLaFw//1lk=;
 b=X8oAmDICPmcspmANPbtrqflr2nQzeGnnw3HNVaHvkjSW6z6ZrSBSGSoJHG3eeEBegwf/n0N56QZNEzUR5f3yZThOWewJCfDRaqMj3ODimVpxnGuj0DZvUxQT3RnG/MjM+AqQE9RNbC1JIpKyNZ0OeOFocT4NgHhvXM9D9cR2PV4dycaEAzlsPUBk5ngv5nZtO58FyI6kTTvhXsEAML68NwsnmuI7ImWagTXTnqe3CXYEeV+ElfrI6DpBGQ73t9uDlBdSwIo1w1Og5XhwGX45yIKbNFJDbyLIkT/S2ny/1X2TJfscrDhrq4tTP67odoIYapICMGdeegdyTtD2F/yuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5542.namprd11.prod.outlook.com (2603:10b6:208:31d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18; Thu, 18 May
 2023 14:42:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:42:18 +0000
Date:   Thu, 18 May 2023 07:42:13 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] MAINTAINERS: Add additional reviewers for CXL
Message-ID: <646639453692d_1111d3294aa@iweiny-mobl.notmuch>
References: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
 <20230426-cxl-fixes-v1-1-870c4c8b463a@intel.com>
 <20230518103648.00006e93@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230518103648.00006e93@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0143.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5542:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a456ec-18f9-489b-dded-08db57ae1461
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgGCBBC6ydQ08LGwTuc55gA0JFeKNCYm8NQyMd7BlDoiPjzDtLxIyoCnOA+KNwkoRnzoPLOxzItzudp82/csu/UBTLjL4QgXe6C+KMD6k3nwrcULZXARBkNZC1hIerxz9i3jDAb41DK46hhvp+YpiQH/4ZZRQt1Rca8O85nqoW6I5v484hvol644+5wRqeiNCT032MwF2dCCplUfLc//LDp9snz282lCrMkrbnHGQ6JsNcs6qc1ZC8qrkWqNe4PDNygnIab22w1PiUWrrtEaAnCP/JS9VL2NEu2rwB50jgSOogdCQISNtUxt/DKLZkNx+I8uYruSDKjiByMwjEKCr7A2DaL456/08fSfiW+koY6A9PeRRd+w7UIqydW2sPma3F5aa35OBpsHhMwRr2fWQfhNHNup/RMOD/hmxYLrfspKPNwaNDtRtZPHRqYqtOS9rZVXWU7dd+TuKznzkT18imnBwg0hLi20FhVBfzkAABIK20TqLWy/kWgm95jVThM8eV6/QpKkkIlPSG8HSiZ+n56y/i1rBx+BPxesK2M3amsBEnEHiFjL49zJu+ngA/mD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199021)(66476007)(66946007)(66556008)(478600001)(9686003)(54906003)(110136005)(316002)(4326008)(6486002)(6666004)(41300700001)(5660300002)(26005)(186003)(8676002)(8936002)(6506007)(44832011)(6512007)(2906002)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?prqDD0bCDAWaERbqvSMU4jsxEYbu3LX/EFM2VMbrc5pYQggOgXMuso07oOMD?=
 =?us-ascii?Q?qjFuh7kdy/U6m4MaZunBKHHu4bo0YTCHicsffE7/foHXuOHkir8aBzBkoqCN?=
 =?us-ascii?Q?gc1XWz+1l7/sRUi+V5s0jbAEwAiRDxyYyEWT3BnkmcvfJTxNVKX1SfBBG/ex?=
 =?us-ascii?Q?XKYnW9uIhYiXIPERZajGXUUODEqGtaaqcm/kIQbh8Q/TgbIaMOQj/6YQzY/x?=
 =?us-ascii?Q?sOpf05kRd1t5cZdrd7SuqvEgf8Kp+zZBB4gujdiPUaPIWcA8gMXTCcYg7vXN?=
 =?us-ascii?Q?+RtKtWtoFIgPjt0sClFQwhzd9ofFdr8RAw6APp8Fr3Vo43DsVB5IjH/um6Lq?=
 =?us-ascii?Q?ifYfLewVUunIgwcxv/ZFxsaiDzrRGEe0e8hi39pmm0686eiRvErG/FVF6dqq?=
 =?us-ascii?Q?v3y6RrgPX9dbp1Mfe1Uim7gPiXzjkYVkHCjt2fAkXT8EUV57X5owSu8pkwBj?=
 =?us-ascii?Q?18kIKh4FyoCw+kufWddRG2SUTMrBX8Tv2zn7koXF+FzXohmd2eY1P5Aec9RK?=
 =?us-ascii?Q?iX9NZsiT4zdN21AcniifePIg533+D1PHArNjcSwhKVR6uYNZc4hF4Ok+vncb?=
 =?us-ascii?Q?szA6HQLJc8jZkSpTYrjccqrWaCOuTeQM+XmAD1lxMsBZ1Q9a1mLUJtYnyezA?=
 =?us-ascii?Q?FQ2/FDkS7jjOfjH1Em2Mz3K+nSxbcTL3ede4BN2H2FQzrvHeuKDwsJiEB8ZL?=
 =?us-ascii?Q?djXzw3lijxLiwCqLQi6JN6OkdRQwYboDIFqMmh8KoN1Gil9YF5fFsyyvJ7TX?=
 =?us-ascii?Q?tYNJmeIL2IPPy+3GHOgfm/4XOuzeIIPUZdP4o4MrM6bhhcWAlxjmsmh6jCMT?=
 =?us-ascii?Q?+buUZ+N0Ra1Ko64aHYAkdXYPZam0DCuapcWBsmAaCjd5PLCmPlGerOCFV9SC?=
 =?us-ascii?Q?zXmHpEhDJFQ3BiM3EmP4l/q5/OR6yE4lkQnNz31sU4rbFUOGs89pa87fc/+B?=
 =?us-ascii?Q?hFWamjHeInk2xCwCawVTqAIqGAq4GX4Zq7V72/JWixX0NGC+Xc/GBUaONkW6?=
 =?us-ascii?Q?0r9s/znrsK5fuChzxZhYPM8F4ydyq5ADSmWc0IHsDzK6ws1hjA9vRnUR4rX5?=
 =?us-ascii?Q?EkQJyqt9hyDdTYaLj0xM3MDnRSvbzKYrf6a3W4Kq4S7njMZ1Og6AvA8rwLZ5?=
 =?us-ascii?Q?XVwE0R0TcRM3be/Hu4L2/mGITMolgU/ASoNY2o2y5FM95QcdLqoeI53+ywuX?=
 =?us-ascii?Q?mnD1F8R/nULTalZvidVmynUPiRy8GfyULrJzzoFiBMJa5nfAnxvleAB+t2Hl?=
 =?us-ascii?Q?f7CCb8a98/NXu3wuAPk60fI5QJXUIjMh6CgVaylOGTBA55hDUxcue42tZHfS?=
 =?us-ascii?Q?XOAt2ybUAuW2p/kisAaEK1KxRQTU92Jeh4fSIwUpWGO81SKRCsWmh/pK/ius?=
 =?us-ascii?Q?ERDSClBGUCC/aw0q44BfDGs8yD2lhaRU65UkDEyrov8mZFuSi8u0ADoqH3U8?=
 =?us-ascii?Q?eQBBg6xIJFcgHCPlFEXP4gZS4W59SjcHfdzX8W2voY1g9vVOGn3C3OkuKUYB?=
 =?us-ascii?Q?zBVUqvrUbus41g7/5ySn4MUHaNneRYSy21IUFS5w2lyGIKjLHOxfI8fyK/ut?=
 =?us-ascii?Q?kpW2Rq7U6msfHr4ncHVh6XNnYel099LrvS9gxzFL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a456ec-18f9-489b-dded-08db57ae1461
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:42:18.3785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDcYwM3UhldSbsi8SndrmDsciO97BnCgAOvcmdpZYFjrdibyMg3fx27L3ptJY/zOg2S2rOgQrtzvQqyA726GnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5542
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 17 May 2023 14:28:10 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > To get better coverage add Dave Jiang and Jonathan Cameron as reviewers.
> > 
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One comment inline though on capitalization.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 90abe83c02f3..6f8568ec2731 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5169,6 +5169,8 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
> >  M:	Ira Weiny <ira.weiny@intel.com>
> >  M:	Ben Widawsky <bwidawsk@kernel.org>
> >  M:	Dan Williams <dan.j.williams@intel.com>
> > +R:	Dave Jiang <dave.jiang@intel.com>
> > +R:	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> 
> For consistency go with <jonathan.cameron@huawei.com>
> which is what I'm using elsewhere in maintainers and
> matches other lower case entries here.

NP on this change.  However, FYI b4 picks up your email capitalized a lot.
For example when you ack/review as you did above.

Ira

>  
> 
> 
> >  L:	linux-cxl@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/cxl/
> > 
> 


