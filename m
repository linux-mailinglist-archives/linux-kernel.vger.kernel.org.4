Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C936A65A47E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiLaNFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiLaNEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:04:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD50F01F;
        Sat, 31 Dec 2022 05:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672491875; x=1704027875;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m7OVUJ6Ue4FQ+4DX66lwm6mrSCX6K/cUPNAGGfnRtok=;
  b=bHJJ4jbBh3hRTp7s69cii9jBiKGu+Ut8O1fXUedSXKi/73QjT1ACSIZJ
   uX3uu+WG2Zy0Mb6iUUmAAZNK8dZsyJWeaUVi44vm7J954H4EQidYMbxaq
   WribJuqjs2k567jMuoQarAk+CDpHPsM9bqKTLRMIOcdJxjX74d2lWGwMH
   2nTD5TIebuKNh2vSDLD2EPQUY4cG+W3bLw+V1hOjVh2Xk9YYfmJOU4ODT
   NIZtfsuVJO4sAsfSWt2x0tvEBWliXn4/PKXX3eRTlQqWqN+ctCAwaJDF2
   GmSir4pABP2mpuwcXb5iwVJRhajSvVUOP1HvFw0qgBx6/nquTxMi366sb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="385737241"
X-IronPort-AV: E=Sophos;i="5.96,290,1665471600"; 
   d="xz'?yaml'?scan'208";a="385737241"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2022 05:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="982874642"
X-IronPort-AV: E=Sophos;i="5.96,290,1665471600"; 
   d="xz'?yaml'?scan'208";a="982874642"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 31 Dec 2022 05:04:33 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 31 Dec 2022 05:04:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 31 Dec 2022 05:04:32 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 31 Dec 2022 05:04:32 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 31 Dec 2022 05:04:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BW0ytQO5MvDQ1iXpfnBgoBl9jWjGrPp0oIzBtW10021EKg+K/oZshgKP1r/Nx4zYAOuaTZoiYaE33voDsmGtp0OImxYgWa7jg0fBhKQE297wTEJT8d9zhb+iTx1JrIfy2jCSv9OEKOk6F3+rGYIa0ruGQY5CgwaGKQnJewJ8XOzwxJJrIeqBOqrJL04+vkCwwCfTghJTUWUWuA6lMGPOPT680s5KX5GDqzgM3/QYDsSg7L+ufQy4c+OHJd+aFVxkcuTLWxEYaH2agms7+L6suqajDVl62VfUAC37ncKlpSLWGroyXvhOsezuwylZYirrL9AirPvl3MMnk+kswxNJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cI4wQIveAp66F22EkN97wSTc6tDWnPv564sBx2WT82E=;
 b=bjZ9a0KyNAkuyOtJ4S4S6YMswFfeoOii4xBxNjr+wsEGHsVx9t1NOliRgy7FAVgFaFqM8wa+Ph1WXB+zrw//q0dvYo+oc7lsLC8qmAkj0YCPrNGDgfvO69GAvBiunuGwLH5ktaOZY9PTtirxPjpJXVqD/IFQIzlREq2qHXex1obxqk2B0t9ifKVoZiCebQy37QXmxp9FOfc8GNUyqV4iNlaFy1FppP7h7STFuyyeyP6P02kz6jzq5P5kmiqLWOhYO6rpBvSYNOrjAW9AZGVvXUBsHAyvvS1trFN5yqWg2XtnyyM1xOphD4ImUU8NfRykTkeHNbGYFO86osGyko35vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 13:04:16 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241%9]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 13:04:16 +0000
Date:   Sat, 31 Dec 2022 21:04:06 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Song Liu <song@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>
Subject: [linus:master] [md]  fb541ca4c3:
 WARNING:at_block/bdev.c:#bd_prepare_to_claim
