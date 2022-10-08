Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C4F5F8436
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJHIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 04:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJHIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:12:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780DE285
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 01:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665216758; x=1696752758;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=udEpxP2GIjhm91UhL4h5wsyL0UnNR8UwdOzE017lKiM=;
  b=QEebVvC3CwwEdWZyu8UKClEdAl62hDjaziRF5EHyxE51+F+8XIw5/zM8
   WR6lL1C6N/HQui+99dwy7qdtwchmhm9uGKgsNvXKGnzx2wGe3Ael0TNDc
   1E8nQqljV1Qv7r6eX2HG6XQkX91X/J3oQoikFSV3ENwqzqzjsFyU/iewQ
   +7p6SvQCBMV9UbJoo68DGg+5UZr/Et3nJOAO+9k9VDLblusRytlCIx4bk
   9vHYVOeoatzsqJij1wbDe2adR7TVOqNdsLmF0gNXG9Tw6i/l4YVioro9A
   /5nsYeYIjI/gxSw786oSAB9NfjM5OeH2j1Wjprm/Ja/8y7vpx6beOrZ/c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="365861098"
X-IronPort-AV: E=Sophos;i="5.95,169,1661842800"; 
   d="xz'?scan'208";a="365861098"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 01:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="576504280"
X-IronPort-AV: E=Sophos;i="5.95,169,1661842800"; 
   d="xz'?scan'208";a="576504280"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 08 Oct 2022 01:12:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 01:12:36 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 01:12:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 8 Oct 2022 01:12:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 8 Oct 2022 01:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDePRpOVuRnaD/lQphw9wkkaDA0SkSqEUROh0zOnWUXP6n7fCvugOPyXXIwkxppVQ41gydq6g5YfHSommu+SSddkUFeLPjJgCm1gDCFzwe6C8n4IgaHoKLb8ysDblbXCoArwOzddFKENtu7vRu5ULaJL0JKtLoeHTxMM1GPJvw0fmYhiG1LBkH8ZL5Lep9Va0vtekvc+j0fDACFPra6Tay7HHRYzcEEfzi7Iuj6polUrGWB1CTwgo0wOMY98kRAhuq9zm3agOjV7Muay1y+NPtYrXn2AgQRO3FHDsN+Bq02ORntNmymQ8km5VbLaiM4Kx34DCUnGVTGTMfkRAq1D4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQn7DdCTQ9kZP647LzmIhBjkLe5YEXi53//i1P8YnY8=;
 b=NFomAx+WOW8GVjg8DasusOqR5qSQ5QqcK73bKjb41kn74ghNr7w7JiNw0JKN63CukEj/R2rQg6f6Ps63zNaMsToNMhCnOXUqqj09B1wDpk6+0+HLmZe7BDqhDCYyGedwXf2PF8ppJuLOxktQa0pLknDC9CoyusLtW4KkuvnEpH4E45GwI3s/wtWEzyZYScnKNMoEVJojB5JWtO2JaStTkNuTAHm46OvuGqWBLLLmAII1szLpHXIz3y3aekTAzKWFUMKN7IkrdjLejNdj+ySySrc4Fr8Ri2jgzCstHf+2gXrjY6Q2rneRZCOuEy5WLqRK/SY0u8jpAC5JLWSnNzNF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) by
 BL3PR11MB6460.namprd11.prod.outlook.com (2603:10b6:208:3bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Sat, 8 Oct
 2022 08:12:31 +0000
Received: from DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::3a1b:7b6b:aded:fbfc]) by DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::3a1b:7b6b:aded:fbfc%5]) with mapi id 15.20.5654.025; Sat, 8 Oct 2022
 08:12:31 +0000
Date:   Sat, 8 Oct 2022 16:10:56 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     <lkp@lists.01.org>, <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        <linux-kernel@vger.kernel.org>,
        <aliyunlinux2-dev@linux.alibaba.com>, <jane.lv@intel.com>
