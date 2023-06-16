Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93510733454
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345912AbjFPPJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345907AbjFPPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:08:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E8230E7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686928129; x=1718464129;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D/jo1Rb1MieDx0RtpxoiLxgHMY9h9C0dt3rO38ccRYY=;
  b=mZYvlynRZc8/JNTdPh0O9h7MnLPibuHgC5wqibJra1as2IJj50xz6my8
   BSIffNvcXiZZGAdSM4C2uuvCz6hciI4k8I1IqACVnatfH/4yrm7ZePvsF
   8Inj3aeHB91x/M0bPwLMLSGyhlHowx5Kg0gdmn1XOaXN92QDLNf95/LLI
   8PM9KZv24A3Lo8jYT2XTlsfBeVmNYf/K+gLzCFfeNeau1g5+uR1DurSos
   Nf7TxzeAtODXF3y/bpuh0KsxG8lybIkZMr+Ep6gNl15hpGsZJPutw1pxg
   23hcSpklbm2+DEOdubAvrtjmtooUveKiTL8dtb9oyl/Q+A8r+bqUFiFWb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361764059"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="361764059"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 08:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825773937"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="825773937"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2023 08:08:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 08:08:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 08:08:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 08:08:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 08:08:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbEwcgHokQxKTPEKbb8emI1ecIepHg5qX6CzBCK8iz8n7wEkb4bvFRbHihlSmouPjxJNZ4kReL0sE7dYtDkkgWbOkdYlnUe/9aWotZwqtq5y1ZQ44zLr15EcYvbQ7H6g7fzAMxBgddUAUObOJ2Lr9RmSS2ISnHHnOhxSahWLYN0QBkNZcfqDWb6fls6FT6KJFhCOXqiT4733WRg0DgkG1WqNRt5mjQq2nKbBLReFIm27Pk6MYp2G7uv60vJ8/QAeK8wX8h03kDKhqr8Ta1H/H0srJIbvlRYyLqiaHR6xuHRd7OQWHM3f3vMZddhx4/C+JiRLhb5qIVcqIQkB49KzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NRG5Y2JcUMTj7voUNetr7+o6ap3XJqw2cQfSjnSAyo=;
 b=fCx/vxv83SXDmjkxljNiLiH6wtumWFsggD3x0KvvlZp1gZ+KMC2dPzKF2w1rsF4no/kFgYILkFxFqNe5/qPGhAM393YsIz/PdRueWSu+KQrWi1fW5wXbawPL6LphHEnrbWSusPqoW3kPb50AHyqratdi6H43JYRNvC3PD5/GWZ86V7HmtLDZiV54A6SMsC0SHSZ964RymxaeHN1eHe4OweTtMpNvNgTD0G8jcj0UXfsQ91oYRObNwCVNd/ze3OwhNukbzBYlS+N06z+09GKtMO2FwjZ0TEN2E6WBXpL8aj8ZbcxKO6p5e2My/WQSo/LTkOXTfsbRJeBFcfXZFZOMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CO1PR11MB4834.namprd11.prod.outlook.com (2603:10b6:303:90::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 15:07:54 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 15:07:54 +0000
Date:   Fri, 16 Jun 2023 08:07:48 -0700
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
        Ashok Raj <ashok.raj@intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Andrea Bolognani <abologna@redhat.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
Message-ID: <ZIx6xCgdILbjcw7H@a4bf019067fa.jf.intel.com>
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
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CO1PR11MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c24f839-f049-4f47-ea0a-08db6e7b7616
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4bLAOqA26p23/MFOoA1riUWHQHQFvfFLMjTrU5vWkDgQEBwbH3BOV9nfieqRo+13SBwa+KoFZWqCHd8Tw4xzI1+DzG7C6J2zFPJKvKC0TlmZOOnub2EqgT7fMcAtli9lWh0iMKGJPb1S6Mqr2w6B2e2d6Bzgg0uF+WedgnSFn3lHXasaXRmLFhK/SkYro28tkT1o86MeP7qNM9duVNsL9A2MXvpiEWuHkXhKnn3tkJt/kpMJw7EmEQhNx1G3ne8rn22FfNn6QGuO2VeDcRuAR+EJUpn+Was5V3mQE0kB8hKJcMtTJ8HDkfYSefDnZZ3ux9EHe0dB/Dm17dTY/i2phx4drzs+jwNOuzap1GN0Kc7ddPG0/l8hkBpnmhs6hN4HTyrb0HE4qK802zLxZvw2tcHsmoOWZFGpsQQC7LKC2IzULqAfM6JTM3LxEee5WH16mVylnNPk3Elr9jrO1EL5Baj/gup3/X3C8DVJYS9gh3gsyqkkQ1n5jfpJczy7YddShvrpZokQpHKBoS0wFKpEIkAD0Pn2Ep/boooZogTn47OETT4AEEaNylsBnCoi7stX82cG4KN9TiauTkvzR3r8Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(5660300002)(478600001)(45080400002)(54906003)(8936002)(8676002)(41300700001)(316002)(966005)(6486002)(6506007)(7416002)(44832011)(186003)(4326008)(6916009)(66946007)(66476007)(6666004)(66556008)(26005)(6512007)(83380400001)(2906002)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DN4/pxxTA7YFubAyu8eJTerMWrxxh1oVldjT1pRkw1ux6JJFCYaJXSAqEoum?=
 =?us-ascii?Q?z9FXicQfZ7/5opX1jQAQHzji0RJ8HuOKjJEA5HEX31aR5DLq//GitXO9hxpP?=
 =?us-ascii?Q?saBBdqS2wPv3k5u8Z5Fx2JiQMilAS1ShplqU2CEpIFgATrKFqGVWCo+bh07x?=
 =?us-ascii?Q?ajXGsC1WK+QxBe0WSSplVGU+TLblUtsDqEsidTzyNfwqOMCiEMvD7y+e1K9H?=
 =?us-ascii?Q?NUWs1jBzVdCgcMw0uzrYKagcpID5bWI2iR225C7N2I1J+K+E5xXb8Lz17xMi?=
 =?us-ascii?Q?Mdha5ZfI1YgZQORTEcJWATvGnC59lK1UeCJceev/g39HvK0FOzTtyW9G0m+W?=
 =?us-ascii?Q?2PjSr0He+6NO7yfXgKOKYfi5OrT6KMbYz7M+/qOuZSP0akklatGJBm+e2Cc4?=
 =?us-ascii?Q?mVN3EWA0ci9v1RV4UcN3m7UKYRZMC/34O5mg2SCtFOkI9aCzWouruJOFyEYc?=
 =?us-ascii?Q?P2oZxBihuXIxMr27I39DJECU9nLchDDpo9NrulBbGGzBQD5X2nIc+0cH8EYq?=
 =?us-ascii?Q?QLlayzWeSLi0d+ZvWv5Gtqo1U6CgUC9ccQMHaTg1vGPm9t+YUH699vwzyCVH?=
 =?us-ascii?Q?jq1aOlJRFqY0GFoi67WxxcueW1SGOReWop/7ltMddjCU5ZvEYnzgMQqrF2AB?=
 =?us-ascii?Q?8dT2ENQus2/lfN1+7IqKZm8cD5czDA1HhcLlXGUSLia0O4NaTA8x8iHlUXYe?=
 =?us-ascii?Q?4/trKJNDlnsiYPDvyq3C6KWYGp1mKqQw3QY/yD2pn64GKDSBO3KsJDhJuean?=
 =?us-ascii?Q?PaRKMhJErj/Af3UZoCK5OM7MzZazchJzqh5MGAbhbmBImXkp8bg9jje6ShTY?=
 =?us-ascii?Q?1Y0ZBSznLvj+Kgbva0KFls8FyCkeWW4qNoAqpRZRgG+pJsiEgNaXHwTd/1qi?=
 =?us-ascii?Q?4M2yoBvsOzmgy9NVqaPEd0muTu4Tun6jHo1Ft/mO8aLDo4SKbKDloFkDSB0X?=
 =?us-ascii?Q?7RsxLBuXXPjKRUQEmu3gCyarPif66Nxexyi7rK/Alblgd0jDgpxOjGfC/kzO?=
 =?us-ascii?Q?zUZyRNsGxXQit+Sn7s7imPp0cSyqVMICYdBpv2dUP2pcAgB38OEC5ZvZ7dko?=
 =?us-ascii?Q?6fVEM5JDwP6r6W029k+eedteOPMx66zyBXwVtLM1hjrNgQKadfCzRkPPLFBI?=
 =?us-ascii?Q?FS6WmgauMv06VnxfbiN96uHnAxyaEhckJaDWZLYzNCabBQHqLoJ0BeOgj+Bt?=
 =?us-ascii?Q?+uGzhI7y4CGKspwq5tZlOaehB/nMMetbBnsEEj390QFkEmxHgEAoZ8rnUiUR?=
 =?us-ascii?Q?rlFPiUogxbtDp0z+eEsoOC4JXFmQ88bR0vGmCT6lVHdbDf7yLAQkkqdoZTQN?=
 =?us-ascii?Q?Nw0gSO56JJ5enquYrfCsZnBswNCRcCIexKh9VqayU3YVBvgPX600AJTuFLZu?=
 =?us-ascii?Q?wJwpRar9k1dHqc2Ng/2y1O5L9l/K3BAR9dL/Db4D2CVXe9ow6SrWREC06cBR?=
 =?us-ascii?Q?mDdVxF8Gpt1blO1pgyMwnz2UWRSwJa25bsH/0MlBbkkwNGSK96UkKaKy3kHT?=
 =?us-ascii?Q?1ZeGm9h7NTZtiGTvFlZAt0idEM9BOO2eWKGyXbQq+JicLfvLSFEaJ/y+EyEr?=
 =?us-ascii?Q?7m2HF0sn5/LwCgcd4WagGOldeMNvdgtcqrjWl7oT+t0rCB6OK70Ih0ieiIvC?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c24f839-f049-4f47-ea0a-08db6e7b7616
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:07:54.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpPUon6LL9THR/ZP4Rb+TdD3rzYvCEaty3WtaBvBsyanA5KGqU8nzyXLwTylSkkiXuidy9mdIKIVM4RC2xWSYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4834
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

On Wed, Jun 07, 2023 at 08:46:22PM -0700, Sean Christopherson wrote:
> 
> https://lore.kernel.org/all/BYAPR12MB301441A16CE6CFFE17147888A0A09@BYAPR12MB3014.namprd12.prod.outlook.com
> 
> > If there is a specific test you want done, let me know.
> 
> Smoke testing is all I was thinking.  I wouldn't put too much effort into trying
> to make sure this all works.  Like I said earlier, nice to have, but certainly not
> necessary.

+ Vijay who was helping with testing this inside the VM.
+ Paolo, Laszlo 

I haven't found the exact method to test with secure boot/trusted boot yet.
But here is what we were able to test thus far.

Vijay was able to get OVMF recompiled with SMM included.

Thanks to Laszlo for pointing me in the right direction. And Paolo for
helping with some basic questions.

https://github.com/tianocore/tianocore.github.io/wiki/Testing-SMM-with-QEMU,-KVM-and-libvirt

Surprisingly SMM emulation is sadly damn good :-) 

Recipe is to generate SMI by writing to port 0xb2. 

- On native, this does generate a broadcast SMI, the SMI_COUNT MSR 0x34
  goes up by 1 on all logical CPUs.
- Turn off SMT by #echo off > /sys/devices/system/cpu/smt/control
- Do another port 0xb2, we don't see any hangs
- Bring up SMT by echo on > control, and we can see even the offline CPUs
  got the SMI as indicated by MSR 0x34. (Which is as expected)

On guest, the only difference was when we turn on HT again, waking the CPUs
from INIT, SMI_COUNT has zeroed as opposed to the native. (Which is
perfectly fine) All I was looking for was "no hang". And a normal kexec
with newly updated code works well inside a guest.

Would this qualify for the smoke test pass? I'll continue to look for a
secure boot install if this doesn't close it, just haven't landed at the
right spot yet.

-- 
Cheers,
Ashok