Message-ID: <202212312056.46bc24a0-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="eyIAqbvOPgfHBVn4"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA1PR11MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8128d4-3527-4272-22ff-08daeb2f8525
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MmYvTGQgMjv2V50OabrFUMav0sYEisduR1gEZlDQVBhfX1a6SB/Xu2vLT2QrdSZH4YRg5ezbHwGufC6hAmLNQ6xkAt/LCPlES39sMFsCZafXmFtWUTA3hVFjSwDEOBOMWLVChrlMjKkR4hlgaSJX9WUpbY2e7L/G2haZDlFiTkm8Fw5fOaxEB5bM29b4RO/K+lIh3y1WK0b6cmOD72OfiyIUiaXsFoSZKYKAOmdrsHMvQPT8MoNPdxYnaJPiSnM3eg0anXD7mGweKYE4oENf6gTci4rgLDd4aUa7sLIV1buj43r69SOBW5LMf2yR21zkVILvPAj28ZhiPYfq4n4qJg03okg6hGv1XHDxCjRt+oc7mqzJlCDlE3FH2HbwL7SYaj5C8wTSKpR37kabFDlTAFSh1dMDwkXj/9kddZEIDbWB3dzFy4VePv0h4m1bjmlEqJSj90Xv06nM5trqPQlrfNIO0l/2NayDp62Tmxm6amF3v2NRBFXs7huCenWTvRkE/+I8Vv9RMyS3lDn+uEm4h997u5wJXYyexXPWol6FEJBM5ZF6cWJnhocwrPkRoeZ1Pzq/J5jmDq/icJ9atF70vGK7Zqv4MsslQrp7htSazoibGoJa/9JJnzGlc7uPOIXEswANkfmJzs91oi17RdSEa2z/xghbqJy7dyxfYuj1jP9C8cK10iWOFYow5QVLBxW36QrUyM//FIFJBAW7mJlQXdyrr3td2owdxYqJoX3pdYHWxPyip06Yb2erLg+16fYQ+9nft8WFwpmlr/M1b+OX4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(6916009)(316002)(21490400003)(26005)(186003)(38100700002)(30864003)(5660300002)(235185007)(82960400001)(6506007)(8936002)(44144004)(2616005)(478600001)(1076003)(966005)(6486002)(6666004)(66946007)(45080400002)(86362001)(83380400001)(6512007)(2906002)(41300700001)(66476007)(66556008)(36756003)(4326008)(8676002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CwKTJ51kw3nutcAKQC4ORLPIT5GoJxYg1ednBTSR56ovBmINhcfhZQuHa9au?=
 =?us-ascii?Q?CgvBFlC07JtL86nJDHbYGErif6+S9STyBtJZCdkdt+K3DGuuwQPTWzoyyZLE?=
 =?us-ascii?Q?gSsfBIc2X4KG9tzkR/8Jj/rU7mVQjwNlItjsaysAeBJxGTliqKYr4w3n3aqM?=
 =?us-ascii?Q?10OEUjxRYCdBfOxxlFPekyoouGbpBQG92huu8vXo0wxxZYkgnSoVqU3BA6Kz?=
 =?us-ascii?Q?RoPNVByTlB++29nc4cb+veZvQPmCvgmPhHYakobE3XlaFykjHzGC+RUVI05J?=
 =?us-ascii?Q?6XUN1VowXcn+MAkuh/P4iSELZMiXE/v3euz7Dhx5jluwVYBsmNkORMqO+Rht?=
 =?us-ascii?Q?vsvW7TL/lUhj41lYer9RJh1ZU9NW5AJEiAbHCNY78rwys8TU6Fvvl0Uggo24?=
 =?us-ascii?Q?vruy43+Idq72GENBug+XaR7qpVWNG8QDIhvBWxwsjTZSZr84TBH2ApiyLtMA?=
 =?us-ascii?Q?45fc03nwClVOxGBPDbD6srIJwivSVpmqy3nW16POEJSL+K1qRpjrqi1PzxuI?=
 =?us-ascii?Q?lfkoZOfBQ7K29I1lej9rkJ6bGRRsOU19fyNYlWp7IRJ8ESGHo0wy4nYDA53N?=
 =?us-ascii?Q?IMJrIWj6S64O2nq8pfQXLStl6oca2teZTXO6YQ3fN3z2e0HVhmnltzEUpJ1b?=
 =?us-ascii?Q?k+jw6E6A/RP8Vf/R4QxQTobVQKM5vFo0RkCtn4aW7UwWVtipkRQHL9A2HLQc?=
 =?us-ascii?Q?WGs0FvyVZmkTclA81/iKrS1e2DoRN7FQao4lPflyKWPAcc3hF5JV6P7W0MXL?=
 =?us-ascii?Q?+0Vs1Dpx7vF5o39+JutzTKJohmwPfmye6/VHCnftm3Xb+p3WNro95ktw5chP?=
 =?us-ascii?Q?3N5lfhzFyhx/sZGAk+GOGipJIp+RKLCE4RVufP2NQch8/PRgpU/fdt0MOIhw?=
 =?us-ascii?Q?LfKeMUFbSNYzflmZDblVTzyYgpUvmGEiVYaEpTiKDTHnwO/H//fkbJM5asDw?=
 =?us-ascii?Q?ZIEKuI5QoCaGWbK4qMf3ENI2IzedA41TrUGff5o1EPNWd7JGlci+r40pe4tK?=
 =?us-ascii?Q?SxVmm8N+tjA3giUnJxif0YkJy8bxWzdU4Gl4rb/S6pN6rpWxbECJYFKrcp4F?=
 =?us-ascii?Q?UVGLahuRVA5yVFSy8RBIqjJ9F5FRv+2BabLEhgc1+oPkRduOxP3sUVP3htMD?=
 =?us-ascii?Q?BMR6UObU2Hnw0wvu+uRRUkQS9vFs3d5BWUWj0211eSeOsdDQjL1hfu8hRkKB?=
 =?us-ascii?Q?OJayLBPmO2VyMIHc85kIGa6xpiM5LL3cryTM6lw/n/bCHtu4yQyuyYd0cZhX?=
 =?us-ascii?Q?cbBjoGYcXG6X+XZKgcv+YASlccNCtp2eNUrJG3phT2ohZ7+YO8gBLehbPq/s?=
 =?us-ascii?Q?462ahCexUXUpC/iWakIC2HVbf1FDxr7oTL/xjGBnvQ4JK5jTGEMsLxQnOlO1?=
 =?us-ascii?Q?+Ci2Ai0pZ1BQ8O0mfcy0irQjrGInp1lLmD1YSLgArSTehd4PmVmHD2NC0eAq?=
 =?us-ascii?Q?UUAhDh7VIwu6WRL+cRxZlRXvXicm5m4LuzOxr5ceACGCxHyh67cFLw5Et2H9?=
 =?us-ascii?Q?cTeiYzmW9u7C5RqXyRC6dtRjUgiZNdVXONEhbrontfjKhjbx+HIFHj/sbegR?=
 =?us-ascii?Q?vCQXFSwxHTpDLOLzjtgNqXBV5RbOuXpA1rhm16J0rMagEedF7lhkvFcNOZdE?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8128d4-3527-4272-22ff-08daeb2f8525
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 13:04:16.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5coqHyDV8kz4casSEwuYZGr0cp5ZL6TC6FOn0XO8/Nmau+4Ky4kTT7eunAuUF6dXDSd/S8Bn5UZWu5pDlRCtOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6733
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

