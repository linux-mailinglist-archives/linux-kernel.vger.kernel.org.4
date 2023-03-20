Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDCE6C0AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjCTGfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCTGfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:35:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F937DAE;
        Sun, 19 Mar 2023 23:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679294103; x=1710830103;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T9qCgRvOh6Oq6seHW7Qxp3xfrdSQGr7ULULaAsJ+I7c=;
  b=f+rF3J0UJ1/7tHvhxtfzfnPFuTlOv6AMDFU0RZFZldeWpmMUNh+Yxd1g
   L5xe5oIlG+Fu0tbVIXKFWkDh6dTDivVwIJa7YXrNS1fgVkNVZu47RVgeu
   i1l0BY8sWohAOnh0A+xwgQqhMkY2hUEmfBlo1B3CYhLSz6yFEX4JKDhtj
   7VSY97R+QOxl8ZK0mjVSsJqNv+blqVG5C1sz4LuPHQPpWY2S6yBNVDYhM
   wdVgMVCFEjNB16hMcpKtokuAb/Rn+NP8fq0HU2e1XfoFxOy361rxpZAcg
   TyLxYYFd7pGJmQqWitc3GgIdrDBjrqik/G12V9a1wiX1HAxR/+nhaOZo+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="318235670"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="318235670"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 23:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="711202555"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="711202555"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2023 23:34:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 19 Mar 2023 23:34:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 19 Mar 2023 23:34:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 19 Mar 2023 23:34:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 19 Mar 2023 23:34:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk7c7qRx043arhN6BYU2ApfUALv+fZ4SLe9iEARMV4Api2cdXpbK5SLbgloTvh1nfrUyQn2sB3El7Sxsg0z7THPHhzb6a/UpCypAbyi6b03fjChdS24VIiNkAAZYJ29oBJaFuXtsT4aJSDFZOL6JnBCcpCz46P0wmFcwgo/bNVrZpY8cRBMrW0TMeGqRTdMrLeF2E1sEZAWe0qn1af82q51V1swEVLtRKdwtnQYlEskEfTnKGdIv/MsOBWnZWk0ASoWUU0l+BSF3YDGARIMGwcx8c0vKi0L2gCPcQKl48Uwn7c30KBxFnK0EeoK9O+i6Gxtt2nF+YtVwB83DJnXn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgiN2lJfR7E8V8ZhaxSKGYmijp5o9SHPXulrZUwSXhQ=;
 b=JCygMN9wKTXoJFW3ojsfnaUQQZshtXhXspTcYwSjeHCDE+4Ww+ODcTjCbhF+skpR6lCUIZbOt2yQWg57rB5L+7YhVBwqLOEQV3MsWx4Go0aazpgtJMAfAL+PY5yEoOwlvjcGUDLs978oIji5Khq6OM9tZtucUr4pWtMpiyHnUqXh82PPnwiAq3nHiOdz7kVFSlKx8Gwt3YHNCjA/PL6QOOFUUKp9rS2SE+SzrxQvnPHux/xoAb7KXtpeTLGuZKf5A7zPBztek3sS8tj7EPtTYRLlWe+go5v+Nl0Wy62lfKVFSCrNkDjmI1ISqIednSaYExTfK9KyG0ARGqUO3FmhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB5061.namprd11.prod.outlook.com (2603:10b6:510:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 06:34:55 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 06:34:51 +0000
Date:   Mon, 20 Mar 2023 14:34:44 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [mcgrof:20230311-module-alloc-opts] [module] 7e0c0a44ca:
 WARNING:at_kernel/module/internal.h:#find_module_all
Message-ID: <202303201435.e531d292-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="9CmXcXAz9LoeJ0JW"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: a3880207-78bb-435b-771e-08db290d34d7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLB41WT9oktAba1PGJuUiSKsYrP050I7E2RGYLpuAVhHtmF1zi7Sblew0dZoWogJEyNu9ZO3/OymlLDzQRpXIaCxnlhLGi85qgGtHY2Va7v0A+wc25BHiBq0OZfB2AvK8Z8NZRBj43iXwGeFc+qH4sWjUG3McDC3S+8SYwwKxLYje65lBawA6RM7Yto8iDOmPn29MqrjkYl3tX45pxl/QOQbbM4wbmMpT1xM0jyoRib7pS+QSqUqRIs3fdEjhHVO9ztgqp3yQUf15cY7UNKz/khSe+moNLn9hirj01dClkkJNPPP76iw09IDZH9LkSYVjdO6KJ6bWKhAA02VAWQCemUpPe08M2AQNfY++Zx15v1hjOc/3txioZZ8hROe0gJWrPxw7TH3dNbqg0b2Td43jn2IVysotmaMMhUacEVYLefGTmSq/4RzuwJQt38j1UEpMeBcwAMduOqZmJkpbmfkfIvSExWoTc4k0XdTjteFPb6KN7eq/l4IuA73bG4bhlQ1m0d5Jh8OS57nEqfeNYK4kvXUm0ztNGzcYvxg0YrUlHad4bZU1leosSwtESRg5H6REJEIW8UrVDuLqOzY7+r9SPqzQfaGUN9GtId5nTof2AgJC7ObqQPb+LzuCaHUnLNF/CR/WqtixqsNKUDadkojN83gvB82OxsF6Mz+Z04HXSYYtWiQhdPj8INm5qZwI1bHx3MbhvCVj1xtpHvRadf5WZV9ONJk9yD8OoeYELOC+Ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199018)(21490400003)(6666004)(44144004)(6506007)(6512007)(1076003)(26005)(316002)(36756003)(41300700001)(2616005)(966005)(6486002)(186003)(83380400001)(45080400002)(478600001)(86362001)(8676002)(4326008)(66476007)(6916009)(66556008)(66946007)(5660300002)(38100700002)(82960400001)(2906002)(8936002)(235185007)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KCw/kpHYT6MfydF07aC7JRS8t2Hhzb9SqniWHi0XD7RIZGscM45iKYvNg5Oc?=
 =?us-ascii?Q?nZeZSrxKsbz+EAtgXWROxeCtfRuFTV7WS1b5ynA1LvLfCvEesD253mSroFp3?=
 =?us-ascii?Q?aft7mg9lJUz4sKg7Pe3x3Ll4LRgcOXc4CXvn1pzilNnlBFgvcIjGALAKmKkn?=
 =?us-ascii?Q?3u1jaP14JjRjeedtS8Dleap0BWUWCh4s17VA0+7zqOJ16/xw1Nktgdv30laJ?=
 =?us-ascii?Q?bKzOEWEjbFjOocLcPq1WCCUSB78TGTU01Uoz6jt8ZC0c7u929Kj/NDsnzKOk?=
 =?us-ascii?Q?b5YSXblvaAxmfe6Ygw9iHtf3O2ZaL3WjkUFdBaU+rnZ+Bl/OQp9Gs8shEzNG?=
 =?us-ascii?Q?BR9G/6Akw4pukV0sH/WGVq6OQQH8J+s4usbjB5k0DrYMk/Ofpml/rtVSNgR5?=
 =?us-ascii?Q?QN5FYOK1AP4SlTAfMhEtYWbLrOi1RXfLE+vlabxtlvQ/PhOcLe/ntnSc2XG1?=
 =?us-ascii?Q?ZqpJX3wym5sdX4ME0xEh6at6hWh5xwMSQgphc9/QAMeSQ59Gft1mm7FpXmqG?=
 =?us-ascii?Q?Jz8QTffpO17b7JunHSCn0F0TidPDN10JtQb+KYM5uYlcVx/iBRDFtYdNIpNf?=
 =?us-ascii?Q?jkTxl6EUgb2xrsp06BmAg7srYiA5FaSWJSr4s7sss6Dn8+IJt7PTcAwg/BPu?=
 =?us-ascii?Q?o8H4lBtzrIjbteWAY7lqZHWml4S8cSct9KUmqtO0GGLk58JtXF7Mwx+BKR6l?=
 =?us-ascii?Q?ZY00TJGUWIQJebvA/KH/OmD++qN7BywzbVRrG2BRMZ4BTqEC+vJRpEoS5+MY?=
 =?us-ascii?Q?kgy+RIzh9wxDCrJ8W2EZmUB4ItweVk2gbxx54+6LAahOK14dox59H1abpz7p?=
 =?us-ascii?Q?qPp0tRFei1dRubumWMfNbkGadNib1JmfGcktbD/YTZl/Q2piQi/snimG0RYm?=
 =?us-ascii?Q?hiQSKHq1mo+BCT0mU72WaL6dLUYAR/0qtLaI8BEB2+89ZFjn/Oq/SgN7F6Y/?=
 =?us-ascii?Q?nyMK/ctvU8BY2vXswcbr/P1HzthfyNpXyOIte6PdFpGY6cdlWcZ5ODji7mIZ?=
 =?us-ascii?Q?NBdXslYaU+NBnYHNsQhgQ5tSUDzl39V6enWycd9gWHvkHhO6mCE6CHdiogkZ?=
 =?us-ascii?Q?WM8LUUqWrgmVZYuGcYozAAAL/RZY8MLJkHesjQ2S3XzeV5MHR2vCyMI0/NXg?=
 =?us-ascii?Q?EsBkOdOSZ/qy8Cug/4fEN8t/dteLODmQB/lZNiNf9x5fASpCRK6ggd1Rm/ci?=
 =?us-ascii?Q?FlH6RUPEXorRg9pgOmCGN1oI9dXyuwLMjmAtWRy+1NjLQuloDDdmLvcd/5i3?=
 =?us-ascii?Q?WoI+LXsercTwX4NnrafVmn1wsgh4sfMdF3eNAdmFS3O6h3aHnWVy9EiAU2ga?=
 =?us-ascii?Q?okE790hQ0KCLzCPlAz/eEyLC4ukFcRAudOooau/VU1ba4phdqee5nEE97G6s?=
 =?us-ascii?Q?VzTf+W+tUstgIS8hjYa9Tq6TICjEXgUl+hnxyh11HpFdUuAYA36Z3VamBD4L?=
 =?us-ascii?Q?lxWr3aDqQ1lv9NUWAyoOIrVM++3Do3D8ucUJUvnN9lygg4Akfz2YuT/wGspc?=
 =?us-ascii?Q?yH1LjdigWw00dzGSlEYLRK3Bb/1ugmRCwwlq46yK3g5ie65/AcJsm+rD89T0?=
 =?us-ascii?Q?oUU+g8e7H+wfG8xOH2udrA9YgJhRBIvPshYLt5C7WDCdmyNY10EU7gzGMziI?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3880207-78bb-435b-771e-08db290d34d7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 06:34:50.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYjWnqxmMaFNmV7++4YwzcMkcJdzhBkFmvJ/o8d55opfYrMFvyDBFQf4JyhgKTDl1B/USAorb65OXGTnS4zEkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5061
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

