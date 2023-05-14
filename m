Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14983701DE1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 16:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjENOmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 10:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENOms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 10:42:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D21F30C8;
        Sun, 14 May 2023 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684075363; x=1715611363;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JNGC1sYmDPZbDXzuzuiX8XcZ3EM0ylR3lLd7riA5jkw=;
  b=oK5DasyIm5wHgFcPzCJu7Xp3y+hE9aIYZU38tbQy5QeO2KCNXibLVchk
   VwhFYrRXe6kvUeeZnXYlXlyZ7WhEnSniASL2d0SMuXLBJcGizCcE8cJFj
   p+ioSsLIaK10LupvW8YWw6zj8DHa6hT/BaybFfIPjK2XccZDInhNyeAih
   +csd8JBsIeggGr9y7Cnn0JY2Ypxu3UAKvH6vRycDghQ5fb2XsP5ri9IcT
   7nQZk5lf6mdxcZu2a4B/R/cLTznLX6XwwHBDo3w5xa0cSOu4IIiEO1fCU
   oTyRCKIi1cJFyliWPcYPlhdiqWLP+2MPa/YXk7etFKS7vmhkUjzW4JVP1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="351075343"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="351075343"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 07:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="1030628712"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="1030628712"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2023 07:42:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 14 May 2023 07:42:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 14 May 2023 07:42:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 14 May 2023 07:42:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 14 May 2023 07:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSCL7n3Sid0WiHRnKUc3QFybv7Rm9T5oL/6JRL6oLlF0D/H+NddPfAZRZRYNKperSN68FBDpv57spZT6eDKhm2fb4l7fE5azlvp8LyIIER8HHqhv5sjHpWWueiac+8VFSjbspL/wW74rze8fTlxOdFt/OKrL6gdfvLuddgdyW4jeBRNimXaArkHeOVatJ6pHhlYuPd38k+sI2AZr47J9ttrH+MId629WNyK15jQQ9zYRpyPaw8SA5jxfK7pe5BnsZX7FFEWwMZ1tJnrPduC+waF14rp8thIGvVx/t/SqZ3eJsSFF7PdjZmWfyzRGaoQ0+7enmFZhpSqrM5ViwUytBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDwoWOG7qNboWVNc04qD5WQbo3OJb/XFYUosvvg4p2E=;
 b=KEfu5XrxgjeqH4MbtwpER6yO0AKk1eDeKa2K6Dt4dvmuzRAA4Aoc9Yy2mRUHfyo+r8KXbIit3WR6aZ0QhrJyk/4/C1VtWtVYAsPWp75VJvUMqtAB7AW4eTdsh0yrh+weudTwPPhSaAZTGf5SVjFy5oMjNf6lJCq2eJ3D3x7bm4X9rk7IeIhWCrKEfkHz3aqBgTtVs5JlZYpafkBnYjL4FCmD0Jsb42imz6LuefDJa5XZagafDbvx5/ulY/YURrggr6iTCtRThPkyIKsuQ1Uv8dBmDAAGwQAzH56VWJ2C7Oeb6G02W0gPh5543eqAjNw4+tsR1W8kcoU04Qu2f+OnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 14:42:37 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%6]) with mapi id 15.20.6387.029; Sun, 14 May 2023
 14:42:37 +0000
Date:   Sun, 14 May 2023 22:36:48 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Oliver Sang <oliver.sang@intel.com>,
        Dave Chinner <dchinner@redhat.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <ying.huang@intel.com>, <fengwei.yin@intel.com>
Subject: Re: [linus:master] [xfs]  2edf06a50f:  fsmark.files_per_sec -5.7%
 regression
