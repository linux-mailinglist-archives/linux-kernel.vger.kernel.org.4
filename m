Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C94969284A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjBJU2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjBJU2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:28:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A4D10D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676060881; x=1707596881;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gRCjdhxYzjbfsEoqwnjavNZT9uoneXvheSULmPrmlEE=;
  b=oCLsmsyN7yPBLxXCuEkq/nDvRtaSWaPMCqDZPpAtYtLpqqtkVb1O4/KR
   hClvYEb613EPhoVUsCioW2cXk5P2Hr1wYEeMWPmGPLJdv70cLMazE+4pc
   6kOXJyFHiKrTWkZkoAP3sPfNZqH10wv/rO+sm5apRSlwuu+yVm/qv9Zfb
   SmPlYTZrxsbffo2pL5MOTJA8CHanq+SSpyz11Ly2fjXHuHgq5HgZy1v8q
   bcQfZzyo7sAPXsaF4YpVlB0RNYtZa4kvkIcrjNxFZ+j9HEo6qnVtYqgka
   hU8vCgZsH/5RClXfmjU8vRwW1+/2fxoR3AZn5HsEMz7IKClw3dgmdF7Ek
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="330528566"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="330528566"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 12:27:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="756905022"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="756905022"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2023 12:27:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 12:27:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 12:27:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 12:27:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 12:27:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjjldg7iwAY4wGor16P96go1+a1hT/MkVIvFgZ2CatJ8fkX/8kiGwQdLPFZ3SXwrsBckHutRNrzFLJi8vd8OTYoGbFLpb6zzU4LrFuLV0EATSxBacHN7fffRwFZNHqgtTCFVcGuXYEtjlJukWdDBMBWPOhW9YEl7iJlNJrZYKO4sUWgAuLrQ2rAdYXSX7ySnqSaBfeUaBRTHdGaFWJjsd/7J3Ozeskrf4VCO295gCTjS26FA5ajgnODtbe4sk6CSvEeKchqNhrtV9Wo9fkZG4xwCbL0T/YX1yEU9kwTSJCRkD5c+jxIUdDsBdZ5/R6gjxIWYk7Ndl0avwed3po+iww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh0TDUFWf0/cnOaxrXlvwlzvf0htXttVdcMDhESmc3Q=;
 b=nPFpFpvfCNgVrwgqro56pZs5mWh6vs8dnASWKfSYUGFet/WTxIECZjpd7kRAx+WRmO62UeRM0o2o+ZXIHBC0OqD9YoDu+q4I3Ib6r5WgzQ5BO7oheUCTaTmbnLIkvQ1v5vWd3KPnQAQXMWJCYv7VE6Abhoy/mCw2qCQZymFxv6AroOXOGH9lixCYtQQkEMV4PbymcimRGlM3XcPM7xx2nXQ0Ufws618iFuAf8OUpUHr8qQW81fR6S3V8/QMRz5CtvCQNfWtS8Hb6Vp77ocfkz+2iFfKyL5hgCQxgW9sgkqR7pZMsGIcShfxfzJT1OfPZxVeG+oal9wKm/IRo0378vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4693.namprd11.prod.outlook.com (2603:10b6:208:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 20:27:39 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 20:27:39 +0000
Date:   Fri, 10 Feb 2023 12:27:35 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        <linux-kernel@vger.kernel.org>, <op-tee@lists.trustedfirmware.org>,
        <linux-mm@kvack.org>, Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2 0/4] Remove get_kernel_pages()
Message-ID: <63e6a8b798a_145760294a6@iweiny-mobl.notmuch>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
 <CAFA6WYM5tzs3T1tDgspA=R=VxfWrknm2YPHMCZihx405pF-ftA@mail.gmail.com>
 <63e279f730612_104ce22946f@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63e279f730612_104ce22946f@iweiny-mobl.notmuch>