--9CmXcXAz9LoeJ0JW
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed WARNING:at_kernel/module/internal.h:#find_module_all due to commit (built with gcc-11):

commit: 7e0c0a44cae2595beda2f4fb1af9118eb50c7526 ("module: avoid allocation if module is already present and ready")
https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux.git 20230311-module-alloc-opts

in testcase: kernel-selftests
version: kernel-selftests-x86_64-d4cf28ee-1_20230110
with following parameters:

	group: sgx

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+------------------------------------------------------+------------+------------+
|                                                      | 62f6f89a67 | 7e0c0a44ca |
+------------------------------------------------------+------------+------------+
| boot_successes                                       | 6          | 0          |
| boot_failures                                        | 0          | 6          |
| WARNING:at_kernel/module/internal.h:#find_module_all | 0          | 6          |
| RIP:find_module_all                                  | 0          | 6          |
| WARNING:bad_unlock_balance_detected                  | 0          | 6          |
+------------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202303201435.e531d292-oliver.sang@intel.com


[   38.890941][    T1] ------------[ cut here ]------------
[ 38.896344][ T1] WARNING: CPU: 2 PID: 1 at kernel/module/internal.h:112 find_module_all (kernel/module/internal.h:112 kernel/module/main.c:350) 
[   38.905714][    T1] Modules linked in:
[   38.909512][    T1] CPU: 2 PID: 1 Comm: systemd Not tainted 6.3.0-rc1-00019-g7e0c0a44cae2 #1
[   38.918002][    T1] Hardware name: Intel Corporation Mehlow UP Server Platform/Moss Beach Server, BIOS CNLSE2R1.R00.X188.B13.1903250419 03/25/2019
[ 38.931176][ T1] RIP: 0010:find_module_all (kernel/module/internal.h:112 kernel/module/main.c:350) 
[ 38.936615][ T1] Code: 45 31 e4 5b 5d 4c 89 e0 41 5c 41 5d 41 5e 41 5f c3 be ff ff ff ff 48 c7 c7 48 cf bf 84 e8 dd 2d 4c 02 85 c0 0f 85 26 ff ff ff <0f> 0b e9 1f ff ff ff e8 59 28 5a 00 e9 4e ff ff ff e8 1f 1b 5a 00
All code
========
   0:	45 31 e4             	xor    %r12d,%r12d
   3:	5b                   	pop    %rbx
   4:	5d                   	pop    %rbp
   5:	4c 89 e0             	mov    %r12,%rax
   8:	41 5c                	pop    %r12
   a:	41 5d                	pop    %r13
   c:	41 5e                	pop    %r14
   e:	41 5f                	pop    %r15
  10:	c3                   	retq   
  11:	be ff ff ff ff       	mov    $0xffffffff,%esi
  16:	48 c7 c7 48 cf bf 84 	mov    $0xffffffff84bfcf48,%rdi
  1d:	e8 dd 2d 4c 02       	callq  0x24c2dff
  22:	85 c0                	test   %eax,%eax
  24:	0f 85 26 ff ff ff    	jne    0xffffffffffffff50
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 1f ff ff ff       	jmpq   0xffffffffffffff50
  31:	e8 59 28 5a 00       	callq  0x5a288f
  36:	e9 4e ff ff ff       	jmpq   0xffffffffffffff89
  3b:	e8 1f 1b 5a 00       	callq  0x5a1b5f

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 1f ff ff ff       	jmpq   0xffffffffffffff26
   7:	e8 59 28 5a 00       	callq  0x5a2865
   c:	e9 4e ff ff ff       	jmpq   0xffffffffffffff5f
  11:	e8 1f 1b 5a 00       	callq  0x5a1b35
