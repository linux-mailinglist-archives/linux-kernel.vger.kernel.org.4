Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EBB70B497
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjEVFe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjEVFez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:34:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F6A8;
        Sun, 21 May 2023 22:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684733690; x=1716269690;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=AKTMQONN9xDZ/gDu/t+gegdQqDiglJVwvGbsYR8YWlk=;
  b=Z+h4IYHOrfHRSoEEgGi4IYCAsdD/IWHazsWO2+bSzlu2xUW+qAo+e+jt
   kFz1Nu24RUaZGqSGj8s23pp/AnzHGxw6A371Vch8lVGAInQiD3x5i57x2
   DqUvDV3YwR2XTYZvvswhPEWyH3SzRI7yBPr+MKZFmlnq2vmTHY1W/RaAm
   8ljpnBIHXr+KN4DbYMvSsqPgs1h0QUJrwZatPgOD9wT5AhUyCRkmW1xDC
   mUdUICxXsTxWK9GwRhkLQLjFCXhKq4DHAQY+5mE6GRAKDfL+DvUinNTJz
   L9otj4xyGzxilPhXgK/Oyg3bZdndnadon+24YgTWhrvLGwjhBGIuH8ag6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="356058854"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="xz'341?scan'341,208,341";a="356058854"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 22:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="949932813"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="xz'341?scan'341,208,341";a="949932813"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 21 May 2023 22:34:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 21 May 2023 22:34:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 21 May 2023 22:34:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 21 May 2023 22:34:47 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 21 May 2023 22:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndjuD6RO8hiaWGnBfAp7z5W83ugJmrOtsuTeV2Vo3ITxJhloj/3JBkCgaTQsHtuwSuTpXHTvw5iVhkySY0JXrEhHD1kNsamj432duaMHWyC9U6O7WiHX5dzk4ALTlloFTCXvWc2trZ4Xy3ogsdb2v1rXRG7SkJ9iViwNeVO6x8Z3UQR+mRtZ8gaBxpoWu0ih8+hxMsMopkDpjbv8fLDcexogYeHS+1iwLG9qN9+8nmPWBzFU3zZ/fJJp0eyhaeMsF5VIk/ajyvnjoPiRvc8hWbCAPYIJvHdzsgxFumwYlGstLFom6EXwaNDnty6D6WXd/Yz6m4Ammy876Jzk2EKfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORmucVJI7kOrvqvQ0PH7m7x5r1nm8lBNJ0lhNJSUEG0=;
 b=GUR0U4TB2HMYQgt1C/wei5HXhoUDBoTBPqfzNQNKaqSdU7kJFWDSStySjiL1Mh12CcSxCHGKXu5V1daHaxgio3jseBu4MMittI4rrhZLcwG70V4ttgvfvGUOCnH15bPhGMequRfElyqrvrVvgQH3b4mM5z2UrL+LHZDQvzh31QaNCm/EYX8/+0Rzs4b6Gm0q/640rXhvrFNKWKEwYfLFu7OheaUpdUmbVseDwNJlbJ+FIu4yVicgN1WcOc6rVfYGVXCh/fKrRDgwsUCGGPt1VNzVwlUXiRQ0Gy+owK4KuV7OLz/aUzinlJtoP6dwvfsNXW4NRJvmnBD7eEtiICwDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) by
 CH3PR11MB8564.namprd11.prod.outlook.com (2603:10b6:610:1b1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Mon, 22 May 2023 05:34:22 +0000
Received: from DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::bf39:1326:e68e:2ebf]) by DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::bf39:1326:e68e:2ebf%2]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 05:34:22 +0000
Date:   Mon, 22 May 2023 13:30:58 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Ed Tsai <ed.tsai@mediatek.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <bvanassche@acm.org>,
        <stanley.chu@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <powen.kao@mediatek.com>, <naomi.chu@mediatek.com>,
        <wsd_upstream@mediatek.com>, Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH 1/2] block: make the fair sharing of tag configurable
