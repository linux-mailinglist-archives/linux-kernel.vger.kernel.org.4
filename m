Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AADE6B8D89
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCNIh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjCNIhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:37:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E2B6A1C0;
        Tue, 14 Mar 2023 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678783042; x=1710319042;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aeWLDFokKhwHQK5GvTG87mSGUtx9KLI9wIG3KqfEAkQ=;
  b=ij5W3vf+KHrLKEuy9/saJVOvZJZGNvNSdWmyg+BgT2wZxDifinAzGRn7
   2wdD2VA1s96bGl1An68Iid27YfCExlrrJxd2thmAbIC0wWTSNS/zm27tV
   mh8mB264PVxEctVTX0Cvk383o7zDWXBcHCPHaQYz1F9WbJDxRiM8kzKCX
   rKq1JvEr38Uc5CvNPLFbbAruKdAJxinvwhqzQ431ZNRQGu5RXUU4Cp7Ai
   +YlcL+TSudmt11VdITEbprqRIJifcnKv0PMiF0qlwYyV3c+h1ZA36aPTF
   bPB9DoW9S5bfzwZEMQyn7984V6EXi9CYBqEVGe9+2WQ+Mi2g2kXsmo/or
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="325729274"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="xz'341?scan'341,208,341";a="325729274"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 01:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="747917146"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="xz'341?scan'341,208,341";a="747917146"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 14 Mar 2023 01:37:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 01:37:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 01:37:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 14 Mar 2023 01:37:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 14 Mar 2023 01:37:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q86YB9E/DANE08f0psLMLkwxbKS1Tnmyn5y6QB5+iCq8FetuxLCyQd3bAeXWk8MP2vjWpJxtn+QJvavJ1H4Gji1pmTDgYWc2Np9vrwMArGvpoDkU2IFkzRAifEeXHAo6d+/c+AOl5nhYcy8OFIgsdos3x9L7y50pTU/Y3/MZfukcbs5DPV0Gsth/NqIrJjKoY/mwuWqSyhP8+u0lUKqaSJtVcyyG6gN4L1kH3VU9Zoh3SFg5sqRdumi9woossO4rpF2PaqXbjovFB7JTek9wnuqTvXzkO339JnY8UhSZYihBKfRUpiJC1BSToNIR48mDQVkewt21dT6EFhdXoXM1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wesciCGDnLohJeT+pDgOHRxrGq6bU3KnJnr67WukaWQ=;
 b=SYM7z5F0dtRfaFwZFvd+//TsqgA/sTjI9rRsLtGiIYe6PjS4j9Em4pY6diFvJgE8p2JJoOYw+jh70dfrZmagpoa7UUo0V9vqUwo0BP2yIra8z0GbTW2Qz01gIN1luf+qxZUqgvuBl8bWsqs9XGvQbqa4a1nqy/5d/STQ74QsTa70ClNwxBPBoY2A8RejY2dRBhUR3U3T2t9e/x91stZGoXse1aXQ6tVU5s3SZ7PcCXtjlx4nRecUGKMDZgCwxEvqzXXaIWIb3Yj1VCg+dP/0orv/gVUe18Nne1uiemWDjDB3d5ZmO5R8qz/onk1/wjBiHchJiX5XmfdWnEMmFUYtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 08:37:12 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::66b:243c:7f3d:db9e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::66b:243c:7f3d:db9e%3]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 08:37:12 +0000
Date:   Tue, 14 Mar 2023 16:34:22 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Kees Cook <keescook@chromium.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <aliyunlinux2-dev@linux.alibaba.com>, <jane.lv@intel.com>
Subject: [linux-stable-rc:linux-4.19.y] [panic] 4d00e68cfc:
 WARNING:at_fs/sysfs/file.c:#sysfs_emit_at
Message-ID: <202303141634.1e64fd76-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="pM1j5p9RDJondMxj"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a45f2c-0fbe-4ea6-89dc-08db24674dfa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Si7PybSETLnd0rg2eXtNp108uix+Dw3ps5hUlA4KWzL3y9zjY8tUvAvfzFLNhTIW1WqxeWoM/v2MxwIYnREa0I40VEkm4sut7QTDxQUllqHgqFhbRq622yeclCjs8hSrcmZ3i0UgsQI9gbLRlZPscaZtdty00QBcvZ92NSdn9GSxeN6W7qGNOkfmgvxrk2vaCOINl9zPtV+RcTkswSi24NgH1v2v9tGGdOaHRTzTJC7cJIijgXDB/4hjnaMEpxMCaz5UG05+u9ut773HZUjIVPYatcxULWshbQ+v51GGH9PVVvPWhymTY9caod4405RME3wVat48Apm/7K2Fa2xajLCANMtHxwlqp4NLfzoFk7ILLnchAvQsN5dZxzV0uzwE96oD6KMzpZJUxzLH//r71f74rPjNfm5yleyv8MsPxQA60yaMn9IBSteuzVByc1Ap3Mm9ELPGKpTTDIDy091sBCw/v+WFPyMngc2C7IjUtb+pkJclAED2YWBZyDlEpn+wYz3giRs2sNxSCazPIlXgES/CNDaXAWgGcYCiSZcONSSZIDsaAnIIHe51nTSBO4C/pDaaw5cessOkOp47dalI8rndYgxQLCcyA2zFHrllb5Yxix3HnVpxfUnUd37KL0T8kcBPPRrckKMapYlFS48RnNq3s3svscpYQhUbrKKQPyHDVjGWE+KHOPXsKyEjSVDMkeO0D2bw0tuubWHFaEozR7LdUnk2DQtSTlkRwk6EOvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199018)(6916009)(2616005)(235185007)(4326008)(5660300002)(8936002)(186003)(7416002)(41300700001)(6512007)(6506007)(26005)(1076003)(36756003)(86362001)(2906002)(83380400001)(44144004)(66556008)(6486002)(107886003)(8676002)(66476007)(966005)(6666004)(54906003)(316002)(66946007)(45080400002)(478600001)(82960400001)(38100700002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O97a64mmSIyfCAIYLbmMUgMqFiCzXOsaEZmFliGExduNSbu+OPGjyVZQTlk4?=
 =?us-ascii?Q?xLWuYV9nM5YrsKIpULk2rwER7kgkNxhNVXvvd0gZ3XUMe8YulctCcytUr0OR?=
 =?us-ascii?Q?Q/uaqzrSFM2sswrbNODXp8RBQggpyeyf1Gv9071a+7opOYHogZTAZsO8YrPG?=
 =?us-ascii?Q?1z4SY3QtA5GbutrsUVFdGCDhMAXRbMJ3O00Dz2wEmvWlEkhXrORK+Ql/zEsV?=
 =?us-ascii?Q?XVWWAn7xxto5eOn36U6bl/22CPp9FhNutPZKr1Lywz0BPUB413HMT0dBH500?=
 =?us-ascii?Q?9T9iXFd19yCfiuBpzHGUnRqwUYHwBzj4FxeYid/5vM4Lx85f5qBEwrgSdm0J?=
 =?us-ascii?Q?VZJCxPCx9vpM0PBjoga3yJYE8iaTplw8zr/SQYFC1KxzlobXWY3h/oz/FU1z?=
 =?us-ascii?Q?ybdDOHYylvUniRMBOrw+kFxqqWEdPCTMyS+ytZTsC+9KAVYO69tEDaUOxyKI?=
 =?us-ascii?Q?RbyZ2RZLv/SGSHl2F0emCtAlFW8pTT6isgwTWsI3NXqHoQnWYGFPnpM3elDn?=
 =?us-ascii?Q?pIhoAmGeanM3xrBnihy7uB0kekUpdGYzVhfiQMzRPE4r/YyabfUIUmcaTA15?=
 =?us-ascii?Q?6VfeveeFWsBlEVObonep63aAo3iXUnnvU9FQuSkQWYxL0fRniGzInxhmZgU0?=
 =?us-ascii?Q?9kdPwTWj12HWm1EusztKEq5VyL9DIpCPRh/7zjo/wfqyJNROiB5Dklei+Err?=
 =?us-ascii?Q?atTEyxrDSRscsfOADhqP/JNFzRpzmT0hcMdkwvynt2Mh/Z4IZ/EbLlNYzeDO?=
 =?us-ascii?Q?A/Qh0wslp6ivtKHyYZMpa4cQxkCztJeSudYoXpad7KVbPbTwytI6Ws6AT5a4?=
 =?us-ascii?Q?xfR5/80KCnP38xZopKe8lti0PWeKdT2S5E0GVd5wEvHi654jRLPubJPGyU4E?=
 =?us-ascii?Q?JzLeTdbRQ+XgKa4FkCycfKtNBAFlqBQ4x+kRJKOYLrr693aBz/ZzVvwibrUU?=
 =?us-ascii?Q?D4ApNk0Bc2HyyndONo4UnqtV/E/h2Ts9T4NqxbBdJm2VkSTHYdG/oWWkZEnB?=
 =?us-ascii?Q?B+MEx8uW7j1MPQDweXDu3rVB8KuIqY0BQdX/GF3UDQdyQy801TFR4EmgDX/t?=
 =?us-ascii?Q?O1oz/78z+MrgH9O5JNeEC2BS/Yfq5gThymgQDw8SGVwV03DbMk3OYBN0EDUz?=
 =?us-ascii?Q?pmuS1SejzYkzVldw4/AGhGgKvis0nHaep1igudh4iRR+48GTyZs1dJOx68F/?=
 =?us-ascii?Q?se52tKtbictoww34xA7qbaMuJ9UGrROekqMgveg5pjXBsdMqSQIv8gFMEMJM?=
 =?us-ascii?Q?j1RZ8nazL7J4soQvxH3iXfSWkEU7m8ZLYgCyT9z2kmjf7cponu1V4NWmkN/U?=
 =?us-ascii?Q?8qRQtJWoTD2NyTCNv6A6LvmOvZvGUnDaeKV8335iZyfJpxRqVM3R/eeifnMf?=
 =?us-ascii?Q?TuGh7zF5t3nwoBshD5FoGiPHSCZU+p5C8oJJ2ubXzx4qKS+OnEUPuYns6TiI?=
 =?us-ascii?Q?WTs60T786R5A3qqqGSw3IK7AGfwlyXup/R61vqBEgTHOlOGhLZ0MmgScZxHd?=
 =?us-ascii?Q?29nkVxP+kZMO4Z9v67F+NSFeQ3ddf8nOXJeH16XgP4v0lDnXIxHSyGFRMGC/?=
 =?us-ascii?Q?5JuT2PCE7PMJIRcs4NZ2OsinnpB/I6Zd5uPC2Km6eJthENaNcyY78QAngA0R?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a45f2c-0fbe-4ea6-89dc-08db24674dfa
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 08:37:12.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lNYo9dsNr3K+RBRUAI1g4UzP0KpyUQLgCswlFUlblcBwy+MnA5r2xargBppWN/RxV3K/g0JGzwsUfItiWlNRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pM1j5p9RDJondMxj
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greeting,

FYI, we noticed WARNING:at_fs/sysfs/file.c:#sysfs_emit_at due to commit (built with gcc-11):

commit: 4d00e68cfcfd91d3a8c794d47617429a96d623ed ("panic: Expose "warn_count" to sysfs")
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y

in testcase: trinity
version: trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06
with following parameters:

	runtime: 300s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202303141634.1e64fd76-yujie.liu@intel.com


[   91.396522] ------------[ cut here ]------------
[   91.397797] invalid sysfs_emit_at: buf:000000004ba465f7 at:0
[   91.399038] WARNING: CPU: 0 PID: 1032 at fs/sysfs/file.c:602 sysfs_emit_at (fs/sysfs/file.c:602 (discriminator 9)) 
[   91.400702] Modules linked in: crc32c_intel aesni_intel aes_x86_64 pcspkr
[   91.402049] CPU: 0 PID: 1032 Comm: trinity-c0 Not tainted 4.19.271-00075-g4d00e68cfcfd #1
[   91.409221] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[   91.411167] RIP: 0010:sysfs_emit_at (fs/sysfs/file.c:602 (discriminator 9)) 
[ 91.412300] Code: 31 c9 31 d2 44 89 fe 48 c7 c7 c8 21 3c 84 e8 2b cb d1 ff 45 85 ff 74 14 44 89 e2 48 89 de 48 c7 c7 a0 6a d8 82 e8 31 c5 14 01 <0f> 0b 31 c9 31 d2 44 89 fe 48 c7 c7 98 21 3c 84 e8 ff ca d1 ff 45
All code
========
   0:	31 c9                	xor    %ecx,%ecx
   2:	31 d2                	xor    %edx,%edx
   4:	44 89 fe             	mov    %r15d,%esi
   7:	48 c7 c7 c8 21 3c 84 	mov    $0xffffffff843c21c8,%rdi
   e:	e8 2b cb d1 ff       	callq  0xffffffffffd1cb3e
  13:	45 85 ff             	test   %r15d,%r15d
  16:	74 14                	je     0x2c
  18:	44 89 e2             	mov    %r12d,%edx
  1b:	48 89 de             	mov    %rbx,%rsi
  1e:	48 c7 c7 a0 6a d8 82 	mov    $0xffffffff82d86aa0,%rdi
  25:	e8 31 c5 14 01       	callq  0x114c55b
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	31 c9                	xor    %ecx,%ecx
  2e:	31 d2                	xor    %edx,%edx
  30:	44 89 fe             	mov    %r15d,%esi
  33:	48 c7 c7 98 21 3c 84 	mov    $0xffffffff843c2198,%rdi
  3a:	e8 ff ca d1 ff       	callq  0xffffffffffd1cb3e
  3f:	45                   	rex.RB

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	31 c9                	xor    %ecx,%ecx
   4:	31 d2                	xor    %edx,%edx
   6:	44 89 fe             	mov    %r15d,%esi
   9:	48 c7 c7 98 21 3c 84 	mov    $0xffffffff843c2198,%rdi
  10:	e8 ff ca d1 ff       	callq  0xffffffffffd1cb14
  15:	45                   	rex.RB
[   91.415947] RSP: 0018:ffff88839cc1fa00 EFLAGS: 00010282
[   91.416980] RAX: 0000000000000000 RBX: ffff88838b769168 RCX: 0000000000000000
[   91.418321] RDX: 1ffff11071af5000 RSI: ffff88838d7a8888 RDI: ffffed1073983f36
[   91.419751] RBP: ffff88839cc1fab8 R08: 0000000000000004 R09: 0000000000000000
[   91.421196] R10: ffffffff81270059 R11: ffffffff84354eeb R12: 0000000000000000
[   91.422617] R13: 1ffff11073983f40 R14: ffffffff82ca7140 R15: 0000000000000001
[   91.424162] FS:  000000000109a880(0000) GS:ffffffff836bf000(0000) knlGS:0000000000000000
[   91.425867] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.427062] CR2: 00007f4f623b2000 CR3: 00000003a8cba000 CR4: 00000000000406b0
[   91.428458] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   91.429858] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   91.431301] Call Trace:
[   91.431996] ? sysfs_emit (fs/sysfs/file.c:598) 
[   91.432848] ? lock_acquire (kernel/locking/lockdep.c:3910) 
[   91.433740] ? kernfs_seq_start (fs/kernfs/file.c:113) 
[   91.434689] ? __lock_is_held (kernel/locking/lockdep.c:3728) 
[   91.435558] ? klist_remove (lib/kobject.c:793) 
[   91.436437] pm_show_wakelocks (kernel/power/wakelock.c:53) 
[   91.437326] sysfs_kf_seq_show (fs/sysfs/file.c:63) 
[   91.438281] traverse (fs/seq_file.c:116) 
[   91.439109] seq_read (fs/seq_file.c:191 (discriminator 1)) 
[   91.439949] do_loop_readv_writev (fs/read_write.c:704) 
[   91.440833] do_iter_read (fs/read_write.c:925) 
[   91.441616] vfs_readv (fs/read_write.c:988) 
[   91.442324] ? rw_copy_check_uvector (fs/read_write.c:979) 
[   91.443293] ? rcu_read_lock_sched_held (kernel/rcu/update.c:119) 
[   91.444338] do_preadv (fs/read_write.c:1071) 
[   91.445142] ? __x64_sys_readv (fs/read_write.c:1060) 
[   91.446045] ? do_syscall_64 (arch/x86/include/asm/paravirt.h:799 arch/x86/entry/common.c:280) 
[   91.446944] do_syscall_64 (arch/x86/entry/common.c:293) 
[   91.447774] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:244) 
[   91.448894] RIP: 0033:0x463519
[ 91.449627] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 59 00 00 c3 66 2e 0f 1f 84 00 00 00 00
All code
========
   0:	00 f3                	add    %dh,%bl
   2:	c3                   	retq   
   3:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   a:	00 00 00 
   d:	0f 1f 40 00          	nopl   0x0(%rax)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	0f 83 db 59 00 00    	jae    0x5a11
  36:	c3                   	retq   
  37:	66                   	data16
  38:	2e                   	cs
  39:	0f                   	.byte 0xf
  3a:	1f                   	(bad)  
  3b:	84 00                	test   %al,(%rax)
  3d:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	0f 83 db 59 00 00    	jae    0x59e7
   c:	c3                   	retq   
   d:	66                   	data16
   e:	2e                   	cs
   f:	0f                   	.byte 0xf
  10:	1f                   	(bad)  
  11:	84 00                	test   %al,(%rax)
  13:	00 00                	add    %al,(%rax)
	...
