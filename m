Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7470B79B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjEVI3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjEVI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:29:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9552AB6;
        Mon, 22 May 2023 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684744138; x=1716280138;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=r7IxBnLTh1tR0cLTSELK87tILv9ue724lTfIskvo+Qw=;
  b=PDo8vCPfMTqXvlbAo6ClVwr/goeP+IDNEVHcP3i9u4Xt/EHXTNae3ACM
   sRVcaNaCwBJjx/rCDRpyA3HZQHTWNvdhr8gfE6DfHKoyjDvHzal9LaO0M
   Vmqria2jD/inpj16Z8W8YxzbbeopDNtm5W52qCanG0MZgityd7JJ9b0oK
   a4z7EvkuAkDPbTTT/vHEpN9CTn7bGKlsbhgjj6hHj7x+fPfWi1hC3j6NE
   t81iUaBpmlFcHGNp42+PICmAgm35xkvzhxNAFRkFyyGABO3F7TaU2c07Y
   65QVdRPV/rSrh1HezFzt1qP4dBemU2ZsWHTVxtx+ecrdpMZYwNwY8NPcS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="332470965"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="xz'341?scan'341,208,341";a="332470965"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 01:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="736332101"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="xz'341?scan'341,208,341";a="736332101"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 22 May 2023 01:28:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 01:28:55 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 01:28:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 01:28:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 01:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXCeyDJmNVVMVfyfH52GVTZwo1bKHd2HzwLFKbVB5NQy+LmN2JwQTmRmp4xNzpKzEDi/D6Mg+eBHHmtlvYX+D1C8r45sre0wlWEy9Nj4aVRq8TZnKMvUFHIZuEXRRppdqB9T0vpG6iOJVCmAH4L/yQ3xmVb85WuwwLxiTLFbC6vlFYBj6+POg4Y3/plX8tois0ww2X3Ai4F6+odXffZ0nnFqGI8cuuhMcayR18fT2TwfsoYNcjqhviIaar62zqYg9GVyrRPaGUyAGzfhNjRLGmM7xCnX0C16XE7MVDj36bbW8kU8tWjnLracD3SrZEzS78Mj08IZm/7MFZNIuyR4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghYf3+AIMa1eKJ41WBhJ0VpLExgXUChPqyUs2QX/FIg=;
 b=Db0SnkKVbsY/mUbaM0n329VPho7pls5yKPBRrxxJhLCTncrbnLoS/lIDmyaA8akYNpOrDb44A5fSUkwQyWt2BSKNxsSG9JwNrNNWBcjDvEo37NWrOg897dWnn7ClPCBjAypvwf7Ox1u3Zo50FE2CXSagmnp9uuhUhhGVQZFcyoP6uRj3157sbgwoNeugxfsIWZIxYP+DytNqLkeXcAhV8O+HULXTzCngut3kDdGCzajklD3fW/9JmoZcWWMLyYzOt1vZrS/+jHxImeQNPrf/I8aD9ROl2IPBKMZ2B+4H/njPVw6v8z3HeUAMdcKl0iyhH5eV9tjTaBU90AorOV2hxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA1PR11MB6992.namprd11.prod.outlook.com (2603:10b6:806:2b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 08:28:51 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 08:28:50 +0000
Date:   Mon, 22 May 2023 16:25:31 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        <linux-arch@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 3/3] irqflags: Warn on irq disable when disabled and
 enable when enabled