[   38.956135][    T1] RSP: 0018:ffffc9000004fab8 EFLAGS: 00010246
[   38.962100][    T1] RAX: 0000000000000000 RBX: 1ffff92000009f5f RCX: 0000000000000001
[   38.969976][    T1] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffffffff84bfcf48
[   38.977857][    T1] RBP: 0000000000000009 R08: 0000000000000000 R09: ffffc90002309fb0
[   38.985725][    T1] R10: dffffc0000000000 R11: 0000000000000001 R12: dffffc0000000000
[   38.993595][    T1] R13: 0000000000000001 R14: ffffc900022d6c18 R15: ffffc900022c9000
[   39.001464][    T1] FS:  00007f8a51fb3040(0000) GS:ffff8887ed700000(0000) knlGS:0000000000000000
[   39.010295][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.016791][    T1] CR2: 00007f8a52af49f0 CR3: 00000008769e8002 CR4: 00000000003706e0
[   39.024682][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   39.032570][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   39.040446][    T1] Call Trace:
[   39.043629][    T1]  <TASK>
[ 39.046464][ T1] module_patient_check_exists (kernel/module/main.c:2564) 
[ 39.052086][ T1] ? finished_loading (kernel/module/main.c:2559) 
[ 39.056834][ T1] ? get_next_modinfo (kernel/module/main.c:1058) 
[ 39.061758][ T1] ? __x64_sys_sendfile (fs/read_write.c:405) 
[ 39.066851][ T1] ? check_modinfo (kernel/module/main.c:1066 kernel/module/main.c:2006) 
[ 39.071517][ T1] ? early_mod_check (kernel/module/main.c:2713) 
[ 39.076352][ T1] load_module (kernel/module/main.c:2766) 
[ 39.080761][ T1] ? post_relocation (kernel/module/main.c:2729) 
[ 39.085600][ T1] ? __x64_sys_fspick (fs/kernel_read_file.c:38) 
[ 39.090530][ T1] ? __do_sys_finit_module (kernel/module/main.c:2991) 
[ 39.095888][ T1] __do_sys_finit_module (kernel/module/main.c:2991) 
[ 39.101068][ T1] ? __ia32_sys_init_module (kernel/module/main.c:2959) 
[ 39.106351][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4529) 
[ 39.112845][ T1] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 39.117172][ T1] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   39.122958][    T1] RIP: 0033:0x7f8a52b195a9
[ 39.127272][ T1] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 08 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 27 08 0d 00 	mov    0xd0827(%rip),%rcx        # 0xd0861
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 27 08 0d 00 	mov    0xd0827(%rip),%rcx        # 0xd0837
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[   39.146794][    T1] RSP: 002b:00007ffc529dd768 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   39.155103][    T1] RAX: ffffffffffffffda RBX: 000055fb53a182a0 RCX: 00007f8a52b195a9
[   39.162980][    T1] RDX: 0000000000000000 RSI: 00007f8a529abefd RDI: 0000000000000004
[   39.170860][    T1] RBP: 00007f8a529abefd R08: 0000000000000000 R09: 000055fb53a1aeb0
[   39.178737][    T1] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000020000
[   39.186615][    T1] R13: 0000000000000000 R14: 000055fb53a19c90 R15: 00007f8a52fc39b0
[   39.194502][    T1]  </TASK>
[   39.197428][    T1] irq event stamp: 3344063
[ 39.201747][ T1] hardirqs last enabled at (3344075): __up_console_sem (arch/x86/include/asm/irqflags.h:42 (discriminator 1) arch/x86/include/asm/irqflags.h:77 (discriminator 1) arch/x86/include/asm/irqflags.h:135 (discriminator 1) kernel/printk/printk.c:345 (discriminator 1)) 
[ 39.211276][ T1] hardirqs last disabled at (3344086): __up_console_sem (kernel/printk/printk.c:343 (discriminator 1)) 
[ 39.220808][ T1] softirqs last enabled at (3344010): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:415 kernel/softirq.c:600) 
[ 39.230161][ T1] softirqs last disabled at (3344107): __irq_exit_rcu (kernel/softirq.c:445 kernel/softirq.c:650) 
[   39.239695][    T1] ---[ end trace 0000000000000000 ]---
[ 39.247049][ T1] calling ip_tables_init+0x0/0x1000 [ip_tables] @ 1 
[ 39.253677][ T1] initcall ip_tables_init+0x0/0x1000 [ip_tables] returned 0 after 43 usecs 