[   91.455329] RSP: 002b:00007ffffd5b9df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
[   91.456888] RAX: ffffffffffffffda RBX: 0000000000000127 RCX: 0000000000463519
[   91.458335] RDX: 0000000000000001 RSI: 0000000001231800 RDI: 0000000000000078
[   91.459796] RBP: 00007f4f623c8000 R08: 0000000000002000 R09: 00000000000000e9
[   91.461235] R10: 0000000000100000 R11: 0000000000000246 R12: 0000000000000002
[   91.462644] R13: 00007f4f623c8058 R14: 000000000109a850 R15: 00007f4f623c8000
[   91.464065] irq event stamp: 274688
[   91.464867] hardirqs last enabled at (274687): console_unlock (arch/x86/include/asm/paravirt.h:789 (discriminator 2) kernel/printk/printk.c:2498 (discriminator 2)) 
[   91.466659] hardirqs last disabled at (274688): trace_hardirqs_off_thunk (arch/x86/entry/thunk_64.S:43) 
[   91.468608] softirqs last enabled at (274684): __do_softirq (arch/x86/include/asm/preempt.h:23 kernel/softirq.c:319) 
[   91.470384] softirqs last disabled at (274677): irq_exit (kernel/softirq.c:372 kernel/softirq.c:412) 
[   91.472049] ---[ end trace b63cb36c8c6dcdaa ]---


To reproduce:

        # build kernel
	cd linux
	cp config-4.19.271-00075-g4d00e68cfcfd .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

--pM1j5p9RDJondMxj
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-4.19.271-00075-g4d00e68cfcfd"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.19.271 Kernel Configuration
#

#
# Compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
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
CONFIG_BROKEN_ON_SMP=y
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
# CONFIG_KERNEL_BZIP2 is not set
CONFIG_KERNEL_LZMA=y
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
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
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_TASKSTATS=y
# CONFIG_TASK_DELAY_ACCT is not set
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
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
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
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
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
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
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_INTEL_RDT is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_NO_BOOTMEM=y
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
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=m
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_VERIFY_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
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
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

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
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
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
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
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
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32 is not set
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

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
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
CONFIG_OPTPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
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
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
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
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC=""
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_CGROUP_IOLATENCY=y
# CONFIG_BLK_WBT_SQ is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CFQ_GROUP_IOSCHED is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
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
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=y
# CONFIG_TLS_DEVICE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=m
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=y
# CONFIG_NET_KEY is not set
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
CONFIG_SYN_COOKIES=y
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=y
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
# CONFIG_TCP_CONG_BIC is not set
CONFIG_TCP_CONG_CUBIC=y
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_TCP_CONG_HSTCP is not set
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=y
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=y
CONFIG_TCP_CONG_LP=y
# CONFIG_TCP_CONG_VENO is not set
# CONFIG_TCP_CONG_YEAH is not set
CONFIG_TCP_CONG_ILLINOIS=y
# CONFIG_TCP_CONG_DCTCP is not set
CONFIG_TCP_CONG_CDG=y
CONFIG_TCP_CONG_BBR=m
# CONFIG_DEFAULT_CUBIC is not set
CONFIG_DEFAULT_VEGAS=y
# CONFIG_DEFAULT_CDG is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="vegas"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=m
CONFIG_IPV6_ROUTER_PREF=y
# CONFIG_IPV6_ROUTE_INFO is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
# CONFIG_INET6_ESP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_IPV6_ILA=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
CONFIG_IPV6_SEG6_HMAC=y
# CONFIG_NETLABEL is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_INGRESS is not set
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=y
CONFIG_NETFILTER_NETLINK_QUEUE=y
# CONFIG_NETFILTER_NETLINK_LOG is not set
CONFIG_NETFILTER_NETLINK_OSF=y
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=y
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
# CONFIG_NF_CONNTRACK_SECMARK is not set
# CONFIG_NF_CONNTRACK_ZONES is not set
CONFIG_NF_CONNTRACK_PROCFS=y
# CONFIG_NF_CONNTRACK_EVENTS is not set
CONFIG_NF_CONNTRACK_TIMEOUT=y
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
# CONFIG_NF_CT_PROTO_SCTP is not set
# CONFIG_NF_CT_PROTO_UDPLITE is not set
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
# CONFIG_NF_CT_NETLINK is not set
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_PROTO_DCCP=y
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NETFILTER_SYNPROXY=m
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=y

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
CONFIG_NETFILTER_XT_TARGET_CT=m
# CONFIG_NETFILTER_XT_TARGET_DSCP is not set
# CONFIG_NETFILTER_XT_TARGET_HL is not set
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=y
CONFIG_NETFILTER_XT_TARGET_MARK=y
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
# CONFIG_NETFILTER_XT_TARGET_TPROXY is not set
# CONFIG_NETFILTER_XT_TARGET_TRACE is not set
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
# CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
# CONFIG_NETFILTER_XT_MATCH_BPF is not set
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=y
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=y
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
CONFIG_NETFILTER_XT_MATCH_ECN=y
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
CONFIG_NETFILTER_XT_MATCH_HL=y
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
# CONFIG_NETFILTER_XT_MATCH_IPVS is not set
CONFIG_NETFILTER_XT_MATCH_L2TP=y
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
CONFIG_NETFILTER_XT_MATCH_MAC=y
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=y
CONFIG_NETFILTER_XT_MATCH_OWNER=m
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
CONFIG_NETFILTER_XT_MATCH_RECENT=m
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
CONFIG_NETFILTER_XT_MATCH_TCPMSS=y
CONFIG_NETFILTER_XT_MATCH_TIME=y
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
# CONFIG_IP_SET_BITMAP_IP is not set
# CONFIG_IP_SET_BITMAP_IPMAC is not set
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=y
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=y
# CONFIG_IP_SET_HASH_IPPORTIP is not set
# CONFIG_IP_SET_HASH_IPPORTNET is not set
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=y
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=y
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=y
# CONFIG_IP_SET_LIST_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
CONFIG_IP_VS_DEBUG=y
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
# CONFIG_IP_VS_PROTO_TCP is not set
# CONFIG_IP_VS_PROTO_UDP is not set
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
# CONFIG_IP_VS_PROTO_SCTP is not set

#
# IPVS scheduler
#
# CONFIG_IP_VS_RR is not set
# CONFIG_IP_VS_WRR is not set
# CONFIG_IP_VS_LC is not set
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
# CONFIG_IP_VS_DH is not set
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_MH=m
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
# CONFIG_IP_VS_NFCT is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=y
# CONFIG_NF_TPROXY_IPV4 is not set
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=y
CONFIG_NF_LOG_IPV4=y
CONFIG_NF_REJECT_IPV4=y
# CONFIG_NF_NAT_IPV4 is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
# CONFIG_IP_NF_MATCH_RPFILTER is not set
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
# CONFIG_IP_NF_NAT is not set
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_TTL is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_SECURITY is not set
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
# CONFIG_NF_TPROXY_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
# CONFIG_NF_REJECT_IPV6 is not set
CONFIG_NF_LOG_IPV6=m
CONFIG_NF_NAT_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
# CONFIG_IP6_NF_MATCH_EUI64 is not set
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_SRH=m
# CONFIG_IP6_NF_FILTER is not set
CONFIG_IP6_NF_TARGET_SYNPROXY=m
# CONFIG_IP6_NF_MANGLE is not set
CONFIG_IP6_NF_RAW=m
# CONFIG_IP6_NF_SECURITY is not set
CONFIG_IP6_NF_NAT=m
# CONFIG_IP6_NF_TARGET_MASQUERADE is not set
CONFIG_IP6_NF_TARGET_NPT=m
CONFIG_NF_DEFRAG_IPV6=m
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=m
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE=y
# CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=y
CONFIG_ATM_CLIP=m
CONFIG_ATM_CLIP_NO_ICMP=y
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=y
# CONFIG_ATM_BR2684_IPFILTER is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=m
CONFIG_IPDDP=m
# CONFIG_IPDDP_ENCAP is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
CONFIG_PHONET=m
CONFIG_6LOWPAN=m
CONFIG_6LOWPAN_DEBUGFS=y
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
# CONFIG_IEEE802154_SOCKET is not set
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
# CONFIG_DNS_RESOLVER is not set
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
# CONFIG_BATMAN_ADV_BLA is not set
# CONFIG_BATMAN_ADV_DAT is not set
# CONFIG_BATMAN_ADV_NC is not set
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUGFS is not set
CONFIG_OPENVSWITCH=m
# CONFIG_OPENVSWITCH_GRE is not set
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
CONFIG_HSR=m
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
CONFIG_NET_DROP_MONITOR=y
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=y
CONFIG_ROSE=y

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
CONFIG_6PACK=m
CONFIG_BPQETHER=y
CONFIG_BAYCOM_SER_FDX=y
CONFIG_BAYCOM_SER_HDX=m
CONFIG_YAM=m
CONFIG_CAN=m
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=m
# CONFIG_CAN_GW is not set

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIBTSDIO=m
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIDTL1 is not set
# CONFIG_BT_HCIBT3C is not set
CONFIG_BT_HCIBLUECARD=m
# CONFIG_BT_HCIVHCI is not set
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_WILINK is not set
# CONFIG_AF_RXRPC is not set
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=y
CONFIG_NL80211_TESTMODE=y
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
# CONFIG_CFG80211_DEFAULT_PS is not set
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=m
CONFIG_CAIF_DEBUG=y
CONFIG_CAIF_NETDEV=m
CONFIG_CAIF_USB=m
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_UART=m
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_FDP=m
CONFIG_NFC_FDP_I2C=m
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_I2C=m
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MICROREAD_I2C is not set
# CONFIG_NFC_MRVL_UART is not set
CONFIG_NFC_ST21NFCA=m
CONFIG_NFC_ST21NFCA_I2C=m
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# CONFIG_PSAMPLE is not set
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
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
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_GNSS=m
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=m

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=y
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
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

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
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_MQ_DEFAULT=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=m
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=m
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
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
# CONFIG_ATA_PIIX is not set
CONFIG_SATA_DWC=m
# CONFIG_SATA_DWC_OLD_DMA is not set
# CONFIG_SATA_DWC_DEBUG is not set
CONFIG_SATA_MV=y
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
CONFIG_PATA_PCMCIA=m
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_MQ_DEFAULT is not set
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=m
CONFIG_DM_CRYPT=m
# CONFIG_DM_SNAPSHOT is not set
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
# CONFIG_DM_CACHE_SMQ is not set
CONFIG_DM_WRITECACHE=m
CONFIG_DM_ERA=m
CONFIG_DM_MIRROR=m
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
# CONFIG_DM_MULTIPATH_ST is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
CONFIG_DM_VERITY_FEC=y
CONFIG_DM_SWITCH=m
# CONFIG_DM_LOG_WRITES is not set
# CONFIG_DM_INTEGRITY is not set
CONFIG_DM_ZONED=m
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
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
# CAIF transport drivers
#
# CONFIG_CAIF_TTY is not set
# CONFIG_CAIF_SPI_SLAVE is not set
# CONFIG_CAIF_HSI is not set
# CONFIG_CAIF_VIRTIO is not set

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
# CONFIG_AQTION is not set
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
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
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
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
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
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
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
# CONFIG_ATH6KL is not set
# CONFIG_WIL6210 is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
# CONFIG_AIRO_CS is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_MWIFIEX is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PEARL_PCIE is not set
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_PCMCIA_WL3501 is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_HWSIM is not set
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
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
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
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_232=y
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=m
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=m
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=m
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_88PM860X is not set
CONFIG_TOUCHSCREEN_AD7879=m
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
CONFIG_TOUCHSCREEN_ADC=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
CONFIG_TOUCHSCREEN_BU21013=y
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
CONFIG_TOUCHSCREEN_DA9052=m
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_ILI210X=y
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=y
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_INEXIO=y
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
CONFIG_TOUCHSCREEN_PIXCIR=m
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
# CONFIG_TOUCHSCREEN_ST1232 is not set
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_E3X0_BUTTON=m
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_MAX8925_ONKEY=m
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=m
CONFIG_INPUT_GPIO_DECODER=y
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PCF50633_PMU=m
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA9052_ONKEY=y
CONFIG_INPUT_DA9055_ONKEY=y
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
CONFIG_INPUT_CMA3000=m
# CONFIG_INPUT_CMA3000_I2C is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
CONFIG_INPUT_DRV260X_HAPTICS=m
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SMB is not set
# CONFIG_RMI4_F03 is not set
# CONFIG_RMI4_F11 is not set
# CONFIG_RMI4_F12 is not set
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

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
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
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
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_ALTERA_JTAGUART=m
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_NVRAM is not set
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
CONFIG_MWAVE=y
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
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
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_MUX_MLXCPLD is not set
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
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_DA9052=m
# CONFIG_GPIO_DA9055 is not set
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_MADERA=m
CONFIG_GPIO_TPS65086=m
# CONFIG_GPIO_TPS65910 is not set
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_WM8350 is not set
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=m
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_MAX8925_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_CHARGER_DA9150 is not set
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_MAX77693 is not set
# CONFIG_CHARGER_MAX8998 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=m
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=m
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX6621=m
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=m
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_IBM_CFFPS=m
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=m
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS1015 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=m
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_WM8350=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
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
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=m
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_CS47L35=y
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=m
# CONFIG_REGULATOR_88PM8607 is not set
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=m
CONFIG_REGULATOR_AS3711=m
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9055=m
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=m
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=m
# CONFIG_REGULATOR_MAX8925 is not set
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8998=m
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6397=m
# CONFIG_REGULATOR_PCF50633 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65090=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65910=m
# CONFIG_REGULATOR_TPS65912 is not set
# CONFIG_REGULATOR_WM8350 is not set
# CONFIG_REGULATOR_WM8400 is not set
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_DVB_CORE=y
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_RADIO_ADAPTERS is not set