Message-ID: <202305221624.b202695a-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="4fl2+zdcvTV6RaAH"
Content-Disposition: inline
In-Reply-To: <20230509110739.241735-4-npiggin@gmail.com>
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA1PR11MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 603ea9f0-d83a-4062-ed7a-08db5a9e91b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VKTMYOizr4x4izTRbVney0e5zr5Adbv++5Q3wUIcqgWQZyjcvpTX3Rk9jYVVXOGBtljJLNgXor055NNuaIZlzVFEjQpUe1O7bvYY+0TFKKbsYg73T5W8gWRgAGoFg6lgOtQV1OKkFpWvU6ONvd9cgOiEs3t4KGJm7LW2/XM1ULaJoSE+MDFWvGoDBVopptFGsbjCjOGQTsDBAxd592WTWSN9Zf7+3ftSJb3JFzEOL405jMUCF50Mf1S/V2WMFZA8TdcqYR/71lA/bckfi+y3jtJcvoGvji2jvGTzg2pxc4IUy4VyVQDBrfKG6CFSJuCK3aVHcRiTsGmYCESYkWYCPV6eAHCWWb9pYIfJOSQjQRxK0kiN8tqw4cEIBPX1mKZTK4H2HbN58RsQ1A1rOWJqGiEu2k9M2FMCs2jGTRnPHvc7XUyW+ev2yzGGP/OedK/lurYgOsm+lmxhHWj0601uRapo8xbpu275Qb1t+X4aga+wQ5YsvyTuD5njSEVmVAol+4+uFySiyTVsX/aXPn563+32GVfuq+tWhcpffkJYalycFGrCxltGILCHJhMKvr7DhH6LUSct/zpAYoKDyxR+4ejOscatIhpqaTJAiRFwleNoDUaLeNcuaELPkZRAiMdCVt3xhgXmN8CIi/eArrS8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(8676002)(8936002)(5660300002)(235185007)(186003)(26005)(1076003)(6512007)(6506007)(83380400001)(86362001)(2616005)(38100700002)(82960400001)(41300700001)(6666004)(6486002)(44144004)(45080400002)(966005)(66476007)(66556008)(66946007)(316002)(6916009)(36756003)(4326008)(478600001)(54906003)(2906002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wMxzvf2FCe/MgT756joxP4wHIQCjBQNObPpoFUYXABK6kQAn6QPr/8jYpKte?=
 =?us-ascii?Q?vMDf6S3ChH5oMesgnx7zOqaTuxNlvYMce/Xftm/YaLXDNKlsk182ok5CS56I?=
 =?us-ascii?Q?tHEoc9Mha51Nmx2yD1iUkv6ERb3Q99KGso7Wij+SNxPJEvXCHN2z2iTHNKWo?=
 =?us-ascii?Q?TMujlXk8ed6lTwiuchnK3BzkDIge30k6Z1MDqsajvAji25Y2nvSemJUXhu6w?=
 =?us-ascii?Q?2XcrJPcvsmbqshqooKk3CLdkyq/U2ZX/e9BXOxb6THn0ESQJAhJgEQFblTr2?=
 =?us-ascii?Q?JfJVIylTqVcD9xTidcM4hjImKqDH21+ieSWfpHMwhdE/op+A1F2Reny+T+yg?=
 =?us-ascii?Q?CsNoDNDV1CKOpu/5phvQ6ZYoDWVY1aZQ3frHa1djmjLbgnYy5E+1NmP+z9pv?=
 =?us-ascii?Q?fpGQkSadSBNCE40WOiK7rirQ5Rrv99fehgY/ZzeL7sc2nTmhdWc54zz/GA+1?=
 =?us-ascii?Q?hHTmpDFcSEyEwhKlrnxYzpmNgHrku8fzbwWSxXuv4c2mMeoBXTZgnIPBX7Lj?=
 =?us-ascii?Q?cDIblqQZntdURAHtgmzqh4na7xAZy1yjBkYZX2rS07UTJFMYQpHsYbrqFW8H?=
 =?us-ascii?Q?2Y1G+5pZWHexrJWsj7uOkjXV7lxzFa81nW1MyEI6xx4QkFfe2jBvbXpLVCFB?=
 =?us-ascii?Q?uW9gLuHm+9thn44g4x7ou/H3SjFaqoa7wW0JTGjVF3aWnicItvgLeUZVWTvi?=
 =?us-ascii?Q?3cnmpgLjJZvBPInMkbgTM6huRKwADwJGkKwft1WUXIGE2ejGNIAVkaWD2/ln?=
 =?us-ascii?Q?zSHquA6cIfrCrlKg7UZ8PyLCFJAvHL5cpynSxVUpZutuM61qFQOXHvWDRl3g?=
 =?us-ascii?Q?g2Q9jbgQJAW72lPQsYnYaWAtbfwI4uoexQo7sDp6KyTsKm7MePrNIxOZelCj?=
 =?us-ascii?Q?T+nBM5YF9QjZ7j4qKTRnbWnlRJoFcgVUoAGB/vvhSnuqvCr+e6ENpHsyf1o7?=
 =?us-ascii?Q?1Mj0O+YchrnCDBmrKYirkJyDlGklHc+rym4HnYdZn0EbT9dsC/9l58cua/dN?=
 =?us-ascii?Q?GCl0+7tra32fEqtUZBHRu5vhegBViOtqC/8GKn9Tkva4a85xyw//EzNKMZR7?=
 =?us-ascii?Q?sEEn2Ikz35nZntwSXBtzthYR/8CDtm5UT2ezTgVLZVEz6jazPXJdVXKvScOL?=
 =?us-ascii?Q?KwPNw7FQYCNb1OnKShIvUbzJWbngsXoDQci3gqN7uk7YFq0B704i4vn0wMv4?=
 =?us-ascii?Q?YcXMov53AeKkBxZacV1f+REBIM6FVcALwFepTsapLL6YMSXsDlo20jAxKmWy?=
 =?us-ascii?Q?BC2hgbi43mftBMMB8/GV1pnTGBOG7gfCPdcIqEtBlhZJg0P1w14doQGNm3dq?=
 =?us-ascii?Q?RGJ8r4/OD82MQcFiZ1FFMo2KEbPRea1ZcTC/DwzZoqt7f+5nkjrGiKByY5+k?=
 =?us-ascii?Q?k2iqZzGUkTC6ULRxgu9zx6c1KrpKDNnvDD/euNGDRZ/DiF9Qr/jQPKUtZ636?=
 =?us-ascii?Q?dfAoNRux9t/o7hylqvD7rCo28n/gXuOIeEXvm/Z26IQj29LQkSARhl3CSfTD?=
 =?us-ascii?Q?rkLZtvPbdYrU2TZ3iOoqB17fjHNRCWeuskG1OxT2gi5nbpa6WwW54BrXWtvY?=
 =?us-ascii?Q?MZOqwbqQWfaXTKmWSU5cWXewnk7l2PX/jIGbd/ck?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 603ea9f0-d83a-4062-ed7a-08db5a9e91b0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 08:28:50.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wPLVB8c+M1rASr8vpqlmDVgvQcWLXeRqyl3EmcoLgfZ3FcyqUrteRLIRyJq5nx+FuxkbwqrzkaFn6ks6SNwCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6992
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

--4fl2+zdcvTV6RaAH
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hello,

kernel test robot noticed "WARNING:at_kernel/locking/irqflag-debug.c:#warn_bogus_irq_disable" on:

commit: d91910ca3451a1d633351e3492117ca62054eb92 ("[RFC PATCH 3/3] irqflags: Warn on irq disable when disabled and enable when enabled")
url: https://github.com/intel-lab-lkp/linux/commits/Nicholas-Piggin/hrtimer-balance-irq-save-restore/20230509-191049
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 158009f1b4a33bc0f354b994eea361362bd83226
patch link: https://lore.kernel.org/all/20230509110739.241735-4-npiggin@gmail.com/
patch subject: [RFC PATCH 3/3] irqflags: Warn on irq disable when disabled and enable when enabled

in testcase: trinity
version: 
with following parameters:

	runtime: 600s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/

compiler: clang-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202305221624.b202695a-yujie.liu@intel.com


[    0.010000][    C0] ------------[ cut here ]------------
[    0.010000][    C0] raw_local_irq_disable() called with IRQs disabled
[ 0.010000][ C0] WARNING: CPU: 0 PID: 0 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_disable (kernel/locking/irqflag-debug.c:10) 
[    0.010000][    C0] Modules linked in:
[    0.010000][    C0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.3.0-rc3-00033-gd91910ca3451 #1 4790732644a1b20c085ca6f51351525a5135ad3c
[    0.010000][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[ 0.010000][ C0] EIP: warn_bogus_irq_disable (kernel/locking/irqflag-debug.c:10) 
[ 0.010000][ C0] Code: b3 e9 e9 fe ff ff 00 00 55 89 e5 80 3d 7d f1 48 b3 00 74 02 5d c3 c6 05 7d f1 48 b3 01 68 ea 43 d0 b2 e8 81 38 f0 fe 83 c4 04 <0f> 0b 5d c3 90 90 90 90 90 90 90 90 90 90 55 89 e5 80 3d 7e f1 48
All code
========
   0:	b3 e9                	mov    $0xe9,%bl
   2:	e9 fe ff ff 00       	jmp    0x1000005
   7:	00 55 89             	add    %dl,-0x77(%rbp)
   a:	e5 80                	in     $0x80,%eax
   c:	3d 7d f1 48 b3       	cmp    $0xb348f17d,%eax
  11:	00 74 02 5d          	add    %dh,0x5d(%rdx,%rax,1)
  15:	c3                   	ret
  16:	c6 05 7d f1 48 b3 01 	movb   $0x1,-0x4cb70e83(%rip)        # 0xffffffffb348f19a
  1d:	68 ea 43 d0 b2       	push   $0xffffffffb2d043ea
  22:	e8 81 38 f0 fe       	call   0xfffffffffef038a8
  27:	83 c4 04             	add    $0x4,%esp
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	5d                   	pop    %rbp
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	55                   	push   %rbp
  39:	89 e5                	mov    %esp,%ebp
  3b:	80                   	.byte 0x80
  3c:	3d                   	.byte 0x3d
  3d:	7e f1                	jle    0x30
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	5d                   	pop    %rbp
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	55                   	push   %rbp
   f:	89 e5                	mov    %esp,%ebp
  11:	80                   	.byte 0x80
  12:	3d                   	.byte 0x3d
  13:	7e f1                	jle    0x6
  15:	48                   	rex.W
[    0.010000][    C0] EAX: 00000031 EBX: 00000030 ECX: 00000000 EDX: b2e15db8
[    0.010000][    C0] ESI: 00200096 EDI: 00000030 EBP: b2e15e64 ESP: b2e15e64
[    0.010000][    C0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210082
[    0.010000][    C0] CR0: 80050033 CR2: ffd99000 CR3: 035b4000 CR4: 00040690
[    0.010000][    C0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.010000][    C0] DR6: fffe0ff0 DR7: 00000400
[    0.010000][    C0] Call Trace:
[ 0.010000][ C0] __irq_exit_rcu (kernel/softirq.c:?) 
[ 0.010000][ C0] irq_exit_rcu (kernel/softirq.c:664) 
[ 0.010000][ C0] common_interrupt (arch/x86/kernel/irq.c:240) 
[ 0.010000][ C0] asm_common_interrupt (arch/x86/entry/entry_32.S:636) 
[ 0.010000][ C0] EIP: _raw_spin_unlock_irqrestore (kernel/locking/spinlock.c:195) 
[ 0.010000][ C0] Code: 74 05 e8 07 dc fb fe c7 45 f4 ff ff ff ff 9c 8f 45 f4 f7 45 f4 00 02 00 00 75 16 f7 c6 00 02 00 00 74 01 fb ff 0d 84 e8 48 b3 <83> c4 04 5e 5f 5d c3 e8 58 49 ff ff f7 c6 00 02 00 00 75 e5 eb e4
All code
========
   0:	74 05                	je     0x7
   2:	e8 07 dc fb fe       	call   0xfffffffffefbdc0e
   7:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   e:	9c                   	pushf
   f:	8f 45 f4             	pop    -0xc(%rbp)
  12:	f7 45 f4 00 02 00 00 	testl  $0x200,-0xc(%rbp)
  19:	75 16                	jne    0x31
  1b:	f7 c6 00 02 00 00    	test   $0x200,%esi
  21:	74 01                	je     0x24
  23:	fb                   	sti
  24:	ff 0d 84 e8 48 b3    	decl   -0x4cb7177c(%rip)        # 0xffffffffb348e8ae
  2a:*	83 c4 04             	add    $0x4,%esp		<-- trapping instruction
  2d:	5e                   	pop    %rsi
  2e:	5f                   	pop    %rdi
  2f:	5d                   	pop    %rbp
  30:	c3                   	ret
  31:	e8 58 49 ff ff       	call   0xffffffffffff498e
  36:	f7 c6 00 02 00 00    	test   $0x200,%esi
  3c:	75 e5                	jne    0x23
  3e:	eb e4                	jmp    0x24

Code starting with the faulting instruction
===========================================
   0:	83 c4 04             	add    $0x4,%esp
   3:	5e                   	pop    %rsi
   4:	5f                   	pop    %rdi
   5:	5d                   	pop    %rbp
   6:	c3                   	ret
   7:	e8 58 49 ff ff       	call   0xffffffffffff4964
   c:	f7 c6 00 02 00 00    	test   $0x200,%esi
  12:	75 e5                	jne    0xfffffffffffffff9
  14:	eb e4                	jmp    0xfffffffffffffffa
[    0.010000][    C0] EAX: 00000193 EBX: b5dfd634 ECX: 00000000 EDX: b2e259b0
[    0.010000][    C0] ESI: 00200282 EDI: b5dfd660 EBP: b2e15f08 ESP: b2e15efc
[    0.010000][    C0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00200202
[ 0.010000][ C0] ? _raw_spin_unlock_irqrestore (kernel/locking/spinlock.c:195) 
[ 0.010000][ C0] __setup_irq (kernel/irq/internals.h:155) 
[ 0.010000][ C0] request_threaded_irq (kernel/irq/manage.c:2201) 
[ 0.010000][ C0] setup_default_timer_irq (include/linux/interrupt.h:168 arch/x86/kernel/time.c:70) 
[ 0.010000][ C0] hpet_time_init (arch/x86/kernel/time.c:?) 
[ 0.010000][ C0] x86_late_time_init (arch/x86/kernel/time.c:100) 
[ 0.010000][ C0] start_kernel (init/main.c:1117) 
[ 0.010000][ C0] i386_start_kernel (arch/x86/kernel/head32.c:57) 
[ 0.010000][ C0] startup_32_smp (arch/x86/kernel/head_32.S:319) 
[    0.010000][    C0] irq event stamp: 404
[ 0.010000][ C0] hardirqs last enabled at (403): _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 0.010000][ C0] hardirqs last disabled at (404): common_interrupt (arch/x86/kernel/irq.c:?) 
[ 0.010000][ C0] softirqs last enabled at (0): 0x0 
[ 0.010000][ C0] softirqs last disabled at (0): 0x0 
[    0.010000][    C0] ---[ end trace 0000000000000000 ]---


To reproduce:

        # build kernel
	cd linux
	cp config-6.3.0-rc3-00033-gd91910ca3451 .config
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

--4fl2+zdcvTV6RaAH
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.3.0-rc3-00033-gd91910ca3451"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.3.0-rc3 Kernel Configuration
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
CONFIG_BROKEN_ON_SMP=y
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
CONFIG_KERNEL_BZIP2=y
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
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
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

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_CGROUP_FAVOR_DYNMODS=y
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
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
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
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
# CONFIG_IO_URING is not set
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
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
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
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
CONFIG_MVIAC3_2=y
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_CYRIX_32 is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
CONFIG_CPU_SUP_UMC_32=y
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_X86_16BIT is not set
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_TOSHIBA is not set
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
CONFIG_VMSPLIT_3G_OPT=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xB0000000
CONFIG_HIGHMEM=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_HIGHPTE=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
# CONFIG_MTRR is not set
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
# CONFIG_EFI is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_STRICT_SIGALTSTACK_SIZE=y
# end of Processor type and features

CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
# CONFIG_RETPOLINE is not set
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_VIOT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_GOBIOS=y
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_BIOS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
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
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
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
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
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
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_LOCK_EVENT_COUNTS=y
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
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
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
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB_DEPRECATED is not set
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SLUB_STATS is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
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
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_GET_FREE_REGION=y
CONFIG_VMAP_PFN=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y
CONFIG_USERFAULTFD=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
# CONFIG_DAMON_VADDR is not set
# CONFIG_DAMON_PADDR is not set
# CONFIG_DAMON_SYSFS is not set
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
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
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
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
# CONFIG_COPS is not set
# CONFIG_IPDDP is not set
CONFIG_X25=y
CONFIG_LAPB=y
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=y
CONFIG_MAC802154=y
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUG is not set
CONFIG_BATMAN_ADV_TRACING=y
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
# CONFIG_MPLS is not set
CONFIG_NET_NSH=y
CONFIG_HSR=y
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
CONFIG_QRTR=y
CONFIG_QRTR_SMD=y
# CONFIG_QRTR_TUN is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

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
# CONFIG_AX25 is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_MCTP=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=y
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
# CONFIG_CFG80211_DEFAULT_PS is not set
CONFIG_CFG80211_DEBUGFS=y
# CONFIG_CFG80211_CRDA_SUPPORT is not set
# CONFIG_CFG80211_WEXT is not set
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=y
# CONFIG_NFC_NCI_UART is not set
CONFIG_NFC_HCI=y
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_MEI_PHY is not set
CONFIG_NFC_VIRTUAL_NCI=y
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN544_I2C is not set
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_USB=y
# CONFIG_NFC_PN533_I2C is not set
CONFIG_NFC_PN532_UART=y
CONFIG_NFC_MICROREAD=y
CONFIG_NFC_MICROREAD_I2C=y
CONFIG_NFC_MRVL=y
CONFIG_NFC_MRVL_USB=y
CONFIG_NFC_MRVL_I2C=y
CONFIG_NFC_ST21NFCA=y
CONFIG_NFC_ST21NFCA_I2C=y
CONFIG_NFC_ST_NCI=y
CONFIG_NFC_ST_NCI_I2C=y
CONFIG_NFC_NXP_NCI=y
CONFIG_NFC_NXP_NCI_I2C=y
CONFIG_NFC_S3FWRN5=y
CONFIG_NFC_S3FWRN5_I2C=y
# CONFIG_NFC_S3FWRN82_UART is not set
# end of Near Field Communication (NFC) devices

# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
# CONFIG_ETHTOOL_NETLINK is not set

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=y
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
CONFIG_PCIEASPM_POWER_SUPERSAVE=y
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
CONFIG_PCIE_BUS_SAFE=y
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
# CONFIG_PCIE_XILINX is not set
# CONFIG_PCIE_MICROCHIP_HOST is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
# CONFIG_PCIE_INTEL_GW is not set
CONFIG_PCI_MESON=y
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
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
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_CXL_BUS=y
CONFIG_CXL_PCI=y
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_CXL_ACPI=y
CONFIG_CXL_MEM=y
CONFIG_CXL_PORT=y
CONFIG_CXL_REGION=y
# CONFIG_CXL_REGION_INVALIDATION_TEST is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_DEVTMPFS_SAFE=y
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_LOADER_COMPRESS_XZ is not set
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
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
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
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
# CONFIG_EDD_OFF is not set
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
CONFIG_GNSS_SIRF_SERIAL=y
CONFIG_GNSS_UBX_SERIAL=y
CONFIG_GNSS_USB=y
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_OF_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

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
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
CONFIG_MTD_MAP_BANK_WIDTH_16=y
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
CONFIG_MTD_SBC_GXX=y
# CONFIG_MTD_AMD76XROM is not set
# CONFIG_MTD_ICHXROM is not set
CONFIG_MTD_ESB2ROM=y
# CONFIG_MTD_CK804XROM is not set
CONFIG_MTD_SCB2_FLASH=y
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
CONFIG_MTD_PCI=y
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

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
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
# CONFIG_MTD_ONENAND_GENERIC is not set
# CONFIG_MTD_ONENAND_OTP is not set
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=y
CONFIG_MTD_NAND_DENALI_PCI=y
# CONFIG_MTD_NAND_DENALI_DT is not set
CONFIG_MTD_NAND_CAFE=y
# CONFIG_MTD_NAND_CS553X is not set
CONFIG_MTD_NAND_MXIC=y
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_PLATFORM=y
CONFIG_MTD_NAND_CADENCE=y
# CONFIG_MTD_NAND_ARASAN is not set
# CONFIG_MTD_NAND_INTEL_LGM is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
CONFIG_MTD_NAND_ECC_SW_BCH=y
CONFIG_MTD_NAND_ECC_MXIC=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_UBI is not set
CONFIG_MTD_HYPERBUS=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_SMPRO_ERRMON=y
CONFIG_SMPRO_MISC=y
CONFIG_HI6421V600_IRQ=y
CONFIG_HP_ILO=y
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=y
# CONFIG_PCH_PHUB is not set
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
CONFIG_HISI_HIKEY_USB=y
# CONFIG_VCPU_STALL_DETECTOR is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_INTEL_MEI_GSC=y
CONFIG_INTEL_MEI_HDCP=y
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=y
# CONFIG_ECHO is not set
CONFIG_BCM_VK=y
# CONFIG_BCM_VK_TTY is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=y
CONFIG_MISC_RTSX_USB=y
# CONFIG_UACCE is not set
# CONFIG_PVPANIC is not set
CONFIG_GP_PCI1XXXX=y
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
CONFIG_FIREWIRE_NOSY=y
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
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
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
# CONFIG_CAIF_DRIVERS is not set
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
# CONFIG_ENA_ETHERNET is not set
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
# CONFIG_GEMINI_ETHERNET is not set
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
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
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
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
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
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
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
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
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
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH6KL is not set
# CONFIG_WIL6210 is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_MWIFIEX is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=y
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
CONFIG_KEYBOARD_ADP5520=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=y
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_PINEPHONE is not set
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
CONFIG_KEYBOARD_STOWAWAY=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
CONFIG_KEYBOARD_IQS62X=y
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_TWL4030=y
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
CONFIG_KEYBOARD_BCM=y
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_KEYBOARD_CYPRESS_SF=y
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=y
CONFIG_MOUSE_BCM5974=y
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_INPORT=y
# CONFIG_MOUSE_ATIXL is not set
CONFIG_MOUSE_LOGIBM=y
CONFIG_MOUSE_PC110PAD=y
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
CONFIG_MOUSE_SYNAPTICS_USB=y
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=y
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
CONFIG_TABLET_USB_PEGASUS=y
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F3A=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set
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
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DFL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_SPRD is not set
# CONFIG_SERIAL_LITEUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_SSIF_IPMI_BMC=y
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_CCTRNG=y
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_DTLK=y
CONFIG_APPLICOM=y
CONFIG_SONYPI=y
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C=y
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=y
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_INFINEON=y
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
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
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=y
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_EG20T=y
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_CP2615=y
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_PCA_ISA=y
CONFIG_SCx200_ACB=y
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
# CONFIG_SVC_I3C_MASTER is not set
CONFIG_MIPI_I3C_HCI=y
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_SPMI_HISI3670=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_AXP209=y
CONFIG_PINCTRL_CY8C95X0=y
CONFIG_PINCTRL_DA9062=y
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_PINCTRL_MAX77620=y
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
CONFIG_PINCTRL_OCELOT=y
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_STMFX=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_LOCHNAGAR=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L92=y

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
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y
CONFIG_GPIO_IDIO_16=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_ICH=y
CONFIG_GPIO_LOGICVC=y
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_VX855=y
CONFIG_GPIO_WCD934X=y
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=y
# CONFIG_GPIO_104_DIO_48E is not set
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_BD71815 is not set
CONFIG_GPIO_BD71828=y
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_CRYSTAL_COVE=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_LP87565=y
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_RC5T583=y
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TC3589X=y
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_LATCH=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_IP5XXX_POWER=y
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_QCOM_BATTMGR=y
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9150=y
# CONFIG_CHARGER_AXP20X is not set
CONFIG_BATTERY_AXP20X=y
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_BATTERY_TWL4030_MADC=y
CONFIG_CHARGER_88PM860X=y
# CONFIG_BATTERY_RX51 is not set
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_MP2629=y
CONFIG_CHARGER_MT6360=y
CONFIG_CHARGER_MT6370=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_BQ25980=y
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_CHARGER_TPS65217 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_RT9467 is not set
# CONFIG_CHARGER_RT9471 is not set
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_RN5T618_POWER is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_SMPRO is not set
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=y
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_CORSAIR_CPRO=y
CONFIG_SENSORS_CORSAIR_PSU=y
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_I8K is not set
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_GSC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LOCHNAGAR=y
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC2992=y
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX127=y
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX31760=y
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MC34VR500=y
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT6775_I2C=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=y
# CONFIG_SENSORS_PECI_CPUTEMP is not set
CONFIG_SENSORS_PECI_DIMMTEMP=y
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1266=y
CONFIG_SENSORS_ADM1275=y
# CONFIG_SENSORS_BEL_PFE is not set
CONFIG_SENSORS_BPA_RS600=y
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=y
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_DPS920AB is not set
CONFIG_SENSORS_INSPUR_IPSPS=y
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
CONFIG_SENSORS_IR38064=y
# CONFIG_SENSORS_IR38064_REGULATOR is not set
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LM25066_REGULATOR=y
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=y
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_MP2888=y
CONFIG_SENSORS_MP2975=y
CONFIG_SENSORS_MP5023=y
CONFIG_SENSORS_MPQ7932_REGULATOR=y
CONFIG_SENSORS_MPQ7932=y
CONFIG_SENSORS_PIM4328=y
CONFIG_SENSORS_PLI1209BC=y
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
CONFIG_SENSORS_PM6764TR=y
# CONFIG_SENSORS_PXE1610 is not set
CONFIG_SENSORS_Q54SJ108A2=y
CONFIG_SENSORS_STPDDC60=y
# CONFIG_SENSORS_TDA38640 is not set
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_TPS546D24=y
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_XDPE152=y
CONFIG_SENSORS_XDPE122=y
CONFIG_SENSORS_XDPE122_REGULATOR=y
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC2305=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA238=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_TMP464=y
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y
CONFIG_SENSORS_WM8350=y
# CONFIG_SENSORS_INTEL_M10_BMC_HWMON is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=y
# CONFIG_MAX77620_THERMAL is not set
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_TCC=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
CONFIG_INTEL_TCC_COOLING=y
# CONFIG_INTEL_MENLOW is not set
# end of Intel thermal drivers

# CONFIG_TI_SOC_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_SMPRO=y
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
# CONFIG_MFD_CS47L15 is not set
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_GATEWORKS_GSC=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=y
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_MFD_HI6421_SPMI=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6370=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_NTXEC is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_SY7636A=y
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RT5120=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS65219=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD71828=y
CONFIG_MFD_ROHM_BD957XMUF=y
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_RAVE_SP_CORE=y
CONFIG_MFD_INTEL_M10_BMC_CORE=y
CONFIG_MFD_INTEL_M10_BMC_PMCI=y
CONFIG_MFD_RSMU_I2C=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_ATC260X=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
# CONFIG_REGULATOR_BD71815 is not set
CONFIG_REGULATOR_BD71828=y
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_BD957XMUF=y
# CONFIG_REGULATOR_DA9055 is not set
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421V600=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LOCHNAGAR=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8893 is not set
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8997 is not set
# CONFIG_REGULATOR_MAX20086 is not set
# CONFIG_REGULATOR_MAX20411 is not set
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=y
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MP886X=y
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6331=y
CONFIG_REGULATOR_MT6332=y
# CONFIG_REGULATOR_MT6357 is not set
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6359=y
CONFIG_REGULATOR_MT6360=y
# CONFIG_REGULATOR_MT6370 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PF8X00=y
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_ROHM=y
# CONFIG_REGULATOR_RT4801 is not set
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_RT5120 is not set
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5759=y
CONFIG_REGULATOR_RT6160=y
CONFIG_REGULATOR_RT6190=y
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=y
# CONFIG_REGULATOR_RTQ6752 is not set
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=y
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS6286X=y
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS65217 is not set
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS65219=y
CONFIG_REGULATOR_TPS6586X=y
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM831X is not set
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8994=y
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=y
# CONFIG_LIRC is not set
CONFIG_RC_MAP=y
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=y
CONFIG_IR_JVC_DECODER=y
# CONFIG_IR_MCE_KBD_DECODER is not set
CONFIG_IR_NEC_DECODER=y
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=y
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=y
CONFIG_IR_SHARP_DECODER=y
CONFIG_IR_SONY_DECODER=y
# CONFIG_IR_XMP_DECODER is not set
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=y
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_DMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=y
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
CONFIG_DRM_I915_SW_FENCE_CHECK_DAG=y
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y
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

CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
CONFIG_DRM_VMWGFX=y
CONFIG_DRM_VMWGFX_MKSSTATS=y
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=y
CONFIG_DRM_MGAG200=y
CONFIG_DRM_QXL=y
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=y
# CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
CONFIG_DRM_PANEL_DSI_CM=y
CONFIG_DRM_PANEL_LVDS=y
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set
CONFIG_DRM_PANEL_ELIDA_KD35T133=y
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
CONFIG_DRM_PANEL_HIMAX_HX8394=y
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
CONFIG_DRM_PANEL_JADARD_JD9365DA_H3=y
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
CONFIG_DRM_PANEL_JDI_R63452=y
# CONFIG_DRM_PANEL_KHADAS_TS050 is not set
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=y
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=y
CONFIG_DRM_PANEL_NEWVISION_NV3051D=y
CONFIG_DRM_PANEL_NOVATEK_NT35510=y
CONFIG_DRM_PANEL_NOVATEK_NT35560=y
CONFIG_DRM_PANEL_NOVATEK_NT35950=y
CONFIG_DRM_PANEL_NOVATEK_NT36672A=y
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=y
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI=y
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=y
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
CONFIG_DRM_PANEL_SHARP_LS060T1SX01=y
CONFIG_DRM_PANEL_SITRONIX_ST7701=y
CONFIG_DRM_PANEL_SITRONIX_ST7703=y
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
CONFIG_DRM_PANEL_TDO_TL070WSH30=y
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
CONFIG_DRM_PANEL_VISIONOX_RM69299=y
CONFIG_DRM_PANEL_VISIONOX_VTDR6130=y
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CHIPONE_ICN6211=y
# CONFIG_DRM_CHRONTEL_CH7033 is not set
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_ITE_IT6505 is not set
# CONFIG_DRM_LONTIUM_LT8912B is not set
# CONFIG_DRM_LONTIUM_LT9211 is not set
CONFIG_DRM_LONTIUM_LT9611=y
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
# CONFIG_DRM_ITE_IT66121 is not set
# CONFIG_DRM_LVDS_CODEC is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
# CONFIG_DRM_NWL_MIPI_DSI is not set
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
CONFIG_DRM_PARADE_PS8640=y
CONFIG_DRM_SIL_SII8620=y
CONFIG_DRM_SII902X=y
# CONFIG_DRM_SII9234 is not set
CONFIG_DRM_SIMPLE_BRIDGE=y
CONFIG_DRM_THINE_THC63LVD1024=y
CONFIG_DRM_TOSHIBA_TC358762=y
CONFIG_DRM_TOSHIBA_TC358764=y
# CONFIG_DRM_TOSHIBA_TC358767 is not set
CONFIG_DRM_TOSHIBA_TC358768=y
# CONFIG_DRM_TOSHIBA_TC358775 is not set
CONFIG_DRM_TI_DLPC3433=y
# CONFIG_DRM_TI_TFP410 is not set
CONFIG_DRM_TI_SN65DSI83=y
# CONFIG_DRM_TI_SN65DSI86 is not set
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=y
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_ANALOGIX_ANX7625=y
# CONFIG_DRM_I2C_ADV7511 is not set
CONFIG_DRM_CDNS_DSI=y
CONFIG_DRM_CDNS_DSI_J721E=y
CONFIG_DRM_CDNS_MHDP8546=y
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_LOGICVC is not set
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_BOCHS=y
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_GM12U320=y
# CONFIG_DRM_SIMPLEDRM is not set
CONFIG_DRM_VBOXVIDEO=y
# CONFIG_DRM_GUD is not set
CONFIG_DRM_SSD130X=y
# CONFIG_DRM_SSD130X_I2C is not set
CONFIG_DRM_LEGACY=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
# CONFIG_FB_PM2 is not set
CONFIG_FB_CYBER2000=y
# CONFIG_FB_CYBER2000_DDC is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_RIVA_DEBUG=y
# CONFIG_FB_RIVA_BACKLIGHT is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=y
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=y
# CONFIG_FB_SAVAGE_I2C is not set
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
# CONFIG_FB_VIA is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=y
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=y
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SSD1307 is not set
CONFIG_FB_SM712=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_MT6370=y
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_WM831X is not set
# CONFIG_BACKLIGHT_ADP5520 is not set
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_AAT2870=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_TPS65217=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=y
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_DRM_ACCEL=y
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
CONFIG_SND_PCM_OSS=y
# CONFIG_SND_PCM_OSS_PLUGINS is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
# CONFIG_SND_VERBOSE_PROCFS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_CTL_FAST_LOOKUP=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_CTL_INPUT_VALIDATION=y
# CONFIG_SND_CTL_DEBUG is not set
# CONFIG_SND_JACK_INJECTION_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_MIDI_EMUL=y
CONFIG_SND_SEQ_VIRMIDI=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_OPL4_LIB=y
CONFIG_SND_OPL3_LIB_SEQ=y
CONFIG_SND_OPL4_LIB_SEQ=y
CONFIG_SND_VX_LIB=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
CONFIG_SND_VIRMIDI=y
CONFIG_SND_MTPAV=y
# CONFIG_SND_MTS64 is not set
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_SERIAL_GENERIC=y
CONFIG_SND_MPU401=y
CONFIG_SND_PORTMAN2X4=y
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_WSS_LIB=y
CONFIG_SND_SB_COMMON=y
CONFIG_SND_SB8_DSP=y
CONFIG_SND_SB16_DSP=y
CONFIG_SND_ISA=y
CONFIG_SND_ADLIB=y
CONFIG_SND_AD1816A=y
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_ALS100 is not set
CONFIG_SND_AZT1605=y
# CONFIG_SND_AZT2316 is not set
CONFIG_SND_AZT2320=y
# CONFIG_SND_CMI8328 is not set
CONFIG_SND_CMI8330=y
# CONFIG_SND_CS4231 is not set
CONFIG_SND_CS4236=y
CONFIG_SND_ES1688=y
CONFIG_SND_ES18XX=y
# CONFIG_SND_SC6000 is not set
CONFIG_SND_GUSCLASSIC=y
CONFIG_SND_GUSEXTREME=y
# CONFIG_SND_GUSMAX is not set
CONFIG_SND_INTERWAVE=y
CONFIG_SND_INTERWAVE_STB=y
CONFIG_SND_JAZZ16=y
CONFIG_SND_OPL3SA2=y
# CONFIG_SND_OPTI92X_AD1848 is not set
CONFIG_SND_OPTI92X_CS4231=y
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_MIRO is not set
CONFIG_SND_SB8=y
CONFIG_SND_SB16=y
CONFIG_SND_SBAWE=y
CONFIG_SND_SBAWE_SEQ=y
# CONFIG_SND_SB16_CSP is not set
CONFIG_SND_SSCAPE=y
CONFIG_SND_WAVEFRONT=y
# CONFIG_SND_MSND_PINNACLE is not set
# CONFIG_SND_MSND_CLASSIC is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
CONFIG_SND_ALS4000=y
# CONFIG_SND_ALI5451 is not set
CONFIG_SND_ASIHPI=y
CONFIG_SND_ATIIXP=y
CONFIG_SND_ATIIXP_MODEM=y
CONFIG_SND_AU8810=y
# CONFIG_SND_AU8820 is not set
CONFIG_SND_AU8830=y
# CONFIG_SND_AW2 is not set
CONFIG_SND_AZT3328=y
CONFIG_SND_BT87X=y
CONFIG_SND_BT87X_OVERCLOCK=y
CONFIG_SND_CA0106=y
CONFIG_SND_CMIPCI=y
CONFIG_SND_OXYGEN_LIB=y
CONFIG_SND_OXYGEN=y
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=y
# CONFIG_SND_CS46XX_NEW_DSP is not set
# CONFIG_SND_CS5530 is not set
CONFIG_SND_CS5535AUDIO=y
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
CONFIG_SND_GINA20=y
CONFIG_SND_LAYLA20=y
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
CONFIG_SND_LAYLA24=y
CONFIG_SND_MONA=y
CONFIG_SND_MIA=y
CONFIG_SND_ECHO3G=y
CONFIG_SND_INDIGO=y
# CONFIG_SND_INDIGOIO is not set
CONFIG_SND_INDIGODJ=y
# CONFIG_SND_INDIGOIOX is not set
CONFIG_SND_INDIGODJX=y
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=y
CONFIG_SND_ES1938=y
CONFIG_SND_ES1968=y
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_FM801=y
# CONFIG_SND_HDSP is not set
CONFIG_SND_HDSPM=y
CONFIG_SND_ICE1712=y
CONFIG_SND_ICE1724=y
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
CONFIG_SND_KORG1212=y
CONFIG_SND_LOLA=y
# CONFIG_SND_LX6464ES is not set
CONFIG_SND_MAESTRO3=y
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=y
CONFIG_SND_NM256=y
# CONFIG_SND_PCXHR is not set
CONFIG_SND_RIPTIDE=y
CONFIG_SND_RME32=y
# CONFIG_SND_RME96 is not set
CONFIG_SND_RME9652=y
CONFIG_SND_SIS7019=y
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=y
CONFIG_SND_VIA82XX=y
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
CONFIG_SND_VX222=y
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
# CONFIG_SND_HDA_INPUT_BEEP is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
# CONFIG_SND_HDA_CODEC_REALTEK is not set
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
CONFIG_SND_HDA_CODEC_CS8409=y
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
CONFIG_SND_HDA_CODEC_CA0110=y
CONFIG_SND_HDA_CODEC_CA0132=y
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# CONFIG_SND_HDA_CTL_DEV_ID is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
# CONFIG_SND_USB is not set
# CONFIG_SND_SOC is not set
# CONFIG_SND_X86 is not set
CONFIG_SND_SYNTH_EMUX=y
# CONFIG_SND_VIRTIO is not set
CONFIG_AC97_BUS=y
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
# CONFIG_HID_VIVALDI is not set
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NINTENDO=y
CONFIG_NINTENDO_FF=y
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_PXRC=y
CONFIG_HID_RAZER=y
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=y
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=y
# CONFIG_STEAM_FF is not set
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_TOPRE=y
CONFIG_HID_THINGM=y
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# HID-BPF support
#
# end of HID-BPF support

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# end of USB HID Boot Protocol drivers
# end of USB HID support

# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_PCI is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_FEW_INIT_RETRIES=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USBIP_CORE=y
CONFIG_USBIP_VHCI_HCD=y
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
CONFIG_USBIP_HOST=y
CONFIG_USBIP_DEBUG=y

#
# USB dual-mode controller drivers
#
CONFIG_USB_CDNS_SUPPORT=y
CONFIG_USB_CDNS3=y
# CONFIG_USB_CDNS3_HOST is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_CHIPIDEA_MSM=y
# CONFIG_USB_CHIPIDEA_IMX is not set
# CONFIG_USB_CHIPIDEA_GENERIC is not set
CONFIG_USB_CHIPIDEA_TEGRA=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=y
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=y
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ONBOARD_HUB is not set
CONFIG_USB_ATM=y
CONFIG_USB_SPEEDTOUCH=y
CONFIG_USB_CXACRU=y
CONFIG_USB_UEAGLEATM=y
CONFIG_USB_XUSBATM=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
# CONFIG_TYPEC_TCPCI is not set
CONFIG_TYPEC_FUSB302=y
CONFIG_TYPEC_UCSI=y
CONFIG_UCSI_CCG=y
# CONFIG_UCSI_ACPI is not set
CONFIG_UCSI_STM32G0=y
CONFIG_TYPEC_TPS6598X=y
CONFIG_TYPEC_ANX7411=y
CONFIG_TYPEC_RT1719=y
# CONFIG_TYPEC_HD3SS3220 is not set
# CONFIG_TYPEC_STUSB160X is not set
CONFIG_TYPEC_WUSB3801=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=y
CONFIG_TYPEC_MUX_GPIO_SBU=y
CONFIG_TYPEC_MUX_PI3USB30532=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=y
# CONFIG_PWRSEQ_EMMC is not set
CONFIG_PWRSEQ_SIMPLE=y
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_MMC_RICOH_MMC=y
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
CONFIG_MMC_SDHCI_OF_AT91=y
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
CONFIG_MMC_SDHCI_CADENCE=y
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_SDHCI_MILBEAUT=y
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=y
# CONFIG_MMC_CB710 is not set
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_REALTEK_USB=y
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=y
CONFIG_MMC_TOSHIBA_PCI=y
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=y
CONFIG_MMC_SDHCI_OMAP=y
# CONFIG_MMC_SDHCI_AM654 is not set
CONFIG_MMC_SDHCI_EXTERNAL_DMA=y
CONFIG_MMC_LITEX=y
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_PCI=y
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=y
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_LP55XX_COMMON is not set
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=y
CONFIG_LEDS_LM36274=y
# CONFIG_LEDS_LGM is not set

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
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=y
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_AMD76X is not set
CONFIG_EDAC_E7XXX=y
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
CONFIG_EDAC_I82975X=y
# CONFIG_EDAC_I3000 is not set
CONFIG_EDAC_I3200=y
CONFIG_EDAC_IE31200=y
# CONFIG_EDAC_X38 is not set
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I82860=y
# CONFIG_EDAC_R82600 is not set
CONFIG_EDAC_I5100=y
CONFIG_EDAC_I7300=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
# CONFIG_RTC_DRV_88PM80X is not set
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_HYM8563 is not set
CONFIG_RTC_DRV_LP8788=y
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=y
# CONFIG_RTC_DRV_MAX8997 is not set
# CONFIG_RTC_DRV_MAX77686 is not set
# CONFIG_RTC_DRV_NCT3018Y is not set
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BD70528 is not set
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TWL4030=y
CONFIG_RTC_DRV_TPS6586X=y
# CONFIG_RTC_DRV_RC5T583 is not set
# CONFIG_RTC_DRV_RC5T619 is not set
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
# CONFIG_RTC_DRV_RX8581 is not set
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
CONFIG_RTC_DRV_RV3032=y
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
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
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=y
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=y
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9055=y
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_WM831X=y
# CONFIG_RTC_DRV_WM8350 is not set
# CONFIG_RTC_DRV_ZYNQMP is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=y
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_MT6397=y
CONFIG_RTC_DRV_R7301=y

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=y
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
# CONFIG_DW_AXI_DMAC is not set
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
CONFIG_PLX_DMA=y
CONFIG_TIMB_DMA=y
CONFIG_XILINX_XDMA=y
CONFIG_XILINX_ZYNQMP_DPDMA=y
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_DW_EDMA=y
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
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
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=y
CONFIG_LCD2S=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=y
CONFIG_UIO=y
CONFIG_UIO_CIF=y
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=y
CONFIG_UIO_PCI_GENERIC=y
CONFIG_UIO_NETX=y
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_DFL=y
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
CONFIG_VBOXGUEST=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
# CONFIG_VIRTIO_VDPA is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VDPA=y
CONFIG_VDPA_SIM=y
# CONFIG_VDPA_SIM_NET is not set
CONFIG_VDPA_SIM_BLOCK=y
# CONFIG_IFCVF is not set
CONFIG_MLX5_VDPA=y
CONFIG_MLX5_VDPA_STEERING_DEBUG=y
CONFIG_VP_VDPA=y
# CONFIG_ALIBABA_ENI_VDPA is not set
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST_RING=y
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
# CONFIG_COMEDI_SSV_DNP is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=y
# CONFIG_COMEDI_8255_PCI is not set
CONFIG_COMEDI_ADDI_WATCHDOG=y
CONFIG_COMEDI_ADDI_APCI_1032=y
CONFIG_COMEDI_ADDI_APCI_1500=y
CONFIG_COMEDI_ADDI_APCI_1516=y
CONFIG_COMEDI_ADDI_APCI_1564=y
CONFIG_COMEDI_ADDI_APCI_16XX=y
CONFIG_COMEDI_ADDI_APCI_2032=y
CONFIG_COMEDI_ADDI_APCI_2200=y
CONFIG_COMEDI_ADDI_APCI_3120=y
CONFIG_COMEDI_ADDI_APCI_3501=y
CONFIG_COMEDI_ADDI_APCI_3XXX=y
CONFIG_COMEDI_ADL_PCI6208=y
CONFIG_COMEDI_ADL_PCI7X3X=y
# CONFIG_COMEDI_ADL_PCI8164 is not set
CONFIG_COMEDI_ADL_PCI9111=y
CONFIG_COMEDI_ADL_PCI9118=y
CONFIG_COMEDI_ADV_PCI1710=y
CONFIG_COMEDI_ADV_PCI1720=y
CONFIG_COMEDI_ADV_PCI1723=y
# CONFIG_COMEDI_ADV_PCI1724 is not set
# CONFIG_COMEDI_ADV_PCI1760 is not set
CONFIG_COMEDI_ADV_PCI_DIO=y
CONFIG_COMEDI_AMPLC_DIO200_PCI=y
CONFIG_COMEDI_AMPLC_PC236_PCI=y
CONFIG_COMEDI_AMPLC_PC263_PCI=y
CONFIG_COMEDI_AMPLC_PCI224=y
CONFIG_COMEDI_AMPLC_PCI230=y
# CONFIG_COMEDI_CONTEC_PCI_DIO is not set
# CONFIG_COMEDI_DAS08_PCI is not set
CONFIG_COMEDI_DT3000=y
CONFIG_COMEDI_DYNA_PCI10XX=y
# CONFIG_COMEDI_GSC_HPDI is not set
# CONFIG_COMEDI_MF6X4 is not set
# CONFIG_COMEDI_ICP_MULTI is not set
# CONFIG_COMEDI_DAQBOARD2000 is not set
CONFIG_COMEDI_JR3_PCI=y
CONFIG_COMEDI_KE_COUNTER=y
CONFIG_COMEDI_CB_PCIDAS64=y
CONFIG_COMEDI_CB_PCIDAS=y
CONFIG_COMEDI_CB_PCIDDA=y
CONFIG_COMEDI_CB_PCIMDAS=y
# CONFIG_COMEDI_CB_PCIMDDA is not set
CONFIG_COMEDI_ME4000=y
# CONFIG_COMEDI_ME_DAQ is not set
# CONFIG_COMEDI_NI_6527 is not set
# CONFIG_COMEDI_NI_65XX is not set
CONFIG_COMEDI_NI_660X=y
CONFIG_COMEDI_NI_670X=y
# CONFIG_COMEDI_NI_LABPC_PCI is not set
# CONFIG_COMEDI_NI_PCIDIO is not set
CONFIG_COMEDI_NI_PCIMIO=y
CONFIG_COMEDI_RTD520=y
# CONFIG_COMEDI_S626 is not set
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_NI_TIOCMD=y
CONFIG_COMEDI_USB_DRIVERS=y
CONFIG_COMEDI_DT9812=y
# CONFIG_COMEDI_NI_USB6501 is not set
CONFIG_COMEDI_USBDUX=y
# CONFIG_COMEDI_USBDUXFAST is not set
# CONFIG_COMEDI_USBDUXSIGMA is not set
# CONFIG_COMEDI_VMK80XX is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CROS_EC is not set
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
# CONFIG_HUAWEI_WMI is not set
# CONFIG_MXM_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACER_WMI is not set
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_LG_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_COMMON_CLK_AXI_CLKGEN=y
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
CONFIG_COMMON_CLK_RS9_PCIE=y
CONFIG_COMMON_CLK_VC5=y
# CONFIG_COMMON_CLK_VC7 is not set
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_XILINX_VCU is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
# CONFIG_INTEL_IOMMU is not set
CONFIG_IOMMUFD=y
# CONFIG_IOMMUFD_TEST is not set
CONFIG_VIRTIO_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
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
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_PDR_HELPERS=y
CONFIG_QCOM_PMIC_GLINK=y
CONFIG_QCOM_QMI_HELPERS=y
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
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_TUSB320=y
CONFIG_MEMORY=y
# CONFIG_FPGA_DFL_EMIF is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
# CONFIG_ADXL313_I2C is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL355=y
CONFIG_ADXL355_I2C=y
CONFIG_ADXL367=y
CONFIG_ADXL367_I2C=y
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=y
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=y
# CONFIG_DA311 is not set
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_IIO_KX022A=y
CONFIG_IIO_KX022A_I2C=y
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
CONFIG_MSA311=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
CONFIG_AD7291=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD799X is not set
CONFIG_ADI_AXI_ADC=y
CONFIG_AXP20X_ADC=y
# CONFIG_AXP288_ADC is not set
CONFIG_CC10001_ADC=y
# CONFIG_DA9150_GPADC is not set
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
# CONFIG_LP8788_ADC is not set
CONFIG_LTC2471=y
CONFIG_LTC2485=y
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=y
CONFIG_MEDIATEK_MT6360_ADC=y
CONFIG_MEDIATEK_MT6370_ADC=y
CONFIG_MP2629_ADC=y
# CONFIG_NAU7802 is not set
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_SPMI_IADC=y
# CONFIG_QCOM_SPMI_VADC is not set
CONFIG_QCOM_SPMI_ADC5=y
CONFIG_RN5T618_ADC=y
# CONFIG_RICHTEK_RTQ6056 is not set
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_STMPE_ADC=y
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADS1015=y
CONFIG_TI_ADS7924=y
CONFIG_TI_AM335X_ADC=y
CONFIG_TWL4030_MADC=y
# CONFIG_TWL6030_GPADC is not set
CONFIG_VF610_ADC=y
CONFIG_VIPERBOARD_ADC=y
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
CONFIG_STX104=y
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
CONFIG_AD7150=y
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
CONFIG_CCS811=y
CONFIG_IAQCORE=y
CONFIG_PMS7003=y
CONFIG_SCD30_CORE=y
# CONFIG_SCD30_I2C is not set
CONFIG_SCD30_SERIAL=y
CONFIG_SCD4X=y
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
# CONFIG_SPS30_I2C is not set
# CONFIG_SPS30_SERIAL is not set
CONFIG_SENSEAIR_SUNRISE_CO2=y
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
# CONFIG_AD5380 is not set
# CONFIG_AD5446 is not set
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
# CONFIG_AD5696_I2C is not set
CONFIG_CIO_DAC=y
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
CONFIG_M62332=y
# CONFIG_MAX517 is not set
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
# CONFIG_TI_DAC5571 is not set
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=y
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
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
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
# CONFIG_IIO_ST_GYRO_I2C_3AXIS is not set
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
CONFIG_HDC2010=y
CONFIG_HID_SENSOR_HUMIDITY=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
# CONFIG_BOSCH_BNO055_SERIAL is not set
# CONFIG_BOSCH_BNO055_I2C is not set
# CONFIG_FXOS8700_I2C is not set
CONFIG_KMX61=y
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_AS73211 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
CONFIG_CM3605=y
# CONFIG_CM36651 is not set
CONFIG_GP2AP002=y
# CONFIG_GP2AP020A00F is not set
CONFIG_IQS621_ALS=y
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
CONFIG_HID_SENSOR_PROX=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
CONFIG_LTRF216A=y
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=y
CONFIG_MAX44009=y
CONFIG_NOA1305=y
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL2591=y
CONFIG_TSL2772=y
# CONFIG_TSL4531 is not set
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_MAG3110=y
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# CONFIG_TI_TMAG5273 is not set
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# CONFIG_IQS624_POS is not set
CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5432=y
# CONFIG_MCP4018 is not set
CONFIG_MCP4531=y
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
CONFIG_DPS310=y
CONFIG_HID_SENSOR_PRESS=y
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
# CONFIG_IIO_ST_PRESS_I2C is not set
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=y
# CONFIG_PING is not set
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX_COMMON=y
CONFIG_SX9310=y
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
CONFIG_SX9500=y
CONFIG_SRF08=y
CONFIG_VCNL3020=y
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_IQS620AT_TEMP is not set
CONFIG_HID_SENSOR_TEMP=y
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
CONFIG_TMP007=y
# CONFIG_TMP117 is not set
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
CONFIG_MAX30208=y
# end of Temperature sensors

CONFIG_NTB=y
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
CONFIG_MADERA_IRQ=y
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=y
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_LAN966X_SERDES=y
CONFIG_PHY_CPCAP_USB=y
CONFIG_PHY_MAPPHONE_MDM6600=y
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_HSIC=y
# CONFIG_PHY_TUSB1210 is not set
CONFIG_PHY_INTEL_LGM_COMBO=y
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=y
CONFIG_USB4_DEBUGFS_WRITE=y
CONFIG_USB4_DEBUGFS_MARGINING=y
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_RAVE_SP_EEPROM=y
CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_SPMI_SDAM=y
CONFIG_NVMEM_U_BOOT_ENV=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
CONFIG_FPGA_MGR_ALTERA_CVP=y
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_OF_FPGA_REGION=y
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
CONFIG_FPGA_DFL_FME_MGR=y
CONFIG_FPGA_DFL_FME_BRIDGE=y
CONFIG_FPGA_DFL_FME_REGION=y
CONFIG_FPGA_DFL_AFU=y
CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=y
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_FPGA_M10_BMC_SEC_UPDATE=y
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
# CONFIG_INTEL_QEP is not set
CONFIG_INTERRUPT_CNT=y
# CONFIG_MOST is not set
CONFIG_PECI=y
CONFIG_PECI_CPU=y
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_STATIC_USERMODEHELPER is not set
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
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
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
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARIA=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TEA=y
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
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
# CONFIG_CRYPTO_BLAKE2B is not set
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLYVAL=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_VMAC is not set
CONFIG_CRYPTO_WP512=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_TWOFISH_586=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
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
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
# CONFIG_CRC64_ROCKSOFT is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
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
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
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
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
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
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
# CONFIG_SYMBOLIC_ERRNAME is not set
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
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
CONFIG_VMLINUX_MAP=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
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
CONFIG_NET_DEV_REFCNT_TRACKER=y
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
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_TEST is not set
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SHRINKER_DEBUG=y
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_MAPLE_TREE=y
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
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
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
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
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y

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
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
CONFIG_DEBUG_MAPLE_TREE=y
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
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
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
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
CONFIG_MMIOTRACE=y
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_UPROBE_EVENTS is not set
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
CONFIG_RV=y
# CONFIG_RV_MON_WWNR is not set
# CONFIG_RV_REACTORS is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
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
# CONFIG_TEST_DYNAMIC_DEBUG is not set
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

--4fl2+zdcvTV6RaAH
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=600
	export job_origin='trinity.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-devel/devel-hourly-20230515-075501'
	export commit='d91910ca3451a1d633351e3492117ca62054eb92'
	export kconfig='i386-randconfig-i052-20230515'
	export nr_vm=300
	export submit_id='6465cc398f4bb6280797b1f2'
	export job_file='/lkp/jobs/scheduled/vm-meta-269/trinity-600s-yocto-i386-minimal-20190520.cgz-d91910ca3451a1d633351e3492117ca62054eb92-20230518-75783-6se10v-0.yaml'
	export id='7c09a47d7ecf1437682026be34da388d5d3e9a45'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='yocto-i386-minimal-20190520.cgz'
	export compiler='clang-14'
	export enqueue_time='2023-05-18 14:56:58 +0800'
	export _id='6465cc398f4bb6280797b1f2'
	export _rt='/result/trinity/600s/vm-snb/yocto-i386-minimal-20190520.cgz/i386-randconfig-i052-20230515/clang-14/d91910ca3451a1d633351e3492117ca62054eb92'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/trinity/600s/vm-snb/yocto-i386-minimal-20190520.cgz/i386-randconfig-i052-20230515/clang-14/d91910ca3451a1d633351e3492117ca62054eb92/0'
	export scheduler_version='/lkp/lkp/.src-20230517-200353'
	export arch='i386'
	export max_uptime=1200
	export initrd='/osimage/yocto/yocto-i386-minimal-20190520.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/600s/vm-snb/yocto-i386-minimal-20190520.cgz/i386-randconfig-i052-20230515/clang-14/d91910ca3451a1d633351e3492117ca62054eb92/0
BOOT_IMAGE=/pkg/linux/i386-randconfig-i052-20230515/clang-14/d91910ca3451a1d633351e3492117ca62054eb92/vmlinuz-6.3.0-rc3-00033-gd91910ca3451
branch=linux-devel/devel-hourly-20230515-075501
job=/lkp/jobs/scheduled/vm-meta-269/trinity-600s-yocto-i386-minimal-20190520.cgz-d91910ca3451a1d633351e3492117ca62054eb92-20230518-75783-6se10v-0.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-i052-20230515
commit=d91910ca3451a1d633351e3492117ca62054eb92
initcall_debug
mem=4G
nmi_watchdog=0
vmalloc=256M initramfs_async=0 page_owner=on
max_uptime=1200
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
	export modules_initrd='/pkg/linux/i386-randconfig-i052-20230515/clang-14/d91910ca3451a1d633351e3492117ca62054eb92/modules.cgz'
	export bm_initrd='/osimage/pkg/debian-x86_64-20180403.cgz/trinity-static-i386-x86_64-1c734c75-1_2020-01-06.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export meta_host='vm-meta-269'
	export kernel='/pkg/linux/i386-randconfig-i052-20230515/clang-14/d91910ca3451a1d633351e3492117ca62054eb92/vmlinuz-6.3.0-rc3-00033-gd91910ca3451'
	export dequeue_time='2023-05-18 15:39:21 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-269/trinity-600s-yocto-i386-minimal-20190520.cgz-d91910ca3451a1d633351e3492117ca62054eb92-20230518-75783-6se10v-0.cgz'

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

	run_test $LKP_SRC/tests/wrapper trinity
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

--4fl2+zdcvTV6RaAH
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
ygAB+6oDq4kZnSwlz7HEZ/sCAAAAAARZWg==

--4fl2+zdcvTV6RaAH
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="trinity"

Seeding trinity by 77149 based on vm-snb/yocto-i386-minimal-20190520.cgz/i386-randconfig-i052-20230515
2023-05-18 07:40:04 trinity -q -q -l off -s 77149 -x get_robust_list -x remap_file_pages -N 999999999 -X
Trinity 2019.06  Dave Jones <davej@codemonkey.org.uk>
shm:0xa7532000-0xb3cdee14 (4 pages)
[main] Marking syscall get_robust_list (312) as to be disabled.
[main] Marking syscall remap_file_pages (257) as to be disabled.
[main] Using user passed random seed: 77149.
[main] Kernel was tainted on startup. Will ignore flags that are already set.
Marking all syscalls as enabled.
[main] Disabling syscalls marked as disabled by command line options
[main] Marked syscall remap_file_pages (257) as deactivated.
[main] Marked syscall get_robust_list (312) as deactivated.
[main] Enabled 426 syscalls. Disabled 3 syscalls.
--dropprivs is still in development, and really shouldn't be used unless you're helping development. Expect crashes.
Going to run as user nobody (uid:65534 gid:65534)
ctrl-c now unless you really know what you are doing.
Continuing in 10 seconds.
Continuing in 9 seconds.
Continuing in 8 seconds.
Continuing in 7 seconds.
Continuing in 6 seconds.
Continuing in 5 seconds.
Continuing in 4 seconds.
Continuing in 3 seconds.
Continuing in 2 seconds.
Continuing in 1 seconds.
[main] Using pid_max = 4096
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] Reserved/initialized 5 futexes.
[main] Added 25 filenames from /dev
[main] Added 15902 filenames from /proc
[main] Added 6437 filenames from /sys
[main] Enabled 14/14 fd providers. initialized:14.
[main] Error opening tracing_on : No such file or directory
[main] 10335 iterations. [F:7623 S:2669 HI:2726]
[main] 20365 iterations. [F:15059 S:5219 HI:2726]
[main] 30741 iterations. [F:22673 S:7928 HI:2726]
[main] 40915 iterations. [F:30203 S:10529 HI:4141]
[main] 51272 iterations. [F:37816 S:13243 HI:4141]
[main] 61813 iterations. [F:45612 S:15946 HI:4141]
[main] 71831 iterations. [F:52993 S:18532 HI:4141]
[main] 81872 iterations. [F:60403 S:21124 HI:4141]
[main] 92085 iterations. [F:68006 S:23680 HI:4194]
[main] 102590 iterations. [F:75820 S:26316 HI:4194]
[main] 113472 iterations. [F:83884 S:29082 HI:4246 STALLED:1]
[main] 123753 iterations. [F:91500 S:31692 HI:4246]
[main] 135356 iterations. [F:99987 S:34761 HI:4246]
[main] 145605 iterations. [F:107612 S:37327 HI:4246]
[main] 156922 iterations. [F:116029 S:40186 HI:4246]
[main] 166926 iterations. [F:123400 S:42771 HI:4736]
[main] 177175 iterations. [F:131015 S:45361 HI:4736]
[main] 187848 iterations. [F:138864 S:48123 HI:4736]
[main] 198441 iterations. [F:146624 S:50914 HI:4736]
[main] 209335 iterations. [F:154635 S:53740 HI:4736]
[main] 219992 iterations. [F:162468 S:56521 HI:4736]
[main] 230487 iterations. [F:170268 S:59164 HI:4736]
[main] 241154 iterations. [F:178132 S:61909 HI:4736]
[main] 252335 iterations. [F:186344 S:64834 HI:4736]
[main] 262610 iterations. [F:193985 S:67413 HI:5791]
1970-01-01 18:12:46 hwclock --hctosys

--4fl2+zdcvTV6RaAH--