[ 40.050683][ T215] calling drm_core_init+0x0/0x120 [drm] @ 215 
.
Star[   40.056380][  T217] fuse: init (API version 7.38)
[ 40.070259][ T217] initcall fuse_init+0x0/0x2d0 [fuse] returned 0 after 7799 usecs 
[ 40.535901][ T239] calling init_misc_binfmt+0x0/0x1000 [binfmt_misc] @ 239 
[ 40.543017][ T239] initcall init_misc_binfmt+0x0/0x1000 [binfmt_misc] returned 0 after 4 usecs 
[ 43.526064][ T296] calling acpi_pad_init+0x0/0x1000 [acpi_pad] @ 296 
[ 43.527853][ T309] calling acpi_power_meter_init+0x0/0xfe0 [acpi_power_meter] @ 309 
[ 43.533399][ T296] initcall acpi_pad_init+0x0/0x1000 [acpi_pad] returned 0 after 765 usecs 
[ 43.550142][ T275] calling acpi_tad_driver_init+0x0/0x1000 [acpi_tad] @ 275 
[   43.551753][  T316]
[ 43.552553][ T295] calling acpi_cpufreq_init+0x0/0xd80 [acpi_cpufreq] @ 295 
[ 43.552563][ T295] initcall acpi_cpufreq_init+0x0/0xd80 [acpi_cpufreq] returned -17 after 0 usecs 
[   43.575694][  T316] =====================================
[   43.579882][  T309] power_meter ACPI000D:00: Found ACPI power meter.


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



