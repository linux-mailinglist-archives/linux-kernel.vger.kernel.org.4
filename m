Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E72698ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBPIjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBPIjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:39:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AA5367DA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676536735; x=1708072735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=njG7v6CFdBz3wgIitsLo8o9kBHgdEprelhID7yyTwNo=;
  b=g+hEtkRTpoMSmPJyPWtzupjMwsFRQqbRQkotzOs5ySlKtCoIfV10iTQp
   UQS1+2B8V0in70W2kqFP3F+/EGsmA2QmiN8xIXQe0cavKpM9TdB8VgVSQ
   Xv3KUlb5nngYKGHEQTEQOhC3gRqwFLRWy2QwdGvNfmCzrPyslb/CGUqJH
   zOoZT1EBJFKb3C05aXz2ngPRqS7lGfV0lS3rnHGrMzMPm8//DEb5cmsZx
   YxmIJwOLVde834UFguIWYLwk/fO+Ci91PClc9+tntUeFpg+gMvWxESRgQ
   dfDlkzckUeFGCJeuWOHjUzjQT2HC15Bas2//UfDnYcfYatYfNaIofp7dl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="311291576"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="xz'341?yaml'341?scan'341,208,341";a="311291576"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 00:38:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="702479865"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="xz'341?yaml'341?scan'341,208,341";a="702479865"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2023 00:38:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 00:38:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 00:38:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 00:38:40 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 00:38:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6K+OOBwes4PxkP7BiZL//xg5r8dsx33YScE0Yvt/Gos8w0Vdgcyl6hADxw08nUOSFjXmLimv82URkfjaxTydzJ/Q5zY5K6EstVz2pYfCKFtlbrYChmAORsRARCEVaLLRHgSHJFBKqQN/D/Ao4rapzA1dn2Ysgb5M7H4INhT7c+y84rSoQCuU/LwboA1vJaxeO8w1on9ud1pZywDAK+CxiCIgoD+MQ8MGFSfLuXN04rjBC8TbtYJKvT47SOt7u99xVHOEKGa9atFYaYEGfON9A4OF3RsSq1tO7+QtoFqIfNN1DtfeuNpRhZSCce4Am90R3GhwHorbE5IlvckhHaECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8+gRs1NETx0HIXr7HdfcDl3LBd+mSd+axsCSk319Ds=;
 b=NlXRnXg3jcFfW1AltKgl4G7Vufhm3tzSeid8L8nacJ48ASzSSstOycO2OVBq0qygUlg837khI2sTY32ENut40nKiUkHcg++eSXqoaOs/QZUqDUJNEa/GlKIWQ/82C51qZ2AWUitaf0GBKBiJbqt1vj/DMe1/8zYC9spPeNkbKJTz/vD3+Sx/SlU4Yb6yja/AC6NTyFxiuv2Q8XEsOv0IDue9b03jZRpzBxdnNwvvSs4vYb+gK4n1NH7M8RFBnGiO1cIr9MQxI1gRHSo5xyD7rFNqHoMPgaqY01Heh8AzO7j7KPofbDU/w6hUh+ckE7rSHq7JIytVaZ3xHpvEy/xEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 08:38:35 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4%8]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 08:38:34 +0000
Date:   Thu, 16 Feb 2023 16:38:22 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [tip:objtool/core] [x86/unwind/orc]  ffb1b4a410:
 BUG:KASAN:stack-out-of-bounds_in_unwind_next_frame
Message-ID: <202302161616.85f13863-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="mXwfwGN2RzZ59ncZ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BL1PR11MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 354b1201-fe4b-4e29-14ec-08db0ff93011
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rJXPL7IHo+7vXEV5nWNk6s2B0ksP3VaSX7c+NyVwCglkvwXpTSUhqTozyk+6jOpFOzbneK55XS8I1174RWwznfaes0hA+/haQpZWzHrxbpI7Ll+Bzfa0vZSlIEXfyGNbMwqJUe/Cep/6sbWTOUqvZ6UEI02K91pGA2IKEfaagtphYtiT0w874eF+GSjlGsmFFALF3/xvP4ubrDERVV4gI4D0vLSIkbPU8xPghGLoVrpvYhNnT3csODc2Gt7wDUcCSEgKMAz3fPxEotFzTB+9kkb11LC2SCn+Vo/TfJ2FYepqZiMTvW4fX5hxSTH4Wik5aa6h6htJ6OT1d86Bu4rEstCBs7F9KNrdzoTfk6gUvUJs+0I1GMAji3LfntddAuuTDbB3v1zeJp0ZPaAiqPTkjRHWPzS/KwptTmd94J/BaWxdGvpT6KS49a/vXoS8awqR2pDcALEqbRRT8XH39c1QeSZhxRTzP9mKzCDwRgegtn8Q4sbSJUkN+jGeA4DCRvWO9NOga/EnfB3uWZMFkQchyIHkHQFElsM9q/KP6t8mw57HUK1AK7rckg+S4gJZfHKS49vzd0Y1RYTguTWtIhGO2C7Bb4A/RhgZEA4NOWMyT4DWRrmjh9GSIABRzH8w1scCsbHxbZNTQj/uYW8YxFazPVLBgWVpemnu9djV+ylbaaVp7nTShWgoAuhI+IE7s/lwTC77C/Ra8AfhwkmbhfZsiLAnZVcx6GHmhtd54xh3l0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199018)(83380400001)(2616005)(2906002)(86362001)(316002)(44144004)(30864003)(38100700002)(8936002)(36756003)(186003)(235185007)(6506007)(66556008)(6512007)(26005)(6666004)(1076003)(5660300002)(41300700001)(478600001)(82960400001)(966005)(66946007)(6486002)(21490400003)(8676002)(4326008)(66476007)(6916009)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M3lMMeA8X6QWXzdshaET6pr+C329IejwLOjtr9zItehrcVNX4XJn44JehJdd?=
 =?us-ascii?Q?4/fQRgsYaSfT7ytpmGSeesK2Wso8NU/QTHb6p9k8oPo4GdYpCnaSVS9/mtxe?=
 =?us-ascii?Q?cb0zU1t2OveutIvUIFRy9frajJxGrlJKQcPSh6jP+Noz5iKWOXYdpKV1wY57?=
 =?us-ascii?Q?2icMMgMYrGM4lXo195JbG2d8QR8sc15Uj/TBQ9eREIPMks+WBdRsUNENGsb3?=
 =?us-ascii?Q?UsZ0UywN/eiOqv0aKuwHT+llwc/ZLuvvUcedi7mXION8DqajzTcVVRrL+RNo?=
 =?us-ascii?Q?7mTpgk6hKmeRP7DwostuloQEJQmN7VK6TXfXnQo/jNcd+TwOIJZHO9Rrkv/z?=
 =?us-ascii?Q?QzAgcVN/4SYkWMeuui1xbkcfgyMKS2cL+lIgV0YwISieSw6h29k/k+gi52XS?=
 =?us-ascii?Q?gPOxCXepBmYpXcfADw1/DOMaOnqWrtWwhlaDU3BvSzTWc3IzYLPo1FO4jPHv?=
 =?us-ascii?Q?F4j5dMWo3dPRz7q+eNdse8RkmaMRCQZR9N7/zwoPOed5DSO8H/pmxJz3BJCh?=
 =?us-ascii?Q?S10EZhjGz7cbXKKS/4eG6uyvxHPBnEgiqKtzRTIBrN6ztikQneYNrmxncO9i?=
 =?us-ascii?Q?712fcWfgN6v7jHOW8oCIEI0Erpi/1u7SkCgLatRtXoNcvaArK9P1GOsL71js?=
 =?us-ascii?Q?VyU6Hj1CDIF+nH1Gf9wWU+NNePFfaVT1HDxy+xyGYEVsDtRHNJdShAeRI52W?=
 =?us-ascii?Q?DMg5tMcTnGRyRi1DrLhKocbc3qrBaetJbJjEwwG2elXG/seQ8FxPMjHyqZLj?=
 =?us-ascii?Q?Rw442xop2OSstLKtxUjpKA0gmgGfDTajdvxQKF6JqQiUtjZ1eD6ts+QH4JxN?=
 =?us-ascii?Q?iy7/JqD2JNGvdCRF/9FbhG4td9LNDZJGVO6NqbCaXjGPzUMW4ocrCg0I6BA8?=
 =?us-ascii?Q?i6voW6M2rDt65pphd3QmwHORk+OP3HZAxUW3u+ctUylkkbSZbW4ucoexoG/7?=
 =?us-ascii?Q?QxCskf1pDOG8RY+/DI3egW0dbvVhonfOX5kulveGfTgnpS9spljDSCJH/Rhm?=
 =?us-ascii?Q?c0wSWHsPURPhvC78hFe6nyFiLuEGMt/w8QR854c0/2jVAJJ4pi0WvAxxG2TE?=
 =?us-ascii?Q?+DZQ6PMqQkrrRgUqEHkXqUhbhhfUWsG6l+LLiTDmM+UedVTUDP1fD9O4T12o?=
 =?us-ascii?Q?d464JULy+/tEIL0a//NN8iXLysuynEE/FkBZ84fcexQm2xhPZ/nvA3bT0J0i?=
 =?us-ascii?Q?L6xGCQz93QV9XUFQ9fg18cU7PUxPBAlTlmZfb+edmO8tlc8THSlHwLlL+VC8?=
 =?us-ascii?Q?3Or6sdoEHXJb8UUH09hlVfQf6AlhrriHyDFIJIkLWIaQKBkSgwqGn5K+tlSi?=
 =?us-ascii?Q?lYJ0JSlQQ1FBoqy0yBOu7OlJ13CcM2Ilfsp+IGuma4J9xRB9FmereAAvzPhB?=
 =?us-ascii?Q?Rc5s8QGfzqwbOHjgXYhTW6+4QR2ZY8/V17eSq8liUF1c4reqia30rjQR6P6/?=
 =?us-ascii?Q?RygbKeCFul66mLOH/xuEHdUyxcWhuVmoA+ZSQ8tXcKwsiPIAtx9qBW0UhhqQ?=
 =?us-ascii?Q?15J4fGFoSZ3DJDziNZILs0sgxPnNuax70OIs7NJ7EoIE7vNx+URk80m5aCKz?=
 =?us-ascii?Q?CHOLUxtqiDFIVm2iG8NKXT4rwSuRLS6VtP/LCQVGMWffTahwaPF/eMa5qMEe?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 354b1201-fe4b-4e29-14ec-08db0ff93011
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 08:38:33.8255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/alE0RVO2OYf4CThDRPEjKxeJEG7RG91p2aBvjZDPX+SZ5l1W0BxgL6hVTMlvSp9sKFbm76Eszq30GphBoY7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5978
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--mXwfwGN2RzZ59ncZ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed BUG:KASAN:stack-out-of-bounds_in_unwind_next_frame due to commit (built with gcc-11):

commit: ffb1b4a41016295e298409c9dbcacd55680bd6d4 ("x86/unwind/orc: Add 'signal' field to ORC metadata")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git objtool/core

[test failed on linux-next/master 9d9019bcea1aac7eed64a1a4966282b6b7b141c8]

in testcase: igt
version: igt-x86_64-d2ca8db8-1_20230211
with following parameters:

	group: gem_ctx_create
	test: maximum-mem



on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202302161616.85f13863-oliver.sang@intel.com


[ 235.289948][ C1] BUG: KASAN: stack-out-of-bounds in unwind_next_frame (arch/x86/include/asm/ptrace.h:136 arch/x86/kernel/unwind_orc.c:455) 
[  235.297832][    C1] Read of size 8 at addr ffffc9000169f3a0 by task gem_ctx_create/601
[  235.305714][    C1]
[  235.307891][    C1] CPU: 1 PID: 601 Comm: gem_ctx_create Tainted: G          I        6.2.0-rc2-00011-gffb1b4a41016 #1
[  235.318536][    C1] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[  235.326587][    C1] Call Trace:
[  235.329714][    C1]  <IRQ>
[ 235.332410][ C1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 235.336750][ C1] print_address_description+0x87/0x2a1 
[ 235.343163][ C1] print_report (mm/kasan/report.c:418) 
[ 235.347499][ C1] ? kasan_addr_to_slab (mm/kasan/common.c:35) 
[ 235.352276][ C1] ? unwind_next_frame (arch/x86/include/asm/ptrace.h:136 arch/x86/kernel/unwind_orc.c:455) 
[ 235.357398][ C1] kasan_report (mm/kasan/report.c:519) 
[ 235.361570][ C1] ? unwind_next_frame (arch/x86/include/asm/ptrace.h:136 arch/x86/kernel/unwind_orc.c:455) 
[ 235.366694][ C1] unwind_next_frame (arch/x86/include/asm/ptrace.h:136 arch/x86/kernel/unwind_orc.c:455) 
[ 235.371645][ C1] ? orc_find+0x1ed/0x330 
[ 235.376424][ C1] ? orc_find+0x1ed/0x330 
[ 235.381194][ C1] ? orc_find+0x1ed/0x330 
[ 235.385966][ C1] ? kernel_text_address (kernel/extable.c:99) 
[ 235.390909][ C1] ? orc_find+0x1ed/0x330 
[ 235.395678][ C1] ? write_profile (kernel/stacktrace.c:83) 
[ 235.400279][ C1] arch_stack_walk (arch/x86/kernel/stacktrace.c:24) 
[ 235.404705][ C1] ? orc_find+0x1ed/0x330 
[ 235.409474][ C1] stack_trace_save (kernel/stacktrace.c:123) 
[ 235.413986][ C1] ? filter_irq_stacks (kernel/stacktrace.c:114) 
[ 235.418757][ C1] ? perf_event_task_tick (arch/x86/include/asm/preempt.h:80 include/linux/rcupdate.h:94 include/linux/rcupdate.h:762 kernel/events/core.c:4305) 
[ 235.423874][ C1] kasan_save_stack (mm/kasan/common.c:46) 
[ 235.428385][ C1] ? kasan_save_stack (mm/kasan/common.c:46) 
[ 235.433078][ C1] ? __kasan_record_aux_stack (mm/kasan/generic.c:488) 
[ 235.438453][ C1] ? insert_work (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/workqueue.c:635 kernel/workqueue.c:642 kernel/workqueue.c:1361) 
[ 235.442789][ C1] ? __queue_work (kernel/workqueue.c:1520) 
[ 235.447300][ C1] ? queue_work_on (kernel/workqueue.c:1546) 
[ 235.451725][ C1] ? intel_engine_add_retire (drivers/gpu/drm/i915/gt/intel_gt_requests.c:120) i915
[ 235.457918][ C1] ? __execlists_schedule_out (drivers/gpu/drm/i915/gt/intel_execlists_submission.c:613) i915
[ 235.464194][ C1] ? execlists_submission_tasklet (drivers/gpu/drm/i915/gt/intel_execlists_submission.c:660 drivers/gpu/drm/i915/gt/intel_execlists_submission.c:2045 drivers/gpu/drm/i915/gt/intel_execlists_submission.c:2476) i915
[ 235.470793][ C1] ? tasklet_action_common+0x21e/0x2b0 
[ 235.477118][ C1] ? __do_softirq (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:572) 
[ 235.481632][ C1] ? __irq_exit_rcu (kernel/softirq.c:445 kernel/softirq.c:650) 
[ 235.486314][ C1] ? common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14)) 
[ 235.490999][ C1] ? asm_common_interrupt (arch/x86/include/asm/idtentry.h:640) 
[ 235.496046][ C1] ? mutex_spin_on_owner (kernel/locking/mutex.c:387) 
[ 235.501161][ C1] ? common_interrupt (arch/x86/kernel/irq.c:240) 
[ 235.505843][ C1] ? asm_common_interrupt (arch/x86/include/asm/idtentry.h:640) 
[ 235.510874][ C1] ? orc_find+0x1ed/0x330 
[ 235.515645][ C1] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1700 kernel/time/hrtimer.c:1749) 
[ 235.520847][ C1] ? enqueue_hrtimer (kernel/time/hrtimer.c:1719) 
[ 235.525616][ C1] ? sched_clock_cpu (kernel/sched/clock.c:369) 
[ 235.530299][ C1] ? clockevents_program_event (kernel/time/clockevents.c:336 (discriminator 3)) 
[ 235.535932][ C1] ? var_wake_function (kernel/sched/clock.c:364) 
[ 235.540873][ C1] ? hrtimer_interrupt (kernel/time/hrtimer.c:1824) 
[ 235.545815][ C1] __kasan_record_aux_stack (mm/kasan/generic.c:488) 
[ 235.551018][ C1] insert_work (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/workqueue.c:635 kernel/workqueue.c:642 kernel/workqueue.c:1361) 
[ 235.555199][ C1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1107 (discriminator 13)) 
[ 235.560833][ C1] __queue_work (kernel/workqueue.c:1520) 
[ 235.565172][ C1] ? check_preempt_curr (arch/x86/include/asm/bitops.h:207 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/thread_info.h:118 include/linux/sched.h:2038 include/linux/sched.h:2053 kernel/sched/core.c:2185) 
[ 235.570205][ C1] queue_work_on (kernel/workqueue.c:1546) 
[ 235.574456][ C1] intel_engine_add_retire (drivers/gpu/drm/i915/gt/intel_gt_requests.c:120) i915
[ 235.580456][ C1] ? __i915_request_submit (arch/x86/include/asm/bitops.h:207 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 drivers/gpu/drm/i915/i915_request.c:695) i915
[ 235.586470][ C1] ? engine_retire (drivers/gpu/drm/i915/gt/intel_gt_requests.c:114) i915
[ 235.591790][ C1] __execlists_schedule_out (drivers/gpu/drm/i915/gt/intel_execlists_submission.c:613) i915
[ 235.597884][ C1] execlists_submission_tasklet (drivers/gpu/drm/i915/gt/intel_execlists_submission.c:660 drivers/gpu/drm/i915/gt/intel_execlists_submission.c:2045 drivers/gpu/drm/i915/gt/intel_execlists_submission.c:2476) i915
[ 235.604325][ C1] ? execlists_dequeue (drivers/gpu/drm/i915/gt/intel_execlists_submission.c:2422) i915
[ 235.610156][ C1] ? var_wake_function (kernel/sched/clock.c:364) 
[ 235.615110][ C1] tasklet_action_common+0x21e/0x2b0 
[ 235.621266][ C1] __do_softirq (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:572) 
[ 235.625606][ C1] __irq_exit_rcu (kernel/softirq.c:445 kernel/softirq.c:650) 
[ 235.630120][ C1] common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14)) 
[  235.634631][    C1]  </IRQ>
[  235.637412][    C1]  <TASK>
[ 235.640194][ C1] asm_common_interrupt (arch/x86/include/asm/idtentry.h:640) 
[ 235.645051][ C1] RIP: 0010:mutex_spin_on_owner (kernel/locking/mutex.c:387) 
[ 235.650790][ C1] Code: 5e 00 4c 89 f8 48 c1 e8 03 80 3c 28 00 75 6c 49 8b 07 a8 01 74 d8 e9 f3 fe ff ff 48 83 c4 08 b8 01 00 00 00 5b 5d 41 5c 41 5d <41> 5e 41 5f c3 4c 89 ef e8 e1 83 5e 00 e9 2b ff ff ff e8 b7 83 5e
All code
========
   0:	5e                   	pop    %rsi
   1:	00 4c 89 f8          	add    %cl,-0x8(%rcx,%rcx,4)
   5:	48 c1 e8 03          	shr    $0x3,%rax
   9:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
   d:	75 6c                	jne    0x7b
   f:	49 8b 07             	mov    (%r15),%rax
  12:	a8 01                	test   $0x1,%al
  14:	74 d8                	je     0xffffffffffffffee
  16:	e9 f3 fe ff ff       	jmpq   0xffffffffffffff0e
  1b:	48 83 c4 08          	add    $0x8,%rsp
  1f:	b8 01 00 00 00       	mov    $0x1,%eax
  24:	5b                   	pop    %rbx
  25:	5d                   	pop    %rbp
  26:	41 5c                	pop    %r12
  28:	41 5d                	pop    %r13
  2a:*	41 5e                	pop    %r14		<-- trapping instruction
  2c:	41 5f                	pop    %r15
  2e:	c3                   	retq   
  2f:	4c 89 ef             	mov    %r13,%rdi
  32:	e8 e1 83 5e 00       	callq  0x5e8418
  37:	e9 2b ff ff ff       	jmpq   0xffffffffffffff67
  3c:	e8                   	.byte 0xe8
  3d:	b7 83                	mov    $0x83,%bh
  3f:	5e                   	pop    %rsi