Message-ID: <ZGDyAOewWqjY5xvJ@feng-clx>
References: <202305090905.aff4e0e6-oliver.sang@intel.com>
 <20230509065433.GT3223426@dread.disaster.area>
 <20230509071053.GE2651828@dread.disaster.area>
 <ZF3uXe+cjAsfCLic@xsang-OptiPlex-9020>
 <20230512230504.GF3223426@dread.disaster.area>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230512230504.GF3223426@dread.disaster.area>
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA1PR11MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: c10ac80d-e7f7-4d57-1a24-08db54897581
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6UFFTIEbk7wTl6MKF47KGeBL7VPwHL1HUjqCrbj8sl+Pvyxdkx/ZqIoMdit182vEUd1s3hHQ+0lh2OyuPluJW9JFWTbPmJQ6+VAcCwT8EIU304NEvvCGNWuvT2VMDVYnDQzdx+VCwN6qvQ/MuFT/BwadsFAEKcFdXT9LtyehkI90EOvmTHcyOyDSnUs832XHlhOb5Z4Bmfh6P+EIRcNw5F6TPyp0tQE2K/xDFWNL9mrUGrBoNPR1StnBuZiHUWY6Hr7BWJUxOw2xf5VoEbRPB5m5W3mThr3+LkqiXOw5o5XRg0utfSAekuOeWEdyyK7lwN7sIonEsqHhs0aETShoHItEPa2V/4M6t1sJhIFFbArwNu5DA3LSYUWV8Fl33bCuvgLomQoxPXiYJ5eu+ljZ/DpMH6oVP77b2nD05lm4F0KKLfMAao47GY4qR6xrR2VRsZQyyjbpFQldQ1/O0h6xvWCeKD7rnZ95F1D0WZ3s8qhi+nGnzhVzV4r6sMW0ut8iV1qwX4As8l9qOa9ZMSDj0cJEZB9rUdQM2xO9Y6rgom2R4u1J2Y8ESQ/oynO9Uqh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199021)(6486002)(86362001)(54906003)(316002)(66556008)(66476007)(6916009)(66946007)(4326008)(478600001)(6666004)(33716001)(8936002)(8676002)(5660300002)(41300700001)(2906002)(44832011)(82960400001)(38100700002)(26005)(107886003)(186003)(9686003)(6512007)(6506007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXZnaDM2Zzd2d3UxaUVHWit1eFBKcGVyTTdBTEJ3T3BFTVkzZnRDQnlxSW5a?=
 =?utf-8?B?a3NlYW9GV0lHd1B0RytVK0taZFBZRU15UjRCNVNVemY4QitmcGVESS96Q2Jx?=
 =?utf-8?B?VC9sN3dZSmtuYWU4YytkUkxMNTZCUEphZ3BadnhBMk9WMlpVa2NON2UydkJL?=
 =?utf-8?B?bFNEZFozUUFyV2ErRlZRNUxoNkR1WE9wQ1lzYi95cksyeDl0S05CYmVXTDdo?=
 =?utf-8?B?Qm5FU253RHovaUJrZndlQk94TjgyM05HVllBR3Y4QVh6S0Z1NWlIdUY5cm9p?=
 =?utf-8?B?NTZ6NldKM0xJUUlGUWZETmY1NjZvMUVZQ2V2SFpBY0JuOE1xclVoaEcvVldC?=
 =?utf-8?B?SXBBRk5DMit5ayt2UncwQVQwVU1ibm9DV0I3ZjNSMmRBQUN2NzBqOTY3RVRy?=
 =?utf-8?B?UHZBZGhZaVN4QlVDSnhucFF1VHBkQjg5WDRZZzgzaXQ1WlNkczNRMkxOclh2?=
 =?utf-8?B?ZW5Uc2M0cEQrQ1M2Umx5bWpVRzlYa0JNUnhqYnhnWkV6OUxVbEpYalVEOEZH?=
 =?utf-8?B?ZU1RbXppbG10S0tjNVo0aDlrWHJOWVpiNWFnN01mTUtWZzd5aEh4ODhFQllZ?=
 =?utf-8?B?djc1SUJpcFpvbklBaG1sVTJ3SU5vQkkrTUVYSTRIMWRNR1pjb0w3b0ZsKzBO?=
 =?utf-8?B?eUY4V0ZqMjVYbENCcTFEVG92SHlNTmVuVFJWUThOTHJKaEhOdTI1WTNqKy9O?=
 =?utf-8?B?VDhmWkszTm1zQzFSVkJDZzRyUHZMcHpJSUducUhJa2dlWkhkQnJiL3B3eERO?=
 =?utf-8?B?M1lOVDJuRFNiZDFlRGFJaFlGQWgrY3JvSksrTHVjSjRmbm1iTkNwWi9ab1RI?=
 =?utf-8?B?NlI3eXVIb290VlBWNVhieXp5ZGFzK2R0M2JoVythb244cUtmcmwvMTR6aXdB?=
 =?utf-8?B?VWhTaXBGbDRtaTQrTThHYThVTWNmcWhaQnkwaTdKSGI2SE1zdFZTYjMvUlBZ?=
 =?utf-8?B?L0R5T2VrdzB3ejhCMEFLTmduSCtlMmtaR3piT01aOW0yTlphRkJXVnZjaFM5?=
 =?utf-8?B?WlkxRnBTR0cvMU5qTkhhMlEwL2ZNUkN6UjlBaXl5dXpBMmw3S2ZiYUh1R0lC?=
 =?utf-8?B?TXBldGRWRWgrTlZJYkZ1RWN6SzRkRkliaGlEczNHTHpyYmRRb2lTUkwrT2la?=
 =?utf-8?B?Q1h6NGdWK2N6T0FXS2taZWQrclVtdE13bUNKeXZtVDNPMDZwNVRuVlhDY1NZ?=
 =?utf-8?B?VVQxR1dwRGZ6Y2c1Yk1wS214RVdXOTlaTytHWFdVdi9LVDNOYVJjNVp4WlRp?=
 =?utf-8?B?U1RPNlY5V1RjQndrUFo0N0ZKS3lKR2pBbERGYi9Qb3JhNHF3dzZKT25BSzI5?=
 =?utf-8?B?SXFsSE1sendSeVRMMVg4aHlEUG8vMWZVVXNRTjVPSXpiV3A1R2dOZGR2SjN4?=
 =?utf-8?B?UTJjREQycHJ1b0NDMUttcWhsRkc2R005Tks0Q3NUMGh1R0hvVEZFUUYrZXBN?=
 =?utf-8?B?NUFDeFJVOS80elptbEV1NDN5ZUkxRWJlSVgyc0RqUW5vSkpSeWFZNkdrZmMx?=
 =?utf-8?B?Z1hLQ3dEQ3VZRHRMaGtMRzBKRDNsR2c5Q1ZvVWpJNWsyZEFFUDRyRXdlRzVR?=
 =?utf-8?B?cWlPRGsxaGpWOG9GU1lacTlsYnJrWDR4NzJMcW0vZDRheCtBVm9SRzRGYVlM?=
 =?utf-8?B?MW5RUHRhTUpNb3BDRUVzSUQzNndKUkZLNDRHTTJjZ29mcElMZmVnSW5uY3V3?=
 =?utf-8?B?UTJSa3NpUXFZQlVZczJXeWZ4RW9GcDAxdEFwSHZBU2JUQ1RZdEFsWkxWalBG?=
 =?utf-8?B?LzRCekJIL2lXdHlDYnpKWlpNeVRTQTJzeUExWTB5ZWpTN1lzQmR1R1M3WWZ3?=
 =?utf-8?B?TFpJSThCSlJzUUhETVFvREN3Q2UzcHdUOEpYTm55QlRMc25uUWMwMGx4QVlv?=
 =?utf-8?B?aE1XbkR3bzZmTDdIalZzazZtOERSUTlrR0JZbmdjQm54V0E3VTVBbndtbHBQ?=
 =?utf-8?B?dHRwZFEvYTFJOEU4UWlDR3haUUZuVEZtdU9MUVhsdDBOeXh0NUlPVHpUTmN5?=
 =?utf-8?B?ekFKM2hidDZZVnBZSkdkM0JEUjJOUGVZYllpb00yb1ltOFp5NFc5bm5MR0Ix?=
 =?utf-8?B?WjdsaktOSStUbFRUWGJvemc3K2FadkxnRDc3QnlVVDUwd3gyTjdPNDNBZDlU?=
 =?utf-8?Q?Ez4LT+NU6y+lEFpUPNSL+S/Zb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c10ac80d-e7f7-4d57-1a24-08db54897581
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2023 14:42:36.4222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S22MbBJv1DoMcczk7oPB/EHCXXyYjToHMys0j+IuBZequuPvhLDXg3cIsHLiFYBF7HiCJ0wihFAa4jDtbO5BtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
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

Hi Dave,

On Sat, May 13, 2023 at 09:05:04AM +1000, Dave Chinner wrote:
> On Fri, May 12, 2023 at 03:44:29PM +0800, Oliver Sang wrote:
[...]
> > Thanks a lot for guidance!
> > 
> > we plan to disable XFS_DEBUG (as well as XFS_WARN) in our performance tests.
> > want to consult with you if this is the correct thing to do?
> 
> You can use XFS_WARN=y with performance tests - that elides all the
> debug specific code that changes behaviour but leaves all the
> ASSERT-based correctness checks in the code.
> 
> > and I guess we should still keep them in functional tests, am I right?
> 
> Yes.
> 
> > BTW, regarding this case, we tested again with disabling XFS_DEBUG (as well as
> > XFS_WARN), kconfig is attached, only diff with last time is:
> > -CONFIG_XFS_DEBUG=y
> > -CONFIG_XFS_ASSERT_FATAL=y
> > +# CONFIG_XFS_WARN is not set
> > +# CONFIG_XFS_DEBUG is not set
> > 
> > but we still observed similar regression:
> > 
> > ecd788a92460eef4 2edf06a50f5bbe664283f3c55c4
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >    8176057 ± 15%      +4.7%    8558110        fsmark.app_overhead
> >      14484            -6.3%      13568        fsmark.files_per_sec
> 
> So the application spent 5% more CPU time in userspace, and the rate
> the kernel processed IO went down by 6%. Seems to me like
> everything is running slower, not just the kernel code....
> 
> >     100.50 ±  5%      +0.3%     100.83        turbostat.Avg_MHz
> >       5.54 ± 11%      +0.3        5.82        turbostat.Busy%
> >       1863 ± 19%      -6.9%       1733        turbostat.Bzy_MHz
> 
> Evidence that the CPU is running at a 7% lower clock rate when the
> results are 6% slower is a bit suspicious to me. Shouldn't the CPU
> clock rate be fixed to the same value for A-B performance regression
> testing?

For commit 2edf06a50f5, it seems to change the semantics a little
about handling of 'flags' for xfs_alloc_fix_freelist(). With the debug
below, the performance is restored.


ecd788a92460eef4 2edf06a50f5bbe664283f3c55c4 68721405630744da1c07c9c1c3c 
---------------- --------------------------- --------------------------- 

     14349            -5.7%      13527            +0.6%      14437        fsmark.files_per_sec
    486.29            +5.8%     514.28            -0.5%     483.70        fsmark.time.elapsed_time

Please help to review if the debug patch miss anything as I don't
know the internals of xfs, thanks.

---
diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 98defd19e09e..8c85cc68c5f4 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -3246,12 +3246,12 @@ xfs_alloc_vextent_set_fsbno(
  */
 static int
 __xfs_alloc_vextent_this_ag(
-	struct xfs_alloc_arg	*args)
+	struct xfs_alloc_arg	*args, int flag)
 {
 	struct xfs_mount	*mp = args->mp;
 	int			error;
 
-	error = xfs_alloc_fix_freelist(args, 0);
+	error = xfs_alloc_fix_freelist(args, flag);
 	if (error) {
 		trace_xfs_alloc_vextent_nofix(args);
 		return error;
@@ -3289,7 +3289,7 @@ xfs_alloc_vextent_this_ag(
 	}
 
 	args->pag = xfs_perag_get(mp, args->agno);
-	error = __xfs_alloc_vextent_this_ag(args);
+	error = __xfs_alloc_vextent_this_ag(args, 0);
 
 	xfs_alloc_vextent_set_fsbno(args, minimum_agno);
 	xfs_perag_put(args->pag);
@@ -3329,7 +3329,7 @@ xfs_alloc_vextent_iterate_ags(
 	args->agno = start_agno;
 	for (;;) {
 		args->pag = xfs_perag_get(mp, args->agno);
-		error = __xfs_alloc_vextent_this_ag(args);
+		error = __xfs_alloc_vextent_this_ag(args, flags);
 		if (error) {
 			args->agbno = NULLAGBLOCK;
 			break;


Also for the turbostat.Bzy_MHz diff, IIUC, 0Day always uses
'performance' cpufreq governor. And as the test case is running
32 thread in a platform with 96 CPUs, there are many CPUs in idle
state in average, and I suspect the Bzy_MHz may be calculated 
considering those cpufreq and cpuidle factors.

Thanks,
Feng

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