--eyIAqbvOPgfHBVn4
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed WARNING:at_block/bdev.c:#bd_prepare_to_claim due to commit (built with gcc-11):

commit: fb541ca4c36500b7b1d1a4def992059d9af56f14 ("md: remove lock_bdev / unlock_bdev")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master c76083fac3bae1a87ae3d005b5cb1cbc761e31d5]

in testcase: mdadm-selftests
version: mdadm-selftests-x86_64-5f41845-1_20220826
with following parameters:

	disk: 1HDD
	test_prefix: 18



on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202212312056.46bc24a0-oliver.sang@intel.com


[   78.488835][  T913] ------------[ cut here ]------------
[ 78.494802][ T913] WARNING: CPU: 3 PID: 913 at block/bdev.c:577 bd_prepare_to_claim (block/bdev.c:577 (discriminator 1)) 
[   78.504268][  T913] Modules linked in: multipath loop raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid10 raid1 raid0 ipmi_devintf ipmi_msghandler intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp btrfs i915 blake2b_generic xor raid6_pq zstd_compress libcrc32c sg kvm_intel drm_buddy kvm irqbypass crct10dif_pclmul crc32_pclmul intel_gtt crc32c_intel ghash_clmulni_intel drm_display_helper ahci sha512_ssse3 ttm mei_wdt libahci rapl drm_kms_helper mei_me intel_cstate syscopyarea joydev i2c_i801 libata intel_uncore mei lpc_ich sysfillrect i2c_smbus video sysimgblt fb_sys_fops wmi drm fuse ip_tables
[   78.565665][  T913] CPU: 3 PID: 913 Comm: mdadm Tainted: G S                 6.1.0-rc2-00207-gfb541ca4c365 #1
[   78.576327][  T913] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[ 78.585032][ T913] RIP: 0010:bd_prepare_to_claim (block/bdev.c:577 (discriminator 1)) 
[ 78.591591][ T913] Code: e8 1e 12 3a ff e9 a3 fe ff ff 4c 89 63 40 48 c7 c7 40 d7 40 84 c6 07 00 0f 1f 00 45 31 c0 65 ff 0d 5e 05 12 7e e9 cb fe ff ff <0f> 0b 41 b8 ea ff ff ff e9 be fe ff ff 48 89 7c 24 28 e8 92 71 98
All code
========
   0:	e8 1e 12 3a ff       	callq  0xffffffffff3a1223
   5:	e9 a3 fe ff ff       	jmpq   0xfffffffffffffead
   a:	4c 89 63 40          	mov    %r12,0x40(%rbx)
   e:	48 c7 c7 40 d7 40 84 	mov    $0xffffffff8440d740,%rdi
  15:	c6 07 00             	movb   $0x0,(%rdi)
  18:	0f 1f 00             	nopl   (%rax)
  1b:	45 31 c0             	xor    %r8d,%r8d
  1e:	65 ff 0d 5e 05 12 7e 	decl   %gs:0x7e12055e(%rip)        # 0x7e120583
  25:	e9 cb fe ff ff       	jmpq   0xfffffffffffffef5
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	41 b8 ea ff ff ff    	mov    $0xffffffea,%r8d
  32:	e9 be fe ff ff       	jmpq   0xfffffffffffffef5
  37:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
  3c:	e8                   	.byte 0xe8
  3d:	92                   	xchg   %eax,%edx
  3e:	71 98                	jno    0xffffffffffffffd8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	41 b8 ea ff ff ff    	mov    $0xffffffea,%r8d
   8:	e9 be fe ff ff       	jmpq   0xfffffffffffffecb
   d:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
  12:	e8                   	.byte 0xe8
  13:	92                   	xchg   %eax,%edx
  14:	71 98                	jno    0xffffffffffffffae