Code starting with the faulting instruction
===========================================
   0:	41 5e                	pop    %r14
   2:	41 5f                	pop    %r15
   4:	c3                   	retq   
   5:	4c 89 ef             	mov    %r13,%rdi
   8:	e8 e1 83 5e 00       	callq  0x5e83ee
   d:	e9 2b ff ff ff       	jmpq   0xffffffffffffff3d
  12:	e8                   	.byte 0xe8
  13:	b7 83                	mov    $0x83,%bh
  15:	5e                   	pop    %rsi
[  235.670165][    C1] RSP: 0018:ffffc9000169f2d8 EFLAGS: 00000286
[  235.676076][    C1] RAX: 0000000000000001 RBX: ffff8881acc1a980 RCX: ffffffff812cb45a
[  235.683872][    C1] RDX: ffffed110b145033 RSI: 0000000000000008 RDI: ffff888858a28190
[  235.691666][    C1] RBP: ffffc9000169f410 R08: 0000000000000000 R09: ffff888858a28197
[  235.699462][    C1] R10: ffffed110b145032 R11: 0000000000000001 R12: ffff8881ab068000
[  235.707253][    C1] R13: ffffed110b145032 R14: ffffed103560d000 R15: ffff888858a28190
[ 235.715050][ C1] ? mutex_spin_on_owner (arch/x86/include/asm/atomic64_64.h:22 include/linux/atomic/atomic-long.h:29 include/linux/atomic/atomic-instrumented.h:1266 kernel/locking/mutex.c:81 kernel/locking/mutex.c:359) 
[ 235.720098][ C1] ? __mutex_lock+0x33a/0x1040 
[ 235.725732][ C1] common_interrupt (arch/x86/kernel/irq.c:240) 
[ 235.730242][ C1] asm_common_interrupt (arch/x86/include/asm/idtentry.h:640) 
[ 235.735097][ C1] RIP: orc_find+0x1ed/0x330 
[ 235.740471][ C1] Code: 00 48 89 fa 48 c1 ea 03 0f b6 14 1a 84 d2 74 09 80 fa 03 0f 8e ae 00 00 00 8b 90 e0 01 00 00 4c 89 e1 48 89 ef e8 23 f9 ff ff <48> 85 c0 74 0d 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e c3 4c 89 e7 e8
All code
========
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	fa                   	cli    
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	0f b6 14 1a          	movzbl (%rdx,%rbx,1),%edx
   c:	84 d2                	test   %dl,%dl
   e:	74 09                	je     0x19
  10:	80 fa 03             	cmp    $0x3,%dl
  13:	0f 8e ae 00 00 00    	jle    0xc7
  19:	8b 90 e0 01 00 00    	mov    0x1e0(%rax),%edx
  1f:	4c 89 e1             	mov    %r12,%rcx
  22:	48 89 ef             	mov    %rbp,%rdi
  25:	e8 23 f9 ff ff       	callq  0xfffffffffffff94d
  2a:*	48 85 c0             	test   %rax,%rax		<-- trapping instruction
  2d:	74 0d                	je     0x3c
  2f:	48 83 c4 10          	add    $0x10,%rsp
  33:	5b                   	pop    %rbx
  34:	5d                   	pop    %rbp
  35:	41 5c                	pop    %r12
  37:	41 5d                	pop    %r13
  39:	41 5e                	pop    %r14
  3b:	c3                   	retq   
  3c:	4c 89 e7             	mov    %r12,%rdi
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	48 85 c0             	test   %rax,%rax
   3:	74 0d                	je     0x12
   5:	48 83 c4 10          	add    $0x10,%rsp
   9:	5b                   	pop    %rbx
   a:	5d                   	pop    %rbp
   b:	41 5c                	pop    %r12
   d:	41 5d                	pop    %r13
   f:	41 5e                	pop    %r14
  11:	c3                   	retq   
  12:	4c 89 e7             	mov    %r12,%rdi
  15:	e8                   	.byte 0xe8


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



--mXwfwGN2RzZ59ncZ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.2.0-rc2-00011-gffb1b4a41016"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.2.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23990
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23990
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
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
# CONFIG_RCU_LAZY is not set
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
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
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
# CONFIG_KALLSYMS_SELFTEST is not set
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
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
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
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
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
# CONFIG_ACPI_FFH is not set
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
CONFIG_KVM_SMM=y
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
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
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
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
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
CONFIG_BLK_DEV_INTEGRITY_T10=m
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
# CONFIG_SLOB_DEPRECATED is not set
# CONFIG_SLUB_TINY is not set
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
CONFIG_INET_TABLE_PERTURB_ORDER=16
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
CONFIG_NF_NAT_OVS=y
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
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
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
# CONFIG_ZRAM_MULTI_COMP is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
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
CONFIG_BLK_DEV_SD=m
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
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
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
CONFIG_LEGACY_TIOCSTI=y
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
# CONFIG_SPI_PCI1XXXX is not set
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
# CONFIG_GPIO_LATCH is not set
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
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
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
# CONFIG_ADVANTECH_EC_WDT is not set
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
# CONFIG_MFD_SMPRO is not set
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
CONFIG_VIDEO_NOMODESET=y
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
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
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

# CONFIG_DRM_ACCEL is not set
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

#
# USB dual-mode controller drivers
#
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
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
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
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
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
# CONFIG_INTEL_IFS is not set
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
# CONFIG_IOMMUFD is not set
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
# CONFIG_NVDIMM_SECURITY_TEST is not set
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
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
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
CONFIG_NFS_V4_2_READ_PLUS=y
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
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
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_SM3_GENERIC=m
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
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
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
CONFIG_CRYPTO_LIB_GF128MUL=y
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
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
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
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
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
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
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
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
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
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
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