--9CmXcXAz9LoeJ0JW
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.3.0-rc1-00019-g7e0c0a44cae2"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.3.0-rc1 Kernel Configuration
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
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
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
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
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
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
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
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
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
CONFIG_SCHED_MM_CID=y
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
CONFIG_EMBEDDED=y
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
CONFIG_X86_MSR=y
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
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
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
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
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
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_X86_SGX_KVM is not set
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
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
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
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
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y
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
# CONFIG_MODULE_DEBUG is not set
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
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
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
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB_DEPRECATED is not set
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
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
# CONFIG_CMA is not set
CONFIG_MEM_SOFT_DIRTY=y
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
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_DBGFS=y
# CONFIG_DAMON_RECLAIM is not set
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
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
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
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
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
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
CONFIG_NF_CONNTRACK_OVS=y
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
CONFIG_NFT_FLOW_OFFLOAD=m
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
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
# CONFIG_NF_FLOW_TABLE_PROCFS is not set
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
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=y
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
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_MQPRIO_LIB=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=m
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
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
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
CONFIG_NET_ACT_GATE=m
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
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
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
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
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
CONFIG_NFC_VIRTUAL_NCI=m
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
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
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
CONFIG_PCI_HYPERV=m
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
CONFIG_PCI_HYPERV_INTERFACE=m

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
CONFIG_FW_UPLOAD=y
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
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
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
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
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
CONFIG_HYPERV_STORAGE=m
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
# CONFIG_PATA_PARPORT is not set

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
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_AMT=m
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
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
# CONFIG_MICROSOFT_MANA is not set
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
# CONFIG_NCN26000_PHY is not set
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
# CONFIG_ATH12K is not set
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
# CONFIG_MAC80211_HWSIM is not set
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
CONFIG_HYPERV_NET=y
CONFIG_NETDEVSIM=m
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
CONFIG_HYPERV_KEYBOARD=m
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
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_PCI1XXXX=y
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
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
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
# CONFIG_SENSORS_MC34VR500 is not set
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
# CONFIG_SENSORS_MPQ7932 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TDA38640 is not set
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
CONFIG_THERMAL_ACPI=y
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
CONFIG_INTEL_TCC=y
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
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
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
CONFIG_IR_SHARP_DECODER=m
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
CONFIG_RC_LOOPBACK=m
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
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
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