Subject: [random] 1f9cc6d2c6: BUG:soft_lockup-CPU##stuck_for#s![trinity-c1:#]
Message-ID: <202210081508.e66dd4e0-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="2Q0v4TIw/8RGD73A"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:3:18::23) To DS0PR11MB6397.namprd11.prod.outlook.com
 (2603:10b6:8:ca::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6397:EE_|BL3PR11MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: e816f5c7-2b43-4a1d-ae40-08daa904d888
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQFwALkejEnNr/6sjBDm3ApWg2wHsUulJ6SS+BAeNzrl6UZbyCGBFfW1VAwndMvfBJ/A1yIHaohpaJVZ3UwkZKy3WYUZ37osbsma+09UAXut/N6170AoITF5Hwow2I7VY5qaf+O7wwy8++o8UfiqlkEzdigsZTv5sOO/TD3XUGeEree+Jbs5IGwNSXObXwVe+6dsSjQiqTJagb3XE8kF+uiA+X6+h9BhjXzHwAORkN2TpD5dn2SXOrMPGVku4uCDnRI2fyM6HO+2ReXZsyOAYHfsgV56pHmTCoXf/KlwEfcPp51FY4gbB1Cq3tFdWT9zPTju3zIvKBxDDi8juaawClYTfyv/fKRyuqutCv/rDYEs60HCPMJmpW8Baa/VNd/FqoeTG4nvgcY1BwDzAEIGDQduDamCVnwwqhtgKuItsHNAmcfqR7ln4LzH1pL54iS/Xf5BsViFGB+3uCY2WdA32G3lbR29BO33nhLRbKiuwRW7+hIfSuRHBVATlX9123xWScb+wsLBa1oCoD7UPDeWKwewozf700MIqCBpRFKsVP6THhnFf1uRWuRRrDaMWhmvb18E7SCpWH5W6FeCbu10LaW8ktl5T09ZlGHyH5napWeSMtET0biWR6ZP8ZCpXFpFH1tTWbGHsVEHdpl1BCguhashbMiWfwInSA4agd2Du7y3zO2HnYqqyooL3bVd2E3y8jE9mR5DljMJ7QlWE1i1UKbU+Bc4Ttq6Rw2AWdUt5mqJYF0SoBomTT/2JWMTliCReWmEo0zswQkzRi6cxaavJzixrawBZQdfavGhra7litnFTnG+k3xWuKf0TOjPUH7YdnpDOLXny+cJ1YS3X2YZ9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6397.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(8676002)(83380400001)(66476007)(4326008)(2616005)(66556008)(8936002)(26005)(6512007)(6666004)(2906002)(54906003)(107886003)(36756003)(186003)(66946007)(45080400002)(6916009)(1076003)(6486002)(86362001)(82960400001)(235185007)(44144004)(6506007)(41300700001)(316002)(38100700002)(478600001)(5660300002)(966005)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OSBoHkD9rb/KdsjtJwQyQv65v+LX0Ii0Aapha9+BH5ZBVskvL4eCcv84yRAr?=
 =?us-ascii?Q?5rqfvkqRRALhNvnjhKPQjDCa8mWh7x3iA3gkCUHI024+nW/vfBidVv23H90R?=
 =?us-ascii?Q?J1E4QMABJc8/OZgtUuQ4zGjwOxLE4+ga4hMdVNlmqCXrw/H/rzgk0qREfg45?=
 =?us-ascii?Q?l4M0OxAoWseXSqkbXly90SHxfSBqbm77THLQLj9cMR2OzEXFuEhBTMrgg4n8?=
 =?us-ascii?Q?7a5urNl4I5YQ2FqRLsO6s8svZKb4u9YQYmReHuuMDKwGxY9upllv6DFPd00a?=
 =?us-ascii?Q?TOYI51s7aKo9PLEB4fZepzxxABeTGWez6RsFfaJhKLwYs9owVhTxLBBAq0TO?=
 =?us-ascii?Q?4/gxxFj7wkyTvwlxZ05HpL4cHpppw1QZ30YQdLcgHSGzGR3wSO4NJ2tcioco?=
 =?us-ascii?Q?dD9MIGdxlrloi8x+xHw6Gfx5fHuFMJzjwLHxIag9k+A7whesXkm3avHqqwyi?=
 =?us-ascii?Q?P6mzJzVsAgZYc5AU7wIR832fOOXMygHC+/vEjRk5JNSu8GO4MWXp478x3Ked?=
 =?us-ascii?Q?O8k/qmn+aUdTGY2jQGCR8yTZFCMPS9Fc72Jz7N5Q5mLOzrOP08XEJFw9+KHw?=
 =?us-ascii?Q?AwzkE9ESfzP/Imnn37lxSXre2JD6hzbZQH328xXts7trTYc9qmKEfUR3+aZm?=
 =?us-ascii?Q?RD3sbxgB9YrOXEWa1ApRtB7xWBdoNB20x/ld+sBYrRYVNsBYlu2NIiyeLrzl?=
 =?us-ascii?Q?1VMO/5+h04SefHbjnuV34L6l+L7VpjY1+UT8Klq4tePwtJ/V0jBaE0oWR3Rr?=
 =?us-ascii?Q?7SmEFqv6XGKtOdvHFM7gJcmwHnNSQmxPBa0g7gpP1DdUlXRoYUd2HKCqZEjf?=
 =?us-ascii?Q?9hETJS7xNqaeE2QgXiLBUV2UJ4f9QGWMT37OOQUXk9CLLoTCwvo41lz303xZ?=
 =?us-ascii?Q?j5tfbOomjlrX1tCmyGPWgPIVP192z/hd2mQolNm6KX+KBLhC1sRfersShPL9?=
 =?us-ascii?Q?4ai8qhG8xZpe/SzMCgnaiTeCGwLpRepyktxEUNxhz+FWqBnHCzFYryrWEvHZ?=
 =?us-ascii?Q?m6BYWjc6r32J3AKUeBNtsf1rOo9hjDaW/aohDVPhm9S8CoDgUwWlaH9y2EGd?=
 =?us-ascii?Q?xjmf2lx7lx7bfuF3x8+7F4j2dcFx7okpkfDY3hfQaIh+v9geMI1fkK5+ZaJI?=
 =?us-ascii?Q?esbRDqZGuunoTd+sXqDHMKWG6amtJdh2nh9dbDrIZ31n7e1N8qYwve4Kc2fS?=
 =?us-ascii?Q?qVXq2XXKwfBXwKAgQCsZebMSH3j7dgQUOV5a5uo/P4CIhxALavLUGoxfSb0S?=
 =?us-ascii?Q?EX/auRkVi8RX9TwHseVo/tPqWgtJDtBWXTw5MQk6XjkBNRYAeANYGlIJ0+Jw?=
 =?us-ascii?Q?mLkz7hCpmBg8TYcpLSakKJyAmhn0ENXWEWgxTdmK1oMJDi+vbOFTR9rleOFK?=
 =?us-ascii?Q?H+v0x+/Twz4xZldEZhmJAgA/iyzPYkSiFM3q27J6hVX6mXIVj1zq1DEb0g15?=
 =?us-ascii?Q?ndcPSgn83EUG+VRAXOFb4WGUe0yfoWLeYwaANtkTaub0yXlraCPrGi7R+7RH?=
 =?us-ascii?Q?t//pCjsIgVRnRg8Qpg8gAGsreNr2gzVy3PSy4Zl+0YAazSWRJb4sB6SkUR8I?=
 =?us-ascii?Q?FKPzvNATuVYeD+DIR6An1Svf60qHALNdmc6Du/LZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e816f5c7-2b43-4a1d-ae40-08daa904d888
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6397.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 08:12:31.1345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQG/3WHIRRNsmuKG43HnikXU/ha6roCsGX1BII8JeDUivGTzWtAKy30vWPNhOH3dmLw3uoNmwTQLB24EoHxTGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6460
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2Q0v4TIw/8RGD73A
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: 1f9cc6d2c6076297d7b0daf87870a5c86385418f ("random: absorb fast pool into input pool after fast load")
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y

in testcase: trinity
version: trinity-i386-4d2343bd-1_20200320
with following parameters:

	runtime: 300s
	group: group-04

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


[  162.171609] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [trinity-c1:3658]
[  162.172501] Modules linked in: aesni_intel aes_i586 evdev button
[  162.173166] irq event stamp: 6681002
[  162.173603] hardirqs last enabled at (6681001): trace_hardirqs_on_thunk (??:?) 
[  162.174671] hardirqs last disabled at (6681002): trace_hardirqs_off_thunk (??:?) 
[  162.175746] softirqs last enabled at (6670980): __do_softirq (??:?) 
[  162.176711] softirqs last disabled at (6670967): call_on_stack (irq_32.c:?) 
[  162.177619] CPU: 1 PID: 3658 Comm: trinity-c1 Not tainted 4.19.248-00087-g1f9cc6d2c607 #1
[  162.178493] EIP: chacha20_block (??:?) 
[ 162.178997] Code: 8b 15 2c d9 d2 c3 83 c0 0b 89 85 50 ff ff ff 83 d2 00 89 8d 7c ff ff ff 8b 8d 70 ff ff ff 89 95 54 ff ff ff 8d b6 00 00 00 00 <8b> b5 7c ff ff ff 8b 85 4c ff ff ff 03 45 80 8b 95 78 ff ff ff 89
All code
========
   0:	8b 15 2c d9 d2 c3    	mov    -0x3c2d26d4(%rip),%edx        # 0xffffffffc3d2d932
   6:	83 c0 0b             	add    $0xb,%eax
   9:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%rbp)
   f:	83 d2 00             	adc    $0x0,%edx
  12:	89 8d 7c ff ff ff    	mov    %ecx,-0x84(%rbp)
  18:	8b 8d 70 ff ff ff    	mov    -0x90(%rbp),%ecx
  1e:	89 95 54 ff ff ff    	mov    %edx,-0xac(%rbp)
  24:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  2a:*	8b b5 7c ff ff ff    	mov    -0x84(%rbp),%esi		<-- trapping instruction
  30:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  36:	03 45 80             	add    -0x80(%rbp),%eax
  39:	8b 95 78 ff ff ff    	mov    -0x88(%rbp),%edx
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	8b b5 7c ff ff ff    	mov    -0x84(%rbp),%esi
   6:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
   c:	03 45 80             	add    -0x80(%rbp),%eax
   f:	8b 95 78 ff ff ff    	mov    -0x88(%rbp),%edx
  15:	89                   	.byte 0x89