--mXwfwGN2RzZ59ncZ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='igt'
	export testcase='igt'
	export category='functional'
	export job_origin='igt-part5.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-skl-d02'
	export tbox_group='lkp-skl-d02'
	export submit_id='63ec92f4fe9fd793d9c03032'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d02/igt-gem_ctx_create-maximum-mem-debian-11.1-x86_64-20220510.cgz-ffb1b4a41016295e298409c9dbcacd55680bd6d4-20230215-37849-lb6idf-5.yaml'
	export id='6aca35551704245b2f4cef33933439e4332d4889'
	export queuer_version='/zday/lkp'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c500746fa0cc-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e41514d5105-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e41514d5105-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export commit='ffb1b4a41016295e298409c9dbcacd55680bd6d4'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xf0'
	export bisect_dmesg=true
	export need_memory='25G'
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2023-02-15 16:08:24 +0800'
	export _id='63ec9318fe9fd793d9c03036'
	export _rt='/result/igt/gem_ctx_create-maximum-mem/lkp-skl-d02/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ffb1b4a41016295e298409c9dbcacd55680bd6d4'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='7902b53179c7749df7d6309a48886918c6e5da9b'
	export base_commit='4ec5183ec48656cec489c49f989c508b68b518e3'
	export branch='tip/objtool/core'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/igt/gem_ctx_create-maximum-mem/lkp-skl-d02/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ffb1b4a41016295e298409c9dbcacd55680bd6d4/1'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/igt/gem_ctx_create-maximum-mem/lkp-skl-d02/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ffb1b4a41016295e298409c9dbcacd55680bd6d4/1
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ffb1b4a41016295e298409c9dbcacd55680bd6d4/vmlinuz-6.2.0-rc2-00011-gffb1b4a41016
branch=tip/objtool/core
job=/lkp/jobs/scheduled/lkp-skl-d02/igt-gem_ctx_create-maximum-mem-debian-11.1-x86_64-20220510.cgz-ffb1b4a41016295e298409c9dbcacd55680bd6d4-20230215-37849-lb6idf-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=ffb1b4a41016295e298409c9dbcacd55680bd6d4
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ffb1b4a41016295e298409c9dbcacd55680bd6d4/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/igt_20230211.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/igt-x86_64-d2ca8db8-1_20230211.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.2.0-rc7'
	export repeat_to=6
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.BUG:KASAN:stack-out-of-bounds_in_unwind_next_frame'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ffb1b4a41016295e298409c9dbcacd55680bd6d4/vmlinuz-6.2.0-rc2-00011-gffb1b4a41016'
	export dequeue_time='2023-02-15 16:13:50 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d02/igt-gem_ctx_create-maximum-mem-debian-11.1-x86_64-20220510.cgz-ffb1b4a41016295e298409c9dbcacd55680bd6d4-20230215-37849-lb6idf-5.cgz'

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

	run_test group='gem_ctx_create' test='maximum-mem' $LKP_SRC/tests/wrapper igt
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='gem_ctx_create' test='maximum-mem' $LKP_SRC/stats/wrapper igt
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time igt.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--mXwfwGN2RzZ59ncZ
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj43srlwtdACIZSGcigsEOvS5SJPSSiEZN91kUwkoEoc4C
r7bBXWVIIX3QflT+sKzVYooFrJJ/12Zhr+XMQhsyCZsZGNDDisloEmuBKnh/AISsDW1y4NagGYvq
WhhdqtMCkXfUDuVn+UrzO/K2wGHlibU+SEuYzjcZhkze2Yl9RwNQ1B3y/6haY2Ly/y9x+EYxzibp
sfYg13vMZQo+eK5mq9aYI6bKAEtG7xhF/NAQq8MQix3nurvYQE8Lee0bzsvn30fnyVHikAf9yruL
Jvwh4JDZUA2MNibWED3cX1qIDVMINs0EDZ3uj0MuOkoS4iAfH4PKZQ1kRmbEwr6c6s1KE40F/+dR
qQ/eg4aEcJ0m2TelBC19rkYs+k1NrwgH6AZ4eLczf9ytolPGLS28uj6GVVZDWr9Le8omi02V8nhs
V+A+sLLDGxawk0E/7lz6UxqOwGNtPFq31L2bJ5vSRmIZjH0lQPCepGnLtLPwmWxnXcnImWm+vqnP
ObIBfqvJsWf0mdEEgOneUyVAfhXkPZp32XYDQwMonSp8xhbUE+RvTcFFo6r3i2dm/khRwXoz+Osl
Vd/XGrRMPDWOtbg3l3cJKq8B8/+uo6EbDk2NlcDkbD7GsgCdI20r61ox8G4jk8uyVLbcyvMdjgaq
rlYeHdJuMxl2NqEtm8x1zyCh8n89i0dyvrnzI+nhhrwmvYY+ooiP4vx8OK7OMwoT9NPqvHR3KnaF
rEFSjRHGUH+9+pMJBR2eyQ/7b9qa0aDpA4Ox6p7CARcBXWokH4O38fL74yYLwOsyLSEqVUg4gotk
OBlG+61D4SP2/NMV35OGzMH9rQA3fHpPZCt/mzLCbyXZIJeqhCG9xPsXKTby2W4eCKZ9CPWDsxbI
0tAMHuh6ipm7mBFfY4VpEkpjcINcT2I2QMCgWn8FSnOhRgLOH84wQur3MRlrCHIdLuIpDk89d5KZ
jR4PbX+jiFbcVu/08mEB98riC2P0JuxofyE3o/hWXE0lGjx+1MB+68NSsm8Gvjk0AYomcwQh3Yu/
+/N7HwHRv4h8dUqI2oXofARDysCigEhAPVkWSfYgO3B3l9HIpi3hwmoJZ536bhU0K8PigyITugQr
ATMDpiQcwZ36lm4z/nmCehV3ZrdYoYd+vBMMabiwXB4fvu+Xgc9L3eWbzFv4BVbwd5j36FOsEfIR
Y1yNr67C+KcZXcdJnP+WNgKOliYj3W82daJj6qyKE/rJbk4oCQTYnUBRmEjTDqMFxIqdj16bzyoR
G0GBWvGGM74Z7a0XevHnYwLNB/GWO5kzqm7ya0Cz9AAvaBTJ89MKwlXxUQeFUa2yifIpE2t3Dw49
HTwj/F/0V8O4hGuWDjbyjywgkacwgeEJ6/33V0PCb9AVfJBW0F2VUL2VwLFkQrTzlvGKEBoP+FOZ
mWDtrQmtutUnKyz7iwaAQCJRuQ8oh+kGndxCezrdPvVmbXQy2jxJKclZlpVlgwVHLw4L0I+L03PK
Vafvaw9d2iQfVR2uguB6sKOHllsOhUOvN7nxVojgX2t9iSPaKErcDOHaMlkrJs9MZELQMv0a31MJ
CWLwVWkeJGZw5ewsDZ7PQnSyuc2FdDRZC1VqbpcfxLP4Wfr7EGLRL1q2ggw6JVzifQ3jDbvol9rU
a8GnqYXmZ1rWYiPq1nl8eCCYbbXzZy3CRH8y1XwLjQi0OuN/XDX5Dzxfpv8TFercKqnkBdMV86Hq
Ooemm1a4sUzCnSEUqV/AKupbLmhdKBBH8Q9fB5Z9/da2yxxMbU3uw4SeRaaCKUS4Gp5a3e1MBmCv
28OKD4Ige5zczTs3bXu1gfuF2+n4JCa1uJ2BuCkQsZFwlynwRb4z1tnMweaL/tDVkUZBtMk3AB9h
hwvAmt12HAhoCtJCUA3a2TrY7bd6Xyzv5onn0WHyAnO2yM8MLeDpsDXaOqE4ekjvJ+mymCo1l+FJ
qBiJVpCwee1lAkua9sKp/oPUznKjRcLu4wopcoNlJFYczTTmzSk56l24jZ92muKa2+M/O19F5pUy
7YDaP+r0h3H9qaNPV8PSMH7dB5R97KWq6EUmoZ4DwMelpsGnliLcglEWGpyRWnPGoswyiPQmPwub
F/wTLgc59R/Hy+KL9X/yXTtEx4qTUFoBJSQd6cBFw884I09Fdatw+sIk2vEi/lDCSGWgi7Vw4/YA
2yTVEXrEJfPbczOdXszTrag4w7gnIybUt32xPcsaaxD9xy1pFBOxSxwggPw/YTOy2f/a26J4zstM
Ft//909aNcgMqbuGWF+hOQqMw+wcMGy9niViOpCcbK8BHPqaYE8TshVFE1e5Vm9OqS/WM3bQHv0f
OhyyrTMQf6NNEnZ4hdCosdZQ9MIqawNd5xnCUyYYmt+y0TfhBQpSHkWWDaIX0P5F+6c9rcs5KDhO
mF1CMF6mDEgVCnaxSPM8EgKj50DU3aI/GuDG3CJoJqVdAAkapCvB+7vJHFKvvsM/xux1t2wo9V6z
DoPWwomhU7i2JB23k2nFJpGYgkowUqTtCy3b3LnlpcGSKTq4VCPmmKHqFV5s3nNiGEPBAW0ZFtzt
7MYrvMqe51XNIw6ZGC0XROR0WYcZxx0M6DQ+eXA5nET1QWUuqpP3XpLtwSIu9vjgvhIpR7lKxNra
8ZhMR6tOjgv9dyXdl8zJWcuIc+I1kF+vE1JHr5F/IyLpqYnvAWHCOkPK+2SRo8ZnJArQfXTw7ZnN
LJI4K3wLo5lodVtYfZE9iY+fj7LBhY2ayz5UqsRMSC3Sb80XFog2w+bA2+Gm4zfXuOPchUAGIS7y
zLqNTHPTk0Bdxp0eMvKWCexzdVPZAGpq1DluAtNwHqL4RAsY1df1r7GRWg6ed6NuFU5vnV+WitCR
DzH12ZjPoCSE4+x6j2j1b/0L3iL3RteTaYLM/NaQbn+JKfs+Kk1P62aiSG5YPhBDO9/yEBc2UyZ1
a3GorEKcgDnRWk2TRIHy+AUrx19Jx+7RjE7mf0G+Ul/iicB3eE1Tu+WESbWGDQUR07A5aPr71oG9
+a0UQk3QcPJJzunJl6Ls0RR32d744fWIfKavyMxDvcBHNvxpVTryEICzImDSq7AoDdqvucjmiTFG
d7esTduFO2xiClnxQ7G4Vtr1mFoaQzdHheeVGg6G/qbfs1kNyUXdr2HlKRckV3EOn2H8epX6qcjx
6RqzAC45p3nK5OiHYMDwwJtnBU5lNmuwhufy1pLfYS2Rt76d8j+vRXgFzzxqIJBC/lOO3LT3bNad
g8FAe5WLXZfdlBdlfzZeV4MnbkR0Xex7TeUeOyaCtOy+fm0tIxppzmxeU1tHj6u3fPaN9WZw7O61
GbueeGiPU+AGgGAJfbA1fN4EvxrriXJZ1hGdRvwvf+rZqrJTRFB9y+zBW5LY5zeJYKn4RjTm9hBt
7YpgPFAxqZ02wd5ZdERL8razDqYi6gDfdBOkSxlO2oNQ7IrG0wek2+B2ujEUHoBmKbuthTXHxZAM
xkoz+Sl8CFTD4yXs1YUthMsfXT34iBGlYCIXbw//lqvZoU4Q+ZbnfQB+wq5g/vC3p/SONNvljjev
JEs/BPZINrAI3Gv4AEP9THt8ug0Rh+qJn0xzUsbmKyfcVN6b9fsEIivIpf2lN220yNRPt43CWbUJ
tPVVjiIxUfP0H2GVd2EfrRNvnQeCI63mc+1MywIoFo2ksoTYoCm3ZVUbanBDmjagOm5LIOuthec5
L1IZr6Ejx7f7Nq2pjtg6W67BgWZWDW4mmXPqMrvUgDkiQu8ENk4Wzkh5uuZ2DitWINbZ+7T/LhdO
24cBgU0n94RvidHgWdsuf0maGsqiQBHEqtU4DCTTQmTPGsrezXMXIdcaadfmHVBNrXHOKxZygABs
UxYphcCc6dpXII1GvVtbH6b4WiexMwMNUfI6KOd45BI+VXLrxFy9viRBnTHAL/FlHZL6cV6MR/lU
BQF8G5d5Jj9v+mTZPegRHLkT07rrCxOfcAh3GQM9OFnSX9VPjHwo0AaP/Yt/jnwQmHtNS9s9lEA0
2xNadG4OR4s2NL5Q5qIxDnJ2tV8cNx3Ha3Y8NQGf5HO5xJf+KU5hO0HCYkpM8RzHY3F1cpOmFZfb
nrSVYmme0Kc9i9HrVYagDOmjGRbYm5tXMXGT19kd+r1xUxSbVqAu0XlPN3twL9OT2Cg5Np2yhH5U
t4Rd38hHHeA72p/9Pfg799Mq4xvQ6otKW5fXsWAmv8MItVI4hexFdPJcSCLeKjQptd/CthM8LVho
nStDLvznRO+t+stolkP7zPMiXv5kHPaGDKVEUbmxZ1B22GTG6Jgj2VZs9McK12z8amNPaGVLwV5h
v58rLlpPLo9EXUhF1GfO/MHWN3DhTqZL5wvazYXfaIjqkP4pjN5iUL922joZt9Q2lcJlkiTRijnY
9XjgZyfYrFBz8643FSXdiIm4cYMNFSF9YBjkSOx74dF6vuwtRSZU9KKXPCUvZTKqsWxFr6ned8zD
ZGMbH0uSKCf1EuL9onDh2MFBy6VcREA0cFh1rhCVxsAfkw5R+euw9n+t0p29i66ljyNrqe0K2IWi
QMCi+SX5y8R+Kd+s6Y1UcWwOxy3YSZbl6ukhBTZucRI9ljMzoOgXZSNhcS4BhQeuTPI06KKUFWIR
meH29VthfNEyenevAsyHke7RQmY/8wPIImNxtjJTDUuySHZzRv/1+wSpvtFSH9h3h8QFkEgNjwMO
oqW8xLvppsJfIRQnbBilJrKiRjPFtkoZqR//L8va8h31IeMBfec6O4Hyckm/PEfEQvZyo36WSW9D
lH0AVhQA+vdxPrynjd62yGcD9e7GeZEDgo/R6cikTAbVxUA/a87kBKk4jzi0Vo3leAuE2MFBaMvP
wkMmUAJ7FolUabZONl89+fCe8+2zGtxNRj9TBOCx3Lo+RiMxhVoWNaKlZrhNqZezJ9ovKfL8NGOM
Pm9ooD+A3zaegiRH9/GdrRYFLM2qF5qRMgj4botSOojecqw0a/c6GNs3zqgl8iMHGxZ7uK99ZoLQ
7YuZ4s6pPZ1su9GnKHqbkv/XV5GHSxo2kP2S7SuIDgihBhej/WraVLCK2E67YmPe1HoKTvcx//Vn
ZutbHlq2SDZRhRMrYsAnLh8sa3Bmc7dzddtHTl8QB5Jl7KZh+hvyms4fpFK0J9q5yrW/syupuJ5/
tfA8rjYjYcv3Q2QnDNzC/DDanyismo+zeKvIhsEmTzuAcZfyMxFj60/1u9P06kI6HUo536KNUzff
4JfQO126aEOyavjZKDJ3LPOLi28c3D8BAejTJVgJrFp/MadyScSnJY80IS2IA+M8CDE/V/8Rbwpm
6MfNpI8gcebSPHFu4zb7tsYkkC9VVZA9tUbQEbN9HeTesRDEGh3FWViG1KeGq4FN/CJ8rlAm6ZXM
jeHnIykXCas1eeFEX/bjUCPdcJpy25MPONlmpHN7DCcAYIIT/9fSby3p2ZExm4P5W1LDZ2cl1/LW
HLElZdCgTOG81ZIluNilnDNAUMNVdNkLssQLLt/dr92pTukEninjIYOMlHc1g/rvZ4RYuWiOQEFf
8e3eARZ8ZbiBFBOJ/J3iPoz01waGhq66BHZ7jBhKoppdY6pRa+TEywFZzgJ6YNQcav4b1c/yzBIa
w+vbMYqtCPQ9UyLp69KlEQhqzXj3CG87dxwcOU3Wd4/940O6ZRR5WUMRVqFsm6EJGKh6y7VEs9Eh
t4oK7Oc5lBYJz5y3SxHQSf/xS0YfLQWMHZwWwtttrBlDMvKXHfQ650eF+HSpeeJIncoJIjs5OL3B
5Mq6W4exdHFCMZoxk2U+ZcrIu3iGw6a1fxXIMO0HFnSRdPqj52HCHhV6jFtL/4/RvDACFUwsTmCv
mGxs3OeijTTtonwVAB83jkdKS01JynV4/IYucILgQvcVetAp6NBK5BytX5yw8gSVEd5qk88bc4LY
rBQjXz7terxogDnF2fu9feXoBiKab2ar3nA9NysCicLqQMF7UmH0025p/+dN3q1WpkZ+NrBsIXsh
FgQNsFJotGUTP4nnWs8fKQ+JdedAIJVl65Iys52WGMxyegjK/SmgFDrzB0hPBgEo+hahJMvXgdtl
KdnX1f4Ql4wFOBvL4n4kLbGsx6/wj6TypQIj0z51VjeHiW/A/VDjOuojxl5D8fnBz0uEIbZcTlIx
4F/7OUhaowdL3OTqxhe3xUUJESql9OVXoxByXm5MxcIsR5tqa/9Nd6NbBV5xETDSabiR1tw4SO0E
KwIY5rBNOD4NiddNygAlB+QxoGleQEgIzZu18VtisbqoA0n9pZzpx1GegpamgaL+8ThVnzgRSZG0
igEdXaG9QUC3MndzR24GkpwCpD8gP4P0MdyqXNs1w0FnTMtp96CHqEGKhm2IWjWJKV7hKHv4FIki
bWGgs6oiweeTyIVZjKVtXCJY0PbTvXSO33dfXmMTphKaNrZqk/VaO1pVIY+OOfJVW6hBet86OOFF
vZ8o52BX2GIdU14MsGnUuXYOimE2rQ2C1yJ10kPMMsJ3uwh84VY+JEjb3ZBIp56VXbuasJv8bZu7
yCvu5mHXiq4OjFBqSBAIA61afoyI8Ap6VvoCRRMh8IJCTyCWpUFLAfNjsWqqDMuCW+ynjT0g5JrI
FIko636o3LeBp2XwpGpsBirPswql3pjQ4EXhyvwHcabyU0fbsYUP80JaYOC+481Cvku3wUWxPWsg
c26/zyYu+tKZKapaYS84hyl5am8ShF5FJPxLLpSN3UoAeUubWFbuA8h9U5we98kE5BlT9o44rfyT
PAHGRMa7+utaEPU4pFGvgd7RCwgjR6NjQfE/yfsx+5fZamciWDlzt2fbFO4aqwcC1hGl7N6TsnKV
aLfEKObdGQkOkJfEA9isJkAg9lEb+8pvUy75t8NmrOxaymIc4VgG3K/cpmfnLr26DQKqPmhvSmyH
rYXLVGC+/6TChNkaerimio9wTwLHUDklJDPH4IYrJrzhIC38T6+C8lUEMAI1m7jbMjKTD4uTDX6L
OecWzT+wod2rsOtd83ApQ8Xb2fb0sKnDC/ml96t81nSDiLhrrNuhHepuFTmv4mgEXvYJ3xeM4jTB
mMm2eFMkh61uNPfZHsrWt1M0YQmFxERSsW2DIiD8Us8CuBiHxUX+jZlS2a0ceN59V9ERsNDZxpPS
L7k1DZ4+KEkI+S6vQJld1SVnbVp/sns/9oZSUDg0CQ64CcNDQ/pKnmYlCF+jKd74OIpnJoF3xZGO
Pfcuw95ddq+CyxZbyTxl6sEluPOzEv6HvU59m7FtjWzv0VymScbSUOdjZ6Wo214voCIobQks3r/i
1JJO2IJOOSl79hP2ChAnfz/0wNb8Ph6DTU0ZoELK/C24qQfVN+/FC5yJmSN9/kl5QsnxGmwfFY3Y
CYWBjgi8rO144q538dPenmoYnCKHlPb8djyGlzJ0AOLbd7uadGJRVX6uh6zQSqWm7bcJalnD37Y7
QFuvZkSstDe/DCloPrttPZrnGnBB61fzLa+rJWTBmqPTMsCkMtmS67hQmfC2Bj91EKKVDJIkM0EJ
McMshzfY6i/bLCaypHaJn2yN4+8G7p/w0IJzOYvxlwMHHJoYzlOFba2Grc6q3bxObBA6OGI4b6nw
8XTxIaoGmAzC0XlZ3d5gudwZGVWrF31SYxtPPDuZsF8ws1tReLwLZxaDBadeXZbLof7uxVLNlH8o
K2r4vlgcnEPbYShK7n1C/yLwa7xV6I7In+BReO4ZA38ZZ6ouo3K2qqGV+8ldArdM5vBesSsBtcfi
Hhnyc1MSY6hgr9/SQerCs8EzHBcjs5gDwTZyaSuI9nk77DeTAHB/E34y+HjLQuKv3DGNFBdRiCup
m9VTO8V+mHnsalEsd8VziIhx6ddtPshnz8/QsOU+opPr7ho5ghRBLDZAL7Y7FZACbfvavFoXVE1l
YtrTpbIrad81PTCicef/Ksg1W22Q8sAsPzJtrRN28PzGivkB4TEiwGMh8VVWuerZ2Cs1pWdDl+43
5uNV3YMdGPM2Kvc3KFldjN2QWpEc21x7PDlAgtB1OIeARe6iREkbhdPBsPxtFTiMA6k2fz95G9qX
zQs6KR/Yba9nCMx7H4lpdch3AwrIlpaiSHLp93zvG82Zqdf6ofNS1VmR9SM0A5QGpn8bYN40g3QX
+cvaUXPiHSbIPpj6fUGesjTBQCaWhJ8gB4EBjFsIFJo09mO3K0Lva36ZVTXcEG/4yazwpY4d21Iw
B3WD6k522IJ6bmY6x9edVco6a5zfhjWQLVHZwvOmSxPMb4gqPIYTuZqaNlj2FKoxjyZd54ki1zb/
Q5kR8gxjU+NOEuM0NFPXWUyw51GJbICOJzV174Yt9Qc4Iy5ppHsc+bl1oMPwcj9zx2nolUOeZ6S3
bzhRsNXxkXGkmyh8q6iH85mWPamQpP1chnuXZDiDdXh1EqRmzvwJ7iEix1XzGN0TMiIstjZENme2
cBRE79ZbpoU5og8SUT1XaGmSqbdpvjn4mP9rAWmZ3kUbeUc/rYwU+KAU7QIJ093Pt1r7KEmW+tgn
+Ua59Zd+tk860kVefSIWmo7GbG5cik4zxWCb8k4Fbl9OnzhQ4fo0/AojqP3HMVVZxRlXkT4dA9kV
6nEt89bmWVnmqaBQ+15OGWyamMd5+5SuMSozApoiJYb2B20apgZdT3+eVn8uzZNhLEk0hLlytzTs
GEeXxhukEAWOCgC7Yyc+W88+VlqLzRlVHcgOiyBbPN9EEjP/FZOxWdN1ryz2Qh+xX2BCoXh7sKH2
b335M2EfXIsb2R6n8u88O/THjW4GFOSpLJudaqThvJh1q3eaEBoMh7Afv8LIvLmYvNJih3+mAgug
rWGFjNyGx2HIed6Fs1reBVDX25MY7nI/iU2cMbfOvdW2ldDiD5yBhdP3Ua+OwjXeUsZGBZltVVCa
bllT/tO+dpz7fjkV0Yb4kGoNGEA5G3PmKyHeRRDOC5/qRlHb8edgopqQKnfi6RBuVX+fmODX9oLT
iy0GgnyJsMob9l7naFUWgMPmlKdUg9DLdYhQzkRznmdZjh9O6+s0EgWaXXcl7OTkQ8WHfOR9u0Dz
sNgJjd7aBbDypq1D58mSRzzqODSzCuacD2JqpcAo+WdRTEpxCU8BC89DWWeX5nMycwmhmF2GMg14
M5PwdSIIKbSjKJ7oDLJdITcGxHMLqaOF24lUBEHG6k/5/18xt5jLSb90x0AQzkqoC/0FqFz3MLT3
ScQoWtEdbO/OGuXxIsf8N3eWFHQZOvi2J265TtnJ2tbp/DgodJtXnsCiP7NdzKOjn/wr9CPxXNs3
G7NHyDCTqlNJa4QTLd2/yHkdLx8JZQfQsxkkq3gdZTYhg4PMf+Z1bgeIHrkCdHNF2xceCrf4VLyD
6RhdGKoFyhylBXtLH3/E8ZmsVlV7BcZtNK1aM5hduBK3/OoyXvCRAFJPxQAoX2eyJcSZBRDi4Qxe
VEx7ggEJ1qj6PYNHyp9dnMZcxp85WvNL8vLIrT9KWEeK2zkoBXzQbpwD+bDJrjA53qF/UocgVAcW
FDYeHymsKqagDDq6nX6k6FFUVFg3Ocw2bR6eyIGKF91keoliaIdwlapIas510F7tdCT6PPF90Gb0
b16uYm3jq8SJtWyYFSysjT/liIijxKwWsz/Qf3m9byxRXqW6OsfuNgssLWhJ8ZcyUdGMR6f2Ccua
AcPiJAr75pKO1sM6dxXga5mELBiVv2U1HN4yBwPH0jm4RX3BPJUrwpQpg1GC7TuPTMGRgoa9Wg1m
8n1IScROr5Wyg2T0pXq35uP36agXMVZAbSqrWY/az8SCpcgJdMX2LBvHyZRiBIre30psM6W39BQE
6FfnO3HSgLW3XGSI8edjOjTaMyyq1LBlLVamSNzydC4W24a05ie23k/JcsVbN26ZwAATzdCv0QpR
9F0MLahkO/rTOg8hFuFIebyQNb5OrwTb6K0jRBvbYobxvEkyEUko14AxWqCbwDU+xqEyyb6MbK8+
KlthCcBWIVyTJeVWX1KCjUrsKNaWo9xY0hSggpOi1dSAIDi2wv2To9iA9RRwe+gtOjWWYbuV8hC7
5O7tbTKsHt8jv/r8pt4g2RwuAlrXc9IVCwxJnmwQ0bJC1d08tHpFhfHxq/EKgTGH3AoJT09drlhm
Zvs8IoZjyrDmXXjy/QyMwp3sQjQg4f0rft11NlU/PnGVkMRy5+aur3LC2NvDFayUwaNxgsbh9WMe
NL98xEJz/dxUjxvUBEw+XGwjARNG5b1pt15fggMS1HqWjhriUKomaIthGQqHLPKt1z7jYyx3mgDm
LCbA/tM+yYR5q7xARgeFXdTuRhTJRKRdCgweKh61EUq3G4vC5ub6muebfGCqMbCsImOaUEgTiiu4
dq2vkaWYM0UB9pvUxRiLSLngTREkH0su1W5SjptpjxBvu9wJPaej93k1hPj9bQkhC8XB8+b9QoeV
/JvNMEAvR1BpLFj+Fss5WoU7AogM9omJka64XwBfkC+nqm9JGbFCaQG8UNUVd0qWPItHKdTzFYRx
UOVnmF4BlY3W/cNGXqZHPH81chc0crmaH9ZO7LX+/OUUE20tgyY1lw+em0oIbp9X2NZrGZ4W1VQg
xNh/hJrwBpH9FYITjZf0kE1tsFRujWm5Soj2ILzYwZzwkWwXQ5MCwBL0aDjLY/WzyuEHeXfJmMxH
TNDZWcZGIcpuaHaRAsGUFL6xn4zBHHNqxGX5vffsBvBvDBTA+ekQhgZkoGIE40NzV41xk0vtNWxD
47bpipWZMhzzlYI6FZaX+UEqqgHt9ylxWPDT3B6mM3YZtFApkh9SZYM61qczG9QgFDB02vT95llw
nedUPGq7VZebrI52qVOveNzp/GCNTC2STrAOvHUE/WcMvEmBKcZzrGht7IJ2jpK0g0mUM7S47yTk
GETd0D2K04E2WcHlObgO4gLiDgjoIfRwwUFqu1ZQQP3S65kCXPiYYlcSfJghOIaO7paWzgwe6GmC
VqJrFB0hsLdUulia9EO/qLhx1lN6cMA8e9mEuC6uqe56o/ej3DKYII4DwdiZ13EI8FqEFbVy2qdw
1CnIluTHWESwWLNllcQiatSiRTRYyI+GzrGjflz2gb3/o6leFz2wZRSBbD5cTy8PfhgW9BBI62pW
w3Fet3GGndGV+QqCtR5JIyCjDfJ9zulTRgPSzfwlgTxXujLtwpnjrhj57o0/znXRl2HeiGsoJB0W
QOSRBMgjEhOhIZcg4s+GnLYzhzP6hZiqj+MsAluE7xB5wzNQrk83majOUZaobm43gMYMYCQ5GK1S
MmvEgCR5HtckPIjyzCsw9HvYLW3jFRAN/bgHRz9NSpcsBlzrt4DPw9EnC9gQnB+OX3djQSIjhPlg
nkUgZmlLV1agWHAbYAv5rEGmo9uhFhcJQwg9Y7ZuaUnxsgw6Lj4+ue9tP1uXdP5nqCPh87pJ3BUA
+YzOevMdRvmyBsQ0b7ccm36no+KUMX766i+7jv9i8IJiTDeZKlpvev3Gl6zCpZkLHtKpMm/rj6Hz
46LZDfD77tZZR0ihs56niaY6BEh8NfWqmnfpjT2Z4NZtPZ4v6VxpBLnk7O/rdPn6wEuBA/D7j34a
fuMIBOJXz/sgrRqMoP+tXyPaUoTfGcxRXOd3vrYdK775yHlSDEpRytvr1JkYz3bEHx50xTm9vaYG
a8+GJ1qK+U+P5SEjZS+oOQY6cPs3Li/vUZzSPlXhb4wre0aGXBw91rSJcL0tV97Pmykp8nwr61X3
kbLJ+qvyQ7xR1CcaZI01ESRFuxQU5NmwPNPZeHsqd6j5aHW2Buub9pdpbCAkNk/dfk8ogn9qA+oD
lNLsRz/5YZzLSPn/heS2EbqPNVEM7ZVlghexYcQ7nfVzX3oorbZXQBKDetd8Uv7Fs62SckT1bLi/
LhfbV5vlGlAudlWlJltGGDvWI+hOmgB7D3o7wMKVbSD2Z0pMYcGhfnEtF5gU8BBzXO3akZ0fc9Br
tVWX+IT/Y8+er/IYWM76JNIL9S99JQeU8RJOtwyrv6BmiwiOSgI6ITuMWG72Bj5TvqfY4YnyVUro
Mphv65yfqS3bqDwLJDduQu7TMHlsWSr8XzFwLXFP3EpnQ8XDcfnBZ2Yf4ZncING2f+jrV/YNBfEz
8Q3B/mCM5MmWyQ4fQW3Qd1djf8uSpo7ssxdA9s9D89tRKvmtXotHnwTUY5yp7m1jMlBvykHVj80x
T62tNEb8Y+It6ZjJJ9M1comfyYPSlfJ0Ud+SZ09mnHYmjyyrAQXFbzhRqTRihSVMVjFNv/WOE8Ax
NS1XzGZ7GRp9fq6M15QmzKiCvHeZ8Eu7kaa+3A0rKoaZnIZ0YDzTPSw3a45coi83eeWYJtxV1/IR
9YOWyOAJWlSeQT7Lt57Yq9ngfJpBUD1Oe+uIJIhhacrMtykFGEEnsQ6q2RF5jWj+MnC770w7YR9N
4jzGk7UPXmQjezye9Z+etCWgtuCu8ykwG7kkY5kDK5KTfa/j7FygFBLEWrOGBz6HkovJF0meH9jR
cZ0R9D0YOAn7//4KeAgqVnwQSGJI8lbgy+lYg+2Q3KK+xQjtRRq0htX71U80nj9ZIVanqHqu9QUv
z6msLY6+wlwv9sU/sqDR1fT1X27SZ5PBGRAVRx7/JJ1fONKxslaEuaitq9+Ws0WWQhHeA5wSa0Vx
h/hR/Q7NYO0GMBV68cruSZmYOtH9lUJxfeSoxgX8v6qSqRoyCmyVWAKDOfsQq9zICEnBLGqaEGFh
Kqn3Agj5kz9ZSE+m/BOnTVlT1ai9lHwixMKxF87anX8MuaS7SstgWecGOg6oBwf2anB06Oo9dtwO
X7fibgEjcJdpGko2vYcMryiPq+iwxVEzmpJwVw249OB5Pm4gaCcYYsij1JM8z88FvCCBpK7PlcVh
/kiRWqU2GLhgWJBSPBKVwQSIAXcQn2Mybt8++8orXDXMLFVX8pS1RTg/EPkT8tyvIJZdPy5NU16R
H3SjsMuVwl5nXI1rx+I7y5wIT2uOMCNymcedfUFvOFAIwaFc40rLktGkFYgLLl5CL9S7sJig9l3M
TUAvKRuIxuy4Zd6DI8CtQnDGHho9MjsD2MYY28q4ofKGnBrfrf6j+8VAkek/C5oyPERfoRimwCuh
4s8e8eNWinah42/VoNml2T/0Z7RLm+8v/DEU4nOmQd83jSxGEc9970BYJVGbOhB9j1YbB55pWzZv
UsZWZjx4qQmMxHETB2OrG0itdSOB7l0VGJ4M7GpHrkhRSh7M7/wX8xlLfC2VVuXi8pHZBIWNMvk5
Hl/IajpdV3AU0t5LuHLkDmGlD1swjrR3PLzZYIxuwild3kN5scWNpxS610sq6tHqmyIpE1+/Cfge
iaWRY8mkkX8oBj8vVaWiryg8+2vAxeEQQfX42TVn+6AC8JYPInnnzUCTqMXUZTgx2hQXFUFNdZ1H
mJ6wBZ6c3ZDQJbf3H/vw1pUvdHCEiqXJdO/4WGISd73gmYjKoB9sf6vM/QiD2lIdlz7y6VOvHfKj
nwXxakX6SWuKh3vS0p0zl6+oE9vY+0tee1FBVm3XmFKRvOFoL4MVsyoYBNrZUWzDVVXv3QfqgoGD
I/qMMlRDMRqEuQKpK0lKX1ol3dabq6fL2XgOBll2OnbnwOFnA5EuPhwiBrW8Xw7O4v+I5uwKAXBO
xiwjx6PfvsGKhB6+fP31LzcwWe31J36CVEB506/B1i/pCgXgWh/C1QX1+YTRQl/k2nFiTP2qq2Ex
WtzcDZy4d9MMFXe9imoG+72oeTyP0C3WkkCIUUAmJUi2bAZd2mq8vfCZD8zbwWjOAtq/W4rQQjgC
dfuSpY3pu2X4O62NSRMoiChi7bEijjXtksAhlA5nYUx4GD04dbFbL1+Y8PdFrmiTBcS6Y1XGUnW3
F66lneFTMN9jEahp0QxYb2c9NFFLD6nupW8FlckpTW+SGbDQyg/iRttz4oHWgDD4bPGXfoZZwSCQ
mgOjME8+C3iNPxFv56yc2zyxIzU4Kf8ptBmej08WgDKGT1k/4Qv43F6U5fdkHykBLLhFw6J5G0gr
JUH5CGGmYb6nB8sDXMSJzj/BVCt5DyRqxcqLPhZAiD/Zg2rRPsQmKLhI4QA4IYUnuheOt63xsGkL
+yk3TJugOWywbxoW7UZmzJrZ7PInSZT7W2GC1qoVG5kGdqA6vF2dww2rhztlxZk4uTwbdpavG75l
cZsTcewJaFlG/ZvcM0jekCqGK2EIISa6SROyuJ5D8O+bKRANSeVTIptiKF7uP+ED0xkrfZu2cUZW
1HzUOXSHWbjfKpKi3El4+xkZRYPzMFLS9BcMKjgMHzxmmRAusYtcN3HaDZInRmQYXaVE5VtOZ0z+
jgRa4EF0NvZoeBjT/a9eSaWIqq21BNr+kAEivHdTi15RFUOtayF5UnWNj1JxitNNND3uigWqb5FW
76LKj6711uXcFNuOxMA37OGdi0sBrW6+88QnJ8GznFT/FKnnNAvXcYRZoPAzj7lnWNwYkoGlRTun
AkvUarLQfwHBM1zjZowmB/ajWC7Pr/7vxYhUJvqiu5o0D2XHa3vf1cRGOe6GwiGwgGxjUZroGeHO
WYeV4EXisbi6jA95iKewk5jyE2ZP/eJHYLKuY0QbxMmsawtp+7jA6P9Qidnj1YsIDvwdzmADgMs1
aE573TVd8B+KZ2u+tc4RM0t1sMVyD2PDnyDfx12EToTUR1MvCwBVgh2tf8CpZ5deIR/Cr4IeK5Lg
csX/Qei/xRPXrnfNlqLU1qrClXeDOL3Ir4Zer4Cb88vCFa8xp+SD0bqGe/MtBUEDTWwIZ33py9V+
3DYolhMHD/zyQseMJEWwbzSKlqWdSpMFDlUa/e/bzrQ5EL7vlhgLyhHhw5xyLMhCHKIidsa8Rkbf
p2UxnlBylF0U8htcChKQPuXSvqzlEwKEC3RxDCSIB6BWKCdu/ODt2SeHV2pMNCR1R5zqt4zSfgC+
3JeHXfBJ9l8nzhGIfdFGx2Pv3iZQW5PbOCaASjHbuWmZx4RPeIm2TpcqlsA6YMlzg8A7VjUAstxm
lLLz7KASmvdpS9RYBA0nz1zkSSzOeRr+vU9YTTMM1wuafiy4qm45kQY0zZ6jEbCxd4A/3I5PlZVz
yrXIgXjj1YlNezfC10TvTIema6tRTb6P8g+r2qtOTDAxCAYiy/HTlhyYC4BR6GI/cza/S8JAa/ma
pvUZ14lHOS2RkkhS505wmFMyC8fqTdPxxbBpdHsD87uOK3Wzg1olA9yP/w9gs+5RLVT75xUYhitf
TEsN8rmyPkH36yaBqgxXxHElN0A9GdqqLuKRQCq5O0Bdnd2APSVR7KJ7txgvcpS25zOLKc9BjYsp
GYrEPmpErXxCnzKTORU/xZU8NZalqS1zxXPyMa5JRI6f6wmMqsbm8lSNiH6pO4o7fb/2y05bF0fk
lVlYA6HefOPAIrls31mOEyugq8prjweuvv4UjXXYBfPYfsz1u7Y9pNbTIhYDokIW088bfdywgjaC
A8cFxdncCJ9TaByz7WOQGX0/O3kjKyCTsQ2oc9Pl7sMaJ935rywRFBsfr2EfWH+/y2ufFNnssH+O
wgncvbguUEbIeMaU47Fbgjkuv5qy+QhcTvu3mc6EGaDkFJzHulWTuquz0Y8UNM0iSUNnUgF/WQ1R
EdXq6k/+CmVsDdhvHi76fd6MtL2VnCt9ELLSKTnJf/AmMURyxUsjmIS96cAg1J83yeyhGS9p16LO
5Rs2R4Zbez5vSzczrzw+tGpveiI/xJJXdgmAjyD43DItcoaKTQ8zXfvYSiRJX0rMCgmKxuRDPkVz
0z/UwzOLmKow5uAE9ykVaouAMM5Dxa/ighB9zdiEzwBqoKl1DdxRvFSVrbaRAgDHn5yFbFFEJgnN
XQMAANCp7COGG/iEqXtrlJyDyZGiBh5g5lzxT6cpPzPuBZ49C5qWA+zWx0TF1o6UpAQpDB/NzJ/g
/rq/qB8sT3GqX0LU9nUVfj74b6wBq/JEtnXuMgy28FlJ1srATJybGay1tcx3iDXar3R+7QAz5Jed
nirZV6dljGxkumC+UNDNGHip1641ZLxdc0xYZG2mmEq7ikuSq6lk15pN/4ULXsGuNLb9BUaGZh6D
/W13pxWNiHBTVWmzx/2HrhbMKsi2iQF0ZGNxwIeNVHZEmaz19vE5o5btIf5hJTylMqioOlTPB2eA
a3YQB+4OKjU3qxXmlqIaqpnQMyN/e6hHL+FM61aH+Yux27qIx4W6MQq+DIX6Sy4e0n8bIYZAUeat
uDoVkJb7hsyr+Rzn7MwBK8FiiDdN9eGzIQDRrUtyLu3nwMFAoGwnVxKYAHBxHwI+fv2MJoHZavsR
itqk9O+1yuwBogB3vcq8GpyAn8N9BVopJUW/xXN8TcI4zPMK7dwFjl2hdbGJOQQKyXWsBfA4icYb
QgeNruwKjBDa9G6/PSfQqqFzpLhWog8E9tVXy3fGiQOrqfwIRwGUabXLh3U+uUVDFZGyZR1OiZT/
ADLy+3NmNdN7j+iBvf5BoFNQU5NYJ+5zTr3cRVwnqWEh3pM3v9Am+mS43rstkn4cXSDF+PBmfTMI
LJPmuA2lZv3y4uvgIbBbK5xZwm+FnFWQzRLpfnVw0LNUsBhCIp/IaxFMZjxkYR6fsdBI1Xt2iZYS
6+QaaB+kECXdoEY6IHAOtIqXIzbpsCYKLJWaKvLjTZkAtlM3FoMG35P451/wWje+5D19Go6luBOx
Cdm0Uio29Ia4iJi4WhWwet5RGev/klEjXsZn0CmyBCaz/ya2zTCjKhKI1WelD1sM/0iNviwX8tSP
1DFHppFIsf+C1S6RB9NqOEEwehtjQwCX5t2wENDLa1aI/X9SZtonwIGDhYEru5lcTDzJebPPa+6d
Fzr417bJ4PZFVDeE+/JrbkfmNY1VSbvTlFN68BeJrnllU8rd1s25WwIcrIk6im1AlmcZpCYMwtR7
b12LmLwQzLaOq1zIXlpWuetrzMCuJNSNN1fq2NAeOq8IJiO/Zi4QYX/oEdn0ni+XLZ3l2kd7A/5z
iauAqSnMmgIgd/g3JIgIvrJ91cVZOKP4sNVPctdQSqDxLyCeSoy15dNcSKUC0FgTuvBUQAEqBQ06
t8t2IEoWwKI+xKo3+qXW2hXaLBgL8zhrtYFpwIoscEppbEsXzWJfepGy3Wlp2nL1RtVbdCItBBAw
fAbpytMv2z3DaY57n/zy4zHlWdFqVGmosi2tPff8bTmMHR7Qpe6SYUI5ESaEJR3Fp8t992T/bY1F
GnNvLXjWI5oOBFzJR2J/3+UdZeLCxxy7Vve/WGjXEx2+ao2cgmZ8FUlzR0FIWo34sRQIlJY4gLNI
puKkpbREHb3rLC5evxTve5uG5hwuLYumqvIRPskmx0EH90sIBdO7rpoyubW0UTqJJEDdB7xVefh5
PpcESqjkCHiWzrDCLIYxrFWaO5wDP4D4YU8HryF+7fZKI7A/dR8BYXKAWz1Me7t83zCdg+AWdlHD
bSfAJxdI2Op9JbxKQQz0TjN85gTo/Ts/Y+UH3aZw4apSdDAzYk0zDe7oydO7cgFezx46RG4IB0KD
3xOkh2CoVPteQsIRDb/Mnf4kvcM6F/dXonAhDix73Zd0LrcQ53Q0uDbP2ym5JKsOlsXqbdMCkxsS
pPvMV9SzQB1/B0iFdM6DKpib8k8o0t3DWaFijQTy5fbaowC/IzWKl/XT6wMKoeEvS2YHGvVSDedd
8ov9u3IHT/eZQRkLjMROmCB1Z6mgaSe2z7h+nRc8hOaehcP6eLFog6Gxh0/vV/+2w7RX3VcbYcIn
abcBh4uu2tjip2gh/Di1n1wBe6Dc8d6qozJwLQ0qsyihGV6WIsFTwnQ0L11LZblPj9PlL28iD7wN
57XGFwVlAsp7Hwj0nEK4j9BrZtTClMPOys8PJtV8PWD2OiVL96Rz4bG87dzQp+XnGgD3TmvAbN6g
C9FYtrRYZhPIbvzUCY56vkdHQAabLa+Buf9xS1oLDu6Lrj5VGejc2DAgDUFIFdoOZ3GHNdQWi3t3
SILQVjcl3Z5Cd/jbT/30h0JHgP1Juh93s8u5vKRtQoXxg/8qBHbw0YJxtOBHlvc/aRtKbKGwmMGI
BlSNHKJuM5KLEnHUgwE3WnFJSl74/zwV2/Zvbz8Q1HaqQgnRqaK+CP1N0vCntRU0xxDVvu+Qhbw/
plfgiFaMHPkpP//c1Da8xB5ecbwlvfDKCkzESe9l4avKJ9ZzBTKCY5Z/X8os7O65ySL9ctyWpRM3
ymdVjI59Fz+8SL2bHoVXPcySaKL04s+8f1R+Bk/EsBz9eZ52rzhbQAvRm0j5ZIQssIg7f+UQscQ5
t6BR82LJjE6uysC+a2wjmxcmU5d2dTqhrGlMuMEBgfdUFNBIwzhBsRleElQJzdwZQTg79HxV6qUq
UdA1lX4FNsZzF0BHhyLdjHu1oh0ZBFuMt0jJ31uHJoqhyjwBKPZ6hjzWXD1Z2N96Ui2JgUNEFDYJ
ZHJUyJh2ZLs+l7CquSEuT2RbAYsBdl1eXGyj2UeJxDpcOKHz5luz96WAtOO+RpVeJAYdLztUy1J5
QyjJFeX9eMZxkOGSqx0XAixN86f6e8yh5+F4PK8a9bSmlxXZk8FujsIOyryse70vAUopRO/1mLOi
43U2phZeX/AoKxQbmkzx4nld7+ROQvOr6LeGk+9jfbQNkAHd+846SyN8BeUA27bEUN8ewHV3/e5W
VNjtP4rwsn5G6vwlMm0HAlKjF0aS7DS329ZXx1R4wSWfVdtSIoboWVyA7hz8aFB7G6ZQ83h0/ViW
ALd2gmr65FUmsdDp1jX+oxObW8x+ave7S8JRK4+9fvejf+YPLdks6FhHPJmZolTX4yML+BOkjhFc
rbvu2Os9YEdjVwlk9086+uNH8GZwzb6H/fePHvYDJtFSlOl6GSDDxSIVPdfLbPsM7ikpaO2F8Iyq
KfU5xsR1GqhljMjZdAltxsP+CAmaeXnFgmKhpQeX3GExb+zD3aE3Jqt3901IF5ymaPDprFaWTG1z
CP2ALyWh0yqWhtwd6dGTZMBBQZ6zTtTMLAXvA0HxxJyOSdkUBQkfmnKMouql18RnfkmTxpToIynH
sG+BrgxhzjMXphwjSeUqgOwCGtZkOj+WQbc4hhVc8Lfywiji1VQdMnZ2VZ9zqxMN55rK751HlWFy
TBODJeNAkGTXclWChGh2XCfRihee4P7tyxbZHJmomS9TqvaNcFE3FdqBz3GipQsgjHxEzd9A4dEQ
BwYVvBOa9au86LDj+gAf7XFPMj0REu31cGFQwK92nbMwHTsefRFL1NgPp+E7Feg1mz7ELTPGU1gA
vuWZ6siZKTF7Fre2UJaelWkrjSICZGLS5eVg+LENKZAsDHxQKw7fj53NTN8tN+OWBeXek6jLkxm9
43TqXt85H/k9lD+FSOU7nS3l+LS7VcBOYMI4hybu14zNuKugAfMuV4j/hqHhehwbiOoc6PvHunyH
UkokCqiO+qYqrrQYNi6pkRorArfeixDmjRGo2qK8KkhWX/a6Of75XeKnrNwfumrEcsYfQHOC90W5
/wFV/UZCqT37pUb1e2I+/2BNF2mh1yiD17dk15DPd9DK8xZ4+FTMi5UN7Yxe7xsKNjjE85Et+BPW
aPwbMHVNF1WliWbAy1GCFM7Hq6DLAy9lYSbZckbIUHGRq3qCWAN4haQsOQgbMZDjF9efo6Y9pjlc
BlfKrWVGGbPxQq+0zkq9LyKRQHgLoqBCnHOwyueplczpJV+aZ6mfAnwPHTKpdzKvOHaFNYwjp3CA
dcPIAfLBm//XdL3yu2/aZnnoN8TR3impNB8VVr44ifzEu4Ws2YRE364cgk88jgcsWNkbBnMiCjLa
MH3QoPMBS4+AKjnFrOlcgRRkCjhYp/AW56uumRpyW5yWRgClLioFMU+fDMqp3auM5UHj2GZ0HsAo
b/G8Jda1MJha+oB7P0fHWp7UrdBDJmmY7djD76PmIJ092/N3cFrbMSbo6Y1OetjiSxbyayejbX9Z
x05mfE7/x7MFQm5DTTC0tb5srYD5B0V8UyIzEsQw9PhfBEMFWW4BGFFMaO3mWXbiSYFXF6vGpQBU
w28M6iLtyMKy39fJYxa9tKqx3KjyeD99tx/syGI3eJng6Q1w0e1gFiqNlxSlF63iln/Uf3I7SMQu
C0l6Swd2qdqU41THYPyglMGUrQz8f4HRRiXrslc2OytKJcvz49Nc8AodtiiQzr+Dr1Ue+d1V8TWI
CaRwKGtXXWdOmkVNGUr6yqK/70hsxyWkgxfbxzLfhTvqib1PD+nI7lG/LPbXN8xtnTGoyPrcJnIB
oPzHaH4jBmdA9hzOWa04DlFzwn910pInGIjgdTBxfnX9ypcADkvRzjKv1+OCHw53x2xkAfE8X8P4
7PBG6mFj8HjI6GbHfxahUsKNqfUtEMSJajAVUgPy6DIjVtazcutTKFgJrhT/D5w8799ASyEvifL7
m+9KhCD8SJGRcJ4XXTxqzUtyhgL+VX3I9hBZ9NFEYjqRlLeT+TfME3cVCJivA0mQ6dTUlSxW36cT
eFS0/Vj8coH+VAKuA0LsuOC1F/VBTwYI61IKBwPp8JWkD0qqsILDfRaIOPO56d4oftRWAwGtKwQz
F42G6kItm/qjU40DuptKJE/39pyBWaj2LuvxXnwY56daTWuchudl0XlLpZ+UrVL98Qwda1SCepTq
7TvRiNXU/w81G371SECx0nzGTq0S8OTd0eT1kWSZ7wtFO5cUICwtouZjWw++sAAEJHu+1+Zyv7m0
ZvRx81ArmnQdFadfO5LbxKDkiwkqN2j5TqQRG6zpIefkU/BHOBRFgLl2wsmvlZAVfThtTxuXwMzJ
CLPeM7FB0v10Qx54AVsM5Oj8t3ZFNBZclzttYqZUoxGQ3QMNktxrzfbfsK3YZ1tmIqLkTy7alyBK
I3PZFV1RnZjS3hriTk53sRfvNFNRnBsD1Ldv2Xa99deU9Xo3tDQX4RLQmFUmB04MRSITTMNPi9Dm
enUp4ncy+khrI70zarXlg4jw/tml4nRh7Ut7Z95NUqZNyU+ILMH5S/YJVoCTngchS5K/2nJjEbHL
4hS0P8H1po1d5ylj8MIiwA40yjgNqpZAgJ+61SNdPeddqKXqpxkBaIC2i8RZU91yjEbgd9o1Ww4X
yEcmbwpQ2LzpLZOwDOqAV1WauYI3kb/7CNPTELEtiN7xNOqMdy/xCFUsyPsuqLxMv7TT3PhtB6lA
XczHfbk9QC59FAIvaLseCDENPzZVFDSh/UODbmKMcRGMmR+Kkncp8gL8qHYvIjr0EvOh9wSMGL+J
kZ4k5WvCn+7xLByTnx3uEHZPGam0u6mjmsAEJTODvrPuERS/qGYTyQkGp+X4TRbgE3kb1CAzR7fI
rrL7ANYVGFq2VYBvwcV0+d6Px32fceYeQG9SyYkk6Uo3Fkp/UBDf9onDg03/wwgvCW0KXNiKgerc
pmlK5WlQHCatC2ZiaZ/H90BqIVW9dKUt44vG/2ouR9VxnKFawibKvsY94kw35nciVSRIOPkZJFh3
AvQPjFZlVwZ44xGWtsSZu2fh1IxOqseixw+PA807VLMF2W5qWlCDw0FNn6ay/LBIQl1ghB+Bga9l
Jz7ViFXbm9phFHcD7MSBgKJi+t9oftD42dhrPHvyfYVrtV/wjlWnGYrp6RUOBtGo3MeWiOUBq0nm
RbEgSew2b4UTiJGxfotz/n6GpEMaf/hVGx6z0pMuSN98Ck8ajDj6sjrn75yNukJuYw+yrakvqrj8
vbGuHCzXWWn90NeZXXoSNMBuTdruarPlS6G05KO2aljH3wI5X7l54jfURaLvXNqGa+sRO81VTyWU
lRuLMko5dDCGDcLelbxKGSa9L0RBGn4tNkz3hacLH4NXdIQ3oc1N8EmSHd89kDPkY2TuMieXzKWy
euR9+OjuMMbsdq14p4IDAEAlWIN21ZmBsGrExpe5YWQM76PliKB6xJ+jxs+duwq49ATpe0lb8kzr
y+GYL/w227o5DnaGfH6Nqija2BC6LCr4O8KHk31aq+9GFPhEOuTATkbUzd7C1ZyvHXhN01mKD+VO
Bk+lBHVKx6rWQVgUJWWXsLuUvnckOx/SnGHRM3P8xPP71tgx1WGkRhHRVN1nYt45uI+t8x8TKWkD
Yz/74ncjlMLemsTiRtkCazNKOWUlv486v/9w+r8M27mBMGbsfQZ/F+Ma0eWh+xRkdODbkjFYZA2Y
8o17z4MU39NbvD8nTEY7RSUCellBknz9o4h2K+bYauhPiGBJ1VhjGqnDL8wFhSsvDxptGIJ6WUhQ
Ypakg8eH0uBJ370yhyTYQorRlPmtlm2uoPb8C9Ch4l6HzHWfd1WUkDqm52t2qYEzqo3ksArrWYdJ
Lc36YxqSbVrIVSleI9+IudkPATpTkEOEikM+NsP3Hc7UY5ew19e/PlVKgO2zFZtfGFFoIBVkZ3EF
+phzun0eDLMG1oPsVUVjM0LCjEamk42zBrqzMMvSyWmCO8btSaeHL4tZ4ky3yMVheSMia5lFWQx3
rrGwedIspP3MWq9Bn4icZxYAgH+BEYFYisKoMbaemDjQZBdOlx91fL73iZGO420bs9SIZvlEJ3oH
QawqpDupMqM9vewo8FqqiLeNHJhIXTPR8TpwquywKekwwhTxhiR75jTpLP52akx/K8+TURPsg0+A
kOjgLry+N5So9ME8MV5esXC/bqMcnzVv57/b8fhzkLKGFSp31Yl+HvnuC9785ZlX3F3+FjSzOwcY
3p8UOwDU6he1yDPcll8VdlsFr38J2ZfZfDH7FAvdqxCHA0vz4slTS6oiTbL/goKzE6A8N7ZvrsUG
WvvZBcCjRW7MKDqyW4k5RUlJLdfWUBQAV5qSL/X8XwndqBBxoiQABoOk2f0IdL6CAEj4YhVwIn97
qaBwDoT8JhFttE4aPY7/zsD9oVCRfYjDvDam/0AAxhut1CnpGJNvIGSzR6VGA+VxlaJrRoSQKnq5
nSDH15kn9DG5cfs1owLVnrkdOGQUQwuD6x1e8H3lAx6sJqKELPBwKGIcI2eFlZVoN2z5wwg85biV
dEPwl3oNlGnSAHODeR2PqPD7snAVO/rEC13qqZRu9YQybP5p5R7xAfpLWJCGlKzSVIdbZoBIcpEp
5U+axfWBmQXYVAMbRDZiaQGoBRBQm6odVn7hPwwTglmz/ew+54pb4FV3orYyQGw/sFzQ6/mnUZfy
fgS7BGG/urBQ8iJiZYiOfzoge6HuGsgrj9wYP6oKViUAZ+Kbna6DCrujM8hJV+A00eYccdceWmrx
8rRykIXg3LheYZblzChlkY2mNsvdkAzpHBJcFYxuujSwLI6Dky/iOdonZWEmTFC1ZLXwlqEgsCau
5aQTNVjtiG5zAOdMsfE2KOPjTTfiXyIUFCnLyFvFE0RJpusK9fotGfLEkCj2JKYvdzpPtWS6cvaj
uweBjoo7OPt5J8KfZ6gX2Wofa3EBIXkNfRrAuqPAeR8wDiDAas0MScr8A2b1PT+BTSSs1ghUYKI0
icCX9SVTJ/1ZIZfJxsmtLLPHsxNRlNVSXzj/O0kKXqJW7nfpIKUwcoSWvOTPzko3eptdhiywyp3b
Yn1G7J8SlLUFPI+azomZjnxJP79tjzf4ppcQ0mdu6ypnPjrRq2/gEvDKXg49LNhZm0aTlGS++98Z
kWNEAN3XpkpKZsOYi412v5Poa4iK8YvPQDpnYB6gCL/ddP/764EpeNt4RLSCWZKitUtbvmge4rCF
RGB1DNfDK9fdER60DNhQl/02yVNmdpfbUI53+1XY6cYcEbP9fLOhmdbRFangKYNoHG5bY8n2/Jtz
qrh4mHY2crgYG7u1mum1T5RQw98DG6rvap5JeX6yiyrYzAOJlVoch6lBnhkq0wpRLa7DQ15ivdK4
ZVezNqhmSa0QWmwJ9BCPqhE5l2pip3eO0vlANhne3kQ5Bk2GVBdy8V3PkAcViFLMqbJs+bLFwpCA
63ZKOqPFFvrTcgPWTXWSHUfTqnoVtUS2RoJNaKTCjc4S5Vw8vWYm5RKUUGtVPok71Uv1PmN0WLR3
Ck9drjDZfRHszEDWxJ1HVYl7c+AIiCsINTk+7fUw6742G+gB1jmWuUtWLMR1f+fmw5n2rlFKYikw
fWEcekbOWmbUjScDX3T0Eu/yIDgDy0/aoHunxIbYuPI+eKo8868dlDM2tKQq4kCKhY3aPmp5tMTF
5+rM6PTIsqSeeijpox1mcBNNMPtnTX4bN87PIGwk/QA/OsNh4eYJNEqsEA1IYEhX7300lsME3Pjb
STVtA+MWvMejYZVnax13o16UNK8k7TIehUVOV+d/CqzsGsOACqwfTjG+1vEvCat4VpDlap5FS8m8
yHMcoEnhODz771nf5mPizLuM+9WLiBPPWRadnGAj2JHXx6tGgo/qUpZXYHhrOTlAXcW1NSkhd68B
oGrIs9BSpX+1trLpNyupoRjRtJb/6HrwvYliE0umw+nEiL54jO0WAB+dCgZE3sYN3DQq3n64nGFN
1nyHb7+mNboFmCXdPH9aACqyKeyVHNKYiBQzFerJOwkOYNIlfJlpiAm8OXRXP3OIK87r1+NgMN3f
+feVs0iMK9WA3Yatd0y8pyArB+L9k0hGCd5AgA6u0NKcwlV+5JfV6kRTcod5tgkrRyYmya60RFNu
1onVQKBLRpFAO8BhXXZH0EYhuLjTbRqpu6jVRGesMq/ZKk0LxNeFX53pI+0krzps1dWIjfqVEreN
v/svyVEHopift+cgd/N1HO0DNhGRrY2FZ+nCYl007S0Nztr7zfKiGJIK+Tro/THZxJ+krjrg9t+Y
2ylpplusfLVb4aVImRNiziPHTThTeNnOmH9zGctOexPGZG9Av5MrSVFCU317JRydvYudOJ+sVQ3o
zatK5JyJ8eFRBegxNgkMJL6bEEinFgPOwLPRtzYkdmigd4j/yzb9ZKqpwTWOT5nVpGyOKz+rA8Bw
IZX82H6ztpIvLOJwPdewk/NfMNHkTdq6CHoB3USR4ZK+oJmCLF69HIV0iczGpQ/UO35jKky53ykJ
3EFiZLyuJkEbYm0JAdCqMJpdykO0MS1UNW/VXTq7iV4HvuNXKckZeKratb748/NvbAW4ZSPzM3LO
ruQrI3ucqbt2fuwcxtI6AhmcvY3TfoPH1ceMv/eDgM6MaRSH0dA8yru/HfvGBwS84FSHen5qZKtq
FiJx0CFxeqjmk/tQePsHLercZd7wOMT3F3+1fHCZni9Y/iS8iRMpI0i+zUomoSZYCiyGBTr4ShLv
V0+fehnFFzh4xXiiH+pt/jvvif7exvb5jN4L35hW3j/55maLJraR3p96jevC52wiZehYuWGwQ1sm
6iQgmi8SGgpsWzlpBVUYgJozbkkAPCzBFYjQPiUlzU9oCmU8rsZRkzHtt6/FKcV2ZBs+apvP8nVT
xQUJZZ8Q7Uhxg8QpcBlJS6Ay6m0wH5C64Q5qEDVslzJiOuAJRhpjHgcu+onLpVigOnGd9MY8o95M
cvy1S2LUTJQJgn486Q36qAK/gDT2Kt6HHY8Q3/nqoWcR/H4d2rQgXGnI2GNP+5eVISHPez+NpQyK
lPVIWuUt35GuzbmAcTWpoUdWzqvxDi/m0jnF8c6S6TNLECIEiTbe8AviDGmvr/GSQUdSCKSHfEkc
+PJMIFfxeoIInZYdHTz8k87Ni3BCv2WMh5ueZRJhKj/wOVcdnlWi9C3+/gzwFXGlnIHzN6MMdPAM
atCGwPhIRu1ROzqADypg3E11b2iQBYkUPa6jqjYpeyWfI7oB0D1U/uIv6/61k4BZnT/bIjjP12al
XpJAs+IV0mV3EbXhqQJfuIuI1jICFCLyYL2wWrATC7+8rKa64I/AuHFbvzLLiAFQvPKIZTZUDdCD
pWOdiSO8JzmyxM0JihhqHJGN8h8evYl1be2LuFhRP9u1rOSMga8ly6GN9AYe/Uov0oq5i2IJQNOW
XLQURFicCwe8dhK7f1IMlMR2p7gJBRHP8ZibjiVi/O/Qz4BjxZbQgWUEqTN9DC+27zjxMRS15VZi
XYp8ZFLP/d7NXSF5fLUg22lLthZZ0/+MAm7adtL+UNPlRMEqqQMfE4qJiH6XVfkMOhs5WpuPdMDc
72LPNdQIXHNiLtrcbdBPVUa3HLhK8N8Hid6Sv+GDJOn8dybTOOSK9bpzZ+pbVRdSr+dUcPd9lXn+
jCi+7y95jJbYLdwLxAGBqeW13SY/iKr2xXCmirCbS9oqZ7DCYpBlR+vL1+wle7Ysk3cjVONayAbc
q//6sDw8Oc6f4onlFdgvf5ub7CJNjRsT0wIv4Vnkso1UQ4b6ix4dDr0sQguk6O9SOrDFuBssvnAg
V2WyMraiIcfIuxzNRiHI9lV8PCiYzhPSWq4EpB1cRR0XwQrAEztS6BZPLu9s7OmM2XdLShHJFaZl
AZC6mffF9qgOEF9uzXStF9UiAF/tIrfMZbktbv6ITBi16zgIlkEpLgTlDX0fCV3LhDBIOzruMQhN
PTp8RruD5Z6wSlMx/t3qWBwDXOCKSvJCg/hgffmsg0INHmstIOTA79gVCl0z1iq2mt7rir0Eq/2t
JJq5iwkSnyYDrRh/Kypd1xioZVRRWcaBlP3j5lTKohO4gpIy4XFfmv9TsxF9NPIsBzPCV11sT79O
mXexjTDmdQK0BtRFev0Ob7Y0CtC08cAxGmC0cZQY58xEqnvZy6mtZn8yAsn0jsAi28YhZjVZE8MW
9vdGB7WuGNwSiBq0stjxuPoibLM4ZTUw6bdwDDjixRBmTbpCNltmYi9+r7TQRkNDtfXVZS9nqtdm
HtlNe979mr7Ka8SHFcybb4zWJ7pHWtX6b+JTFV965/ZCUM1133Re9kl0HvWrh/3VsCt9rmLf7aDS
RdY+cxk9XhENjNKGlyaP5DyB15w91hk9Z1Eq2I9wJFG8N0xDovqZr193aQOjb9eDTJmDHiMacoNo
9qhZ1fBuXARlcQI9EmIiFAqPymK560/Nh76bs99bd5nhduOQtkt7ozBgPPW7Gzb/HjE2BCRqHe+T
u+4NBgBNs/I5gJVVZOFuZcJTeBiB8J/KdpaPnZNjdb+Aje3RWT7NuJM2qXTUEpRtqa+QSdvqJpve
HuVKYA1OeUg5QD8K32f0swBhxI7/q4Z9uIb/6wMIjpU3+neToUaYzuh0JHz4px6WttHTPt3zvFVG
ig95mqlRV0iBqQ56PY8y9Ys9ScjMvaqRavqk0WWmxAt/Gg9o1YEo4SUZZ1AelDNdtROwbqa1bbXf
EFuH0uzd/AtSrXSby/wQwz3KR3XtaSVAq3MYb/GMfmj3YtPLWHGQuH+75+U2LUBqNhZBN+o3SGE0
WTt2fsZK6z0+WnuNTtjNjmNH8CY+p+YM507EKe5XpAipHQfpmWjuJLpmdWxPSJSyfOkm/vT5+ddT
LHp/ZIA6zdj6ZsTyZZNecPw4T7a6R78v9PXrMTL9GdMAKoHDZQXwxRm7hH9xFTgDubhnrvhUhhXO
LP+kbRnrNwIsn8+1wnK9VO3ODKuQMxcvD3zhamUmQ90lzTchFEdshnf1Sio/sl4+PTbhhf7jQtbQ
D/w45Aq1FA7ShqFD0q6tcfc0ETLpSPb6Akyy2oFkQ//C6Pc9/1Dkc/bIAV7UPlGh0YO92/S/KM+/
VIFcTrSBIBpbveJOslPPwD/saTNxNcJ+OdNH/wzyVkhOHzu5tbIvqJsi4IidyVC2AAvNGTuqM1DV
NsLxj/KHE/OTFjxIYZckMvJ33Ffx1HEalsPWIKnZOi/qRNuOw3+wZGflA2SKE7DjQ3hdXf6m8dV0
UwZvoiUojIRkMGYSRVCvv3qIQFwW0QYfa1Z8maDM93FtNOp7YhnA3qTdfZJ+RpFaZ0hfsIBmlSbF
vD+LB9Va8W4I+5LmqJVuekZaA+VYPOveaPNiWkvvGFzfDFrfu949C7FdNYQoUehjj8Zv011ujAnV
++QQO09PWBEQYIxNM3w/gZ2gsEjkfWSHJ0/0665gFdRiNwkf2Wvkw10t3myTTn1L4oBahSWrR70o
NdGuCan1sO/l5Z2H4vx9c6h4+wjJgvwMaX8rAe/CvIoEcnoEfIQTFFv+kcPD+CBOJpZn452BbptF
vaC1TiNld0RNbLQJKVq+D8uF/+f1j0Kb0VvXnr79WNfxMPbXGtxX7Unp1X5Y9OOHBs2MI1ZGO//N
mqbS+ZbAjfgcNpKWih0kPU0tl5bZ10a8YmBizxRmVrYKy0cJlWDdWiOsLs+rSTpKMDeo9l0wFOvx
aEXUSAfi+j1pppq04MjW/Mvp4SIdifCSJKqmN+4CtalxG43FL/HwgixACXumpsIANnpYkjIIFdVE
UIb5rBFber8cTplmHIuFsjtLBzD2wTxTq6QzMCAiZZEZZrnTqEZxQaHbnAL2XjSPwVrpxp3KUBs1
UIc8Oh7BQFBPWq5z0IUgHq62lDHxnrUwVyd9uyrbosbFfxcmc84FW7VQQB1a0nCfkDl64qRF6Lb9
jBwYVKDjROkqeivj9Kj+wtSsVlcLFHbH1V73+ZJ6Rq1XTe29z3Uu7zxIFcsVSRg9VdEHngUdhJ17
RnX0qvmzJJnEQz5apmMULiOer7muoE7ysjpWzcFmKJR6B9+0fMYiuz1OW6W5pdNfxrHkQauFU7Hw
8ta8w84+yaQxycaxcHumCerp/RoK/0h5YCfqbjq+3w1yDB4Yt3NviVIvclBsmfL+h4eYuLHXe+qk
rOHTS/UpB4IcqG4zspZRpIBxRCZNQKQqRTsdFEiqKK5cpugLOJpqX9vo4PlNYKZyffDSqXuqif7O
et65WLf9QMwDeK1x5YTLdTfEUEhemp/f+BhJSrPuewpe9jf48HwcQqITrQy8CG8ZfUzi6tzs0Agk
e/UJMEKEP4Gim9cACgy7oWDZraB+CDVHeVTwtNMm+ygGg1l3zYkN/X5C/DLMHhneNDO4v/r/C3v5
WPNreHySgcWzL9y9T7FPEPW+qNVlI+PfY7aUHF36xvXK0jpxJhBoGyr8ZDnDjCritFMWNenC1s4e
h6TvaL8Gh/oXpD1kk7EgKfu9SValgEYDlV8LqPJxexUFqr9YvzZrQQmZDuNbOsbxp6v5kjaWE9Oj
XoYQcWfZSK3QfwRdR1Y36ob+q6t0QchONdnAvtIR88vGDN5LsetGVgDXHj3iwVWGPvEL9/ANoQed
eqItbqZO9tkTufFUsX9VBWeSShCVglmlLbfFEvdPpbFECh98aVkqsp+wZbjPARZhzoOX21VT2zNa
kASkHafa2R3kVjBsynzw+23uLhca8mz2KFlDaVJ4EzZV0ulXm4T99c7OhmrDGMAfFMWOLJMWI+cM
q7mLdmkaczAp3THMWqaDprLxFwYvriqW0pmGQ+WZDXp4S4uBwawE3Uf0JXe8WvS+PpIHGXs9jpm9
kCPcVBFg8OIIN8DifGFKyxRhm4J9PyjtQiqfTL8OauVuF1vVHRbTWLT4612sLNA50Z/P/fTLKZ8D
t3oC65OUtyCsKdiQfALUR2nwCMha8LOV1HXfInMvvhPXWIijXYRwHkN6wUYjWWrb4eQiB/cdszZA
+7Cll7nv2XOvvRXEpbanQhXhz8p6Bnm6vLY9oz+33u85/F/ocVIyAtkbd87EwLNvHD1Lri4jPi9f
D2Y8j8iYOEk+kQ13h6+EFnt+DlZD3IKh/x27X0f1VnRhqlYqg8M0hF3ZfUSlrMV/e7iwzCf6wPVd
cbphU/2SGECBceZpZWNbaH5kRAzhaICKHzfMkaYJyHyKj0YV883bwGmB/SScT8AqZF4n02BRgKpp
qLe+w0jpDam3bWw3gNhSx/mc8XOHXE+3hjrl/2vvNyYGN+UBSpUIyEQCph8tjoV/pXze8/eB6L6l
o0igyBKBwCcuD0OjyU/z6a1AGQ9eyCGpdqMabKiw8QAay60WVEC9hmqf7v8dS6pGguM+htBGzRIb
KPKAn488qha2ViFBLISiSnSxWUZc01ndUJ5g1bRusNMVudNzf7gIb12rQ0eIs+E5qiWlO8nCbSI9
luvLb3DbeceSr+7Zzj04rriJz5RY9jNx1d2jskYqMwUPe0OunkHFr3BLOqnKuq8EM6Y4r75sYI+w
Eng2Es7gPfAIlQPn2Q5AqUtVx6JmiNXeuZb3GDFGYVyYrpT1rhnExulu+I0vnGLpS1bIQ7tmnVsU
ZHeUhyZmyX9tQHdWbI9ahU00arrQyRZeZnVxXj9bh5hbw8n/wDSx5rrv0SH+R71AxMNvRHw62adi
OSrEpJzl16KoXXXEIBFl6EGJkf7TgXudWvp/dscusXwMPoUugYbG0Bebu+2rofv85yFyuRxF7gTn
yOkFG2FKk98eFm15dn0KI+NirBSKnS+lhG9OLuZoQTy6fFXlgkbCoZ0GuXYnAo52lePTMRo9D6AS
R9woOVJ8rQhsj6rh95k4DPQwvfadmvW65xojCkIVspFTG+XsJLvB6mZoXRBXR8K3zyFkfJi3dPnh
rG+zmscpGfLicvvMrkgRWWA7o0uM9E4rPh6w8Ie8RpGUlqsGAjMxJmrDTbzHC9yduzNAz8MH3Hor
Yw9GU2fvP5MxA/EMns2r3A752mPqenxi5FuEc3GmNawVKRK0hlx7xS1tdnHasFepAZ9ZN+ZLa5iu
NsYAdkyQjn+dYseXpwXpfXRYZQJIWJf3Eatm5j89qvGG+m/pb0R4065wbEQv96kMPpxK5piBiclM
hjyst0l93BdmO0rd8FKOzKBSHAF07mGMwP+crjFAqo4/oZiZpzdJFziesXghCB3n7yJj/Vb86ibr
LXC/gvtLoQxUUu6zr9KbXVejeswiTpGDEAvHdVME3pG9ZgcGDLM/gd5AqvDAkKOBkc8sNa2XgLuP
SEqU/rPigN4XYuX+qRqnrduOLcikH93MWU8xnXhJSdswOW8ciohdhXO4LCjoNddwCI0YV8Wh8MrJ
QamR4U2qFcFpG+1mtQgeEw9P0l6IIdNY2crOi65/JJHG+LqZPj1Q49ywauRrGHZEKW/03OuKVmWF
BQDXR0BdVadSAfWzF/aRbHTKZD2O6ow8ZnpoFFt4RREO4Op3Ztuy85JdzJJYxwhqtaCXjPQBAeOM
J3Qw5e9vRweN2hkMDDHV0o90JSUPApKBEtxNeiwm3BWY5Bo2z2nzmJSQGoZj0rxp601Gglqp7d4k
hpIEASVv3AR1Xf6oLXLYCAo0WviDYwKfrxbbHg7u3+xdfh0fanni1Uqq2h4aIXRYxAP5tWb2wmEi
f1lOAl6938PrWfy5DjzH2yYP52F+wOChJHU3Kp0ENu+Lj7MJZxq0CuOa7Lk/fPGxB/vOl24lxDSD
dipwcFiqx84LUI3ARr4dQaPiopGxab45SxayorQDQoZEuSQvU/kNTaPXxUX8vnhP/z27zeS95VE0
d74nh0e2N3wCsD4Ia5xwT2vCgTuJXjobBYuTXjAwPXOcgDH85IfaUOsD3cBU6Xqhrxe9kalvd5g4
umxO/++x33x7h1PBpF0ll8AfJ4P0q6DPF0YA09SGuU/qzuM4ONWFrGD6FPSyT3d73O9OAeLsPvVz
9gLDBq4aA2xu+wwa/2Lp/iCLJxoPg4NZwi4E6Y8+rSc+Oo+tpLK+BFqniH3Rd8cZ0FqjBDscOoOi
zcakH/CiXMValRi6PGQeZHMPYS52En0a4d8twqWRfbdMniUuM9uQ27GR2CbrM+qaQTnkPocUfihy
WOQNoIDb/mcMbHm4vU6llEspwcXzi8Oa2CIwY4XBLJg5BSrxp4MwwTTsUZbFAyswyXEwkmSILiWb
d7sNHJvvV9F1dGhjSHcMPkZ4DAqgkdrE3a8aGkmBDpi+/1ERRvqcvoKX2LLNUjaZv/lgiFX68OeZ
u0iDU8xvWAsiE4ZCXroA5ivfRxWWt58qeGSfPZeZ/rrNERUe3bCoSoZxD0yaNQI1Gwt/3+ybAeTY
7PrpACpMmZMmkqv0oY0UJuxkTg82nlDOQLzTUV3+rdh4kSn3hEmUMwmw0tKIwlu56Xe5h16uzb+n
y1KFYyDiGl54qp1/6YRLRo/lK65a0wgtjBsv2tnODE2uawTwXehlv8ZpjTLlks7qDGs8yq42Hyzr
GVfjBgvT3I0VHZ3CwRNlXEAywlEUnp0qKbISMGvfv+dUC+qlV51fKx3uNPHvv92or5TAULR6RmiZ
KlnKCJkMH9cCLSLSKJUNSxgxbcM04BT2XOD0Z52O4nclBAYvgE/myGVvLWm1Vu8E0f0gJovFjz0g
m/xWnDrTwPkI41ozsl2AbP2NQDhdYLc3B2evxAWQrR6hHrsY9S8klzv5reHXrEKnHnXYOVLmAuBn
G052JRL5zXPU76r/E1MMyyB7hPG/dLxzmp+nWX7WTcOGbr3MgAP2HWwMu1QwdPfIps10RSfdXZOB
p653EjEl+L+J9oLPZEb6dofrn6+GZhNg17srlsCsii9j/nlpF1qAFsZPqVxk8iBuJn+WHvRAmyRu
zgH+OsMn26L61mn4gp5xZhdBD4uuIq3G/tAq10OeaJCOXsdsPwkDNup26YHC2fnNucREHec3Tzyn
5EglnrwNtDW1/3LFJG1FV2ONxEch8hWpop8fG0TVGqMCifP4Aeac853yzPYTsZ6oe32/opuQCS51
Y/Ix4hl/Y/sHsf6uI32v/9QFRvsZ6QbByPaNTP8HYeTr4F6OXMkVmBJCIu6rxOHnv380DftjC6uQ
g1Ok66eO/CL63SjsFx0oga9X/RpfgHNPZq0nqG1nj7BCiuq5akw6l2epPb2I2q0v1IfRDa3SqKp3
go9G7n9xEDSTc77tdUvlHf6D7PXY/pE5q50Vi986hKeVwPPneRFRpc5As+vQtYVzU4RBJU0DFxSI
q6Pmt7kRnhkmbQkTDuFL2wQvBASbN7oNwABpt4zhPSJzdxXph9BEjyq0BH/dCKRVVTJ2V3/uENNo
8pSSwbZXQ7wELIyI5D3uzIeeSYj3Cp15meyjAZEtGJkAyzT0yN3Azb1XVtKX6HJP24YbBxRfeQaf
AiktYcxMmUVEWeHWaibITzpDPRhfdLlx2KZovaJyRnWBxsSE3mSeCaM7aEv/+g4lSVLHl2G0XRgQ
7rRZTnNdYXa1tdFO7ImflD72+/M5Ee6j6nbVtbWNaoGOwW9WkJreQGTs3lwuyYVYARDAXvZcMten
cVz1EPjLmRjVRcZP1tf6k6WSyXg8e0h1DVTCu6XWCTSJLh04CI1M60t0Kpi7PSxQpdMR7Ou2oKv+
9/2yq4wBOJcv7WtnkmsATgP++iYDyyVfUtPTpvEYiGo0o5Ae4NiYOW3aQRfgfFMsVbuuEBxX2UZv
odCl4tfbbUXKj7lJbKHm2xx9xW3PqYwxfxu7zigPxNByh2NLs5ok1/FOGAHg08yjm+06cUGFHtsc
rD60NBTIRRMi0WhUwgahgdcfEgqwDl0MnvKLUw/Mm8hmYi8WgY4oqGmEnV2AFqh/gFpALXlCQecW
9O+NAp9ZirHF8rCaILJc02/9Tikwp1tlIQWWGmQHoENdpILbdxNzY0ndzDy8oXz7ZySTFF7BZ8C3
yGDHZE23adqX7y7dMW+Xil/4tsHiBEaujqrmVZyHeaE2y/wvk6ygZERfKuHJMSs5LI1GZSQsoMuJ
DgOTgxSr/4yuKEDmekQOzfb0U5DVs2wy/wouMMpluT6S4N/VF12iPA9+0ht4HgPxLBnTCy4fhyex
G2f+t5wAgSGykxNouG1buGfIzjQZTNsp6RI04FOw26T7XJVSOwg2U/s7neQn7YI/CiQF8V/WK3EC
sP+qdfO1GyrADve3VZ3u7COMN4Q8QuaBouqVAZHNn8tqdeIlQCCMlFcbgwnd6bIrrjVyWvxyGWU4
CyHJojxSe6hzKh7uIsS4HovDZa1soXJEy1AVn3MOwZNjsv9+64caqGNGGGHg+X4CsUBAWmyhpv+9
8cNdvWdNc67oCsksJ+YwQVFVqJhHEGKv1hU11uZ0o0la1qkBRYID6RLvNfNvlp9EZVhxzOnOQZQv
qmk7frdK8rMengq9erdvoZvX0WdD55quxitlQIgSJsYiGC7cLmZvkrNlfJpkv9jU6aqErEjFKaWf
kOZSJHG6jcW6MWQt4frXFKjxyJiQxfrJCyRckeelPJRAF3SAK7IDusWlixvbHiEEsEctzimHrgav
mgwCutbS9rWMZYr7HG6RNsB0OkLRkWslcftQhUgT1iZzEg3BT9mS09ypBAd/l5SkE5tqn1cji9UR
xyEUYuZawe2hNu9b7p1ZF7t1Xbds8ihVeg3WXfXEvYxS+nGSDyXIKV7euC6hKUwJslYMT28DVmN+
VrDmyVpo2+BLPPt6WcnE5sTw9rUoNdRrs7lMVPiqYa8aY9FHy56r3vA7O0rHsjeoiHTKHHG1nn79
3UPdzK5DOubOJ3zzK23wfjIZJZF8bexuqzFrB8D1c1r56qLFsU1ZAANE14B0ZlwhJJAw02jae+26
2epIvISAF/WC2LeGVACrkkXII0U7L2UPdZGQNykScdgybp+gPk4LIM0vs3fRyjyTrKrgr2X5TPbP
PCVOMDrpBMObdth8nIerAx8I04h0ValdN47A0aBvswEtgVTsGnSVOkkWY7419xkmCvtrk7zsXA/s
KgvmFRGgmjVHhhwYP16bvB8owcPxIB9y0+Y7sH5aLTuWCm7N5UxnXk+BhCroqyfa6GZh83O9WPfK
ysigoE2ocQQCEkeeTNKdnjOlvj89lUxjyepakwn/v6vADphhsW0OtkxJbSiLF7Hgwj6CB8QSb4xV
LoAxTgeFDTIEthgVId4NzJ3lc6SB4ZgfyXU4OdIiuu1YoFDdyZF0zvwajZW3WbAw608orAKtyA8Z
lMPclGyuJ3qytSZ5dqpLA7/FEi19csAJ6LhTn7LWh5714CXO8ayiePtIl1LYWo8xFLTtf5aaArAG
5Bvu89OdWXiGKhl8Ckn1wYKKZTeSRcnpND+dratXqEGzLIeAmdrz6wlqNJfwzKF4sYjf/rCkkoHh
7BcUelMH9HEbOOzxRNWcA0+kFaeNEnNQ9eRnUGEVgLKpUufxShV9mbBTmPNMCbV5sMX954GebGRd
xPhSDq7qn3/akfdELtoWj+Gjyz1Kl+g/Ff46O/yeIVNkzk1vvkna7j++4yoxemhPT9ctq9gWUPHi
FJwsXo1liV/vHPGQes20tWpT5XySJ7LBrT2ZzaZcXuH4KcFzjwGzhJuEQLwl24KiMLzwYXmlUEyQ
/dhumDYKQpmmdEJggeA701V0OzuqUhI96STj9WEg/IfawpZLwpKS8q39DqRRoArzX5K+K/Zskr8N
3TXrA1w4FpoIqTfR5HyZOjmQd0tma+bsQojQ4GmpPfR2F6cWpBLFXwo/It9cwhD9pAwrOqcQy+iG
VOE9syvOv1wLAv7IsgSQ93jh2LJ2uQhECHys4XfvrmoVkOUkioT3aGDiCk/15XQf6BGVvaQpT4k0
aL8S6bappPOvKLZF/WT45v0idQSddkFt6DGZcdD3+XLZOQDH7lpoHKZiVkULCOK6ytcrw9qe9Fhk
KYZXNbMzpqborLFaUTmg2GYXvBZAZ8bDv1rTTfHXzV51FnRUZ+cKaK31hEEht1OdS1zDaSCpHzuC
Ugo207LqRv29Iclm4LQm+aTsiNutG8eoX9VmpMQLFFVTUyv0WDeKGTIQjdHk5/3Z/+TAoTsxov2i
PD/8LVvacyru3+2DlNUw+G70yKaLDDiHpVKdY6eCco1M7dCJSnNOSbMfiHa59hMo/B8ipDF/WuCY
0sAKGAcdn5d8uFo9C6JREwraLgVMcVWURLvwEczfb97FYtb21DyuX1tRBj9EYfyBFiX+6wgi4T7o
WhI9/z/aRM1/PyCyfHROlHiMDi94/DkjmKAxQNhnqGbLxeFQ84GNbJsoebpgjSire73+PDxOx/qD
GfpCMvvoRfO0rnABrmnzNOdi8kOp0ENlA7w2FRW2+Gzm9VZD5WwM9xTdfXVEBzi/SS9UBp+LDTYl
OicNJqurlsEn+Wp5/hMLt6eerdqivB+HY0Ol0bQ9/TiwYwuLCniyipN+AHnlKZt83uBtGbCaT/E+
PaVqqhZnJ1bqUNltunA8CgPQlugBdiEvowNVCyaH9+7WA4NkCY69PEtHx+cUH0+he4VV2ouE5flz
++ak09S37TB+uNiNiNume9eE0WHS4ma+9l0uicIVay3Lqi90ThmPl3rQP4UBo+q0hI2wMklJe+8H
+teHmYOeV0yXmyqH9chvK0zklZ6GkzbVUJJ9fZ7NyzrynYFNvH6sFtc36uFKsD9UasQsZNPNquCU
Fi3bMJFYvRBKxg2Amti9a/r3Iy3mX7GMnVlTSHsWXsBM8gKNUj5+406VZChaQGzOzMF6tFhIOZz0
AZesdysuvmTwDzB3UEinzLUya/VI6HqxjSckM72UDzAEmXqPqZo4uRS0OEISeKCHsHMSbpytx+O+
w/HD/QTrChnr57NXYy0up+nle0+32j3NkNaWpf718CeP6AZfRaOYCaAjasu2p2v60R5v+z7nrnNs
HpyqtnbeW6ZBPrC6XdGy4oR7IMNBJNLxzWoNWPsxW1kTSX65VHO5snzGzEE0ccza1tAGKkcg3GpB
sebf3GZyvpk7epyV3m3702/Q5t9mOyFtJc4YFHyLyQEyWusM+Ok8zMlhtVoMfCEHACJgCmraFQBZ
dkZD7/dBIId1LJrFIV0f1QkUoBc456yTy1Nde/7QnoAonotonfxpJ4S+nGq5oog4zgGFmXEOTDhm
mwXNWOjGkwusQjI82JmO+5u19AnTVYPI+2ITpWIW3Rej02LbsLeFxeqxJcXHD51jhUI5Q0XXoBv6
FLgYwnE3+Du6WBiy2lwS0b9EgZDsWmx/XLbBSR9204KI6l8mHQdg4CJWCuogZZckea1sTDx3HXaG
DiiFE6UIMpGeO4i0qF+DUHkEiCkQ81Op8emdjqF0p+Zm4Fv5IJ2u/d5ypniLA9ZCrIpX3ULVgsHo
efAS0pe5BKLniAzHlprSgB6ZdVASkr7AO3lFiOpEWKByI5x1nCrHKmVwsCaUvA9BKwklsQ59f4GF
l6rBFh1HAPkG2K3lc4aWuKb/qpHivkQobSi83DqjkzMacjpwMr+USttzTTPPPk1Xcvap+A7/JeZD
2nPJDQw5NF23FtUmHxZyRqdeRDvYr/lHk8TqJ1d3HkCr6YwfUUHi8HwJ0MPCZw7QKUN3LtK6ynL8
I67Cr2J0VoOUtCC7jUZC/+y7mlJ4vsYaqmfKOAFFH+kYpG2yqIqEMS7IhzRn7Om9x2uVoA9ds9Qj
uoqd3IvSdQK9WyYaCZ9Z8jiyc303APHtPHo/QZhtkH45hpPqwfnL1WbUXJpZHc27yjnasL6WuuIm
9U1zfV3suMWgeMGV+wvz7VzSRqvkSIVrQQIVpiuvdyhUWrH5fraquyBVWBsFvbDofs4bPcuI6Xw3
VvnESCXKKG+fsM14LtI9z6+UMNLVGSqyYLbYacDsg7IaraJIl+qy0li+3JUTM9m2CeRcUNoxrNVQ
PLkFkkRv8aT/8hj/7qeppzM3dmsvWO6FRaWpKRZma92IcO8vPUDCcMSVHF67z5AC+0J18SLwLNO3
/HsLbLfBu+S/HQ1RaZdTD0PA2/X0fc7WT/wJNA9BQHMAm3/mMWfk6UW9lml4k0pFyr0wqXWbyQFH
P6iMdTO0MxXrByTWaFAf1hlJV/P+Fx6nrgwbi95pf8zX3RM2AEVRL/RmZYEwnnPHVsYlwJY1yF1B
bM5W1kfniDrANnYmFRUn9IVJsxffG7jT9hkaMGvFcZqOY9Bz1yL/i6ZAQwVgO59f2CvxcF2BRTsT
VX47UGEIR7iHN1JpxFHQjYm4FJZO9zqmU145xzDDHWPaDlWpGRTJNtO/PwLJJkKXVfOr/x/ejynh
QG/6X0xVr+ooweHHm2Qz/yv2idtAfHQ6F+9GAFChkFU5ZUGL3xGa3D2G7ilUsX+Ph7BbYJ0PjGb9
kvL+sq9BqBYkx9QenMso3G8NtIef2Ss9nlMaF3/1uDw5Unbm2yVVbbnzu8Ar3FNV8ClWvQcusRuR
lYJfqfuUVt41EVJ26Z+MK6kWnQ52yycE0BwETeIt5Bv27f0X6tZ9J/prpsudiT8TWSCi1DK3VJuS
Vx3+zGmvzWhc+gss8xUPPS4Zpji3Dz+DkHNBDg6Rwa+qlUmzqiHWMsKIo7bJRnEvTFGpl6LGOaxg
QKGU6qhQempOxBu4xlOy+v6r1cjFaZpdocC6IAsnRSaEW6snIuYTkLdcgaxUlHThzQl15H0Zq5M+
Vq09wvYzp9W7ByUdh5fONMz8PiKKvctsWWDVZLBjSvKW3VauqI+JPrJVM8B1q/OCNRVpMOCOjzQD
ZGvVatUWojskW6y+zwghrMnJUTqMU6nIZwkNq63h8xmx+h9PiGmQhQjgO353UNFy9GPGUfvllgZ0
cSFGtYfgldny0TmdozSypceLTAsqFSTuQR+QKVcHFtYw/OV0NtZkc4dWiEGZFniPXCx1v1cOusMP
eUWKVE2AbsNST6mSvUjB2YQldufEl5ffAtHdXZCsX31iehKiGao9JID94vX1GYlyb1p3A5HZytGZ
9y7QKKtGsuOIKRkk7ERrt8zrLd2dCGUFZYpepzJ/w9x9ubVfDbou7LTwFNs16zG/l+CmGKPfMfaT
BkANO9dsHt8hyQ2LR8TEnCb0+mnvz6/79tJt9j8jlnqu8AyiFCwS6SPirT36SZvbw2+LHOyDpCHe
TjiMwTFZ8nRUIyWZbPgZRFiXe5UNnhbtgGh8jxbmI21koAkVuehvt8PsYPOZqmtWDpZQKV0k/3tC
yCOxCZueiRXsnIrpSwPBUPcHR8AyeVJUpoYYCe9d3iBj/qV16a4XkcEZQqvN1and6FNmkWKgnGel
WGLFbDoD4l9E4X8m0NZvxgsUSbj9/5161zo4RZAZVMGGLAhGxwsYs6i5tE5oZ67u2dGHsRUwGyKe
IU8rwfUMLKM2KK8b+EZvAZD27JS63Milqet/IaSalXnijlTdHgo5cQSJtdhmffwJdRLeCamLAdnH
AHr3kwA7FNXgaeiC2Ul3plfjdYap+GaO1xlsmd+q9GFNAx2yOqfEw7J18dr15DViwnPOoshGhwvW
lBWu6swIEbJpZrcA8vtllddpaoyXrb6fnX5mOjVkyIXZecPPrS0FSCKVE7pU8AI0mB7BOx6wsVi9
Kkdce94JEkLHzLxgbMQFxTad9ua4MlKYT3hSWhRVwc5S0o/BRnHTGnWZvr0GwhRoTi06lXv47i/x
cBFQRDZ/Jvyeb3B2AJif/FbJie+Geu+hreLP/2mcjqoBMI2k7UbsOWALP00JCVrcpsjkQIDt9WtF
KMlDgiJ32GhfQIjSNWf/thGpR0Yp8t85M6fDo5xAFKyA6GqydYHi7QefLGT7q1Hd7BCH83UO2Sht
o92iX7hp6QGw5pvFqAmxlaCKTIeCgmglRSKBaFGXpkhAUalnSkmUuWqYgzonp3MDMpu8UCE0j/aF
alXMM/APMAgocIzBxm4yw9YViA5bCDRRzE+nZWAheW+QSgaO+QqUNUhfEMDbs5wYzLGU//nPITt5
msAZ2cjFT0jCj9HM6hq0Wi45hP/vAI6tAILJz3pnl8tXz3k1XHoibwGEKBZ+BFo6HZE20drCZz8U
3XtdwWUMWyo1wcoktM84KU83mLBnE0WFPL4SHVJ+t120PR9FlKLA2e58iZA5uo8DxJkqLHjvj0Uw
73TDnwduc6Sk+cpy6Txx/KwjRbW5LQSKA3luaaMsGQhSL1DzW1GcfBzkuHEmt7Y5F0l4jbWGKT8E
qP9BjX4nKKFM0daqDMmcf1KDK0+UYzVSQVk4AOu/dXsf22XYxGFJiiEi/w/rwS8TUwA905WBboIi
zzclGmzXQLX85LprxyN8nBW9bcyUfqscOvhPfZo6p8lVoNFlNM+L36jzwz4rawg/i5zFOYziBaLV
Hk8vmBu1bLwycOExmq1DMSKTrTjaIFDa98Iju61Yu/ZBWGzOlP3Pf5A3cggzr2By8ccjwzIt65jf
hGmAr7sbKU9RFOddrfkhef95vuSovzYewyW96SeQhuPTWeUoNBaM7U+ij3wGTzit3tL2F37AuK16
lM4InqNwqPrsICU/6Q33S+g/UbqJU0J07DUW0ZcZHYI7Zfm40UIHwG+TdvQHUkrEfTcoZfwJKeEv
aTnWgSPNNzEwIRp9NGXn2JFhikENjOTQZ4mCkhKifeViXM1fDsQMHRzmGgmrDF+2p9t9/jil7nzb
HEb+woYLePTDaoSDqsa+BdyYawmYWBclKfEXwoQW0/Pqy4O1lSvyteWn2UZa3HGuGBseRLJoVEqm
lvGVNVUuWtmRi9GBd5RwlJsA1IdVqouF7bfgHRxjPLUbXNQKmoKjr393/hfty6EEpfJ10DvF2ga5
WGSwqOXrns7XrHUM5ltuqZAJpC0I2/7bNOVBZERRv+W/ORVlXNR9nxrBIhs4js5gZebv0X6aX5iT
qN6bbajvL732G3WkiD/7CGg6gNFOJMSouCtOnD9srueCAg4BjYVTkP+s2TmYJUZZalQDW0E+I/lT
w5yd0SnRJUqU94RcF65sPuvnlSOhxo9qh3kF3xp5G5dsGy2DOlWeC6ZK1KnmZ8s1rqp9rCZPtpfS
ClQ0VOPhC5HEflCvnLEDYn+RnkFvm0fLoSSYKlHjTendfisNIe8SjPBZzOfxzGFCUa5WTNUXFBYI
bNjrZ5jXdtxDgO86sxRjuXNXQ6DMYX91wu/rTy3/msOIEoJr1BzpVenGAcKwuI5K5Rt9o0HVgjBk
YB/X1FVniBBWI4JydMmpHYYPR5zM/y3Fa0JyTwJ2pRGr0jG0juGrfWetoJYInASYd1tY+ahO7/dP
vlrCO6+lP0clfpZxyqgaJ94dHH/CPrPP4uKcRVSfHYLUuc8/z6VlTzmvqCdOOKSL19cYLBPyk8qR
MidT8CQiPYZg2YpfAwBR5/pTV9KI4a1S5FCJWehycS4xAO8JK4YiC9swdHKyKmrSKHZ8E1qn9Iru
WQmPf6Ex2vFdXfvuzWCMjaNFGF5NpXCmc05W4YzAzCC8CFdBQZWzbaUBG+NehT0wtYlIvB74Ibqr
8U+nAjYX+2vmgvJiyJiSu8CdMXkrIHB53Y0DnhmJcmWhhZZw7CLxR8RRQUIH02uLyfmm6d858XIQ
kIec6nuQs9vYOxgAAgpkhlKdDib9DZ3Ym51ESk5Zfn/5fA1USW1e8bBRE58RS6ez3FKYsshvV0cf
JhSgFWWN6gF1J8CA+KDaPic8nFS6usk30WFLb0d7jKywU5P3KW9gfigzCwsBOhqzw9a0RIJ7b6SP
XFKOCgx9TeQSS4Am0hFEuhw/HGrCfgGJm+Eoa+j93wmofkEFodCEgevqtJeOOjo7rsDU13+fw8Ma
lEtR3motdaeqotAwqCMGDNLeu/FYv63QKZq6269H3Gllum3Ypa/qn1o3Rv7Z+j3vgv3jpAeG7BHT
1tZERoG4DtraruNvHX+XbYd7Q2gX+vgQANmlqDZ4RZB9GiJ6JO49YdrugfO5bdglfrrkOlJwA/IV
e0Enmv2AR8yPHDKuZke+5pm3SkBBUj8GryuRAUS7xY+TUfX2Y+rysam4jg+8XORUMwtdI3o9hPfm
j+xPWEPVThUVfEj5+xkmOTeegrBMd0uWw9O/UuPjgh18txOsF56Ax3Sbsiazb3V+VyC+onwkSm1u
HLf3Z5hO1uDfS5P1l5zEJwymeCSivilIeQtPkntU8Cp2LYiPQXnsDZwXDWIkblStGYaWDnEZXC8P
Ka9OncOi/4Eunu7W9fUqnLlT8pBeTtMyCuIneUXMAfosaxAGrGMMPgoYBA/ZVwp/KQs8G92ftXh/
pMxTPEGRk6YiSrzV08a9Aa3u/Z5LY/G+8qsbfXTPcQL6FllZ41gKRloBEGEWY50SlkI3atIXm411
U2kwqRtQU/1nk1QpAeTpBFFziLzieHX+5A5Enj9jXrraY70RIte9mRcMkBLGS55DPxOlyjzE8kuv
l/mOZlIYW0iPd9DMrv1SWbF4sKPSy/2Q0Y0g8s8qlaaVy+PdbGCDhMogQ9PPCd3rMeWTrt9gCKiy
f3fcqBD70swuLXdcqtI1fTxMv/2IMa+JW3xfj/IYKDlcVCQ7bV4O+lBTI0JB7CAZiheus/A2ggA8
9XBpXh9bhE2h5wkr0MbnUqsZh2YC+eJzEEORymauGoJeknJ23BPQOx2BS4VbBzpzBYgRG9b6bk1R
cFdhImvIchLcegVUsoJ/RFVZ9CqbVAuJZraUx3BIUr+B5A2QQKi226kOA6hvvGea509wrUMyg5R3
XEWv62CA5E5ANUD/xPMXp6picl+bxT//MQqb7CFnzehMIcD5+0i6FF2ptfXLvKWW49F5bdk+EOAC
xirSPsnxZ177HgcmcLoQEcCnRV+TemfOCYFCHVjmPLU1skUsJ5FqDfa0OOa/tPD8Xsoj1+2DxuYK
Uf8MG/IeLP5Pwwkq7zf0Lk5zoUGxYfTT6Jobp0e2wgqP+4cxmx2QDn6eBa1Ry6Eq/D0OVxyqNtp8
+SGnKS0sEtHejfsU21JAGpPIs2pzsB+wDtM+/Rpk/8c1UHCNQUxnfJSNIYgM4G/BPW6YbuliGeFu
Cgv6veck6oAP0MR9JxxGWHJic1zZ2mEE6EA24Zi9Zgqx6BNI0Q3LxUy6k2+NNrrDfVSYicSwlWl/
Dd59pZEHzFKCgFRa6CH7LbSBJNmriWNhHjATewulDBTqnLbw7J2mkZ/kc3fAb8D3oQQfe/G8NSxN
abAvA7GJZcXcXvn8QUEUAzn35V3Z4FTSPq9P3ErVLTO6wBlRrrzp8J/VzgrhFVbPkiGE1+WMC6TL
7+FYBLSbt9smouhgTZyMwI89IkK8Uz6bxm4oO8P3/gLZsq68yWmmp6Q88whD0zYD38tm+21UIx+F
W+h1kAQMCt2EdjWJ9GQTwsaVIwCHiBsygo4TLbJDNdj2qY4rkE+nOwSwQvMNopMiF0BLKfaFhv7C
7EsELoaBjneMfkF0bEJrxJd/m/AKQ1oLbjq7F+K02Ed5LWE6MpXjukaxQMs3n1GUt11QTqJhp+nG
oHsFo7JfbKeIwF+6RU/qTg6CiN2dkiNfcI+kXSJLQlXL4VOCTGBjobp3LmA0Nofzjex0Y0cN8If4
I5CzOg55eUI43VMR8JAEcHkpJLMn2OiXbOi9eth8kerfcYaR73hfa+63fvcmUuG7cokF6a3lMFQf
DyrIs2/lOvNng0UVb19D7Ubq2RyO5ToOOeMe2EMKdr6yJHahwIfrQsgKFnc2yh+nUdMCFkhBpZ6j
4MNIPbWY4V+a2KSxVM22dGYj1bvM8adSK7yrDNiNQncXJu9eZ5jxKJtc62dCcpSDLcPaERRITcdw
atnh0Vzmv6H67nqAJRFmu7F0WAUVgocOxsIQB4g3U6sN5V/6wKxFv9DSs+Jee9Wr9HuITbd4JzS2
9ST607syBUkZ03DNTxDlLldJLP9YbdAiNSAqY3DxSSVgITo8dmMkZogsjutC1O/WOFQ0C1yhz8Nh
IWhY8LMvyuBBgkt4rUcgW0qL0k04hhDaVpK9pw6AA1kCVotGUfEB3ntGAnhhJmrj2tWxS9bz7l1B
8xjwjLrNlpJBvC2V/yudFaKGoV3VL+AY8eKL01FwTXw01LhFO3cn1FuZCkfUPQwtzir+5RsG1mNw
dh3AWs3rU0tJKcrniuR+R1bWG+FTiuei9r7Kx+rabqRNLjQxq9zZw/ddgA36lYNs6eYQWI3U8eEj
50n2LWtUjgIED/HFLRWlqDGTssgk/GPnYpvQycUkJNSp6D8YyvmwkoYE+mqNlHy1yfBU0r6r+3OJ
/ZICze99QXCjlIgbc/fMC786ymNcXOMOC09ucKa60idp9Fg/iJs4IXePdgez0pC3Yv+3z/czkS09
0xb7RRIHcoiK/NwBXik9l/b2rhjBYS/qHyLerYnqHIMlOIVxSjB59/ZusjTQLNt0S5SDV/N1QWrI
f5S7ZjGISnshx8B56+3jvsoF/5KtK4dFw189bl10C39V/QGpj0pXjDzWSbnCLYlXr+7c1tZHCD2j
CkMisCkDp0lIzg9ShgPBJY9f5IdzlOiz5Kqm1xzJnsXshjlHdu1dorMocTUt2kWQ347jUEFfCuVC
Q7R14Fu+10n4+8o5DUJ4gsRlBI5wY86kcAW5WZrEemG/wSi7ng7g8JZCUlbaxR1c5CTb516m7DIS
PgCEm1ksT317TM8bHheidbdXLzAQBKJGL/0RU/uEuw/3PwydH+tQUZQj2LHYj76gJeNZtL05Vwch
OPx937DoqMr7hm7WExSQeobA56Mh97hoQVRGhYJ6cE+B/3exfshmt9SF1JsA6qG2gh1kGIA2yxy1
sDESoLrb2ziYgUafUV5B205PMbRHVKZlGQ2g1AtRfRyWXielJZPWsZlj5paUZf5KMk/ytbz4WDzm
21voRJIOcOpKEw7FKaVCJmNPxDitCY54NOYeYwCbsuuwc/ceggBUIfgA/8zIA2kuxo4aHxeKvlRv
BRyrs4eiWk5iXgWIYM4yqqwSs7JNkk4n/EjKhY5tfj1rM5B16ol8qliZdFw9cTb+R2xK147g86Ic
lPqVWolq+QL4yz5pCttjcdkehe1hRBAZuBwLp2FDZ5HFZApHaPqVERDvV0763gr8xIXN32qKfhmT
wdXFhOHyFd4br4NUXYSPj0VPkF7HRBQZu+tX1NgL4ciNwjf8A76qDSZ/Y9HtTbBuf9Io+36H20us
ZIMSVB4dT3z39/TAC6hSQaNtbRFujpI88XistkZO+ECivdcNUHoVXGZ7LmkxMS9m4w9NX5Df59fn
MbgCMQbEnqM93TUAb8iIVhSaNwzWfBwa7A5x9SXV5jdF/aCyUNuh3R0ZNcfVfftn1WuIDex/FlBA
OfJeMf6emtw9MT37oXs2qn9FLv6Iyfgoi+GpyihLKzvq0ZeAS31zUgjDRcUgExCEBIvxbcAMLpCJ
mtzb1C/z7tnuIx1YFhoivLMZZvU3Uzh41McX7+ZprbC6/k1SSsDI7BJJwzYkFz5Y8XRbBhq3nl6j
a26Cfw5H1cBZSRH5a8CnZxlJsA15ogF+mDJNziPDdPFsdGk+3QVv9q/A2d21GCY88XESgMzSUPHW
LCK6BnKg/NJeCJNcfCnWFyIxs6mBV9ANGNtH+WK++d612+2vsw+gOxbdncNi5hRM7VlXsmLDdkEx
/vNdvBdMdGqlK7i+wuLEO3YozBbUm86NIm0IpUwT+C0En47V2/aRVXjYONMvOdEUk/yg/DgDV/I+
FE6exNipd+1BiK5GIQCcLJdB+5YgQ15AhZ8g+TsRmJZLfKzsLz25+5Ik/pN39b32wHnVadI9mrFG
OXw6ANZBLz5dbp2mV4qmSfNb7udephibaBa4YriEQw+y05AbEXm7GRFfOgZ9wiykcjdDM4F3Z71L
IyRRNPRwvD/MoujOfDTa3xRIpKIGrv0NJWDnLQ015ZSLwp/MmFPS2N9OGLheO6riGI/fb5k71Bkb
wnLC9inLtJAi2rWIh466njeI2/C1r0Zqqutw1xXKb40e6MCVQ0h7xNB8eSg3IIVrAOSnKHDMiZcz
jIYvtoOuVNB2f8zk3KWhwPw4lA5hc6Et+u73FpFvzzk4QkeKy6ELfZqhSFRfiJ8JS7pOFj7sk/Oj
1aKV5C94qeuJf5tebstFA0oB7WkFts1yqWtli/sb3auJbUrkHVGbLvChucRhbT11cUcabWOfC37R
9Yn7U14INSUgMR0QySQhMtZo/h2Cf/etNSNN/GK7d9kcQhu5bYowbrYuWHfcxY11ValQvo+/L1gd
/ElFoNjTe579LcQKFVkm7Pgz6POQTlEaJXN6a4WYe3Vb6PIGry0LjZ3Lk3OjuA/hzB4gcGYjQNhR
Itocx9JweystCYRDM8T82DzFa+ZLY473u+KnzJGBWnUMBofgYIFNf6BQ5XY2cc0UuwuqtCwf406O
uAf7NQOf7LfCjjf1McNwnAB3dr0Jj89Aw2wxFTvgxnVg0znFsV6O9cht908N791OShRifuTXgca5
Ws82VzoBJG66UURrULUzukrbuKq/qYqqeFfT+nj5t+cP1qurznklM+q5rIQkLJxSlPpDorYm4+yr
3i3XaJmAX5Qm52VOPErtZ6Q/F+TPen9zyhjjH9okQ5KRHKTfpIKEVbS69JPIj91TUHFnrpT27exA
NSZtyAmWuIWrJBBSONXvztl9m5Vh+3PfNexxxOlUd7Q/TpAOrCuGZcrCR9LRQCM1GUa7hAa970pF
1EFWtIKKUWy9kozKivL+9Tq/nPOy17/Zeuz0ATwggvbfyFVO5uoWZJpXHrzEDjDyktQHLjHpUcdx
OMSSa9W4bqri70y6sb0PzJ2mCen8W2Sa9G2IroXgjRkxhUfadypqzoLau+RM4MFWZMjvMqjmcwBb
FdXTOSrSbinYCgfEl/Kinm6aWA5rNZpa7xLI3WARGBaO/4EmYyGEvnnpeDDgYZ2ntCe70MMmgnNd
T5RswHqZSqParCcbWontBdSwjQU3ZnPK5hTiVO2UTASOOOTDpVuY8L05or/XA6nCoia718sagETo
3DVeTjR6DnEr+/7u0NekrczW4iNgWX55YYGPqJUVmn+kZ3xPTZmwm7Q+09Q6DE8+oUZyKYLU17XT
mZcd48lirqEilEXjmCFpk+QsMlfzyGapUPxP2MtGRUZ7O5V332N1It50Wd2ipcm55CmKRjwC33zI
BZrR/aJd6l+2rLYQGH8WUucqAjJZAJ7ZrJomnjlNWHSipULGdlwuknKlb7aBXICbLCN0p/PwVFJk
yRBTQcJpvjWii+IJ6juSJEml9GrhXelX408xI6RlvRCPhLysz+cm8Piesh0IVlrrn8ZvDDpIEL19
nSQlQjv6ju8Io1LvKhm/yHx74xupVJXTm/sLTvHODpSLvfgjRWIpxxxTxAPoq6mE7XpZi6PIZhA5
wpAlA2a/CZjU986QqN77sYvvWbrPJi/Sev4McHie8xhpbnjswBEmNZlHglCviaNdvhk1UMeBfT9K
q9kqCZi9Rqu47/HPj9+BbPrw2s1xbrgaKPQa0KTmXAp7TLt9sHr6RRgSOOAjDLCKpEVsbmmOAs46
QWhDxU6XPaqsfFI2OXAyfpb8HBAvXejjXdUiPBpBZOSeNyl5QxQltjotiJNI6WS+gZehFud885jb
LCktZKUuTS+E73REtfYPIBxlJ3LvHQ6y7IVm2N0j/Y867Tk3lBKzV/DeFG0VhVB+Kd8ChVg/RDGk
PYqLTAhqUGmBAHBZmWh7hAxT8oAK+vT6uf/oz9Gp6Wr2n9t6k19RtUTFsbkdd95Ghw5ri7NA3ino
G3Jk5fa7nTpKP1rhP3D7wqUTiyNMfzBA/eyjsHf/Tgwjmbgxt6vNafvZ11SMDuN2OQYaDgkNAWTA
rlGCVekg5GcFuPOUzXdduve2dYx4M+oR/Pii3AlLXG1rC9tM/eiu5s4PJ0L/v9mXbUkTdvnHrrEx
a0wVw+IpIWnwbl9LzfqAPbXLQfR6afA/1eCF4SA7E/CLX2nNgrXjAjCbYcpjp8xLw/RXDyyogPGa
Q6MgNmVNc5jXRlN3BR7qomFHNLu0FtJXbMuuV59m1QZTFNexmizUqWYRkbC1fW/AWdRKpacE51qW
hTFEljjVEJcr8PIrB75ha1Bpoeeh4PCWXu1Q1ii6HDmF+7h2JPYJLH4FJ/mgPIMEqAw6jmvroB8L
mz70JQW/uXknGS4YVP1+6DdICionwDJycMrAnNz0HqFefxOZgWV0KLy5k/20VSthkx71+x0t44zk
L3Ed78TUweyW19e2V/htTnzYFMwX2Iu1kR9uv6sgaovtirdUDl0I8P7RaV++Exbw5zMgOdczymGR
coWZq9G0M6pe5mNVnU5uQ1BUFFmjVPJC9wqozp8V3xcVY6zn6rxXRy6oZBCoovi6qzdiF1Hv0owW
1A7PsOCsB+msOI1P+MM4YSKQDjajYcmNXMxDrS84sUmCoH/yOo36gk1IcK1g2EK+n3lXPU1QLvQR
8wMdI2xn9oteItXGk1P723T217m0h5lUVMD5SWi/eY1ODgrBYQfSaaS84Gtf06nCKfJi6GWVRKgW
igwnupJSKdyCrdWtClIREe7TZ8D2RkvELgqmm06KhXLawCyLpvMZyLqrCqhcgjfIg/5761K8Auuj
B9yaeOPIT2sERIr1uk2QWLycAWnC7lhdOu5S/tHxncCh90RbSxf3TIM6Ds7lU1UnYEluDh6oRr86
hFiCASMKZEJxct/Zn7N+HTdk7ne8Ht6EZaHLgNnJa7jdjDu38dmBFVtyPXGV6J14tAAbDfjv5nzr
URt0W6LinA9fSIo83p9BVJvWyJWyAjHhUa+y7uJNjcws05Ple1e1M/IjrlrTvFtqSU9H74swOaq9
XFkohcX7CixEGTvJoErD8bFb3eIXRzfybrCu6LYFzOfIWx+g00svMbVa/f//TmSdyejNTMNKsP0L
Xqsa879iA44Hi3/wp+V6+F9B4Z8q0GzBne7+QWaBc9bifKwWJ1gTrHwcGQGymIYROB9OESVcaLuC
uG0OrYpxTW+PgAwyxZTfIxexrOyq7OH16ekmMyKAK2EFcULAAGgoL4/rXPW39YEJYwcuY48h8qKV
2gjOttDRBF7jfvhEMmL1hnBiofJR2cI7LAHIiWW7zK39Za+jMDFUdjVSOy0+guI1Ia3MP0p6gbGx
fmLKhBZV14BPDBJGYsFDYc0mUWKXRCfR0GL70oDYwBZnTasUUzk/I+zXfQ1TGJQNp11vf7zhE7el
TboZ9KjUPbd/Mrerpcv13hFzmdSthFwV7qqd68x4FSzRCTWKjGcgu+XbqYxk/UsKNuWFtAiyuqtT
sOygsGaW+By054QK+gFNZoyL/ABzDYCcnMFaP74RJL3084LpP/yHH5c4HA+jNsJMNewPbO60P8TG
qzJam/OjHKyPDIJWaPVqqCvAQfHTySH1XFy49Cql3QRLKajA7LaItlyRt6vylqiUeprxStveZ/cT
gwv9Bj9FLhNQxLRaul915/VTDVpMlyQSvklw+OTL9u9hVedzXmqQz4ZrWdNnhAEKz3s3Dd0xnd6C
OKK/+quUloJat9Ippgm/SBrTGsY8iJMQZGrOc4L/Uhg+7nyC6jRIi0eYp/1yNwAw2m8iyEmbSmK2
nIxmad1bkGKYL5jrSW5RLsfo+nlOfjfV52JxZCkZHJaqZ8cIOxPhkHqcjZm5AAH+i25jwLNjIn1Q
rfpKq2sRLw1LU3EFj+92CcILDsyivFaVUOfn7uQi43+jmnaUWslI91wgSnA+zqqNJm+FDK3Bnn05
XXdzSyBVEL9waWZHjWzN4xEaAY4Ivn+O78ZJMxaLJCB0OUIpZeFPNcmEG6QAFEEnRIPffp9D0T/y
Ze8N//jhAfrBuHCUvMGjgghul98LPXiX4Pfax7vkbTU/D82WwZmrWH0rxyWhR7YA7Dh/uL0x4IP0
qLXcsrIrz7f3H2bdozrzvOeIHM0bdsdIg7ejqqZK9v4X0eL9qkC7nKe38V4FYdNbObgiB7yghQWj
rxZWxr/PabyLXJZURP85FFM+tebmj6CAE0IQE0uBn1cbVzxkiTK89T3bIo2CdGXA1iwMh3GZajb5
PbqnXn6jcyP4mHxHGB3Rdr8OXzJYIm5L9HkuWg1xrhbg2gItvIKuPHAGfdP9ygb3jKltneJsZAsf
yBTCuEg5KfVj4f72mLBJNxdb6D6/Pk8r0lZvJC5dqe8T/PaZLZml1JkJBujibF78xoc9ES+DEzkP
3NBUvFJWEnIRGwTZiBaTQpQiFfWC5g5LIV9rS5v00f+nLi9MqX/u59lnYLVCtldcKs/pdaDUcYFG
ZidlI82dVE8epSFJFzZcv4iLZLJ4EZhNe+1MkxHxN+b6wP6F2E9U4ETMtziZivrMDLKF9xvUymt7
JnoTgE14VFRqNX0Wu3EBsAJvZjdun/ws3f4WTxK0oo3OhPztEeajYRVdX6+jfuHt7nS/IEoq/X2K
C2stwIgf5RMx5nogWI/U8LNQU+dTBMuF56nslH4H9rCg/Bsh3e8gFtzbtYtII9zuCYvT5Pq+CG9m
8fXn3oOPSwIV53/HlwH7jJDtOijNNBNa0PCrjjTonTJoXI1srtf9QrUBiXEQgBAUNQ+iCoktbPJb
MMa28LqRkhz+gjzsx4wttgPWmrpq5mHk3lb0xuYYw/2sY0ZzZZxQjuH/neFgEawBSGjT5/IQKB3e
sqS+CgUa7ihDyROf8AJtXc+dBmZdUusWD140066odRIkqUNFGDHnuaM7BV9DZdDjxyEVwpqoQ0qF
/qN6ZH7nBiRseyf3KlM3ke9f9ErlwoaCyjXkCrSFg7brf8O8XGNauhHeXkItEz2Ca8tv7qmG0HwH
2h3NLk3HcJqN7it26APlx5x+4zZjq0zSROqnYi1GF7yNQKuak9i2KZbX54uv4P55BkDBFxldmYEp
vt0QXZMAN0VcLyDMDtj6GFW3KW4F4h/orz5NWejToViKgMpOYri0pb3R+4/i1YDe7h+WGCtG7uO8
34piqhmWQjm8NK0DGz3LtIrjLWYHhBwoCVlNlV0W/UeH9HBHhH+EgVlO5w8YE/1MgtzniKfr69jI
P9WvOgwt1QAOgWdFM51DlzmqQ3QgwCVfGBIKz6bjqev5Fg/5pEvGqejEODeu+ofpz92xNm5na1cM
Fblj+ujWaW1QCZf6aicgQ/LjmWOdhKGQcIqtQa+hRjXIqOEyZmY5Lp2qpl3Kw4JO6oqFSGXVL9f7
pIEH4qbajMHXmulIUZdB+DOT/sXlo9JuWvjX9gvdTnH5L/pX6nBLKyteBjBkesCQg6Y5TNiRk4Cj
JTEIHB+ZGikXZYXTIrao89b4f+7KQL+LeSj3rYNv6Ig0aanf1KIHxtEexqK580OfgN2OX/oi3K3F
PgOuMOANwT2CUB0hoYuxFdMA1+ZbLmz+8S6iXWq12R7FqKbT7Wg090809RO5VJnTrgkCaPQzpcpK
6bZuOqSmUbSSHBaJFkXOhMN3WAApF8bezxj628Jlt9LM8bRl/QxjMjieyuuiLbQzAM/I2FKg8SV3
kJoQYPsjOdsjpi79ywYwQ3bBT07vXpPgDKQ5DMNziioU39W0YvdV5GAwmajB1ELe+p1tp0fl7i6Z
vUo1+NDskKYkvN4af53oSD9vUvvva/O/+gbaKtgD4GAggSTH2eXeqVuxtHscDMDWiUR4bnyBIyg3
QZjPprwDln1xgTIUSJtHOmnJpNueam6RHS0C9OFavWXJXJ7iBD4fbU2bjx9YSG6qi8lOeRDl4HUj
Oe7/M6ymUOj4+xPBYMAX2gjBhAXYjj7IpDtRGS6BJQwGrg7c7UF9cUF5xz4Pr7mW+5rEcmaWQP6Y
zcoz00+fKvnFPKhnaN0nujGBQ+7zMinpbIJRpnD91ekvZv8x+ntfuAzx9V0QT4AVpfK0FCkGbHQw
+2avw3aKv+wW82ZMeEIZFRxurdOBFe/DUeT+XxbDt6eVXhqlA6ccMlJnJuPAyySENdUzSkBEm7XK
4uCbaGNMHIswaFLvtHQxxDqBp9/hmrXNkWR370SbeboAMq72gjapYCekzhfzf385AWmZr4Yo16Yp
NjdJDBjaf1mnQduwG5sjZZiN/DAun52FOvWZdLkdf7/9BpHqsRy3SJgHg88nvAub1D1xD93UzP91
3vtsF8BalE9reK2skBRZ0ppr0xOWGFjKBW3vmCIzCNWOHigSdh4z/D+/ZOomR1oYEqVeU/LCD6Ul
sgLk0zFD2LW22Rw4ivyyyZ5Ku3GQH9feiHOWLbPKyWAWj1ySfkH89eBuSubDS1OiQ1uJsAAAH/hd
iDZx6h8AAaeuAqz2DXWCZ06xxGf7AgAAAAAEWVo=