CONFIG_DRM_VGEM=m
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
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
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
# CONFIG_DRM_HYPERV is not set
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
CONFIG_FB_HYPERV=m
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
# CONFIG_BACKLIGHT_KTZ8866 is not set
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
CONFIG_HID_SUPPORT=y
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
# CONFIG_HID_EVISION is not set
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
CONFIG_HID_HYPERV_MOUSE=m
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
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set

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
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
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
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
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
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
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
CONFIG_UIO_HV_GENERIC=m
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
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
# CONFIG_EFI_SECRET is not set
CONFIG_TDX_GUEST_DRIVER=m
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
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
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
# CONFIG_LTE_GDM724X is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
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
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
CONFIG_IOMMUFD=m
CONFIG_IOMMUFD_TEST=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
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

# CONFIG_WPCM450_SOC is not set

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
CONFIG_IDLE_INJECT=y
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
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
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
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
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
CONFIG_NETFS_SUPPORT=m
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
CONFIG_PROC_CPU_RESCTRL=y
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
# CONFIG_MINIX_FS is not set
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
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
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
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
CONFIG_SUNRPC_DEBUG=y
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
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
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
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
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
CONFIG_SECURITY_LANDLOCK=y
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
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
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
CONFIG_GCC_PLUGIN_STACKLEAK=y
# CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE is not set
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
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
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
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
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
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
CONFIG_INTERVAL_TREE_SPAN_ITER=y
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
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
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
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
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
CONFIG_SLUB_DEBUG_ON=y
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
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
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
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
# CONFIG_DEBUG_MAPLE_TREE is not set
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
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
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
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
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
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
# CONFIG_SAMPLE_FTRACE_OPS is not set
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
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
CONFIG_LKDTM=y
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
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
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
# CONFIG_TEST_DYNAMIC_DEBUG is not set
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--9CmXcXAz9LoeJ0JW
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export need_memory='3G'
	export job_origin='kernel-selftests-sgx.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-cfl-e1'
	export tbox_group='lkp-cfl-e1'
	export submit_id='6417e0f4b313dc13428764d4'
	export job_file='/lkp/jobs/scheduled/lkp-cfl-e1/kernel-selftests-sgx-debian-12-x86_64-20220629.cgz-7e0c0a44cae2595beda2f4fb1af9118eb50c7526-20230320-70466-1pgol70-3.yaml'
	export id='20bbe58b65ea5700b236a1c3cfd311078b0e936f'
	export queuer_version='/zday/lkp'
	export model='Coffee Lake'
	export nr_node=1
	export nr_cpu=16
	export memory='32G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part2'
	export swap_partitions='LABEL=SWAP'
	export rootfs_partition='/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part1'
	export brand='Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz'
	export commit='7e0c0a44cae2595beda2f4fb1af9118eb50c7526'
	export ucode='0xf0'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"IGB"=>"y"}
