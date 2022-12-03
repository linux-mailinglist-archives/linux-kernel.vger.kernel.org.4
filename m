Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D340C6411EC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiLCAVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLCAVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:21:45 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BC8F1165
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670026905; x=1701562905;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jVIbDKpBpoHPcmYWqzRQHlE0jFmyQ3jCwCCm6i6Ohkw=;
  b=KYyBSGMZANnBwZnrRc9CiBRHm/c0+XSo1NYbQWThIH4bPjNCFS11aR1Z
   sy/gZlZqxgrNEV5bI9JoJWDgy06yOd+pxn2j7Z+IJPPPlanq7Z3/DJcsx
   UopcnAVyrrVlxTKqulCo/Jkuet7UNEKd5tm9C8dTaOvE/euJiWi08H2Tw
   CELAFSRQ8xopdBfhSMo+IIHzOk26JJqmmyVAffRDj3pVLUKfdZjyiyee1
   SJE0idiVvYQJ1VjzO3fz9iWkuSOl/XrSRlHzVDQzAF6c8qgQe8Fn7eO+B
   AxJTO+L45j+3Vk1UjdGWsi2+H7a/ug8ZGRbpr7ZKnsD2NjGTgQHyo5B7G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="378225565"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="378225565"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:21:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="708664403"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="708664403"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 02 Dec 2022 16:21:44 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 16:21:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 16:21:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 16:21:43 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 16:21:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGfwmyjtwJ8MkDmUBYJ82ExslbIpYufPXUBBUDJKSYMPkucYShtwBkRuUVZqQ5kLB7t8vOXbrPpJzp4u83rP2lclNilOIKWQP0Kx94dLNGrAnfFTGGLFRNP0wB6E8ISDo2cpVzxhhsTlyul1uug2/Cq0v7fFCYnPNK7KA+J5z1fM9UcGfN+z8wIMOf58Q8FflBwgavMwapSvYGrecUAOfNgAiFSv2ob2Tr/DPGn3D/hhB0zL1IYPtquQZvA5Pl2fHhhzLExsLsTWus9IuABsRH1TzYJQrBCLqxRsS7uToTm3mf8wSbOND7d8/ZbZLO7THwUOCtHflxHAP5rc+DvhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+ml4NXnojzj4SLqHjIj6uRf5e9ziLbGd436xqMpLmk=;
 b=NK5JWBZmWxEgyajd5pWuzInaXMofjJEATRHFRqwbbpRotE1IctMHaIVM1gim0cjKl3+1YltN2i/c2jdDCpFZLb4J2Z1YDXI4K4IdETlokHKEJ6t8rThRc2U+1Uhnxiw++x4eetVK3YVU1MZBxhAIape0GQ4PsweW8F2ChIZgKEZTOI9KfhLxBDH9HiKKJOLZdBHUMOPOykiYoX82ALQ+71yUSpSrlwTlfaXP7xFIKLI3hIslMl99vAoofTEwtyGbJnbVsiQQL27to80AxCAt2HDrKMGtDyeQjYNTvmxxrOh2UC4C1Ip+Oj0/k1UZ6t/hW5TgPic+xUgoRIuCGsbJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB7206.namprd11.prod.outlook.com (2603:10b6:8:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Sat, 3 Dec
 2022 00:21:40 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 00:21:40 +0000
Date:   Fri, 2 Dec 2022 16:21:32 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Sohil Mehta <sohil.mehta@intel.com>
CC:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch V1 3/7] x86/microcode/core: Move microcode_check() to
 cpu/microcode/core.c
Message-ID: <Y4qWjJOwQ/YsiRT0@a4bf019067fa.jf.intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-4-ashok.raj@intel.com>
 <f46f133e-d401-a91b-b67a-cca278f171f2@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f46f133e-d401-a91b-b67a-cca278f171f2@intel.com>
