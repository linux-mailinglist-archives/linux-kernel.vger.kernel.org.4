Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD1E5B6A73
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiIMJOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiIMJOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:14:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916785C340;
        Tue, 13 Sep 2022 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663060446; x=1694596446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ps8c+uH8OfG6OawRaCNBf4nYANeh00sGjpAPo5L/Acg=;
  b=WFZZGnGN7Z+VNBA217Ha7dWIPm6kC1TZSDwCgRMw02vymwVboOm60i8/
   UBJ4qu4eoNJt3pr6loEcmDXZZOJoPQRS+bcde9RpsvZg/kT6XMKmp44s1
   1kdRCOm/xzwRPrJS+9hRlqFwUghk+6jhhlts5NeaT5Xh3go/1JvKiV3MC
   XiIMhnQrM4sFH1Jp4tEbsgFvRSoS1OpGnNBeXn3daIcRnSckfG0VhNwvq
   HTe2EVAWV2l4Fg1InrGHdJ7NIi63idfEmaCL7XYKU/oea/U0GlbF3wVji
   bT+UDASYp5UbgL+wZCU7QnjQU47txdqdXGLUxRTeMgQTQYXogpRG9DnnZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324332620"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="xz'?yaml'?scan'208";a="324332620"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 02:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="xz'?yaml'?scan'208";a="567514837"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 13 Sep 2022 02:14:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 02:14:04 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 02:14:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 13 Sep 2022 02:14:03 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 13 Sep 2022 02:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJmpeUXm7wM7aCzEQ6juAOrS89yjOSXjrnEeP1eyGDgzeeERQTD6eqSEZuerll2Cw7Ex9cx7iGavVwLRhvtDqk77emSfejjb+Ao4NLgcCqXKGzTJfT2zMcS5sjVRPqF3MvNmESHE2PyVXdCaNtSxIaAX5tpXO4IPB8Dd4s7xjc79zQtcwsf8ztGCwq0+cLiXNwPYuU2nPb3uybBSGNAy6qVBZb1Qnuw9Yj0Myxtknl7jkI6OUegmLQG/aN6jG50VoAWlmmkGfqsG43/LXGvaPkkA3j6F7LdbYtGzzOKmRg5Fbthx6oOC1vqh7PrZDgJTxiiyGFqtyPfVQB51fSrMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3HKxNrcFMIqGeIFGXfL2ZsD2r/y7hf2iHjgsQ6DLDM=;
 b=hdkdSRPtnXVtwijOqRhn4woe1zQ7QLBZVGvhxM7UTkhIiee+d9TeYTP9XXgZpYFobhAGyEXe7IrP5Vpa06ecMO8ZA5gWxSRVg0G6XG8QuyRkIhSzUqfuGjyc8cLnBZBI8lGllyvPO4dA8ECX1ykXiD6r8q7XsqL9gXdLwy/iiESxbpOlSOynkWeD0Cn7s+72Mnq42x8avRoxSC+/4MBPj88daa58wgnmun4U+qlvik4Q2ZX67265JeYJQe7jLUET+76DUAibMX+6Ahoi7uWlD9ACDvpL5+nD17b8jI4kzrFGhFBsXXyn6YSkENZ4oLaI3QnV+TyM3o6GP7g0MLikRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH0PR11MB4918.namprd11.prod.outlook.com (2603:10b6:510:31::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 09:13:56 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::4d24:8150:7fb7:a429]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::4d24:8150:7fb7:a429%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 09:13:56 +0000