[  162.181073] EAX: 6427fd2b EBX: 1e5e39aa ECX: e5af2b96 EDX: 00000000
[  162.181842] ESI: 4be2a3de EDI: 72a99bc6 EBP: ec861ea8 ESP: ec861dec
[  162.182594] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000206
[  162.183438] CR0: 80050033 CR2: 00000001 CR3: 2c862000 CR4: 000406f0
[  162.184229] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  162.184994] DR6: fffe0ff0 DR7: 00000400
[  162.185481] Call Trace:
[  162.185811] get_random_bytes_user (random.c:?) 
[  162.186367] urandom_read_nowarn+0x2a/0x2c0 
[  162.187023] ? do_int80_syscall_32 (??:?) 
[  162.187598] sys_getrandom (??:?) 
[  162.188059] do_int80_syscall_32 (??:?) 
[  162.188613] entry_INT80_32 (entry_32.o:?) 
[  162.189063] EIP: 0xb7fbca02
[ 162.189428] Code: 95 01 00 05 25 36 02 00 83 ec 14 8d 80 e8 99 ff ff 50 6a 02 e8 1f ff 00 00 c7 04 24 7f 00 00 00 e8 7e 87 01 00 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 1c 24 c3 8d b6 00 00
All code
========
   0:	95                   	xchg   %eax,%ebp
   1:	01 00                	add    %eax,(%rax)
   3:	05 25 36 02 00       	add    $0x23625,%eax
   8:	83 ec 14             	sub    $0x14,%esp
   b:	8d 80 e8 99 ff ff    	lea    -0x6618(%rax),%eax
  11:	50                   	push   %rax
  12:	6a 02                	pushq  $0x2
  14:	e8 1f ff 00 00       	callq  0xff38
  19:	c7 04 24 7f 00 00 00 	movl   $0x7f,(%rsp)
  20:	e8 7e 87 01 00       	callq  0x187a3
  25:	66 90                	xchg   %ax,%ax
  27:	90                   	nop
  28:	cd 80                	int    $0x80
  2a:*	c3                   	retq   		<-- trapping instruction
  2b:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  31:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	retq   
  3c:	8d                   	.byte 0x8d
  3d:	b6 00                	mov    $0x0,%dh
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	retq   
   1:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   7:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	retq   
  12:	8d                   	.byte 0x8d
  13:	b6 00                	mov    $0x0,%dh
	...