[   78.612486][  T913] RSP: 0018:ffffc90000f67aa0 EFLAGS: 00010246
[   78.619180][  T913] RAX: dffffc0000000000 RBX: ffff88810cc20d80 RCX: 1ffff1102198421a
[   78.627773][  T913] RDX: 1ffff11043074208 RSI: 0000000000000000 RDI: ffff8882183a1040
[   78.636373][  T913] RBP: ffff88810cc20d80 R08: 0000000000000001 R09: ffff88810cc2127b
[   78.644945][  T913] R10: ffffed102198424f R11: 0000000000000001 R12: 0000000000000000
[   78.653502][  T913] R13: 00000000fffffffe R14: ffff88810cc210d0 R15: ffff88810cc20d80
[   78.662050][  T913] FS:  00007f3f562f8740(0000) GS:ffff888199b80000(0000) knlGS:0000000000000000
[   78.671529][  T913] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.678656][  T913] CR2: 000055d5e91e4048 CR3: 0000000213af2002 CR4: 00000000001706e0
[   78.687190][  T913] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   78.695681][  T913] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   78.704295][  T913] Call Trace:
[   78.708201][  T913]  <TASK>
[ 78.711663][ T913] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 78.716859][ T913] ? blkdev_put_whole (block/bdev.c:574) 
[ 78.722254][ T913] ? kobject_get_unless_zero (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:560 include/linux/refcount.h:157 include/linux/refcount.h:227 include/linux/refcount.h:245 include/linux/kref.h:111 lib/kobject.c:637) 
[ 78.728389][ T913] ? _atomic_dec_and_lock (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-arch-fallback.h:1242 include/linux/atomic/atomic-arch-fallback.h:1267 include/linux/atomic/atomic-instrumented.h:608 lib/dec_and_lock.c:24) 
[ 78.734181][ T913] ? iput (fs/inode.c:1765 fs/inode.c:1759) 
[ 78.738609][ T913] blkdev_get_by_dev (block/bdev.c:1052) 
[ 78.744677][ T913] ? devcgroup_check_permission (security/device_cgroup.c:819 security/device_cgroup.c:844) 
[ 78.751054][ T913] md_import_device (drivers/md/md.c:3667) 
[ 78.756455][ T913] new_dev_store (drivers/md/md.c:4576) 
[ 78.761594][ T913] ? md_check_recovery (drivers/md/md.c:4534) 
[ 78.767499][ T913] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 78.772751][ T913] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 78.778694][ T913] md_attr_store (drivers/md/md.c:653 drivers/md/md.c:5544) 
[ 78.783828][ T913] ? sysfs_kf_bin_read (fs/sysfs/file.c:129) 
[ 78.789721][ T913] kernfs_fop_write_iter (fs/kernfs/file.c:334) 
[ 78.795750][ T913] vfs_write (include/linux/fs.h:2191 fs/read_write.c:491 fs/read_write.c:584) 
[ 78.800790][ T913] ? kernel_write (fs/read_write.c:565) 
[ 78.806282][ T913] ? build_open_flags (fs/open.c:1296) 
[ 78.811931][ T913] ? task_work_run (kernel/task_work.c:182 (discriminator 1)) 
[ 78.817355][ T913] ? __fget_light (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 fs/file.c:1006) 
[ 78.822529][ T913] ksys_write (fs/read_write.c:637) 
[ 78.827370][ T913] ? __ia32_sys_read (fs/read_write.c:627) 
[ 78.832705][ T913] ? switch_fpu_return (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 arch/x86/kernel/fpu/context.h:80 arch/x86/kernel/fpu/core.c:755) 
[ 78.838290][ T913] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 78.843255][ T913] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   78.849646][  T913] RIP: 0033:0x7f3f563e9f33
[ 78.854552][ T913] Code: 8b 15 61 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
All code
========
   0:	8b 15 61 ef 0c 00    	mov    0xcef61(%rip),%edx        # 0xcef67
   6:	f7 d8                	neg    %eax
   8:	64 89 02             	mov    %eax,%fs:(%rdx)
   b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  12:	eb b7                	jmp    0xffffffffffffffcb
  14:	0f 1f 00             	nopl   (%rax)
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85 c0                	test   %eax,%eax
  21:	75 14                	jne    0x37
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 55                	ja     0x87
  32:	c3                   	retq   
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	48 83 ec 28          	sub    $0x28,%rsp
  3b:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 55                	ja     0x5d
   8:	c3                   	retq   
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	48 83 ec 28          	sub    $0x28,%rsp
  11:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
