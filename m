Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43902674670
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjASWzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjASWyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:54:33 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA4987641
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674167839; x=1705703839;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xUOiNQeZB7VXEqB0npuiBeHtF++IuOaIalFEBKhSRs0=;
  b=GY5oVXtnXKKVncV4umwCcEdZ8rSP9vQFv5+94HT2G5loEm9qjYOtcvCE
   bhErAI099/28EWnaUcqv4yizMWnJ9au8T19BUgGbyeFyZIDbkTIQWhAP2
   MbEisAqOvu/T7B/S7gpY//MsLjLlZ4FXKssYKtYefZBELWyAj3v2Z4aki
   b4yYgLDB4BKCs1wz0774rXucfjaGCdwiqsmmZpCPA8sqcHo41Me8LQCCP
   3qrvqHZDCx5g81ZUnrL59858D39v+MCcTbHP0w1zEMir9BDkg8h67jo6m
   pHin42e00082VY9if+VypD+4gJQ6bzKSGG4Ck2DO4q/1SdBDtnzkYoKUz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="327541801"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="327541801"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 14:35:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="802818339"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="802818339"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2023 14:35:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 14:35:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 14:35:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 14:35:10 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 14:35:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUsbW4LVbVuJ6K2MatBVquTcBD/9G1lw0gelAqnQabgAz19LE6ofnR9d2XjhWdfM5gbi7/SrSYcyIERRvRsE7CztQLNO5a+Yf4iVMyu/hY4pqk5ztTwnD/KFlfY9Xx2eGgdPwk1YHDIFB5g/459YwGZlELEAcphJ3NWYa5wjN91V4RKWYOBmktru8a7dGVmXjfK5g7TgzFLbSDUEA49sw14qSoiSGGycFtbGLYKOYB21TlkOs1hR31d9R+g0f5u7b+4c7fDA1/03JlCo7/LcJxMpUmSbr5fatm/u3bzKMflk7QoZ3rOuPvhpdlaZ7Th51Zl+72O6zd/DdzC3zZAbtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2heskgq0kvflQuvE3DFplQYj3SUTl71iI9tAFKncSJM=;
 b=caVfi5/vJW37B/fzVTJKFpSoEAVH/Vq03WWOstiBEXtyw0YuLY8GiOFKbx9Sl9Ir3BNySkesC6JKtWDGh0WbZaNvMUzimFmEp8aQo0VMc1FPmw9yCVEhG14vyin1algWCJJeMEz3RHl2XVYSeIWNbdhcJ1Tgct24uqqMq9w5O6+SXmRUNxHJxwcz4MqLYAfum8TIivALPOWzr527pAIZrenDUQoS3ybCxEgP8UZYrVAIFtfwcG8YnLyPUTPNSs13hsAj6IEkO4VY2PiOEAV8kpLbHwrDWd3UrB8wwsQ6L19YdUd7dl1EzjQyMfDFK0dw4liji4qAlbwMEsZYDI2wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Thu, 19 Jan
 2023 22:35:06 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%8]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 22:35:06 +0000
Date:   Thu, 19 Jan 2023 14:34:59 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1 Part2 2/5] x86/microcode/intel: Add minimum required
 revision to microcode header