Date:   Tue, 13 Sep 2022 17:13:01 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <lkp@lists.01.org>, <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Thadeu Lima de Souza Cascardo" <cascardo@canonical.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [intel_idle] 55bba093fd: WARNING:suspicious_RCU_usage
Message-ID: <202209131658.a3549a75-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="Pkm8t1gC1ILy8Mdh"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH0PR11MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fb09d4-7dcf-4718-eecf-08da956848cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4Q4zxCzij6bm7xik+Q+ZXSlJp8VVk1tQyEEKbJjK8/NwT7JdYN0dLZRnRo1fuxCD/NX1IbwQixTAc3KNmPJRqs4RZM/RZO1ptKyKJqHovxuS2IdQae3g28VBjZu73FBA68Q1v7vY1mcgEQCRTKVGtzATZoiBPAqoQ6JwF1kppGZezjIdUvx4Vd076AldKtSOo3iIb6FrV2c3OkqVsn2mcYIdk6Mr/dfyfR+DKYdG6fR8CYJBq5RBa/bxekKDLegpqoVz/SzFzs3pBNNySezi8Xi4SrHSGCsJy5VwSm7ZlvanqLrkspNsqAIfPnWKLMeScbKihXyHlEr/KKUKBl7h1J3giG2MDq1z7mItyGjiLaNd2OWwbTpl+4lzzXcuLvgwkBAVLzBhSJJQgUT8BB4Ntxu3Xx/sPdVsSAGn3uPAW394apCaFdgLunRjOHeHCVhfj39wKZh+oqs/PEBXV6gviegp5YrQxUz8EoeLCz5PQaiPMyA1msVrZ65073UTVXpmM8jfwb5lQVOAoDfNcUup71jw0wNMzpr5DodEGM7AbSTVUCC/VIjOQhwgMAVQ7HIIQF3fRbz6ynGBv09d6/YTcNxEp8Odjtjld9Kh0DV8roLGJaUNsXSfDzbBlq4d79kr1MaTj0oLWL1NU6jeStuMh03w0dC8WVWiL16V1o000WpQT61SB5iUtGgRRmOFG/K3h2zVI72RUzBdhfDDUnPHzzh5Ws4fBAmXbttrhBgN/wy9TFA2puxuwNkt67a+yEx47kG+PPjsVIk0aF+AzMYHMG5qkmvJc4iY5Wq0paLsSaiYIUPzxlGuZmsnaJAvKW82YJUsNXFPZYmKfGUC6bwpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(7416002)(38100700002)(6486002)(86362001)(2906002)(8936002)(82960400001)(6916009)(30864003)(6506007)(26005)(4326008)(36756003)(54906003)(235185007)(5660300002)(8676002)(66946007)(21490400003)(83380400001)(478600001)(316002)(2616005)(66556008)(966005)(41300700001)(44144004)(66476007)(6512007)(1076003)(186003)(6666004)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ElhK9eyE2koKDyvchNFw9kax0Z5t1ZKKC594bUKzLZK3NTqGPY6Qp/U0F8p1?=
 =?us-ascii?Q?h84m5l+5bWPRzFiZlesNC9OrPDU67tyMflRh7Ehu6AJkIYXaYX6vGcH0z7Uz?=
 =?us-ascii?Q?uRL0KWC8eyEFnUXvY+g158KVdZl/EpII2RwnXxhsZ4dUOFhtQ+NM7FxLVBOR?=
 =?us-ascii?Q?oHPluId1sgc0t8cH4rJ4vOoxGWyGwkKv6xArnCgzMLKO9kWQLNW5sAsoB3IY?=
 =?us-ascii?Q?XJaaZWafJyerlkt2fAxHrv+jNdzlD5ewyPRJmKR5F8XH/jC3vYWB//rYCAQz?=
 =?us-ascii?Q?P5D1drPmxHVw7E8zRTMCFH9n63KhP98u4Bw5ffBsV4isWE55BPZttN0Cpcss?=
 =?us-ascii?Q?4I4sajJf425JvsMIEPv0g9pIh9l9TJc54gTOip+D17x72gNLjfiFkUcoAWF5?=
 =?us-ascii?Q?/V1OF/F831x3CQ20sfywqQpJwl0zHPVpDrUJOu8dw3kbRhBzspTjS1kTT9lk?=
 =?us-ascii?Q?B9TbEYcZmEpaeRadlZltC6NkArFDxjtpl7mxZNohJmlGs2jM02yFFoVPT7V4?=
 =?us-ascii?Q?nmkZRjnvW6FXH1YRJQzjkbSLKI/hIn59FU1HyXf9EjzcCtAt6cImevS8W8kk?=
 =?us-ascii?Q?XqM8Oxgm+f3XwZGzDzdSGK288/Wg2FZ22LVSDgJUSact199ZI8L77u50lGp9?=
 =?us-ascii?Q?iW7IKElO4dKn+hVCvgfnxQFbpYnQxtLk0V20x9suMTJYCXGTZ1pMWuCDBOna?=
 =?us-ascii?Q?eYHNh7D+zA3XPP8r/bK6vPCSlToYa6HRjyG4MNVIgT5m0FUSjy08eoXqUQfJ?=
 =?us-ascii?Q?7jh5fJ7f4ii5sgYD9ao0DgbKEFOfkjk2yFDdSX/LDJAO/7EXWhtg3VinAghR?=
 =?us-ascii?Q?BQmnS3mwXgMQbznw07eOUilqZ2tSYwMRI5ow/qYiZwBoDNyAbAmWrLeazoDQ?=
 =?us-ascii?Q?WolgzYR1x/EKt+3+EjbVAGoqM+ibZqkahQf2FtBr+TF0K17KqBU6biFPmqw/?=
 =?us-ascii?Q?Dv9PeeyHWGZLID950tsX859EB4IpiofBjniwNd9BF3ZKHqaZN7cy65KFlmIa?=
 =?us-ascii?Q?PagtvGF2JkbCOd5u6dp9d5L69fCmhX1E1jlLtaCzSW+oxz6oFvWuWWDaGc6G?=
 =?us-ascii?Q?r+zT8dqoHxBXViXXeeWOYXTK3xOPJ/tKfwEsjChkq4ZDvBOapWA7Z6uDV3ip?=
 =?us-ascii?Q?aNG9kVtX0zRWZTAkJIXn9oawbopn215i8BgVMf7kUvCAqtRgoQ+6Id2K4jOZ?=
 =?us-ascii?Q?TsSN/rPmT671WAQJGdXRvgue1eQ6zROk9tBM9cpWCoxp9NDKASjSqXMwbMBA?=
 =?us-ascii?Q?JH9HS2qzg1fG+AdNXQM1gEKyxa7fivLJOe+NgrTGVEeo20ewIsuM8girQRaf?=
 =?us-ascii?Q?epOS/fqTvPDzhFaZu8fvSf3qNpj3Mjpi1fmRlQHfsncHMOvZM+Rxf7YsqMPu?=
 =?us-ascii?Q?cPPbMnp2iT3vP8SBpJi+OkGR/5EvcddcoYRI33zfHuv0RtFG5+Kfnthz8wdL?=
 =?us-ascii?Q?NGCC8leSlf7HHUdYWkqlrfDfbZjjUV18B4UF5x4Pn7WbcwNwDFgCUsbeoBbk?=
 =?us-ascii?Q?Djh0gCsEjJ25iXgRph9PHMTcIIzOgWhnVJBgcBtKBYMoNBYIhrSGD+22zVDA?=
 =?us-ascii?Q?sQdkvMNutUpnldKqugkjtQCNbH/6YDGikBYVYyZXLevBzOD1Nzf2f10dZuBp?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fb09d4-7dcf-4718-eecf-08da956848cf
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 09:13:56.4737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycnXVk6lt//D9WAf2tUIJfHm8Zpxts/b6u1JjBHpplMbdm628fkSYfBIVqhm0FkMa+NiGYKoBQy3rtIKj0ipWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4918
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Pkm8t1gC1ILy8Mdh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: 55bba093fd91a76971134e3a4e3576e536c08f5c ("intel_idle: Disable IBRS during long idle")
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y

in testcase: kernel-selftests
version: kernel-selftests-x86_64-700a8991-1_20220823
with following parameters:

	group: ftrace

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


