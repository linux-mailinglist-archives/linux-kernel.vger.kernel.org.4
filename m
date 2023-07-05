Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DAF748AFD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjGERvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjGERvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:51:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EAEE57;
        Wed,  5 Jul 2023 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688579491; x=1720115491;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TaPcWpI5SA14pOBAfZQ2y2OtnaPLA1rfNr5xuK8yJbc=;
  b=jZEAh6nZ92Mo2rZGrUGs2KNsKbDwkrft9EGOw/xMSpKiM4Mh6HaZq4FQ
   EB40R/96dbcQvztgqY+mHy0jMa1bdKAl7ZURnzxD6yklqsMy9eT020x2x
   ubVO6LXQu6vFQP9ZOESR8XoRt8fXm8n17xYUDHla4vGV0hNPeRpCWqCr2
   sYdBCNHztVBNqxDbyGEG5/dpa/u0d3+/JjLE1W6Wfq/j3rICsNi+c04N1
   caY6wdxSmoMkD7KgLjomeR2SaCWUy4VUWqJOPHUCcLMoZEjrXphLO5VGh
   HIlR/cJs1u65dWfF/BgyZpAKAHyXMWHPPJzw/jux7clT+kU1zLhAgQv+5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363436069"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="363436069"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 10:51:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="696538824"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="696538824"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2023 10:51:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 10:51:29 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 10:51:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 10:51:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 10:51:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kv9OeGBuBAh+7/XuMw6sMob9R/KUXMbfhzqyB7k2LjcyWccCkcneyzefF3SR12wR5GbIox4qQ9uD41cC34sDS0jrNS6VTppwe96MI7NQK/gEOSLna6E2xRGcw3cgl4BeHPMoiB5+57Z8j9ciBURQR7ssdluXYNaB4CXvrbANv/UHYjciGXX8OKQEzpuIgLygQTfsFk9+B464C7sabH8l9QkpBTiQK/SBJrwhFvjNDFUlDpNVgWqs9vbBtxOCSwvAa8JnGP8TtNMA2NyWIMjnAxJdEepaEZciNunQgVafEBEZ5pC3MbrBXfimvWt8Z2D+fHasj93W6sRD4TdZsno8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWZJdfRuKLjA6QD70QqYhziyCwsttA88Mv1CL2o+iQc=;
 b=bRl3PZFd8YZkxvQLx/NdoQcb3zI9BZUvhmqRwZiwqL3fMJnwS+uJA07lumQCmZX4KdSJpTp491nR6xLZXEOc4RnmDlTb562y4CjxZNn6PmRDSV7VUfsmQOTdFqijbcdWiwz2Wf6FOMIkQ7gIjo7Lk0jo+Qyu22icomTfUnjOUXh+3kqhnr03XMmUCw2ISetdWEh/+V4wLMctTT688EYpYUcMtcPxpAFf9VI2yr7JENhvUejYj/CgcjlkGXecKGaSB2VXqhLx4WXxx5tlDklcxd5z/d8hnWI5sIxcyVm+QPE3916pGvFnX5FmdV2TEgn5e+jufgRt51e3lWIzcmmHFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by MN2PR11MB4632.namprd11.prod.outlook.com (2603:10b6:208:24f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 17:51:21 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::955a:2397:1402:c329]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::955a:2397:1402:c329%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 17:51:21 +0000
Date:   Wed, 5 Jul 2023 18:51:05 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "lucas.segarra.fernandez@intel.com" 
        <lucas.segarra.fernandez@intel.com>
