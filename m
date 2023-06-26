Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E691C73D8DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFZHvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFZHvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:51:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DB4128
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687765904; x=1719301904;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CevVugZWyLM2yKe1xRiTE42MTeJD9rkcmF3hfxiyumE=;
  b=U50AgdlqT1NlHMdAQW0anvbXlqBqbOx4HeuQZ0GQ/p3D+wzwwnsxwcdU
   lPxQ08CtM5br0wfPDArDXxiehUaHM5FwYnYNt/z78ofmD0EVe9w7yA/S8
   8gPhmRkU7th1xE2+MBIb0z6ImRSP4swCmucSG3DuNwMx6JrDvasrzgsnD
   HWyRkeHZ5gd+8XeG34lVw2uNgu8Dbj9zx0WvMFVR+SxMlJeHrcZGYqano
   qz/LmguqzvIrKHgXwkZpVhF3uglczih2+seJAEK/yVmGz9u0CkDtbCLJG
   Y+JjSExpQBB88sRiZq6/rtgelMMmeTw+SDxBU6xaxlrNMxkaykLhj/Zrb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="427198216"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="427198216"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 00:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="1046399544"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="1046399544"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2023 00:51:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 00:51:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 00:51:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 00:51:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 00:51:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlH5ytabDeiX+jGd7ij/jEVTKqQYiW9o0SDLEvuSVg03kiHkcZzHvspzobYVPAoHH4tEBIGSHUfk/SZd1mSqwFmANJOfAXK3Sf3jDSgQuBqTTMdHYV6UNt+V/h2Bmp4rXnABBzOzapC3FnMwToVdp/IecU2vp/p4h+4YnqXTEB8yXu3WV82e2PXZX+wkEB8HMXVGTekeC1zPmJomPy8oX1s6jJeSDo20Ct4iT/IXuTG6dO1dKF6OAP/JEsBnvGsCzlBonWahp3jenJet8yo9yCtS6ImmvSe2+3gzQNgHDH/LGoeiVMkkmlgCugFcfjeBteLCWYFkxsnEEyCc9fPgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tusn25xz7MiKAZ/wOxkIUQqU6bgbZS0hwrq0wFDm7Kw=;
 b=OGz0qrbPEDAtppn6Uobb5lQVrqGZu69faEqvbsoWTgvDYxLUed7aJKpHqkgsIP8E6KDj34BIngnkJFtMuE8MLl34fYYewjgtJ3p3sFoWqQb0GiSnHHLAvgriGB6Snc0RA7ApAPsUF1/x8jUwyyZM2zJuLq+mUkD1nTRzh1iZPvtQ+afD+j7MDPVKSQNdxDWDzqiv31Pk2Zyc29ekD8n85cv80CCnqFxSbDW1McdMBOhquobLCTUZL8hc330OHaLK6y4BgqA8ps9vxkFxcWKmzG74SOpx1S7ewEhqkUK0U/A9Bb0+4+1Vezu/gc1SsFwCIgfAgrvvKlMNLQC9qW+70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH0PR11MB5048.namprd11.prod.outlook.com (2603:10b6:510:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 07:51:38 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 07:51:37 +0000
Date:   Mon, 26 Jun 2023 15:48:34 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>
Subject: include/linux/compiler_types.h:82:5: sparse: sparse: undefined
 preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
Message-ID: <202306220043.IHVrU1h8-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH0PR11MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: f94843cf-905e-4423-042e-08db761a2bb5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdAZh99Xni87s9u73d9dLiCPA24TyGVkbZQduBqdbqcDC9dk5o+pcMsqLS8c8h/+23sFvfbhUbtjGata/Orcz9AxtksRSD5tqDtpmkbAr7+Ub7wBz6LUWKH8RBGLUCMBiaAvIaA1maQe5twJBN2y3g5JJT38PtfVsTvjWI5DYaQYKMBrmvMGfL2wJWEIXtTSbe7nfpOGLOWJdkZYCo8vWlen7difSmKMFtc4CsFeZohbooU3zYycBBxl3FzeFBkAfZI2BC1tFeTMjLByjMiN6XGpr8htIkljzGzyXAb7uudXgPq8Voz7LQHEX2Qxwykt9aWQvjJ3a7ya9L4eQp/nW1FEYk03QvUczM8PT03cPLslU4VnDHZelenUZ2jb9vxjjZuwd6ZkPULzvJAJYLdOOqKNH0gdYvtzQvxjleqFCPrGeU5+5u2gAqhM2BjJNnUntDsuCjZCdgxMH1K+HgNFcYok5WfSkwGpV+y1CXHLBLj6UWdBhzCZh0k1M/o8n8qppeAsS0SHP6mmXS72Wp6FGzRyus7FScKpv4VrQ9ARGyI6hsG75FNGxIr7U8kcISLply1MlceOzUgPFNbiSGqPFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(8676002)(8936002)(66476007)(66556008)(66946007)(41300700001)(316002)(6916009)(4326008)(6506007)(6512007)(1076003)(26005)(186003)(2616005)(478600001)(6666004)(966005)(6486002)(2906002)(5660300002)(30864003)(82960400001)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0vJVP7T/1s7L7Q2qBe2l+NZ+WgduASCMP1p7Vjsh0ReoosDHpXGN1C7bmwVz?=
 =?us-ascii?Q?0klRa1567YuKwUOkxzFMKPLqVav9kyiv0G+YcJjCnbBxtnOeVWk3YLvlUkOU?=
 =?us-ascii?Q?6gweL5wFsBH5s+Q46YHglGPASyCUkAPdfmASlVjJdog+X05FxB3pbxx1zoVy?=
 =?us-ascii?Q?Ly2fPH2OJfwZRzZncKMt8MQrSuXYNOf7JwwjVfb3RyMJpPYrbz5wOcCjs8OY?=
 =?us-ascii?Q?jHqLVnrXCHoetBEu4iQ/s7rU54ixo0vr6CNTG08OxB6jIg8t1HExPASDJFCF?=
 =?us-ascii?Q?+1f2FDeAdtxFzOzuF+cHr6da2KQ+nJu0gC+HbNpSZdhXJdj96JxXHBd08dhC?=
 =?us-ascii?Q?HbdBSLP/lvLbUrAE6QItgQA6tRCtchXA2bM5iMe9xyr/V5KBmgW1IcURW5b2?=
 =?us-ascii?Q?o9TAlLKCTVoqvnNqe/zjUcoSkk8zOylvxfscrUqLkTzh4hQCFMkBwEJvnoSV?=
 =?us-ascii?Q?TmYuXanu89Gec0xIF7+3TEcoBuf24kD/6AdwI1uKNWdZWg//ByjSUzXtEyqP?=
 =?us-ascii?Q?ViOM0Yce0pZdr0hYpg4rFdaM0dZn51+uSsKgTPn+76lC8BVjqdCcTckGwTvi?=
 =?us-ascii?Q?1JSklIB5lsA2/IRLXqQapWMM6xCbFCBkUCxGixjQ3hTb1mVnaJxnhoxx57aR?=
 =?us-ascii?Q?U6/5hcJNn4YV8iH+o7xy1ld/CRYDMKrMSN+7j91KucbnUaSL9K9NR9p3JGT3?=
 =?us-ascii?Q?WLU4NUlM2XEIUSHGGl6ih4CdQktLHjpTCWaMYpQCrbmn/48yuh59yn6oplDW?=
 =?us-ascii?Q?HZXdg09vYeN0YZ/pfYENee78nm4BJM8ZOPufNKfmBRWjG7/6nlw5h3ahhlH1?=
 =?us-ascii?Q?rnFOyurKiK2AlD7WPKM8HDvLVDzMiMkZv7KLFXrGJO2oJbE6Wnne/CGuR4qX?=
 =?us-ascii?Q?nx9MiJVKEOF3xEb5FqtXg0pAXXZKyJ4fEZGLWqij6kmi+lfX5K6h0Q33W0jj?=
 =?us-ascii?Q?UE8op2azkuE+kjApcLhNrYmhTYgLgaqqEta0L4jVRBW48Q8Z7NL2GVPmHd/y?=
 =?us-ascii?Q?3z4xzHLQT3eH27w19vjU9gCzz2UyERez567zRHEV0/M1w3mIYpqXWVyWNK/o?=
 =?us-ascii?Q?7/zNBO0tHpSR+vUEFWJ1ylhinWIBr1sOQCECJDLn++ieYLCEyX1IiyPRIy26?=
 =?us-ascii?Q?JH2akB6WDFdBQ5yu4P/6xPQWLhflULmZXSQvCpX9nP4Ll7X+G+Tex0khiENp?=
 =?us-ascii?Q?kM7YFGdce3umZBCFQj3ORqdToMUkFKivSIO61IVY+q8gDJh+amfJa5f2breR?=
 =?us-ascii?Q?hkXKJg4P6IjVq2mn2wQF5XwA/w7DifjDiejf2vNAjwHW6f8cfOSi5FZOeASx?=
 =?us-ascii?Q?O9lVtIcnqWEQLEIKbyhCnyT0HXCGyKaOPdzrItvSrYKkErYuyH6uOyboVqv6?=
 =?us-ascii?Q?p4Y9fAIsRjBrqmioi9Z1HD1VcwyyV6w0827topv5aYMRJLrt/rEKfO6lJyM5?=
 =?us-ascii?Q?3HlTXWatQaWI+EuRT6N+b4ndfGiA1U8lEb9S25ycELqhZwtjikcRM20uXaqj?=
 =?us-ascii?Q?/p2jRP7KTuNuI4R2M0SL3YXt4RJOXPxmwbx7+ggFB9P/qIdVMkhM8USoi1q+?=
 =?us-ascii?Q?hf2+SIOet5cj0un07LbJZR9+QXauGivv32ZDZyS/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f94843cf-905e-4423-042e-08db761a2bb5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 07:51:37.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2V0RQ87JGX4ngTBWJM/kYgs/ssDHAunhRC+MPKardnp1bi44SwlROS65OqQ+v/JfWiXdN2qXzR8gyI9JgfC2+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5048
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e660abd551f1172e428b4e4003de887176a8a1fd
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   5 months ago
config: um-randconfig-s053-20230621 (https://download.01.org/0day-ci/archive/20230622/202306220043.IHVrU1h8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230622/202306220043.IHVrU1h8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202306220043.IHVrU1h8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/um/kernel/config.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/kernel/config.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/kernel/config.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/drivers/fd.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h, arch/um/drivers/chan_user.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/drivers/fd.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/drivers/fd.c: note: in included file (through arch/um/include/shared/init.h, arch/um/drivers/chan_user.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/drivers/chan_user.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h, arch/um/drivers/chan_user.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/drivers/chan_user.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/drivers/chan_user.c: note: in included file (through arch/um/include/shared/init.h, arch/um/drivers/chan_user.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/drivers/port_user.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h, arch/um/drivers/chan_user.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/drivers/port_user.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/drivers/port_user.c: note: in included file (through arch/um/include/shared/init.h, arch/um/drivers/chan_user.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
   arch/um/drivers/port_user.c:179:32: sparse: sparse: Using plain integer as NULL pointer
--
   arch/um/os-Linux/main.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/main.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/os-Linux/main.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
   arch/um/os-Linux/main.c:187:6: sparse: sparse: symbol '__wrap_malloc' was not declared. Should it be static?
   arch/um/os-Linux/main.c:208:6: sparse: sparse: symbol '__wrap_calloc' was not declared. Should it be static?
   arch/um/os-Linux/main.c:222:6: sparse: sparse: symbol '__wrap_free' was not declared. Should it be static?
--
   arch/um/os-Linux/mem.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/mem.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/os-Linux/mem.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/process.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/process.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/os-Linux/process.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/sigio.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/sigio.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/os-Linux/sigio.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/start_up.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/start_up.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/os-Linux/start_up.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/umid.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/umid.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/os-Linux/umid.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/util.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/util.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/os-Linux/util.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
   arch/um/os-Linux/util.c:93:48: sparse: sparse: Using plain integer as NULL pointer
--
   arch/um/os-Linux/skas/mem.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/skas/mem.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/os-Linux/skas/mem.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/skas/process.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/skas/process.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:424:10: sparse: this was the original definition
   arch/um/os-Linux/skas/process.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
   arch/um/os-Linux/skas/process.c:300:5: sparse: sparse: symbol 'kill_userspace_mm' was not declared. Should it be static?

vim +/CONFIG_FUNCTION_ALIGNMENT +82 include/linux/compiler_types.h

a3f8a30f3f0079 Miguel Ojeda 2018-08-30  81  
c27cd083cfb9d3 Mark Rutland 2023-01-23 @82  #if CONFIG_FUNCTION_ALIGNMENT > 0
c27cd083cfb9d3 Mark Rutland 2023-01-23  83  #define __function_aligned		__aligned(CONFIG_FUNCTION_ALIGNMENT)
c27cd083cfb9d3 Mark Rutland 2023-01-23  84  #else
c27cd083cfb9d3 Mark Rutland 2023-01-23  85  #define __function_aligned
c27cd083cfb9d3 Mark Rutland 2023-01-23  86  #endif
c27cd083cfb9d3 Mark Rutland 2023-01-23  87  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

