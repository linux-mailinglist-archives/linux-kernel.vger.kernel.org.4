Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF967453BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 04:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjGCCEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 22:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCCEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 22:04:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDD51B5
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 19:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688349876; x=1719885876;
  h=date:from:to:cc:subject:message-id:reply-to:mime-version;
  bh=vcgww12csYv0ysrp2gElklVKWINDr66NgG7Fx/bPnks=;
  b=GPgoW1poB0hhlRgQq/TjXmYywVql/S3jQq1IFOw5ZpqY8VA3n+1Dzkk5
   /6kdbkwg910ZH0PbcVVyIfiI9lL/PhM6DeIP0HbzyuJw3Ghc8cSUCyxcj
   664hH/2Q9l6gxeXRvGptXdRKLtBRkATdJAgFRFhF1XecPsCehKYJI3ESl
   3WlqO/YS85ei/JQvkQHlzI10rILdGDgUcEeID6wp1PMY1WEUezlHJariL
   wVAonnET/ZD9ZT3KpenYjYqKtJUkvv/oDu4QXZ9zMhn9gL7Nuneg2ziew
   Gby+M5JGY3ki6F6uqChrsOHi/ULET/7JmNFaJ96Jr08PfGnD0BqGJZhib
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="342359563"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="xz'341?scan'341,208,341";a="342359563"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 19:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="842491255"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="xz'341?scan'341,208,341";a="842491255"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 02 Jul 2023 19:04:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 2 Jul 2023 19:04:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 2 Jul 2023 19:04:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 2 Jul 2023 19:04:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 2 Jul 2023 19:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn6jHqGcM/P4v3U++tV5bsHFoeqCORdE5hECE4dAJvx/Htc6HHUesk/gmj5sPYycQd4zz0PH14p3Z8IKewB5wuH8zbY/EpkZJeb6JhNn3O4wuYR9yM/RUPqOwJjIfEF1xjH/Erggvit67OQ9b4IEVbjBf/Co4rLveVlGyeeww8GudMeSOPER5I4EC/1Pb9cx3Hm1xA1oUJ7NblAKhXxRLjMFp5Lbbhv01UkBDIQ8Sfm5TFBXXwQrt1i05pu2Y689I0CCzUrPEW8iICEUQ7IOGeC8Wev8i8MXZfuv2SXninyW5lugF9mcm5EusSM/pg8o7bvFOCP4AyZLV03oexjm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFGRe0MYTtme/aHeRZxLsbduAh4aZPBkth/5z5BU3wg=;
 b=I7/YMV/pCcMaFMcMb0Lh87iNK7QA6yp9pmzGiaTfAl63zPsqVXB5SxguB4x89dmUBiTus73ejGMThwFTRUYIi4VzhbIyRx2Fu3079RsVAQzEht7lWbrTX+ipAfzrDB8/EsGch59x6OrKMzAU7+CxFXeYSaVpuGaHCdLj/ewLddBcOvaH5JvmDn3B1NIoWXbe0CspcRTXsV+uocr8PzzLY+1GEOlXFwYOfLACWNa79ttpHFhobGP815AJa4FrSbZpZUdPCF/CfQq1lNIYnscKUmEUYjNdSuJz4PoutiEgipRk4PNeAkP+3PHoNCHAmcMs7y4CByJmzsEHTlW0tSfG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MN2PR11MB4646.namprd11.prod.outlook.com (2603:10b6:208:264::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 02:04:27 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 02:04:27 +0000
Date:   Mon, 3 Jul 2023 10:04:16 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <oliver.sang@intel.com>
Subject: [mm]  408579cd62: WARNING:suspicious_RCU_usage
Message-ID: <ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020>
Reply-To: lkp <oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="U1FD5TZE+IMg8iGr"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MN2PR11MB4646:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2afb4b-59bf-491b-0f1e-08db7b69d3d9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+Fx+NDKjfhPRA46oo9FnAuXnr9YRbNmVnnoLQ51tsNYSkFwIcI9sz+3SVuoSZv6Gpria1afda3TInJjID8mRlnVJXRx0n8SHH5gN6wqaK69/StbcjLKJ4Acd8egQF3oI2k+iP+7QMo4iQ4WPHjzvGNvf53CibwZzBpfKHoa9wRH4YgXR6EW+xo0VCz5uTOk6IsJMd41i57bMHf2eTPJlzaPCEbNq+W5xIw+Lb9vPxoSLeJGynEa+WHo+va6Fsj5trAL5DXDkPV3BsA8NRPI+nmld4YnXbjM/o4SYu2L9Umk+czJI4ufGWylJhSmRpAUyyeTwkQmnayXPsUUPT06gF138eyOlwO9zwkzKZDiR6MH/RwWJPySPaT5D9vhDXD3ihZ4BC5ZP4mJFmz9IIuA8tmDWRjEd3c15nZW2PwYyDPBS7cMmOuegawDABF0EeUk+wbH1lZwMzFN3P9/+1MDL46Zt4LTHahIbLDqH57Mwe2bSSODrvW8zhJuA+Sd2HUZeeRMW5iGniZJTvHplilSi+hyPRYba0KFnkKQzdgpRtYXr4biV6cLb0LHDxxPM3aL6IF0LzJ0F2tUpbc7GyTCpixRae1X/SMcswCoBNifaHLs6jJJYQkRIjr0ee5QCkryHa9IX4IY/1Yeeel+snfISQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(3450700001)(2906002)(41300700001)(66899021)(235185007)(5660300002)(8676002)(8936002)(33716001)(86362001)(186003)(82960400001)(478600001)(107886003)(26005)(6512007)(966005)(6506007)(9686003)(6666004)(6486002)(44144004)(316002)(6916009)(4326008)(66476007)(66556008)(66946007)(38100700002)(54906003)(83380400001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wgYtZkP07WGHSSWSmEihfQZniELirkZpsXVQnI7B1OV1+Ozsen6EFRaZ27yJ?=
 =?us-ascii?Q?QD1g/ZEhy38udXtJAjc6Mhnv2oJK6DqJQ1PBtOkCrEVY+mkbZDMmu5EXeXyS?=
 =?us-ascii?Q?dTOQ64XfQxUDsP3ZnJKIsT6Ep1ZLQrLJxVv42hvfoBHVRRaZFqqe8rhV1VvX?=
 =?us-ascii?Q?Id6huN167i3jFK9adYjPbVphyjdiBN64xgt0hq88rKZjdJMjAsJ9wvBcgE7Q?=
 =?us-ascii?Q?W27qSUmb3nqSVEjuRz0HsU3slrZ1it2kxaDsIHeASl4pum7m3SI66TyVnq0x?=
 =?us-ascii?Q?LEqo4DN4o3e5wJFN6Nfd1EpOHArrvCESLstOQV52j08Bd3Ao+mxcSMuorpEj?=
 =?us-ascii?Q?DuNT+66avzk01E4QEkj51Re/VuN/meNeelwpkPG29MWx+N5tRrKEv4DXHb+4?=
 =?us-ascii?Q?TFTDsJMonk7ZZtxjGSn4C+NbfPrjhL207WcdLtObvTFeRqdZ730O8r82JWYJ?=
 =?us-ascii?Q?KV35dOYaVBz6ky6Wg7qFZMpvtI+TTNxTn5d6pRhna2nstkOF8wErSaJYCLxQ?=
 =?us-ascii?Q?wdcErGU/lhpWRYHg+lthjS+/Z3avsY0oydFCfG/HOcenG2Ypkpt9wqL4BVNo?=
 =?us-ascii?Q?v9VeWRKqhZ83TOZPo90I3nN1NjIoOPJqPcb8KvxvWDa60Hj2yYp86QFMNys0?=
 =?us-ascii?Q?/52cZy611NiUVrdbvNbRPwxqcvrrWet6XhbjO+hljXyXAS0MlQ31EXdIKrTp?=
 =?us-ascii?Q?EWkR7WY1Y6rULehc6dGWBjlzT9XiPwgO44lwRx1TKImikkMoLH65+cVKyFQT?=
 =?us-ascii?Q?FMdvkWfFbs4dLib44UnsMNo+TEIz1TALJ/n1xwMBzuGbyjUJBAjQ7nQBAraZ?=
 =?us-ascii?Q?zIoOVmfLozyhTFeWXb0iX3x5JUIaMy3s6CzD3VXF1qCYNxSXQOz4uHzPJj+/?=
 =?us-ascii?Q?nJ/jH0+TW/ZNmPtazBrJWX8uiWjfxD95f5RW0e58seON4y0lp9WSbewi1jcZ?=
 =?us-ascii?Q?Ibq0FfOX6GootPdexclv9FOdBfVPCB1Ei6eoUDNMs6khzNliiW7IF+pjUceO?=
 =?us-ascii?Q?o/mW98sG3rKhiIoYbsNOSGsCSvRcQ+kqk9yDDV9OAXA8mcM8ao6L6jXfVkmr?=
 =?us-ascii?Q?6pVFdt6r9QkE7BpgR+rRPJROv4bSkIGz7qDsXykmnqCRpo9PkZs4dToZd8rq?=
 =?us-ascii?Q?1wySJTUdFMSGIDpqqjb21bcjyjGOaoVy0nnpuaT+4XK9NnQE/ch/4Njsxfbf?=
 =?us-ascii?Q?5rz+Y59vfTkmhhXfKEYpX23joBJhD5F1I4sab4cv8eZmY/RlGvOEjtG1+j3a?=
 =?us-ascii?Q?8Kdfo39D4ORqELsadi5e7CMQUTWLIUqHkhhmaZNqafgzFOJ3AdAkfgylT4GH?=
 =?us-ascii?Q?TRgzQ4uAWxPCik/t6/CLQBEqHyoIySfXVwTUbzjH5PsXkHTDqC+Xd2AOqLFQ?=
 =?us-ascii?Q?pnSwluyRpEEmSPBmt8TOwXyXba+PzikSYI1D9ggEaV1QdyM6CZHBDzj1fDTM?=
 =?us-ascii?Q?+6uK9m/YMuekrACJ40n4Zs4b5rlO049+gz8weU7hhtj+koshUIXR3rkm2QZk?=
 =?us-ascii?Q?6HSpuWJLKeeiBohoygdhtrURDXqOenDB6L2/Xcj+SzzvcdVdEmkBWF5NfKd9?=
 =?us-ascii?Q?Lt4OnsV+10gczRJgDHW1RJ8KijdqtnP3I+1TfRPb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2afb4b-59bf-491b-0f1e-08db7b69d3d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 02:04:26.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06wmWk50QI4U0PAIfwVCPNR/lhK/hbU2hPgkrhMvh2Ps+f5k0sV5E6RrC/iak/m462+bwtpvIoPhCeMigLjoww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4646
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--U1FD5TZE+IMg8iGr
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with clang-15):

commit: 408579cd627a15bd703fe3eeb8485fd02726e9d3 ("mm: Update do_vmi_align_munmap() return semantics")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[  215.088258][    T1] WARNING: suspicious RCU usage
[  215.089042][    T1] 6.4.0-09907-g408579cd627a #1 Not tainted
[  215.090018][    T1] -----------------------------
[  215.090877][    T1] lib/maple_tree.c:860 suspicious rcu_dereference_check() usage!
[  215.092160][    T1]
[  215.092160][    T1] other info that might help us debug this:
[  215.092160][    T1]
[  215.093936][    T1]
[  215.093936][    T1] rcu_scheduler_active = 2, debug_locks = 1
[  215.095232][    T1] no locks held by init/1.
[  215.095989][    T1]
[  215.095989][    T1] stack backtrace:
[  215.097067][    T1] CPU: 0 PID: 1 Comm: init Not tainted 6.4.0-09907-g408579cd627a #1
[  215.098372][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  215.099963][    T1] Call Trace:
[  215.100474][    T1]  <TASK>
[ 215.101027][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 215.101807][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:122) 
[ 215.102688][ T1] mas_start (lib/maple_tree.c:?) 
[ 215.103355][ T1] mas_find (lib/maple_tree.c:3861 lib/maple_tree.c:4980 lib/maple_tree.c:5924 lib/maple_tree.c:5965) 
[ 215.104024][ T1] validate_mm (mm/mmap.c:301) 
[ 215.104777][ T1] do_vmi_align_munmap (mm/mmap.c:?) 
[ 215.105691][ T1] do_vmi_munmap (mm/mmap.c:2619) 
[ 215.106384][ T1] __vm_munmap (mm/mmap.c:2899) 
[ 215.107145][ T1] __x64_sys_munmap (mm/mmap.c:2916 mm/mmap.c:2913 mm/mmap.c:2913) 
[ 215.107962][ T1] do_syscall_64 (arch/x86/entry/common.c:?) 
[ 215.108784][ T1] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  215.109733][    T1] RIP: 0033:0x7f5ef4577e07
[ 215.110443][ T1] Code: 0f 1f 00 f7 d8 89 05 60 03 01 00 48 c7 c0 ff ff ff ff eb 99 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d 31 03 01 00 f7 d8 89 01 48 83
All code
========
   0:	0f 1f 00             	nopl   (%rax)
   3:	f7 d8                	neg    %eax
   5:	89 05 60 03 01 00    	mov    %eax,0x10360(%rip)        # 0x1036b
   b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  12:	eb 99                	jmp    0xffffffffffffffad
  14:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  23:	b8 0b 00 00 00       	mov    $0xb,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8d 0d 31 03 01 00 	lea    0x10331(%rip),%rcx        # 0x1036b
  3a:	f7 d8                	neg    %eax
  3c:	89 01                	mov    %eax,(%rcx)
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8d 0d 31 03 01 00 	lea    0x10331(%rip),%rcx        # 0x10341
  10:	f7 d8                	neg    %eax
  12:	89 01                	mov    %eax,(%rcx)
  14:	48                   	rex.W
  15:	83                   	.byte 0x83