[   78.875232][  T913] RSP: 002b:00007ffc5eb6e138 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   78.884360][  T913] RAX: ffffffffffffffda RBX: 00007ffc5eb70390 RCX: 00007f3f563e9f33
[   78.892858][  T913] RDX: 0000000000000003 RSI: 00007ffc5eb6e220 RDI: 0000000000000006
[   78.901364][  T913] RBP: 0000000000000006 R08: 00000000ffffffff R09: 00007ffc5eb6dfc0
[   78.909823][  T913] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc5eb6e220
[   78.918304][  T913] R13: 00007ffc5eb70390 R14: 0000000000000000 R15: 0000000000000000
[   78.926730][  T913]  </TASK>
[   78.930224][  T913] ---[ end trace 0000000000000000 ]---
[   78.936156][  T913] md: could not open device unknown-block(7,0).
[   79.127239][  T381] /lkp/benchmarks/mdadm-selftests/tests/18imsm-1d-takeover-r0_1d... FAILED - see /var/tmp/18imsm-1d-takeover-r0_1d.log and /var/tmp/fail18imsm-1d-takeover-r0_1d.log for details
[   79.127248][  T381]
[   85.431749][ T1025] loop0: detected capacity change from 0 to 40000
[   85.638740][ T1031] loop1: detected capacity change from 0 to 40000
[   85.844483][ T1036] loop2: detected capacity change from 0 to 40000
[   86.051863][ T1041] loop3: detected capacity change from 0 to 40000
[   86.266434][ T1049] loop4: detected capacity change from 0 to 40000
[   86.469395][ T1054] loop5: detected capacity change from 0 to 40000
[   86.676377][ T1059] loop6: detected capacity change from 0 to 40000
[   86.876781][ T1064] loop7: detected capacity change from 0 to 40000
[   87.469588][ T1075] loop8: detected capacity change from 0 to 131072
[   88.061829][ T1080] loop9: detected capacity change from 0 to 131072
[   88.656197][ T1088] loop10: detected capacity change from 0 to 131072
[   89.258611][ T1096] loop11: detected capacity change from 0 to 131072
[   89.863317][ T1101] loop12: detected capacity change from 0 to 131072
[   90.500181][ T1109] loop13: detected capacity change from 0 to 131072
[   90.525792][  T381] Testing on linux-6.1.0-rc2-00207-gfb541ca4c365 kernel
[   90.525805][  T381]
[   90.611308][ T1126] md: could not open device unknown-block(7,0).
[   90.804497][  T381] /lkp/benchmarks/mdadm-selftests/tests/18imsm-1d-takeover-r1_2d... FAILED - see /var/tmp/18imsm-1d-takeover-r1_2d.log and /var/tmp/fail18imsm-1d-takeover-r1_2d.log for details
[   90.804508][  T381]
[   97.040576][ T1242] loop0: detected capacity change from 0 to 40000
[   97.241584][ T1248] loop1: detected capacity change from 0 to 40000
[   97.463397][ T1256] loop2: detected capacity change from 0 to 40000
[   97.664791][ T1261] loop3: detected capacity change from 0 to 40000
[   97.870902][ T1266] loop4: detected capacity change from 0 to 40000
[   98.074234][ T1274] loop5: detected capacity change from 0 to 40000
[   98.278356][ T1280] loop6: detected capacity change from 0 to 40000
[   98.491480][ T1287] loop7: detected capacity change from 0 to 40000
[   99.070949][ T1292] loop8: detected capacity change from 0 to 131072
[   99.670376][ T1300] loop9: detected capacity change from 0 to 131072
[  100.265457][ T1305] loop10: detected capacity change from 0 to 131072
[  100.860594][ T1313] loop11: detected capacity change from 0 to 131072
[  101.455755][ T1321] loop12: detected capacity change from 0 to 131072
[  102.055578][ T1326] loop13: detected capacity change from 0 to 131072
[  102.077796][  T381] Testing on linux-6.1.0-rc2-00207-gfb541ca4c365 kernel
[  102.077806][  T381]
[  102.168502][ T1345] md: could not open device unknown-block(7,0).
[  102.355361][  T381] /lkp/benchmarks/mdadm-selftests/tests/18imsm-r0_2d-takeover-r10_4d... FAILED - see /var/tmp/18imsm-r0_2d-takeover-r10_4d.log and /var/tmp/fail18imsm-r0_2d-takeover-r10_4d.log for details


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--eyIAqbvOPgfHBVn4
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc2-00207-gfb541ca4c365"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.1.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
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
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_IMA_KEXEC=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
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
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
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
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
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
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
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
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
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
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
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
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
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
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
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
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
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
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
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
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
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
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
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
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
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
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
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
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
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
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
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
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
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
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

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
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
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
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_TPS546D24 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
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
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
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
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

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
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_ERDMA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
CONFIG_INTEL_IDXD_BUS=m
CONFIG_INTEL_IDXD=m
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IDXD_SVM is not set
# CONFIG_INTEL_IDXD_PERFMON is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

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

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
# CONFIG_DLM_DEPRECATED_API is not set
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
# CONFIG_IMA_KEXEC is not set
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_IMA_DISABLE_HTABLE is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
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
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
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
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_BTF is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
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
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
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
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
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
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
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
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
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
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
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
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--eyIAqbvOPgfHBVn4
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='mdadm-selftests'
	export testcase='mdadm-selftests'
	export category='functional'
	export need_memory='1G'
	export force_reboot=1
	export job_origin='mdadm-selftests.yaml'
	export queue_cmdline_keys=
	export queue='vip'
	export testbox='lkp-hsw-d01'
	export tbox_group='lkp-hsw-d01'
	export submit_id='63afde070b9a930d11f25cef'
	export job_file='/lkp/jobs/scheduled/lkp-hsw-d01/mdadm-selftests-1HDD-18-debian-11.1-x86_64-20220510.cgz-fb541ca4c36500b7b1d1a4def992059d9af56f14-20221231-68881-4qsjm8-3.yaml'
	export id='b815d926bf118043bff25393075f8b247e766113'
	export queuer_version='/lkp/xsang/.src-20221229-153216'
	export model='Haswell'
	export nr_node=1
	export nr_cpu=8
	export memory='8G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=6
	export hdd_partitions='/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC12HHHW-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL42040015800RGN-part2'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL42040015800RGN-part1'
	export brand='Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz'
	export need_kconfig='BLK_DEV_SD
