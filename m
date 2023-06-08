Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17327275F7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjFHEEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjFHEED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:04:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036E01702
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686197041; x=1717733041;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gN/lGuo3pMWT+bbgP01sLhS8JJ6VNNpON0g/zUX6GlM=;
  b=D6ovY5KlF66tuFEjYJa2qK7xcdF/jmUtPbPgY+5SIGnei2DS1BvZJpTf
   yEfR7aMyJzdJ70i42h8o4rMYn4IwC0ZcQyQN9OA9fgwH2vTc8aiSzlkVG
   dfXUfdwKwu6s6kqlnHOXveB9QvfN2OqG2+aPjvqrrJ2WRkys+ucop9d1W
   j9hoCsgxeDhFVWSCmT0+mUxucdjqgj0i93jde7Q4Delj5os6VJnIvbXyW
   lPpEOr313T6kiXTRVez3kvHA1/3rEo9IftrIxkpA3irC8KJa2ydHn4nSs
   cx7k6v6UwkycOokyYN6TdhomwLzBbzNE4GjIgQMkiU44f/uvuICEManom
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="341850761"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="341850761"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 21:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="660213259"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="660213259"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2023 21:04:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 21:03:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 21:03:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 21:03:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 21:03:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApjSLuhXTNWOHmKYAi4efRAUua0bFuQuI9+BkYRQ+2NPEh1+bkEbyAJO0povjtxoMnDXuN8OttCZ1nJ1eEkQAYuZQuhz8KlF+cm1NaiJihVdYJBYDVhlrGtbpka3M5MGNncHtDPzGqdw3lWeWRH8R+yD5NsRsOIYjNVFT1BaCX018iXiSJnR1vhDBtwx1DAc2XIr3imoOuz7onnfEfrWQRExQvrSPoQzc2XP/MMRxFM9zRxHuMAwE6KfW7M3FZ2p8KuUzje4zFjo4Sk2/Bgakbe47GHbopWh0LF0teazCLeB/8dOw1Yx4IGE25k93qm5dJCJ16U0afTV4rDVgKyQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdGLu2kby9SMsrErWqntY0JFFakFSCNb9hM94E6/wA8=;
 b=Q8nSg38+mQm3CT0ntO5we1gXPRDdcFJrBt508WTek0e4QCPJzj8/GXBxOphLxaB8toPiyyD9fY+KNwz1byX9r60RUoJkn0RAgOPpfwOQr9xfe4j57K+J4By6v8XJ+tc8LQ9Mgs0bZhWzhfl14z699JYUoAzzYVekcCDQItTGCLyHrJdUoNjM+nNLwpNE907OUHCdnoWR6UKQ4WHlNGocDWVOky3AXxwejUiF/MFuTyR+uIoiu3PKznU01pFtxYd5jBLI9v/an+NlbvGadu1EUTMbvW6Uee9I7gyrhSlJFeDcupURu1/ufUJPRujLykgWXnu57HKSvNSFBB4smY8Wkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 04:03:55 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f%3]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 04:03:55 +0000
Date:   Wed, 7 Jun 2023 21:03:50 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Ashok Raj <ashok_raj@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Arjan van de Veen" <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric Biederman" <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
Message-ID: <ZIFTJgwlgfCLXtjg@a4bf019067fa.jf.intel.com>
References: <20230603193439.502645149@linutronix.de>
 <ZH4eNL4Bf7yPItee@google.com>
 <87pm694jmg.ffs@tglx>
 <ZICuhZHCqSYvR4IO@araj-dh-work>
 <ZIC/b+AwvH2wIz/o@google.com>
 <ZIECZMHxtEYnuBAJ@araj-dh-work>
 <ZIFPDvsKGZ7MVSMt@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIFPDvsKGZ7MVSMt@google.com>