[  162.191402] EAX: ffffffda EBX: b7039000 ECX: 0007b000 EDX: 00000000
[  162.192085] ESI: 000000c7 EDI: fffffff6 EBP: 2a2a2a2a ESP: bf87d688
[  162.192818] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[  162.193613] Kernel panic - not syncing: softlockup: hung tasks
[  162.194257] CPU: 1 PID: 3658 Comm: trinity-c1 Tainted: G             L    4.19.248-00087-g1f9cc6d2c607 #1
[  162.195377] Call Trace:
[  162.195624] dump_stack (??:?) 
[  162.196007] panic (??:?) 
[  162.196377] watchdog_timer_fn.cold (watchdog.c:?) 
[  162.196878] __run_hrtimer (hrtimer.c:?) 
[  162.197329] ? softlockup_fn (watchdog.c:?) 
[  162.197714] __hrtimer_run_queues (hrtimer.c:?) 
[  162.198113] hrtimer_run_queues (??:?) 
[  162.198567] run_local_timers (??:?) 
[  162.198960] update_process_times (??:?) 
[  162.199471] tick_sched_handle (tick-sched.c:?) 
[  162.199928] tick_nohz_handler (tick-sched.c:?) 
[  162.200311] smp_apic_timer_interrupt (??:?) 
[  162.200889] apic_timer_interrupt (??:?) 
[  162.201396] EIP: chacha20_block (??:?) 
[ 162.201874] Code: 8b 15 2c d9 d2 c3 83 c0 0b 89 85 50 ff ff ff 83 d2 00 89 8d 7c ff ff ff 8b 8d 70 ff ff ff 89 95 54 ff ff ff 8d b6 00 00 00 00 <8b> b5 7c ff ff ff 8b 85 4c ff ff ff 03 45 80 8b 95 78 ff ff ff 89
All code
========
   0:	8b 15 2c d9 d2 c3    	mov    -0x3c2d26d4(%rip),%edx        # 0xffffffffc3d2d932
   6:	83 c0 0b             	add    $0xb,%eax
   9:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%rbp)
   f:	83 d2 00             	adc    $0x0,%edx
  12:	89 8d 7c ff ff ff    	mov    %ecx,-0x84(%rbp)
  18:	8b 8d 70 ff ff ff    	mov    -0x90(%rbp),%ecx
  1e:	89 95 54 ff ff ff    	mov    %edx,-0xac(%rbp)
  24:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  2a:*	8b b5 7c ff ff ff    	mov    -0x84(%rbp),%esi		<-- trapping instruction
  30:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
  36:	03 45 80             	add    -0x80(%rbp),%eax
  39:	8b 95 78 ff ff ff    	mov    -0x88(%rbp),%edx
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	8b b5 7c ff ff ff    	mov    -0x84(%rbp),%esi
   6:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
   c:	03 45 80             	add    -0x80(%rbp),%eax
   f:	8b 95 78 ff ff ff    	mov    -0x88(%rbp),%edx
  15:	89                   	.byte 0x89


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/r/202210081508.e66dd4e0-yujie.liu@intel.com


To reproduce:

        # build kernel
	cd linux
	cp config-4.19.248-00087-g1f9cc6d2c607 .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.


-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--2Q0v4TIw/8RGD73A
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-4.19.248-00087-g1f9cc6d2c607"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.19.248 Kernel Configuration
#