Message-ID: <202305221236.5410a5c6-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="3Jp55kb4egPYDP7E"
Content-Disposition: inline
In-Reply-To: <20230509065230.32552-2-ed.tsai@mediatek.com>
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6397:EE_|CH3PR11MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db866c7-be52-45d7-d485-08db5a8630ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsPNKOq2Bl4iM80y/FOf+S6eok2a6tqJA0RVz4VYcsvcRt32zBLo0bZ5Nm2wx/Ljek/Xj15UpPBIZpsPARKRU2Ime/y9dCOA4y9zY5Ekcqz+e6nv4V6l4BfMO95kzHeyB5+sJtYqz2umnttMH24uOllKRQxiIESW3ywAoMv7BfWs+nhse9jYbl/AhZjJyurL4l4m0evuJCE8ucog1BMLRaF+v06uBihVc+EOB1a/04nkxbgtrBNdyS414ENhcnYSzXP5AruagXwp3dPAfL9yoDf6UF7OD2tKYENiKmY2SAPiNOZyA7rzQFgDnFIGWY5WO+YhVEldOTwCnMHYZYDDwO8NQQvKKG6Jouz0CLdrqs6cMlTYEuNdVqawEVHiRVa/5rkdk/MU7J9hiLXqhgAdkO2ZuZ1sMU+/geGmYY3W6tpxaioT7XcLsYnvHM/5qunow4ZBSiJEWvo8jTBPO8QI68ia9xl0bW4cjovDgA9E6FiHA3AMjgOVOur3h6/TgjSu/0MSvS9RzLiXfCNbcCy4FVzwJ/34IEx2YVgFds5nyEz00uSm6wxlt8iMESmv2jfP1guUkEnUM8tg0GSb9vgUuY0NBk0H4TMY1yjyLH2f1y0vt6n3AJj/002TbU1rXjnHdVpQNnRoHIWilVA//RyiVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6397.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(2616005)(83380400001)(186003)(2906002)(6916009)(4326008)(66476007)(66946007)(66556008)(41300700001)(6486002)(316002)(6666004)(478600001)(45080400002)(7416002)(235185007)(5660300002)(26005)(1076003)(6506007)(6512007)(966005)(44144004)(8676002)(8936002)(38100700002)(82960400001)(86362001)(36756003)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EWLNf8wqahTFHaQP2gBgWb0JD00QIl6nePzTjiH+1an5B0/fb5aEWWj+l45r?=
 =?us-ascii?Q?lYmc1KO8luUCDoQvz9EUA++eNbKVHwpcmgOK1RP34iVf3PLxAb+uSHnqj2Zn?=
 =?us-ascii?Q?63l3pKwPha+pcDGqZe9oGuHLRvsp99AY1eJhDbBFWN4Z5NrOGM6919gle5iP?=
 =?us-ascii?Q?k8pinS/E4yo9u1GAEiGiCAUDc+XxEDAdaM4UPZI5YDIXcqfen9DVJw03uCl/?=
 =?us-ascii?Q?OIbk2RPj1wUp3GDvHwTxsgNZ9caO1mTy9hmwbKcJIZG1ATT9P6P8TX9oK2vJ?=
 =?us-ascii?Q?lHMPp484I5V0LK/rQ4jT5gBbSSrrt6njAxsvDKQS6WeT9l6KG5QWdNX1xZDS?=
 =?us-ascii?Q?vX27GFzT+5tO7HJC1xyH6ceWrzmlYMVGJyO+7m27/y6ydpoIO7leNxQhRKHm?=
 =?us-ascii?Q?eRrjUfdEdhP0O9Yn2B9l9A3ooACki+z2zN+hbzMyrMkqgyJWLu8t8PZtkk+a?=
 =?us-ascii?Q?9wvx4r/t11f4WGJORmlVj2zYcfWVyhkFXf2tfkEGvez8DlRr2KVX2aGxlG3D?=
 =?us-ascii?Q?h/SiJRMhRmf67pRb3ETV8uMYYLWfWPZdT4Wgt/Yrwl/RLwpAJs6xXAx6qdqF?=
 =?us-ascii?Q?/UtkA8GW4X+lkAWrFaXScndU+NPdqAS4BPGOF2SUUUNbjhtjrMEdmDkzcWYn?=
 =?us-ascii?Q?VnzMzVrqt+fxA6NNa7U1/7q0Zt5Om0HlmJk5O03n7IVjgZ0yvFoqzojz4iP/?=
 =?us-ascii?Q?3aPtvlepRNHawaOU5ZexvVKqwNAQ6MGb+gTMYp1e/qqdc0Gh/KS2XPKm9qzR?=
 =?us-ascii?Q?ov0dLCWidl0ZEn73G51VTiMvrmXGqC4+iA0r91m07y4F4ooMaAdXKMNFJfyK?=
 =?us-ascii?Q?8YQ1AhBZvt/dBzCdGG5gxim8/d7mSl8mplw1gzq0wz0OuPJqxx6I+VFshRFw?=
 =?us-ascii?Q?KgFYwOexh8IwfyDSBG+N8J0rbZqFPDlw5lvjF+pDQIGy5zDX9RRB9d38CXE+?=
 =?us-ascii?Q?p4RknC4VpJAieb4B4RkLmXpMhQlxFLLnhc837pnSwwiesOhnlHxulBXRpcr+?=
 =?us-ascii?Q?MGw3qJewIdWjjcDIf9g/OJyKkmslCIPZRhjxYZA6oSu9/ybF0BHpTApfJAS1?=
 =?us-ascii?Q?biGvflgU+2qfPceUsJ5oGrkKlUiqBSA9Wlx/ZIuLBWFV3krf/Jqcm3zp+O/G?=
 =?us-ascii?Q?3nZCr+P5+OjdpV8TXeVjzVi1pfxBU50CvrFlO5gFALAltWpxUv5kMzefuGWK?=
 =?us-ascii?Q?zGj5bz41liSvXTsmubdY6H0tL0aw2kNT0NUJui9ScPzYnhoIjHuXQEew/+e7?=
 =?us-ascii?Q?cGVrN+bZFkGTTk4J7y5ua1oiUr93aQ0XQ9GO1NeXUsuuHRwCgKiJBPsbu4cG?=
 =?us-ascii?Q?XDQ4uE99xCl0zY9t9QZpSqZeC57IMJLTFL9/cQbZkjEdWq9/M7xlEy3/a4iE?=
 =?us-ascii?Q?EPa27N7YzV6oilDnf0jnUo8khNdciGkmVyy31u6Ni49pXjsbgjBC6wH5c4l2?=
 =?us-ascii?Q?z4EVYP0gbIu1pP8NcF/R1Br1z5nptDH0OldQhLJEs38sqFERdWkB4UahJsI1?=
 =?us-ascii?Q?9gK7pA+6wrGqvhAa8AAZtf3X917j6VahSmbrxTiaaXxrDDYZdiopgInk1rEt?=
 =?us-ascii?Q?eDKenTxwwAAE0iU8/bITG25vKfjKRJF17sfpbE0w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db866c7-be52-45d7-d485-08db5a8630ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6397.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 05:34:21.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsDcjCxTa7tnND9fSgN623Wh5LzTjyhmnL1q2aKrwsQjaMIYhYVfFT2eKZB4dUi3DTl2rl0v7oPXUb3hN/YGRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8564
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--3Jp55kb4egPYDP7E
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hello,

kernel test robot noticed "UBSAN:shift-out-of-bounds_in(null)" on:

commit: b1081024bc6d1cdaf5b39994b19040cd8e6099ec ("[PATCH 1/2] block: make the fair sharing of tag configurable")
url: https://github.com/intel-lab-lkp/linux/commits/Ed-Tsai/block-make-the-fair-sharing-of-tag-configurable/20230509-145439
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch subject: [PATCH 1/2] block: make the fair sharing of tag configurable
patch link: https://lore.kernel.org/all/20230509065230.32552-2-ed.tsai@mediatek.com/

in testcase: boot

compiler: clang-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)

+------------------------------------------------------------+------------+------------+
|                                                            | b2e48bd0db | b1081024bc |
+------------------------------------------------------------+------------+------------+
| boot_successes                                             | 8          | 0          |
| boot_failures                                              | 0          | 8          |
| UBSAN:shift-out-of-bounds_in(null)                         | 0          | 8          |
| WARNING:at_lib/ubsan.c:#__ubsan_handle_shift_out_of_bounds | 0          | 8          |
| EIP:__ubsan_handle_shift_out_of_bounds                     | 0          | 8          |
| BUG:unable_to_handle_page_fault_for_address                | 0          | 8          |
| Oops:#[##]                                                 | 0          | 8          |
| EIP:blk_mq_debugfs_register_sched                          | 0          | 8          |
| Kernel_panic-not_syncing:Fatal_exception                   | 0          | 8          |
+------------------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202305221236.5410a5c6-yujie.liu@intel.com