#
# Supported FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

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

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_CEC=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=m
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
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

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
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
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
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
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
CONFIG_FB_SM501=m
CONFIG_FB_IBM_GXT4500=m
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
CONFIG_MMC=m
# CONFIG_MMC_BLOCK is not set
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MMC_SDHCI_XENON=m
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=m
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3533=m
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=m
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM8350=m
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_REGULATOR=m
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_MENF21BMC is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y
CONFIG_INFINIBAND=m
# CONFIG_INFINIBAND_USER_MAD is not set
# CONFIG_INFINIBAND_USER_ACCESS is not set
# CONFIG_INFINIBAND_ADDR_TRANS is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_NES is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_IPOIB is not set
CONFIG_INFINIBAND_OPA_VNIC=m
# CONFIG_INFINIBAND_RDMAVT is not set
# CONFIG_RDMA_RXE is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
CONFIG_RTC_NVMEM=y

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
CONFIG_RTC_DRV_88PM860X=m
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABX80X=m
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8925 is not set
# CONFIG_RTC_DRV_MAX8998 is not set
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=m
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_TPS65910=y
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=m
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV8803=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9052 is not set
CONFIG_RTC_DRV_DA9055=y
# CONFIG_RTC_DRV_DA9063 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_WM8350 is not set
# CONFIG_RTC_DRV_PCF50633 is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=m
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_MT6397=m

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=y
# CONFIG_INTEL_IOATDMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y

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
CONFIG_AUXDISPLAY=y
CONFIG_HD44780=m
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_CHARLCD=m
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_FUJITSU_TABLET is not set
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=m
# CONFIG_MLX_PLATFORM is not set
# CONFIG_TOUCHSCREEN_DMI is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_MLXREG_IO=m
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_VIRTIO=y
# CONFIG_SOUNDWIRE is not set

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
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX77843=y
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_BMA180 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
# CONFIG_DA280 is not set
CONFIG_DA311=m
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_KXSD9=m
CONFIG_KXSD9_I2C=m
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD7291=m
CONFIG_AD799X=y
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=m
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=m
CONFIG_LTC2497=m
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=y
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
CONFIG_TI_ADC081C=m
CONFIG_TI_ADS1015=y
CONFIG_TI_AM335X_ADC=m

#
# Analog Front Ends
#

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_CCS811=y
CONFIG_IAQCORE=m
# CONFIG_VZ89X is not set

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=m
# CONFIG_AD5446 is not set
# CONFIG_AD5593R is not set
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
# CONFIG_DS4424 is not set
CONFIG_M62332=m
CONFIG_MAX517=m
CONFIG_MCP4725=y
CONFIG_TI_DAC5571=m

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_ITG3200=y

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
CONFIG_AM2315=m
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTU21=m
CONFIG_SI7005=y
CONFIG_SI7020=y

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_IIO_ST_LSM6DSX is not set

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=m
# CONFIG_BH1750 is not set
CONFIG_BH1780=m
CONFIG_CM32181=m
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
CONFIG_CM36651=y
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=m
CONFIG_JSA1212=m
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
CONFIG_LV0104CS=m
# CONFIG_MAX44000 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
CONFIG_SI1133=m
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=y
CONFIG_TSL2772=y
CONFIG_TSL4531=m
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=m

#
# Magnetometer sensors
#
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_MAG3110=m
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m

#
# Multiplexers
#

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=m
# CONFIG_IIO_SYSFS_TRIGGER is not set

#
# Digital potentiometers
#
CONFIG_AD5272=m
# CONFIG_DS1803 is not set
CONFIG_MCP4018=m
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=y

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
CONFIG_ABP060MG=y
# CONFIG_BMP280 is not set
CONFIG_HP03=y
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL3115 is not set
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_T5403=m
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=y
CONFIG_RFD77402=m
CONFIG_SRF04=y
# CONFIG_SX9500 is not set
CONFIG_SRF08=m

#
# Resolver to digital converters
#

#
# Temperature sensors
#
CONFIG_MLX90614=y
CONFIG_MLX90632=m
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=m
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_POWERCAP=y
CONFIG_IDLE_INJECT=y
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
# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=m
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_STM_SOURCE_FTRACE is not set
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
CONFIG_FPGA_DFL=m
# CONFIG_FPGA_DFL_FME is not set
# CONFIG_FPGA_DFL_AFU is not set
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_ENCRYPTION is not set
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=m
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=m
CONFIG_PSTORE_LZ4HC_COMPRESS=m
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lz4"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=m
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_NETWORK is not set
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
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
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=m
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=m
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=m
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=y
# CONFIG_CRYPTO_SHA1_MB is not set
# CONFIG_CRYPTO_SHA256_MB is not set
# CONFIG_CRYPTO_SHA512_MB is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_X86_64=m
CONFIG_CRYPTO_AES_NI_INTEL=m
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=m
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m

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
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=m
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=m
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=m
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
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
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
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
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_GDB_SCRIPTS=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
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
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_DEBUG_ON=y
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_KASAN=y
# CONFIG_KASAN_EXTRA is not set
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
# CONFIG_TEST_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
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
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
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
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_MAKE_REQUEST is not set
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
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
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
CONFIG_IRQSOFF_TRACER=y
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
CONFIG_STACK_TRACER=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_KPROBE_EVENTS is not set
# CONFIG_UPROBE_EVENTS is not set
# CONFIG_DYNAMIC_FTRACE is not set
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
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
# CONFIG_TEST_KMOD is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_TEST_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
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
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set

--pM1j5p9RDJondMxj
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
	export queue_cmdline_keys=
	export queue='vip'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-stable-rc/queue/4.19'
	export commit='4d00e68cfcfd91d3a8c794d47617429a96d623ed'
	export kconfig='x86_64-randconfig-r006-20230306'
	export nr_vm=300
	export submit_id='6410215b0b9a9306d1aabb74'
	export job_file='/lkp/jobs/scheduled/vm-meta-99/trinity-300s-yocto-x86_64-minimal-20190520.cgz-4d00e68cfcfd91d3a8c794d47617429a96d623ed-20230314-67281-b0l3ov-11.yaml'
	export id='9939896b2afda994350a00eb77be5e114297cfbf'
	export queuer_version='/lkp/yujie/.src-20230314-091610'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='yocto-x86_64-minimal-20190520.cgz'
	export compiler='gcc-11'
	export enqueue_time='2023-03-14 15:25:15 +0800'
	export _id='6410215d0b9a9306d1aabb7f'
	export _rt='/result/trinity/300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-r006-20230306/gcc-11/4d00e68cfcfd91d3a8c794d47617429a96d623ed'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/trinity/300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-r006-20230306/gcc-11/4d00e68cfcfd91d3a8c794d47617429a96d623ed/21'
	export scheduler_version='/lkp/lkp/.src-20230313-164509'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/yocto/yocto-x86_64-minimal-20190520.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-r006-20230306/gcc-11/4d00e68cfcfd91d3a8c794d47617429a96d623ed/21
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-r006-20230306/gcc-11/4d00e68cfcfd91d3a8c794d47617429a96d623ed/vmlinuz-4.19.271-00075-g4d00e68cfcfd
branch=linux-stable-rc/queue/4.19
job=/lkp/jobs/scheduled/vm-meta-99/trinity-300s-yocto-x86_64-minimal-20190520.cgz-4d00e68cfcfd91d3a8c794d47617429a96d623ed-20230314-67281-b0l3ov-11.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-r006-20230306
commit=4d00e68cfcfd91d3a8c794d47617429a96d623ed
initcall_debug
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
	export modules_initrd='/pkg/linux/x86_64-randconfig-r006-20230306/gcc-11/4d00e68cfcfd91d3a8c794d47617429a96d623ed/modules.cgz'
	export bm_initrd='/osimage/pkg/debian-x86_64-20180403.cgz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export meta_host='vm-meta-99'
	export kernel='/pkg/linux/x86_64-randconfig-r006-20230306/gcc-11/4d00e68cfcfd91d3a8c794d47617429a96d623ed/vmlinuz-4.19.271-00075-g4d00e68cfcfd'
	export dequeue_time='2023-03-14 15:26:17 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-99/trinity-300s-yocto-x86_64-minimal-20190520.cgz-4d00e68cfcfd91d3a8c794d47617429a96d623ed-20230314-67281-b0l3ov-11.cgz'

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