#
# Compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
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
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_INTEL_RDT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
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
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
# CONFIG_X86_MCE_INTEL is not set
# CONFIG_X86_ANCIENT_MCE is not set
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_HIGHPTE=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
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
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
# CONFIG_ACPI_AC is not set
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=m
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_EINJ=y
CONFIG_ACPI_APEI_ERST_DEBUG=m
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_PMIC_OPREGION=y
# CONFIG_XPOWER_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set
CONFIG_X86_APM_BOOT=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
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
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_POWERNOW_K6=y
# CONFIG_X86_POWERNOW_K7 is not set
CONFIG_X86_POWERNOW_K8=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=m
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
CONFIG_X86_LONGRUN=y
CONFIG_X86_LONGHAUL=y
CONFIG_X86_E_POWERSAVER=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_SCx200 is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_4_7=y
CONFIG_PLUGIN_HOSTCC=""
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
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
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
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
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
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
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETLABEL is not set
# CONFIG_NETWORK_SECMARK is not set
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
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
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
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
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
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_FAILOVER=m
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
# CONFIG_SIMPLE_PM_BUS is not set
# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_OF_PARTS=m
CONFIG_MTD_AR7_PARTS=m

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=m
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=m
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=m
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_PCMCIA is not set
# CONFIG_MTD_GPIO_ADDR is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# CONFIG_MTD_LATCH_ADDR is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=m
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
CONFIG_MTD_DATAFLASH_OTP=y
# CONFIG_MTD_M25P80 is not set
CONFIG_MTD_MCHP23K256=m
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=m
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_NAND_CORE=m
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set
CONFIG_MTD_SPI_NAND=m

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
CONFIG_MTD_SPI_NOR=m
# CONFIG_MTD_MT81xx_NOR is not set
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
# CONFIG_SPI_INTEL_SPI_PCI is not set
# CONFIG_SPI_INTEL_SPI_PLATFORM is not set
# CONFIG_MTD_UBI is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_LATTICE_ECP3_CONFIG=y
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_ECHO is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
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
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_JME is not set
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
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
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
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
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
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
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
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
# CONFIG_JOYSTICK_IFORCE_USB is not set
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=m
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
CONFIG_JOYSTICK_DB9=y
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=y
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_JOYSTICK_XPAD=y
# CONFIG_JOYSTICK_XPAD_FF is not set
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_PSXPAD_SPI=y
# CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
CONFIG_JOYSTICK_PXRC=y
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_ADS7846=y
# CONFIG_TOUCHSCREEN_AD7877 is not set
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
CONFIG_TOUCHSCREEN_ADC=m
CONFIG_TOUCHSCREEN_AR1021_I2C=m
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
# CONFIG_TOUCHSCREEN_BU21013 is not set
CONFIG_TOUCHSCREEN_BU21029=m
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=m
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
CONFIG_TOUCHSCREEN_DA9034=m
CONFIG_TOUCHSCREEN_DA9052=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=m
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=y
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
# CONFIG_TOUCHSCREEN_MTOUCH is not set
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
CONFIG_TOUCHSCREEN_INEXIO=m
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=m
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM831X is not set
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
CONFIG_TOUCHSCREEN_MC13783=y
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
# CONFIG_TOUCHSCREEN_USB_3M is not set
# CONFIG_TOUCHSCREEN_USB_ITM is not set
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
# CONFIG_TOUCHSCREEN_USB_DMC_TSC10 is not set
# CONFIG_TOUCHSCREEN_USB_IRTOUCH is not set
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
# CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH is not set
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
# CONFIG_TOUCHSCREEN_USB_ELO is not set
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
# CONFIG_TOUCHSCREEN_USB_ETT_TC45USB is not set
CONFIG_TOUCHSCREEN_USB_NEXIO=y
# CONFIG_TOUCHSCREEN_USB_EASYTOUCH is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=m
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
CONFIG_TOUCHSCREEN_RM_TS=m
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
CONFIG_TOUCHSCREEN_SX8654=y
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_COLIBRI_VF50=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_LDISC_AUTOLOAD is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DMA is not set
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_CS=m
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DW=m
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
CONFIG_SERIAL_OF_PLATFORM=m

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=m
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_SC16IS7XX_SPI=y
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
# CONFIG_SERIAL_XILINX_PS_UART_CONSOLE is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=m
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_DEV_BUS=m
CONFIG_TTY_PRINTK=y
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=y
# CONFIG_IPMI_POWEROFF is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=m
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=m
CONFIG_I2C_MUX_MLXCPLD=m
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=m

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
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA is not set
CONFIG_I2C_RK3X=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_DLN2=m
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_FSI=y
CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=m
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_DLN2=m
CONFIG_SPI_GPIO=y
CONFIG_SPI_LM70_LLP=y
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=m
# CONFIG_SPI_TOPCLIFF_PCH is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
# CONFIG_SPI_SLAVE_TIME is not set
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=m
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AXP209=m
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_LEWISBURG=m
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=m
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_SYSCON is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=m

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_LP87565=m
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_TWL6040=m
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8350=m

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
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=m
CONFIG_GPIO_XRA1403=m

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
CONFIG_W1=m

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=m
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=m
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=m
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=m
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_SBS=m
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9030=y
# CONFIG_BATTERY_DA9052 is not set
CONFIG_CHARGER_DA9150=m
CONFIG_BATTERY_DA9150=y
CONFIG_CHARGER_AXP20X=m
# CONFIG_BATTERY_AXP20X is not set
CONFIG_AXP20X_POWER=m
# CONFIG_AXP288_FUEL_GAUGE is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_BATTERY_TWL4030_MADC is not set
CONFIG_BATTERY_RX51=m
CONFIG_CHARGER_ISP1704=m
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_LP8788=m
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LTC3651 is not set
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=m
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_QCOM_SPMI_TEMP_ALARM is not set
CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_DA9052_WATCHDOG=m
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=m
CONFIG_MENZ069_WATCHDOG=m
CONFIG_WDAT_WDT=y
CONFIG_WM831X_WATCHDOG=m
CONFIG_WM8350_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_RAVE_SP_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=m
# CONFIG_DW_WATCHDOG is not set
CONFIG_RN5T618_WATCHDOG=m
CONFIG_TWL4030_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_RETU_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=m
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=m
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=m
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=m
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=m
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_NI903X_WDT=y
CONFIG_NIC7018_WDT=y
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=m
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=m
CONFIG_MFD_ATMEL_HLCDC=y
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=m
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=m
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=m
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_VIPERBOARD=m
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=m
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=m
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=m
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_ARIZONA_SPI=m
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_RAVE_SP_CORE=m
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_88PM800 is not set
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=m
# CONFIG_REGULATOR_ANATOP is not set
# CONFIG_REGULATOR_AS3722 is not set
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BD718XX=m
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9055=m
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=m
CONFIG_REGULATOR_HI6421V530=m
CONFIG_REGULATOR_ISL9305=m
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LP3971=m
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=y
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=m
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8997 is not set
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_RC5T583 is not set
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=m
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65218=m
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_TWL4030=y
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=m
CONFIG_REGULATOR_WM8350=y
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=m
CONFIG_DRM_VKMS=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_RCAR_DW_HDMI=m
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=m
CONFIG_DRM_PANEL_ILITEK_IL9322=m
# CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
CONFIG_DRM_PANEL_LG_LG4573=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_DUMB_VGA_DAC is not set
# CONFIG_DRM_LVDS_ENCODER is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
CONFIG_DRM_NXP_PTN3460=m
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
# CONFIG_DRM_SII9234 is not set
# CONFIG_DRM_THINE_THC63LVD1024 is not set
CONFIG_DRM_TOSHIBA_TC358767=m
CONFIG_DRM_TI_TFP410=m
# CONFIG_DRM_I2C_ADV7511 is not set
CONFIG_DRM_DW_HDMI=m
CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
CONFIG_DRM_DW_HDMI_CEC=m
CONFIG_DRM_ARCPGU=m
# CONFIG_DRM_HISI_HIBMC is not set
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=m
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
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
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_RAWMIDI=m
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
# CONFIG_SND_VERBOSE_PROCFS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_MTPAV=m
CONFIG_SND_MTS64=m
CONFIG_SND_SERIAL_U16550=m
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PORTMAN2X4=m
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
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_SPI=y
# CONFIG_SND_USB is not set
# CONFIG_SND_PCMCIA is not set
# CONFIG_SND_SOC is not set
# CONFIG_SND_X86 is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELAN=m
# CONFIG_HID_ELECOM is not set
CONFIG_HID_ELO=m
CONFIG_HID_EZKEY=m
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GOOGLE_HAMMER is not set
CONFIG_HID_GT683R=m
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=m
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=m
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=y
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WACOM=m
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=y