X-ClientProxiedBy: BYAPR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::42) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4693:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a513e6-57b0-437c-133d-08db0ba540b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXstvjvMbgwkAK6WeRUe561bk85M+DPTi8ROiWiGGWrXMYWMBlBRjOpXNvdLChXirru5tZoyJUsLwzyUOEDfdlPsLEgA2OquLOjCawA6N2mIPvNpc4eY0ftz/BOZWjq8DXQk4Oe6pfDzOmtIhUCVshP+tmyUunkU9U4qkN0TKhedBZlGjukRyoimuHjmYWXuH2VCpItGfTcBuEj3Elm06bsgoDrmAlsiMfwvF3MVRghj5vrl66VEeBsMgcz1ZsCKT8eYeOgyVmsEj0udpxbW3IhoVVuKEy4eLzj/F5UfkjFyVswby+JTkNxB621AHadJ6bcU0GY+neDMIAjlKp3bp/lGmDeitNkRZTKBaah8BKARyL9oybhdbs7vvtxyo5BWVEHhA3DF/IOc0U51e0q9gPBmDEsH9ix3jxd+Xjh/V415QVMVCNWD3Hq2BlEsTwA6jnCXcGuO1+59SDlcskTgeKCHLBiGqoqII6KM8G+/JNi+2VPpQu02oB1gmfw5V/JfJR4Qj4w+rjMCvud0HGGO3ClQLFDYcLPsNJEzi3iNtL/RJoLd9kHh2POJQpN8v0eRqFGxmrfmKDtlD11Vg1XN0ubzl44GC5eG4pKKpxpfDJHkhS38PULuIZ4R19pF9UQDyBbFonHunp2B8hJ/usTulQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(66556008)(54906003)(110136005)(316002)(8676002)(5660300002)(4326008)(66946007)(41300700001)(66476007)(82960400001)(86362001)(8936002)(38100700002)(6506007)(6512007)(9686003)(6486002)(6666004)(186003)(26005)(7416002)(44832011)(4744005)(478600001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1hDoyKVBxMdyxlh2fa2cX0J7MFSFnXWK0RpXylkXz2VHBc/TdbH9fVJGue/z?=
 =?us-ascii?Q?E5aYBRgNjdOhY9Y/62h8jWLfdSp1JfFF6mg04GTuyhGXehc/PyVzNfowq3bY?=
 =?us-ascii?Q?1fdH8STtU+G8nsILdnaJL7UYOKf/RKalGknlw5ncMJbI7BrU3n4WqZxM0dkM?=
 =?us-ascii?Q?Rl18SORIDddEDDq4MoN9kLJZVQPiO2l0qEoXafyDzfyUMglZITMAoLdsjUze?=
 =?us-ascii?Q?rbtLeBYuxj2TcrMhFuCyCmIoGKIvUox+mNLZBFfN09fXULirmI4sy+RRcDya?=
 =?us-ascii?Q?fYlBPySw9OtK6P82Lrn5Egnkvi4aS1C6XmnbucOZRU2FA5FtTu68ETVDm6dV?=
 =?us-ascii?Q?mWgwbRiafJ4mFASnrzF/tLx9opy+cVGyUDGql6QXAskF3RFanmJiI2f9yuVe?=
 =?us-ascii?Q?4yVVADYCFGBItPFKpzYWtpKV+p9skYNb0p0jBnwx+eTrteC0UhtwQeDBfFRv?=
 =?us-ascii?Q?hVzXzQCCv3GxSmTpVBY5UkxcR6nXOZokjgh+ymz+k+4P3ZPBhOzlczB/hx6E?=
 =?us-ascii?Q?DREPLqRDGTaQmvoZmdUq1f6PHno2S1MfXRT8i9pXBkGte0xLAHG0smFxPBXR?=
 =?us-ascii?Q?H0wOXqowfLkjhIg0e522ujtgWCq3EgxfGqCG16szLhnrveacOmD7tFplgbsK?=
 =?us-ascii?Q?4OiuwGgUV1sowpeXusuIWo9Ud2r07oiRJqlSQD0EdOoxrmMATusgzRyv56Ot?=
 =?us-ascii?Q?Tc5k+tX+orFK60p2MlQ9xuYcn4JwVB+qm0phl59shmfsDusSahWdiMkth0kl?=
 =?us-ascii?Q?8L83YV+fwcIujNxjNHmzhXDnMZsMQDS26ra3zfE6tbiNinwy3gRtSrBvXg48?=
 =?us-ascii?Q?Ezkv9cA1jGWq2T1dWvpbqDKTT0BvlSADhruU+z7EA5knhfAn2vMCZ7OPabrZ?=
 =?us-ascii?Q?gi93R1NqM/ygJvDzmtq93IqBYmanzn/g4vM/mkPZ0u3+WXqfkJ/0C5qYdSK+?=
 =?us-ascii?Q?yEPzHQd25mjv9ECD8O90kDPicRrwxwns4tPnZQPQhS1Yl/Rt+XcnknAof7LI?=
 =?us-ascii?Q?J76PlVuBQZuMyZz2SSSnwi0x2pgbOwLb+qOKJ3j4Pjd+Bk9cIFpRTs06dhKM?=
 =?us-ascii?Q?9B3grsN7Bm/osTEOrhF6HkPH/oHuKQzbjJFC7bcvIJk+qMglG9aJdGfu7RUc?=
 =?us-ascii?Q?ft0QmNo6E1fNlKCMi15u0cgwefeCD6hKaCWfec6tYti5KQaGwm8xslLjHK94?=
 =?us-ascii?Q?mnd6tjrHcQWQnsHLU1XWKddbutAiJD/HiQx3TtxPqNBB1dUfOXG13w8S2yWV?=
 =?us-ascii?Q?u4P9VhUBOrT/AFEhAK1cv/YDFr/PohxiD+13qaJtRvU29N2a/PyrWLtZ2ho5?=
 =?us-ascii?Q?srdbZ6FC9NwLLPSCEBPd4WvifOsyMSbRNE+lmoipW20/Lo8IUyE/jDIRVSI/?=
 =?us-ascii?Q?/vRrZxBiALpRs5T7XNkP61g9ViK/ufKhq2hsgBuY0lSRb8p9XypLi1n/WHjT?=
 =?us-ascii?Q?YwfwaZKqyzLYyVRGo2+2pCC4PY+8Ci4dJstSaQQCfh2yhtg/GVfuTPA51FF7?=
 =?us-ascii?Q?9XwWgFoF2HplYf4tPgokUTjdB7UT7EosYWPgwolYU4XJ6ENjqJdeZKoojsmI?=
 =?us-ascii?Q?SFD12VEYNhycXbvKs0qRTD3kMeGNgwUIEbTj474h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a513e6-57b0-437c-133d-08db0ba540b5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 20:27:38.8831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LII4v6I5Q2Yg1nyvQDgEAGdCb0BZZ/riA1LrQ4o36AQvM1FSV6JxXD0D1kzhKewHGcTS3njP3lN3IaxKu/GFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4693
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
> Sumit Garg wrote:
> > On Sat, 4 Feb 2023 at 09:36, Ira Weiny <ira.weiny@intel.com> wrote:
> > >
> > > Sumit,
> > >
> > > I did not see a follow up on this series per your last email.[1]  I'd like to
> > > move forward with getting rid of kmap_to_page().  So Hopefully this can land
> > > and you can build on this rather than the other way around?
> > 
> > Apologies Ira for keeping you waiting. Actually I was fully involved
> > with other high priority work with my upstream review backlog
> > increasing. So I wasn't able to devote time to this work. Sure I will
> > rebase my work on top of your changes.
> 
> No problem on my end.  I just wanted to ensure that I did not miss
> something.

Andrew, can I get an ack on patches 1 and 4 for this series?  I realized
that perhaps I was not clear on my expectations of this series.  I was
thinking this would be easiest to go through the tee subsystem tree.

Sumit or Jens, is that ok with you all?

Thanks,
Ira
