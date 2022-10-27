Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484F360EFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 07:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiJ0F6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 01:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbiJ0F6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 01:58:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18999156250;
        Wed, 26 Oct 2022 22:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666850314; x=1698386314;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dqdszg/SUgKqbArfU0ZjFxrR1VHoAnYIZxAViXCU0DA=;
  b=jYW3KLu3JTJpTI9+n70zfVFQSqamkhLAjmVYTyjZQkYcsb4NbSdwHxkG
   ini8VXqMLC4fucZcNjhgQ1ladSsHQBFZJ+TEdmbapeVA3/XVsEUjemwJC
   iG4AQZockusDkWYYjaMheFWqkowXiqy0/piN/A2myZi0tuwPWic//virq
   aOKbr/G2ecbGhPubR/BkPYfwy4izG/P3Iil3RPNBZ/RCRPA2YVKf1E5QL
   71ljcyHOWpjd1ncxIRglXHYCZwmPPG6HAH4zHaduS5ybkfnB+4fFEdxb5
   jbabfiDhU4/Qrxw8Yb0A2PrShz/8gZtFhJbBG5EI3n42bESqzGKz37rRN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="309229185"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="309229185"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 22:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="774868928"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="774868928"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2022 22:58:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 22:58:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 22:58:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 22:58:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 22:58:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2Rsnw0BR3qOeh02ZgqgKlSMmwkEGNuwfhGZKKWgFohlggglGI7intlHW7IUVCbV7lT3DdIJyBFTpq7z+STBEl+e0SXL9Acr5M85Zj5tA9izaWOPr0x8EJbh8lm0Ye0SyuI6B62dwMnZTuzi8JwoNt2nRJbqdF1wOaa3Jsg6e2sNLRgAXnK0ETIxjPJBuHh1TWQwjobH47RbLuX5GzJNwbK91Zxgw6hcOY+BuIRZH1I9tR6cePn7vcDn21b0VW5r0mL9J1E1ayETobfIXoJ27vUySz7Ri395gtdbGL0HRGdApFZzLIZsmneXYKe9YGoIFdr5xZCrvBfFLWosj2o8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB1+cSKAK70Ifpv0URVnev7npZ+SHWEsOzVqmZwcvm0=;
 b=enEm3UAehP/TXKCvBvD1o97aPzNxX2eSbLpja1U0t2QRMe3hfqEvsuybBYUbM4Iz6AbnEQvbPJ2dmKg9/wJJ5RIGVsFgDdugK2n9vxW6AQFTclIXLi+DuUHcXC3TpgRAqVbxg+8eDro1E5vaCGoUZqYgBua2bvrifxE/AtbzwWwyEgm772AVlxFt/bGGSyF7fubVat2Ng4xX5vN/bj/bRa6FqVLDPgEzYGo1utDGn9+zIL2DiJYsEnLwKZ8KF9haXRd4ivCVG38wLmdGv5ziARab4lg7E6HqhL31g3EZXFIshTCimFp1BRsIPrgoFt77sQvpChtfsDQstTvsi5dD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS7PR11MB6101.namprd11.prod.outlook.com (2603:10b6:8:86::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 05:58:29 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%4]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 05:58:28 +0000
Date:   Thu, 27 Oct 2022 13:58:09 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, <rjw@rjwysocki.net>,
        <oleg@redhat.com>, <mingo@kernel.org>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <mgorman@suse.de>, <ebiederm@xmission.com>,
        <bigeasy@linutronix.de>, Will Deacon <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
        <linux-pm@vger.kernel.org>, <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <Y1od8VwCa9mjkiLl@chenyu5-mobl1>