SATA_AHCI'
	export bisect_dmesg=true
	export need_kconfig='{"BLOCK"=>"y"}
{"BTRFS_FS"=>"m"}
{"EFI"=>"y"}
EFIVAR_FS
{"FTRACE"=>"y"}
{"IP_ADVANCED_ROUTER"=>"y"}
{"IP_MULTIPLE_TABLES"=>"y"}
RC_CORE
{"RC_DECODERS"=>"y"}
{"RC_DEVICES"=>"y"}
{"RC_LOOPBACK"=>"m"}
{"RUNTIME_TESTING_MENU"=>"y"}
{"STAGING"=>"y"}
{"SYNC_FILE"=>"y"}
TEST_FIRMWARE
{"TEST_KMOD"=>"m"}
{"TEST_LKM"=>"m"}
TEST_USER_COPY
{"TUN"=>"m"}
{"XFS_FS"=>"m"}
{"GPIO_CDEV"=>"y"}
OVERLAY_FS
{"PERF_EVENTS"=>"y"}
{"SCHED_DEBUG"=>"y"}
{"SHMEM"=>"y"}
{"TMPFS_XATTR"=>"y"}
{"TMPFS"=>"y"}'
	export rootfs='debian-12-x86_64-20220629.cgz'
	export initrds='linux_headers
linux_selftests'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export enqueue_time='2023-03-20 12:28:36 +0800'
	export _id='6417e0f4b313dc13428764d4'
	export _rt='/result/kernel-selftests/sgx/lkp-cfl-e1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='ba81728f619143afe6918c3cf20c8680ffb46705'
	export base_commit='eeac8ede17557680855031c6f305ece2378af326'
	export branch='mcgrof/20230311-module-alloc-opts'
	export result_root='/result/kernel-selftests/sgx/lkp-cfl-e1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-12-x86_64-20220629.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/sgx/lkp-cfl-e1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/vmlinuz-6.3.0-rc1-00019-g7e0c0a44cae2
branch=mcgrof/20230311-module-alloc-opts
job=/lkp/jobs/scheduled/lkp-cfl-e1/kernel-selftests-sgx-debian-12-x86_64-20220629.cgz-7e0c0a44cae2595beda2f4fb1af9118eb50c7526-20230320-70466-1pgol70-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=7e0c0a44cae2595beda2f4fb1af9118eb50c7526
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230110.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-d4cf28ee-1_20230110.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20221125.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.3.0-rc2-wt-ath-04570-ga0f50aba5c73'
	export repeat_to=6
	export stop_repeat_if_found='last_state.load_disk_fail'
	export kbuild_queue_analysis=1
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/vmlinuz-6.3.0-rc1-00019-g7e0c0a44cae2'
	export dequeue_time='2023-03-20 13:05:18 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-cfl-e1/kernel-selftests-sgx-debian-12-x86_64-20220629.cgz-7e0c0a44cae2595beda2f4fb1af9118eb50c7526-20230320-70466-1pgol70-3.cgz'

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

	run_test group='sgx' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='sgx' $LKP_SRC/stats/wrapper kernel-selftests
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

--9CmXcXAz9LoeJ0JW
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
8RGDyjm6scRn+wIAAAAABFla

--9CmXcXAz9LoeJ0JW
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kernel-selftests"

