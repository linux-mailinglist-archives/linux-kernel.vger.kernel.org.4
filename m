Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ED65F0226
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 03:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiI3BQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 21:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI3BQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 21:16:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F2011E0E8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 18:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664500563; x=1696036563;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=04McLaTTJFMz/lD3u1giz0tOsXhjyRa+IugcVxvPIck=;
  b=NKpYtIpKbZmInoC+xgb1nXvMHG3/xOJ8ty2AjMfZ+I2o/BKOfhjQaTL6
   Q0T8JfMLjkEbdHh8eH95s4mwy3CNNar+Hp0yoGasa9OfH/wnzB4nrFENu
   EudFXLLIuTAIbZJqvnNj/yKBstbnx2eixnnyJB5T9pFnfTVK1FI81a8fs
   Fl8XfVKF0lzIBdRVssi0gF85l4pDGhlv7FZPA2OBoLKzxBHhBx8Py3li4
   hQntInB/BfSa8/bTtqwRLhTHqruTsezI61DKWlkJHJDmTuPcQyd842VQS
   wy0fvpkCFfP1LSm374hMSZ6dXobgK2ie/uBb/jLx2bXFIOBlwAzNpQzaU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="388349373"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="388349373"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 18:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="764952251"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="764952251"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 29 Sep 2022 18:16:01 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 18:16:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 18:16:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 29 Sep 2022 18:16:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 29 Sep 2022 18:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iP3ZzcxItliVpcJmsg5pcaE2kw5bGI8MYhPyf9GOA3VQoHLZiRT2RrFVWQIkFf88SOeWnBWmayGDmqu/t21tlz26j0HBtch2kttEjakGUvKgRRlj13L/oGF+/nBtIkXxoe6A9QTCINn8rcpZIDSMSN9zaG0ZRyLiTimzsIon5uTUwKaYHLTV0klAKP5xCpY8IRyDk40r5RgOE2AxgQs48EZb13vik+rOCEQP7YIsgOZDASd1DDr2Ri4JESOUw2pcmJEDYjnQcBHD/QMYtJxh1EWmLklGCaJco4yVQRgpNUKuaCrz21zyW5LsifIPlFyt+IJ/VpkbXFOj3cKpkCaj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFI4M4ehAjTqf/VzsVThN01xEXPmySYZKklRpwkdEUU=;
 b=G/qo+fWNJ7+xPVJTBMLwWHqiurXtanjMkMQVf4e5lC/hIqIZIkKx7vZru15xzzV9c7H+FwY8kuBgYMzp3wddOpXqSKCgGsvCrSyq4CZvF9c4avf7Jz8qRyyUahMoXAl9TjJsPb+VZt0YTVY6QvAEcAcoxQI3svcQEZadf9PJXXyElAI0PONq6Urm2YQdxwp1dv5EPvy8pJ7SQn0tCH4RcZyrTON/oHzUBgDUjYwldDL1JCHggVGqb9MOLdGT5lKlihIUm3SImAMR22NgwtjnfgM+8p2oK4sAgDccplIcwYeDVtkrlT14U9ebRQdCEjDdrvMA1wrRb8aRDrHWdxvjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 01:15:51 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100%6]) with mapi id 15.20.5676.017; Fri, 30 Sep 2022
 01:15:51 +0000