--mXwfwGN2RzZ59ncZ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="igt"

2023-02-15 08:15:15 build/tests/gem_ctx_create --run-subtest maximum-mem
IGT-Version: 1.27.1-gd2ca8db8 (x86_64) (Linux: 6.2.0-rc2-00011-gffb1b4a41016 x86_64)
Starting subtest: maximum-mem
Created 64696 contexts, before failing with 'Cannot allocate memory' [12]
[0] Context execution: 528.487 us
[3] Context execution: 530.014 us
[1] Context execution: 531.182 us
[2] Context execution: 531.261 us
Subtest maximum-mem: SUCCESS (414.995s)

--mXwfwGN2RzZ59ncZ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/igt-part5.yaml
suite: igt
testcase: igt
category: functional
igt:
  group: gem_ctx_create
  test: maximum-mem
job_origin: igt-part5.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d02
tbox_group: lkp-skl-d02
submit_id: 63ec8292fe9fd790a399cc32
job_file: "/lkp/jobs/scheduled/lkp-skl-d02/igt-gem_ctx_create-maximum-mem-debian-11.1-x86_64-20220510.cgz-ffb1b4a41016295e298409c9dbcacd55680bd6d4-20230215-37027-dy2nxi-0.yaml"
id: 2199f6193a516a43ffcd420a0d40239ce505459d
queuer_version: "/zday/lkp"