reboot: Restarting system

--9CmXcXAz9LoeJ0JW
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests-sgx.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
need_memory: 3G
kernel-selftests:
  group: sgx
job_origin: kernel-selftests-sgx.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-cfl-e1
tbox_group: lkp-cfl-e1
submit_id: 64178c1cb87e2476d7dddbd8
job_file: "/lkp/jobs/scheduled/lkp-cfl-e1/kernel-selftests-sgx-debian-12-x86_64-20220629.cgz-7e0c0a44cae2595beda2f4fb1af9118eb50c7526-20230320-95959-icy12n-0.yaml"
id: bb921f7b1a6e67f98051f84a9f796a2041fb9d50
queuer_version: "/zday/lkp"

#! /db/releases/20230317222837/lkp-src/hosts/lkp-cfl-e1
model: Coffee Lake
nr_node: 1
nr_cpu: 16
memory: 32G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part2"
swap_partitions: LABEL=SWAP
rootfs_partition: "/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part1"
brand: Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz

#! /db/releases/20230317222837/lkp-src/include/category/functional
kmsg:
heartbeat:
meminfo:

#! /db/releases/20230317222837/lkp-src/include/queue/cyclic
commit: 7e0c0a44cae2595beda2f4fb1af9118eb50c7526

#! /db/releases/20230317222837/lkp-src/include/testbox/lkp-cfl-e1
ucode: '0xf0'
need_kconfig_hw:
- PTP_1588_CLOCK: y
- IGB: y
- SATA_AHCI
bisect_dmesg: true

#! /db/releases/20230317222837/lkp-src/include/kernel-selftests
need_kconfig:
- BLOCK: y
- BTRFS_FS: m
- EFI: y
- EFIVAR_FS
- FTRACE: y
- IP_ADVANCED_ROUTER: y
- IP_MULTIPLE_TABLES: y
- RC_CORE
- RC_DECODERS: y
- RC_DEVICES: y
- RC_LOOPBACK: m
- RUNTIME_TESTING_MENU: y
- STAGING: y
- SYNC_FILE: y
- TEST_FIRMWARE
- TEST_KMOD: m
- TEST_LKM: m
- TEST_USER_COPY
- TUN: m
- XFS_FS: m
- GPIO_CDEV: y
- OVERLAY_FS
- PERF_EVENTS: y
- SCHED_DEBUG: y
- SHMEM: y
- TMPFS_XATTR: y
- TMPFS: y
rootfs: debian-12-x86_64-20220629.cgz
initrds:
- linux_headers
- linux_selftests
kconfig: x86_64-rhel-8.3-kselftests
enqueue_time: 2023-03-20 06:26:37.195188890 +08:00
_id: 64178c1cb87e2476d7dddbd8
_rt: "/result/kernel-selftests/sgx/lkp-cfl-e1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: ba81728f619143afe6918c3cf20c8680ffb46705
base_commit: eeac8ede17557680855031c6f305ece2378af326
branch: linux-devel/devel-hourly-20230317-025233
result_root: "/result/kernel-selftests/sgx/lkp-cfl-e1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-12-x86_64-20220629.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/sgx/lkp-cfl-e1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/vmlinuz-6.3.0-rc1-00019-g7e0c0a44cae2
- branch=linux-devel/devel-hourly-20230317-025233
- job=/lkp/jobs/scheduled/lkp-cfl-e1/kernel-selftests-sgx-debian-12-x86_64-20220629.cgz-7e0c0a44cae2595beda2f4fb1af9118eb50c7526-20230320-95959-icy12n-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=7e0c0a44cae2595beda2f4fb1af9118eb50c7526
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230110.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-d4cf28ee-1_20230110.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20221125.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01

#! /db/releases/20230318184241/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.3.0-rc2
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/7e0c0a44cae2595beda2f4fb1af9118eb50c7526/vmlinuz-6.3.0-rc1-00019-g7e0c0a44cae2"
dequeue_time: 2023-03-20 06:48:10.814687764 +08:00

#! /db/releases/20230319113320/lkp-src/include/site/lkp-wsx01
job_state: load_disk_fail

--9CmXcXAz9LoeJ0JW--