--pM1j5p9RDJondMxj
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4iJna0tdADKYSqt8kKSEWvAZo7Ydv/tz/AJuxJZ5vBF3
0cBaGDaudJVpU5nIU3ICatAOyRoDgsgw6LNN2YAnmjHievXhwF9sCdZxmFgXwcJQteaeO/p03hnd
GAxBxVWHQspp84GjF2oLlI/2LA2XyqY9UZLoweAjaicKXcgxJOljcdiza6Xt7g28/tdSesikk/I/
gWUCtNsaZjW8bXtGB0n6SZSKdCxIYHxpp00pmf3INJVHlWOCM5OMCfFwMbWIToMIazz+z6gzj/cS
mnuWFouyX1x7qUEooSmvttULPxUkxryzihYQ14+FEW2Zc9EdyeqLQi+CIeQ4bTAs+3c6WnG3mByx
Q1SIG6zr2X1xtA77kQsgSwaWSFQpu3LI/qxXPmuUwcZDM4mHirXmVVctFrjHnEYItO7HZezhdhPM
g8zzG4Wxz03nyYvqt9oq20koqfjVviMpKGX6fzVZ+87pHoz6VSySwyiZXINytkXp26Zj6zoF0MWi
hwoe9V1CkxR1SUO9dxFxF5kzCLqZ12dBRLfoafsLrMG8nKGFSKGQ5MypfvUs/MBahezbNbkGZfA7
0imF/dn7NwpoZtHIUToL6LEpP0hJRHOgvMA3P1IY96nCHzO+7v7MlJGiq9uy86xNlx0vMg/fq3ZH
3/R6H5NYy9kDyXRwl35vuQ8my27wLgCCngCX2JK9fF9ejFgz5OEStfbdESo+j7gm3kWOYjtymAS1
BkB/AgYYMStKaarCYdmIF3UyVkBqLKUsaJsJ3vmtUeX2tkd4/oeTOwuvLyOqF086MbLD5mOfPKLc
phK9lYZcXSZxKpVQ3a518NHQekb6mtCjxhDLUOLKAJO0BXgs3AIBSmc3dgoQUc2zzb6KCz59nAHV
Z5cmSCnYx6VaWyaSwlMUZpjtAaQtS8gNtkRs9vxHsV0NAEyTPgZKffrfEdsIpwmauscwV/KJV7/G
haLi3ywuhOM/xMV9JdBCtGXiAellS1Uwk44j3NdfHfKW3GcfH9HzIj0iR1H8JfJmeu2BbsCYLe2x
eNjLsXvI/bsBUNa/KMj59ZICgijxx4vQ58VANCUD6eOZgoMBlHdixPGcDQu5i5IyWPQmkGHT1i4i
kcLAgh5qvdAb8v9Tfc0u+zn2OKTPTbaUN30/QPh8vxvUY5gHz3JXujl3RFBHoktCm+Y5Wg75Lnbs
vZDKh9FppIb9dh0VMqvfKPppThF2G6dHGBFWDR9toH5xe+A4CDRoPhhO/iEd01UyNicXsr+hPZ26
47l5MfSymZJk+x3tZ+jZXC8I9ksSKGikzjcisP9aKvfMOon7C7PMlgZegZG/10yZTLmhMR+CeqlO
UgSVZPxSl8+6CbMyf9DLNJep4E5Cq0Zaw/airg0EyDZCpofp5DmrX8n8fLVJoEvr9rMhhfp64AUj
zT+4K6njHbNFmTeEwYABVwBDJ0xZbM0473sBO4mCE3YiY7Iom4xmszKJhws0IFT65mKA7bx8LwA9
q7l+6lQFtZDcQ9Ugrk1Vc8zQis35cmPzTDYmXl9pza/Km+LzV8vWw4ItRHNkRZbcMuC3uibcECsP
A7cA74mCA9aWBqQrweQJGAe7n72mQgAbTNwO0myRocU9LaEDbTizdnSCsI92/d3kA1VSCkkikVZm
6SVh6IlpUZD7CaMvUpT1ztbkJ7ocegBfzpQt55nMMO3REEI6kd8FLkIV8wf+gptE+u8J6G9xmxL9
elxo1E+9+EQiZ2sAMQhDoOJ4ieVQ/PEhAHilXQzL5P9ZpS4rik5qEqw9Ly3ZAtRDS7FdmqNwrwxl
HWSP3O8oQriGJkN67NV4BxcvWrIMbmBrP+jbjBP6xps1PW+vw/D7dvXwa2gDWyzdrOgr5vpR3yNw
9FEoe0SYAwIsdMeGLRNE4RiQwNCzXwaoQ+CYROBPQDNKYSI10gXq2ZDb8dWFY42j82+nGxgnxbPP
wTksYXzKd6v3r9WDgSZ/pJJNS4gOeLcEJEL6eBdQIUUfkDYJGpwSRGxRrgNFwGrYieg9oassRbHp
Arm0ZXBqUPTg9gHKjFvClJbRrgdnAZR5qFsFeG294bLf3FOTGnW2pBQtEWg9TbQQjR6IhH0W+jM3
z+vHAjI9JZZnqw4PrAC90kFVEGHgK10tW4CjEstWvf9otCM6zwWNKk5obpBRbgLRPbPILrAsQjEg
4ckLYWLaNUNzaCSON05hzZBRAEd8KF2G7ixFjIIRQQ375N+qHIVbhiPlgWkxAl0lsyJDXU3Lh7zY
vA/2FKFpzqXTRXchJPNz7fgu181xJtEJUXcCCu7fXurogUDz871db/82nAex/6AeWVTc5GeaGJsV
gO7K2vynLnlUsvODNVu4KJxZKdzU5uydCkVK8iJ0b1L5kLhRpltpXe62fGaQYHp2ikXQ2SbWh+5V
gUQdahrYnOgSPwkiOEAlBW51aSGPiClPzVFdcwrPvQ+/117RC2K34AhmrpZHUaHKIR86oKn6/tRg
Tly3PJ9oOfAGoPIF4peL/CFIlY+j3VadQmWSeOF6GS4E4USMX06TeuNFI0Em/0K1yQ2SZozQDb5g
qr2eCaGOGaGGmxoDyX5fRb8b3kkOKQsIWTbAXzbEtSR49RnZx2BfP5teWfyA279zBIleNYo4NNdr
A8/G9dI4/EGa6aZdxmeHifnIo6VjYlza+IQWVTVY3QES1H0cPspp34iVdLcHf5DMAWTI03Oo0XsY
De6+BiuvNExUtvksR2IiqKlpEL5qHObuw6BYDEWLQCWr4hYljfjKTi/xBFdvCjDEgMT0Ait9WrLt
S4icFBGgCgXkC/6PT0jDuJxVht8koQ1jKq1GIGW4Z7nVPBjPH2zG2mSvCBm0DD8W9ryxrKyHErAe
uz6P7a5VP1+U+lbeDA8aB+1vAUquYujQwL+ITILP6himt1leJwIZk3AGXPM0/akWDGEaUs+Pzv97
wb926ocZKxcWMN9sT/Aa/PiVWUmyUwHGDn7OHoMid9GyrBG38uj/0VaajYNVo7wjIbW9EZII1HZh
kvbW+DPSucmA8M4a4MXdkQg62siPabo3lrwEw2HTPK4r4R1UMRLqdwKZQc5cWd5Qtm2wnOQq6ui2
hJ+eY7Kv1s8MhmhjLmAFbbms3srXz2WYAdDLkUjrflA3SyI1niTm5Ep5l9UI7G+zMbkKaT1nCIBl
/C1fjfIeIdr5Dl7e/9FyCvIISXm6kCqBNTy1XKs+p8MLnSff3SwO85fX05NzKT6zSaAtYvdyLyTq
bpm3CHff8PbsfOo2jsKRiVr8NLFe5NB1DMFJx3KJfAvxGu/8bWRdBDKVx9BznKAAmLVYy/Eib4qp
B0mW+Jz7CyLyMnCufYbBnK0G6FX3H/r4LKkTS7jvped+D6Vwk5i1fdi5WNnIuVZzOYJcnTceafmS
DssNRQDgMvVCsBttbyWzfhtxpdqZTA+hEB4J49fX2A8vYkWF7qcoVDiHUqbdPgonTRJwSYAvVyBc
m/ONUD9kkrfAst4ANV+UBiNSQh4JRr2eTG+Ac3U9JxcHBg0GBQgfrE9R8bGRh2cBVSvazQrXgCiz
Z82EbxgH4kPe9cOAuODukOBARVFfvOnFrB5J2uicHjANDK7z7wg31v01TVhUmKH5m1RFPLM0tsMZ
sbHI+PcbLbPQd7BC7gMYUFIzw2n2wxwbMCSRS5nah8XM/o8N9VAPFyKRsupJsLQoDFdeHFFUnHcp
tabgtqRyw2UZfTEdeyqDonUphvlf5ZzzTBcyIB2cxb4q/tHxcz0lpzvoIgSpE83tTc9LdDuzd7Go
gKSQWtjYnIFpfBi+9VYV2m7NQA2VhvKulg/iHLLMUrwn2NX4CSwt+wmTGnGAD3JD/3Xw7NEk3XgA
hdcMnkraVASFNJgTXxsGhHBSafP55QUmcLQ9jdutwNDBra2D9DvSW1HadJI7SpalJ2sHM4GJjUXI
WBIFgBUXMME2GuI7xe3mJ21Gak9GmFh0QcUqdUv1JaXfrqqTsF8N9skL/mXNA9AIc0hQcSP/Fr8A
Q7BrD6e9r2cReK0TlnRdtiAu2eNW1JI9jPLQmC9iQJayvtBFXU0NLgcBbnXlh7KqpeikWLpizpjo
o+F8gMwrWSVtbwH2aggocwNC1Yg3oPluDHCaEA3Gxk0j9lXb2aoKQCMMu646W0IQ8rorSgnYxu0M
K+Dte1xL34RKGOXUsNuWMtPaY+0mHfZxPyQsNorMY5oA2Gwp1B1eDZNO3k4OiJe7eX9ajKg7q/Rm
YIuR6l+ztC9ZJ29DPG4gewDEEcHs3ihyFIzh6iWBbp6ZsInTOPhWJL77nUyBBzfi7A3dOQK3LPnb
kSw3rDTf65tT6qD23+OVCc4K83/24/DtRnbu+F6YVzxTF+A+S56pmSp6psLTnv+0AecpPz5mUBI+
XzeE5VKV2466yNhHk4LkVILX87tb4cuhs5Dz/1MYdPI+OmO6xg+k5g7NSRSWrvNBLnp9GzN22NeU
1nFGpyt8piK66ofXjdQvs7ckTLDbpHaFnNafPHipcMpKRx+Hk6w+Mz1J6Tn6eLLHqtUmA156f4N/
sPUxz08Tg/C4xkx/VjeOIzhp8xTztZPcCI/IH+MgJ8DETQawIFLrdPd2AyNG2YbHYqfsOvxx493A
4FYB6fCc3GcV7JGnBnGOYO6Q7zUZyAc+EnrbSD4FHuZ/5k/ZtLz0BAYp05LhK32BjgOdChw8AJ40
Y6TLPH+DzD8rzFxFRGk3L7w6FNEGFysU8A0OOJFjW8kr73AqMwUJ9Ck3prZVwyToBwEKYEhQ75QW
d31nzGP3eMTGoerFKg+PtUQPXkgc/OFkHWk9wy8aYfj4exr7v0Y2naqimMnB1wgWdfb84ZmNJZHn
+k3f0ecoUtX7FkhuI9X0G/h1PCbux0ScUHGQaB1fNIyW6E7bPoQa3P5GqRFRo0my/hEnOFkTW8iE
x4zFNaM0I2XvoRXNEb5MjPfkncSG7HB5a3moZo+p9aumZMVsDlGe7qVuDPCC+gtbEthsomkDIhNY
E6cA/I4KXKuMDRo2q2JomURY5bOuea4uvIL2QOoww1NkIikls9deklzyUFPwlDTB4IwczYwPxAsL
mJEtS0Pvutd5nN8Fb84Al0W5Ft9wMExQhw+3RPIw1Mi4d8o69tTabmreyTztxaboRoZjmw4SUsTl
S2IBHBl7lX4RgQ/efm87WEsURM3+Bkmmv9Gj8RqwKrVfaiZBSzhmBL8WN9cRg44T1Vqh/oomnK9x
IvR9PMDLgF3y24Mjvj+d4Egyo9tAO0tVL3VUcKw9+19Af1Ahm59WEAEvT/P+XR7yDY22vLEt7IKk
LjHSjSaj15j1HSxXwrvvGvSJflFqRBSst8+9AecW1Yyl/acsoiDvsKaDmrXjaIviS0ZKEKjb1bGA
l6w1hbPFe9PeRpqMlEolAWwOSLIsfZTsLPSlS/SPmbpP2OQCQgtz7qIZpJxtWE76W/rD3yRNlXmb
KDHOGsqIYNpmAS80qK6h2HqWrZTKDKB+oI3n3FhiNRZSDv6csk6HyKl0gxm9B1yLyYt32ZsZHjck
PxxPOt5D7IHot8NhnIerUUr3tgQzyyiW8aH9naWsREg+Kuvn8yizWwm339KC0rK2LwDXGkWTWuyc
uv8RkrP9XCikTDKcznHfQLCjAqLRRANd8bGm5QB/CI6DzI+kZrPi5T/hDK875U8+oc+NDPkPMLlA
spe0ozaKcpEHVvjTTO3vRxDJitUt1ceDNMX8CpdUNBOnzvLEQuKlZhZ5Jilz66vl9tIk4edFAeSr
v81uGLC2ArkA8r7mQVD7uLZiOBEcs8rFsM++ydxXvP//Nil0x9xtBs6ZeuprdzGvIwP+lEIF/wYu
bbDC6CeD/LmrtZEBqd/GW629+4vTDSvK1BY4vxy7dGBb0hNzinmKKSwa8dvGqb/+oX3psQm0YN9w
xGzdQCleZZX7OE5Qo0ilZLaypF53S2GRDXEhFKfDmyo2XZ5OjzAbAiOWZNQKMbsDV2MlO+5AOkpx
ZBHTKoW6AhIwWqfXwSIqDjTypO5Qos5CoqnG0W2m46Qvy80FGRu/P4xytQ8NzEvNgoflyST/5Y4s
hDIFQ+pLxKKh0EzIRP4awA2lP8LK6sXwGo2RM4dS8qRE277YmEUZnR2X8ATm8Pi08bTS9wdzbloG
/RvD8fGEcGDoYh36HW/CrofkdzfPxv6mptT/YLYF00dq9z9cfB1E+GKsaLZ8YwNh7nci6wFlJP/a
nwkVTfVABxOQiw81WtP8vXIweN3zq75NjThjCv7BtOFvg4tsUILMGeF3IrApZMkSqMTNghfd8Pax
Zkt/VBYFMNQRxIXwLLfeu5TJNu6sfc3ss6DznsWQibUO3JiSRyIAGZ8JJouxB5lMgL9j7FFPYIMK
2VWe9YpFX1lpHiEttqqU/p2fvMcqIpaQYWMczE31R2rGjMj47r0JX1ATvkw6nnRv2BsEdkyiDZQo
cUBoccB7WuIBSV62NsEVzHbwKfypaL3jEPbISd4D1vHH3XG+E0ekV/odZ7kFWrRvyS8qwaeK8brI
d4Ac+lS/AG8A1nxIv2FpgJ9Scyl0N0hYdGgrbcQMluHd+1Ta6l8wFGHBfMc7C4ax5eizQaK+E+yY
5Vmbw4VHlwZrebLCg4V8/Rw4mWIUpROY6QpJ59tosE0ypajTh921p/nTbaqvsZ8IcNJfMbhpuKI+
CYA4v+h7iEtm7PMqANpdewpJSIWZEcQIOTMXJroDjn4F/9ZukcN58EpUYeCUHT1Q6JWggpCBTLo1
0UDTpqBs/VDJgJsc8q4U/KaKOpKvw1oD+bZspB+sN9lrCMC9RRqBEpUISNGqF+d8bGs00fdIdrQd
xOJLYlc2Ali7+FfoD6+d6I5SLQY3QIvjnI+NwpoexqV+/M5W8NK7SYj7PDBWTbdiUNmSzzNU3swi
PX1OsWhXMIEmHtB6m6xYs5NzEzAEetBXBJdCRB9jQwt4lbxs4JyCQ/fgmfhAIIL5eO0zvBIzZKny
uGYPNNLOEOOGlQcfX5wOrR/ZIkoPo4XsAZr+1bwlYwbhUpeLcsqWW39ca03k+7xlXiGTZZyRzFKZ
3EFUs1CLtWe+VTREBaovXKXzrkzMODkavwqpN313HOX1Bl/7VPyErm3QxqNipcO1BiF/hw4CGycI
SqeFB+alSRhtTDmEMV6derghzc5weEZ3PRm28xWBEQ7a1HPXOvZQy2QtiVPeeqH26gOrkMPmkbbF
FLxCxSw2jimbg2KASVdPyY7ErbTnHD24sRxfnLeNkhfL/kcEuxSCYDEszhS0ge9rjdv63MexLOTe
XTBoZX2kG5t9czQNyW3W5GH4CQW/taUj8yIl0koe98p3fEydWAIN/RvsTqgcqOlMdDWIxh2WBwbo
5XfVjiLKN4s6Ih7jo78j0v5i3TkdNyEr5rcG0WuM5epqFPZSzkG5U1RwzM4pw/dvqyZ6+YKc+dq9
nAfNotXGzHR7srAdwxYhKYdKFZp2Dol5vda6kB0H9WvkRsUNqD4oZqitjZwFPog0jbOVEfmwAspQ
wn4030UunF9QGOmGTtww6AZNFau9dNJncROyyf5Lvoep4924PyChcCcam7jIk5iiqrJ2zx/ET1N5
afjVolgvKn2WMpbquYm08s0TGn3RRaSke9TAJwiVX37fsAXOVT80etyiq9t5SLJ8T7bqm52ymZM2
jRk7DT4mQF1chis5ZDcepjDtgvFDIz06tXWiVhZZd52JtmEYV8OemqQ1pAOFD1+qLKT14FkQSFRp
FlyxjtRGLnw39z2y8rje/boJnKbZFQ1utbedJTJazCiUHg3acpcXmts2Qg0AmNOI/AS+kml7Bdp6
vLH92QTRTSFQM9T9Jgl7dm8QVbEaP8j9JrKE/sdflK/zPIE/bbn/TwgDC2u832SrGw+nPf9RyhoU
W1moyWHFEpCbnRJXwyUA5Dnal6nv4B1IQNEW9yg5fsvsluFkQ+jXYVL2pf4VnnnlYaCWROcM6V+t
BFmF2snAH/wjMyfItMu1xeA+GW5+mOeEvmNe/m299hEnuLzsbDPu4nKq/1oDn2JA+H8FqBxSs1Rw
0wEtiAIDYreIkG6TXdQ/vJFBem4IyeATSG5TBbXz/xIMxgC0OPr+qhaXTt5oKcfdhgWHkHW5521H
9FbyY2C4p4IWIvKomToOX4ABU/WVpKErg0bxILZjCSspaQWS0+gcoNsfhACsi/2eg1lL5ffFfwZv
akgI9c6kVgeaFPJKJiOQ1klzCTo/Jl57KMudgCWfquNCGsO94fUhPkQx6k9ta1XprHxw0WJzBsur
qAalO6Yv0lvFbGESQS8ansao4B2VgN/mxwB6NdePuQsbGxR9D8prqCDoaLG3vAW0tSW7i3meyazM
2b2UGhcpD+d9+beuO6rKbUEpqqL4Bj2yxPk1JSG2ZAjDbrB15lFBoM2mZiGD2U40qW6TUOjDEQJ8
SzymEmwXejoKQq955JlC2lqhwksIf8TlxPpKx/umZLU0e/B07r/BT2WxUoJWWvNzMZh4D7c80WH+
7gyUpDH0ev3h6QyPuH0bYO5hO6CL4evmFdDNuO21IimD5Ny481ad49LuOR0zGT19DmefgOvPvgVN
oAgPmE9g+E4z087ZgxQ25XowHdh61I6Nbi+W9JvwMZs1/fDopTcy4pzhjP/0XmcALbTONw9b38L0
5N1sgMUf6NDfQULJCaVtvUglZPLsqFc8nks2UxiCgXAHG9fwONtjQFjSJWGxrXOktk97VzgbWVF5
Vy7Dc9nHeaB4zR+nGNlX48yHVjA60y8iWO0jQEa8orsObykhIWmcqBVCvY73u/kXLsTWL+KHjd94
VfxO6MQsT2sGPKGOcL/+OjUqoJC39FmJi6mQSVWNOanu8CZUWZwlUjEmdsoXCxpGyQT6MLZpQOzj
emXyzhnikTfgMWWly0U6iMO1xHfEDirvwgYdPgSbrp0pJJDgiOBI0cEQ8WEbDCfw/+YRy2UGlQx0
1GXDNfJO/9k/o2frjmCow/1ijYTBM1xoqtTaTl0PS7OhwsffsM1BDbqnz4GH6vUhVo8efGyYq68T
+KNB3R3nTDRwB8DelXGxO2cJNA4zIOtZA65ZFw3D78cA641B+9ZBYdrQDenV4hVN+jxJ5P7PPbUK
Z2+49L0FBmuGTy3Wq2lXfxe3kNfa29k/spYaKMjwJQvuJolzCHICPVfa4+x0Es6KejRVsFOHh7u0
Ifta8gk+88epRX6FBjZAJJ/I+ZYyFdcaI8Mp0Aq7oFgmq3x2UN3xNydDFn1xmf4ZJgugmxuN2r3d
bSLXrVHUAUW6bvet+XpaZ2vBBAuAwKQD5+dyJzmwcf4cWFkS0Sp6BxGnPpyF4JjlFLe9S2q7mcwx
tgSwMJccLTZyZ+b42qrBjsYufuiYzHEAY6hL2/aA+TVRA1XMrkNpJzJjtJ19zrCE5rgB1vFPBR/S
QA0IQU458X7V8bDgpuErfBDzwUWOULg3NZu5tuQiWR0Li9rJTIZ+J3vOwkktkszqGR/VhqmTw77x
gJsVt1hM7ZJTF9ESYtVkZtcdbxB/R/dwbfQ570hGYG/uVjJxoXYMuSr3Z1eaMuEvdH9qDSN6zYew
V3Yy7BGHZuHE5hU4y79HbMi8j9Tai6/VUXA4z0Fl95LNqYUUJT0ymphTrohytahjSgR0ZoZ4b6Cf
UKCIMqjub2/1+GjSINguwTPMcmrQx8Ay4zNA8xAW7L+1TchmnOTHJTZP9eXrHGao/7lRPWq2+62h
CcC5gX6YvTPDaQwpwsukN+V1Khqg94UtWHMtDV1LcCsrrfoLoXOj2/geVOD9X49XXw1s7Qb1AfuD
qgN0kS42lc6FMG4Rt+4Zx1GeOWvsn0zX4CG1kLC4OAu4GAyGOm6agy1uq5CiIvICxfAanF007Gh4
6JaHs+latSEYAh/+m4/PXwvb2xgZTAxYdRfBa+uUaELWUjle49E3+LqCW/qQBxYUCwxk0pdmEbte
ZUhFto7rcrIXq6Bn8S8QdK3e8YSt5muNpZmmYlUgMq49kvi0AWB655GnAcOSDf1zU1/Fut9Lp4xR
2uAk266rRugK5tZvt/oWy0j7tp10dsqSVuHQBzRV3w3UofudN2gx7XM29DNH/RgjjMXoLyrx5Zrx
m3D+NZvO0vm1xmEFx/33C5yU+iRuGl5xXjVMdSNcqXYkPhEnaMtLU0PhggeOS7e4EjNXfDw6kMNE
zEJmj7pOzqR62M+flyNCZwKcFFn+HEbybtrW8KlobaOspuUdTrQ4+qZp2E0331NE/AvbGYIy5yvK
XDFGCsjUWpVGcRqfUmn9hdABrYXdDGG1CR7B9IaKUoqvtDpmoLeiWumtuqhtD1xdETavnA+vX4s/
p7cu9ENaGsibmQf/ElBH1ytJhEZn3RQZp0F8Q2bAQ++ZyI6JaTyv2IqwRrjaTNTRmSd+kQtzFqrn
As1tdQ3QDzOuVVtVfmFO3LO7p3imkWmybsX7a9a8oi5Us1V57Re7YqZnVOdO9G7axaN3qXavfweH
DSXWTEUHXrYHEfOrJEKH7/20xXEfS/X3IAYP4Gl5dDvD0CfR1qaSlz/kjg8ogm3QoUV3v6o0nxHS
EmrYOJgTeUEaZFX1BTB2icT0WreX59tR7ocA1ISVRCu9zwUtze2Wiu2WVdsIEJE0Y9miQ4vtiUY7
bps11co32Dc8YhGFbaIKr6uiJXJasZMnKY/IoPlC8v+sbVFbBfRvvLD3AlzWvW5bsmTJZ5xbkHJg
+WX0CnisjXoVOCf5UjM4nYsbFjQhtUd92TDMxBuqTNQKVPBB4iRRpN8KlCMKDvNz594H1zU74oQC
8m0rLK71u6voWdOYb+R7l7kmVFZ8iFRN69IcIk5AvcgLoNDFztfBdk9PZsdufJJwgxICliZWQQph
kpcc3RiwYzZBtI07/Zc3nZdBlgBPTBERPr2ihLWidU4anxj5cZfZ0F+DFx2TPj2PY7iyzwqUP3BO
N2FOFiRO6QcH6gI38rt3UhvFgKPwuFLdh/UHAizi/0k3FpZg12X0JT7MtRwCyFQYSexCi76lXvlr
qcZ0KL7p0fEUnb8KanBDPKTyAvDmVup2p/BC1w3hZT+Qc92tde6pgYzIXgKwAeenPgxD8BBatmiC
6QonRGfvgVRrMlohv/KZX1oxPC8EQBFqDuAtse0NMNCIfh8swmOJJ8a7VvYDSuiuxgDfMp0tD/On
MNxZE8RvmSvF+ZvDAThDky3TetQ4AOR8rcDcnNqNRK1NKtg7wSercLU+Dm1aEUQu9toQVBQms24r
OD7APeFQDtTVkb9p8/YBApJXLqEjvV19o3d2TrYInUwLMB/E5MuJwIo7zL68T9KLF8G6JxpjaF6H
MkPCihspw1wdq1c956wJhiHEeoDYtZhCKj9pxNikhk+sfwAbIllrzWnfxBCU768XUMcyX7CtmyU0
EchOfBkrRenvxfkiEaYAn1QYvaP3mXmC/2KVID5N4MgIYlNnGZqJiTRqipAlKW+tqgjvEoIocNNy
Nie7vOWwUkMTuXodcX4SV3K/GGMY2EXnqnLlE/F8la/lT/WP6k97orhPoyJcvcUaEZcNiS4S+x3L
Vxc1QuEIdUzYtQzWZo+1y8d4lB4PzfvkcSSVEgYo49W0Oac1pMvkLEDWV1JpYhPaQakVQNQ4rWnW
DYAw02xJeo5lCbSWFyNHmO8haBrS6yzqLASyD1M7oCpMkfhYe+cJNh3zHdEWQrDfL6Bhg5FCfNn4
WPd+NtfXrDQKD6U9+++6mrQ8FlW6DCm8pT1jU3GXUFMEqfEirebsweJNZERjXUxQSZg7ymFeyFID
M8+7sPhQZKa0uZfw+5ZIOkNvTDWhLm5qEfDkcGZaKY4DOx0utQIZOGR71x7cZYdT/PjH0ugzUYcl
/38wpregEqonkcLg773hdyYXljf9RFQMs4IwXfXijgwkgJvgp1iK+kPuXaQ4M0ZVZisQgZ7LhGkI
WujBpjyPOJBk7DJ0TUsbVN0GjQUUHvsZFyv7LYjiryzZV7Stx0Z9uMnpfbSnnowTIAkQbmeQ4w9x
N3TjHYWK4MTV/SNxwJ6Tt8JlOU/wzbDeqs0qdur6WlSEqd6ahE0gIO1HHkjK+/4nsVGibK91r5tS
dKq46BSO2wM0twh7/OWXvOcmSEqg2lKrrtnLjRNHpjMvAL4NNSk11Jo2NXrjwBPDf7X+FmWMpUu+
5UFPIqXgoLIPUGh7Ho4zDmZsK9FB4VnvN9uSEws2Clnp8ONHocqKBfXAA84tpmgz8laW63r/Hu38
1lu1s6Y27Jvz4lxfL/gJ3Kq/VugIua7hpGPRN8pBsClD2y6AlbdDLa0VMLfFR75X9HmiIBn1UeOr
GgVO0ITgrhInXgKFBrN9RmXhwcYrHbnuKJe7SbaRi9AvRpNwHTuVXXRlBJsDhRm+h4zgDemhNljX
ErbO06i8oCexaND7uxUNV1Ww/hgyPlaibqxOKZpEXVfG2sqNq4R76yMXdOP+6ikBMWVIhPalnzJ6
RTBuU/PxmqBJ1MBl9wXn4MQE1RDS2UV0KnVfNa0Y/0pkfoQQV+szB9tLVOX+68nSfvZaTlgRl4QN
6MQL1OZRTWIsmLddgPGYTsf7SpVC/LbMoaL8Gk81/zSoMqBzIJJitwrNzLw2/i1+15IgHwoSmn4c
z4F6NLwanPTs/M9D5NWiqcJJSIyqqYUKCEi0EDKbiuPWJnVvADk4LQMAl6u6lASQG57DWakgDC4y
OVUbCs5r9O53PukqMnRaXvnJvFxDNHeBEx4UVylrFgRFAXK5sPpR0RMxbdqMLPQr+KyxZahaDxbi
AJvIF/abLNByXjEnUq76q+g7WfzESeuUXEedfds9OlUCeJcnuWZRupZho5pwBhq37vG+9KCR1PQY
piv0QrqcyeRne0u3hbT/+TQ/z4BwbwWgfnxh+StQqgtwqbCtE5lMoe8XR+gzdqhlMl1M3gKgXSg2
zqBZ7ivQYmtVKSGdPiEnhZAEjraUa4IA64DFf5DtV+aMz7GrceB+1oK5Jh8qfpgCZoS7CLr0RDMn
JzvNjt0fNBPaWTqSA7OzQ5EPQzQLIBlv873rjYLlU0F8WzGWXephaWXY6EN5e3XJz8jEmEz5ztvn
eByvmleSErQ88bvZ2XF0g7wlvuGjbTqBN0GqJbwEzrs8gl/ZARY4PjMJ+1tXex9x9P2fi69Bu17Z
QSX9/YKQtCCGA8feTXV/+5FO1et66kW9WhV5JjZPeMkA9P37kfrp+KSmWfAQKwuRmk+yViFUvi+t
FmFcxd/KCbn815vykLltcU9TTcece2X1GnYvri1SboTV/Y0+maUm0h1BeKa4UTof4HaGQ2LhixCq
3QKjFWrJLjHarkaGlwTfC8+wYWybowRoDSvlmH8YZ+2YV4iZl4PhjleUd6IdeGyrzMSM1lzHzhuH
NcS92Ljt0EQO8lSLirAHfJH+HgW4CFLgIA5o8ae5NSdc4pNlCHlsbyPug5xNlNwuMvunJAakWpw9
tu3YiZ8nzAx9nDlJvXMxywD/khLDpw0PMWLAiFDOfCmhMPEMQhHkBBBcAyBqvQTPuFngiwDZVday
WhuZsgfGvqVf3lvm6HXbSuI9DDQJ7sw4zbI34m2n+s9TM/KrfmxUBRnTsVS3CQW8rkOFHo1KUdiY
4BmHsW4j2aXzRu5NnC6DyFPYBJTvHlvem2O8durxaZiIYYGEAGmHgsqg5oB+k+2SBzuZdckB3y6n
Sq2wBxZAt+0p9tyqpq2w7KjvATh6XzlCiaXJdhBoDVNGPjeFCqNpXv1KfKD2OXr1VoKYte91vRvn
LzG/XXP9fG7XMNnef6GjzWa0ABqDg+848XUwv/OJHi3Slti5mVLqDd590o3crZRclF0xiiJVabTZ
trWOxhbufJieeAo2GC4yDXVsrLd5oSVM9iRHbMjtPmDkMBetGNR04Oy2ZFE0UdghaSMv271ySlV6
eI8IsHFoDUDrIrMBc2BnBkGpchlarGbuW2w0CFF/gH8UgawgY9y7xuNAeYQ9VahmWWif/IBWZtIa
jYfORZXrJh5iV6QD3gVOSIra48Jwx6btCezxmLEzL7PFZT0OSWceSACe69ubJP14A0xENJtInyZ8
BV10syNgpYQ0QR+VcVgHztA/R0L7KWxvd21AbY7B+K5u8xooYGXBmeWO+9dvhm3LKIKAK1JRJ9yj
Pw4WyNftllNintnbCBEvExM6WL78CuQjxNE0niZzF6V9UmYawuuB7IjqM9mXJLHVJElSxEEXcrD4
lRNhGQmXhac55a8NCtZX8MIdOwxmWtY5LpHgUXHSaZTGGSERjNwl5DRxBCx8egUuYHQZe8XpedN3
HgwLHvA4vY25Ug2RpFhQzsOZmOJFW0llg3PWeBqjHg+m5KfkmTPeSvYB72lR56+VfvgBr7yvIeAE
nmriomYEla554Qf9Wdb6x39RKcGl4QqpqFt//oroegTWqssBlN0CcEtyFdWzw/5+ZOnkgnb1PYxy
ntbpMU2p++oe1iaK6tc17huiBDofFo7WESGN5WGqkJ0/MMS+79tRfdvHeY/Z28v24e2JX9Mv/z9M
YWg0fKzGSKGTB6hSIeTkLAT1zmxTmMUUgfDZ7RysEU1vczXLnVySz5sOmAiCi+s5DcNgyDP2ZRFU
8QrZE71G7sbye/GUEAShmLDnrA3sZGEgIx9A6qsUZOzZuYAXkpxV/0S3zMfN8U7LV089aWng/Gd5
UB4eFyr71gzaUzOEHjyMGQFlKGjWwXj+a43odDb1Yzd6JjAl9f2nqEDQvG1xQBNe0lAKn/u6sph1
nzH2R6JszQTtHb/KuhCdr5Nd4ag1E2MvUBIhBj842VPKtiu2XWDMzqy/fQ8hk1FMnS4nCFAcOJ+4
DiOqeE3j8Z0+s4m2Qetf2fNcMmLq9nf6PVfxQyS/+EDaXNm+TLVObWmUFqmamvNMdOjgVO2JlGeP
rUFm8uRw2V7oKabPkHQW+cBaT2fFKds2LU8VKIWTK3OTImP1C5kRtIRl/frui2sWWxsEClYhzXuT
mmB0iO/SkSL8iUzi/n3HZpOQNlfka12jcmLO6huI9X9Zh4mg75nkHQHq0XDGNKuN4sdpSyRXYIOI
2u9I9fQrdGdSa2vydDgnnhClIT0cgqUWK7r+ji80hQt3oacWemQhnr33z4Jt+wYiu+EX+TNyT80a
CzuERxgBKBWHQfXYyhE+hj/r0j7mvwjASAtjZ5kehRUUPfe+ISNmioZMF6VxB80+Mmjel7QIFJZY
TBYIJs2I8HW3CuOzhPz3ISDYliRWokFBH41lrH3hhxwCd4jhp2qY1ntZU9zZIo6PCLLin0rgD1TE
dv4gTSswVSfq35ODTXiUXK6uAfTpNr9rKyAJoNZDsVy1rLA1vhXzy5u54Je0+jaf5qRIqS0vYdrV
a0GwXM+5j9JScov6nkyGURf5ni7MkGVT3c5UN8Ze1uZFVuv1GCdGk1DR0joStOHlKyenIF9zdowt
GI/4JXXvwsLLLLgabE8337dxyNJ/IxJGbrMbCL6lELizQdDaDJih2sKjLIo2ncsnSHEGAw+JbsNX
fmns12kVZX3ymROcrCjcfg1hYvw0PtibyH8MdtUB2SfNzG/qV6sWxMxlsvpLMqK8GiwX0O4PqgIt
5vROUX9Uz8woJFp5wuAG5LW6lOpewtY3/23MGBpAdHOQdgGdrPypfDyMAda0+8MbSx/3mMFhQCX3
6TDqhJf5be7rnikpFlD6v8W58jXhwcV5Yr6YPT+a/41dbGCtK6ctzoFHUw9FHzj/SYn9zjMxaTIl
Z5t15PVA1nMOywC/+EHXOaQ4/RH3gFxlD3VXYVovz3lkJQI1+QagA0eiaRm5UZKDGz4/56ytaGTZ
AUdi3s1Yj6aLPvegmrJ1Fm1c8W7uAYUzxqUC9EBzdYIhZM7ASNmYRy7BJs6u5f6XF1cue0L9n0bV
f2CHpfW4v/Q91bqfp63PVO8eLQffHp78fltt4Z5PBOiuOhHQCRr7o+2ebaj4DGlBz5I+cSArKDHG
1viVmufmyRkF9UQ8Rl5bgDQgzUFBM5xQ+U0BYqtkjV/yttObextHuoCpfvTeicFjd9bF1lE4Fe4b
KPzaB6BJRWMDL3GA4D9j4EQvkYfdL2XhpRQZ0yyM+o6RNIOON7kCUnpM7LjrI2i1ZZXnUtppdT4/
aKqYWbFrdI4dkKgIrbVdXEsxVfBlfcYqD/kem1OIwVRXE2ukp9Sr0BhiOwT7vmNFXsCEi+eHCuHE
IRfVEL1KDuKBWF02ILk7pXSZiYKF64QOcrRDD8OOsYtQT0HP1DYVZubqNOb5sCYlyUUE2LUwFHCM
IFvSCmKi22Nth8r18XyX77wP8N+kHmnLFgV/zm8EFXLoRtIEqrLiIax4JRddKl2QI3B28aYC3cPh
Mr0D+ZxxaXwl5tMUl9lUgGAqiQIosGoAC4O0iIGPsfrpmOLmMM3rP1dZBNilaAILXfUtsZbDr2+o
rl7jJ3801KTX7+U0qWNVQlXFrmS55YLzRNT/tzJb+BFN+JTy7+3FhDFKwpZ+Nh32RogNP5wTbvT1
wJjhxyrFWnfpWsaqyd6q1fkffR3eGh4isAXFbRSGlf3R0zVWFjjd9+GSLV0xJy25qd5/yVDhIeoL
D5UzTmi1VE4Aul6s6zsZjTOb0LWNcXY+MQ0MHuCF+4H8gPWT7Bby9Q8PoyGCJH54JLvujPDQe66Q
ZKGFA+XTKt2SgU2J+6rn4sVrfTnr6zLYD0ENigg7MpPQzYWzUVrrYKTsLguxSGvTGHA4O4fdP/rP
D2/XPBk1kMUE/fEbx6/M7bTpKhPEubrrURQEjaJeaqAEwmoixwX8FcL2hZ3Jb5qcF7mNHbWPqpGN
4u5p1UV7zDTEmX8q/rMYUxJliWZW18IdrVydsMcg+EJjxFbrfMZ1lnvZ1HV/+sTCpPTKl62SjXJc
/OQop85909AVbO8uyPc9yS1oxT8uu1Vj9Wuf6pcCCVeIx/XtWXr/jLlikmXvIUDxrtunOMK+7ixd
llhZ6Nnceo/hxRCWXk3xvR4QAr0ybZlTG/BwLlgeAGjq1Ejrq5SnmWOxOP8Zy3qyzvnEm/ubmxct
lbuBe0tzyp2mpy6EExImeHb6HfbgeePuOCSRrv7PxGxnCqsRzT0LuBLEchgGAmt/GE6KthGYnlTF
sPom1Cq5RTg79HbXVmByl4viQMz69KPopx60L3jsCTpoMNced/D+NVKSDKO4eOBir5urUnjCT4v0
zJzVS3RtyUZK9a7tNMPXZToF8SJq+b6yk3V63XjT30wmgTB0y3RyuLTe6LxaPK8+cwj1pvmVPQqp
zg9lflyDfG9EkgmtM78EgX0EZzPtB1NmxOjRygxgijJYjCX0HZ4453vdpb7pXsYkPBgt4r3XRFSn
QvY75ql+o2Ii06TtUS74ZGcWPhb8i9FzPe98R5ufC3RukJaibqlB1XSh+yX449P7TE+LsRNC850/
vCAsW62GE+jJUoJneCMVUBXPPLn6cPC44kbue06WWGXpYsV9Zp/atJz4CGbNN/mucrUIl8dOwyDo
zOSe8k6h/BxqNjrygvkOweFW1GooysivPnycwt8LaxhzO8azLz5JFGQkGdcxcd6yXRW2M8gc0vbO
5+OC/dY8CclA2/U4a+pnzFsFHsVvF4Yu6RTQ+rHaVxmxrhiYKcF8IkdiS6sGW8U1OC6EnFuXIIak
6f0gtXU8jXAE5qDRRz6GMyTDGq5JAmQfxzixlYhoWqJ61EPqO1JbtuXRxRHRB3UkVb7iYg+SXXTr
qP1xHhxutKZ5eWgto0F4ye6+3W4z1SKdBLbykgCkxlzMiDYCPF8BOpTDyNCSFldYcWtnVkJ1NNPz
OzlKNRPOmmHAu4k2CSxKlFwa0Q58m10pub2iE3rHGdGUNs47JkMFrE2TpdilB8RLZENt6xlZ4tOz
xvLXfhmStHIqHlVhCwK75VagXOgC7JhmP2zQIOmJMH0YSYUOP1wvUi7nZSuqxF2wR7JCtw0aXRfV
JBXWu/ErBnUGXfwm1z5PFxTWefGCiG3qOTRMElXt10T0G1ufj48Z5jg3pTDhbwUUK7+7oVs4xCB+
lxIZWx+VRPAsA+r075y9BkgNbWllyU5HSvNTyHcQ4eYvRETkiWvaKw78FCEck9aeFawaTOSk5wfQ
zp573jk4LD63aGKXBJ3EzYagW6X0I8j5jCR1sCGKoyWThjuI8U9Y1uqYqdyHadLiHSeWaEEufMGX
/F2UZG1FASwkyrgJuRo+0olE7ca4DE11kBN58kitFtBnlWRietQdnfsozqrTFjJzc5ITXZfdIQJw
eWlxuNEJpoMFK2mMzKAgXsoYoFDCUNGQnbgQU+REUECay3gO59KNw+5XjtL/zxVR+AKLZKf0ltnZ
YWDUtxCrIDg5ppiOmv6ki/iMXI+e75QvCEP0kCFyuMXbfbORYbRvEryf8mOg4IV+a9mxxUPBTsea
kGua3ZpGLq1L6Q89WrPIYioEOL4aVy4GC9ksPdYSh9WMax0nTCz+4Pkk7Oih6xRbZF9T7RPEtwc9
3PoA030h4b8NsAdDppspMlZ9b76LXAnUXn0zdkhmeH4K87CuOKwTmSblspncoeHwAB+ajDoE81pY
JV+uNSiThtKu/WJNvtEnit9EGnDYWqfc07QCcXJQ02nDJnoZnP6Ir4ilXEo/qACMS7ZZ1cDSbNp0
f7aSAty/XiKLpW2IUpaya74exR16QqHLhDTLZsp3ucTRGdzyov40YPecaDAtUnB3IypniVm2ijuM
NA+I6Rbrg3oCYG5Wj+o2LuCpq4hWX3XjArgvjzARlyzt59yDoRgSvigp9hHRtOSm0Lr7SCsmaDTJ
Tw6famWquj0BI4+1OWzsScvpW13UHagqIatZiFlRGPOEj/Bd7r6G6tXIR794xsznHo5oiT+C0cmc
EGGFjcwYuGL30ElTtuvsKOoDfAXmgkoYd9jUQRtY/ay/lCMJOYbKVcdQHwP/e7YSP2vA0+Ii+iOB
I3g6ZZ8eNVa2YkaBYB9VDeRqtzjwz9w0yZlUkd/G6gLu7/QZCW6ua0IIUNf3eHx83cmNzM41R/2d
8HySPSgNZY6jhEnovqBGMmyN3FCcX3gvGaBZzv935OVTIN4w5xKwDqeimQ3dYNAdoz/iAl4z5YPj
i856TDaaR0XaP2wFjZ2xW/TayXoLOLVQuY21QrpXx8qTGQB5+o0uBmJmnPjCAmHYu7qAZD/cC6/g
DwTNpzWezcG6j+8cuqF1ZvHhwNq/CbvfKhP3B+5DFcrhu2Qkp6akRMDiVeQgg9tjT9J+cuRIP1E3
Z/5WQBliTh2kADeIud+4O00OUQVstfSOwOhyV20iGw28ZMwu3uwn54kFaOi6BHX9WQdp9HBDqGZH
AfO7ZrUacaPSBHdT/q4OFAyLAp3Z4pwgA9hp3jdZYOmDuxSRWaYnIxccUjEvOfiX1/2QenzJzo4z
ZunNxlyhPwl8g3tYbqkCPb+bCj4T29H8v+/dDCkl3IXNMtVteMZyBJcD1XFu6E0ROl8AztEAa6+T
PGGzvKjQRQ8ojMLkYkrGSQj6XC4ML7ENy3cg63A6PuewNcsKqYorWCBGXq9II5/HLYYKH4aFlF9b
eJnBSXpn3ynzF0DWdsxNl2IbGkNQ7sGU7J7Hi15MVOTxGMIEh/AkEBflJozs+RrEZJnkndCU9rEa
DhAbKXI3swxYWnBaCzJMHZv+3DQCHYG9H96B0dVAlnEAm1p5cAt4vqqZ/geYAeZMr6gNYZe7Fzfm
LYtrFjL07bt1nrDxiKdKQDO7LBh6jmmi3QZY1n4iyeNQt2Yaeyv9INQEersAGj7mjUFGMdNj30c3
o1P+pOtE68Zklrb2uqNP4Sn5aL30fymBfioga6MErmcZ2qka3DR3e0DXbu5b7i5gYTXzRFpoNgMt
4jXf4u40xENSt8nyzFmZQxXj9cW21M0mZis4odoxpyz7zi7gXTDdASKNWGF/Y1CJnkdPSaUxFk9p
Is+7G/5xTxbeBJOj4OezGArp3GTW7T3v4pqYNAG8vqWcLBE+q94dFzgqhQ5PJ1xPIc00PnzpSH9M
qNuEOL/LQMhkyUvQcqOz5bje83K/HOQd7CWR/tqy3FER6WD3ubAxo6Z5yQ4ZIVnOymmV3xpOs6jf
8MO4eo/w/mRtq4UKDsuZz2D0eTP8+6E6GEwJNxFR4GI8I81XeMXebVoyi2ck3BimCok+hwcgn4PY
nRbb05bP+O/Jj5E+xx71HWH4xApn8+oJNEhtsFjAB7zNfPuiPY0r7obg1bw9/X06C93T23W88KSq
hvQzizJZBTZPTe8CpPNcRiyJpnzE4KdEM33mXGyiO/lF3NZRe3TIrj07aiwPGKfdSNIMcndQZKsn
refDRai7BUyqUqcdQS/Uv8zQHpaoY7IyZPEMfs2DwMXSkhpPG0kzaCdyk3sPX1YNuePoOgTMloAG
BQdD+uGpDfv7DsvYnKP9P8y6ZRuuS2OrU82KMjHif//zFTwOjDf6N6SYw+fYI2B9UGF48ZTtdqh3
PqDNauqjC3P9oGF0W7yQ8T0EidszTSc/0dkSGi8Qf8P4zvnwKCZbklsco9KHBxG3u1wUWXhA9W8A
0vhgCWltpHxrxKVknbLGbtn6pKe0LYTAFaBOjtF5AE+0v8SwNT1zaqojl4HMKUQ8XZ95fuimN5n7
tbuaJFUr07bDKONnVSVs4GJO1+N77EiGAPVyBXzm+SRVdrX9cmYcUMLGuSVB8RGriQhTGxKdqWsn
3hlXFDWbbgRZ4igItOL+k5ClRWN71IRSDt4yDSUEbUByxOWdl5yigt403gyvXACxm+s+fWh+GBQF
grqg6vBxPnDamiIuTQxsI94MCo07FPoYiTgxHkFezznPKjAR0VXdamx58r/bg4iwvZ40yqiBsPi0
OY1tjngsWYiQFtlsYrGtJSNptvXItaNpJeOxiSH6F+2pCa98GR8R1XGW/S+WiCt9aeuLDOzvBw2k
sPKFC6zHJaP9fVbOjLApoGLCVfLi6qSzSm4yarW3FmAvB5cDe9TXhJhw8Kb023Cv0S906n89lTcW
aQzvxGGeqVVurktcf0w2M1hMqr83PAUOFm8RkRT8lBHtfe8BiCulljh9gnI29k1yPNMzgGKi5pcE
dzemWGxjkKs3JSEfajfHJLHP7XaWkV2U3E8/rnq3fLfmbN7rLerjNherzKTtG0OP87arrLconexd
Z+rdge47Pq/FYPJ0pFv83AjzvFHb8ny7KsqwyPW/7C3rOhdP3OlX66heiP5TermoweGoTHGS+N13
xf6h6w3ZVhYAFKgfHXmw7NqyDZ9Npmm5Z5+PZRsFI5SSfTZLqp7pUylE1OMOrHHbLrz82CO7oNRy
bf3Ifc2XmHLz1aCKDxNGJcyHMA81pHkW35Q2PZmGqOeiA+HRfuqCzPImE6rrYbAR+8kOAeUz92qr
Z4arqltpAiy9GNrcbUkJPJW4BbBfbhJe7CMQgwLmYwd9JyE6KbkhG5Wv+U6lBF6gl7QogC58z/zL
Qq3EnM8GaqU7Cl9cL5oFlO6HtLFsG066l4hrDjC9aLnzLXV0JKbrfgLa0xvc0zqmc1j+6ZnKOcuz
1+FZGX5WRl916LdfLTQi+pkIcObOvkuahmntdi+yXw2lj+V5/lHIkK0YoMOoRxMbNBV8BjOaJ3Ca
1ZK5rGkL8XpIpigkm6dl3Qs/c8pZCD3Q5ys0inaqg89puN9XA0+r2GA7ORXpm/P7DqtuCIWlnHfe
s0vzfLH8LSEpqHAme1D1Y7Zpdgo7fM1QXT6DWQYXkzK6MRlZynsT+RldDHxCKRPmeEmSXpjOVSpX
38a1GOGzxmUF+BAA9K/goGwnZs0hMWcV/OEvE5ddrqXSF6kHQkfozJRq0DJ/5bqceXp8C/KfP6ZY
mTeb9H2vsBuiSIRFLkLEUbfCP+3ulbcuxSuKBjz9NQ+61CWU2xRIemOOzCqk0TydzJfUOnOQXQl2
mxzNc0i9mc1EfRLU1o1r8PQLLcPIGSgktMP1aGJIhpRi2AHYP5nhA0qEXaALBU01Xi+/59wyMmQC
NPVgfK+9EFyq5D1PAdf+22jiQ3nw33HeAlMGJqZtS2P78iTyHufnRVbDSyyBHoqzvDppjCuJgHll
ttr1U+Y7aoE3yCYdzneHXF4jW7sOoIt6t88r9aRL8wvPDOlRsXqBTb7wXgm27TA5BSRshxNUjaLt
i7KpCLseTVzPWLYIsPbLVq896eHNNB4lat58YM9U6rl1QDmb3pWBSaaJ2fKGHvXiogtUeeGTGj+a
w3VPs+k3fZNd2n9NbACgrNPBxosT0jZS3t2HQE3YhBlnpM6Wlq3GaFL050E5ObC/mEpMX7EfOLtW
TVTRqsrRmTbBe+nexl+og8qBUah2mJDVJJ2fuWt/TrOnQtlM0X0at+xmwhVLRmog+lHx5dGesHcY
jLPQQPmVfAYsDj/jE+l2WuW2gp0qsCwkhy9Li7dljzrKOadecSDa67kxpnEBKHWwiP5DjNx79qYl
uEElxFP1nv4dxEsxOpBC5rgEheFpM8a9dufP99tvN6y29V4zf8b+pzMkRYE5N0M/knRcq9vsafVn
pCwNUVKHWCGeP4rgXDs8kN2C/2lMYGOse8ceQzPV1zyHWM3leyN+C32N/xNrzhM0Y0fV0g3mo4YB
oU6Vt5WBb1u3A1nDui+2nnFUL6g+t0+YENXZ386DIiWi3JKl1IvNkb7rMYxkg1SOdZjAsz8KsNF2
JxwVsZK23kpFUZmQ29FCB1vavQyKwemoLezOzVot/CtsGZU6lw/qYtwPPp9BxUcBEpYJu8H6G8JF
EZvDQraj8m2O5S4GJhWJGtPoQDMIzY6+vTMV8bZrFkO6cHQFiN47KNDkw23rrDoYC4XcaT7PFUcV
YO6yBz4Uw8oRyPs8uY/RHHiZbW0bN+9GmMcBjwMb5imxmUmbKPynqllAz/DRQpsdfAav1VvzXqPC
j+r/zyhUTEJSSpIEFfLrU3Yw3o5dV/16wZ30vfi6unCnVyWACb8C8FzjtjFn3NyyVKnXNrRoAOaa
09rG4DXmAGOl+GtIz82FjpzeEm/mN9WuIbTDM0Kefm1W+y1eRAX5EMFaOYlDtKtXvJ6nx87HvNBr
/72oo04ej+uDVDxBIioAqLrT3sEn8qdNJQyhdKRlUbZyUkzQVNauP7pmkMgiyplvP3LmqqABcZhQ
yhp1rfj+18+qeFvP2n/LJuAkyiMmEzfhYvrpshn9OOOnIYw9gg4TEzzDKNdkB65j5VNG/YkGUeeX
g20hceU5JyAydByFPKsCTEAXQoH6Hobhunx1xFwNPke0WWil+eb+1V0V7u0Imac8GDWLShkpunJe
zlLpd1tOh8r/ZvcV3nv8INP4tn/sf8NusLQ2+57QRYnDP3xJ3teYxTiHIGWSTqdS0fWBo71zzlvG
VH3teBq6NcPHfjQrrvM1sE0MyIkvaaUtiGKP0mvLfx3EXReP2eOSXHgRd2tfFe8sE9NGae7xADdN
FGSVW0ktmWr2m2wkbuDVRWElP+W/laEuhpeTOMilJ5VO8zb+CJtSCAEahGft0Gkydz9Y0HK9TXYY
GJdFulR9VTpP1sMYAjusgxdZ1SmA87hTTasD0xQvpNs8Td7fWKpFZpJrGl82O3hZ7VxHeZhC8Xgf
JU1FaJ3aKZwznuqKbavXSY3CKC4qylpAIMNmvR6KTHX8wE/kLzrc645INAmoHxIcUdYxToPx2HLt
sHTXJP3JUOAVM9IQkCTEyUDpKiOhjal9LU+HjmtysOgar463XF1qCprNrDr5OctDZkul+xJt6SkY
KmtLj/4ZbNZIVjyPGnW6ySlwEYCMBKOJgT2K47vCVNwH6/LvzTugWymja6T7QFAx4ny+4kdWi+Pb
TI/cZ2m2Y12i7qydvSnOrJRtVy+oadPl2luseZc73P3GI+TfpaYDAVd9sn21MxOeZxemg7OOL4AS
kIJDucNyS1kAjZcn9WyqdDjRNW2z/kAN+qmv0XOQrura4JTMR3H+aQTHVMcSv6/FhgzDvhCZsooG
MKSuzU6tA2446F4xYvIpmjLwx6eCSA7joPyCH4ahz8OHHha8XVZws6QaSX6FC7jfGhsaGUa11oGv
lQjq0y7oK8vqQvmbGKBXNbnYJvmzV9J/O5Sn56v2ZEhbn1MMhKl/DSF5HDFMnnQHupVcumlbLeeM
mwZnDpZV8RSKpyNaQvxLczP9+yGtqSUOc3osQ4ATtNlgRmeojzSULKupSpKzBT1VEhQEEmPIAL9c
3QxKZkwtDgPsmyi+7P6vPAgaVS6XEkyr9VPlNZaD3KTuy4fpPGU7BqMIzwaitbK5EGKdS3Jdgi9n
Sol67rbQQNE+CviBf+SgdSFBEjGp/pF4nf6iDJp85kiutKcZwbXOntvHT+GcOFoXOf2Zi6XPjttI
Vrq+Ob4p8UMYg3G0Tlu7TbKGaEBKrBeU8DXUnXW74SYxJzx1s86NfacMNPawo7QGcfdC010bv/+J
Tk4LSut74MuMzNw2RZ0A0RLL+2vjguDLOWWeOhBkd5qjq9Y8f29brvENQ8/QewcHfyq3rcs+m2/E
V8uSmmJ8MT4ChH8MwOAqN9u1R4G8gdKuTUc/qMXplxQn6F5kOBsiFMHg7HNEAhlgAGWsYUY96nww
99qBAvncsUwgQCwwQ5YS3X59FyK0odvcFla4Js4fCIJ0ED949L8uustRLruHPYYKJ1BWTjdPNw+G
dtGVxBuZSWROLHA8ZNc6aWZVoVGQQd2fYLFmHUh+JHhyXc8HHJLPQBTV/40kYZXl2VrIteEJd86u
oD6Xb3OlnpPDVDETjinctwyHiXr1UA87sjVaoX6qfMNDaSq7lMv6VCBtB5HNEY8M5UuzjolaQXRC
NkTSNIgXNisNqh1w0cd7DZ8QPH9Gv6xYJeVgAIHSTPDm7WXvmLkBebjyUyXzpOvuRbC76IiEypb3
S6/hGQXQwHvURkibTJ3ljC5svUjIGnknvVUiuybFppbOcBjvn0q6dh601ohBFhBMhXBaoO7ExxIx
yPYB5EV+j+RZmRTrqAx/wSUigBsT8hLkdCPycZloWblOThEdNeIfkHZ+ZegMu9/FKcCmF4iF/cjq
nKFMvALbgjx9Z4DpxmF8StIYEjq20KiJnVEHQuIO2TFj3j/HgZM4y72anVL0j56mf7oxIWrgTqLA
jv9i3QRrQJepayfcExH3N4qFL9Q/sdqf4Y07qPvEgXtoEJnO1Bq1M9scb+Zuy5tP8bYl+1o0nTIU
6qjvsqeOyzHq3AUCWX6hol2eZ44EFomavaw2EQ0aDPC7+7l+bCri894gakoyiKKgtDDU89eS3ggO
sP5Qug2i1dhmkqg3RFGjKe6wrzfdVftz7lcwerNZFwzd2n9v7UGLgl4P6kGxCitKhWolXJgXgq5W
u71OBFUvyxmh8H6GIU1eotU3mhS6jyuqvzHEiOOcQ5TcAvn9s3rERc3RuYovmo7HsKs2ylAtSzcC
p6H4XW33AYFT7HDfiv9HQSNhpwvExKx9f5UIVFCFu/zvK3KITf/ropXVmLAYNqVq3FWsdgT3MOdP
Ne2luitHrm4vgrUofcU/xf/oAQ0sLTzVR9gbf/eTU24Dmr3yvdmGNkGVslCMvQWXCcn75VbI4wqn
mJVQr+XDHMDIaWPeNU7FzX6f7MoGpd2IAqW39bohUSaGkn3nb47T/ZxuNEZfHxDrnCJdigN1thEr
V7NLXu37iPYSNmWEfVoU3MTSxSzZGtODGcWX/EjhnP7jNz3yesRafW5BdTaIrKrgS3CkAC6gVmlW
gyjhCXmW7S8I+DLDr2IjjNQToLO2g+qHC3C+Fv7jRhiIvPlsTVpOAiNSGDu+WCAAVLrwl0HrrKUu
LUQqL1suLvaDz26H0GMxccjHgiQme2M/S+oNTFlYHL0xcFZFLNgdbXMGX6l18NTOSKNpuPRAEU5Q
y1YLpzcH8A4nU5UrLvI3PNxHnDYdeuLNsWRLg1lBnkH68pxdsV+6a9lOjpCiSK8ctSdFFXqjDaMR
4v9ZRZNxaR1kkYtJ88D7dXdSlOgx9p+Kk4NSA183VccKPXBlthWrTvBITW6j7n2FtI2zAplk8GEn
QykPek0uYkBeVE7V/ccgjYPA/drPHdsF4rdIQfo6Vw5jLjKoiwE0+kcwVM6XQe9j5HtjdtZVZC8R
If3HYp/niYtoH8bG7jBdpzgfU1gZ6Dv4u28QQgoztsphDtQzfMvNv3iN1ZtLL9XHA7+PY5kPTgxS
TetcjIDvbQSueBn5DgPYiILXB1CCIha7xjbVgdSNxU2KXAz0NTjBnVKnxsqYcZqp+d0fv14Ki5KN
EAdtoktkTiPYTaiL7hIxbmyGaQq4QGufbeBiQfWGMjGvDw1Pnxtg2r9wjEdCp9c63WV7IHOPoMvB
RbKkQBub5aTmlQUcNUr5lJMkcSyiJF/ae9zUIlDNVEIb/P4J9o3/lktdi424DLYwWIdSwuotqM71
GNu4GfBsPlTRc3s8I3wii8TenKZPRK7j8gjpURZ2K4UkKM9XPsLxzmcALs5GJpyqz2TFuxMg50Gy
YTwPMpZYzO+J4it3scQVYlRe3yPk4ZqJ0JA/vMGmQ3mSQLSUuqpmF/1MrtJYmTiA3ICaM6NV1dVK
ya8fM41mhj2Ydks2ST+azD+41fTGE5lSeH3vJlWF3s1oAWtZcbClhP0u50m/8rryjTbIN9f1rBlc
kgNt/zezcpxRalIB6q8LYtTezzlTTBwdR/WT0nI/A6cf+GUnR/5U0sZbmQHDHEP4hDlTzYS4nYZF
is9pCmVPqS+V5JKOtgm6qSxJpobpBCBQ9mwLlihmpSV9iVVmKxx7lTr0LRaMs1g4kuuWrALepROM
ZJLD+i6nE7jG3fcxTsrRSQlGSFhq1/Sbzb/CA/JmMJXw0bfvsEuJPT/dXbdyjxODIhyQ2QS+gsWg
pSJZhaTEFAl4J68cKtACHViwd/UU7qPMCA7uDb1ZAZr7SM1zj/aKqKPJtmUr5vG9WXPM9EAPoLRK
jogItv1lZvyexTTBEhZOT75uqGJOXH0s+641RcPvHxzBusQ1BRIo+Vo7MyZ+0ajXu88TWWQFJxin
2TBtBd5MVhixLKKvPaf7MvKfi8itwUXHgS7sXPRLmBhOtgFmdIGT5ManAXZv7Q40VXdgyeJreCey
AQp3Mmt5geWHo8eoz1zy/+ZADdI/Jmtpxzfg1LMu4GyS1C0LrKa9iNKabm0nycDksDWZ9Vp+VQNn
I0+NS9dmvnQSJ7Ct5IIOUWSBKOq/wO4nYF+ThQmxgLJGt6YAooXJi8oknq5GkN7XMlhSnf/IQOMT
4xa0B2BjlvPlgR8uViqYOBxY4HyC65uj05LUKR+AoSRTau61Hw8IxiIjyz/NXoRag7wYi7PU2z4P
RY7xHCqd56nAjJ5Wyu7QN+WIEPTUxmJcGMJAPdJb22JQDjir6TthNt0JLcFRNQNH6jDSuN0RS/jo
TckCScTFZN0tjh853TBnSoGSERItm9ntew6Kwd3FPVtbi3VMz+nUCnFIH+fslUo4cpaJld6Q2Hhp
Vhuqar0cTVitgK54UJOjF1d9NFP+o4ggWCghYE4tBhN28caKS0lP5EDk/NdHsK1VP6LlLHcihnXr
haAr2VXFJwrQFALupKVJ7Tdd9usrfkao79uDa9XJoAxa5hVRsMsonG/0py5NU5AyA2BRQhQ5R6BS
Y1XxXMp/j5rdWjmyh1MQDLWuwkG90etiWTjU1+IPxD4gW+UGpaRop/JsB5sNH6z/qwdr9FxKVE8I
Dr1d5QklJDi90pFilp1ymv9VT2DlsTxnyd5LlTxc/5XZowGa/IF/Eb2EIvhN7wkUR+9cIDGsvwtJ
xkk2ZjCAeM/ZNZ3xTWgY8OXmPM3CSl6kv+OOhkUh1iunKr9WZNBWaFjmhR7hblUn4HfLoYDWJUiU
iNu5eugl6xWr59mzJ6B1NLZyQ2lzM3r4qoL6iFRYP7P9JUZJ8LJJUvXW0eP67rRLf4Zq3Vfmj/c9
HnHgECMhY8ZH3ZhCRafmfkTycAL+nUUByBLZUrAaHRqye7WBsvKpIJjHPkRFPLaLt5dn/NoCKsrN
cG6WE4GjQIPW3QyNwtgTB+gp6u8Qj6nQYSP9twIIFL54Dm4yJ9hqk0Z/0x6d8PZIJGk15oYV9MY8
Iy3o78S5Ki95gZRNefpiSyPhk8SWCOGBYnSAJUoApjnu7j6lO+dcMdSRVdEdG6mz11hxNPfRIMhM
tXpOv5zMRXSHFKtmQI7+QIQuLh/47guAADteDNohReolSb/M2H74o+x5ARaVfEhOCeynT3YJDvNv
Ja1mP9aJvOBkt1/ccEJgS9CrmROvUXh4Unapy9+oVUQG1i9QIHOEYHhUKcxYXwNxkVN9ciI8pGN2
9FBEcVfde0CBfxtEVZbIz7dqvTqh5RFL+6YjZsIbI4FQtYoXom2rFIcskpsUpJQej4h3quJOD6UN
4h5KSpS0pZJTb4KIFl5x919S0Ob7rmxnbZfxUe6myuRPw4+XFsgT4kGIBXTgP4/t2fMYODMZxozT
j86PYaAd4zJEbygWqh4/lsUqsqefdgqCkCeQadDhEM6OOzCvlfV8DYIUuVsZIV9THogEgnlW7M79
27pNUFgON+kOpI5t1nDGvtokpT/oPBy8KH0Dd4w3R+AQg2PpVF6GZ2RKtp51Jh2gt94HM2wPDGWT
mXHiWCNa6Z31MZpE8LOVn+t4ku6sbxkFxpJme14JwwMwRDljdT+MotIzjAeNi4mg6tCfVyBVxCWP
HUf7yAEwDm9dtrmiK1vQz6GLxI/ggptH+t7pl4/+hDr/8tzdq6NRnRqLgKntRyz0LykYFjHSRp24
gm+EGoz37xocEoPX/ke4HCP3V61adDv6G7Vp238m6nrC6N41LPtSYSENJJi0U8phRC9lks5+P4AP
gAw5sps+4jJalAiMJITx6Kk4rsAhCvLduYRrQMgrIc94QJIUzAUEs8SdQhqCXTed21Pl5KoS/hwD
ex/kFIJyC0iFmCB23dlxeauRVkOgEkJMGAIjieaaiIAZ7N2pC4A/9OnCxWESBl69dPDJqzZlQMB4
5oRXkY0ywllTvCQqEkUil263fiXQMvSKwoNQjIZTv73N6pHNLw9eINSQm5cZggp2e3i2978d7yMu
DiYUn3Dxnex1YUxZV6OoBCDxLfbhJu9pa2N145hKzKPyWJSfmA8lZQyX89T2HHglaANBFhUc+gWI
NNineVm/ahF9/axXH/MTQ+4v6tYltMxhKl6ndtMKXpX31JD4GKfh/kQsD5BSRzaO80F9FmrFVqzL
hEfyaKySdT1q52pQH3YY+43gRrwvVMtYM8Sc6R0/JTD3l3CAYgCif5O2SNtRnphKB7pFGTugVkzl
F9OHZCP61zTPQtNwvGe+F+0UySslrvUHQwgv93TQAK5Z+HAQ+pvZpHvkNCP9TQYHZSXe5Qg6AzDg
rJ8rcCb5TFW4z0j4sxhF2Ila6ZFvcI5Gt2Vryj/lNo0huDKYc7nTuErzosFki20IQ5IOyy9mX7uR
aEkEyCxwDfWMZ++Zosu1KeU2gmkqJRbynUsUG4lHFS9Sx21JCE+lhaczwHRkcouMscvGxORY/zWN
wl6e7lQtFAOckvv7kFf5LocbkbXhdnwhPVWT6XgKKC5gRJ44tCAHB/SjmkQSpPJrb4PPsZxyk8Li
53gY+xoLfwZSmAxnpXB/WUVoVI0/u0guwE9FThEQ6pTVZ4BP3ADcexNY8XBM5ZJ7IiFq4qzEsJ1y
pONW3zbHyif6yfhG+udRVQFuler+CNm5CAsvctI9/iLACpJqz9TLVhbgRoOA84eSrmsgzf9z5Kuo
g8jYBD/xH9BGIx/jqsom21pAssN3pCypqj48/Yf0feEmchP/uW3/SA7/7/PaZ8zscQSc9S/1CPG9
+Nl9k+LCFYUvIJ1/hllNldrnWZBwBOrDZ07U6QsQmB6gxhG5DJ3xTEIQJMEX5nBuYzm/TlM1yZR7
19GfLecHxjSlQoIJ7TIu7kFjXlmcHgZw92GuwOdret041JiO4fWBq+AxP+1CJAhyxTWRTRK1Qb39
T8++0n9Q0BpQmgUXI+PyT6cbYgyYhJnQp650gDcy7Z+Pe9qbvSsXEJXY2J/piIb4CuHadC6c31FN
Wr+EOGnyTiyKOdyfi+XmMX5mu4iMCaB+BFhtZkr0nCDcjefikgGwkuVU9r7hTWNBvvHRy9AiBgh3
6AC5w+4isFVRAKjyhl3jWUXlZIeEok38uKZSHb8s3aloiab/zog4sUs9cYpxbmAVvd2q+at4TfZi
uh3Z0XhRW9w0x+C0YcRjtS0a/adP3drLwMlla2tiYcDMNRzyTynUvmKZujojnsSjOdkc3GICd4OB
EwObOg9UJLkdiw6mE5lu+2xNHDQD42uFhnzPcNLJgMnSQLgkhRY9qMU8rGZsakTR9ZclpqJkXrjE
w7/My6HXkUpgySq0Uq30mc353D3+8Fs+ThmZigNk6tKpRFd4wRj0azE2Y0jNyJ0thz331fPlKALW
dhzDULxNivjsOTLuibORTxorTHy7mOakuvwI/HKn/h6d/W1WWQiN5p4pdryNDMAz4uipi0BIc75Y
O2mqM+P5xSEtFxT+WsRrMYP2uvnW7LE0qDBraNMuWcVbZQ4eLGvnGifxKgkHU2vdrBr2R9aj37yE
d8N2eUq7i/KdJ3VFpbFPqVVciyExG3lzJkE16Y5sAFZR3fiWd9iXk8bLLuc7yTWp+cj4gSARhSut
aQCs4jM53XEF8K183JDXOSxjQiWDwlIenBpwGkrBlBb+KbSz+UvYv0FL48leQ2VGWu2Kvcm1VQNh
VP5ExNnQ5rzpvb/3LzOJ3nLUNROd/VTzWJWezg+qhHDZS3RImP/FQaxRhTfKEiPAY4N6zggvphI2
tmSHu9DTGF0KMWXe4l2cKh3INkam7P0NZWqt7dtCphm3zDvtUWmUKdLqPP7DE2h5UV6Dsz3VFU/c
t2Urfy9VITeaW1MxjVhcmcKCF8zXCve947jJaT9RV3xTEy2bRGfq1GNDAmPHy8zCYaAqbL+1xflt
pEmTCGCIL7YNIEIp5ExxoHUOzCxTkVjVrnHQsDJuihOGY48xSw7eP+db+DIWiXa6VKi/lIl6bbpK
lPSdoTsOYza+XNCjGJssAtw6YHefC/WGOauUdBKlFuEzkL5Kk6MjZ1ytkbPm92UPHMZW5zDQeRpc
QTBXMmfEn3JfpaIbzp/fqX7kisPZQRO//7BrF7wInzZhZb5ZqIYHHMz8zpXCRV+hRHxVzPuLcri1
j8xqdeQLBtBFSsCmg97Rx7Zw5n9IQeev9xVSHXJtDmEbMg5mSNnAFoK011ZG+50NVojfESJcBIbB
idJ+lowfihfna/lsVtU1Hlc8tsoyWELAiLysrhOpC816yuZhAgR9s190Z/i8GpLfQAKx46QuE80+
TyjTqhUTt3tNVAr77htWu2RdY6ZEKEryKn8Ip54FaBPcchPlbABKN1y6CyiDDhieTHmrVH0RG4dt
zbBuhrD4mHobBoI4QxmMcAgVNgq/E9AV+BzgCoOAsq4a9QgDMVgvqZqiLUe/PBhx/vHC+6/0d+dK
KZflI9AA/I1HBECABjOW0U8SGIXz84dqod6lDk882rSMVwvMQ0zsD4FMinpjfKJjeVdGC53Rr9yS
rt0rX6hNKkOkNJ7QlkqsLoZLwTWb5J8yp9MD+c42wXfNs2EayeOgrAus5qz5NItGLfseSL+A5sEL
rxpcWLK0tw0U21XKdsALUVsZkaDnSwASZsQFwWpzEXjaMy5vnhJ1xsW8mjEiF06MwWaMKEZoXQZy
gNClZxrfEvo4sk5IobdSWTCAPljW0FXDhx8qTaefd4vsqqAD3+UNsLuHXLXjz4o9Qtha1vcQ+7v9
pUXPSb2dW93MzUO6Zp4frpjDRXi1pL/MLD3BTnl1r/9gf5m6s1Q3rEkS2tDU6slVsCK2t3e5jN7l
7oWGsE3XkLIp7eDdyZ5JMKOb1I2oruVyqwiXcg7C8ZJqwrwCM1cr4bebt4wmBjQB4jc/ww1lbIL9
qHiRFxyE6puqXsA7VDVuaVDmz5tn0Mc71kOmqWI4QnJ95c5gPDHFy9Fsz2OQmBo9nvKQbCVfkvR1
kExQqgmQXHhErLkMnHjgzCderI/moPQH50hCxqhgA/kkm/dM53WmBvgwjvC49QEROLbwBZmFLb1U
f59r71jZzYeaZ+vj4KreViWZHn6+tquqVxLsxZ3l4bJxIvSzJK8CdrroTaBeWzHoglV1C/otdJR0
8k33qa8Vycy3My6dtVZxdahAVnXxqhBuJLeVTEs9TdEWb1HxTk6ablnnQMHOsNzOAyuBChYSkWxm
IhfWBDNQPWgKYE51WYj31ce7WhjRi09eDskAAeWxWTTElOtOy4EMAKT8yMyL9hDRki75Oq7FDAZa
Be/4EJIjdC9Dsrz3FJGpXhxgBCBcyDYEPUQZ2yKnQe/rUB1gZz4LslRwrfcRQQqpyBVwB8mUImdP
KssMWI3+fGUIXbBYhAxmDWNdatNG3jSxuWNzE7qc+V4qAXHLGjElCafCkSWBQAK0oqauMc5z2QKC
IcB8GL/uSoQyC5msRwpGifM1cM2BsC8oAqoJyORrnHlthTZhYK8OYTt15mk+e4k4Y7Y1cHjJKi0O
J72fc9cNIYbK0oxc9uRpqBFctsWk7C4mDTg3oGd83QTWSQ50UZ5//c2pMl/ZF9CwigGeD+q/DdDX
baT09nJL0QokLLNrJGZT7fzjwmmqSdUeTGPLKBtxi1H0OYhiTcL7H1I0mlvmP374hKXTHVIETZC5
eiIzrn1z87t9i30yfDHtLYZAZyP+EKIgDNNzzxivZqWXik98gf5bWBUuYKxWjt++joXcx4Ffvrsx
qb63A8kjvCMuS1YneeTd1gJU/DlRjxOUIZTHPUHzTit4AiJ0Py0fvJhokn7Ld6Ai5mzJ4qK0ssYV
9kKY2j9N14zcsQxU/j7mENTkZ8BNkL/iTT8t+Fz1g9nkgLFm3y7vBzgtWQhDdfVOuwv71skIl7uR
ZXxbBciOYhHCO4zlgt5byT2TJ7GfeuhobgZehvdq3Y2wDVut7FNZkRWL1LGl1TmbTOd9Ob/U9BaI
03slLFMCRWB6HGkxb8W5t3aMbV9Nv5lEHDRvla0isezWWoYEd7LXT8gq3DhFXVka5k1E5S71lBVZ
BTEDLEZVqh2dlh+e1wL7Gdp0DDHoSDdR1JKKRShg0O9hjcWHgLCXDBeUwv/6gjpesVkBFztamrUs
eDkH09oMDnNt7QdNZ74AchtjpGP4vyzo6LAtvw4AaUpGNbqHjtqvVll+Hoy5dzSxqX1dgdh4irdQ
DENluGTGZmqrV86T50YL1HjaeZaAfWydloEpF04uRjQ+5Rj6FhNdzrKm420fMLR3fySDCLf/kCKx
aZGU3+jKi601CftJJ5YD48SrsCvHXpmGJaqTgQyTIufR5fTZo3X14Cbk4JHB69awFVlRt7cNXKtR
0LWtRNgciJMTql7S7VP+HWeZKx6px9AXXMkpGKNtx2+c4ytOjhdcwyDHxJVsCPEZ9FF2TDj0ADVY
znC7sAcs3cehFoKsqNTI7N/XMZIpN72Vdon+s19d35SeLNGKJ48uQdrbTITw57tSvBiKezkou9JI
iATjYKjD1lcnwLVIusLY6CmJmVQt2MmL9jroTKeZTL+4uVoGk6zRElPr5tT9i4NEhvctlkqXVJjI
lMqCfYKsw3DPGq3CxiYO5WD6usHUrG3SbdqPRFsOE3F6AL9ow0EwcOtQc50lS4BfS98+SRCxxEO4
2gYs+pFM60N3cctP2PUkqvxPwioeO7GShz921SBsFyj5RykwstBN3aul0Y+meSL92V999GHn2jkU
9Cg11JHBtcmeJs5wLSXOLw7emzloxK3XxHtQSQBoCPZ250tHUBOjD+OVgVDZo74/RFgY9/+UbayP
uCZDn5p5zBv/cTBZtkHDgBdXuEy68nYwP77TwLPMDu76lV+NJivo6tlUZdhPCqGAnAQt1ZlCkAyZ
fwEvLgeyKeLTwinhEU/l/fMUIbWmpQTOli6H/vhAjp7VE7e9tdcWifqm+fo0Ok5y3ILRGDWFxWJb
w8hv/+6CzAnyS6defOvgd9mmIF0apfQ5IvGWxLjHAWoq8bdf1G3XUVmeXZGGx0JJ11ouk12EGim7
U4BMGRKwr+cCIBRkHNKhi39ZXuSNhGnZButqvGd6LiUQWvdQqEwIk6G6br7KQVH9qmKUTdkyqyEM
/EzHBBWgAaSVbIrgZLnkarBTHljGD3RMwY4DxD7EASRBMzIHU8oFebbpIzdeu+DPvPgUnqqp+h2W
l0E32KzLsNXQYwY1T/CExdc1ocw7nn0FV94jWXH6I2xVTccs3JYLfBwySUNEFHBMSeLypTrPVEbM
kpyBEtSndPKrN4GmBKvWWOvCZ3lJ2g+sReMjYZNQ+dBYNf8NqIttW5mzFtJqUmqhLcveAGhkOqfN
99UIZuY4/wEVHPeloVNjy9/Z1G6vH6hAi6Wi+DjzYIJDb3NLG4WQMDIr76yG4cVUTqukIqtvhNwd
Ga/reW78Ws0Dtv7krJ4nHMERllhacgqz8KY1Y0m1GXlz5LJNujyvTU0nbZKk++LqjtVt0AYUlJSi
tw6DEyEbb7ddObSAg8N1w9MqJxhn6h3CBk5misb0BEr6oFTT3SllDVwKeQGo/GUjLh3QT8LSMwtr
DKHVHEE2GZbcc+sKtWE1s48TVH+4X0zmvdmVW4DQPei4NhiZYbPfTUb6qfAIm0taDHk2eEcVdUCP
VZQVpE2fpXEkMZmu60kD547ma95tg2kTo4WssPLAuT2BCs0lidfI7ubJ6w8PGNW2n7ZHFzSyri1U
yr2FcQVuYe1qp1B8BRo8JM4JCt1H+yM65sa9maoNtPoyHevzse9Tj3U7jY7fosf9v3xyCeGVOrm3
15yflOSCxbdjZqEyenXg6bGCHXhzrb6ETsSTRhV2nYe5/2W+4EdTifmb34IxXbyEEYdc2PLl99K9
GH3xFKATpsQmeyked2/Joxf7RzjG48b/j5tD9vY8RYuxUTILYS1ZBR4/xLfUjZ4d3446Md0RheV7
bb0/QmnVakR34W6ZUHxmjclgp4tfj6fN7YBDuMv7Xnc7M6Uy7TxTKDa+QGuByMAAd1SCvWY95bPA
ZdHtYQcVYygUmBFEFQx3ybFzhRHqIKNYxHz+/h3RQ1natYLyQLraKH0j19t3bUP4pnseZeodXu6k
xutH90f7s1e35dA1cdjk6+nUSNZq9LzSLsU60b+uxQxXR6waGERiWI2MH44n6TKNNMrCdS95MOsy
kuK08MPsy5qQGtSEY3SLYNAz2F9+8GRGkOLrgqauXPRGRLl4sSD4TK58Q/ejfCabnskg9oQYVQBy
h81F+3l5l2/7VYN06pn4O+6ALWJz13kqEK/uoPg4PTLm1gORL4rTfkvbru0XYdGXl8puxrZ2s3MS
sI4WnCFMkRg4iU/kdMkQ1H64In5ItmhMitT01YMw6aAmyGsofj4qYm6FDHO/McEi4trAEgM+0vyB
1z1gxjI8TZeLt7HGeMZ3EKr08w9yP2wj3kMIEHLVzOmln6gsBPSYjJjXabNCXXSwoH+smTP5Kglp
/k1gFXEH8fTnLEoq2/Zn0bmvs0IgO41tRtSR3vUao4sGn5w5432p7jLnFMNw5az5pl1lYO2u1+bK
tFuYWbBjoRrdPl884mtYr/AIYYLgfwhNliKAahuuJ7WvbHKGs8iCR7zljpuU3jnfFHrVpyBEM28V
oKHQIRfggWSPifX6h5jberM1WfWSbL2c1Jkeb+FLWcQmN/JPRBnJAuIOnaXkUkjBekm8DAYL7pxj
NMw6OVKzZWPpEHhVQYJ5Kk5xK6sQO8r9ZpgGujetnmv5vVOGizcvVIpNP5zwSzDvx0Cu1tiV7Gtw
lmYzOAGl0uKpNVD28GX9UexkaaP5Ry2GZHgjodAfrULahwrS1MS62LPrMJihy+lAwOKxtUlWYKcs
b9l8UhhhzOwNh/Fer3G0qFnc6FPCqcKST/qYEWA+QK8ycegVwsbnfapWVRqE7YowB5mYmZyj4cgB
gUUkOcv9U1YfF9PPdPWlvpnpc1EPCw4uP1neAcHtdYjgBVmAe7sXdPjPTjYnCG+hDtvO6aPGIvqR
Ix/KoxJLqWMDwkix6cgcQE1LdAcXOoi8n8hGRTepTZHZH6eiN7B+nMWDo5lbRNo/OPiwrs3yac9p
NKutF/LL+6I51/rstLx65N4+VXj3v34DZpiqfCWWtqwov0nEVLF4MvPdS168TNYXB05R0CGC2jPG
a5WNSv01DO0HGVxhNx0HesrkBUryRu2+DaJ3bjwjNPi8PyvBKIswmIw/u1vuEXVJIyfEepAUdy6L
DaM5hGzPtoxL+x/D5uUu0UvKoA0EHcq2E3Cchp5pohxrfRpSyVg+zuGHhuCFG4kx4AWvyD17hB8N
wa0EgKhwQOUoCmYLYz/9Jr8DD3/2Zr/fXGBdrRnKiAAIoPUnzk8PPqqEnBpdPVgbt5Ibg4OjM58k
u6SvOPZ85o2m2gdXVKGQXD+dQvQCjiBb05uLSyQ0Xu+PRV1ZDjeQkN9E/1F4JxCE8q8GVC5ywRXp
vfhzFfeFA/Qv5p2MG3O8OuT42pmSJkzBItU6kzsR0S0nKq73lGZZa1gCO7InfMdoFlfDpicmQQbp
3y4KCLmTTSJ6G/9sDQtZAWyqmbN5aVSB3MVzVntKxGHu9ApZapmueEYywe4De4mNaUXeV7LeUDdN
LV1cOZc8WEjvu+1gsdVU43UAutdSh3akAAB6DKdlOZBdngAB59YB6MQIGwmhcLHEZ/sCAAAAAARZ
Wg==

