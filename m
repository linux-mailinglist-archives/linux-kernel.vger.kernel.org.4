Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2573B60F46A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiJ0KE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbiJ0KEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:04:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A40922B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666865051; x=1698401051;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iNtpiGF0MGSpH+tfovfdvZyEIL8n9q/DcbhpA4DIrnY=;
  b=akUcWKuMydvxAzuv87QJAQOLBXhuJdoMAQpMHlVZGNDTFfErpMo3/ewB
   QBtAQkNDyuaAvGt1wzAOMUHUL6aBHyGNAVYRt1O74tqbyEgjqANBoMxml
   nctQiiAmWRGghRX6QKswWN894f9akYuNCYEaExhfCQvX3qbiCMmDdBGhz
   ptxs92DUoluODW7L8t39BYl5Hl2GmeqaXfLlNMO/3binFO2fVkccMR6LU
   6AUVjpWwOOX7udjPgZjYk2rBMjraAtSVFA+TUvEfknJNC/metKWfKnF6I
   Rn1EB+I9XvkUm7mHlxKiUtffHDXnaPLaJrW+TKNHonJ0YS6sUi4wx6E4E
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="288579448"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="288579448"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 03:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="663562857"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="663562857"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 27 Oct 2022 03:04:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 03:04:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 03:04:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 03:04:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 03:04:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIJa5Z3TFEbuMlImSR+4zGEnf0MqyxHsuJtWSLmwbq55ny5TOUFi59xrKTiTdmHwWSAcz62qnOz79IEtQET74OR1yRSGMt2ATRD3GEAQC4cZp7rPizCXHxoOWf7K5svaIiiQ1kzTD4Ie0J0o4RLZeqs7YAtdxkozbSRzVGwKPf17Faqltatn3l+vhjCsIxZNSZyyuGGm2u2NojUfisCNy/HeZVSrhEJi2dDWsxpEOIsmMjY5fxgOjCm1kVJG0DNOb6R56paK+vDm5emjcjoWiJyu0z14wgK3L4etqLHqlz7xHtTJ7Qf4VvwIsy6XcBhzmp3SZVdacY0wx0zDThvn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmmG3LlZt9Bfk1gOZYT1EYwejvTjImwQO0jE3pP3fKo=;
 b=nu6f5ALjKIvTsT0sFseX6iDvfz2KtrY/swdTQDveWYwgdIW4VXY4AjM2JcUudNC+qKtPJ8KStaNNjme1E7pisXP3Y5SeBy5q9c8UBjwE7snJnv4KblzRjcXugNN64RjL3PdApzMwlNyrVPNC6IczrrRi/uoQS1IHPbQn0F8LBmyCLo+FnE4IXNCvvQudRQ0DHxEKeL5krdwSF/xFk28kfqxjKBEJgonpSGXDiX+I8Sb7ufmGXh1QcEtqyiRmoJUWWzZkwDotOCjDnMNkZD7AcXmm7Tb0pJ7OaMp/jFZLCPjWo+Q2mtbIGdcxCPZgAECqTNIxiuLvMoEXLqiS2hJhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 10:04:03 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d%9]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 10:04:03 +0000
Date:   Thu, 27 Oct 2022 18:02:14 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Seth Jenkins <sethjenkins@google.com>,
        "Kees Cook" <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        <kasan-dev@googlegroups.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [tip:x86/mm] [x86/mm] 1248fb6a82:
 Kernel_panic-not_syncing:kasan_populate_pmd:Failed_to_allocate_page