#
# USB HID support
#
CONFIG_USB_HID=m
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
# CONFIG_USB_MOUSE is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_OTG_FSM=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
# CONFIG_USB_MON is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
# CONFIG_USB_SL811_CS is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
# CONFIG_USB_DWC3_OF_SIMPLE is not set
CONFIG_USB_DWC2=m
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=y
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_OF=m
CONFIG_USB_CHIPIDEA_PCI=m
# CONFIG_USB_CHIPIDEA_UDC is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=m
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
# CONFIG_USB_SERIAL_EDGEPORT is not set
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=m
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_METRO=m
CONFIG_USB_SERIAL_MOS7720=m
# CONFIG_USB_SERIAL_MOS7715_PARPORT is not set
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=m
# CONFIG_USB_SERIAL_PL2303 is not set
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
# CONFIG_USB_SERIAL_SYMBOL is not set
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
# CONFIG_USB_SERIAL_XIRCOM is not set
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
# CONFIG_USB_SERIAL_OMNINET is not set
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=m
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
CONFIG_USB_ISP1301=y
CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_U_SERIAL_CONSOLE=y

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=m
CONFIG_USB_GR_UDC=m
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
CONFIG_USB_MV_U3D=m
# CONFIG_USB_SNP_UDC_PLAT is not set
CONFIG_USB_M66592=m
CONFIG_USB_BDC_UDC=m

#
# Platform Support
#
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=m
CONFIG_USB_DUMMY_HCD=m
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_ACM=m
CONFIG_USB_U_SERIAL=m
CONFIG_USB_F_SERIAL=m
CONFIG_USB_F_OBEX=m
CONFIG_USB_F_MIDI=m
CONFIG_USB_F_HID=m
CONFIG_USB_F_PRINTER=m
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=m
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_G_SERIAL=m
CONFIG_USB_MIDI_GADGET=m
CONFIG_USB_G_PRINTER=m
# CONFIG_USB_CDC_COMPOSITE is not set
CONFIG_USB_G_HID=m
# CONFIG_USB_G_DBGP is not set
# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=m
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
# CONFIG_UWB is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_BCM6328=m
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CR0014114 is not set
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3533=m
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=m
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8788=m
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_WM8350 is not set
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_DAC124S085=m
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX77693=m
# CONFIG_LEDS_MAX8997 is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_KTD2692=y
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_GHES is not set
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=m
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
# CONFIG_DW_AXI_DMAC is not set
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_PCH_DMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
# CONFIG_CFAG12864B is not set
CONFIG_IMG_ASCII_LCD=m
# CONFIG_HT16K33 is not set
CONFIG_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD=y
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
CONFIG_COMEDI=m
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=m
CONFIG_COMEDI_SSV_DNP=m
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=m
# CONFIG_COMEDI_CB_DAS16_CS is not set
CONFIG_COMEDI_DAS08_CS=m
CONFIG_COMEDI_NI_DAQ_700_CS=m
# CONFIG_COMEDI_NI_DAQ_DIO24_CS is not set
CONFIG_COMEDI_NI_LABPC_CS=m
CONFIG_COMEDI_NI_MIO_CS=m
CONFIG_COMEDI_QUATECH_DAQP_CS=m
CONFIG_COMEDI_USB_DRIVERS=m
# CONFIG_COMEDI_DT9812 is not set
# CONFIG_COMEDI_NI_USB6501 is not set
# CONFIG_COMEDI_USBDUX is not set
# CONFIG_COMEDI_USBDUXFAST is not set
CONFIG_COMEDI_USBDUXSIGMA=m
CONFIG_COMEDI_VMK80XX=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_TIO=m
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=m
CONFIG_ADIS16240=m

#
# Analog to digital converters
#
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD7606_IFACE_SPI=m
# CONFIG_AD7780 is not set
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
CONFIG_AD7280=m

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
# CONFIG_ADT7316_SPI is not set
CONFIG_ADT7316_I2C=m

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7152 is not set
# CONFIG_AD7746 is not set

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
CONFIG_AD9834=m

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Active energy metering IC
#
CONFIG_ADE7854=m
CONFIG_ADE7854_I2C=m
CONFIG_ADE7854_SPI=m

#
# Resolver to digital converters
#
CONFIG_AD2S90=m
CONFIG_AD2S1210=m
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y

#
# Android
#
CONFIG_STAGING_BOARD=y
# CONFIG_LTE_GDM724X is not set
# CONFIG_DGNC is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_FB_TFT is not set
CONFIG_MOST=m
CONFIG_MOST_CDEV=m
# CONFIG_MOST_NET is not set
# CONFIG_MOST_SOUND is not set
CONFIG_MOST_DIM2=m
CONFIG_MOST_I2C=m
# CONFIG_MOST_USB is not set
CONFIG_GREYBUS=m
CONFIG_GREYBUS_ES2=m
# CONFIG_GREYBUS_AUDIO is not set
CONFIG_GREYBUS_BOOTROM=m
CONFIG_GREYBUS_FIRMWARE=m
# CONFIG_GREYBUS_HID is not set
# CONFIG_GREYBUS_LIGHT is not set
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=m
# CONFIG_GREYBUS_VIBRATOR is not set
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
# CONFIG_GREYBUS_I2C is not set
CONFIG_GREYBUS_SPI=m
CONFIG_GREYBUS_UART=m
CONFIG_GREYBUS_USB=m
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_PI433=y