[  215.113442][    T1] RSP: 002b:00007fff4bee7608 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
[  215.114734][    T1] RAX: ffffffffffffffda RBX: 0000008d3439883d RCX: 00007f5ef4577e07
[  215.115953][    T1] RDX: 0000008d00000000 RSI: 00000000000065e0 RDI: 00007f5ef42bf000
[  215.117299][    T1] RBP: 00007fff4bee78b0 R08: 0000000000000000 R09: 00007f5ef3fd6738
[  215.118541][    T1] R10: 00007f5ef4586f78 R11: 0000000000000202 R12: 0000008d2ecd462d
[  215.119813][    T1] R13: 00007f5ef4588180 R14: 00007f5ef4588180 R15: 00007f5ef38ef900
[  215.121130][    T1]  </TASK>
[  215.121750][    T1]
[  215.122149][    T1] =============================
[  215.122955][    T1] WARNING: suspicious RCU usage
[  215.123772][    T1] 6.4.0-09907-g408579cd627a #1 Not tainted
[  215.124752][    T1] -----------------------------
[  215.125549][    T1] lib/maple_tree.c:816 suspicious rcu_dereference_check() usage!
[  215.126747][    T1]
[  215.126747][    T1] other info that might help us debug this:
[  215.126747][    T1]
[  215.128401][    T1]
[  215.128401][    T1] rcu_scheduler_active = 2, debug_locks = 1
[  215.129720][    T1] no locks held by init/1.
[  215.130417][    T1]
[  215.130417][    T1] stack backtrace:
[  215.131392][    T1] CPU: 0 PID: 1 Comm: init Not tainted 6.4.0-09907-g408579cd627a #1
[  215.132633][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  215.134353][    T1] Call Trace:
[  215.134896][    T1]  <TASK>
[ 215.135380][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 215.136130][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:122) 
[ 215.137047][ T1] mtree_range_walk (lib/maple_tree.c:?) 
[ 215.137865][ T1] mas_find (lib/maple_tree.c:3868 lib/maple_tree.c:4980 lib/maple_tree.c:5924 lib/maple_tree.c:5965) 
[ 215.138570][ T1] validate_mm (mm/mmap.c:301) 
[ 215.139322][ T1] do_vmi_align_munmap (mm/mmap.c:?) 
[ 215.140203][ T1] do_vmi_munmap (mm/mmap.c:2619) 
[ 215.140985][ T1] __vm_munmap (mm/mmap.c:2899) 
[ 215.141721][ T1] __x64_sys_munmap (mm/mmap.c:2916 mm/mmap.c:2913 mm/mmap.c:2913) 
[ 215.142511][ T1] do_syscall_64 (arch/x86/entry/common.c:?) 
[ 215.143276][ T1] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  215.144276][    T1] RIP: 0033:0x7f5ef4577e07
[ 215.144998][ T1] Code: 0f 1f 00 f7 d8 89 05 60 03 01 00 48 c7 c0 ff ff ff ff eb 99 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d 31 03 01 00 f7 d8 89 01 48 83
All code
========
   0:	0f 1f 00             	nopl   (%rax)
   3:	f7 d8                	neg    %eax
   5:	89 05 60 03 01 00    	mov    %eax,0x10360(%rip)        # 0x1036b
   b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  12:	eb 99                	jmp    0xffffffffffffffad
  14:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  23:	b8 0b 00 00 00       	mov    $0xb,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8d 0d 31 03 01 00 	lea    0x10331(%rip),%rcx        # 0x1036b
  3a:	f7 d8                	neg    %eax
  3c:	89 01                	mov    %eax,(%rcx)
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8d 0d 31 03 01 00 	lea    0x10331(%rip),%rcx        # 0x10341
  10:	f7 d8                	neg    %eax
  12:	89 01                	mov    %eax,(%rcx)
  14:	48                   	rex.W
  15:	83                   	.byte 0x83