Message-ID: <Y1pXJheAg+sMj7eG@yujie-X299>
References: <202210241508.2e203c3d-yujie.liu@intel.com>
 <Y1e7kgKweck6S954@hirez.programming.kicks-ass.net>
 <278cc353-6289-19e8-f7a9-0acd70bc8e11@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <278cc353-6289-19e8-f7a9-0acd70bc8e11@gmail.com>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS0PR11MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: e18feab4-04cb-49ee-10c8-08dab80293d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4jDevK8h2g1RUY4iFByAmuZWXtwPTsoXjcyjuE6hNe/1GnKm4hQJ1YCDFKZGMHeCGJZx3o07AXoKCPHdHNjLvhFxpXWsBFdpe4XVCZYyaTahOulQ/ugDpAEcxbZSqaI4bpNaAu6SlBn+/unU87he5GL6ZX+mO2zxw4RpUN8vyyeJZL5WlMue6DB7OeiD4kSW6ptBr/M19kJaIZBryb/gjHiP0A2ry2s+LIPm/DL/WPAXHPrmUCKAbXSHKVwwL+TeCNsPYmaAdZpG40iGYQ0S6ZmExvm+yAZDDNOrc8dMOTwcR+ILPDwPt/DwktC1OQ5BWrAMSHBaegNIO3wuTqp7WAYUj2NmIydF37k2jWoeqtKIQziXsrJrzNFrTT4ks7difajGzzmMPXGFprEKPN/b8/UhZUvjwSwnssFS1MjQVYALS94XB83DfFwYhMeSM+RvCkEaTqzU0f6GWCv2g+xNWAyBXErTYn066MukNDAqNSgE657iaUHWJeBCYV/mVw8PzWfOE6V35yyhSjHOXnReGzwS5JmifqJY78szg0T5KmBqSfgO4QDJ41bJ7N3amwVxBBZh4qi7bM0KbKk3uwcOoC+9a0jmbsBdbqlJiYh6hHrSP1SBvOSPcZHl8LwWO5KiDngYP6stEaFg+IYWpb4nHDkGApdOTa40BRm/PzOwQBiiKOZopLE+wf33kbLEyymw2VIo7deuuPXdqiE2EF9nXJAFjQmUy9cV4rUe/pkmH2zOzUNGJ5IYTpOD356K4RN1+Bk+l/OFxzXs7u9lSeiOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199015)(8936002)(26005)(5660300002)(6512007)(7416002)(54906003)(8676002)(66556008)(53546011)(110136005)(66946007)(4326008)(9686003)(41300700001)(6506007)(6666004)(66476007)(82960400001)(33716001)(316002)(38100700002)(186003)(44832011)(2906002)(83380400001)(86362001)(966005)(6486002)(478600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBwwx6AgvlMCIbyMdhZRka9H1FzUnkq8S0ZvPxHI9qU9MfgyK2tLgW6tJReq?=
 =?us-ascii?Q?DGeEQDIJaBjgTxlpTWjecEsvAi4j6GaDHTP7YOjPzsbn5Ilk9WHHxjLFCekX?=
 =?us-ascii?Q?4d6a72WbBf8+gnFTe/Uch/bw9r4eKDX6eC0YDnLYzRXU1c0hoKhRQJGLH35X?=
 =?us-ascii?Q?AiPMwIQDcc6UASgDOokzPCUKTch2D8dE17xfncXlKPdUivuuLVz2gZ3miHGr?=
 =?us-ascii?Q?2eEf+gpq+3gSCe1MS7wSQEe6VpAuF91ZWpAaF7/hzvBMA9HOF/t/rpXoNwSO?=
 =?us-ascii?Q?FcLfqSvyqbN/opN0r9NphWirHwEaXNMqTy60eHyKRMViA2tQTpsTQW/Lvv1m?=
 =?us-ascii?Q?iVfZ5IpJlFoNCv2ow3nmjqefHIj5si4TrQPG5q5dJxj67e/9Xe5e45xJ/4DR?=
 =?us-ascii?Q?FFFFLX9pPwdKpw7/9zR8QEeJ1t3Y/PkuzW/2C+9CZLoNQ7OAYDsCoDKY+lGA?=
 =?us-ascii?Q?sk3R+Ca+joMtHJHeP5Nzo6j40G20FrBNADq3Tfern/+y9NAXOsqb6ifAJ95m?=
 =?us-ascii?Q?jnGga6TPbDN1phrDIZznF1BHuHipMqPRkgNsE14q+RmZPqPzxCkv8h60RYrR?=
 =?us-ascii?Q?TAZtfMwqVeTOcEsckp5VlsJwENCC8BIURbVcDY6Hltd2suRumDbjDTSQihQ5?=
 =?us-ascii?Q?T32oW8Vd0C9cUy6v13g1ud7PWHlpTkRWoH4sFvcRt27OxXZJsi/ugBSqFlO0?=
 =?us-ascii?Q?c/7abtRXQh120093fQOIdfUE/eCN3yhZ/T8BL/snAkMvGwWd14SU5QJfs1d4?=
 =?us-ascii?Q?tD5W5n6TtjtPzTz1mVUuSIaK2JePECc8F+FDyQaJQiPaSsf3sdTJIdjkT9he?=
 =?us-ascii?Q?j5MITNMdc96M3C8Tpi4ssr5rq6/OvVGwu3q6paN1tjcn3NfGZah82qWllbdi?=
 =?us-ascii?Q?iKelrf2T11qwyRT+2S8a0KNjjWViunEY9cDOF4XRY8BmqKAy5dEp3m3SOxX7?=
 =?us-ascii?Q?ZYjpjMJnywJOEGOs9a6zxfPt2yveUJTvBIrk2BIHE/sK0gHGod8/V6yxygj/?=
 =?us-ascii?Q?CsEmqwRU6j6qfRQJQduSLdvmOOzWnyVXMIvkAyS+Jo3KnnS7I9AsJCFPTWcx?=
 =?us-ascii?Q?NQl75dz/Pb381JFVHtL8vnsy6Lk5pWdguSmljxSWwBz0dR3ukr8nZPVjQ/aI?=
 =?us-ascii?Q?CeARffdi/QJl3Fa6BoHTFHPhnOJ5zq/5HVRZmZI7uwyYgCw1mSLwCDfU1Hhu?=
 =?us-ascii?Q?QGtqGCYCuHNz2RfrDmhFf9vqIS6PM6PP6y7jqVPaMKg69j2NZ3hAPUnaCiRO?=
 =?us-ascii?Q?ZDLICoufCtjatRfPBuQMcr3pThMu1713GNb/cDY7ROfM425XpLN3HXZOVCuS?=
 =?us-ascii?Q?BLiuYHXCOTPF2gzNflfuAY+IzKf5G11sF51P9g5DimbVT8JRPhzYx4Bh4NYo?=
 =?us-ascii?Q?SmAuOfxqHJzZ/v9HdtUJlpDje4AfnIVh3wbQyauWIjYtBYu37KAygkD56SJ6?=
 =?us-ascii?Q?bJ2yyb13Ulcq9I2HYCI1pPvzyWP9HQpDRivO7Y1chdv1vfb7RO+VfwWTV6qw?=
 =?us-ascii?Q?l6RZSt8ASXYonTkkM5Fn0zXG9UzJLDqhhCpx/wFkcPA6BLPefGQBp+fnwRpu?=
 =?us-ascii?Q?pwv12PcPDJ1BwPGLZJJXp3tSE0zeCcNWoVKydauD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e18feab4-04cb-49ee-10c8-08dab80293d3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 10:04:03.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ce31q1RmvNgcldkvulTPMLn/5wr6gc0j105cw8NuWGbsbY7bygelQ7LA27Qr4GZIYzPUi4n8uQ67EIUxzGS+qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 06:39:07PM +0300, Andrey Ryabinin wrote:
> 
> 
> On 10/25/22 13:33, Peter Zijlstra wrote:
> > On Tue, Oct 25, 2022 at 12:54:40PM +0800, kernel test robot wrote:
> >> Hi Peter,
> >>
> >> We noticed that below commit changed the value of
> >> CPU_ENTRY_AREA_MAP_SIZE. Seems KASAN uses this value to allocate memory,
> >> and failed during initialization after this change, so we send this
> >> mail and Cc KASAN folks. Please kindly check below report for more
> >> details. Thanks.
> >>
> >>
> >> Greeting,
> >>
> >> FYI, we noticed Kernel_panic-not_syncing:kasan_populate_pmd:Failed_to_allocate_page due to commit (built with gcc-11):
> >>
> >> commit: 1248fb6a8201ddac1c86a202f05a0a1765efbfce ("x86/mm: Randomize per-cpu entry area")
> >> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm
> >>
> >> in testcase: boot
> >>
> >> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >>
> >> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >>
> >>
> >> [    7.114808][    T0] Kernel panic - not syncing: kasan_populate_pmd+0x142/0x1d2: Failed to allocate page, nid=0 from=1000000
> >> [    7.119742][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-00001-g1248fb6a8201 #1
> >> [    7.122122][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> >> [    7.124976][    T0] Call Trace:
> >> [    7.125849][    T0]  <TASK>
> >> [    7.126642][    T0]  ? dump_stack_lvl+0x45/0x5d
> >> [    7.127908][    T0]  ? panic+0x21e/0x46a
> >> [    7.129009][    T0]  ? panic_print_sys_info+0x77/0x77
> >> [    7.130618][    T0]  ? memblock_alloc_try_nid_raw+0x106/0x106
> >> [    7.132224][    T0]  ? memblock_alloc_try_nid+0xd9/0x118
> >> [    7.133717][    T0]  ? memblock_alloc_try_nid_raw+0x106/0x106
> >> [    7.135252][    T0]  ? kasan_populate_pmd+0x142/0x1d2
> >> [    7.136655][    T0]  ? early_alloc+0x95/0x9d
> >> [    7.137738][    T0]  ? kasan_populate_pmd+0x142/0x1d2
> >> [    7.138936][    T0]  ? kasan_populate_pud+0x182/0x19f
> >> [    7.140335][    T0]  ? kasan_populate_shadow+0x1e0/0x233
> >> [    7.141759][    T0]  ? kasan_init+0x3be/0x57f
> >> [    7.142942][    T0]  ? setup_arch+0x101d/0x11f0
> >> [    7.144229][    T0]  ? start_kernel+0x6f/0x3d0
> >> [    7.145449][    T0]  ? secondary_startup_64_no_verify+0xe0/0xeb
> >> [    7.147051][    T0]  </TASK>
> >> [    7.147868][    T0] ---[ end Kernel panic - not syncing: kasan_populate_pmd+0x142/0x1d2: Failed to allocate page, nid=0 from=1000000 ]---
> > 
> > Ufff, no idea about what KASAN wants here; Andrey, you have clue?
> > 
> > Are you trying to allocate backing space for .5T of vspace and failing
> > that because the kvm thing doesn't have enough memory?
> > 
> 
> KASAN tries to allocate shadow memory for the whole cpu entry area.
> The size is CPU_ENTRY_AREA_MAP_SIZE/8 and this is obviously fails after your patch.
> The fix this might be something like this:

Hi Andrey,

Thanks for posting the fix. The issue is resolved after applying the fix.

  Tested-by: Yujie Liu <yujie.liu@intel.com>

=========================================================================================
compiler/kconfig/rootfs/sleep/tbox_group/testcase:
  gcc-11/x86_64-rhel-8.3-kselftests/yocto-i386-minimal-20190520.cgz/1/vm-snb/boot

commit:
  v6.1-rc1
  1248fb6a8201d ("x86/mm: Randomize per-cpu entry area")
  5e25ad77cfd4a ("Fix "KASAN allocate shadow memory for cpu entry area"")

        v6.1-rc1 1248fb6a8201ddac1c86a202f05 5e25ad77cfd4a0e089a1f370fbf
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :12          100%         10:10           0%            :8     dmesg.Kernel_panic-not_syncing:kasan_populate_pmd:Failed_to_allocate_page,nid=#from=
           :12          100%         10:10           0%            :8     dmesg.boot_failures


Best Regards,
Yujie

> 
> 
> ---
>  arch/x86/include/asm/kasan.h |  2 ++
>  arch/x86/mm/cpu_entry_area.c |  3 +++
>  arch/x86/mm/kasan_init_64.c  | 16 +++++++++++++---
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
> index 13e70da38bed..77dd8b57f1e2 100644
> --- a/arch/x86/include/asm/kasan.h
> +++ b/arch/x86/include/asm/kasan.h
> @@ -28,9 +28,11 @@
>  #ifdef CONFIG_KASAN
>  void __init kasan_early_init(void);
>  void __init kasan_init(void);
> +void __init kasan_populate_shadow_for_vaddr(void *va, size_t size);
>  #else
>  static inline void kasan_early_init(void) { }
>  static inline void kasan_init(void) { }
> +static inline void kasan_populate_shadow_for_vaddr(void *va, size_t size) { }
>  #endif
>  
>  #endif
> diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
> index ad1f750517a1..602daa550543 100644
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -9,6 +9,7 @@
>  #include <asm/cpu_entry_area.h>
>  #include <asm/fixmap.h>
>  #include <asm/desc.h>
> +#include <asm/kasan.h>
>  
>  static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage);
>  
> @@ -91,6 +92,8 @@ void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
>  static void __init
>  cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
>  {
> +	kasan_populate_shadow_for_vaddr(cea_vaddr, pages*PAGE_SIZE);
> +
>  	for ( ; pages; pages--, cea_vaddr+= PAGE_SIZE, ptr += PAGE_SIZE)
>  		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
>  }
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index e7b9b464a82f..dbee52f14700 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -316,6 +316,19 @@ void __init kasan_early_init(void)
>  	kasan_map_early_shadow(init_top_pgt);
>  }
>  
> +void __init kasan_populate_shadow_for_vaddr(void *va, size_t size)
> +{
> +	unsigned long shadow_start, shadow_end;
> +
> +	shadow_start = (unsigned long)kasan_mem_to_shadow(va);
> +	shadow_start = round_down(shadow_start, PAGE_SIZE);
> +	shadow_end = (unsigned long)kasan_mem_to_shadow(va + size);
> +	shadow_end = round_up(shadow_end, PAGE_SIZE);
> +
> +	kasan_populate_shadow(shadow_start, shadow_end,
> +			      early_pfn_to_nid(__pa(va)));
> +}
> +
>  void __init kasan_init(void)
>  {
>  	int i;
> @@ -393,9 +406,6 @@ void __init kasan_init(void)
>  		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
>  		shadow_cpu_entry_begin);
>  
> -	kasan_populate_shadow((unsigned long)shadow_cpu_entry_begin,
> -			      (unsigned long)shadow_cpu_entry_end, 0);
> -
>  	kasan_populate_early_shadow(shadow_cpu_entry_end,
>  			kasan_mem_to_shadow((void *)__START_KERNEL_map));
>  
> -- 
> 2.37.4
> 