X-ClientProxiedBy: BYAPR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:a03:80::47) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM4PR11MB5423:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cc93ef-6d5f-4a4f-da03-08db67d56097
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deNaPqjWRRK8LfcdygqSD6fxE2JidLmpMKsvqeLvvsggfUbuu2m79ECFfJG/YNRIlQFdqZvfmQZqlw2TOKrQFnct3QR3uAhRY2/mSpJDe5RtJ4eKFRlW/F40hM8SCq112kttmCA9QZNCDRelgvgFQAen+O8rJJMNq4VZimyufZFrB5POkSV213InLpZXfoIIkkLPgS1l/iDZ2jf+MRI7Ws1JCdtNIk5sCCV77sVLugixc73wgCpVGsZJtCx/YYNUK+KcDmJOolicr6SNB8dZb7cfW0A/AjigiXbhVXADE7vKEblXRPvIZuCRc41gSF9Ts0nv2MS6haDc+MS2Of9A+mKqGbEu4ThBfp8nREyXaSDjpAWENxJhwJE/a7ZNgOBa9BzxiLF3FIs1QRNjwlfFoFDv31C/CQBnkiZJQm2qXQjrshcsw8VNdiHiM2YFPOYiPWaMsAMH34FOhdVm1f9yY9V68cxRILu50uTVf9vMM4iqeJPM9shPjmB8fuK0OHvD9lCQyC90QULJ2eTiJgRp3CiwFFY8nPSG08BGUCtFeSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(41300700001)(6666004)(966005)(8676002)(8936002)(5660300002)(44832011)(7416002)(6916009)(66476007)(66556008)(66946007)(4326008)(54906003)(316002)(45080400002)(478600001)(2906002)(4744005)(38100700002)(6486002)(6506007)(26005)(186003)(6512007)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c03DfxEFVdJNfcBJOzSKhh7knTNXfE5QtCIJMY90Obnl8siUQ5Qsb70y0/rj?=
 =?us-ascii?Q?DDQ4ScE6k/sr4aEEcsJ/pSVEV1cr8Ei0U1YF2XFeraUWG9aSq5Y7OIAGpKlY?=
 =?us-ascii?Q?iQq0u8Hw5J3StxCXb+XmkhKKDQcyBobKtmH1UI9zZQskUYP6RQxCdUWER+N9?=
 =?us-ascii?Q?IuR2sUaOtyHwad/jLlg0k+OhwFg2ITOesA8TER9w3uBgdPmHzzZ+BwUbkdXV?=
 =?us-ascii?Q?Fbcqfs7b6BjoiFfqQiE7+IhdR1wtfVrUZ0e/wAGL7b3gW/U0v51gaYEajXEs?=
 =?us-ascii?Q?8U6KOr2xwFmTEeKfwyt5xr84q9jDnF+e0+7ix+Xvt9Owo15sGUcU+7g9r0FS?=
 =?us-ascii?Q?Oign3E/r2vvDOnB0bTEkVn4brJIojaTo6Wm/aFqH8GN4pfRonQi2scT3V3Sx?=
 =?us-ascii?Q?LN8zon2srmkcdjRAfiUOKD5HbaNAMI5N0r+aO4u3myA9Hl2cJZaGZcdWDFGO?=
 =?us-ascii?Q?fRGMpLdEIWdLPhbEa7+o3tsWzjHR5JM5Bdc9LKIvGH5z407ZhbF/kDrFq+bN?=
 =?us-ascii?Q?6Jc8N00ME9xs0YR0cNoKXwYict41632Iv5zEe0YKlxkxWX0hr/flBro/+ry+?=
 =?us-ascii?Q?ljTGaUyTP4VgOj2wWnmVGTZOUDvJcuNFFO3qW7/NvHpyCPy3jAyPEfVkMtj9?=
 =?us-ascii?Q?CSvj7lJBkWVFieUQx4zbBDxMZ8UxgP6WTEAdrLY81qKIcX0F/ldAZzZbIFU+?=
 =?us-ascii?Q?aOaedK38X7lxv+gPwkAnjkHzqU/Stn5C48DoTxQZ430ezY8cyI/tGxSaiDVx?=
 =?us-ascii?Q?5ceEizeygX4u1ZCneIQjJe4MVcOYL1kBDslu87MoRtSTUhkyLeh2OIaQTLm3?=
 =?us-ascii?Q?1RuRvTwNarf1c0tsupq8MLYZTuqotVoVHKskvwg9b9Ts/coxqH06oTkaM6SH?=
 =?us-ascii?Q?OEEmO3OZje7FfqoCT7hEB+0kIO7ypIW69SIDmbNfFRgiVRu7UKbuu0g+uP1D?=
 =?us-ascii?Q?tFlgwjQf4RYQOH28oar1b9ES0wnBmiy3ZL9PPLDS/PshelzZZzS5VXJgtgUs?=
 =?us-ascii?Q?M+hl99JLtWK/F5DJ5TaL5qSbqrAXWy5mkXuD2n2tCJ4cXMCh0SYT0HFUecm/?=
 =?us-ascii?Q?mPv4W7SJ252wZm/KkYxIGt5J7zp1ATn5YVJbzQgtH7TbnYZ72Vo4fZPpFAna?=
 =?us-ascii?Q?mPQdY0DrKk6um4kIW06njHP73rxIYT6ZCMluqypJv8MqMsOnrXM9e41tEx13?=
 =?us-ascii?Q?4OcCGKCpEwkzClabqeQR1gmH81yfIVnN97RlKKkYeefLi2JwK27mmo+p2sBB?=
 =?us-ascii?Q?vnKtw/3cZfmGx1Q868TzeXWFyFOnCEHI+2t+gbRQMnZP9iN+MQQ1WDijAQVm?=
 =?us-ascii?Q?+BKyGkStOD5pp/98V/M9dEVwFC9hbnkvT/1VMHDVbzxXfUnoIOf/Z+wuI5hn?=
 =?us-ascii?Q?nOuH39WCt95xcC8DLucGGHaZ7nL/nR7ZD6u9FEw9TkIi64LPaqBQ0C9R/Vbv?=
 =?us-ascii?Q?hu+FCpkHMpsQTlf7OrI1TkQN7nDUbGeP6rtAIcSm0kKehgmZMoVanp7+w2lf?=
 =?us-ascii?Q?rB8iBak2Ks8kqrx+xaCKqgMbeAmAnG8gKupLPoiw/jCuNLEvZna9ICKymaFA?=
 =?us-ascii?Q?vzt2n+LbDzSfBQFAi3Yo74vMBv6E0uZFEqEpwkZ2VsCCngryx7orFdiYCuOb?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cc93ef-6d5f-4a4f-da03-08db67d56097
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 04:03:55.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLeXlHqcAu7Kl7ScUbk5xmO7fiGL7RqoFKPpSWiTwo3oU0coRrQFAzjYo+oQyjgzgdlNuDs/MHC4CgDCd0Ealg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5423
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:46:22PM -0700, Sean Christopherson wrote:
> 
> Yes?  I don't actually have hands on experience with such a setup, I'm familiar
> with it purely through bug reports, e.g. this one
> 
> https://lore.kernel.org/all/BYAPR12MB301441A16CE6CFFE17147888A0A09@BYAPR12MB3014.namprd12.prod.outlook.com
> 
> > If there is a specific test you want done, let me know.
> 
> Smoke testing is all I was thinking.  I wouldn't put too much effort into trying
> to make sure this all works.  Like I said earlier, nice to have, but certainly not
> necessary.

Thanks for the Link Sean. I'll do some followup. 

-- 
Cheers,
Ashok

