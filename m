Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08D770D078
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjEWBZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjEWBZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:25:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171A792
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684805118; x=1716341118;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/Rr1Ww12mnmb9bTOxG8cwIMpz32Kbz0VUCkHhqn4XE0=;
  b=PryA+/461nfBJez+uCPmoaY4SsNAD6XYtDotJzGRlrrd0Okpmkd0ntmg
   gsjQ556/EBTR42l9eWXKZJTNWROJo9iZhxk0+lIrvmJ5e5urmeEBi6rmi
   B6eu1Onnk8iWnD6AOG+SDU4LWg/Nt5AhiWnUFaVmit8q5ZwJybXwwRls/
   XmSXpRM7nQrKi4Dy6k7bAwq56kSO+PZ2cAEJDV86KHYTZDLzXxi2LCY5e
   +JBk0IanrZ54S2WzjUZVK78UB6XriO+dxWVhY+neDZoQLOH7D5d1OhS9p
   LfUrU5Z0HjXKKAxxvUNoYuwq+HM9i37Nx/FkluKLHtlaPWMf4pAaOhj44
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="342548887"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="342548887"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 18:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="703753968"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="703753968"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2023 18:25:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 18:25:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 18:25:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 18:25:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 18:25:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVPArhyJCw27tRDiXQJVS73eCe2/on8oWesQXuGbWlhYTHPCdXlVJ5IZvfQBKFVQj/dSjog1xd8kSSHQvI1qOOfmBL++YRxnBfizuyVNHir3PrPH9UscQJ93A2NctVlZKNsOUnyIf0RRYCqC9DQvBhxQBZ3VrGkNh3uCAjRs84jXnQ0mkqX1zsRYG5IgJBpFqWsVO1rjSvsk0vfXdDjmX7fECGEQ78q7IQxhpVvPwS6PrpdmcnxLAnvlqYOacpw7jG1E7Xyidjef07tTPRG/seSwcWAUY5L+pVBcWCDl/xkXCEDMGgpe+oVuCUWAbvfmvCXSICb3Y6lzIliBxv/uow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fURAyvZ9E0mXcd/nuhYo7a451lgFi7DZx5kd9kbwqmo=;
 b=AOyX9TswGs3DKJD018G+SmbOEClSMrwl3LyMhthXASEjVbhDqB+zK6PFWGAlXCLPDbZ867OGP9V2A3ecSxuv1OTV3jwHTsXjx9hZ8h6Ulh7vpa594YaDd1RsuWD4Kdh9s7sqJf3hq8B/GPqYxcKht4DAOlhpZa5IDl15YIcLme9yEaTufOPawVOhMjycTwlV/3hgE1kOJwAHHkXv8slzUAG6vYZ/5GSa609ClTYwJIRp5e7afdzdbchf4ix1bjgMEd03JVOT6vei+ha0SLNARk0JFWdAP49zwF7iCIJAk6gE/pEqP9jlXT0Qo1fdbOYn5RX4FiuTA3BW1cXa3SM/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ1PR11MB6300.namprd11.prod.outlook.com (2603:10b6:a03:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 01:25:14 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 01:25:14 +0000
Date:   Tue, 23 May 2023 09:18:23 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, <paulmck@kernel.org>,
        <rui.zhang@intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bin.gao@intel.com>
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
Message-ID: <ZGwUXzGcMgbcZVnf@feng-clx>
References: <20230522033018.1276836-1-feng.tang@intel.com>
 <87h6s4ye9b.ffs@tglx>
 <ZGssENXFKmOk/zL7@feng-clx>
 <87zg5wwppa.ffs@tglx>
 <ZGtnUQJy+1Nrazhy@feng-clx>
 <87pm6swi7z.ffs@tglx>
 <ZGuIL6tyzzZP3kyR@feng-clx>
 <20230522161158.GA3330346@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230522161158.GA3330346@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ1PR11MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ba3ce9-1c5c-4b37-d18e-08db5b2c8ed2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dr+Q5Pb1Th1uhcnavdTrAMeLcRuCOMKtKaXFAcoY3u5J3lFD1t1qzRl9uemkYcLPbXqfziSBTXthfrpI2eN/HVOrM3ogHrcsa2ietCRPcdO4djssFRhFPs4VLllcc5hW4hXxOag29xCh/lM+Raad/BCcKV828reBpwu9kqmOuWX5CRvxqAgGZabF+f1YEB6snF00T7C0bo+/lgY/CVMC7zo6Dr8v2kABVkqpHmHIzykdAlS6k9XazxAH68Hpb9nbQH4WCatPCRmTlA4KTatFaOanpMtQfEGoQ0+oxqPBR7IdcNZrsN0hbII2Got7SuCoZ9cgSOl1EwfqUl4qyOi/vJGuW2FZhXPzPw12uvv8Dv/tOlIgxgCxHE2+Lz1/lEabPAlHCG0y5eUNgOLRo8HsfBCc+gjV559nlYmWWC6eRYLtW6q8CM+DE2EneesRK6c12B0OhUFLxP5W5w9BcdkveZtqhUW3E7m1SzrH4tw2hKf80MGgL+eFu9AwigvoY2JlcikIPCPFiMbKkFIC8cPSf+qC6at1gFT7a6HZ1haUeAyP/1aLLJ/5mKbLpWdpvqtX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(5660300002)(8936002)(8676002)(86362001)(26005)(6512007)(6506007)(9686003)(2906002)(83380400001)(186003)(44832011)(107886003)(6916009)(66476007)(66556008)(4326008)(33716001)(82960400001)(66946007)(316002)(54906003)(478600001)(38100700002)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5jkAFBYUHSNC7JGoYM0XDuP6O10jvt11p8mps5TsPyxwaUOvNE4aWt9j37Ey?=
 =?us-ascii?Q?H3kJNw0/JWHfQintZA8WGu9OhGp86IwCfEFIJgcvMab3mMxx3odvFJsRll7w?=
 =?us-ascii?Q?98FcuS9D57v1QvGTHUI/5tWu2bfCnjWkB5mq09V2lEFIun6fZ3IG5xb6NLFl?=
 =?us-ascii?Q?AXEnZDUDFOo3dSgtEuRNkD0roKWwPaAQIo0R+JUAdWxtbtpZCxAQajSbZjWl?=
 =?us-ascii?Q?xR7tH2SOFfYwEAJbA/3XgayQbj8DYVMmFKvvWShFRjYfD1hoAyieiSJ+XZRh?=
 =?us-ascii?Q?HFm+4pftDJY0dsQKJrbt9JCS72X+mIW4qAkFa9O9jNVlia0eGNSkbRZFFS0i?=
 =?us-ascii?Q?pXtpxi0NajcjQk3Msvn3F8hXy9Owsbol7jp3Zfz3fHm+bv4ozEFRQ9nph+uX?=
 =?us-ascii?Q?OkSsY8RjbXnhjyY6urDd176WQGs7zte5XoDCMCAH2qVz4STkmT3zbmYa+URR?=
 =?us-ascii?Q?gn86/XiqRVa94F2+FFeqsLotCSii762STr6u4b8XGHkY2I3reTPQUmX2pfRw?=
 =?us-ascii?Q?pu9/GXtbbx4924Wtg+VGyRwpHgoTyQO2u0Q0BODUV1bTwlQz1LIW2yqFQXwW?=
 =?us-ascii?Q?o45Uid6SlHOZn2esN03UgLChFPKyKq6XpNbCiJDI/F5R8M0+ZS+PDctojCYw?=
 =?us-ascii?Q?LKX1GEwpp1DzIeYlOhvVKtjQYqcAw8z+kIxAJVdCjwOEtwiMnf6SiJuoIKXn?=
 =?us-ascii?Q?qmUj4NpDPK1xNK2OVnyjaSj7FYuDbhok0Q6T+rtq8SckC6MN1eAyDQ4kJSgw?=
 =?us-ascii?Q?RhTgem+BPrxZ5C5P0JN954sOP5glcYYddS4saeOCbGAsdYzfYbZRSeJ5pJEz?=
 =?us-ascii?Q?0K6Q2sGvmxlpHwSqOMCIgOJ2ELABahs4pxx7Y4bx1WSqSmQKCnfd1SXlfMDh?=
 =?us-ascii?Q?fbzpLuoo8KNcx6xk3sw7O2S06DgCNUnbXJSCfMdF1K9SJzpAeztEhtM261eP?=
 =?us-ascii?Q?WTN3fzSuJuzx1UN0Wc+YoKt7LTirSXPMe2mKM6Cbq1lBovGfd+JhUPBZQq7G?=
 =?us-ascii?Q?AkhOgpqNWHvk8prYPsMxDL+/Dp6+ls0SK8Frj/wOwYOk8OW321yV/pw6ILs+?=
 =?us-ascii?Q?BVCcOtqav/G7inwCzldd5EXKrF/fl6cgCJxfsynWIp7G4/GUHwVbGPzsfMtQ?=
 =?us-ascii?Q?mLcMKmZJ3k0UlYrZiY1gZSsOULWx/wsARcEK57IoIRws+LN9kQZ5il1BNNwk?=
 =?us-ascii?Q?+iC4+TEBUteGNTfRxIoJeMQZfl8Wt7IyqQIC/ihR0xB9irUsRVEJukL8e+zi?=
 =?us-ascii?Q?hBneeJldlrcAwA9a5V51iw4oxDZOTZ1CFlhxxaH08fHWal2Vd2Vjqg5Lqah0?=
 =?us-ascii?Q?A48ySjfesj2jMsi3y2cPbWASO6giPrRjR6Kp6JSQz0NGHo0Os33LOjhwNgJ/?=
 =?us-ascii?Q?u5sCBD5IgaIM3uWYjTvZWBg/s1MWzqYUQREcnPHgLVL5WdaOB9+6zu1ipeYd?=
 =?us-ascii?Q?9eN9YIxCh6Dk8eJrdktwckOXSdilKiOBs8x1y9LHI/GV6RD8/8ddDLqkiY3n?=
 =?us-ascii?Q?6qDqu5Td2z0chtiC/xo7wWCyOE5ylqO9AmnFrp8l/CyTZld1R9SD3+FfAxdD?=
 =?us-ascii?Q?5GDb1Y538zT/cMLhnsaIZt4CCNZIQggTv6kjRGA0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ba3ce9-1c5c-4b37-d18e-08db5b2c8ed2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 01:25:14.1281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBjXjzDYKBnlyHF33In4ftHJ1wfhpEmA2YLj/ESziuY5ihpkru/P4M9BeN/pRfdQJLshTO95SyFWR7Wzk3LR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6300
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 06:11:58PM +0200, Peter Zijlstra wrote:
> On Mon, May 22, 2023 at 11:20:15PM +0800, Feng Tang wrote:
> 
> > And I don't understand the commit log: "On Intel GOLDMONT Atom SoC
> > TSC is the only reliable clocksource. We mark TSC reliable to avoid
> > watchdog on it."
> > 
> > Clearly the Denventon I found today has both HPET and ACPI_PM timer:
> > 
> >   [root@dnv0 ~]# grep .  /sys/devices/system/clocksource/clocksource0/*
> >   /sys/devices/system/clocksource/clocksource0/available_clocksource:tsc hpet acpi_pm
> >   /sys/devices/system/clocksource/clocksource0/current_clocksource:tsc
> >   
> > The lscpu info is:
> >   
> >   Architecture:                    x86_64
> >   CPU op-mode(s):                  32-bit, 64-bit
> >   Address sizes:                   39 bits physical, 48 bits virtual
> >   Byte Order:                      Little Endian
> >   CPU(s):                          12
> >   On-line CPU(s) list:             0-11
> >   Vendor ID:                       GenuineIntel
> >   BIOS Vendor ID:                  Intel(R) Corporation
> >   Model name:                      Intel(R) Atom(TM) CPU C3850 @ 2.10GHz
> >   BIOS Model name:                 Intel(R) Atom(TM) CPU C3850 @ 2.10GHz  CPU @ 2.1GHz
> >   BIOS CPU family:                 43
> >   CPU family:                      6
> >   Model:                           95
> >   Thread(s) per core:              1
> >   Core(s) per socket:              12
> >   Socket(s):                       1
> >   Stepping:                        1
> > 
> > Maybe this cpu model (0x5F) has been used by some type of platforms
> > which has met the false alarm watchdog issue.
> 
> It has them; but they are not *reliable*.
 
Yes, that's possible. I tried to CC the author Bin in case he can
provide more background or information for his statement, but his
email address is unreachable now.

Thanks,
Feng