SCSI
{"BLOCK"=>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=>"y"}
{"MD"=>"y"}
BLK_DEV_MD
MD_LINEAR
MD_RAID0
MD_RAID1
MD_RAID10
MD_RAID456
MD_MULTIPATH
BLK_DEV_LOOP'
	export commit='fb541ca4c36500b7b1d1a4def992059d9af56f14'
	export ucode='0x28'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"E1000E"=>"y"}
{"ATA_SFF"=>"y"}
{"ATA_BMDMA"=>"y"}
ATA_PIIX
DRM_I915'
	export bisect_dmesg=true
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2022-12-31 15:00:23 +0800'
	export _id='63afde0b0b9a930d11f25cf2'
	export _rt='/result/mdadm-selftests/1HDD-18/lkp-hsw-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/fb541ca4c36500b7b1d1a4def992059d9af56f14'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='ebadab737b5f5249a7709ff3624e17ccd072eff8'
	export base_commit='1b929c02afd37871d5afb9d498426f83432e71c2'
	export branch='linus/master'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/mdadm-selftests/1HDD-18/lkp-hsw-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/fb541ca4c36500b7b1d1a4def992059d9af56f14/3'
	export scheduler_version='/lkp/lkp/.src-20221229-110721'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/mdadm-selftests/1HDD-18/lkp-hsw-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/fb541ca4c36500b7b1d1a4def992059d9af56f14/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/fb541ca4c36500b7b1d1a4def992059d9af56f14/vmlinuz-6.1.0-rc2-00207-gfb541ca4c365