Subject: Re: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
Message-ID: <ZKWtiRcyUP8OQNSa@gcabiddu-mobl1.ger.corp.intel.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
 <20230523165503.GA864814@google.com>
 <ZHh0DF4meU2ze+g7@gondor.apana.org.au>
 <ZHh/zqNu7XzwJTl5@gcabiddu-mobl1.ger.corp.intel.com>
 <ZILvtASXQKLG43y9@gondor.apana.org.au>
 <ZIQ3OKYyOcwRIOLR@gcabiddu-mobl1.ger.corp.intel.com>
 <ZImNC6KUNHquVAnZ@gondor.apana.org.au>
 <PAXPR04MB957111A43069E2658BCA818F8E2EA@PAXPR04MB9571.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB957111A43069E2658BCA818F8E2EA@PAXPR04MB9571.eurprd04.prod.outlook.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: FR3P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::13) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|MN2PR11MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4dd43e-1c40-4901-ba36-08db7d8070f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZ3HNtjqJPEldR+hmy5SjB14kcV9gxTU0JJ79aBnKZotxmZJ2kxhy1vgpmWNn9iRdSzOJDeUgrwsoN4EFc2kCtyNCoPmAGVrFfMrVQJMDuocKcKAR8NUvGSSv18yFY9Y9Er+GPqsZXeBVpchdnZLV0SJ8P5QgqxQ9hl1IAVJl8GJ2vEDnzEY+gOLGYy2r2CQCMJOqetzutCO1gfU8cyi4/Vc1wFfNov11CBw8r457Ie5clfuemmeYXpcHuK8wVNEEN6cKEyIUDIwSWwJsHKY5XdkF4tfiI6hDj2xDkQ8O+NKYr/IM63AgZIlMS90pZLvu6UrAs3iFsARa0xUBm+E4zAKxWnD6Z9y94EdLn2vMrFDPFO6T8ZGgdHLla4I+NCONYFS9X0WC5cFC1cA3YQNZ7/nO9ojVh0UuVMsEpOtnuVvnlvPZgnVjPARbf0T5LfjsyWNLPucVgoYneo04sPm4bIvVhm2cib9cg4EBuLD2ckCHfHbtcyeGj4Y7Ef4geclzpKtasRK+WF8/hopuzTMbHUAgJ3XNLXvWu7u2sHobRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(8936002)(2906002)(8676002)(5660300002)(53546011)(6506007)(44832011)(26005)(186003)(7416002)(41300700001)(6486002)(6666004)(82960400001)(66556008)(4326008)(66946007)(66476007)(6916009)(83380400001)(316002)(107886003)(54906003)(6512007)(478600001)(966005)(38100700002)(86362001)(36916002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6T9yrWWOS8utDEpjb++f0VqRyYUS8KxvwQWhdFBHCUW3lSKQV0hitipWxOkA?=
 =?us-ascii?Q?omwHCKhVJmJ/h59T7fQLxGJ1aXw0bCYCz0fmdhdgnuFtfR/X3YFmEflYdXHC?=
 =?us-ascii?Q?VBOQtduSlr5kq5/XkjNj4+69jvcj7wcM66tI+/vYuOJ6fWf3a9+kmQKfTGCF?=
 =?us-ascii?Q?9+gc9IXSrPTjaiMXoSGn3fHuudHshNUBn5JXhVIBGwADR8DsdUJt46HmFYOX?=
 =?us-ascii?Q?F1yyvDpDIRr0eXFMsRklpV9F3nh6r7W/YOkm/Imi8bciqMNrZiKRZL1K9gdp?=
 =?us-ascii?Q?xSX9oSYHPDinF8lsSbZckqcmCHDKEdZ+hh4SV2LFsGihPvwHrqEswdjKnBBS?=
 =?us-ascii?Q?rgd56ZsHSRqoCtaQL2tKtMqYPXwCMY7oYnUmnPVSTsZLqgLjcSwBf4G2qpNo?=
 =?us-ascii?Q?ALUeehMv27CfHvYhhWOZUXNleF0nO37IFzUbDsB6qJ7B0ZVQKYVBIypU8tJM?=
 =?us-ascii?Q?Nb0VpGIRkP5mDBXvxrJmRurKnZy37yh/r8MwSbiuNsdFV/6vVI1myEEkNY9x?=
 =?us-ascii?Q?3Mj3PVuR9GBZ+T2GwTVRXkNy3TRrA5pTEia0sLefZJkGQlIX8pDUMlf+TzFr?=
 =?us-ascii?Q?cyD7PVkz8OvNnYSTQXeC2wT98b8rje5ILuSb1ZVMbNXieboGZtPSBRRblPlQ?=
 =?us-ascii?Q?7gMS4Dm0yh+JwNd+9FqSSZNGePS/ss7SjYp74ox2mkYyKMpWtsIVGjdf21NX?=
 =?us-ascii?Q?0aVjD+GnY/axkXXTqMAXiJP9dd93EeI0QqVvCYFTP03nOPiyDXgVw6uaZbRt?=
 =?us-ascii?Q?7Kaj1n88nhw7RcDJcY43sWwhFpcaZO4wl3G+u3jzVhLufjyl2R2EPw/q1gzf?=
 =?us-ascii?Q?8WxowCTdR4OL8JPx0crA0qHR5ZiNit97f0ha9cGywa/8TxC1P3tRTtSQf3x/?=
 =?us-ascii?Q?ihZGuOuIaijCh0HvtefS2k7f7wAZYwWt27+vC4CG0/gkLl8xjlP/0RZKOePi?=
 =?us-ascii?Q?gydCdSFt5uXfwXYjVOajykTITmOZQOhHjT8Rbhc6FyB8ccDfN+pD4TcOXP4B?=
 =?us-ascii?Q?AvDo+0JQ3IF4JiNDf979i9yCJQYMoj9GV4Rixd+TA42evU5mG8LS88EV8HJK?=
 =?us-ascii?Q?nsU1aTszqIbloY+1ByhzwBBOy6K8MJVY1/GyjC2zhShFX2LzLu9ZF0hXEGKI?=
 =?us-ascii?Q?J62Lxgp5FmWMgkUoLW6BxG1HLqUKmVoEvZvmPSxdaq4sG1y7dgRRingUluax?=
 =?us-ascii?Q?oOZXpIjcL/uD3dgHGKEJ/TlKHS6dWbzyax/TydPbFIDOHtHzhiH7mA+pciPu?=
 =?us-ascii?Q?nmKocjLDcaOuOGGmN6q8F6OfY0/qrqOaksjkrr9OeFilJXACK4B5Hhgx6utQ?=
 =?us-ascii?Q?PsGZ2fN44tx7Gw/K4MBrZEbDnz4t/OTcc0jjbf512JYdAfmYidTjPcik9GlH?=
 =?us-ascii?Q?nIzd/A8TnyArMAOZc639eN1hTGtHOij/ED9sKldQgCrLqhnfrtUwN5vZ6qlA?=
 =?us-ascii?Q?yX6DKPGDGza/sLlFsPhXKGFonXeetxOeBAIfZ6AijuUL+E5uscsBgYS9UeYQ?=
 =?us-ascii?Q?OXgQMDC3WtDY8Tm5b00IqShkNdDI+xx3AhrZtogVeARvC62etd3J8rLVsd1o?=
 =?us-ascii?Q?QfVqFxmC9b61iCb4QlDlbx3ImvcKg29cyJeYwr275AvDMRGQxjEFzxJpR98s?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4dd43e-1c40-4901-ba36-08db7d8070f2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 17:51:21.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gL5c8T7gJZkr5iwWKmeE8W78xGHsJ/VBDHpd2YERnhXDwz8VrilbY9jZO6auXMMsjDbPav1mZUGj15QLj90qAelHOtwjCQXuAsFEnmV7dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4632
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 09:19:28AM +0000, Meenakshi Aggarwal wrote:
> When are you planning to send the patches?
Done today.
https://patchwork.kernel.org/project/linux-crypto/list/?series=762772

Regards,

-- 
Giovanni

> 
> Thanks,
> Meenakshi
> 
> > -----Original Message-----
> > From: Herbert Xu <herbert@gondor.apana.org.au>
> > Sent: Wednesday, June 14, 2023 3:19 PM
> > To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > Cc: Eric Biggers <ebiggers@kernel.org>; Meenakshi Aggarwal
> > <meenakshi.aggarwal@nxp.com>; Horia Geanta <horia.geanta@nxp.com>;
> > Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>;
> > Gaurav Jain <gaurav.jain@nxp.com>; davem@davemloft.net; linux-
> > crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Iuliana Prodan
> > <iuliana.prodan@nxp.com>; lucas.segarra.fernandez@intel.com
> > Subject: Re: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
> >
> > On Sat, Jun 10, 2023 at 09:41:28AM +0100, Giovanni Cabiddu wrote:
> > >
> > > If you all agree, I can send a patch to remove
> > > CRYPTO_ALG_ALLOCATES_MEMORY from dm-integrity and update the
> > documentation in crypto.h.
> >
> > Yes please.
> >
> > Cheers,
> > --
> > Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> > http://gondor.ap/
> > ana.org.au%2F~herbert%2F&data=05%7C01%7Cmeenakshi.aggarwal%40nxp.co
> > m%7C6af00291047c46f2325e08db6cbca189%7C686ea1d3bc2b4c6fa92cd99c5c
> > 301635%7C0%7C0%7C638223329655306217%7CUnknown%7CTWFpbGZsb3d8e
> > yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > C3000%7C%7C%7C&sdata=Nrj0YEjJrFUNWY25h0iy5sF7tUnHSDun8KhHxnhUhh0
> > %3D&reserved=0
> > PGP Key:
> > http://gondor.ap/
> > ana.org.au%2F~herbert%2Fpubkey.txt&data=05%7C01%7Cmeenakshi.aggarwal
> > %40nxp.com%7C6af00291047c46f2325e08db6cbca189%7C686ea1d3bc2b4c6fa
> > 92cd99c5c301635%7C0%7C0%7C638223329655306217%7CUnknown%7CTWFp
> > bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> > Mn0%3D%7C3000%7C%7C%7C&sdata=lBaQiOM%2BXaax2lMroHtqbtBbjXBlkkKj
> > ms8mgBnou%2BU%3D&reserved=0