#! /db/releases/20230213111821/lkp-src/hosts/lkp-skl-d02
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c500746fa0cc-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e41514d5105-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e41514d5105-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

#! /db/releases/20230213111821/lkp-src/include/category/functional
kmsg:
heartbeat:
meminfo:

#! /db/releases/20230213111821/lkp-src/include/queue/cyclic
commit: ffb1b4a41016295e298409c9dbcacd55680bd6d4

#! /db/releases/20230213111821/lkp-src/include/testbox/lkp-skl-d02
need_kconfig_hw:
- PTP_1588_CLOCK: y
- E1000E: y
- SATA_AHCI
- DRM_I915
ucode: '0xf0'
bisect_dmesg: true
need_memory: 25G
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2023-02-15 14:58:27.519020019 +08:00
_id: 63ec8292fe9fd790a399cc32
_rt: "/result/igt/gem_ctx_create-maximum-mem/lkp-skl-d02/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ffb1b4a41016295e298409c9dbcacd55680bd6d4"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 7902b53179c7749df7d6309a48886918c6e5da9b
base_commit: 4ec5183ec48656cec489c49f989c508b68b518e3
branch: linux-devel/devel-hourly-20230212-121832
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/igt/gem_ctx_create-maximum-mem/lkp-skl-d02/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ffb1b4a41016295e298409c9dbcacd55680bd6d4/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/igt/gem_ctx_create-maximum-mem/lkp-skl-d02/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ffb1b4a41016295e298409c9dbcacd55680bd6d4/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ffb1b4a41016295e298409c9dbcacd55680bd6d4/vmlinuz-6.2.0-rc2-00011-gffb1b4a41016
- branch=linux-devel/devel-hourly-20230212-121832
- job=/lkp/jobs/scheduled/lkp-skl-d02/igt-gem_ctx_create-maximum-mem-debian-11.1-x86_64-20220510.cgz-ffb1b4a41016295e298409c9dbcacd55680bd6d4-20230215-37027-dy2nxi-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=ffb1b4a41016295e298409c9dbcacd55680bd6d4
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ffb1b4a41016295e298409c9dbcacd55680bd6d4/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/igt_20230211.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/igt-x86_64-d2ca8db8-1_20230211.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /db/releases/20230213184756/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.2.0-rc7-10520-gbb5a53711d49
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ffb1b4a41016295e298409c9dbcacd55680bd6d4/vmlinuz-6.2.0-rc2-00011-gffb1b4a41016"
dequeue_time: 2023-02-15 15:57:22.115565952 +08:00

#! /db/releases/20230215150443/lkp-src/include/site/inn
job_state: finished
loadavg: 1.99 1.79 0.91 1/134 2053
start_time: '1676447944'
end_time: '1676448367'
version: "/lkp/lkp/.src-20230213-104638:8ff05c930337:adf8bfb87d9e"

--mXwfwGN2RzZ59ncZ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

 "build/tests/gem_ctx_create" "--run-subtest" "maximum-mem"

--mXwfwGN2RzZ59ncZ--