branch=linus/master
job=/lkp/jobs/scheduled/lkp-hsw-d01/mdadm-selftests-1HDD-18-debian-11.1-x86_64-20220510.cgz-fb541ca4c36500b7b1d1a4def992059d9af56f14-20221231-68881-4qsjm8-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=fb541ca4c36500b7b1d1a4def992059d9af56f14
initcall_debug
nmi_watchdog=0
max_uptime=1200
LKP_SERVER=internal-lkp-server
nokaslr
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/fb541ca4c36500b7b1d1a4def992059d9af56f14/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/mdadm-selftests_20220515.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/mdadm-selftests-x86_64-5f41845-1_20220826.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/fb541ca4c36500b7b1d1a4def992059d9af56f14/vmlinuz-6.1.0-rc2-00207-gfb541ca4c365'
	export dequeue_time='2022-12-31 17:19:03 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-hsw-d01/mdadm-selftests-1HDD-18-debian-11.1-x86_64-20220510.cgz-fb541ca4c36500b7b1d1a4def992059d9af56f14-20221231-68881-4qsjm8-3.cgz'

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

	run_setup nr_hdd=1 $LKP_SRC/setup/disk

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test_prefix='18' $LKP_SRC/tests/wrapper mdadm-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test_prefix='18' $LKP_SRC/stats/wrapper mdadm-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time mdadm-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--eyIAqbvOPgfHBVn4
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--eyIAqbvOPgfHBVn4
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="mdadm-selftests"

2022-12-31 09:20:12 mkdir -p /var/tmp
2022-12-31 09:20:12 mke2fs -t ext3 -b 4096 -J size=4 -q /dev/sdb1
2022-12-31 09:20:35 mount -t ext3 /dev/sdb1 /var/tmp
sed -e 's/{DEFAULT_METADATA}/1.2/g' \
-e 's,{MAP_PATH},/run/mdadm/map,g'  mdadm.8.in > mdadm.8
/usr/bin/install -D -m 644 mdadm.8 /usr/share/man/man8/mdadm.8
/usr/bin/install -D -m 644 mdmon.8 /usr/share/man/man8/mdmon.8
/usr/bin/install -D -m 644 md.4 /usr/share/man/man4/md.4
/usr/bin/install -D -m 644 mdadm.conf.5 /usr/share/man/man5/mdadm.conf.5
/usr/bin/install -D -m 644 udev-md-raid-creating.rules /lib/udev/rules.d/01-md-raid-creating.rules
/usr/bin/install -D -m 644 udev-md-raid-arrays.rules /lib/udev/rules.d/63-md-raid-arrays.rules
/usr/bin/install -D -m 644 udev-md-raid-assembly.rules /lib/udev/rules.d/64-md-raid-assembly.rules
/usr/bin/install -D -m 644 udev-md-clustered-confirm-device.rules /lib/udev/rules.d/69-md-clustered-confirm-device.rules
/usr/bin/install -D  -m 755 mdadm /sbin/mdadm
/usr/bin/install -D  -m 755 mdmon /sbin/mdmon
Testing on linux-6.1.0-rc2-00207-gfb541ca4c365 kernel
/lkp/benchmarks/mdadm-selftests/tests/18imsm-1d-takeover-r0_1d... FAILED - see /var/tmp/18imsm-1d-takeover-r0_1d.log and /var/tmp/fail18imsm-1d-takeover-r0_1d.log for details
Testing on linux-6.1.0-rc2-00207-gfb541ca4c365 kernel
/lkp/benchmarks/mdadm-selftests/tests/18imsm-1d-takeover-r1_2d... FAILED - see /var/tmp/18imsm-1d-takeover-r1_2d.log and /var/tmp/fail18imsm-1d-takeover-r1_2d.log for details
Testing on linux-6.1.0-rc2-00207-gfb541ca4c365 kernel
/lkp/benchmarks/mdadm-selftests/tests/18imsm-r0_2d-takeover-r10_4d... FAILED - see /var/tmp/18imsm-r0_2d-takeover-r10_4d.log and /var/tmp/fail18imsm-r0_2d-takeover-r10_4d.log for details
Testing on linux-6.1.0-rc2-00207-gfb541ca4c365 kernel
/lkp/benchmarks/mdadm-selftests/tests/18imsm-r10_4d-takeover-r0_2d... FAILED - see /var/tmp/18imsm-r10_4d-takeover-r0_2d.log and /var/tmp/fail18imsm-r10_4d-takeover-r0_2d.log for details
Testing on linux-6.1.0-rc2-00207-gfb541ca4c365 kernel
/lkp/benchmarks/mdadm-selftests/tests/18imsm-r1_2d-takeover-r0_1d... FAILED - see /var/tmp/18imsm-r1_2d-takeover-r0_1d.log and /var/tmp/fail18imsm-r1_2d-takeover-r0_1d.log for details