#
# Gasket devices
#
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=m
CONFIG_CHROMEOS_TBMC=m
CONFIG_CROS_KBD_LED_BACKLIGHT=y
CONFIG_MELLANOX_PLATFORM=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
# CONFIG_CLK_HSDK is not set
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_CLK_TWL6040=m
CONFIG_COMMON_CLK_VC5=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=m
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=m
# CONFIG_MAILBOX_TEST is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_QCOM_GLINK_NATIVE=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=m
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=m
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_GPIO=m
CONFIG_EXTCON_INTEL_INT3496=m
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
CONFIG_ADIS16201=m
CONFIG_ADIS16209=m
CONFIG_ADXL345=m
# CONFIG_ADXL345_I2C is not set
CONFIG_ADXL345_SPI=m
CONFIG_BMA180=m
CONFIG_BMA220=m
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=m
# CONFIG_DA311 is not set
CONFIG_DMARD06=m
CONFIG_DMARD09=m
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=m
CONFIG_MXC6255=m
CONFIG_SCA3000=m
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=m

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
CONFIG_AD7266=m
CONFIG_AD7291=m
CONFIG_AD7298=m
CONFIG_AD7476=m
CONFIG_AD7766=m
CONFIG_AD7791=m
# CONFIG_AD7793 is not set
CONFIG_AD7887=m
CONFIG_AD7923=m
CONFIG_AD799X=m
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
CONFIG_CC10001_ADC=m
CONFIG_DA9150_GPADC=m
CONFIG_DLN2_ADC=m
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_HI8435=m
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=m
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
CONFIG_MAX1118=m
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=m
CONFIG_MCP3422=m
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
CONFIG_QCOM_SPMI_IADC=m
# CONFIG_QCOM_SPMI_VADC is not set
CONFIG_SD_ADC_MODULATOR=m
CONFIG_STX104=m
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=m
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=m
CONFIG_TI_ADC108S102=m
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=m
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS7950=m
CONFIG_TI_ADS8688=m
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=m
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=m
CONFIG_VF610_ADC=m
# CONFIG_VIPERBOARD_ADC is not set

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=m

#
# Amplifiers
#
# CONFIG_AD8366 is not set

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_BME680 is not set
CONFIG_CCS811=m
CONFIG_IAQCORE=m
CONFIG_VZ89X=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=m
CONFIG_IIO_SSP_SENSORHUB=m
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#
CONFIG_104_QUAD_8=m

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
# CONFIG_AD5593R is not set
CONFIG_AD5504=m
CONFIG_AD5624R_SPI=m
CONFIG_LTC2632=m
CONFIG_AD5686=m
CONFIG_AD5686_SPI=m
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
CONFIG_AD5758=m
CONFIG_AD5761=m
CONFIG_AD5764=m
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
CONFIG_CIO_DAC=m
CONFIG_AD8801=m
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
CONFIG_M62332=m
CONFIG_MAX517=m
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=m
CONFIG_MCP4922=m
# CONFIG_TI_DAC082S085 is not set
CONFIG_TI_DAC5571=m
CONFIG_VF610_DAC=m

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
CONFIG_ADIS16130=m
CONFIG_ADIS16136=m
# CONFIG_ADIS16260 is not set
CONFIG_ADXRS450=m
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
CONFIG_AFE4404=m
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
# CONFIG_HID_SENSOR_HUMIDITY is not set
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BMI160_SPI=m
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_AL3320A=m
CONFIG_APDS9300=m
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
CONFIG_BH1780=m
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
# CONFIG_CM3605 is not set
CONFIG_CM36651=m
CONFIG_GP2AP020A00F=m
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
CONFIG_HID_SENSOR_ALS=m
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=m
# CONFIG_MAX44000 is not set
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=m
CONFIG_SI1133=m
CONFIG_SI1145=m
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
# CONFIG_VEML6070 is not set
CONFIG_VL6180=m
CONFIG_ZOPT2201=m

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_BMC150_MAGN_SPI=m
CONFIG_MAG3110=m
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
CONFIG_SENSORS_HMC5843=m
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_HMC5843_SPI=m

#
# Multiplexers
#
CONFIG_IIO_MUX=m

#
# Inclinometer sensors
#
# CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set

#
# Digital potentiometers
#
CONFIG_AD5272=m
CONFIG_DS1803=m
CONFIG_MAX5481=m
# CONFIG_MAX5487 is not set
CONFIG_MCP4018=m
# CONFIG_MCP4131 is not set
CONFIG_MCP4531=m
CONFIG_TPL0102=m

#
# Digital potentiostats
#
CONFIG_LMP91000=m

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_HP03 is not set
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
CONFIG_MS5611=m
# CONFIG_MS5611_I2C is not set
# CONFIG_MS5611_SPI is not set
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_IIO_ST_PRESS_SPI=m
CONFIG_T5403=m
CONFIG_HP206C=m
# CONFIG_ZPA2326 is not set

#
# Lightning sensors
#
CONFIG_AS3935=m

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
CONFIG_LIDAR_LITE_V2=m
CONFIG_RFD77402=m
# CONFIG_SRF04 is not set
CONFIG_SX9500=m
# CONFIG_SRF08 is not set