--pM1j5p9RDJondMxj
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="trinity"

Seeding trinity by 365707 based on vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-r006-20230306
2023-03-14 07:27:11 trinity -q -q -l off -s 365707 -x get_robust_list -x remap_file_pages -N 999999999 -X
Trinity 2019.06  Dave Jones <davej@codemonkey.org.uk>
shm:0x7f4f626bf000-0x7f4f6f2bbd00 (4 pages)
[main] Marking syscall get_robust_list (64bit:274 32bit:312) as to be disabled.
[main] Marking syscall remap_file_pages (64bit:216 32bit:257) as to be disabled.
[main] Using user passed random seed: 365707.
Marking all syscalls as enabled.
[main] Disabling syscalls marked as disabled by command line options
[main] Marked 64-bit syscall remap_file_pages (216) as deactivated.
[main] Marked 64-bit syscall get_robust_list (274) as deactivated.
[main] Marked 32-bit syscall remap_file_pages (257) as deactivated.
[main] Marked 32-bit syscall get_robust_list (312) as deactivated.
[main] 32-bit syscalls: 426 enabled, 3 disabled.  64-bit syscalls: 345 enabled, 91 disabled.
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
[main] Using pid_max = 32768
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] Reserved/initialized 5 futexes.
[main] Added 16 filenames from /dev
[main] Added 14545 filenames from /proc
[main] Added 5253 filenames from /sys
[main] Enabled 14/14 fd providers. initialized:14.
[main] Opened ftrace tracing_on as fd 412
[main] Ftrace log will be dumped to /boot/trace.txt
[child3:744] Tried 8 32-bit syscalls unsuccessfully. Disabling all 32-bit syscalls.
[child3:745] Tried 8 32-bit syscalls unsuccessfully. Disabling all 32-bit syscalls.
[child3:746] Tried 8 32-bit syscalls unsuccessfully. Disabling all 32-bit syscalls.
[child3:747] Tried 8 32-bit syscalls unsuccessfully. Disabling all 32-bit syscalls.
[main] 10423 iterations. [F:7218 S:3104 HI:1827]
[main] 20650 iterations. [F:14430 S:6053 HI:3283]
[child0:1032] Error opening /sys/kernel/debug/tracing/trace : Permission denied
[main] Dumped trace to /boot/trace.txt
[main] kernel became tainted! (512/0) Last seed was 365823
trinity: Detected kernel tainting. Last seed was 365823
[main] exit_reason=7, but 2 children still running.
[main] Bailing main loop because kernel became tainted..
[main] Dumped trace to /boot/trace.txt
[main] Ran 24460 syscalls. Successes: 7218  Failures: 17050
1970-01-01 00:06:44 hwclock --hctosys

--pM1j5p9RDJondMxj--