--eyIAqbvOPgfHBVn4
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/mdadm-selftests.yaml
suite: mdadm-selftests
testcase: mdadm-selftests
category: functional
need_memory: 1G
disk: 1HDD
force_reboot: 1
mdadm-selftests:
  test_prefix: '18'
job_origin: mdadm-selftests.yaml

#! queue options
queue_cmdline_keys: []
queue: vip
testbox: lkp-hsw-d01
tbox_group: lkp-hsw-d01
submit_id: 63afde070b9a930d11f25cef
job_file: "/lkp/jobs/scheduled/lkp-hsw-d01/mdadm-selftests-1HDD-18-debian-11.1-x86_64-20220510.cgz-fb541ca4c36500b7b1d1a4def992059d9af56f14-20221231-68881-4qsjm8-0.yaml"
id: 208e5430ab07cff63a21a8fd9f66371770c5c68f
queuer_version: "/lkp/xsang/.src-20221229-153216"

#! hosts/lkp-hsw-d01
model: Haswell
nr_node: 1
nr_cpu: 8
memory: 8G
nr_ssd_partitions: 1
nr_hdd_partitions: 6
hdd_partitions: "/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC12HHHW-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL42040015800RGN-part2"
swap_partitions:
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL42040015800RGN-part1"
brand: Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz

#! include/category/functional
kmsg:
heartbeat:
meminfo:

#! include/disk/nr_hdd
need_kconfig:
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- MD: y
- BLK_DEV_MD
- MD_LINEAR
- MD_RAID0
- MD_RAID1
- MD_RAID10
- MD_RAID456
- MD_MULTIPATH
- BLK_DEV_LOOP

#! include/mdadm-selftests

#! include/queue/cyclic
commit: fb541ca4c36500b7b1d1a4def992059d9af56f14

#! include/testbox/lkp-hsw-d01
ucode: '0x28'
need_kconfig_hw:
- PTP_1588_CLOCK: y
- E1000E: y
- ATA_SFF: y
- ATA_BMDMA: y
- ATA_PIIX
- DRM_I915
bisect_dmesg: true
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2022-12-31 15:00:23.343238395 +08:00
_id: 63afde070b9a930d11f25cef
_rt: "/result/mdadm-selftests/1HDD-18/lkp-hsw-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/fb541ca4c36500b7b1d1a4def992059d9af56f14"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: ebadab737b5f5249a7709ff3624e17ccd072eff8
base_commit: 1b929c02afd37871d5afb9d498426f83432e71c2
branch: linus/master
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/mdadm-selftests/1HDD-18/lkp-hsw-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/fb541ca4c36500b7b1d1a4def992059d9af56f14/0"
scheduler_version: "/lkp/lkp/.src-20221229-110721"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/mdadm-selftests/1HDD-18/lkp-hsw-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/fb541ca4c36500b7b1d1a4def992059d9af56f14/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/fb541ca4c36500b7b1d1a4def992059d9af56f14/vmlinuz-6.1.0-rc2-00207-gfb541ca4c365
- branch=linus/master
- job=/lkp/jobs/scheduled/lkp-hsw-d01/mdadm-selftests-1HDD-18-debian-11.1-x86_64-20220510.cgz-fb541ca4c36500b7b1d1a4def992059d9af56f14-20221231-68881-4qsjm8-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=fb541ca4c36500b7b1d1a4def992059d9af56f14
- initcall_debug
- nmi_watchdog=0
- max_uptime=1200
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw

#! runtime status
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/fb541ca4c36500b7b1d1a4def992059d9af56f14/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/mdadm-selftests_20220515.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/mdadm-selftests-x86_64-5f41845-1_20220826.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /cephfs/db/releases/20221228124158/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 4.20.0
schedule_notify_address:
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/fb541ca4c36500b7b1d1a4def992059d9af56f14/vmlinuz-6.1.0-rc2-00207-gfb541ca4c365"
dequeue_time: 2022-12-31 16:55:22.624018668 +08:00

#! /cephfs/db/releases/20221230153423/lkp-src/include/site/inn
job_state: finished
loadavg: 1.27 0.69 0.27 1/183 1955
start_time: '1672476991'
end_time: '1672477076'
version: "/lkp/lkp/.src-20221229-110756:e6dc229cd:600449d48"

--eyIAqbvOPgfHBVn4
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

mkdir -p /var/tmp
mke2fs -t ext3 -b 4096 -J size=4 -q /dev/sdb1
mount -t ext3 /dev/sdb1 /var/tmp

--eyIAqbvOPgfHBVn4--