Message-ID: <Y8nFk/0D4XVPOx5a@a4bf019067fa.jf.intel.com>
References: <20230113172920.113612-1-ashok.raj@intel.com>
 <20230113172920.113612-3-ashok.raj@intel.com>
 <873586i3ml.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <873586i3ml.ffs@tglx>
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 7149b05d-6b82-4802-d962-08dafa6d69aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igekBbiUUiP+msnnUMVNGXFpdj02YgCPZeD9ZLbBkpQGygSiWvCM1GEmAyy+IpLH7QA4LZkkTU4L5xzwFd/sX1SdFI0DPLQFcZEbIPJomS7Z+qhyxcrg0GBGc7arjCDmYZgBjPCcrFOksQgFX/pfEESwfImu6rA6qT0DtuuixLe+D3AYe6O1Q6Io58mlmZMeRN8WfHKutyyM6OlHbMWFED874qEM0QZ6KGNxvoTYm33e+ui1Q0JD4bBHm8aOsvGDRxND8AHf3Lh+zeKJa2pDjIXwiGba5OwyVhS+6RPYgvtNOxYtkynpNtWKgj2RwwcXKjAV37XqT9mLU/CoBAmJNYor8ps9obk46feZmLgmIhqI84EutE2U8+JATjnSP5GWKC2WdkRGUWxI/3TLgGZkVKr6zDZR+NxMcFAgL7Jp8q7upF6ry1l0wCF8k2MsiJu+utzViG6ueAGo5XLDHF+ovet1GK7vN9iKGLqQIaMwOFMeS2eW2Lny/RjVaz2d2d0XeMVXNs4UKSyfet84FFkKnp8r2PPcox7fePY4JgzG8DYrptBMkQpK7MhBwY1zZ2kZrug6Yivpowjj7vPxMUGO0aiex+2156JNenLQQZrIRgRXZ/m2w5g6nkSkw5KA5wVm0cDfgnosRnra/8bF5DqpCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(107886003)(6666004)(6486002)(6506007)(478600001)(86362001)(2906002)(316002)(54906003)(4326008)(7416002)(82960400001)(5660300002)(66946007)(66476007)(83380400001)(44832011)(6916009)(38100700002)(8936002)(41300700001)(8676002)(66556008)(186003)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lkotYpuYHPDHsqapUQSdbHUdqLQbx9MFOuZrvBZZFnnSTadv6x1KsL2TZk3d?=
 =?us-ascii?Q?te6wvjDX8ebUl1t0HIf3l0FXUy0b9uIGiLjCVdbvP1S1BObRmFRcRHO4moFY?=
 =?us-ascii?Q?wB8x+s+1ix3BRaCP0xcW81F3FQxbUnPTQFxvln5vGp5mz1NvfPWAYqJR0HV8?=
 =?us-ascii?Q?dEb2LNPaZ6RABXGN3h81KPu7LJfe52pIh3g7MXMYP5R0ieks+S3K6XeY1pnc?=
 =?us-ascii?Q?DnhOUiVPDJaKEmWG+znMQ/pzfIsJLPLUeSco4p9FJnajgGrNTrATrrcR9Vcm?=
 =?us-ascii?Q?Ev+idd6tOTuCGWRccp3rPFiTnxeC47bHlAYhtKBhcbo0k8QrDGXz2RSLHD7u?=
 =?us-ascii?Q?E8c+xb9Su8B3yc6pf+5CfAM0dbZOEHcrO6zU7jn7r1B/cQFC/uHzJmfTjjH4?=
 =?us-ascii?Q?er3M5OTemTT9G81dLlu/ewmCM4M5F27fETE0xh9uhAsZHtRjHrmZbuUW6YeP?=
 =?us-ascii?Q?l2r2/HHXXg80cC8WE8d/8RNBqcUJAhwhOr7c7Lnf49U3FnM76a4m/r1cQOtT?=
 =?us-ascii?Q?9ciWbZGGdJiLU91wVzGCOM8+pL94hqDDeIbVkSPj80mBH9H6h46C/k7yGfB6?=
 =?us-ascii?Q?ikKOHYln+WnDsmVm87b1TaWWU1uHRSorWdBLdZAMnwW2SUzOP8qVmXXsoNnF?=
 =?us-ascii?Q?nBRGPS+EAedhnXVrA3jbfIN3e+wqplW+MgceLTuJj8UDjRPgnI6R1uNaHFBl?=
 =?us-ascii?Q?uuJd0BLuW8NXJVVrREq+RUlO/z6IXBkmU3NQZS3bI3XNkmCzNqBXkBg9x/8i?=
 =?us-ascii?Q?QGzkm51L4+mSTNOogaQtpBfA9z+MT/68jZgiV4+7QHX20ht8Nb+G5i+Fjf72?=
 =?us-ascii?Q?HpIU7Tmct3Iaa7d84SbhC8Wef1XBRaPU1YtXPtmcaKs19RviA2MyShgdIjig?=
 =?us-ascii?Q?osjicOB+kUWcLzvSSr7YAqa8p7D+leLuvrfOlzuaxVNM0/JOioQFkqzQTm65?=
 =?us-ascii?Q?7t63ypMrhWCqHwPepH+Y4th2szEH8peXTM/4EXS8t31TTzZFBJTVtCSWm7pk?=
 =?us-ascii?Q?hEFO3FgaQ/XZDgWdrMfHJWKOSSVBqQGZaHkbDhkQE2Lf18DtFlYICGrPaIK9?=
 =?us-ascii?Q?BUB6Y3Kti7lO6V19LPkK2eb3Z3QqXBBMiZWkDcv1JORAIGdZTImkRT7SAZuJ?=
 =?us-ascii?Q?e8sQ7EmZ9FV1PcRq56/OZtccFKJ2DPtJa1WTz6IeXmRhvt0UvgGfWzuv2D1d?=
 =?us-ascii?Q?oOhHG4RQk475hAQM7q212rbeutkhKV73YCg4+g4/WqzAgLVLPPDrT57fbZrl?=
 =?us-ascii?Q?RP63N+nZ72GNWneaW79C+S3T609SEn1J1BNmt1z5m8wdroAluozt0gh4c6ye?=
 =?us-ascii?Q?Yr36TZhFtvbtaIHpE61gXfeS6cJLx1GlX0Fb+E1S3dLvIgnPry5i9CCXPI18?=
 =?us-ascii?Q?U3561Qbi0Y8huieuljSBQEVY+1zZpj+7P4kRlyCLlB5znGadi3OBm+vk3+Yg?=
 =?us-ascii?Q?HwsLpbjHpgI14TcO2wjCu+8MLWWY5KS/HF3zR0zzHA6/qf5KLSTKlaAZixE+?=
 =?us-ascii?Q?3Z2irFWcsyAHApsB3seY/RUqNDrhCfFC7l4dzWHxr0GwPsIOHi4H5VzqsSl1?=
 =?us-ascii?Q?RswURtlQ1ZzlFeQslkhMJi+LxhBBwhaerS5FDe70GeKdv+N0xMn3omvr6bDk?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7149b05d-6b82-4802-d962-08dafa6d69aa
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 22:35:05.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTCSew4kA9NiePUDxQHGPDrWcZlIZ+JTbPKExal4jgPkYibFdi24cE7y8kOMS6WaSCN1isHxLzVst+eNmnIR/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:03:14PM +0100, Thomas Gleixner wrote:
> On Fri, Jan 13 2023 at 09:29, Ashok Raj wrote:
> > In general users don't have the necessary information to determine
> > whether a late loading of a new microcode version has removed any feature
> > (MSR, CPUID etc) between what is currently loaded and this new microcode.
> 
> s/this new microcode/a newer microcode revision/