[  247.216403][    T0] =============================                                                 
[  247.221176][    T0] WARNING: suspicious RCU usage                                                 
[  247.225953][    T0] 5.10.132-00105-g55bba093fd91 #1 Tainted: G        W                           
[  247.233367][    T0] -----------------------------                                                 
[  247.238143][    T0] arch/x86/include/asm/msr-trace.h:45 suspicious rcu_dereference_check() usage! 
[  247.247136][    T0]                                                                               
[  247.247136][    T0] other info that might help us debug this:                                     
[  247.247136][    T0]                                                                               
[  247.257350][    T0]                                                                               
[  247.257350][    T0] rcu_scheduler_active = 2, debug_locks = 1                                     
[  247.265377][    T0] RCU used illegally from extended quiescent state!                             
[  247.271911][    T0] no locks held by swapper/6/0.                                                 
[  247.276687][    T0]                                                                               
[  247.276687][    T0] stack backtrace:                                                              
[  247.282521][    T0] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W         5.10.132-00105-g55b\
ba093fd91 #1                                                                                         
[  247.292587][    T0] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/201\
7                                                                                                    
[  247.301668][    T0] Call Trace:                                                                   
[  247.304880][    T0]  dump_stack+0x9a/0xd0                                                         
[  247.308968][    T0]  trace_write_msr+0x12f/0x140                                                  
[  247.313679][    T0]  intel_idle_ibrs+0x11e/0x180                                                  
[  247.318384][    T0]  cpuidle_enter_state+0x174/0xbc0                                              
[  247.323465][    T0]  cpuidle_enter+0x4a/0xc0                                                      
[  247.327826][    T0]  cpuidle_idle_call+0x280/0x400                                                
[  247.332703][    T0]  ? arch_cpu_idle_exit+0xc0/0xc0                                               
[  247.337653][    T0]  ? trace_hardirqs_off+0x53/0x140                                              
[  247.342709][    T0]  ? do_idle+0xd0/0x1c0
[  247.346785][    T0]  ? rcu_nmi_exit+0x4c/0xc0                                                     
[  247.351210][    T0]  ? tsc_verify_tsc_adjust+0x61/0x240                                           
[  247.356563][    T0]  do_idle+0xd7/0x1c0                                                           
[  247.360478][    T0]  cpu_startup_entry+0x19/0x40                                                  
[  247.365180][    T0]  start_secondary+0x247/0x340                                                  
[  247.369878][    T0]  ? set_cpu_sibling_map+0x24c0/0x24c0                                          
[  247.375319][    T0]  secondary_startup_64_no_verify+0xc2/0xcb                                     
[  247.381266][    C6]                                                                               
[  247.381270][    C6] =============================                                                 
[  247.381273][    C6] WARNING: suspicious RCU usage                                                 
[  247.381277][    C6] 5.10.132-00105-g55bba093fd91 #1 Tainted: G        W                           
[  247.381280][    C6] -----------------------------                                                 
[  247.381284][    C6] include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!      
[  247.381287][    C6]                                                                               
[  247.381290][    C6] other info that might help us debug this:                                     
[  247.381293][    C6]                                                                               
[  247.381296][    C6]                                                                               
[  247.381299][    C6] rcu_scheduler_active = 2, debug_locks = 1                                     
[  247.381303][    C6] RCU used illegally from extended quiescent state!                             
[  247.381306][    C6] no locks held by swapper/6/0.                                                 
[  247.381309][    C6]                                                                               
[  247.381312][    C6] stack backtrace:                                                              
[  247.381316][    C6] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W         5.10.132-00105-g55b\
ba093fd91 #1                                                                                         
[  247.381320][    C6] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/201\
7                                                                                                    
[  247.381323][    C6] Call Trace:                                                                   
[  247.381326][    C6]  dump_stack+0x9a/0xd0                                                         
[  247.381329][    C6]  lock_acquire.cold+0x3b/0x5d                                                  
[  247.381333][    C6]  ? rcu_read_unlock+0x80/0x80                                                  
[  247.381337][    C6]  ? ring_buffer_unlock_commit+0x13f/0x580                                      
[  247.381340][    C6]  ? tracing_generic_entry_update+0x131/0x240                                   
[  247.381343][    C6]  _raw_spin_lock+0x2c/0x40                                                     
[  247.381346][    C6]  ? vprintk_emit+0xba/0x2c0                                                    
[  247.381350][    C6]  vprintk_emit+0xba/0x2c0                                                      
[  247.381353][    C6]  ? trace_event_buffer_commit+0x17c/0xa40                                      
[  247.381356][    C6]  printk+0xb2/0xe7                                                             
[  247.381359][    C6]  ? record_print_text.cold+0x11/0x11                                           
[  247.381363][    C6]  ? trace_write_msr+0x2d/0x140                                                 
[  247.381366][    C6]  lockdep_rcu_suspicious+0x25/0x145                                            
[  247.381369][    C6]  trace_write_msr+0x12f/0x140                                                  
[  247.381372][    C6]  intel_idle_ibrs+0x11e/0x180                                                  
[  247.381376][    C6]  cpuidle_enter_state+0x174/0xbc0                                              
[  247.381379][    C6]  cpuidle_enter+0x4a/0xc0                                                      
[  247.381381][    C6]  cpuidle_idle_call+0x280/0x400                                                
[  247.381383][    C6]  ? arch_cpu_idle_exit+0xc0/0xc0                                               
[  247.381385][    C6]  ? trace_hardirqs_off+0x53/0x140                                              
[  247.381387][    C6]  ? do_idle+0xd0/0x1c0                                                         
[  247.381389][    C6]  ? rcu_nmi_exit+0x4c/0xc0                                                     
[  247.381391][    C6]  ? tsc_verify_tsc_adjust+0x61/0x240                                           
[  247.381394][    C6]  do_idle+0xd7/0x1c0
[  247.381396][    C6]  cpu_startup_entry+0x19/0x40
[  247.381398][    C6]  start_secondary+0x247/0x340
[  247.381400][    C6]  ? set_cpu_sibling_map+0x24c0/0x24c0
[  247.381402][    C6]  secondary_startup_64_no_verify+0xc2/0xcb
[  247.381404][    C6]
[  247.381406][    C6] =============================
[  247.381408][    C6] WARNING: suspicious RCU usage
[  247.381410][    C6] 5.10.132-00105-g55bba093fd91 #1 Tainted: G        W
[  247.381412][    C6] -----------------------------
[  247.381414][    C6] include/trace/events/lock.h:58 suspicious rcu_dereference_check() usage!
[  247.381416][    C6]
[  247.381419][    C6] other info that might help us debug this:
[  247.381420][    C6]
[  247.381422][    C6]
[  247.381425][    C6] rcu_scheduler_active = 2, debug_locks = 1
[  247.381427][    C6] RCU used illegally from extended quiescent state!
[  247.381429][    C6] 1 lock held by swapper/6/0:
[  247.381431][    C6]  #0: ffffffff8513b0d8 (logbuf_lock){-.-.}-{2:2}, at: vprintk_emit+0xba/0x2c0
[  247.381444][    C6]
[  247.381446][    C6] stack backtrace:
[  247.381448][    C6] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W         5.10.132-00105-g55b\
ba093fd91 #1
[  247.381450][    C6] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/201\
7
[  247.381452][    C6] Call Trace:
[  247.381454][    C6]  dump_stack+0x9a/0xd0
[  247.381457][    C6]  ? vprintk_emit+0xdc/0x2c0
[  247.381459][    C6]  lock_release.cold+0x1f/0x38
[  247.381461][    C6]  _raw_spin_unlock+0x17/0x40
[  247.381463][    C6]  vprintk_emit+0xdc/0x2c0
[  247.381465][    C6]  ? trace_event_buffer_commit+0x17c/0xa40
[  247.381467][    C6]  printk+0xb2/0xe7
[  247.381470][    C6]  ? record_print_text.cold+0x11/0x11
[  247.381472][    C6]  ? trace_write_msr+0x2d/0x140
[  247.381474][    C6]  lockdep_rcu_suspicious+0x25/0x145
[  247.381476][    C6]  trace_write_msr+0x12f/0x140
[  247.381478][    C6]  intel_idle_ibrs+0x11e/0x180
[  247.381480][    C6]  cpuidle_enter_state+0x174/0xbc0
[  247.381482][    C6]  cpuidle_enter+0x4a/0xc0
[  247.381484][    C6]  cpuidle_idle_call+0x280/0x400
[  247.381486][    C6]  ? arch_cpu_idle_exit+0xc0/0xc0
[  247.381488][    C6]  ? trace_hardirqs_off+0x53/0x140
[  247.381490][    C6]  ? do_idle+0xd0/0x1c0
[  247.381492][    C6]  ? rcu_nmi_exit+0x4c/0xc0
[  247.381494][    C6]  ? tsc_verify_tsc_adjust+0x61/0x240
[  247.381496][    C6]  do_idle+0xd7/0x1c0
[  247.381499][    C6]  cpu_startup_entry+0x19/0x40
[  247.381502][    C6]  start_secondary+0x247/0x340
[  247.381505][    C6]  ? set_cpu_sibling_map+0x24c0/0x24c0
[  247.381508][    C6]  secondary_startup_64_no_verify+0xc2/0xcb
[  247.381511][    C6]
[  247.381515][    C6] =============================
[  247.381518][    C6] WARNING: suspicious RCU usage
[  247.381521][    C6] 5.10.132-00105-g55bba093fd91 #1 Tainted: G        W
[  247.381525][    C6] -----------------------------
[  247.381529][    C6] include/linux/rcupdate.h:652 rcu_read_lock() used illegally while idle!
[  247.381532][    C6]
[  247.381535][    C6] other info that might help us debug this:
[  247.381538][    C6]
[  247.381541][    C6]
[  247.381544][    C6] rcu_scheduler_active = 2, debug_locks = 1
[  247.381548][    C6] RCU used illegally from extended quiescent state!
[  247.381551][    C6] 4 locks held by swapper/6/0:
[  247.381554][    C6]  #0: ffffffff8513b1a0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x1c3/0x2c\
0
[  247.381566][    C6]  #1: ffffffff84dbabc0 (console_owner){-.-.}-{0:0}, at: console_unlock+0x255/0\
x5c0
[  247.381578][    C6]  #2: ffffffff8572eaf8 (printing_lock){....}-{2:2}, at: vt_console_print+0x10d\
/0xcc0
[  247.381590][    C6]  #3: ffffffff85162000 (rcu_read_lock){....}-{1:2}, at: atomic_notifier_call_c\
hain+0x5/0x200
[  247.381603][    C6]
[  247.381605][    C6] stack backtrace:
[  247.381607][    C6] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W         5.10.132-00105-g55b\
ba093fd91 #1
[  247.381609][    C6] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/201\
7
[  247.381611][    C6] Call Trace:
[  247.381613][    C6]  dump_stack+0x9a/0xd0
[  247.381615][    C6]  atomic_notifier_call_chain+0x16d/0x200
[  247.381618][    C6]  vt_console_print+0x4d3/0xcc0
[  247.381620][    C6]  ? lf+0x2c0/0x2c0
[  247.381622][    C6]  call_console_drivers+0x1dd/0x340
[  247.381624][    C6]  console_unlock+0x2d3/0x5c0
[  247.381626][    C6]  ? console_unlock+0x255/0x5c0
[  247.381628][    C6]  ? devkmsg_read+0x680/0x680
[  247.381630][    C6]  ? __lock_release+0x102/0x540
[  247.381632][    C6]  ? __down_trylock_console_sem+0x68/0xc0
[  247.381634][    C6]  ? vprintk_emit+0x1c3/0x2c0
[  247.381636][    C6]  vprintk_emit+0x247/0x2c0
[  247.381639][    C6]  ? trace_event_buffer_commit+0x17c/0xa40
[  247.381641][    C6]  printk+0xb2/0xe7
[  247.381643][    C6]  ? record_print_text.cold+0x11/0x11
[  247.381645][    C6]  ? trace_write_msr+0x2d/0x140
[  247.381647][    C6]  lockdep_rcu_suspicious+0x25/0x145
[  247.381649][    C6]  trace_write_msr+0x12f/0x140
[  247.381651][    C6]  intel_idle_ibrs+0x11e/0x180
[  247.381653][    C6]  cpuidle_enter_state+0x174/0xbc0
[  247.381655][    C6]  cpuidle_enter+0x4a/0xc0
[  247.381657][    C6]  cpuidle_idle_call+0x280/0x400
[  247.381659][    C6]  ? arch_cpu_idle_exit+0xc0/0xc0
[  247.381661][    C6]  ? trace_hardirqs_off+0x53/0x140
[  247.381663][    C6]  ? do_idle+0xd0/0x1c0
[  247.381665][    C6]  ? rcu_nmi_exit+0x4c/0xc0
[  247.381667][    C6]  ? tsc_verify_tsc_adjust+0x61/0x240
[  247.381669][    C6]  do_idle+0xd7/0x1c0
[  247.381671][    C6]  cpu_startup_entry+0x19/0x40
[  247.381673][    C6]  start_secondary+0x247/0x340
[  247.381676][    C6]  ? set_cpu_sibling_map+0x24c0/0x24c0
[  247.381678][    C6]  secondary_startup_64_no_verify+0xc2/0xcb
[  247.381680][    C6]
[  247.381682][    C6] =============================
[  247.381684][    C6] WARNING: suspicious RCU usage
[  247.381686][    C6] 5.10.132-00105-g55bba093fd91 #1 Tainted: G        W
[  247.381688][    C6] -----------------------------
[  247.381691][    C6] include/linux/rcupdate.h:701 rcu_read_unlock() used illegally while idle!
[  247.381692][    C6]
[  247.381695][    C6] other info that might help us debug this:
[  247.381697][    C6]
[  247.381698][    C6]
[  247.381701][    C6] rcu_scheduler_active = 2, debug_locks = 1
[  247.381703][    C6] RCU used illegally from extended quiescent state!
[  247.381705][    C6] 4 locks held by swapper/6/0:
[  247.381707][    C6]  #0: ffffffff8513b1a0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x1c3/0x2c\
0
[  247.381719][    C6]  #1: ffffffff84dbabc0 (console_owner){-.-.}-{0:0}, at: console_unlock+0x255/0\
x5c0
[  247.381731][    C6]  #2: ffffffff8572eaf8 (printing_lock){....}-{2:2}, at: vt_console_print+0x10d\
/0xcc0
[  247.381743][    C6]  #3: ffffffff85162000 (rcu_read_lock){....}-{1:2}, at: atomic_notifier_call_c\
hain+0x5/0x200
[  247.381755][    C6]
[  247.381757][    C6] stack backtrace:
[  247.381759][    C6] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W         5.10.132-00105-g55b\
ba093fd91 #1
[  247.381761][    C6] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/201\
7
[  247.381763][    C6] Call Trace:
[  247.381765][    C6]  dump_stack+0x9a/0xd0
[  247.381767][    C6]  atomic_notifier_call_chain+0x1b7/0x200
[  247.381769][    C6]  vt_console_print+0x4d3/0xcc0
[  247.381771][    C6]  ? lf+0x2c0/0x2c0
[  247.381774][    C6]  call_console_drivers+0x1dd/0x340
[  247.381776][    C6]  console_unlock+0x2d3/0x5c0
[  247.381778][    C6]  ? console_unlock+0x255/0x5c0
[  247.381780][    C6]  ? devkmsg_read+0x680/0x680
[  247.381782][    C6]  ? __lock_release+0x102/0x540
[  247.381784][    C6]  ? __down_trylock_console_sem+0x68/0xc0
[  247.381786][    C6]  ? vprintk_emit+0x1c3/0x2c0
[  247.381788][    C6]  vprintk_emit+0x247/0x2c0
[  247.381790][    C6]  ? trace_event_buffer_commit+0x17c/0xa40
[  247.381792][    C6]  printk+0xb2/0xe7
[  247.381794][    C6]  ? record_print_text.cold+0x11/0x11
[  247.381797][    C6]  ? trace_write_msr+0x2d/0x140
[  247.381799][    C6]  lockdep_rcu_suspicious+0x25/0x145
[  247.381801][    C6]  trace_write_msr+0x12f/0x140
[  247.381803][    C6]  intel_idle_ibrs+0x11e/0x180
[  247.381805][    C6]  cpuidle_enter_state+0x174/0xbc0
[  247.381807][    C6]  cpuidle_enter+0x4a/0xc0
[  247.381809][    C6]  cpuidle_idle_call+0x280/0x400
[  247.381811][    C6]  ? arch_cpu_idle_exit+0xc0/0xc0
[  247.381813][    C6]  ? trace_hardirqs_off+0x53/0x140
[  247.381815][    C6]  ? do_idle+0xd0/0x1c0
[  247.381817][    C6]  ? rcu_nmi_exit+0x4c/0xc0
[  247.381819][    C6]  ? tsc_verify_tsc_adjust+0x61/0x240
[  247.381821][    C6]  do_idle+0xd7/0x1c0
[  247.381824][    C6]  cpu_startup_entry+0x19/0x40
[  247.381826][    C6]  start_secondary+0x247/0x340
[  247.381828][    C6]  ? set_cpu_sibling_map+0x24c0/0x24c0
[  247.381830][    C6]  secondary_startup_64_no_verify+0xc2/0xcb


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/r/202209131658.a3549a75-yujie.liu@intel.com


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
https://01.org/lkp