#
# Resolver to digital converters
#
CONFIG_AD2S1200=m

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=m
CONFIG_MLX90632=m
# CONFIG_TMP006 is not set
CONFIG_TMP007=m
CONFIG_TSYS01=m
CONFIG_TSYS02D=m
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=m
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_CPCAP_USB=m
CONFIG_PHY_MAPPHONE_MDM6600=m
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_HSIC=m
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_TUSB1210=m
# CONFIG_POWERCAP is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y
CONFIG_RAVE_SP_EEPROM=m

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
# CONFIG_FPGA is not set
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=m
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_SCOM=m
# CONFIG_FSI_SBEFIFO is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
# CONFIG_MUX_ADGS1408 is not set
CONFIG_MUX_GPIO=m
# CONFIG_MUX_MMIO is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=m
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=m
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
# CONFIG_ECRYPT_FS is not set
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
CONFIG_JFFS2_SUMMARY=y
# CONFIG_JFFS2_FS_XATTR is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
# CONFIG_JFFS2_LZO is not set
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_PRIORITY is not set
# CONFIG_JFFS2_CMODE_SIZE is not set
CONFIG_JFFS2_CMODE_FAVOURLZO=y
CONFIG_CRAMFS=m
CONFIG_CRAMFS_MTD=y
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS=m
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=m
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=m
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_YAMA=y
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
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
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=m
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_AES_NI_INTEL=m
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=m
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=m
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=m
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=m
CONFIG_BCH_CONST_PARAMS=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
# CONFIG_STRING_SELFTEST is not set

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
# CONFIG_PAGE_POISONING_ZERO is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
CONFIG_MEMTEST=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
CONFIG_SAMPLES=y
CONFIG_SAMPLE_TRACE_EVENTS=m
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_KOBJECT=m
CONFIG_SAMPLE_HW_BREAKPOINT=m
CONFIG_SAMPLE_KFIFO=m
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
CONFIG_SAMPLE_CONFIGFS=m
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_TEST_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

--2Q0v4TIw/8RGD73A
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='trinity.yaml'
	export testbox='vm-snb'
	export arch='i386'
	export tbox_group='vm-snb'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}'
'\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export queue_cmdline_keys='rootfs'
	export schedule_notify_address=
	export queue='vip'
	export branch='linux-stable-rc/linux-4.19.y'
	export commit='1f9cc6d2c6076297d7b0daf87870a5c86385418f'
	export kconfig='i386-randconfig-a003-20220919'
	export nr_vm=300
	export submit_id='633d3b9b0b9a930d58c1784b'
	export job_file='/lkp/jobs/scheduled/vm-meta-9/trinity-group-04-300s-debian-i386-20191205.cgz-1f9cc6d2c6076297d7b0daf87870a5c86385418f-20221005-3416-3kyf35-46.yaml'
	export id='91a52d75ab14690802993ecbd069063b176455e5'
	export queuer_version='/lkp/yujie/.src-20220930-134742'
	export rootfs='debian-i386-20191205.cgz'
	export enqueue_time='2022-10-05 16:08:59 +0800'
	export compiler='gcc-11'
	export _id='633d3b9c0b9a930d58c17879'
	export _rt='/result/trinity/group-04-300s/vm-snb/debian-i386-20191205.cgz/i386-randconfig-a003-20220919/gcc-11/1f9cc6d2c6076297d7b0daf87870a5c86385418f'
	export user='lkp'
	export meta_host='vm-meta-9'
	export LKP_SERVER='internal-lkp-server'
	export kernel='/pkg/linux/i386-randconfig-a003-20220919/gcc-11/1f9cc6d2c6076297d7b0daf87870a5c86385418f/vmlinuz-4.19.248-00087-g1f9cc6d2c607'
	export result_root='/result/trinity/group-04-300s/vm-snb/debian-i386-20191205.cgz/i386-randconfig-a003-20220919/gcc-11/1f9cc6d2c6076297d7b0daf87870a5c86385418f/21'
	export dequeue_time='2022-10-05 16:09:58 +0800'
	export scheduler_version='/lkp/lkp/.src-20221001-230515'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-i386-20191205.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/group-04-300s/vm-snb/debian-i386-20191205.cgz/i386-randconfig-a003-20220919/gcc-11/1f9cc6d2c6076297d7b0daf87870a5c86385418f/21
BOOT_IMAGE=/pkg/linux/i386-randconfig-a003-20220919/gcc-11/1f9cc6d2c6076297d7b0daf87870a5c86385418f/vmlinuz-4.19.248-00087-g1f9cc6d2c607
branch=linux-stable-rc/linux-4.19.y
job=/lkp/jobs/scheduled/vm-meta-9/trinity-group-04-300s-debian-i386-20191205.cgz-1f9cc6d2c6076297d7b0daf87870a5c86385418f-20221005-3416-3kyf35-46.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-a003-20220919
commit=1f9cc6d2c6076297d7b0daf87870a5c86385418f
vmalloc=256M initramfs_async=0 page_owner=on
initcall_debug
max_uptime=2100
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
	export modules_initrd='/pkg/linux/i386-randconfig-a003-20220919/gcc-11/1f9cc6d2c6076297d7b0daf87870a5c86385418f/modules.cgz'
	export bm_initrd='/osimage/deps/debian-i386-20191205.cgz/lkp_20201203.cgz,/osimage/pkg/debian-i386-20191205.cgz/trinity-i386-4d2343bd-1_20200320.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/jobs/scheduled/vm-meta-9/trinity-group-04-300s-debian-i386-20191205.cgz-1f9cc6d2c6076297d7b0daf87870a5c86385418f-20221005-3416-3kyf35-46.cgz'

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

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='group-04' $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--2Q0v4TIw/8RGD73A
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--2Q0v4TIw/8RGD73A--