[  215.148009][    T1] RSP: 002b:00007fff4bee7608 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
[  215.149494][    T1] RAX: ffffffffffffffda RBX: 0000008d3439883d RCX: 00007f5ef4577e07
[  215.150834][    T1] RDX: 0000008d00000000 RSI: 00000000000065e0 RDI: 00007f5ef42bf000
[  215.152031][    T1] RBP: 00007fff4bee78b0 R08: 0000000000000000 R09: 00007f5ef3fd6738
[  215.153251][    T1] R10: 00007f5ef4586f78 R11: 0000000000000202 R12: 0000008d2ecd462d
[  215.154510][    T1] R13: 00007f5ef4588180 R14: 00007f5ef4588180 R15: 00007f5ef38ef900
[  215.155756][    T1]  </TASK>
[  215.182678][    T1] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.

Welcome to Debian GNU/Linux 11 (bullseye)!

[  215.449392][   T79] process 79 ((sd-executor)) attempted a POSIX timer syscall while CONFIG_POSIX_TIMERS is not set
[  215.758912][   T84] systemd-getty-g (84) used greatest stack depth: 26896 bytes left
[  215.948756][   T80] systemd-bless-b (80) used greatest stack depth: 26864 bytes left
[  218.217378][    C1] random: crng init done



To reproduce:

        # build kernel
	cd linux
	cp config-6.4.0-09907-g408579cd627a .config
	make HOSTCC=clang-15 CC=clang-15 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=clang-15 CC=clang-15 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
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



