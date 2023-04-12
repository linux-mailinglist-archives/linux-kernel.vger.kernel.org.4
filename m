Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E666DE8B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjDLBOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDLBOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:14:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C645E3A82;
        Tue, 11 Apr 2023 18:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681262061; x=1712798061;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oIS4pSg/99wlCZXUfs3dB0X/IJPPxTEnII+cJ/jib4w=;
  b=IZ7WDWO9CDnLI3eRXhDHlzdM0rAruVSFlrXlQoQcumciSHRZzH8GOjjo
   3CfSaj9xJP8JBA/P2AGhBcjm6ToemJFsMnYGIqVR0SQB6/gqPA3XkTItX
   8Yv58hNOsxUeJVXuSoYYkxw81xvDi+i+Zu2sg0cw8Cy36j+lP8Npo0LT9
   shc0SOUKLhKPuFCVN8NinZrVKrGQxSFNIC252hoqLtOUqWWbLNvc8KhP+
   15A4Peb/2HUwQyZmL6nwjEKc8EcBem3fbLQZTfw3YBsJ9+y9odnP4bbtL
   aWthzMw6VQP5bTEtfCnN6KJwGdW5UeWEdEAqv7V/c2YzLlHVGrjoNzY0Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="327877413"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="327877413"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 18:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="666159852"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="666159852"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2023 18:14:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 18:14:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 18:14:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 18:14:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 11 Apr 2023 18:14:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPsM+vXq+dpYnEvQo9mOn+MS6Kzfmy2S0H+G0j85I0xTFqv3ygGXu80ZsClElSewnrUSuhCL2NkCwzjL0tAdCz3Z2BxDjp5uNfrYDHRBkA5392eOvGj5RiF1Kf8XqFiWSOVYe8LEqZGt4ird615rpUPGEL63DWwTovpkkSWvgS0Cuflt8JQbnOY3nY9SXXawCP/T5+YjiKjq5yl/FRc8EjMl0pT5E6tz5HyutU0vIoZmjRD+a4SPFskfS2s/qpSZ8XnwqVa+qy35OHhAq+5ToF7T6YrDAKxRix3PdTEZt9qGQECbqwlLe0k0Jab5F3pd31AC+/XM2joyj0Q30Y41CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ilgh6GmwfO+6VC7NNhcU2HbYOzSMlwkx6SkMTteB6FY=;
 b=ekNmX4NGQgxSpXbECe0UnUUw+8c5vbcxI7aqzmDMGOzaiQbYL6vGU7to30D62KsgUzMBeFOlyCysMd5gN4g/4sC6d1PUgSVowdoXItxXK+JNu3QJrsDHNlcXx7861ykV8V9LGYX0NEb2WCgOilYYcckUNdYkLZRt3JY5MyxxRb8nx6qQx5+oTrGNhROHM2f4NE94q8fz6SbhfdTZ6AHZ/9h/xTFMvz35pP1FJPlo2XjcMVc+sKitHLn2GJo/hr1xtCO/rKiFEaQ9tamFSU8k2Z79jAGuKkocJnHhi6dNni8Hpfx7gxb2h5vjHGtgmeUdQd5Uo5ztRYcB3cg7Qgq+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 01:14:07 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::3cc2:6622:cce5:cd02]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::3cc2:6622:cce5:cd02%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 01:14:07 +0000
Date:   Wed, 12 Apr 2023 09:13:55 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Fix test_resume failure by openning swap device
 non-exclusively
Message-ID: <ZDYF0xjpz7+b/Rmj@chenyu5-mobl1>
References: <cover.1681186310.git.yu.c.chen@intel.com>
 <20230411053050.GA4099424@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230411053050.GA4099424@hu-pkondeti-hyd.qualcomm.com>