X-ClientProxiedBy: SJ0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::34) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM4PR11MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd8146d-1624-4f6b-a790-08dad4c45805
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKppvSn1OVdHh1M1uSSxaPHtOR5j/jqF4iIXSmtYcZsrisaScJpPmhoC1w3Z9FepH210ZPwoKyGorJJ2XXMM5N8R3345hIHLYy+XOlZkOvfzbmzIjmVjk60ACGT3lb8XmZU41D+xD61V32QvO9WP3St2nDGsCkna+KL3C/wYcj0XWG7ACHaQx+uRZuZ5Am2RjVLcC+anowUSkYW4e1FQyzBIDCC0cGTUm3th8VIt7nPH0oqhbQVn/thCP+myehI57xnRBigH2Xkwa/1g0NXrhcKdY1cUWY74OG51P/Y02pt0Z6hoqQ7ZTqTx7twHK58sx2W193hy14/mmc+AdYmt3bonI3vyiadrwDaFfB6wJuONTDW3lnNRjU3TkGsW7ZemasrMtT3mIbwLYKK+4nXHUmZ+75kmbNh9gY+a5Ev5Td+4o/jeCZB+WlyvCFw0E1EjONErwyvJymx0Y03EPSAZbPAR0oo5gv4SBPMqsuSHUB+NaRdEy+z046/Cjqp+G+JPp9XuWpWYlwU7Mw3L2tMSJqvaSNmb8DN5Qe7srRa27gecdAR6u9000nOuVjBwsP5I4n6q+eT0sSXEjvZOXdtq3rRa6gCpb0Wkt7Zsmc5EvlzJCxbju2gNGWfA1oGUtnlt1lcNylDM0wMKaHmA2sauQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(8936002)(41300700001)(2906002)(44832011)(38100700002)(66556008)(82960400001)(86362001)(83380400001)(6636002)(478600001)(54906003)(66476007)(6862004)(6512007)(8676002)(316002)(6486002)(66946007)(5660300002)(4326008)(53546011)(4744005)(6666004)(6506007)(186003)(107886003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KiEe/pjNZTQS8T7F2ocLFJx2+S6/jYUgO67J32is9xM4KF9F2dO9gIVKoqxE?=
 =?us-ascii?Q?cRevx+O0tQzoP4BLvDPbmQijX3j1vLzbBs0okJTwh8eMT4GwKV1zfatyCJll?=
 =?us-ascii?Q?Uhlm0a875LREAK3xmtEWvDuc29kIuKxOYxPsigexu6dhKsioWg81HohpT0mt?=
 =?us-ascii?Q?22eoRs2tej13oY3io9FxdG9zqFd0+B91TEtcdB+FtdjKOMPQukDQ/3rpTKyK?=
 =?us-ascii?Q?ksR1AbmgRrN1TBe22kEhfc1U0U9UXz+kO93YiTFCCIEZFWavL+yRdRVVyIwr?=
 =?us-ascii?Q?qN6vMIY+HnsJxYWQmZY2Ph9KWxL4CdYu7S+kLx6bTH2kFKQh1ltMpKQRZP6g?=
 =?us-ascii?Q?Tzdwd5xau/cIkJcvPRfCFjVLc/jOnm9JtlNIwhjnq9/JcYRLF0HA8EAdOx8e?=
 =?us-ascii?Q?fCK8Hca53cBy2cE6X8jXOczuNF/o6Mr4lzwIXvkIJeRq8TH43e8CZZkE74xP?=
 =?us-ascii?Q?un8btShr6zDFy64p1tBIa+skyz5LCcdfS1u3Pj5rnLlC3XzKu/lZ/oW94Nii?=
 =?us-ascii?Q?nvNLfX8eLFqF3D85vB5+KZqjEnZ9htzjaAYhQ1bXpy19sQ450Ir/3AG9BfKB?=
 =?us-ascii?Q?LQjpRvbaGj+aYdChbbSDBnqycG2oxDN1jUDnvkzdXkZqEUTCjED1a+KQK5ia?=
 =?us-ascii?Q?kZcc8Rmvih7t1hoRGrqMCeW3rC0Gk4rz+C9d/7p1OCwDBe5BxxEP3wDNR5IC?=
 =?us-ascii?Q?k+OYYFg5rARElwSyirUuHsIdGCyx72ZtPuBPDCelr24iUPd79apnE1/wSqu/?=
 =?us-ascii?Q?Qx8DqVuz/g2SFBVhRgmkHed+IrKiZT/pYLXaUpTMAwTPDkkFNGv6PiAVepET?=
 =?us-ascii?Q?pkaBWd6gCMnC+gBg3ue9MupPGNpHkvTHbTiQm858trXzqiEUuUXhaWuDjFiU?=
 =?us-ascii?Q?6+He7jmz2awAsFO0hyvnuENmqMPclZcTZ9Wb7oDLYEx7xA+Y6AdJK5Hx8imZ?=
 =?us-ascii?Q?5fm9TVM7wjhKDiKJeJ9dB1p+I4ECe0kE675GUYa348lkqVNL5OnicTkL5i9c?=
 =?us-ascii?Q?E38y6CcztZ9n6FvqKo0ZOGTWwmlaj3am/AbtQU+ga76ZA3O73dG14L20k32X?=
 =?us-ascii?Q?2INhzKbXzON6E/iO4nQ6ksxHOCvlj4Yv6yubnPHCfEB0lrxeWORvgi6Fhz8a?=
 =?us-ascii?Q?iO9+L/ldhvYqYdQguZDy46ms27cMg8Jp7OLv1wO2UZV0+EUARuLVSm83zna4?=
 =?us-ascii?Q?7k6X/p9E7xHKvdBvVjadxVuExsL1jw+aJ7uFN2Bz2LmPrvnFlVTMeE0Hi9fn?=
 =?us-ascii?Q?n8AJ8BNm5cRNWPr7GdDxKpztq5ksPqYjj4tuIQtNWA4Z0XvfBkQ5G/s0NXhD?=
 =?us-ascii?Q?EFosPe5YBpR8plxU0DonMdtE/wDIuzMrnXv+2IeAIg+VlPSFauAxvhGszpYP?=
 =?us-ascii?Q?WzRXAAdolizZ/5s8lzshx8DSzGEtYKWJEJougObFCWGlvu5A5G4Fb/BYg2Yv?=
 =?us-ascii?Q?KG6AAEfa9qsvvwDtPZV08tDzv2CAEiTfunLjrZ5+UiQmahcm6vIqdz/56aKO?=
 =?us-ascii?Q?14U09yuLIRB2Tpx8ZP0kjzbovYmUifuhENNa9zrM6F1NcCB9quUe5wp1Kyo+?=
 =?us-ascii?Q?MkvdJ83pNCNiL9zXGUra+fWQCTuHPDpegDAZU1a7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd8146d-1624-4f6b-a790-08dad4c45805
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 00:21:39.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Rr5GHV3JxN9xxuTWjgN05UX8AIf2gOnmWMp6y0jsaYDqz3Ev0Za1QqADgS/7jKNBEagOmHE5+fOPXfzRSbyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7206
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 12:57:23PM -0800, Mehta, Sohil wrote:
> On 11/29/2022 1:08 PM, Ashok Raj wrote:
> > microcode_check() is only called from microcode/core.c. Move it and make
> > it static to prepare for upcoming fix of false negative when checking CPU
> > features after a microcode update.
> 
> Should we use this opportunity to also make the function name a bit more
> descriptive? microcode_check() seems very ambiguous to a first time reader.
> 
> > +/*
> > + * The microcode loader calls this upon late microcode load to recheck features,
> > + * only when microcode has been updated. Caller holds microcode_mutex and CPU
> > + * hotplug lock.
> > + */
> > +static void microcode_check(void)
> 
> How about, microcode_recheck_features() or simply recheck_features() since
> it is static now?

I suppose we could. But given that the function already has some comments
around it and its not having multiple call sites, it seems to be reasonably
serving its named purpose :-)

Cheers,
Ashok