--U1FD5TZE+IMg8iGr
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="config-6.4.0-09907-g408579cd627a"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.4.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=150007
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=150007
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=150007
CONFIG_RUST_IS_AVAILABLE=y
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
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
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
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
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
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
CONFIG_CONTEXT_TRACKING_USER_FORCE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
# CONFIG_TASK_XACCT is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
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
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
CONFIG_RCU_LAZY=y
# CONFIG_RCU_DOUBLE_CHECK_CB_TIME is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_TIME_NS is not set
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_FORCE=y
# CONFIG_BOOT_CONFIG_EMBED is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
# CONFIG_CACHESTAT_SYSCALL is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
# CONFIG_RUST is not set
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
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_VSMP is not set
CONFIG_X86_GOLDFISH=y
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
# CONFIG_XEN_512GB is not set
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_PV_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
CONFIG_XEN_DEBUG_FS=y
# CONFIG_XEN_PVH is not set
CONFIG_XEN_DOM0=y
CONFIG_XEN_PV_MSR_SAFE=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
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
CONFIG_DMI=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
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
# end of Performance monitoring

# CONFIG_X86_16BIT is not set
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_X86_IOPL_IOPERM is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
# CONFIG_MTRR is not set
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
CONFIG_ADDRESS_MASKING=y
CONFIG_HOTPLUG_CPU=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=59
CONFIG_FUNCTION_PADDING_BYTES=64
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
CONFIG_SLS=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_USERSPACE_AUTOSLEEP=y
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
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
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
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
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_SMM is not set
# CONFIG_KVM_XEN is not set
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
CONFIG_HOTPLUG_CORE_SYNC=y
CONFIG_HOTPLUG_CORE_SYNC_DEAD=y
CONFIG_HOTPLUG_CORE_SYNC_FULL=y
CONFIG_HOTPLUG_SPLIT_STARTUP=y
CONFIG_HOTPLUG_PARALLEL=y
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
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
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
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
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
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
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
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT_64B=y
CONFIG_FUNCTION_ALIGNMENT=64
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_DEBUGFS=y
CONFIG_MODULE_DEBUG=y
# CONFIG_MODULE_STATS is not set
# CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODULE_UNLOAD_TAINT_TRACKING=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
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
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
# CONFIG_SLAB_DEPRECATED is not set
CONFIG_SLUB=y
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_HMM_MIRROR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_SECRETMEM is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
CONFIG_LRU_GEN=y
# CONFIG_LRU_GEN_ENABLED is not set
CONFIG_LRU_GEN_STATS=y
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y
CONFIG_LOCK_MM_AND_FIND_VMA=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
# CONFIG_DAMON_VADDR is not set
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_RECLAIM=y
CONFIG_DAMON_LRU_SORT=y
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_INTERFACE=m
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=y
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_XFRM_ESPINTCP=y
# CONFIG_SMC is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
# CONFIG_INET_AH is not set
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
CONFIG_INET_ESPINTCP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
# CONFIG_TCP_CONG_CUBIC is not set
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=y
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=y
# CONFIG_TCP_CONG_VENO is not set
# CONFIG_TCP_CONG_YEAH is not set
CONFIG_TCP_CONG_ILLINOIS=y
# CONFIG_TCP_CONG_DCTCP is not set
CONFIG_TCP_CONG_CDG=m
CONFIG_TCP_CONG_BBR=m
# CONFIG_DEFAULT_BIC is not set
# CONFIG_DEFAULT_VEGAS is not set
CONFIG_DEFAULT_RENO=y
CONFIG_DEFAULT_TCP_CONG="reno"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
# CONFIG_IPV6_ROUTE_INFO is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
CONFIG_INET6_AH=y
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=y
CONFIG_IPV6_SIT=m
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
# CONFIG_IPV6_MULTIPLE_TABLES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
# CONFIG_IPV6_PIMSM_V2 is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_RPL_LWTUNNEL=y
CONFIG_IPV6_IOAM6_LWTUNNEL=y
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
CONFIG_IP_DCCP_CCID2_DEBUG=y
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=y
CONFIG_SCTP_DBG_OBJCNT=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE=y
CONFIG_SCTP_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=y
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=y
CONFIG_L2TP_V3=y
# CONFIG_L2TP_IP is not set
CONFIG_L2TP_ETH=y
CONFIG_STP=y
CONFIG_BRIDGE=y
# CONFIG_BRIDGE_IGMP_SNOOPING is not set
CONFIG_BRIDGE_MRP=y
CONFIG_BRIDGE_CFM=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
# CONFIG_IPDDP is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
# CONFIG_IEEE802154_6LOWPAN is not set
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
# CONFIG_NET_SCH_PRIO is not set
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=y
# CONFIG_NET_SCH_NETEM is not set
# CONFIG_NET_SCH_DRR is not set
# CONFIG_NET_SCH_MQPRIO is not set
CONFIG_NET_SCH_SKBPRIO=y
CONFIG_NET_SCH_CHOKE=y
# CONFIG_NET_SCH_QFQ is not set
CONFIG_NET_SCH_CODEL=m
# CONFIG_NET_SCH_FQ_CODEL is not set
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
# CONFIG_NET_SCH_PLUG is not set
CONFIG_NET_SCH_ETS=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_CLS_U32_MARK is not set
# CONFIG_NET_CLS_FLOW is not set
CONFIG_NET_CLS_CGROUP=m
# CONFIG_NET_CLS_BPF is not set
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=y
CONFIG_NET_EMATCH_NBYTE=m
# CONFIG_NET_EMATCH_U32 is not set
CONFIG_NET_EMATCH_META=y
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
# CONFIG_NET_ACT_GACT is not set
# CONFIG_NET_ACT_MIRRED is not set
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_NAT=m
# CONFIG_NET_ACT_PEDIT is not set
CONFIG_NET_ACT_SIMP=y
# CONFIG_NET_ACT_SKBEDIT is not set
CONFIG_NET_ACT_CSUM=y
CONFIG_NET_ACT_MPLS=m
# CONFIG_NET_ACT_VLAN is not set
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_ACT_GATE=y
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=m
CONFIG_BATMAN_ADV_BATMAN_V=y
# CONFIG_BATMAN_ADV_BLA is not set
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_BATMAN_ADV_TRACING is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=y
CONFIG_VSOCKETS_LOOPBACK=y
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_HYPERV_VSOCKETS=m
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_QRTR=m
# CONFIG_QRTR_SMD is not set
CONFIG_QRTR_TUN=m
CONFIG_QRTR_MHI=m
CONFIG_NET_NCSI=y
# CONFIG_NCSI_OEM_CMD_GET_MAC is not set
# CONFIG_NCSI_OEM_CMD_KEEP_PHY is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
# CONFIG_NETROM is not set
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
CONFIG_6PACK=m
CONFIG_BPQETHER=m
# CONFIG_BAYCOM_SER_FDX is not set
CONFIG_BAYCOM_SER_HDX=m
# CONFIG_BAYCOM_PAR is not set
CONFIG_YAM=m
# end of AX.25 network device drivers

