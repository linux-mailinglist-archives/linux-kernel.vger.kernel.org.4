Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B229716C25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjE3SUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjE3STv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:19:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4369F118;
        Tue, 30 May 2023 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685470786; x=1717006786;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T7EA1V1oqXH8HKig3T7i0KC7dQczNnLI4BPs3uMEHCk=;
  b=Ddb2Jk0JlozB/TrRHThBxXpscYwNP0/QWebPeDvbYYnSNMODcdOZo25D
   y+bY6jXQMtYyT/W6a/PFLZeKmy+yPNePWurCJA17LArzrpdnzhVKij38t
   ZShdBNG1+xDiLVnxQIHd9aikgBtX+RDay8tXbsVFH9Rih8Gb+gchBnyon
   jofPkGig/HS7xzqFmbbeZpzfDpCaZbQs+omdtNdHXMDi+xVSpgdLqKGvR
   ySjksvS4Um+ozb74DyuuOGG5JN1rF3j6kgc4vjmmzrDBZJSHWXeDC5DCS
   sjHl7D1KQgN+PYzEZXrHbFg4P9xuiP3RbkqatfqxnCfZJLLySNzEMmT83
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="344511456"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="344511456"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 11:19:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="700739661"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="700739661"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2023 11:19:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 11:19:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 11:19:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 11:19:44 -0700
Received: from outbound.mail.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 11:19:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfqg8C8bGM+AT2bOpZI54RptFivZcOrp68upY+QR+IaSmhypVv21ZtGqshclNL84U8McPSw7nFQZu0Lr+nU3r+oatM1KKQVsIw+iTWhXgGp4EHgfMl5S4+rj32LrjypHQmNGjpUGrv97hT0UutzpUvNTylHLu9VCgNzveSF+Ved2iKqbOYrqLek4dyHUfv+aBaHlLMihDecpxVwi1Cn3wLk06vt2U3CRnATH8MfsPA8vRRfTURKVYLB5ND1zT0eLUOLv2r56AXY33wuMBQAB5Mi133Lh3CEA+XF7ZMagYD8OclBeovrtMceCEttphagtSHxqpBwHMPeLGldHNuoG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0Ui6ELm6jGyKCaqmWCseziHVSTA048pMTpDF8/Jqrs=;
 b=C61NEVYNkKnEf2kRFphJcy/NQzO1KREa/RjbuZKe/gnvrFRZRvij/t+zpUJBbLEBOrmXC5Lm8FD2mS9xosaNbMTRq1m9KLabg1KXNiKHq7tlpc8/UuNMgl9G2cTf4BjGjE6lTZb//CWAC61litt5uSmGLFqKiWN84v2KJuSAlzUwqg10lBNY1Tfl8uE7LQRSbn1ZqmAnv2Q0aacF5DpEZI9irwt4VhmMHl1LmIk9PYDBcJO0Rcw7caPr/J7mCQ07yGNzbkRNP3lGsthAPavAMenwxi8KX5hDj5AhrkWlDBX03xIJy9KGN/QoE+TsqTiuKfpIHDA0dnbiMD5xageSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8095.namprd11.prod.outlook.com (2603:10b6:610:154::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 18:19:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 18:19:41 +0000
Date:   Tue, 30 May 2023 11:19:37 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <dan.j.williams@intel.com>, <mingo@redhat.com>, <acme@kernel.org>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v7 4/5] perf: CXL Performance Monitoring Unit driver
Message-ID: <64763e39d9a78_168e29463@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230526095824.16336-1-Jonathan.Cameron@huawei.com>
 <20230526095824.16336-5-Jonathan.Cameron@huawei.com>
 <CAM9d7cgYZs4DqLmjPZCYDVrp-KVYoZYDyJHLwB1fOM7ZdzM2Pg@mail.gmail.com>
 <20230530145001.00002560@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230530145001.00002560@Huawei.com>