X-ClientProxiedBy: SG2PR02CA0119.apcprd02.prod.outlook.com
 (2603:1096:4:92::35) To CY5PR11MB6211.namprd11.prod.outlook.com
 (2603:10b6:930:25::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6211:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 187341bb-d3d8-442b-244b-08db3af33610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: woPkoFTjL4BSu9p9AtHKnulyKpb071PcvhJ3jwZEoHQZSNeyzUCxsdNb9H1gYn20YdvhfbH7ZCU2Xv6NrPzGzMAAsn7snEfs32YaTXBZCRv5qBdB6wj8gqIWPLNYlPtaBMxmLzCBUI9P+qzJhElAqSPR26u8QEeqdwW4A34uyvWSQOU+l9Hr8RC7N7bTg/Ybyz86+MLI8CFNdK8IZlCsJSviUoKX5Fu2Q1cPIU5NZ7odgq9pgCRC9+7LA67G/GxupJxQ+rxTWwlKvH2RbmFO73K3ViSpW6IiBC7Y9i1PMpeHlYrCxKpJcJhFU/+XmbkFdA1KvWQIqeQY/Sq8UMMOojacLm8Uhh4SVFGtMGwtMJGebcK/LZ0jpjFsTnZZwoJEuMVImK5Rx/1sfTIXcpZSTKlWTRyK98VPtJH2b511SesM786TUmfplvrDAFNrP+DzE3O0ddSPne0COr49TIB4ppTtVYmieXVyBdWja34fYBjT+QsJchAei+UisPBSaC8kxo8rJnTzztaKtax4LSjm45UTTMRhXEWb9Od4iJ9N3/CYniLYJVsAk27h0BHD0nZZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(54906003)(41300700001)(66476007)(66556008)(66946007)(4326008)(8676002)(6486002)(6916009)(478600001)(316002)(86362001)(6512007)(26005)(9686003)(6506007)(6666004)(53546011)(83380400001)(8936002)(2906002)(82960400001)(5660300002)(33716001)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kM+zHi48tZ6xiI8soKlIOt/sSyBFAkytDTrnzh5hzMFnYv8bisM5Frr4hpuJ?=
 =?us-ascii?Q?BlSrmhac0ypD25K3o+l6G7jYmPxr51rlJtjASeFo3cHqu4CSiaKKEmObEmQr?=
 =?us-ascii?Q?8/NNuPiC5Hc66GbuX7thyUoQUzfHz54CDIzvdw8Y+la4vbkUYaiG7GmQHvHw?=
 =?us-ascii?Q?e/Lj797/KUG5X8/pTaqb7Xrx6V5fKylK6PISgA0WHdcNMpvgq42kZrTBlNK9?=
 =?us-ascii?Q?yZZMnFal0oviiaUmS+G/N03/biWG9GkoqzLfdXC8jroCz6zDPRJis1DaMoCT?=
 =?us-ascii?Q?wM5BB5sNVVhYz1GiJaA16jE1u9BbQGqer7DGB3N8MTaTgnr8fzc2VMBZlAgs?=
 =?us-ascii?Q?zPR2fpYUr93+bp/ZUowasSIGuajcJzT/9uNziCdnXFwZXxkTrt9y+axLqGV3?=
 =?us-ascii?Q?Hhll7oik/sd66x6HPM8dRIn2/VvIS7TrK4atwGIKCBHnIcN5pnuJO7wT5IF7?=
 =?us-ascii?Q?FMVBhvgqwQqmMC/Xmz1+cEsCnzIInLBRUj+llUaRSIC+w5xM66hUYso7rRv1?=
 =?us-ascii?Q?Sw7opBiGCkY442zTUgL+PzgmhJm63uPXwvKmifGPAMm/S0vmQQ+oUPBSJe4F?=
 =?us-ascii?Q?YkEu8X5zimO8V5GM+mYIvfi4Ep3DTDuFP9S3NXFOt8wiQDE/J0IssN13KLWN?=
 =?us-ascii?Q?LkA4962Pb6S2WO1SPEZy09gCvMNYVlY2w99dKOJNpvj2uZsxXA7nrK2nGt25?=
 =?us-ascii?Q?SxTXz7D6sWSgIzi/RQb1ArUHwLQ+cxorS7VZRHURadb7DrYH9VwCt33lHpQT?=
 =?us-ascii?Q?rEyhFP/GR5oJ6HEeGoYSK0AeNGIGcZF/mfLRS3PGuri4bK1q4+raE5otGueR?=
 =?us-ascii?Q?KOt3lCsXF0ROUKkeE8ar7lWsOeGbvoPR5cZkMOdqQrd2eClCr7aKyu9lhlmZ?=
 =?us-ascii?Q?MvTWXu0rRa7rGPaGrDYJHyPGgPx8bMTCQeEpT2pWmnswtQpoEa6CNsfHgETg?=
 =?us-ascii?Q?Rl93hncP8g/t70mqBYO/5qdDUsjbDaxuXFnAP9K0M9zJFHpya02qNF68xzUU?=
 =?us-ascii?Q?wFqUEuRsEKqT1EPka3yuZZrounGTBjGO2cHmqHrN0Am4ILQD/mrd35pJW1sZ?=
 =?us-ascii?Q?W5Pifguvaf7+8iMSZQ2i4E9W7d+bD4mKO925vutVvmfHNZA0R5wBUUp/So/o?=
 =?us-ascii?Q?oDwfS9Hs3JL/qdZm8lbqC15rIpR6QfVO/dfsCuUu2lMTNK6mJp+A9TVxiYg6?=
 =?us-ascii?Q?JYBsICCLBN2BsY27qbD1/OfazvgvcJ85mOudE3H0NvNpVrAuTu4k94OP1ZWO?=
 =?us-ascii?Q?43/FiiLo2XFyDMQcRvSeseZ5kWm4g6WuiY8R59A1KocP5jaevh4Fq9E/TvBa?=
 =?us-ascii?Q?7KAGv3R4OODMH8zTiqnEmWTD6Qot8R3UQLHzsBrVQ0WuGXF77BVLTaD+xfR5?=
 =?us-ascii?Q?VxSdkVtyrafOAbiYBkdOW8eEDbur3VQbukaAXMOWiA4mBDm2/CvccHfZuA8/?=
 =?us-ascii?Q?bZLWYi2JnaNNs9g5Zx5qiemMFObHYwh4gXXfSX8SzTAJeLo5J6tswUMMAo4v?=
 =?us-ascii?Q?65OE80Um0Jlta59YFeYl0EhzssbtmUaMF+KAy4VaOKFo2BpmcKydhQEtoXaJ?=
 =?us-ascii?Q?4tV+Vw7B2YK1sRQNSYFg5BiQFAETPBCt9kiHHwKN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 187341bb-d3d8-442b-244b-08db3af33610
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6211.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 01:14:06.4619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPbwGnDEkuVpVWLr0paDoY1kH+sbwcavToEb1wYkMvPD4zXDTdHFjDM8kNByHdSW/nXITdcBnqe75cH+UtyDlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-11 at 11:00:50 +0530, Pavan Kondeti wrote:
> On Tue, Apr 11, 2023 at 08:18:43PM +0800, Chen Yu wrote:
> > test_resume does not work in current kernel when using swapfile for hibernation.
> > This is because the swap device should be openned non-exclusively in test_resume mode.
> > 
> > Patch 1 is a preparation for patch 2 and it turns snapshot_test into a global variable.
> > Patch 2 opens swap device non-exclusively for test_resume mode, and exclusively for manual
> > hibernation resume.
> > 
> > Change since v1:
> > Turn snapshot_test into global variable and do not introduce parameters for swsusp_check()
> > nor load_image_and_restore().
> > 
> > 
> > Chen Yu (2):
> >   PM: hibernate: Turn snapshot_test into global variable
> >   PM: hibernate: Do not get block device exclusively in test_resume mode
> > 
> >  kernel/power/hibernate.c | 12 +++++++++---
> >  kernel/power/power.h     |  1 +
> >  kernel/power/swap.c      |  5 +++--
> >  3 files changed, 13 insertions(+), 5 deletions(-)
> > 
> Looks good to me.
> 
> I have verified test_resume on QEMU arm64 and it worked fine with
> these two patches included.
>
Thanks, can I add your Tested-by tag?

thanks,
Chenyu 
> Thanks,
> Pavan