# CONFIG_CAN is not set
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
CONFIG_BT_LEDS=y
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_MTK=m
CONFIG_BT_HCIBTSDIO=m
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM4377 is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_MTKSDIO=m
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_IPV6=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_INJECT_RX_DELAY is not set
CONFIG_AF_RXRPC_DEBUG=y
# CONFIG_RXKAD is not set
CONFIG_RXPERF=m
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_MCTP=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_XEN=m
# CONFIG_NET_9P_RDMA is not set
CONFIG_NET_9P_DEBUG=y
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
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
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
# CONFIG_EISA_VIRTUAL_ROOT is not set
CONFIG_EISA_NAMES=y
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
CONFIG_XEN_PCIDEV_FRONTEND=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
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
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DEVTMPFS_SAFE=y
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
# CONFIG_FW_LOADER_DEBUG is not set
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_LOADER_COMPRESS_XZ is not set
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
# CONFIG_FW_CACHE is not set
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
# CONFIG_MHI_BUS_DEBUG is not set
# CONFIG_MHI_BUS_PCI_GENERIC is not set
CONFIG_MHI_BUS_EP=m
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
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
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_OTP=y
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=m
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
# CONFIG_MTD_RAW_NAND is not set

#
# ECC engine support
#
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
# CONFIG_MTD_UBI_GLUEBI is not set
CONFIG_MTD_HYPERBUS=y
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
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
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
CONFIG_ECHO=m
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_UACCE=m
# CONFIG_PVPANIC is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
# end of SCSI device support

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
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
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
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
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
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
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
# CONFIG_OCTEON_EP is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
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
# CONFIG_R8169 is not set
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