X-ClientProxiedBy: BY5PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:a03:180::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c3bae3-03b5-40f7-4caa-08db613a6fe8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EfNy2JKG1lnWjBmSjYMe9Fu1N+FyiMJu4kUTG14j84+oc8l5iAAdjZL5EERKxYoTT7GrKswSSkGf3HOIwAGlV2C/nrXogDEtmFNDhNQH2s25qE79k7Y3ZmTlEN8O2+JR2vpLVeMaMUfIMF7ItvRLI9u1dHD/E9MC0juPNCxJlW6rwG2GZYM92DfhGCnrgkBAbEMPFiR1Zti84iwHOmAynMmRqLQOOSX/PHNbMT+I4oERwYLKDmh8X0fI6AtCSJGDLXa2m3Lv0BVMU1Ew2arZSL5O7HHDFZNjReFj5n7sSPmsIqMNdgFKVW6MGk+Kzd51nicWpwh7yTxG+RarbdzrcsqOlHgHbmuHsnsqWKeS24OdfSF7wVMiAt7VsAMsNgfKG6J1YL2e7Zm15ecFl+ZueqCIK5PZk81w6nRWTUd5YpOGgNeFbcPwZerkh4tQkNw953UTomRqxvgyLmQZvKQSS0bOuzP+5n/E5l2tP3lwMM9Yzf807jEZYDjQciHvxo7XAbXgSzzuUSdkc6QdsaQpaZOhvZADr7pjCUp3rAAoja51355AW0q1ojbAvEq/oJMvZigHnezLNi6fl4+VitQ6utCwFukBHyaEZhqntwjscgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(186003)(9686003)(110136005)(2906002)(4326008)(6506007)(6512007)(54906003)(26005)(558084003)(5660300002)(86362001)(7416002)(478600001)(8676002)(8936002)(66946007)(66556008)(66476007)(6666004)(316002)(38100700002)(6486002)(41300700001)(966005)(82960400001)(15302535012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M55v4z8LTEhop8X6kQhUmdA4TvnuU7S0SUunGr5awbupBP5VtuecwnJHVIaq?=
 =?us-ascii?Q?tiARjLVk6zHzAxUUrMu0Mzg2V6zIFQ0CtznmDJxRrR3JenovaYKPSrdQRrFe?=
 =?us-ascii?Q?DC/0ZIgpsAw7RThXsV+mswXaxK0PbaFgxCuvql5+JpAx30Zf9ayGt40DAOhB?=
 =?us-ascii?Q?Z6tOlzS9cXMm8lCtDSe2IWO9HHmBhfXmccYSL6lL8OnUsHoeG8Z9YjH+lHon?=
 =?us-ascii?Q?MC5W8/dHudHHvFEcrVah2Ia1x0nMMahho/AdGlo2hsnwotPVdW9/o3R1DNLu?=
 =?us-ascii?Q?mgU3MYZ6j+MMzCHexFeI5hfFabT4Ym1ER5bSx/u4HGcStupU46sx6uMB+tbj?=
 =?us-ascii?Q?xHVoH3cXir3W5akI97hIR1gjhwC87p0PXQiRhugS2czudNXpO80dHVD2CqDc?=
 =?us-ascii?Q?YCjC25mZguc+7cReaQKJIr7I2rSPdTJmEydqZqQb9U7mzui7BLEU9t4PAWzz?=
 =?us-ascii?Q?Fa7Q+eEj0uE6x43p7CcV/s5APuyOuarbgK91oV3tydrW/XzoIYryT3QiVuBG?=
 =?us-ascii?Q?kp+rOy6HM/NVXNlinDKEhCy09pB1Rb8463CfGtq4xiJAz+OIDDKAOkYjyoVS?=
 =?us-ascii?Q?VbQlDqdGKVQmsM9+3CRrBBKU9k++a88ni1EW9EowUkjmuKtf0Nt8nu0Fo0Ol?=
 =?us-ascii?Q?Of3y68Novvh/0OB5D4k3tWAGNgMVdEU1KOLAimGSk4tDnYFYGI9bBkWyS7rE?=
 =?us-ascii?Q?GbfLOdZYBuVJFE1YjDrgfTBIMvoNVpeKWnZb2repAVq5Pnln0n6ye9e4P1wy?=
 =?us-ascii?Q?oQXlDM4FY+lWYB6z+6+2jPC3J/hq1L5Yz6t2lRTRCYAKNwAT1a2h6kg8XKTi?=
 =?us-ascii?Q?B6XpFneeWsM+dwq0bE/h1SZjbh1qToPzsisn3bqI+Vi53E4T9jbwiipOj2Re?=
 =?us-ascii?Q?ksmEEHd/QIKF8NO6T5ZuesSv/CsejecsmULR61QKQD/BjWmwg0i0f68oEulN?=
 =?us-ascii?Q?RqjtTjMxhUWxNguKY2eal7XEfcE3t8aVjWH4Ua75sSr2HMlkxTHVDCb+iFSl?=
 =?us-ascii?Q?cD/wr4WVsZkZkAB7gftnK2f4llnw8PlscPgdv/dI2CzYpp0kroNkHjPziRuk?=
 =?us-ascii?Q?0YWFNaeg4Q7O3U8xL4mcb73eM5eD3nAcAaWL4W7BUEbAIX/vNpDkYPDCi0T3?=
 =?us-ascii?Q?ODIBxm01N8i4wYuG/mVuyXbI6BjvR+XJ8pHLaO4o2hQA49gKECIPlEW2rsLQ?=
 =?us-ascii?Q?MfAAVDCIvtuqkYNKJgBmgjs7igV3goLnrnIDsjba9aOR0XuFBFmCS8J13g1u?=
 =?us-ascii?Q?Tjvp1d7wMs0Qqi6oIiK1wZuQkJb1OrSnhLY/pLbg0X1c1p4fOBW+cO0sB7iS?=
 =?us-ascii?Q?nDJVLPcb6Ru9WOu3xA3XypKV5RykC/0/DF8vRH4vjCFdUWInP1ht7hbAj0bl?=
 =?us-ascii?Q?RfdAXO3PQoL65VeDd8kpliSh93o8Na1egfG/pJEgFmDClrFZIbS/8f/1Ggqb?=
 =?us-ascii?Q?nrbKcYEGRvLGiCFNUh8uThkp1ArkSCkvO3rkxn5slkb9Ecz3CjYVR8/Xq08E?=
 =?us-ascii?Q?x162vAR9HruZr8UG1sxQnqDmtvrw5a3GXEuUQjxs/FKtgyTML0BPs8FCoMC6?=
 =?us-ascii?Q?BvoA4BSqNADLerQ6vgK5a4MZU/hYH09adRMhK3JiBvQBr20bvwuSd6EP5F3S?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c3bae3-03b5-40f7-4caa-08db613a6fe8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 18:19:41.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfPnL2kO0x8O7rtTk2OJCMxhvJccjmUn5+secJ15N2vMbdIVzmaDt5ZF4XHWKboQ9jVeRaPtnIbbjvTuAq6pvQUrTK0bTz63NQxBUxtyOXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8095
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> 
> Hi,
> 
> Tidied up the typos. Thanks,

Care to send that replacement patch? It looks like, in linux-next, no
other tree has picked up:

http://lore.kernel.org/r/20230526095824.16336-2-Jonathan.Cameron@huawei.com

...so I'll queue that as well.