References: <20220822111816.760285417@infradead.org>
 <20220822114649.055452969@infradead.org>
 <Y1LVYaPCCP3BBS4g@intel.com>
 <Y1drd2gzxUJWdz5F@intel.com>
 <Y1e/Kd+1UQqeSwzY@hirez.programming.kicks-ass.net>
 <Y1kMv1GpKwOSIt8f@intel.com>
 <Y1kdRNNfUeAU+FNl@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1kdRNNfUeAU+FNl@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS7PR11MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf5fc93-001a-48ef-5228-08dab7e044f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjRCPkfU0auv/wC3soRkzTBJSn3sXap8BAy6vxqB8yZZhN3Hq1uFD6ad3OZGdCjCDH6t0eNYEexTOv17M9rwyw0DRHgWfiIH7pH9pwLhPCG9WPQel+eJTjr9DClPMITMbL6meN0eGnryXEz0Tzmh3RoXqGF6S2zYZraHa4H9K6Cgz6uRlM3UQyAZrdsIYuItwKH7A8X8DCVdVfgwMwVI3XBwTCuUyWvQ6aikfqOLbkphBlc+3KwOpXPhu0RldehsGp8zI2H+xqz//+Ow+GgVaGvI6/B7ECW2Ucx+oE/AS6ovmYfPR5p+Ip92f80tMZ6zxIxrRD+ZFqPhdz8/j6Jg9bDn2UFdMaNITah7f4dCFvN7qPcNrTJbBlODKkZH7ptABip6pSbZdOygfekN7Mk679Fl8Pm+gw+50tN4gGL4M+yqZeaPbEc0zHjJGs2188h4FRNfKA2G4sBa+dsiLHeV6CJXW/ln66ZXj5zIt7HtnrEnvcz0HCKCuUC3Q1ZEJKrwXA8iefSopqmPD2CYnLNuCkBiy8lneC8lfuKKvFbh2MxpxpYOdpaviWJZP1U0pRh/Iyb/XiwDibw60Y4mZtx31dSX8mqoyKwJ38umOhUijmLcIkiDSzAtpY1TayC+oMcKIc6Kgu6tFfJo6Mewui6Ni9QdjNWsm97gls3DzjSS8SGmOwxlotDHuNwTmAHLXdAsxSDheMnNFASHYiWx851RLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(7416002)(45080400002)(6506007)(66476007)(66556008)(66946007)(186003)(5660300002)(53546011)(83380400001)(6486002)(33716001)(478600001)(4326008)(6666004)(8676002)(4001150100001)(82960400001)(66574015)(86362001)(38100700002)(8936002)(6916009)(2906002)(54906003)(6512007)(316002)(41300700001)(26005)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?x6O+KEVWc+hBexLBbiH44STnRVSWn7dXcHlv73VBcvWzzCe7kqh9xzruEO?=
 =?iso-8859-1?Q?N7ptfrtvt+BRlo9eQZ5WXWGsclhqkftB7zYejPNn4umMHwmMowSAtduu/F?=
 =?iso-8859-1?Q?4Mt5sIPpKzBVS7XzlptUcPzFQCAbxjzOZ+bpQXckPQqoMjATyFpVjHoesl?=
 =?iso-8859-1?Q?aUXh41NC6YxP/DoTGOh7jkpHIx1Nf8M7pDHRy4vH8w3knT/CU3dtOGjpgh?=
 =?iso-8859-1?Q?kTO+6z4k+gzkmaxGghl1kph9UswKvMUuOdPsJhQ32xFYWmDfHK2tsnG/z2?=
 =?iso-8859-1?Q?mRUqaQ8LkWmJOuiGEIdsmdvAcGSN0FxudvT5Dj7DOR7uLd0O6AB1Vp0LTE?=
 =?iso-8859-1?Q?oW5qLEjQHmIrAIHTmfElQxK8saaSvwO2NdllY1Wu9vXUrOKyOBylqWj5e1?=
 =?iso-8859-1?Q?nI6u+sKQK6ijkREsNpr8QFeIVEpik81ZGXb2E400vbDnZqi2GAszb+z5PR?=
 =?iso-8859-1?Q?VacbfCBFs62UXkuaEI5Y/El44NjyCUMe5sJ5uhSXcoBwBai3yxhiappDG8?=
 =?iso-8859-1?Q?34kldmHcIvP2ml3PwmLdQmGFGes+3lMYcIwbaXygmjP3btukTJy+skwsk5?=
 =?iso-8859-1?Q?QsMyD+ZrlYiwl/8W3hKJ2MFyJTfNMnVs/Q4s7A+fCHO5sRUcSOfX02vA7a?=
 =?iso-8859-1?Q?QLPZZFRvF+jOk+tQW0YBR7jdeIoG7aU4r1ztIzUMzagvcKN1RpDf64VcK1?=
 =?iso-8859-1?Q?gE4sVwGYi40/mKv1qkBovbOaOBQ9of3gjF3RuiEtRggcOEUDofvV3cv+kg?=
 =?iso-8859-1?Q?73nsURemlbIVMiGArC/7l2SGmrFg7P0ra4/1N7OyhoTshRJsJ3vfwm+jP5?=
 =?iso-8859-1?Q?1Ms2hyLjEbwn7YieZv7KAqD1dcvXcD2GitZQ5XKjX5gvKVz23hJfb8FIyf?=
 =?iso-8859-1?Q?qIBpy3B20pS0/EmTnBDw9cM1B961y+VVGpJW0EoW1zqMg4/4wqF5Z3FbSZ?=
 =?iso-8859-1?Q?1W5jSaKzKoWggs73km+A+N6GrrCq/DGW/pz6ZrT939pvnwKRHinbJK099I?=
 =?iso-8859-1?Q?25CykMLnYqOYNjqK8rEBzwzFNv29ZkdHCHSDD7vhyQ1QN24DK6hNvm+wI2?=
 =?iso-8859-1?Q?zge/dNKb5Oh4hkEQKTlCe5rMKdWzuYck/7ERm4Mw5xCGhdRd8zrSK8ViaS?=
 =?iso-8859-1?Q?6RaZm4qvRrfd97GvcqAE9mXdZa1m7Pdr5QCiK10OtIl9SJWpbu1D/opipJ?=
 =?iso-8859-1?Q?M2rvIc+AKyCsqOYQVwnGeKn2YFOS3Ck6aUESMt/m1CP+NuVQlPHorpziCM?=
 =?iso-8859-1?Q?pn/sBSR1aS4QdjPhXSA4MVe9msEMPCJPdYH+uop8rRCQx6VYybSE/iKk8e?=
 =?iso-8859-1?Q?86clnuoW4g4OCv9YPxS54lO+wZdIXs+P5OED/0KjQbov4wAkD7Gd64bQ2e?=
 =?iso-8859-1?Q?tHLfLvg99fyOMom5bs8OokMAmbiCorSHuOEN9c8xpxK132x9ZRiWoSHOl0?=
 =?iso-8859-1?Q?qm7jvyCw6tueUC+bXpz76IwdBsSyP6vw2ALjy7Klmdg/DG+ihFmoq2saP2?=
 =?iso-8859-1?Q?Q9WESfuzxdtBBzrVAg6mvhLQoNpD2JtqEIZT+Abh4xNFIcYTGKo4wj3lu1?=
 =?iso-8859-1?Q?w+J5DgqDBAqfgGqCGPsngnbHr0nBfMu5jQL6M+9jZkiiE48Az0b1vOCR5i?=
 =?iso-8859-1?Q?+ukIA3Yn9R/TPjhK+XPXZX0yfFlRXUUJSc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf5fc93-001a-48ef-5228-08dab7e044f0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 05:58:28.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rinWdhTz+YX9b2u5GLwmp+z/VTWwRfkJL/IGZQ2nJH5ygen9LKmDtY2/+c0+lh7WvGUW7ngC1XV5hFJAm7hfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6101
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-26 at 13:43:00 +0200, Peter Zijlstra wrote:
> On Wed, Oct 26, 2022 at 01:32:31PM +0300, Ville Syrjälä wrote:
> > Short form looks to be this:
> > <4>[  355.437846] 1 lock held by rs:main Q:Reg/359:
> > <4>[  355.438418]  #0: ffff88844693b758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x1b/0x30
> > <4>[  355.438432] rs:main Q:Reg/359 holding locks while freezing
> 
> > <4>[  355.438429] ------------[ cut here ]------------
> > <4>[  355.438432] rs:main Q:Reg/359 holding locks while freezing
> > <4>[  355.438439] WARNING: CPU: 0 PID: 6211 at kernel/freezer.c:134 __set_task_frozen+0x86/0xb0
> > <4>[  355.438447] Modules linked in: snd_hda_intel i915 mei_hdcp mei_pxp drm_display_helper drm_kms_helper vgem drm_shmem_helper snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_pcm prime_numbers ttm drm_buddy syscopyarea sysfillrect sysimgblt fb_sys_fops fuse x86_pkg_temp_thermal coretemp kvm_intel btusb btrtl btbcm btintel kvm irqbypass bluetooth crct10dif_pclmul crc32_pclmul ecdh_generic ghash_clmulni_intel ecc e1000e mei_me i2c_i801 ptp mei i2c_smbus pps_core lpc_ich video wmi [last unloaded: drm_kms_helper]
> > <4>[  355.438521] CPU: 0 PID: 6211 Comm: rtcwake Tainted: G     U             6.1.0-rc2-CI_DRM_12295-g3844a56a0922+ #1
> > <4>[  355.438526] Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0385.2020.0519.1558 05/19/2020
> > <4>[  355.438530] RIP: 0010:__set_task_frozen+0x86/0xb0
> > <4>[  355.438536] Code: 83 60 09 00 00 85 c0 74 2a 48 89 df e8 ac 02 9b 00 8b 93 38 05 00 00 48 8d b3 48 07 00 00 48 c7 c7 a0 62 2b 82 e8 ee c1 9a 00 <0f> 0b c6 05 51 75 e3 02 01 c7 43 18 00 80 00 00 b8 00 80 00 00 5b
> > <4>[  355.438541] RSP: 0018:ffffc900012cbcf0 EFLAGS: 00010086
> > <4>[  355.438546] RAX: 0000000000000000 RBX: ffff88810d090040 RCX: 0000000000000004
> > <4>[  355.438550] RDX: 0000000000000004 RSI: 00000000fffff5de RDI: 00000000ffffffff
> > <4>[  355.438553] RBP: 0000000000000000 R08: 0000000000000000 R09: c0000000fffff5de
> > <4>[  355.438557] R10: 00000000002335f8 R11: ffffc900012cbb88 R12: 0000000000000246
> > <4>[  355.438561] R13: ffffffff81165430 R14: 0000000000000000 R15: ffff88810d090040
> > <4>[  355.438565] FS:  00007fcfa43c7740(0000) GS:ffff888446800000(0000) knlGS:0000000000000000
> > <4>[  355.438569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[  355.438582] CR2: 00007fceb380f6b8 CR3: 0000000117c5c004 CR4: 00000000003706f0
> > <4>[  355.438586] Call Trace:
> > <4>[  355.438589]  <TASK>
> > <4>[  355.438592]  task_call_func+0xc4/0xe0
> > <4>[  355.438600]  freeze_task+0x84/0xe0
> > <4>[  355.438607]  try_to_freeze_tasks+0xac/0x260
> > <4>[  355.438616]  freeze_processes+0x56/0xb0
> > <4>[  355.438622]  pm_suspend.cold.7+0x1d9/0x31c
> > <4>[  355.438629]  state_store+0x7b/0xe0
> > <4>[  355.438637]  kernfs_fop_write_iter+0x124/0x1c0
> > <4>[  355.438644]  vfs_write+0x34f/0x4e0
> > <4>[  355.438655]  ksys_write+0x57/0xd0
> > <4>[  355.438663]  do_syscall_64+0x3a/0x90
> > <4>[  355.438670]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Oh I think I see what's going on.
> 
> It's a very narrow race between schedule() and task_call_func().
> 
>   CPU0						CPU1
> 
>   __schedule()
>     rq_lock();
>     prev_state = READ_ONCE(prev->__state);
>     if (... && prev_state) {
>       deactivate_tasl(rq, prev, ...)
>         prev->on_rq = 0;
> 
> 						task_call_func()
> 						  raw_spin_lock_irqsave(p->pi_lock);
> 						  state = READ_ONCE(p->__state);
> 						  smp_rmb();
> 						  if (... || p->on_rq) // false!!!
> 						    rq = __task_rq_lock()
> 
> 						  ret = func();
> 
>     next = pick_next_task();
>     rq = context_switch(prev, next)
>       prepare_lock_switch()
>         spin_release(&__rq_lockp(rq)->dep_map...)
> 
> 
> 
> So while the task is on it's way out, it still holds rq->lock for a
> little while, and right then task_call_func() comes in and figures it
> doesn't need rq->lock anymore (because the task is already dequeued --
> but still running there) and then the __set_task_frozen() thing observes
> it's holding rq->lock and yells murder.
> 
> Could you please give the below a spin?
> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cb2aa2b54c7a..f519f44cd4c7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4200,6 +4200,37 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	return success;
>  }
>  
> +static bool __task_needs_rq_lock(struct task_struct *p)
> +{
> +	unsigned int state = READ_ONCE(p->__state);
> +
> +	/*
> +	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
> +	 * the task is blocked. Make sure to check @state since ttwu() can drop
> +	 * locks at the end, see ttwu_queue_wakelist().
> +	 */
> +	if (state == TASK_RUNNING || state == TASK_WAKING)
> +		return true;
> +
> +	/*
> +	 * Ensure we load p->on_rq after p->__state, otherwise it would be
> +	 * possible to, falsely, observe p->on_rq == 0.
> +	 *
> +	 * See try_to_wake_up() for a longer comment.
> +	 */
> +	smp_rmb();
> +	if (p->on_rq)
> +		return true;
> +
> +#ifdef CONFIG_SMP
> +	smp_rmb();
> +	if (p->on_cpu)
> +		return true;
> +#endif
Should we also add p->on_cpu check to return 0 in __set_task_frozen()?
Otherwise it might still warn that p is holding the lock?

thanks,
Chenyu