#
# MCTP Device Drivers
#
# CONFIG_MCTP_SERIAL is not set
# CONFIG_MCTP_TRANSPORT_I2C is not set
# end of MCTP Device Drivers

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
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=m
CONFIG_KEYBOARD_ADP5520=m
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=m
CONFIG_KEYBOARD_QT1070=m
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_MATRIX=y
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=m
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=m
CONFIG_KEYBOARD_PINEPHONE=y
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_IQS62X=m
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CYPRESS_SF=m
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADC=m
CONFIG_JOYSTICK_ADI=y
# CONFIG_JOYSTICK_COBRA is not set
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_232=m
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=y
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=m
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_DB9 is not set
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_WALKERA0701=m
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_JOYSTICK_QWIIC=y
# CONFIG_JOYSTICK_FSIA6B is not set
CONFIG_JOYSTICK_SENSEHAT=y
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_ATC260X_ONKEY=m
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=m
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_MAX8925_ONKEY=y
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=m
# CONFIG_INPUT_APANEL is not set
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_RETU_PWRBUTTON=y
# CONFIG_INPUT_AXP20X_PEK is not set
CONFIG_INPUT_TWL6040_VIBRA=y
CONFIG_INPUT_UINPUT=m
CONFIG_INPUT_PALMAS_PWRBUTTON=y
CONFIG_INPUT_PCF50633_PMU=m
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
# CONFIG_INPUT_DA7280_HAPTICS is not set
CONFIG_INPUT_DA9052_ONKEY=m
CONFIG_INPUT_DA9055_ONKEY=m
CONFIG_INPUT_DA9063_ONKEY=y
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IBM_PANEL is not set
CONFIG_INPUT_IQS269A=m
# CONFIG_INPUT_IQS626A is not set
CONFIG_INPUT_IQS7222=m
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
# CONFIG_INPUT_SOC_BUTTON_ARRAY is not set
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=m
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_INPUT_RT5120_PWRKEY=m
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
# CONFIG_HYPERV_KEYBOARD is not set
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LEGACY_TIOCSTI=y
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DFL is not set
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_FSL_LINFLEXUART=m
CONFIG_SERIAL_MEN_Z135=m
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_N_GSM=y
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_HVC_XEN is not set
# CONFIG_RPMSG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_IPMB=m
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=m
CONFIG_SSIF_IPMI_BMC=y
CONFIG_IPMB_DEVICE_INTERFACE=y
# CONFIG_HW_RANDOM is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=m
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m
# end of I2C Algorithms

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
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=m
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PCI1XXXX is not set
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
CONFIG_I2C_SLAVE_TESTUNIT=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=m
CONFIG_DW_I3C_MASTER=y
# CONFIG_SVC_I3C_MASTER is not set
CONFIG_MIPI_I3C_HCI=y
# CONFIG_SPI is not set
CONFIG_SPMI=m
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
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_CY8C95X0=y
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08=m
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L90=y

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
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_SIOX=m
CONFIG_GPIO_AMD_FCH=m
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_I8255=m
# CONFIG_GPIO_104_DIO_48E is not set
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=y
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_GPIO_MM=m
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_FXL6408 is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=m
CONFIG_GPIO_PCF857X=m
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=m
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_DA9055=m
# CONFIG_GPIO_ELKHARTLAKE is not set
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_MADERA=m
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TWL6040=m
CONFIG_GPIO_WM8350=m
# CONFIG_GPIO_WM8994 is not set
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
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_LATCH=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=m
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=m
CONFIG_W1_SLAVE_DS2431=m
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_ATC260X=m
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_GENERIC_ADC_BATTERY=m
CONFIG_IP5XXX_POWER=m
# CONFIG_MAX8925_POWER is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=m
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
CONFIG_CHARGER_DA9150=m
CONFIG_BATTERY_DA9150=m
# CONFIG_AXP20X_POWER is not set
CONFIG_BATTERY_MAX17040=m
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_88PM860X is not set
CONFIG_CHARGER_PCF50633=m
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=m
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_MAX77693=m
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MAX8998=y
CONFIG_CHARGER_MT6360=y
CONFIG_CHARGER_BQ2415X=m
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_BQ25980=y
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_RT9467=m
CONFIG_CHARGER_RT9471=y
# CONFIG_CHARGER_BD99954 is not set
CONFIG_BATTERY_UG3105=y
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_INTEL_TCC_COOLING=m
CONFIG_INTEL_HFI_THERMAL=y
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
CONFIG_DA9063_WATCHDOG=m
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_MENZ069_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_CADENCE_WATCHDOG=m
CONFIG_DW_WATCHDOG=m
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_RETU_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ADVANTECH_EC_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_EXAR_WDT=m
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
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
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
CONFIG_TQMX86_WDT=y
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=m
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y
CONFIG_XEN_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
# CONFIG_MFD_CS47L15 is not set
# CONFIG_MFD_CS47L35 is not set
CONFIG_MFD_CS47L85=y
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_I2C=m
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=m
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_SY7636A=m
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=y
CONFIG_MFD_RT5120=m
CONFIG_MFD_RC5T583=y
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SIMPLE_MFD_I2C=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=m
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
CONFIG_TPS65010=m
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_TPS6594=m
CONFIG_MFD_TPS6594_I2C=m
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_MFD_ATC260X=m
CONFIG_MFD_ATC260X_I2C=m
CONFIG_MFD_INTEL_M10_BMC_CORE=m
CONFIG_MFD_INTEL_M10_BMC_PMCI=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ATC260X=m
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=m
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8893=m
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX20411=m
CONFIG_REGULATOR_MAX77693=m
# CONFIG_REGULATOR_MAX77826 is not set
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=m
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_PALMAS=m
CONFIG_REGULATOR_PCA9450=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PV88060=m
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_QCOM_USB_VBUS=m
CONFIG_REGULATOR_RAA215300=y
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4803=m
CONFIG_REGULATOR_RT4831=m
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_RT5120=m
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5739=m
CONFIG_REGULATOR_RT5759=y
CONFIG_REGULATOR_RT6160=y
CONFIG_REGULATOR_RT6190=y
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=m
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_SY7636A=m
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_WM8350=m
CONFIG_REGULATOR_WM8400=m
CONFIG_REGULATOR_WM8994=m
CONFIG_REGULATOR_QCOM_LABIBB=m
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=m
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_GEM_SHMEM_HELPER=m
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=m
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=m
CONFIG_DRM_VKMS=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_QXL is not set
CONFIG_DRM_VIRTIO_GPU=m
# CONFIG_DRM_VIRTIO_GPU_KMS is not set
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
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=m
# CONFIG_DRM_ETNAVIV_THERMAL is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_SIMPLEDRM is not set
CONFIG_DRM_XEN=y
CONFIG_DRM_XEN_FRONTEND=m
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_SSD130X=m
CONFIG_DRM_SSD130X_I2C=m
# CONFIG_DRM_HYPERV is not set
CONFIG_DRM_LEGACY=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
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
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_VIRTUAL=m
CONFIG_XEN_FBDEV_FRONTEND=m
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_HYPERV is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
CONFIG_BACKLIGHT_KTZ8866=y
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_DA903X=m
# CONFIG_BACKLIGHT_DA9052 is not set
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_RT4831=m
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP5520=m
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_SKY81452=m
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=m
# CONFIG_SND is not set
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
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_CQHCI=m
CONFIG_MMC_HSQ=m
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2606MVV=m
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=m
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=m
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM36274 is not set

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
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_MTD=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=m
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_RDMAVT is not set
# CONFIG_RDMA_RXE is not set
CONFIG_RDMA_SIW=m
# CONFIG_INFINIBAND_IPOIB is not set
CONFIG_INFINIBAND_RTRS=m
CONFIG_INFINIBAND_RTRS_CLIENT=m
CONFIG_INFINIBAND_RTRS_SERVER=m
CONFIG_INFINIBAND_OPA_VNIC=m
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=y
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=m
CONFIG_INTEL_LDMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=m
# CONFIG_HD44780 is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=y
# CONFIG_LCD2S is not set
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=m
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_VDPA=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
CONFIG_VDPA=y
CONFIG_VDPA_USER=y
# CONFIG_MLX5_VDPA_STEERING_DEBUG is not set
CONFIG_VHOST_IOTLB=y
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
# CONFIG_HYPERV_VTL_MODE is not set
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
# CONFIG_XEN_DEV_EVTCHN is not set
# CONFIG_XEN_BACKEND is not set
# CONFIG_XENFS is not set
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
CONFIG_XEN_GRANT_DEV_ALLOC=y
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_PVCALLS_FRONTEND=y
# CONFIG_XEN_PRIVCMD is not set
CONFIG_XEN_ACPI_PROCESSOR=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_XEN_FRONT_PGDIR_SHBUF=m
# CONFIG_XEN_VIRTIO is not set
# end of Xen driver support

CONFIG_GREYBUS=m
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTLLIB is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# end of Accelerometers

#
# Analog to digital converters
#
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
CONFIG_ADT7316_I2C=m
# end of Analog digital bi-direction converters

#
# Direct Digital Synthesis
#
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_KS7010 is not set
CONFIG_GREYBUS_BOOTROM=m
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=m
# CONFIG_GREYBUS_LOOPBACK is not set
CONFIG_GREYBUS_POWER=m
# CONFIG_GREYBUS_RAW is not set
# CONFIG_GREYBUS_VIBRATOR is not set
# CONFIG_GREYBUS_BRIDGED_PHY is not set
CONFIG_FIELDBUS_DEV=m
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=m
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CROS_EC is not set
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
CONFIG_DCDBAS=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBU=y
CONFIG_DELL_RBTN=m
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_SMO8800=m
CONFIG_AMILO_RFKILL=m
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
# CONFIG_IDEAPAD_LAPTOP is not set
CONFIG_SENSORS_HDAPS=y
# CONFIG_THINKPAD_ACPI is not set
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=m
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL=y
# end of Intel Uncore Frequency Control

# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_OAKTRAIL is not set
CONFIG_INTEL_PUNIT_IPC=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
# CONFIG_MSI_LAPTOP is not set
CONFIG_PCENGINES_APU2=m
CONFIG_BARCO_P50_GPIO=m
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_MLX_PLATFORM=y
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_WINMATE_FM07_KEYS=m
# CONFIG_P2SB is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=m
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_CS2000_CP=m
# CONFIG_CLK_TWL6040 is not set
CONFIG_COMMON_CLK_PALMAS=y
CONFIG_XILINX_VCU=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
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
# CONFIG_AMD_IOMMU is not set
CONFIG_IOMMUFD=y
CONFIG_HYPERV_IOMMU=y
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
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=y
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

CONFIG_WPCM450_SOC=m

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

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
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=m
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_MEMORY=y
CONFIG_FPGA_DFL_EMIF=m
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_DMA=m
CONFIG_IIO_BUFFER_DMAENGINE=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_GTS_HELPER=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
# CONFIG_IIO_SW_TRIGGER is not set
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
# CONFIG_ADXL313_I2C is not set
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
# CONFIG_ADXL355_I2C is not set
CONFIG_ADXL367=m
CONFIG_ADXL367_I2C=m
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=m
CONFIG_BMA400=m
CONFIG_BMA400_I2C=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=m
CONFIG_DMARD10=m
# CONFIG_FXLS8962AF_I2C is not set
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
# CONFIG_IIO_KX022A_I2C is not set
CONFIG_KXSD9=m
CONFIG_KXSD9_I2C=m
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=m
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7660=m
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
CONFIG_MSA311=m
CONFIG_MXC4005=m
# CONFIG_MXC6255 is not set
CONFIG_STK8312=m
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
# CONFIG_AD7291 is not set
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
# CONFIG_AD799X is not set
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=m
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=m
CONFIG_ENVELOPE_DETECTOR=m
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=m
CONFIG_LTC2497=m
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=m
CONFIG_MCP3422=m
# CONFIG_MEDIATEK_MT6360_ADC is not set
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
CONFIG_PALMAS_GPADC=m
CONFIG_QCOM_VADC_COMMON=m
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=m
CONFIG_QCOM_SPMI_ADC5=m
CONFIG_RICHTEK_RTQ6056=m
CONFIG_SD_ADC_MODULATOR=m
CONFIG_TI_ADC081C=m
CONFIG_TI_ADS1015=m
# CONFIG_TI_ADS7924 is not set
# CONFIG_TI_ADS1100 is not set
CONFIG_VF610_ADC=m
CONFIG_XILINX_XADC=m
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_STX104 is not set
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
CONFIG_AD7746=m
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_ATLAS_EZO_SENSOR=m
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_CCS811=m
CONFIG_IAQCORE=m
CONFIG_SCD30_CORE=m
CONFIG_SCD30_I2C=m
# CONFIG_SCD4X is not set
CONFIG_SENSIRION_SGP30=m
CONFIG_SENSIRION_SGP40=m
CONFIG_SPS30=m
CONFIG_SPS30_I2C=m
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
CONFIG_VZ89X=m
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
CONFIG_AD5064=m
CONFIG_AD5380=m
# CONFIG_AD5446 is not set
CONFIG_AD5592R_BASE=m
CONFIG_AD5593R=m
CONFIG_AD5686=m
CONFIG_AD5696_I2C=m
# CONFIG_CIO_DAC is not set
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=m
CONFIG_TI_DAC5571=m
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=m
CONFIG_IIO_SIMPLE_DUMMY=m
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_BMG160 is not set
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=m
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HDC2010 is not set
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTU21=m
CONFIG_SI7005=m
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BOSCH_BNO055=m
CONFIG_BOSCH_BNO055_I2C=m
CONFIG_FXOS8700=m
CONFIG_FXOS8700_I2C=m
CONFIG_KMX61=m
CONFIG_INV_ICM42600=m
CONFIG_INV_ICM42600_I2C=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_I3C=m
CONFIG_IIO_ST_LSM9DS0=m
CONFIG_IIO_ST_LSM9DS0_I2C=m
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_AS73211 is not set
CONFIG_BH1750=m
# CONFIG_BH1780 is not set
CONFIG_CM32181=m
CONFIG_CM3232=m
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
CONFIG_CM36651=m
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=m
# CONFIG_IQS621_ALS is not set
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
CONFIG_JSA1212=m
CONFIG_ROHM_BU27034=m
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
CONFIG_LTRF216A=m
CONFIG_LV0104CS=m
# CONFIG_MAX44000 is not set
CONFIG_MAX44009=m
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
CONFIG_SI1133=m
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_TCS3414=m
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
CONFIG_TSL2591=m
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
CONFIG_VEML6030=m
CONFIG_VEML6070=m
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=m
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_MAG3110=m
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m
CONFIG_TI_TMAG5273=m
CONFIG_YAMAHA_YAS530=m
# end of Magnetometer sensors

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# CONFIG_IQS624_POS is not set
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=m
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
CONFIG_MCP4018=m
# CONFIG_MCP4531 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_DLHL60D=m
# CONFIG_DPS310 is not set
CONFIG_HP03=m
# CONFIG_ICP10100 is not set
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL3115 is not set
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=m
CONFIG_PING=m
CONFIG_RFD77402=m
CONFIG_SRF04=m
CONFIG_SX_COMMON=m
CONFIG_SX9310=m
CONFIG_SX9324=m
CONFIG_SX9360=m
# CONFIG_SX9500 is not set
CONFIG_SRF08=m
CONFIG_VCNL3020=m
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=m
CONFIG_MLX90614=m
# CONFIG_MLX90632 is not set
CONFIG_TMP006=m
CONFIG_TMP007=m
# CONFIG_TMP117 is not set
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=m
CONFIG_MAX30208=m
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
CONFIG_PHY_CAN_TRANSCEIVER=m

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_PHY_INTEL_LGM_EMMC=m
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_DAX=m
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y
# CONFIG_NVMEM_SYSFS is not set

#
# Layout Types
#
CONFIG_NVMEM_LAYOUT_SL28_VPD=y
CONFIG_NVMEM_LAYOUT_ONIE_TLV=m
# end of Layout Types