Yes.

> 
> > To address this issue, Intel has added a "minimum required version" field
> > to a previously reserved field in the file header. Microcode updates
> 
> s/file header/microcode header/ perhaps?

Yep!
> 
> > should only be applied if the current microcode version is equal
> > to, or greater than this minimum required version.
> >
> > Thomas made some suggestions[1] on how meta-data in the microcode file
> > could provide Linux with information to decide if the new microcode is
> > suitable candidate for late loading. But even the "simpler" option#1
> > requires a lot of metadata and corresponding kernel code to parse it.
> >
> > The proposal here is an even simpler option.
> 
> IIRC this was also suggested by this Thomas dude, right?

Same dude.. might have been your twin :-)

I'll fix it.

> 
> > Simply "OS visible features" such as CPUID and MSRs are the only two
> > examples. The microcode must not change these OS visible features
> > because they cause problems after late loading. When microcode changes
> > features, microcode will change the min_rev to prevent such microcodes
> > from being late loaded.
> >
> > Pseudo code for late loading is as follows:
> >
> > if header.min_required_id == 0
> >         This is old format microcode, block late loading
> > else if current_ucode_version < header.min_required_id
> >         Current version is too old, block late loading of this microcode.
> > else
> >         OK to proceed with late loading.
> >
> > Any microcode that modifies the interface to an OS-visible feature
> > will set the min_version to itself. This will enforce this microcode is
> > not suitable for late loading unless the currently loaded revision is
> > greater or equal to the new microcode affecting the change.
> 
> Up to this paragraph the changelog made sense.
> 
> If the currently loaded revision is the same as the to be loaded
> revision, then there is nothing to do.
> 
> If the currently loaded revision is greater than the to be loaded
> revision then it is not loaded as the kernel does not support
> downgrading in the first place.
> 
> Even if it would support downgrading then this would be outright wrong
> for this case:
> 
> Rev:        10
> Min-Rev:    10
> 
> Rev:        20
> Min-Rev:    20
> 
> If Rev 20 is loaded, then you absolutely cannot load Rev 10 because that
> would have the reverse side effects due to which Rev 20 prevents late
> loading.
> 
> See?

Yes, that's accurate, and in sprit it works that way.

The current_rev > mc_hdr->rev is done in apply_microcode_intel() but I
suppose we could do that check early. 

I didn't touch those parts to make sure only minimal changes were done and
we can do cleanup's later.  I should certainly add a note to make sure we
aren't breaking the rev is always greater than what's in the CPU for
clarity.

I do have several cleanups lined up, but didn't want to hold the minrev and
the nmi series.

Cheers,
Ashok