[    8.114565][    T1] UBSAN: shift-out-of-bounds in (null):0:-1017201787
[    8.115735][    T1] ------------[ cut here ]------------
[ 8.116722][ T1] WARNING: CPU: 0 PID: 1 at lib/ubsan.c:127 __ubsan_handle_shift_out_of_bounds (lib/ubsan.c:127) 
[    8.118211][    T1] Modules linked in:
[    8.118975][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc1-00004-gb1081024bc6d #1 db924219c7bf519b06320a8fa4e221875190bd2e
[    8.121026][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 8.122583][ T1] EIP: __ubsan_handle_shift_out_of_bounds (lib/ubsan.c:127) 
[ 8.123706][ T1] Code: 8b 0a 8b 7a 04 8d 45 88 57 51 68 c3 0c d1 c2 6a 28 50 e8 89 ef 94 00 83 c4 14 8b 55 ec 8b 45 f0 66 83 38 00 0f 84 4b fe ff ff <0f> 0b e9 44 fe ff ff 0f 0b 66 83 f8 0b 0f 86 5a fe ff ff 8b 45 e8
All code
========
   0:	8b 0a                	mov    (%rdx),%ecx
   2:	8b 7a 04             	mov    0x4(%rdx),%edi
   5:	8d 45 88             	lea    -0x78(%rbp),%eax
   8:	57                   	push   %rdi
   9:	51                   	push   %rcx
   a:	68 c3 0c d1 c2       	push   $0xffffffffc2d10cc3
   f:	6a 28                	push   $0x28
  11:	50                   	push   %rax
  12:	e8 89 ef 94 00       	call   0x94efa0
  17:	83 c4 14             	add    $0x14,%esp
  1a:	8b 55 ec             	mov    -0x14(%rbp),%edx
  1d:	8b 45 f0             	mov    -0x10(%rbp),%eax
  20:	66 83 38 00          	cmpw   $0x0,(%rax)
  24:	0f 84 4b fe ff ff    	je     0xfffffffffffffe75
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 44 fe ff ff       	jmp    0xfffffffffffffe75
  31:	0f 0b                	ud2
  33:	66 83 f8 0b          	cmp    $0xb,%ax
  37:	0f 86 5a fe ff ff    	jbe    0xfffffffffffffe97
  3d:	8b 45 e8             	mov    -0x18(%rbp),%eax

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 44 fe ff ff       	jmp    0xfffffffffffffe4b
   7:	0f 0b                	ud2
   9:	66 83 f8 0b          	cmp    $0xb,%ax
   d:	0f 86 5a fe ff ff    	jbe    0xfffffffffffffe6d
  13:	8b 45 e8             	mov    -0x18(%rbp),%eax
[    8.126748][    T1] EAX: ca11ec40 EBX: c5bf0000 ECX: 00000000 EDX: c83b66c0
[    8.127956][    T1] ESI: ffffffff EDI: c8118000 EBP: c59f1a58 ESP: c59f19e0
[    8.129141][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010282
[    8.130361][    T1] CR0: 80050033 CR2: b7f19cd4 CR3: 035f7000 CR4: 00040690
[    8.131528][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    8.132744][    T1] DR6: fffe0ff0 DR7: 00000400
[    8.133723][    T1] Call Trace:
[ 8.134454][ T1] ? mutex_unlock (kernel/locking/mutex.c:544) 
[ 8.135290][ T1] blk_mq_init_allocated_queue (block/blk-mq.c:4232) 
[ 8.140517][ T1] ? blk_timeout_work (block/blk-core.c:374) 
[ 8.141538][ T1] ? blk_alloc_queue (block/blk-core.c:438) 
[ 8.142497][ T1] __blk_mq_alloc_disk (block/blk-mq.c:4043 block/blk-mq.c:4089) 
[ 8.143445][ T1] add_mtd_blktrans_dev (drivers/mtd/mtd_blkdevs.c:336) 
[ 8.144403][ T1] mtdblock_add_mtd (drivers/mtd/mtdblock.c:333) 
[ 8.145285][ T1] blktrans_notify_add (drivers/mtd/mtd_blkdevs.c:?) 
[ 8.146175][ T1] add_mtd_device (drivers/mtd/mtdcore.c:?) 
[ 8.147040][ T1] ? mtd_cls_resume (drivers/mtd/mtdcore.c:504) 
[ 8.147909][ T1] add_mtd_partitions (drivers/mtd/mtdpart.c:416) 
[ 8.148795][ T1] mtd_device_parse_register (drivers/mtd/mtdcore.c:?) 
[ 8.149747][ T1] ? nand_create_bbt (drivers/mtd/nand/raw/nand_bbt.c:936 drivers/mtd/nand/raw/nand_bbt.c:1266 drivers/mtd/nand/raw/nand_bbt.c:1425) 
[ 8.150623][ T1] ? ns_init (drivers/mtd/nand/raw/nandsim.c:766) 
[ 8.151425][ T1] ? ns_init (drivers/mtd/nand/raw/nandsim.c:?) 
[ 8.152240][ T1] ns_init_module (drivers/mtd/nand/raw/nandsim.c:2382) 
[ 8.153113][ T1] ? _printk (kernel/printk/printk.c:2331) 
[ 8.153903][ T1] do_one_initcall (init/main.c:1246) 
[ 8.154821][ T1] ? inftl_partscan (drivers/mtd/nand/raw/nandsim.c:2261) 
[ 8.155683][ T1] do_initcall_level (init/main.c:1318) 
[ 8.156564][ T1] ? rest_init (init/main.c:1454) 
[ 8.157391][ T1] do_initcalls (init/main.c:1332) 
[ 8.158194][ T1] do_basic_setup (init/main.c:1355) 
[ 8.159030][ T1] kernel_init_freeable (init/main.c:1575) 
[ 8.159939][ T1] kernel_init (init/main.c:1464) 
[ 8.160759][ T1] ret_from_fork (arch/x86/entry/entry_32.S:770) 
[    8.161568][    T1] irq event stamp: 494889
[ 8.162351][ T1] hardirqs last enabled at (494899): __up_console_sem (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:347) 
[ 8.163719][ T1] hardirqs last disabled at (494910): __up_console_sem (kernel/printk/printk.c:345) 
[ 8.165101][ T1] softirqs last enabled at (494786): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[ 8.166495][ T1] softirqs last disabled at (494775): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[    8.167899][    T1] ---[ end trace 0000000000000000 ]---


To reproduce:

        # build kernel
	cd linux
	cp config-6.4.0-rc1-00004-gb1081024bc6d .config
	make HOSTCC=clang-14 CC=clang-14 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=clang-14 CC=clang-14 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--3Jp55kb4egPYDP7E
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc1-00004-gb1081024bc6d"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.4.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 14.0.6 (git://gitmirror/llvm_project f28c006a5895fc0e329fe15fead81e37457cb1d1)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=140006
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=140006
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=140006
CONFIG_RUST_IS_AVAILABLE=y
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_KERNEL_ZSTD=y
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_SCHED_MM_CID=y
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_TIME_NS is not set
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_FORCE=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
CONFIG_M586=y
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_F00F_BUG=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
# CONFIG_SCHED_CLUSTER is not set
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_LATE_LOADING is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_HIGHPTE=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
# end of Processor type and features

CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_RETPOLINE=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_USERSPACE_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
# CONFIG_ACPI_DEBUGGER_USER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_EINJ=y
CONFIG_ACPI_APEI_ERST_DEBUG=y
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
CONFIG_DPTF_PCH_FIVR=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_FFH is not set
CONFIG_PMIC_OPREGION=y
# CONFIG_TPS68470_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_ALLOW_INTS is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ_CPB is not set
# CONFIG_X86_POWERNOW_K6 is not set
CONFIG_X86_POWERNOW_K7=y
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
CONFIG_X86_LONGHAUL=y
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
CONFIG_CPU_IDLE_GOV_TEO=y
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
CONFIG_GEOS=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_HAS_LTO_CLANG=y
CONFIG_LTO_NONE=y
# CONFIG_LTO_CLANG_FULL is not set
# CONFIG_LTO_CLANG_THIN is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
# CONFIG_ACORN_PARTITION_EESOX is not set
# CONFIG_ACORN_PARTITION_ICS is not set
CONFIG_ACORN_PARTITION_ADFS=y
CONFIG_ACORN_PARTITION_POWERTEC=y
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_BOUNCE=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ZONE_DMA=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y
CONFIG_ANON_VMA_NAME=y
CONFIG_USERFAULTFD=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=y
CONFIG_REGMAP_SOUNDWIRE_MBQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
# CONFIG_MHI_BUS_DEBUG is not set
# CONFIG_MHI_BUS_PCI_GENERIC is not set
CONFIG_MHI_BUS_EP=y
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_FW_CS_DSP=y
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
# CONFIG_FTL is not set
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PSTORE is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
CONFIG_MTD_MAP_BANK_WIDTH_8=y
CONFIG_MTD_MAP_BANK_WIDTH_16=y
CONFIG_MTD_MAP_BANK_WIDTH_32=y
# CONFIG_MTD_CFI_I1 is not set
# CONFIG_MTD_CFI_I2 is not set
CONFIG_MTD_CFI_I4=y
CONFIG_MTD_CFI_I8=y
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_SCx200_DOCFLASH=y
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=y
# CONFIG_MTD_ONENAND_OTP is not set
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=y
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_PLATFORM is not set
# CONFIG_MTD_NAND_ARASAN is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH is not set
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_MTD_HYPERBUS=y
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_SMPRO_ERRMON=y
# CONFIG_SMPRO_MISC is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_HOST_SMP=y
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

# CONFIG_ATA is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
# CONFIG_MD_RAID1 is not set
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=y
CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
# CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_THIN_PROVISIONING=y
CONFIG_DM_CACHE=y
CONFIG_DM_CACHE_SMQ=y
CONFIG_DM_WRITECACHE=y
CONFIG_DM_ERA=y
CONFIG_DM_CLONE=y
CONFIG_DM_MIRROR=y
# CONFIG_DM_LOG_USERSPACE is not set
# CONFIG_DM_RAID is not set
CONFIG_DM_ZERO=y
CONFIG_DM_MULTIPATH=y
CONFIG_DM_MULTIPATH_QL=y
# CONFIG_DM_MULTIPATH_ST is not set
CONFIG_DM_MULTIPATH_HST=y
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=y
# CONFIG_DM_DUST is not set
CONFIG_DM_INIT=y
# CONFIG_DM_UEVENT is not set
# CONFIG_DM_FLAKEY is not set
CONFIG_DM_VERITY=y
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
CONFIG_DM_VERITY_FEC=y
CONFIG_DM_SWITCH=y
CONFIG_DM_LOG_WRITES=y
CONFIG_DM_INTEGRITY=y
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
# CONFIG_TCM_FILEIO is not set
# CONFIG_TCM_PSCSI is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
# CONFIG_REMOTE_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0_ISA is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=y
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_PINEPHONE=y
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_IQS62X is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_KEYBOARD_CYPRESS_SF=y
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=y
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_INPORT=y
CONFIG_MOUSE_ATIXL=y
# CONFIG_MOUSE_LOGIBM is not set
CONFIG_MOUSE_PC110PAD=y
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=y
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_WALKERA0701=y
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_JOYSTICK_QWIIC=y
CONFIG_JOYSTICK_FSIA6B=y
CONFIG_JOYSTICK_SENSEHAT=y
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
# CONFIG_RMI4_F11 is not set
# CONFIG_RMI4_F12 is not set
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_16550A_VARIANTS=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DFL=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_LANTIQ=y
# CONFIG_SERIAL_LANTIQ_CONSOLE is not set
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_FSL_LINFLEXUART=y
# CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE is not set
CONFIG_SERIAL_MEN_Z135=y
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
CONFIG_NULL_TTY=y
CONFIG_RPMSG_TTY=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_IPMB is not set
# CONFIG_IPMI_WATCHDOG is not set
# CONFIG_IPMI_POWEROFF is not set
# CONFIG_SSIF_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_XIPHERA=y
CONFIG_DTLK=y
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C=y
# CONFIG_TCG_TIS_I2C_CR50 is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
# CONFIG_XILLYBUS is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PCI1XXXX is not set
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_PCA_ISA=y
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
# CONFIG_CDNS_I3C_MASTER is not set
# CONFIG_DW_I3C_MASTER is not set
# CONFIG_SVC_I3C_MASTER is not set
CONFIG_MIPI_I3C_HCI=y
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# CONFIG_PTP_DFL_TOD is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_CY8C95X0=y
# CONFIG_PINCTRL_DA9062 is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L90=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_LYNXPOINT=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_ELKHARTLAKE=y
CONFIG_PINCTRL_EMMITSBURG=y
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_JASPERLAKE=y
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
CONFIG_PINCTRL_METEORLAKE=y
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_TANGIER=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_FXL6408=y
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=y
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_ELKHARTLAKE=y
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TPS68470 is not set
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_LATCH=y
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
# CONFIG_W1_SLAVE_DS2780 is not set
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_ATC260X=y
# CONFIG_POWER_RESET_MT6323 is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_TPS65086=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_IP5XXX_POWER=y
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_88PM860X=y
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_MT6360 is not set
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_RT9467 is not set
CONFIG_CHARGER_RT9471=y
# CONFIG_CHARGER_BD99954 is not set
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_SMPRO=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX127=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX31760=y
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MC34VR500 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_MR75203=y
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT6775_I2C=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_OCC_P8_I2C=y
CONFIG_SENSORS_OCC=y
# CONFIG_SENSORS_OXP is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_SENSORS_PECI_CPUTEMP=y
# CONFIG_SENSORS_PECI_DIMMTEMP is not set
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
# CONFIG_SENSORS_ACBEL_FSG032 is not set
CONFIG_SENSORS_ADM1266=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
CONFIG_SENSORS_BPA_RS600=y
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_DPS920AB=y
CONFIG_SENSORS_INSPUR_IPSPS=y
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
CONFIG_SENSORS_IR38064=y
CONFIG_SENSORS_IR38064_REGULATOR=y
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LT7182S=y
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=y
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_MP2888 is not set
CONFIG_SENSORS_MP2975=y
CONFIG_SENSORS_MP5023=y
CONFIG_SENSORS_MPQ7932_REGULATOR=y
CONFIG_SENSORS_MPQ7932=y
CONFIG_SENSORS_PIM4328=y
# CONFIG_SENSORS_PLI1209BC is not set
CONFIG_SENSORS_PM6764TR=y
CONFIG_SENSORS_PXE1610=y
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TDA38640 is not set
CONFIG_SENSORS_TPS40422=y
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_TPS546D24=y
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_XDPE152=y
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHT4x=y
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC2305=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA238=y
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=y
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=y
# CONFIG_SENSORS_INTEL_M10_BMC_HWMON is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
# CONFIG_SENSORS_ASUS_WMI is not set
CONFIG_SENSORS_ASUS_EC=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_INTEL_TCC_COOLING=y
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_SMPRO=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
# CONFIG_MFD_CS47L15 is not set
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_INTEL_SOC_PMIC_MRFLD=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6370=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RT5120=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=y
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_INTEL_M10_BMC_CORE=y
CONFIG_MFD_INTEL_M10_BMC_PMCI=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_ARIZONA_LDO1 is not set
# CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
CONFIG_REGULATOR_ATC260X=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD9571MWV=y
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9055=y
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8997 is not set
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX20411=y
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6315 is not set
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6331=y
CONFIG_REGULATOR_MT6332=y
# CONFIG_REGULATOR_MT6357 is not set
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6359=y
CONFIG_REGULATOR_MT6360=y
CONFIG_REGULATOR_MT6370=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCA9450=y
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_QCOM_SPMI=y
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4803=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_RT5120=y
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5739 is not set
CONFIG_REGULATOR_RT5759=y
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6190=y
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=y
# CONFIG_REGULATOR_RTMV20 is not set
CONFIG_REGULATOR_RTQ6752=y
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS6586X=y
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_TPS68470=y
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8350=y
# CONFIG_REGULATOR_QCOM_LABIBB is not set
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_DVB_CORE=y
# end of Media core support

#
# Digital TV options
#
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#

#
# Mediatek media platform drivers
#

#
# Microchip Technology, Inc. media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# Verisilicon media platform drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=y
# CONFIG_DVB_TEST_DRIVERS is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_SMS_SIANO_MDTV=y
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_MEDIA_TUNER=y

#
# Tuner drivers auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y

#
# DVB Frontend drivers auto-selected by 'Autoselect ancillary drivers'
#

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Common Interface (EN50221) controller drivers
#

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_QXL is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_SSD130X=y
CONFIG_DRM_SSD130X_I2C=y
CONFIG_DRM_LEGACY=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
CONFIG_BACKLIGHT_KTZ8866=y
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_MT6370 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_WM831X is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
# CONFIG_SND_VERBOSE_PROCFS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_CTL_FAST_LOOKUP=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_CTL_DEBUG=y
# CONFIG_SND_JACK_INJECTION_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_DRIVERS is not set
# CONFIG_SND_ISA is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
# CONFIG_SND_SOC_ADI is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
# CONFIG_SND_SOC_AMD_PS is not set
CONFIG_SND_ATMEL_SOC=y
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
CONFIG_SND_DESIGNWARE_I2S=y
CONFIG_SND_DESIGNWARE_PCM=y

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_MQS=y
# CONFIG_SND_SOC_FSL_AUDMIX is not set
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
CONFIG_SND_SOC_FSL_ESAI=y
# CONFIG_SND_SOC_FSL_MICFIL is not set
CONFIG_SND_SOC_FSL_EASRC=y
CONFIG_SND_SOC_FSL_XCVR=y
CONFIG_SND_SOC_FSL_UTILS=y
CONFIG_SND_SOC_FSL_RPMSG=y
CONFIG_SND_SOC_IMX_AUDMUX=y
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
CONFIG_SND_SOC_IMG=y
# CONFIG_SND_SOC_IMG_I2S_IN is not set
# CONFIG_SND_SOC_IMG_I2S_OUT is not set
CONFIG_SND_SOC_IMG_PARALLEL_OUT=y
CONFIG_SND_SOC_IMG_SPDIF_IN=y
# CONFIG_SND_SOC_IMG_SPDIF_OUT is not set
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
# CONFIG_SND_SOC_INTEL_AVS is not set
CONFIG_SND_SOC_MTK_BTCVSD=y
CONFIG_SND_SOC_SOF_TOPLEVEL=y
# CONFIG_SND_SOC_SOF_PCI is not set
CONFIG_SND_SOC_SOF_ACPI=y
# CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
# CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

CONFIG_SND_SOC_XILINX_I2S=y
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
CONFIG_SND_SOC_XILINX_SPDIF=y
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_WM_ADSP=y
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU_UTILS=y
# CONFIG_SND_SOC_ADAU1372_I2C is not set
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU7002=y
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
CONFIG_SND_SOC_AK4118=y
CONFIG_SND_SOC_AK4375=y
CONFIG_SND_SOC_AK4458=y
CONFIG_SND_SOC_AK4554=y
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
CONFIG_SND_SOC_AK5386=y
CONFIG_SND_SOC_AK5558=y
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_AW8738 is not set
CONFIG_SND_SOC_AW88395_LIB=y
CONFIG_SND_SOC_AW88395=y
# CONFIG_SND_SOC_BD28623 is not set
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
# CONFIG_SND_SOC_CS35L35 is not set
CONFIG_SND_SOC_CS35L36=y
CONFIG_SND_SOC_CS35L41_LIB=y
CONFIG_SND_SOC_CS35L41=y
CONFIG_SND_SOC_CS35L41_I2C=y
CONFIG_SND_SOC_CS35L45=y
CONFIG_SND_SOC_CS35L45_I2C=y
CONFIG_SND_SOC_CS35L56=y
CONFIG_SND_SOC_CS35L56_SHARED=y
CONFIG_SND_SOC_CS35L56_I2C=y
CONFIG_SND_SOC_CS35L56_SDW=y
CONFIG_SND_SOC_CS42L42_CORE=y
CONFIG_SND_SOC_CS42L42=y
# CONFIG_SND_SOC_CS42L42_SDW is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
CONFIG_SND_SOC_CS42L56=y
# CONFIG_SND_SOC_CS42L73 is not set
CONFIG_SND_SOC_CS42L83=y
# CONFIG_SND_SOC_CS4234 is not set
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
CONFIG_SND_SOC_CS43130=y
# CONFIG_SND_SOC_CS4341 is not set
CONFIG_SND_SOC_CS4349=y
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_CX2072X=y
CONFIG_SND_SOC_DA7213=y
# CONFIG_SND_SOC_DMIC is not set
# CONFIG_SND_SOC_ES7134 is not set
CONFIG_SND_SOC_ES7241=y
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8326=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_GTM601=y
# CONFIG_SND_SOC_HDA is not set
CONFIG_SND_SOC_ICS43432=y
CONFIG_SND_SOC_INNO_RK3036=y
CONFIG_SND_SOC_MAX98088=y
CONFIG_SND_SOC_MAX98090=y
CONFIG_SND_SOC_MAX98357A=y
CONFIG_SND_SOC_MAX98504=y
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=y
# CONFIG_SND_SOC_MAX98520 is not set
CONFIG_SND_SOC_MAX98363=y
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX98373_I2C=y
# CONFIG_SND_SOC_MAX98373_SDW is not set
CONFIG_SND_SOC_MAX98390=y
# CONFIG_SND_SOC_MAX98396 is not set
# CONFIG_SND_SOC_MAX9860 is not set
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
# CONFIG_SND_SOC_PCM179X_I2C is not set
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
# CONFIG_SND_SOC_PCM5102A is not set
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
CONFIG_SND_SOC_RK3328=y
CONFIG_SND_SOC_RT1308_SDW=y
CONFIG_SND_SOC_RT1316_SDW=y
CONFIG_SND_SOC_RT1318_SDW=y
# CONFIG_SND_SOC_RT5616 is not set
CONFIG_SND_SOC_RT5631=y
# CONFIG_SND_SOC_RT5640 is not set
# CONFIG_SND_SOC_RT5659 is not set
# CONFIG_SND_SOC_RT5682_SDW is not set
CONFIG_SND_SOC_RT700=y
CONFIG_SND_SOC_RT700_SDW=y
# CONFIG_SND_SOC_RT711_SDW is not set
# CONFIG_SND_SOC_RT711_SDCA_SDW is not set
# CONFIG_SND_SOC_RT712_SDCA_SDW is not set
# CONFIG_SND_SOC_RT712_SDCA_DMIC_SDW is not set
CONFIG_SND_SOC_RT715=y
CONFIG_SND_SOC_RT715_SDW=y
CONFIG_SND_SOC_RT715_SDCA_SDW=y
CONFIG_SND_SOC_RT9120=y
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
CONFIG_SND_SOC_SIMPLE_MUX=y
CONFIG_SND_SOC_SMA1303=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SRC4XXX_I2C=y
CONFIG_SND_SOC_SRC4XXX=y
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2518 is not set
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_I2C=y
# CONFIG_SND_SOC_SSM4567 is not set
CONFIG_SND_SOC_STA32X=y
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_STI_SAS=y
CONFIG_SND_SOC_TAS2552=y
# CONFIG_SND_SOC_TAS2562 is not set
CONFIG_SND_SOC_TAS2764=y
CONFIG_SND_SOC_TAS2770=y
CONFIG_SND_SOC_TAS2780=y
# CONFIG_SND_SOC_TAS5086 is not set
CONFIG_SND_SOC_TAS571X=y
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS5805M=y
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TFA989X=y
CONFIG_SND_SOC_TLV320ADC3XXX=y
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TLV320AIC3X_I2C=y
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=y
CONFIG_SND_SOC_TSCS42XX=y
CONFIG_SND_SOC_TSCS454=y
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WCD938X_SDW is not set
# CONFIG_SND_SOC_WM8510 is not set
CONFIG_SND_SOC_WM8523=y
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
CONFIG_SND_SOC_WM8711=y
CONFIG_SND_SOC_WM8728=y
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8731_I2C=y
# CONFIG_SND_SOC_WM8737 is not set
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=y
CONFIG_SND_SOC_WM8753=y
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
# CONFIG_SND_SOC_WM8940 is not set
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8961=y
CONFIG_SND_SOC_WM8962=y
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
CONFIG_SND_SOC_WM8985=y
CONFIG_SND_SOC_WSA881X=y
CONFIG_SND_SOC_WSA883X=y
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_MT6351=y
CONFIG_SND_SOC_MT6358=y
CONFIG_SND_SOC_MT6660=y
CONFIG_SND_SOC_NAU8315=y
CONFIG_SND_SOC_NAU8540=y
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_NAU8821=y
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_TPA6130A2=y
CONFIG_SND_SOC_LPASS_MACRO_COMMON=y
CONFIG_SND_SOC_LPASS_WSA_MACRO=y
CONFIG_SND_SOC_LPASS_VA_MACRO=y
CONFIG_SND_SOC_LPASS_RX_MACRO=y
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_SND_VIRTIO=y
CONFIG_AC97_BUS=y
# CONFIG_HID_SUPPORT is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB dual-mode controller drivers
#

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=y
# CONFIG_MMC_TEST is not set
# CONFIG_MMC_CRYPTO is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_SCSI_UFSHCD=y
CONFIG_SCSI_UFS_BSG=y
CONFIG_SCSI_UFS_CRYPTO=y
# CONFIG_SCSI_UFS_HPB is not set
CONFIG_SCSI_UFS_FAULT_INJECTION=y
CONFIG_SCSI_UFS_HWMON=y
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=y
CONFIG_SCSI_UFS_CDNS_PLATFORM=y
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
CONFIG_LEDS_APU=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_NET48XX=y
# CONFIG_LEDS_WRAP is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA903X=y
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2606MVV=y
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX8997=y
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_IS31FL319X=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y
CONFIG_LEDS_TPS6105X=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_MT6370_FLASH=y
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_LEDS_TRIGGER_TTY=y

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
CONFIG_RTC_DRV_88PM80X=y
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_MAX8997=y
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_X1205=y
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=y
# CONFIG_RTC_DRV_PALMAS is not set
CONFIG_RTC_DRV_TPS6586X=y
CONFIG_RTC_DRV_RC5T583=y
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV3032=y
# CONFIG_RTC_DRV_RV8803 is not set
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RV3029_HWMON is not set
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9052 is not set
# CONFIG_RTC_DRV_DA9055 is not set
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_WM8350=y
CONFIG_RTC_DRV_PCF50633=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_MC13XXX=y
CONFIG_RTC_DRV_MT6397=y

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
CONFIG_DMABUF_SYSFS_STATS=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
# CONFIG_COMEDI_TEST is not set
# CONFIG_COMEDI_PARPORT is not set
# CONFIG_COMEDI_SSV_DNP is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
# CONFIG_COMEDI_KCOMEDILIB is not set
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_MLXREG_IO=y
CONFIG_MLXREG_LC=y
CONFIG_NVSW_SN2201=y
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE_3_POWER_OPREGION=y
CONFIG_SURFACE_GPE=y
CONFIG_SURFACE_HOTPLUG=y
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
CONFIG_HUAWEI_WMI=y
CONFIG_MXM_WMI=y
CONFIG_NVIDIA_WMI_EC_BACKLIGHT=y
CONFIG_XIAOMI_WMI=y
CONFIG_GIGABYTE_WMI=y
# CONFIG_YOGABOOK_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACER_WMI is not set
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
CONFIG_ADV_SWBUTTON=y
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_ASUS_WIRELESS=y
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
CONFIG_ALIENWARE_WMI=y
CONFIG_DCDBAS=y
CONFIG_DELL_LAPTOP=y
# CONFIG_DELL_RBU is not set
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMBIOS_WMI is not set
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_SMO8800=y
CONFIG_DELL_WMI=y
# CONFIG_DELL_WMI_PRIVACY is not set
# CONFIG_DELL_WMI_AIO is not set
CONFIG_DELL_WMI_DESCRIPTOR=y
CONFIG_DELL_WMI_DDV=y
CONFIG_DELL_WMI_LED=y
# CONFIG_DELL_WMI_SYSMAN is not set
CONFIG_FUJITSU_LAPTOP=y
CONFIG_FUJITSU_TABLET=y
CONFIG_GPD_POCKET_FAN=y
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
CONFIG_WIRELESS_HOTKEY=y
# CONFIG_IBM_RTL is not set
CONFIG_LENOVO_YMC=y
CONFIG_SENSORS_HDAPS=y
CONFIG_THINKPAD_ACPI=y
# CONFIG_THINKPAD_ACPI_ALSA_SUPPORT is not set
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=y
CONFIG_INTEL_SAR_INT1092=y
CONFIG_INTEL_SKL_INT3472=y
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_INTEL_HID_EVENT=y
CONFIG_INTEL_VBTN=y
CONFIG_INTEL_INT0002_VGPIO=y
# CONFIG_INTEL_MRFLD_PWRBTN is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_INTEL_RST=y
CONFIG_INTEL_SMARTCONNECT=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_EC=y
# CONFIG_MSI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_BARCO_P50_GPIO=y
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
CONFIG_TOSHIBA_HAPS=y
CONFIG_TOSHIBA_WMI=y
# CONFIG_ACPI_CMPC is not set
CONFIG_LG_LAPTOP=y
CONFIG_PANASONIC_LAPTOP=y
CONFIG_SYSTEM76_ACPI=y
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
# CONFIG_INTEL_SCU_PCI is not set
CONFIG_INTEL_SCU_PLATFORM=y
CONFIG_INTEL_SCU_IPC_UTIL=y
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
# CONFIG_P2SB is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_SI5341=y
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_TPS68470=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
CONFIG_IOMMU_DEFAULT_DMA_STRICT=y
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMUFD=y
# CONFIG_IOMMUFD_TEST is not set
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_AMD is not set
# CONFIG_SOUNDWIRE_INTEL is not set
CONFIG_SOUNDWIRE_QCOM=y

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

CONFIG_WPCM450_SOC=y

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_FSA9480=y
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_INTEL_MRFLD=y
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
CONFIG_FPGA_DFL_EMIF=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_IDLE_INJECT=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
# CONFIG_NVMEM_SYSFS is not set

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
CONFIG_NVMEM_LAYOUT_ONIE_TLV=y
# end of Layout Types

CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_SPMI_SDAM=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_STH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=y
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
CONFIG_FPGA_DFL_FME_MGR=y
# CONFIG_FPGA_DFL_FME_BRIDGE is not set
CONFIG_FPGA_DFL_FME_REGION=y
CONFIG_FPGA_DFL_AFU=y
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_FPGA_M10_BMC_SEC_UPDATE=y
CONFIG_TEE=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
# CONFIG_INTEL_QEP is not set
CONFIG_INTERRUPT_CNT=y
CONFIG_MOST=y
# CONFIG_MOST_CDEV is not set
CONFIG_MOST_SND=y
CONFIG_PECI=y
CONFIG_PECI_CPU=y
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_XFS_FS is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_ZONEFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_FS_WBUF_VERIFY=y
CONFIG_JFFS2_SUMMARY=y
CONFIG_JFFS2_FS_XATTR=y
# CONFIG_JFFS2_FS_POSIX_ACL is not set
# CONFIG_JFFS2_FS_SECURITY is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
# CONFIG_UBIFS_FS_LZO is not set
# CONFIG_UBIFS_FS_ZLIB is not set
# CONFIG_UBIFS_FS_ZSTD is not set
CONFIG_UBIFS_ATIME_SUPPORT=y
# CONFIG_UBIFS_FS_XATTR is not set
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
CONFIG_SQUASHFS_DECOMP_MULTI=y
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT=y
CONFIG_SQUASHFS_MOUNT_DECOMP_THREADS=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
# CONFIG_SQUASHFS_LZO is not set
# CONFIG_SQUASHFS_XZ is not set
CONFIG_SQUASHFS_ZSTD=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
# CONFIG_OMFS_FS is not set
CONFIG_HPFS_FS=y
# CONFIG_QNX4FS_FS is not set
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lz4hc"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=y
CONFIG_PSTORE_ZONE=y
CONFIG_PSTORE_BLK=y
CONFIG_PSTORE_BLK_BLKDEV=""
CONFIG_PSTORE_BLK_KMSG_SIZE=64
CONFIG_PSTORE_BLK_MAX_REASON=2
CONFIG_PSTORE_BLK_CONSOLE_SIZE=64
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
CONFIG_EROFS_FS=y
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=y
CONFIG_EROFS_FS_POSIX_ACL=y
CONFIG_EROFS_FS_SECURITY=y
CONFIG_EROFS_FS_ZIP=y
# CONFIG_EROFS_FS_ZIP_LZMA is not set
# CONFIG_EROFS_FS_PCPU_KTHREAD is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_LOADPIN=y
# CONFIG_SECURITY_LOADPIN_ENFORCE is not set
CONFIG_SECURITY_LOADPIN_VERITY=y
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
# CONFIG_IMA_NG_TEMPLATE is not set
CONFIG_IMA_SIG_TEMPLATE=y
CONFIG_IMA_DEFAULT_TEMPLATE="ima-sig"
# CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
CONFIG_IMA_DEFAULT_HASH_SHA256=y
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
# CONFIG_IMA_DEFAULT_HASH_SM3 is not set
CONFIG_IMA_DEFAULT_HASH="sha256"
# CONFIG_IMA_WRITE_POLICY is not set
CONFIG_IMA_READ_POLICY=y
# CONFIG_IMA_APPRAISE is not set
CONFIG_IMA_DISABLE_HTABLE=y
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ARIA=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_VMAC=y
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_TWOFISH_586=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_BTF_TAG=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
CONFIG_UBSAN_UNREACHABLE=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
# CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_KMSAN_COMPILER=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_NMI_CHECK_CPU=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_USER_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
CONFIG_FAIL_MMC_REQUEST=y
# CONFIG_FAULT_INJECTION_CONFIGFS is not set
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_DHRY=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--3Jp55kb4egPYDP7E
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys='rootfs
compiler
force_latest_head'
	export queue='vip'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-devel/devel-hourly-20230515-172405'
	export commit='b1081024bc6d1cdaf5b39994b19040cd8e6099ec'
	export kconfig='i386-randconfig-i093-20230515'
	export repeat_to=2
	export nr_vm=300
	export submit_id='6465e5aaf757fb76f5bd8bb4'
	export job_file='/lkp/jobs/scheduled/vm-meta-282/boot-1-debian-11.1-i386-20220923.cgz-b1081024bc6d1cdaf5b39994b19040cd8e6099ec-20230518-1210101-12etdcy-0.yaml'
	export id='642ddf9c51af943b72df671a734a05b9d5d78e47'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-i386-20220923.cgz'
	export compiler='clang-14'
	export force_latest_head=1
	export enqueue_time='2023-05-18 16:45:30 +0800'
	export _id='6465e5aaf757fb76f5bd8bb4'
	export _rt='/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-i093-20230515/clang-14/b1081024bc6d1cdaf5b39994b19040cd8e6099ec'
	export user='lkp'
	export meta_host='vm-meta-282'
	export LKP_SERVER='internal-lkp-server'
	export kernel='/pkg/linux/i386-randconfig-i093-20230515/clang-14/b1081024bc6d1cdaf5b39994b19040cd8e6099ec/vmlinuz-6.4.0-rc1-00004-gb1081024bc6d'
	export result_root='/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-i093-20230515/clang-14/b1081024bc6d1cdaf5b39994b19040cd8e6099ec/0'
	export dequeue_time='2023-05-18 16:45:59 +0800'
	export scheduler_version='/lkp/lkp/.src-20230517-200353'
	export arch='i386'
	export max_uptime=600
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-i093-20230515/clang-14/b1081024bc6d1cdaf5b39994b19040cd8e6099ec/0
BOOT_IMAGE=/pkg/linux/i386-randconfig-i093-20230515/clang-14/b1081024bc6d1cdaf5b39994b19040cd8e6099ec/vmlinuz-6.4.0-rc1-00004-gb1081024bc6d
branch=linux-devel/devel-hourly-20230515-172405
job=/lkp/jobs/scheduled/vm-meta-282/boot-1-debian-11.1-i386-20220923.cgz-b1081024bc6d1cdaf5b39994b19040cd8e6099ec-20230518-1210101-12etdcy-0.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-i093-20230515
commit=b1081024bc6d1cdaf5b39994b19040cd8e6099ec
initcall_debug
mem=4G
nmi_watchdog=0
vmalloc=256M initramfs_async=0 page_owner=on
max_uptime=600
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/i386-randconfig-i093-20230515/clang-14/b1081024bc6d1cdaf5b39994b19040cd8e6099ec/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/jobs/scheduled/vm-meta-282/boot-1-debian-11.1-i386-20220923.cgz-b1081024bc6d1cdaf5b39994b19040cd8e6099ec-20230518-1210101-12etdcy-0.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--3Jp55kb4egPYDP7E
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
C9Kf3BCxxGf7AgAAAAAEWVo=

--3Jp55kb4egPYDP7E--