CONFIG_NVMEM_RMEM=m
# CONFIG_NVMEM_SPMI_SDAM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=m
# CONFIG_ALTERA_PR_IP_CORE is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=m
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_AFU=m
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
# CONFIG_FPGA_DFL_PCI is not set
# CONFIG_FPGA_M10_BMC_SEC_UPDATE is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
# CONFIG_MUX_GPIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=m
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=m
# CONFIG_104_QUAD_8 is not set
# CONFIG_INTEL_QEP is not set
CONFIG_INTERRUPT_CNT=m
# CONFIG_MOST is not set
CONFIG_PECI=y
# CONFIG_PECI_CPU is not set
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
CONFIG_VIRTIO_FS=m
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_DEBUG=y
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
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
# CONFIG_SUNRPC_DEBUG is not set
CONFIG_SUNRPC_XPRT_RDMA=m
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
CONFIG_CIFS_SWN_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CIFS_ROOT is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS=y
# CONFIG_CODA_FS is not set
CONFIG_AFS_FS=y
CONFIG_AFS_DEBUG=y
CONFIG_AFS_FSCACHE=y
CONFIG_AFS_DEBUG_CURSOR=y
CONFIG_9P_FS=y
# CONFIG_9P_FSCACHE is not set
CONFIG_9P_FS_POSIX_ACL=y
CONFIG_9P_FS_SECURITY=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=m
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=m
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=m
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
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_INFINIBAND is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
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
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SIG2=y
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
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
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
CONFIG_CRYPTO_ECRDSA=m
CONFIG_CRYPTO_SM2=m
CONFIG_CRYPTO_CURVE25519=m
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARIA=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_GENIV=m
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_POLYVAL=m
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_VMAC=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=m
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
CONFIG_CRYPTO_LZO=m
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=m
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
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
# CONFIG_CRYPTO_JITTERENTROPY_TESTINTERFACE is not set
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_RNG_CAVP=y
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_CURVE25519_X86=m
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64=y
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=m
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=m
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_SHA1_SSSE3=m
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SM3_AVX_X86_64=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
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
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
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
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=m
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_FLAGS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
CONFIG_DMA_PERNUMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
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
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_REF_TRACKER=y
# end of Library routines

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
# CONFIG_SYMBOLIC_ERRNAME is not set
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

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
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_BTF_TAG=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
CONFIG_OBJTOOL=y
CONFIG_VMLINUX_MAP=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
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
CONFIG_NET_DEV_REFCNT_TRACKER=y
CONFIG_NET_NS_REFCNT_TRACKER=y
CONFIG_DEBUG_NET=y
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_TABLE_CHECK=y
# CONFIG_PAGE_TABLE_CHECK_ENFORCED is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
CONFIG_PER_VMA_LOCK_STATS=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SHRINKER_DEBUG=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_MAPLE_TREE=y
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
# CONFIG_KASAN_STACK is not set
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
CONFIG_HAVE_KMSAN_COMPILER=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY=y
# CONFIG_HARDLOCKUP_DETECTOR_PERF is not set
CONFIG_HARDLOCKUP_DETECTOR_BUDDY=y
# CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set
CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_WQ_CPU_INTENSIVE_REPORT=y
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
CONFIG_LOCK_STAT=y
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
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_NMI_CHECK_CPU is not set
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
CONFIG_DEBUG_MAPLE_TREE=y
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

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
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_DEBUG_CGROUP_REF=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
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
CONFIG_SAMPLES=y
CONFIG_SAMPLE_AUXDISPLAY=y
CONFIG_SAMPLE_TRACE_EVENTS=m
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_TRACE_ARRAY=m
CONFIG_SAMPLE_KOBJECT=m
# CONFIG_SAMPLE_KPROBES is not set
CONFIG_SAMPLE_HW_BREAKPOINT=m
CONFIG_SAMPLE_KFIFO=m
CONFIG_SAMPLE_RPMSG_CLIENT=m
CONFIG_SAMPLE_CONFIGFS=m
CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB=y
# CONFIG_SAMPLE_WATCHDOG is not set
# CONFIG_SAMPLE_KMEMLEAK is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

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
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
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
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--U1FD5TZE+IMg8iGr
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
	export queue='boot'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linus/master'
	export commit='408579cd627a15bd703fe3eeb8485fd02726e9d3'
	export kconfig='x86_64-randconfig-r002-20230702'
	export repeat_to=1
	export nr_vm=300
	export submit_id='64a0b9ef56d3572b9feef766'
	export job_file='/lkp/jobs/queued/boot/vm-snb/boot-1-debian-11.1-x86_64-20220510.cgz-x86_64-randconfig-r002-20230702-408579cd627a-20230702-76703-6tdze0-0.yaml'
	export id='f17a2948164cc218f90533aa53c1ad8b1ccaac97'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export compiler='clang-15'
	export force_latest_head=1
	export enqueue_time='2023-07-02 07:42:39 +0800'
	export _id='64a0b9ef56d3572b9feef766'
	export _rt='/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-r002-20230702/clang-15/408579cd627a15bd703fe3eeb8485fd02726e9d3'
	export kernel='/pkg/linux/x86_64-randconfig-r002-20230702/clang-15/408579cd627a15bd703fe3eeb8485fd02726e9d3/vmlinuz-6.4.0-09907-g408579cd627a'
	export result_root='/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-r002-20230702/clang-15/408579cd627a15bd703fe3eeb8485fd02726e9d3/0'
	export user='lkp'
	export meta_host='vm-meta-100'
	export LKP_SERVER='internal-lkp-server'
	export scheduler_version='/lkp/lkp/.src-20230630-230453'
	export arch='x86_64'
	export max_uptime=600
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-r002-20230702/clang-15/408579cd627a15bd703fe3eeb8485fd02726e9d3/0
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-r002-20230702/clang-15/408579cd627a15bd703fe3eeb8485fd02726e9d3/vmlinuz-6.4.0-09907-g408579cd627a
branch=linus/master
job=/lkp/jobs/scheduled/vm-meta-100/boot-1-debian-11.1-x86_64-20220510.cgz-x86_64-randconfig-r002-20230702-408579cd627a-20230702-76703-6tdze0-0.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-r002-20230702
commit=408579cd627a15bd703fe3eeb8485fd02726e9d3
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
	export modules_initrd='/pkg/linux/x86_64-randconfig-r002-20230702/clang-15/408579cd627a15bd703fe3eeb8485fd02726e9d3/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/jobs/scheduled/vm-meta-100/boot-1-debian-11.1-x86_64-20220510.cgz-x86_64-randconfig-r002-20230702-408579cd627a-20230702-76703-6tdze0-0.cgz'

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

	run_setup $LKP_SRC/setup/sanity-check

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

--U1FD5TZE+IMg8iGr
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AwCjoi79scRn+wIAAAAABFla

--U1FD5TZE+IMg8iGr--