Date:   Fri, 30 Sep 2022 09:15:24 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
CC:     Yu Liao <liaoyu15@huawei.com>, Zhang Rui <rui.zhang@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <len.brown@intel.com>, "Xie XiuQi" <xiexiuqi@huawei.com>
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
Message-ID: <YzZDLBKbDTbNr45b@feng-clx>
References: <20201119181904.149129-1-helgaas@kernel.org>
 <87v9dtk3j4.fsf@nanos.tec.linutronix.de>
 <20201126012421.GA92582@shbuild999.sh.intel.com>
 <87eekfk8bd.fsf@nanos.tec.linutronix.de>
 <20201127061131.GB105524@shbuild999.sh.intel.com>
 <87eekairc0.fsf@nanos.tec.linutronix.de>
 <bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com>
 <9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com>
 <YzY6e0UwDAyU1GrX@feng-clx>
 <44206484-620d-abaf-4fb9-fc4ef1c9184f@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <44206484-620d-abaf-4fb9-fc4ef1c9184f@huawei.com>
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: ac43558c-56ac-4bcc-9c81-08daa2815093
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yb5UNyxYDdsTqIOcfNLqUW0VH5/Nkc+cbiAarV0BW32w6wyydGm8bOz0mlIMIzlacPuyzkyGTt7PLiTwk7tDsK2l39P/Td+IZlNCmdPmA45NUid5s94cygxvpsCEjWgDkTskUd2mgLURlOAQVHJs5xPh9d5twjGScvhc54bZYJueqhOFsuHe2RNyN4ITqUjX9Z5gi3oaTfMFLkA3aTQwFHV0DxtR91HADJPN/yKwe5Lfb7m/8ZvlE2mlDAP4+76M9KqSeYMCQ3BplysiyDE13FyooOzkKhI8RcMuiMIIL2XzkPMYeQ7H8zqCWlLsBRD6eHzbZMB+o69A/qvZANpFPlRb02PgJh6uOlEw6T88MMeYR4NnW/OaA1xlMwgBAsANVDGueywWB585F8boMepSi0YngbyfqcoqAiYh+JfmBWQIxVub9sy3WJZWpYYgOrX19q2nvxT6nRE6Aso0zSSzsR7hL8dqyIzUapSsvPA+eyuq33o6G2jyiSTk8Yoj2VR9vTXZHtC4Di2HeoLoWcs3YQFHfBenFVr9KjQ7h6a0G4IkJXVZhx3BBaKeG4RMddYFfRHqzAvqy3KSxymDIHeq/Iwc9qWazbssF1INqj6esxIsYgn5KbHxB7iHgyfZXKJrAvkYPNgMrf2npVFIHXBj2t1Wz/r8jnsg35CKJg0wbAufa2LmpvDCcpbI3v3uoydjX6nLT/4KqxPbkwqnRW/HTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(38100700002)(5660300002)(33716001)(8676002)(86362001)(8936002)(6512007)(6506007)(9686003)(26005)(53546011)(66946007)(41300700001)(66556008)(4326008)(66476007)(2906002)(83380400001)(4001150100001)(54906003)(6666004)(316002)(7416002)(186003)(6916009)(44832011)(6486002)(82960400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cJk0W8bWQHaws3iYnow6SxktBA8PdMnFx43555EnXHUf7CKv/IQPNoP0s9iL?=
 =?us-ascii?Q?QO815hZc3xJ64qGKJeQAX7SkF3zhr4/0YCDKh8dAES0/K06jiCuOzKQO+KWW?=
 =?us-ascii?Q?cln9XJsQKQuT2ER/pSws2lpgNuyjNdCn+47IXfhQrBKl5C7AiEWQqh4saRTT?=
 =?us-ascii?Q?aSQB1WLYJFv0fDLct7UoA6J25/cwNoxSK7fsWrkmCJYtEQaD51TH5nYatNxB?=
 =?us-ascii?Q?WKMzy/ofaM+VlBenEsCsLuSj9ksVOhHjv0Qsyz5KkYqSzYCeoj5Gm6y3SK8s?=
 =?us-ascii?Q?PE2J2/iABcCz5XzzqUPxqI3OB1R4Uur0QxfBzRq2gjOdVAiuouqX3v2TVGt5?=
 =?us-ascii?Q?cHMRP3gKHfI6YpW1424plDOxAGqJpcTO+/d/xv9zeWJQLGESrJw8i8/2HT9X?=
 =?us-ascii?Q?+i6RVfXvsBWDEOHXuBnqlKPSCeF0o+htKMDDqjFgDSeWGd9zmo+1iFqYIj8p?=
 =?us-ascii?Q?esMVeh0b1mU0/ysdi/bjDg281Neaqf+JWYdLkWPSbpgZkHhUFS/v78RlYtFi?=
 =?us-ascii?Q?OuS3+EEwZv4dxJ+w9qseXZBYu/Q3ZEHq7kIy8EPxpyJ7XyN8vknVhU5fUqAN?=
 =?us-ascii?Q?jIEuTTYEh0YWp+Z0jwIkKXMI5hgY3eGIS7wHxbEuzhg1qnatFPQb04QatB/2?=
 =?us-ascii?Q?qhK5iDl+Nn47lJYPITCrbwTjB+QCYHuMIAE5TpGP8PywOKFU640WLiNWwyj4?=
 =?us-ascii?Q?j7QpnArhC/N1RQ0ZBUX54SjdgTbMeONA2LU/2HxhnbXjraIVwOR4fTxOOuC9?=
 =?us-ascii?Q?6/p4mvncznuzQqbrhoCeCqVHfVQrRDjZr71wzeavWm/COC32cQH6Py5MLqtF?=
 =?us-ascii?Q?pnNLDtYG2Fa7nqeHj+a5JW3FjmdrD6qosr+fq+Tp2gHW5Zaz0hgZiq5FKUI2?=
 =?us-ascii?Q?SrUuerWT+Bu+wY+kxeLY5eP8e0+t/UiqcWGVKHUcIZ7q1FdeXrAzJ1GePKQS?=
 =?us-ascii?Q?xgg7iJBpc9XAsIT1R46S5QH3FUZz9NxbAfqJpo9w9lXW90xq1KjfCZMbTDuA?=
 =?us-ascii?Q?uvL+62E/UpsV+tF5Y9vv77oJ3xzNfXJ7IquHD7CDB1sSK2xE4XOzJwIxUJPr?=
 =?us-ascii?Q?Q6T4IGMMJHEz2uz9vCR2EbjlsKXnyNQWhgXtbUItHRlfuWGCFgFaJoymc94D?=
 =?us-ascii?Q?+pj1jo11Edmv0Bh9tqKbKJH1Eaen9jmNyNe7QdQHBZUekF5L8VnNWhLBh/Fy?=
 =?us-ascii?Q?tJvXNpaoXKbtbfQ7gL2FABo0GwMcc5JJYi5Hz10WAK99Ovhm7/cVZebFwnSf?=
 =?us-ascii?Q?KfuNOiyOqvFcFA7St64e21diud3/5Lmxf5er/8OQQmR8iIPcS7cWcRWBDCUx?=
 =?us-ascii?Q?ne/eK0twQLFI/TxS4MppA8JNKrvH/mNSpViMco6HKD0EtQVIrwtWj7EZHDog?=
 =?us-ascii?Q?DxHaH+byHN2JKshfU5YU/Q8NoGlhJGCIlJAw2HEl6iETUAaVHupxU+mrPPyF?=
 =?us-ascii?Q?Dv0D/ZIJDGfT7waF7fgjOsE30pedB2HjEfhHSR3+HQP2kyHsSIIvNfAEMXpy?=
 =?us-ascii?Q?YFoDkjgjSKY7g2qQAOqVxgRgYoQYIU2A6zdUEn21PM7Ik/PWJSLLpoRuUry+?=
 =?us-ascii?Q?rNGxzBVscfIRPRcou4+XqohF2AmH7pz+XNw3vYHm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac43558c-56ac-4bcc-9c81-08daa2815093
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 01:15:51.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQvydRpvjtuUBm4c2R6iexdbzVAELXH0eG+wDbE8dXcWLhGkC/2581kmDIg9Aczgy5oP+PDqLUlGr0krGg/47A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:05:24AM +0800, Xiongfeng Wang wrote:
> 
> 
> On 2022/9/30 8:38, Feng Tang wrote:
> > On Thu, Sep 29, 2022 at 11:52:28PM +0800, Yu Liao wrote:
> >> On 2020/12/2 15:28, Zhang Rui wrote:
> >>> On Mon, 2020-11-30 at 20:21 +0100, Thomas Gleixner wrote:
> >>>> Feng,
> >>>>
> >>>> On Fri, Nov 27 2020 at 14:11, Feng Tang wrote:
> >>>>> On Fri, Nov 27, 2020 at 12:27:34AM +0100, Thomas Gleixner wrote:
> >>>>>> On Thu, Nov 26 2020 at 09:24, Feng Tang wrote:
> >>>>>> Yes, that can happen. But OTOH, we should start to think about
> >>>>>> the
> >>>>>> requirements for using the TSC watchdog.
> >>>
> >>> My original proposal is to disable jiffies and refined-jiffies as the
> >>> clocksource watchdog, because they are not reliable and it's better to
> >>> use clocksource that has a hardware counter as watchdog, like the patch
> >>> below, which I didn't sent out for upstream.
> >>>
> >>> >From cf9ce0ecab8851a3745edcad92e072022af3dbd9 Mon Sep 17 00:00:00 2001
> >>> From: Zhang Rui <rui.zhang@intel.com>
> >>> Date: Fri, 19 Jun 2020 22:03:23 +0800
> >>> Subject: [RFC PATCH] time/clocksource: do not use refined-jiffies as watchdog
> >>>
> >>> On IA platforms, if HPET is disabled, either via x86 early-quirks, or
> >>> via kernel commandline, refined-jiffies will be used as clocksource
> >>> watchdog in early boot phase, before acpi_pm timer registered.
> >>>
> >>> This is not a problem if jiffies are accurate.
> >>> But in some cases, for example, when serial console is enabled, it may
> >>> take several milliseconds to write to the console, with irq disabled,
> >>> frequently. Thus many ticks may become longer than it should be.
> >>>
> >>> Using refined-jiffies as watchdog in this case breaks the system because
> >>> a) duration calculated by refined-jiffies watchdog is always consistent
> >>>    with the watchdog timeout issued using add_timer(), say, around 500ms.
> >>> b) duration calculated by the running clocksource, usually TSC on IA
> >>>    platforms, reflects the real time cost, which may be much larger.
> >>> This results in the running clocksource being disabled erroneously.
> >>>
> >>> This is reproduced on ICL because HPET is disabled in x86 early-quirks,
> >>> and also reproduced on a KBL and a WHL platform when HPET is disabled
> >>> via command line.
> >>>
> >>> BTW, commit fd329f276eca
> >>> ("x86/mtrr: Skip cache flushes on CPUs with cache self-snooping") is
> >>> another example that refined-jiffies causes the same problem when ticks
> >>> become slow for some other reason.
> >>
> >> Hi, Zhang Rui, we have met the same problem as you mentioned above. I have
> >> tested the following modification. It can solve the problem. Do you have plan
> >> to push it to upstream ?
> > 
> > Hi Liao Yu,
> > 
> > Could you provoide more details? Like, what ARCH is the platform (x86
> > or others), client or sever, if sever, how many sockets (2S/4S/8S)?
> > 
> > The error kernel log will also be helpful.
> 
> Hi, Feng Tang,
> 
> It's a X86 Sever. lscpu print the following information:
> 
> Architecture:                    x86_64
> CPU op-mode(s):                  32-bit, 64-bit
> Byte Order:                      Little Endian
> Address sizes:                   46 bits physical, 48 bits virtual
> CPU(s):                          224
> On-line CPU(s) list:             0-223
> Thread(s) per core:              2
> Core(s) per socket:              28
> Socket(s):                       4
> NUMA node(s):                    4
> Vendor ID:                       GenuineIntel
> CPU family:                      6
> Model:                           85
> Model name:                      Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz
> Stepping:                        4
> CPU MHz:                         3199.379
> CPU max MHz:                     3800.0000
> CPU min MHz:                     1000.0000
> BogoMIPS:                        5000.00
> Virtualization:                  VT-x
> L1d cache:                       3.5 MiB
> L1i cache:                       3.5 MiB
> L2 cache:                        112 MiB
> L3 cache:                        154 MiB
> NUMA node0 CPU(s):               0-27,112-139
> NUMA node1 CPU(s):               28-55,140-167
> NUMA node2 CPU(s):               56-83,168-195
> NUMA node3 CPU(s):               84-111,196-223
> 
> Part of the kernel log is as follows.
> 
> [    1.144402] smp: Brought up 4 nodes, 224 CPUs
> [    1.144402] smpboot: Max logical packages: 4
> [    1.144402] smpboot: Total of 224 processors activated (1121097.93 BogoMIPS)
> [    1.520003] clocksource: timekeeping watchdog on CPU2: Marking clocksource
> 'tsc-early' as unstable because the skew is too large:
> [    1.520010] clocksource:                       'refined-jiffies' wd_now:
> fffb7210 wd_last: fffb7018 mask: ffffffff
> [    1.520013] clocksource:                       'tsc-early' cs_now:
> 6606717afddd0 cs_last: 66065eff88ad4 mask: ffffffffffffffff
> [    1.520015] tsc: Marking TSC unstable due to clocksource watchdog
> [    5.164635] node 0 initialised, 98233092 pages in 4013ms
> [    5.209294] node 3 initialised, 98923232 pages in 4057ms
> [    5.220001] node 2 initialised, 99054870 pages in 4068ms
> [    5.222282] node 1 initialised, 99054870 pages in 4070ms

Thanks Xiaofeng for the info.

Could you try the below patch? It is kinda extension of 

b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC on qualified platorms") 

which I have run limited test on some 4 sockets Haswell and Cascadelake
AP x86 servers.


Thanks,
Feng
---
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..b4ea79cb1d1a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    nr_online_nodes <= 2)
+	    nr_online_nodes <= 8)
 		tsc_disable_clocksource_watchdog();
 }
 