--Pkm8t1gC1ILy8Mdh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-5.10.132-00105-g55bba093fd91"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.10.132 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-5) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_LD_VERSION=238900000
CONFIG_CLANG_VERSION=0
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
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
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
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
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

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
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
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
CONFIG_CGROUP_BPF=y
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
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
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
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
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
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
# CONFIG_SLS is not set
CONFIG_X86_CPU_RESCTRL=y
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
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
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
CONFIG_X86_THERMAL_VECTOR=y

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
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
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
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

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
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

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
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_POWERNOW_K8=m
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
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
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
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
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
CONFIG_USER_RETURN_NOTIFIER=y
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
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
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
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
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
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
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
CONFIG_BLK_PM=y

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
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
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
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
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
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
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
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
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
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
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
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
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
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y

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
CONFIG_NF_FLOW_TABLE_IPV4=m
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
CONFIG_NF_FLOW_TABLE_IPV6=m
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
CONFIG_NF_LOG_BRIDGE=m
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
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
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
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
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
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_FQ_PIE is not set
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
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
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

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
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
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

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

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
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
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
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
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
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
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
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
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
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
# CONFIG_SCSI_DPT_I2O is not set
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
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
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
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
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
# CONFIG_PATA_PLATFORM is not set
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
# CONFIG_MD_MULTIPATH is not set
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
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

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
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
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
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
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
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
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
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
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
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
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
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
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
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
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
# CONFIG_WIRELESS_WDS is not set
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
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
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
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
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
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

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
# CONFIG_INPUT_MISC is not set
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
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
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
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
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
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
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
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set

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
# CONFIG_GPIO_XILINX is not set
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
# CONFIG_GPIO_ADP5588 is not set
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

# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
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
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
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
CONFIG_SENSORS_ADM1021=m
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
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
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
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
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
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
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
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
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
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

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
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
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
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
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
# CONFIG_MFD_TPS80031 is not set
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
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=y
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_BPF_LIRC_MODE2=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
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
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#

#
# Media SPI Adapters
#
# end of Media SPI Adapters
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

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
CONFIG_DRM_I915_GVT=y
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
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
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
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
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
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
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
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
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
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
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
# CONFIG_USB_CDNS3 is not set
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
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
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
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
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
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

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
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
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
# CONFIG_RTC_DRV_RX6110 is not set
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
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

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
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
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
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
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
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# end of Android

# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
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
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
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
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
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
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y

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
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
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
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
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
# CONFIG_BCM_KONA_USB2_PHY is not set
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
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

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
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
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
# CONFIG_XFS_ONLINE_REPAIR is not set
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
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
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
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
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
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
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
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
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
CONFIG_NFSD_V3=y
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
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
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
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
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
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
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
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

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
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
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
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
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
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
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
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
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
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
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
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_STACK_VALIDATION=y
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
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_MISC=y
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
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
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=1
CONFIG_KASAN_VMALLOC=y
# CONFIG_TEST_KASAN_MODULE is not set
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
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
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
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
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
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
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
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--Pkm8t1gC1ILy8Mdh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='kvm-intel.unrestricted_guest=0'
	export job_origin='kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis
bm_initrd_keep'
	export queue='validate'
	export testbox='lkp-skl-d07'
	export tbox_group='lkp-skl-d07'
	export submit_id='631e214b43a00701b7303a27'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d07/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-55bba093fd91a76971134e3a4e3576e536c08f5c-20220912-439-b4khlh-1.yaml'
	export id='22aca7d60ef3ed1f550bbc1087168971da164ba3'
	export queuer_version='/zday/lkp'
	export model='Skylake'
	export nr_cpu=8
	export memory='16G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z98KSZ-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part1'
	export brand='Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz'
	export commit='55bba093fd91a76971134e3a4e3576e536c08f5c'
	export ucode='0xf0'
	export bisect_dmesg=true
	export need_kconfig=\{\"FTRACE\"\=\>\"y\"\}'
'\{\"KPROBES\"\=\>\"y\"\}'
'\{\"FUNCTION_PROFILER\"\=\>\"y\"\}'
'\{\"TRACER_SNAPSHOT\"\=\>\"y\"\}'
'\{\"STACK_TRACER\"\=\>\"y\"\}'
'\{\"HIST_TRIGGERS\"\=\>\"y,\ v4.7-rc1\"\}'
'\{\"SCHED_TRACER\"\=\>\"y\"\}'
'\{\"IRQSOFF_TRACER\"\=\>\"y\"\}'
'\{\"PREEMPTIRQ_DELAY_TEST\"\=\>\"m,\ v5.6-rc1\"\}'
'\{\"MODULES\"\=\>\"y\"\}'
'\{\"MODULE_UNLOAD\"\=\>\"y\"\}'
'\{\"SAMPLES\"\=\>\"y\"\}'
'\{\"SAMPLE_FTRACE_DIRECT\"\=\>\"m,\ v5.5-rc1\"\}'
'\{\"SAMPLE_TRACE_PRINTK\"\=\>\"m\"\}'
'\{\"KALLSYMS_ALL\"\=\>\"y\"\}
	export rootfs='debian-12-x86_64-20220629.cgz'
	export initrds='linux_headers
linux_selftests'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export enqueue_time='2022-09-12 01:56:27 +0800'
	export _id='631e214b43a00701b7303a27'
	export _rt='/result/kernel-selftests/ftrace/lkp-skl-d07/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='0b8e37cbaa7637a81ac6c535b551865c5a062395'
	export base_commit='452ea6a15ed2ac74789b7b3513777cc94ea3b751'
	export branch='linux-stable-rc/linux-5.10.y'
	export result_root='/result/kernel-selftests/ftrace/lkp-skl-d07/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/1'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-12-x86_64-20220629.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d07/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/1
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/vmlinuz-5.10.132-00105-g55bba093fd91
branch=linux-stable-rc/linux-5.10.y
job=/lkp/jobs/scheduled/lkp-skl-d07/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-55bba093fd91a76971134e3a4e3576e536c08f5c-20220912-439-b4khlh-1.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=55bba093fd91a76971134e3a4e3576e536c08f5c
kvm-intel.unrestricted_guest=0
max_uptime=2100
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20220823.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-700a8991-1_20220823.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20220629.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.141'
	export repeat_to=6
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.arch/x86/include/asm/msr-trace.h:#suspicious_rcu_dereference_check()usage'
	export kbuild_queue_analysis=1
	export bm_initrd_keep=true
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/vmlinuz-5.10.132-00105-g55bba093fd91'
	export dequeue_time='2022-09-12 01:59:09 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d07/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-55bba093fd91a76971134e3a4e3576e536c08f5c-20220912-439-b4khlh-1.cgz'

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

	run_test group='ftrace' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='ftrace' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--Pkm8t1gC1ILy8Mdh
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--Pkm8t1gC1ILy8Mdh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kernel-selftests"

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-55bba093fd91a76971134e3a4e3576e536c08f5c
2022-09-11 18:01:43 ln -sf /usr/bin/clang
2022-09-11 18:01:43 ln -sf /usr/bin/llc
2022-09-11 18:01:43 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
2022-09-11 18:01:43 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
2022-09-11 18:01:43 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
LKP WARN miss config CONFIG_PREEMPT_TRACER= of ftrace/config
2022-09-11 18:01:44 make -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-55bba093fd91a76971134e3a4e3576e536c08f5c/tools/testing/selftests/ftrace'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-55bba093fd91a76971134e3a4e3576e536c08f5c/tools/testing/selftests/ftrace'
2022-09-11 18:01:44 make run_tests -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-55bba093fd91a76971134e3a4e3576e536c08f5c/tools/testing/selftests/ftrace'
TAP version 13
1..1
# selftests: ftrace: ftracetest
# === Ftrace unit tests ===
# [1] Basic trace file check	[PASS]
# [2] Basic test for tracers	[PASS]
# [3] Basic trace clock test	[PASS]
# [4] Basic event tracing check	[PASS]
# [5] Change the ringbuffer size	[PASS]
# [6] Snapshot and tracing setting	[PASS]
# [7] trace_pipe and trace_marker	[PASS]
# [8] Test ftrace direct functions against tracers	[PASS]
# [9] Test ftrace direct functions against kprobes	[PASS]
# [10] Generic dynamic event - add/remove kprobe events	[PASS]
# [11] Generic dynamic event - add/remove synthetic events	[PASS]
# [12] Generic dynamic event - selective clear (compatibility)	[PASS]
# [13] Generic dynamic event - generic clear event	[PASS]
# [14] event tracing - enable/disable with event level files	[PASS]
# [15] event tracing - restricts events based on pid notrace filtering	[PASS]
# [16] event tracing - restricts events based on pid	[PASS]
# [17] event tracing - enable/disable with subsystem level files	[PASS]
# [18] event tracing - enable/disable with top level files	[PASS]
# [19] Test trace_printk from module	[PASS]
# [20] ftrace - function graph filters with stack tracer	[PASS]
# [21] ftrace - function graph filters	[PASS]
# [22] ftrace - function glob filters	[PASS]
# [23] ftrace - function pid notrace filters	[PASS]
# [24] ftrace - function pid filters	[PASS]
# [25] ftrace - stacktrace filter command	[PASS]
# [26] ftrace - function trace with cpumask	[PASS]
# [27] ftrace - test for function event triggers	[PASS]
# [28] ftrace - function trace on module	[PASS]
# [29] ftrace - function profiling	[PASS]
# [30] ftrace - function profiler with function tracing	[PASS]
# [31] ftrace - test reading of set_ftrace_filter	[PASS]
# [32] ftrace - Max stack tracer	[PASS]
# [33] ftrace - test for function traceon/off triggers	[PASS]
# [34] ftrace - test tracing error log support	[PASS]
# [35] Test creation and deletion of trace instances while setting an event	[PASS]
# [36] Test creation and deletion of trace instances	[PASS]
# [37] Kprobe dynamic event - adding and removing	[PASS]
# [38] Kprobe dynamic event - busy event check	[PASS]
# [39] Kprobe dynamic event with arguments	[PASS]
# [40] Kprobe event with comm arguments	[PASS]
# [41] Kprobe event string type argument	[PASS]
# [42] Kprobe event symbol argument	[PASS]
# [43] Kprobe event argument syntax	[PASS]
# [44] Kprobes event arguments with types	[PASS]
# [45] Kprobe event user-memory access	[PASS]
# [46] Kprobe event auto/manual naming	[PASS]
# [47] Kprobe dynamic event with function tracer	[PASS]
# [48] Kprobe dynamic event - probing module	[PASS]
# [49] Create/delete multiprobe on kprobe event	[PASS]
# [50] Kprobe event parser error log check	[PASS]
# [51] Kretprobe dynamic event with arguments	[PASS]
# [52] Kretprobe dynamic event with maxactive	[PASS]
# [53] Kretprobe %return suffix test	[PASS]
# [54] Register/unregister many kprobe events	[PASS]
# [55] Kprobe events - probe points	[PASS]
# [56] Kprobe profile	[PASS]
# [57] Uprobe event parser error log check	[PASS]
# [58] test for the preemptirqsoff tracer	[UNSUPPORTED]
# [59] Meta-selftest: Checkbashisms	[UNRESOLVED]
# [60] Test wakeup tracer	[PASS]
# [61] Test wakeup RT tracer	[PASS]
# [62] event trigger - test inter-event histogram trigger expected fail actions	[XFAIL]
# [63] event trigger - test field variable support	[PASS]
# [64] event trigger - test inter-event combined histogram trigger	[PASS]
# [65] event trigger - test multiple actions on hist trigger	[PASS]
# [66] event trigger - test inter-event histogram trigger onchange action	[PASS]
# [67] event trigger - test inter-event histogram trigger onmatch action	[PASS]
# [68] event trigger - test inter-event histogram trigger onmatch-onmax action	[PASS]
# [69] event trigger - test inter-event histogram trigger onmax action	[PASS]
# [70] event trigger - test inter-event histogram trigger snapshot action	[PASS]
# [71] event trigger - test synthetic event create remove	[PASS]
# [72] event trigger - test inter-event histogram trigger trace action with dynamic string param	[PASS]
# [73] event trigger - test synthetic_events syntax parser	[PASS]
# [74] event trigger - test synthetic_events syntax parser errors	[FAIL]
# [75] event trigger - test inter-event histogram trigger trace action	[PASS]
# [76] event trigger - test event enable/disable trigger	[PASS]
# [77] event trigger - test trigger filter	[PASS]
# [78] event trigger - test histogram modifiers	[PASS]
# [79] event trigger - test histogram parser errors	[PASS]
# [80] event trigger - test histogram trigger	[PASS]
# [81] event trigger - test multiple histogram triggers	[PASS]
# [82] event trigger - test snapshot-trigger	[PASS]
# [83] event trigger - test stacktrace-trigger	[PASS]
# [84] trace_marker trigger - test histogram trigger	[PASS]
# [85] trace_marker trigger - test snapshot trigger	[PASS]
# [86] trace_marker trigger - test histogram with synthetic event against kernel event	[PASS]
# [87] trace_marker trigger - test histogram with synthetic event	[PASS]
# [88] event trigger - test traceon/off trigger	[PASS]
# [89] (instance)  Basic test for tracers	[PASS]
# [90] (instance)  Basic trace clock test	[PASS]
# [91] (instance)  Change the ringbuffer size	[PASS]
# [92] (instance)  Snapshot and tracing setting	[PASS]
# [93] (instance)  trace_pipe and trace_marker	[PASS]
# [94] (instance)  event tracing - enable/disable with event level files	[PASS]
# [95] (instance)  event tracing - restricts events based on pid notrace filtering	[PASS]
# [96] (instance)  event tracing - restricts events based on pid	[PASS]
# [97] (instance)  event tracing - enable/disable with subsystem level files	[PASS]
# [98] (instance)  ftrace - function pid notrace filters	[PASS]
# [99] (instance)  ftrace - function pid filters	[PASS]
# [100] (instance)  ftrace - stacktrace filter command	[PASS]
# [101] (instance)  ftrace - test for function event triggers	[PASS]
# [102] (instance)  ftrace - test for function traceon/off triggers	[PASS]
# [103] (instance)  event trigger - test event enable/disable trigger	[PASS]
# [104] (instance)  event trigger - test trigger filter	[PASS]
# [105] (instance)  event trigger - test histogram modifiers	[PASS]
# [106] (instance)  event trigger - test histogram trigger	[PASS]
# [107] (instance)  event trigger - test multiple histogram triggers	[PASS]
# [108] (instance)  trace_marker trigger - test histogram trigger	[PASS]
# [109] (instance)  trace_marker trigger - test snapshot trigger	[PASS]
# 
# 
# # of passed:  105
# # of failed:  1
# # of unresolved:  1
# # of untested:  0
# # of unsupported:  1
# # of xfailed:  1
# # of undefined(test bug):  0
not ok 1 selftests: ftrace: ftracetest # exit=1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-55bba093fd91a76971134e3a4e3576e536c08f5c/tools/testing/selftests/ftrace'

--Pkm8t1gC1ILy8Mdh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/kernel-selftests.yaml:
suite: kernel-selftests
testcase: kernel-selftests
category: functional
need_memory: 2G
need_cpu: 2
kernel-selftests:
  group: ftrace
kernel_cmdline: kvm-intel.unrestricted_guest=0
job_origin: kernel-selftests.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d07
tbox_group: lkp-skl-d07
submit_id: 631e0a6043a00752ab3ce260
job_file: "/lkp/jobs/scheduled/lkp-skl-d07/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-55bba093fd91a76971134e3a4e3576e536c08f5c-20220912-86699-pzu2nf-0.yaml"
id: 3cdd68346f2df984fe03c4c94ad60a9ef39255e8
queuer_version: "/zday/lkp"
:#! hosts/lkp-skl-d07:
model: Skylake
nr_cpu: 8
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z98KSZ-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part1"
brand: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
:#! include/category/functional:
kmsg:
heartbeat:
meminfo:
:#! include/queue/cyclic:
commit: 55bba093fd91a76971134e3a4e3576e536c08f5c
:#! include/testbox/lkp-skl-d07:
ucode: '0xf0'
bisect_dmesg: true
:#! include/kernel-selftests:
need_kconfig:
- FTRACE: y
- KPROBES: y
- FUNCTION_PROFILER: y
- TRACER_SNAPSHOT: y
- STACK_TRACER: y
- HIST_TRIGGERS: y, v4.7-rc1
- SCHED_TRACER: y
- IRQSOFF_TRACER: y
- PREEMPTIRQ_DELAY_TEST: m, v5.6-rc1
- MODULES: y
- MODULE_UNLOAD: y
- SAMPLES: y
- SAMPLE_FTRACE_DIRECT: m, v5.5-rc1
- SAMPLE_TRACE_PRINTK: m
- KALLSYMS_ALL: y
rootfs: debian-12-x86_64-20220629.cgz
initrds:
- linux_headers
- linux_selftests
kconfig: x86_64-rhel-8.3-kselftests
enqueue_time: 2022-09-12 00:18:41.426491734 +08:00
_id: 631e0a6043a00752ab3ce260
_rt: "/result/kernel-selftests/ftrace/lkp-skl-d07/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c"
:#! schedule options:
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 0b8e37cbaa7637a81ac6c535b551865c5a062395
base_commit: 452ea6a15ed2ac74789b7b3513777cc94ea3b751
branch: stable/linux-5.10.y
result_root: "/result/kernel-selftests/ftrace/lkp-skl-d07/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-12-x86_64-20220629.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d07/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/vmlinuz-5.10.132-00105-g55bba093fd91
- branch=stable/linux-5.10.y
- job=/lkp/jobs/scheduled/lkp-skl-d07/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-55bba093fd91a76971134e3a4e3576e536c08f5c-20220912-86699-pzu2nf-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=55bba093fd91a76971134e3a4e3576e536c08f5c
- kvm-intel.unrestricted_guest=0
- max_uptime=2100
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20220823.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-700a8991-1_20220823.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20220629.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /db/releases/20220908190824/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.18.0
schedule_notify_address:
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/55bba093fd91a76971134e3a4e3576e536c08f5c/vmlinuz-5.10.132-00105-g55bba093fd91"
dequeue_time: 2022-09-12 01:31:19.856620768 +08:00
:#! /db/releases/20220911194752/lkp-src/include/site/inn:
job_state: finished
loadavg: 0.72 0.93 0.58 1/163 10394
start_time: '1662917663'
end_time: '1662918070'
version: "/lkp/lkp/.src-20220907-174543:e127f2987:8dfd51ee7"

--Pkm8t1gC1ILy8Mdh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

ln -sf /usr/bin/clang
ln -sf /usr/bin/llc
ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -C ftrace
make run_tests -C ftrace

--Pkm8t1gC1ILy8Mdh--
