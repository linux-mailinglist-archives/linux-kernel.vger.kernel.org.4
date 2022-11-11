Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4B6625425
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiKKG40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKG4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:56:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB936742E9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668149763; x=1699685763;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=p0TQkJzSIjZZtfDy4CGxGWwRuQAw50437eZulxE3ddc=;
  b=i5r0vQmkEoWI56z035KsQ63U4GFK14ynywu7qALcIEEahywbA+GQJgfl
   S7h0SsHXUGvTmEVC5OUKknbl+Rk5/TAG+tP6TBjGItvZ8xeumPajd43bT
   AmyPaEq82UHp5NeGc9QoxJXEJxjSDQmhaboOAq2ND1JmC2GraA6oRVA7l
   Nut4iAOXRCCTfDb/enCFnalUHWtVVSJh5QFmeRrDrfrvVepxIceidzk6B
   URVFJk5v4f28Qt4IsD8Xc/96nNvoaJClWl0CaXBlMToTOD97V5KuPlszP
   4IQyeqshh5GpTRZjG4wH4fPOTS8wFXSIlfSd1oePcU0emcn0Pieexyc8Q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="299050092"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="xz'?yaml'?scan'208";a="299050092"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 22:56:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="706450144"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="xz'?yaml'?scan'208";a="706450144"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2022 22:56:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 22:56:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 22:56:00 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 10 Nov 2022 22:56:00 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 10 Nov 2022 22:55:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRWMu+fMRd3HjM2sLhHnXARMzy9HqwyxLhnxsf/ZjUjf3ViAjUqzRrKa18owJ0a05PY5Rw/ViCbhxu6ahws/KlKOin+/BgPaJLTdGM7d+FZwYufe1FMnc1Z8pPAnbvxKzSL+wU+S2A3vLLD58ECazSm3qitx0MhJOGf2FN1K8BKFv4meCD/jayHVXjxlcbJ246AVwCDuOfKbOtDGdEMF/8BW1cVzsFiWUKGZtnsTl1UB9qpaZECgz+3QlSk0mNnhytJGB9AxBWP2uWXiqe2qp3aYUGnFeV7HJrrefDzKJzixlnaU4/GwU4x+PWV2JarxUeEPQejd+avXpqpjkHzZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz2L5hqvAoIMYzQlGE7QV9YpZ5IbIxELLpYgJXN4YdA=;
 b=O4gbzOsYx17AtqPmB5PwARC8OmssBQeUO7MkSJ6mYhmRbHC8re7XlFr4Q60IY9OQflg4DdrQt22OCpt1ZuGNM89aBv1amzGN5/3bvA3hVwqGuKOk+oHxNy2ac3pxtsK8QrCmgAky8TOXjJFGcXlkdXX5xamxbSP8zrsMJPlTHacy5NO2KPeJlih0Azqn4i/U/UrbZXG5ao3cNUo3IGvF7CSf51oOCJ721Y3c/76Gf6QKew4MPvT5lAeb1kfr5EmqsurPN+howEBuHImHIyymEvLMLNr1HUgTjZ4uef+ipZOx2bMJsRuqe8BRV8m2lvjqbfxcZZG3mLtXfHU7GxhKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Fri, 11 Nov
 2022 06:55:49 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d%9]) with mapi id 15.20.5791.024; Fri, 11 Nov 2022
 06:55:49 +0000
Date:   Fri, 11 Nov 2022 14:54:01 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <ltp@lists.linux.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 2/6] bitmap: replace _reg_op(REG_OP_ALLOC) with
 bitmap_set()
Message-ID: <202211111357.9e363da2-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="TR9O495S4ait0Bbo"
Content-Disposition: inline
In-Reply-To: <20221028014834.572819-3-yury.norov@gmail.com>
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|BL1PR11MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f3eca8-aefc-4658-0341-08dac3b1c3aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbbwvAW4Bck4mMP6CniuSWouMpc7IwhtnSwlb0pkwONhKb6J9BYKcBnBBfMMpwJ6g2z6ELbi36ZK6gt9gIGpsgRPV0YtRrXUpMDtbAYn+Igu/WQZ1IrPMmpmkhHryfi5hAJWJT8JwZ3+D7XU/9hPSRWPv+rVotAlpdPd034eX4jI/Hjw4OB9ud9/1IjQMOYt/qJ25n5K/epHAWFd80mt87XcE0unVCPvpJjWNaBxqhHqiACkw2of72KRFEQxeFASJiwTt8kj3IarikGXRDdV/AQvFiU/EYOK/II+gnBsm/XBSkzVlb8piYXX/JPbRfFlMK9VwEFVKfE+um9WulS+ds7MoUswIgDSI+96ahW+50iO6xYfDWPD6WAnYNoycqq5SaMxIr6Pu7HCbBhQlCdWOmnhFQTFtG629+fJumzcUCIYzf2AdNpF+iF2OU2WqKIpfWFf6NvOmCqOETurfQYsGo9mKNBU0bmH4G5ArfnXrfWjPscYrlxToHc8ErlSmOk1is23GqwdTmmgCthxVDFbreWHTT319wyniIGIxP4MgX7kwxyZoECH6P7IlPhZln89SOKvGuyaia7DrhHrOTosn6QAkrx3MkfcZNx/JLaonUmjetPZ3/pgHKa8Js6u8WIHaJxb2ZkvNeb6yosPPyx9XeDkzbPYOmNZTHoXntnbHX4rfI9TQxShCgyA6JWyZv0lNxsPEmCSq3qpS7aNCud41TG02voCY4dzjRLfeTK6HNFUDtYeQERpXvHMmjhxmf6yZ9pfAwuOZKxDtqm+cSuo0JWsf39ueInOHVtk2RCHXm+AboKIcWuqwKsvnJ9+u5AzU6Uv+VQ5srQAWP7lu6ijSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(5660300002)(235185007)(1076003)(186003)(8936002)(2616005)(26005)(6666004)(54906003)(44144004)(6916009)(6506007)(316002)(6512007)(41300700001)(86362001)(66946007)(4326008)(8676002)(66476007)(66556008)(21490400003)(478600001)(83380400001)(82960400001)(38100700002)(36756003)(966005)(6486002)(2906002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8JhccF8/DV50ssVhxj755UlKdWx9f7NN3UfPmwyQcTzFkxjMzBfcLKJo6pE2?=
 =?us-ascii?Q?jiVORPmm76FKEjlHmqH5+O8zM+M4MmD+IDZ4Q/OD4LId/VpcIEzEzGAnIxp2?=
 =?us-ascii?Q?fXqMsNbeCj2Si0VT9XCwZrZJ68crN92wnPgok2+II6jZ4eO+CFKT9lt3IPTy?=
 =?us-ascii?Q?v74FvTFQ/vrp5WnyX696X1Xl9LkrYxuGAZxW4VfqIichbxflY2yBuNEnfjph?=
 =?us-ascii?Q?Beq/vhDJNzhHJ3aTvRY85SJvq1cnQzUrv+WG0c9a8r5EfOCQf/M/VAc0puI4?=
 =?us-ascii?Q?7tA3wciNRA4g+rWT9whwBcsDPeYcSO9e6dCe4nzp+jR6GTChUO4mLjUNn/9o?=
 =?us-ascii?Q?bYcRaWEIGW+aPplwkAOcQyK4ZnOTBTBZ4j/qLoWrI2f7m0CYQwXk/Z8D4V6D?=
 =?us-ascii?Q?tPXGAPSLzqVMn5ujq1cCjV8glFRoqkkPYV43fYcnh+IrQuSk/AHwLLZILqZp?=
 =?us-ascii?Q?itgRPbkSbw9jJ7U3G5f9ExFYp34kOv1LObEgbeyOdA7WUWXeYGLamM4HTp4W?=
 =?us-ascii?Q?T/Z7LmHiiHPaHJoVpwf4qJI2iL4CxqqHST2wY37QFS4aegSiKsdcfO3YiGeL?=
 =?us-ascii?Q?3iFX4Q1utZ4rcastYyUUlWu9jJPJ7I1+FRy2XK+YEBpFfacVQ7o8VqN2+r80?=
 =?us-ascii?Q?OxUK5gIEnZa3SXsS1c2dBTFB4pFjj0V8A8zjWGq4ZkwTuq6nuka1cI4IhVV3?=
 =?us-ascii?Q?FTAkpwa7Mgoy88a2ecip2TjMVWDF/mAcoT7jmq+GTnBVGEbzDuLGnSrosGN7?=
 =?us-ascii?Q?HrPHIPBMFJ/Ujv+gBZLxWRkEvs7J+A3t9zQ0usJ0NC//QeKHzc3BvtWl7sgS?=
 =?us-ascii?Q?c+plSffXgY7GitM01+37EO6+yRN0es6SuuCOD5B2n5zkNon5rbr84xNOk0qH?=
 =?us-ascii?Q?cTbHoZnBhpAUUfXxQ5mjThvIpYVrxBe6Np7gYEiic/Uwwvt6HIZzDOndlE44?=
 =?us-ascii?Q?qEBPVfDFUa6zmCX4KbdLd53kKaJVsQYxzhC96wRjIxUH6+UDQc1WzkPkV/rZ?=
 =?us-ascii?Q?2F0QtFhjVFkS3QfIh7lzAELz5gOCwP0WfIzRRJg9qlb5fb3PT0tmKJ8XoKh1?=
 =?us-ascii?Q?oCy73Dy0ha+8E02jIpvMqIHcenRNkib7YX3ew9EoQc3rBHh93PWnSuuy1SNf?=
 =?us-ascii?Q?TXblzXPpmjHu7WH8DHNx10GnRmsqQCtdFlb/SSLi99lQa5nrcCHCBwJzCfY7?=
 =?us-ascii?Q?vO9OvHfDmUPSG/YEHzVfME0h/hIL9EWdv4yskHrTF6yMX+eR1JzY3ABxTS+x?=
 =?us-ascii?Q?yncLfcR2QXLOEVddJX8rWl5HCSdm5gQgyjtZE0OwpQHtsTv08Qs1XUTBhz8S?=
 =?us-ascii?Q?JTGYB5Q+GbkOXvtLj5jLvTNu/2B54CogvW5GNY9i3m1/+/4kSUQ0+mSBlhVO?=
 =?us-ascii?Q?RXMJTFeHoCAid4AElgox/eDEjrZ1Kcu9GhjwRrewxP1OxMWOma8IasqgAA0e?=
 =?us-ascii?Q?ntIP0SR5b7jmfhW7pW0fG9+wiOnaUwxILhuxHpXfg/MVrR0zLuQ+b8idYVjf?=
 =?us-ascii?Q?Hn2MMW778VMtcZGJGrLu2YJpnr5+af4qqjmCxsopDuiVp9+ELOoQPociC1Nu?=
 =?us-ascii?Q?oGKd6FtPFcsBnt8urt0jUK2wAhosOgnJ6tvJGDIi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f3eca8-aefc-4658-0341-08dac3b1c3aa
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 06:55:49.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkWV1FZ1ZmVJz3+MoLyKlgAMUlv4FMd5V0tIAHUU2VI8yn7RFBBPwWev3Hl+nNt8XXn+XmzjAJb1GrCX0fZAwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5304
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--TR9O495S4ait0Bbo
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greeting,

FYI, we noticed BUG:KASAN:slab-out-of-bounds_in__bitmap_set due to commit (built with gcc-11):

commit: 8cbe83be2e63293c368eb2d580f2f69cb8b35e43 ("[PATCH 2/6] bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()")
url: https://github.com/intel-lab-lkp/linux/commits/Yury-Norov/bitmap-remove-_reg_op/20221028-095005
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 23758867219c8d84c8363316e6dd2f9fd7ae3049
patch subject: [PATCH 2/6] bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20221009
with following parameters:

	disk: 1HDD
	fs: f2fs
	test: writev03.writev03

test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
test-url: http://linux-test-project.github.io/

on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


[ 8.260699][ T1] BUG: KASAN: slab-out-of-bounds in __bitmap_set (lib/bitmap.c:370) 
[    8.260699][    T1] Read of size 8 at addr ffff88810023a000 by task swapper/0/1
[    8.260699][    T1]
[    8.260699][    T1] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G          I        6.1.0-rc2-00194-g8cbe83be2e63 #1
[    8.260699][    T1] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[    8.260699][    T1] Call Trace:
[    8.260699][    T1]  <TASK>
[ 8.260699][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 8.260699][ T1] print_address_description+0x87/0x2a1 
[ 8.260699][ T1] print_report (mm/kasan/report.c:396) 
[ 8.260699][ T1] ? kasan_addr_to_slab (mm/kasan/common.c:35) 
[ 8.260699][ T1] ? __bitmap_set (lib/bitmap.c:370) 
[ 8.260699][ T1] kasan_report (mm/kasan/report.c:497) 
[ 8.260699][ T1] ? __bitmap_set (lib/bitmap.c:370) 
[ 8.260699][ T1] __bitmap_set (lib/bitmap.c:370) 
[ 8.260699][ T1] bitmap_find_free_region (lib/bitmap.c:1321) 
[ 8.260699][ T1] intel_irq_remapping_alloc (drivers/iommu/intel/irq_remapping.c:129 drivers/iommu/intel/irq_remapping.c:1358) 
[ 8.260699][ T1] ? local_pci_probe (drivers/pci/pci-driver.c:324) 
[ 8.260699][ T1] ? pci_call_probe (drivers/pci/pci-driver.c:392) 
[ 8.260699][ T1] ? driver_probe_device (drivers/base/dd.c:808) 
[ 8.260699][ T1] ? __driver_attach (drivers/base/dd.c:1191) 
[ 8.260699][ T1] ? bus_add_driver (drivers/base/bus.c:618) 
[ 8.260699][ T1] ? do_one_initcall (init/main.c:1303) 
[ 8.260699][ T1] ? do_initcalls (init/main.c:1375 init/main.c:1392) 
[ 8.260699][ T1] ? kernel_init_freeable (init/main.c:1635) 
[ 8.260699][ T1] ? kernel_init (init/main.c:1521) 
[ 8.260699][ T1] ? ret_from_fork (arch/x86/entry/entry_64.S:312) 
[ 8.260699][ T1] ? intel_irq_remapping_free (drivers/iommu/intel/irq_remapping.c:1327) 
[ 8.260699][ T1] ? __irq_domain_alloc_irqs (include/linux/slab.h:598 include/linux/slab.h:723 kernel/irq/irqdomain.c:1158 kernel/irq/irqdomain.c:1285 kernel/irq/irqdomain.c:1475) 
[ 8.260699][ T1] ? __irq_domain_alloc_irqs (include/linux/slab.h:598 include/linux/slab.h:723 kernel/irq/irqdomain.c:1158 kernel/irq/irqdomain.c:1285 kernel/irq/irqdomain.c:1475) 
[ 8.260699][ T1] msi_domain_alloc (kernel/irq/msi.c:543) 
[ 8.260699][ T1] ? msi_domain_free (kernel/irq/msi.c:532) 
[ 8.260699][ T1] ? __mutex_lock_slowpath (kernel/locking/mutex.c:282) 
[ 8.260699][ T1] __irq_domain_alloc_irqs (kernel/irq/irqdomain.c:1482) 
[ 8.260699][ T1] __msi_domain_alloc_irqs (kernel/irq/msi.c:896) 
[ 8.260699][ T1] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 8.260699][ T1] ? msi_domain_prepare_irqs (kernel/irq/msi.c:855) 
[ 8.260699][ T1] ? xa_find (lib/xarray.c:2024) 
[ 8.260699][ T1] msi_domain_alloc_irqs_descs_locked (kernel/irq/msi.c:952) 
[ 8.260699][ T1] ? msi_find_desc (kernel/irq/msi.c:248) 
[ 8.260699][ T1] __pci_enable_msi_range (drivers/pci/msi/msi.c:458 drivers/pci/msi/msi.c:905) 
[ 8.260699][ T1] ? pci_disable_msi (drivers/pci/msi/msi.c:866) 
[ 8.260699][ T1] ? irq_spurious_proc_show (kernel/irq/proc.c:292) 
[ 8.260699][ T1] ? __pci_enable_msix_range (drivers/pci/msi/msi.c:359 drivers/pci/msi/msi.c:941) 
[ 8.260699][ T1] pci_alloc_irq_vectors_affinity (drivers/pci/msi/msi.c:1029) 
[ 8.260699][ T1] ? pci_conf1_read (arch/x86/pci/direct.c:49) 
[ 8.260699][ T1] ? pci_enable_msix_range (drivers/pci/msi/msi.c:1008) 
[ 8.260699][ T1] ? pci_bus_read_config_word (drivers/pci/access.c:67 (discriminator 2)) 
[ 8.260699][ T1] ? pci_bus_find_capability (drivers/pci/pci.c:544) 
[ 8.260699][ T1] pcie_port_enable_irq_vec (include/linux/pci.h:1907 drivers/pci/pcie/portdrv_core.c:107) 
[ 8.260699][ T1] ? get_port_device_capability (drivers/pci/pcie/portdrv_core.c:102) 
[ 8.260699][ T1] ? __pci_set_master (drivers/pci/pci.c:4383) 
[ 8.260699][ T1] ? pci_ea_read (drivers/pci/pci.c:4378) 
[ 8.260699][ T1] ? pci_address_to_pio+0x20/0x20 
[ 8.260699][ T1] ? pci_enable_device_flags (drivers/pci/pci.c:2005) 
[ 8.260699][ T1] pcie_port_device_register (drivers/pci/pcie/portdrv_core.c:181 drivers/pci/pcie/portdrv_core.c:334) 
[ 8.260699][ T1] ? rpm_callback (drivers/base/power/runtime.c:755) 
[ 8.260699][ T1] ? pcie_port_service_unregister (drivers/pci/pcie/portdrv_core.c:312) 
[ 8.260699][ T1] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
[ 8.260699][ T1] ? __cond_resched (kernel/sched/core.c:8325) 
[ 8.260699][ T1] ? pcie_portdrv_remove (drivers/pci/pcie/portdrv_pci.c:103) 
[ 8.260699][ T1] pcie_portdrv_probe (drivers/pci/pcie/portdrv_pci.c:117) 
[ 8.260699][ T1] ? pcie_portdrv_remove (drivers/pci/pcie/portdrv_pci.c:103) 
[ 8.260699][ T1] local_pci_probe (drivers/pci/pci-driver.c:324) 
[ 8.260699][ T1] pci_call_probe (drivers/pci/pci-driver.c:392) 
[ 8.260699][ T1] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 8.260699][ T1] ? local_pci_probe (drivers/pci/pci-driver.c:352) 
[ 8.260699][ T1] ? pci_assign_irq (drivers/pci/setup-irq.c:25) 
[ 8.260699][ T1] ? pci_match_device (drivers/pci/pci-driver.c:108 drivers/pci/pci-driver.c:159) 
[ 8.260699][ T1] ? kernfs_put (arch/x86/include/asm/atomic.h:123 (discriminator 1) include/linux/atomic/atomic-instrumented.h:576 (discriminator 1) fs/kernfs/dir.c:531 (discriminator 1)) 
[ 8.260699][ T1] pci_device_probe (drivers/pci/pci-driver.c:461) 
[ 8.260699][ T1] ? pci_dma_configure (drivers/pci/pci-driver.c:1647) 
[ 8.260699][ T1] really_probe (drivers/base/dd.c:560 drivers/base/dd.c:639) 
[ 8.260699][ T1] __driver_probe_device (drivers/base/dd.c:719 drivers/base/dd.c:776) 
[ 8.260699][ T1] driver_probe_device (drivers/base/dd.c:808) 
[ 8.260699][ T1] __driver_attach (drivers/base/dd.c:1191) 
[ 8.260699][ T1] ? __device_attach_driver (drivers/base/dd.c:1135) 
[ 8.260699][ T1] bus_for_each_dev (drivers/base/bus.c:301) 
[ 8.260699][ T1] ? subsys_dev_iter_exit (drivers/base/bus.c:290) 
[ 8.260699][ T1] ? __kmem_cache_alloc_node (mm/slub.c:3400 mm/slub.c:3437) 
[ 8.260699][ T1] ? klist_add_tail (include/linux/list.h:69 include/linux/list.h:102 lib/klist.c:104 lib/klist.c:137) 
[ 8.260699][ T1] bus_add_driver (drivers/base/bus.c:618) 
[ 8.260699][ T1] driver_register (drivers/base/driver.c:246) 
[ 8.260699][ T1] ? dmi_pcie_pme_disable_msi (drivers/pci/pcie/portdrv_pci.c:243) 
[ 8.260699][ T1] do_one_initcall (init/main.c:1303) 
[ 8.260699][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1294) 
[ 8.260699][ T1] ? parse_one (kernel/params.c:170) 
[ 8.260699][ T1] ? do_initcalls (init/main.c:1386) 
[ 8.260699][ T1] ? kasan_set_track (mm/kasan/common.c:52) 
[ 8.260699][ T1] ? __kasan_kmalloc (mm/kasan/common.c:381) 
[ 8.260699][ T1] do_initcalls (init/main.c:1375 init/main.c:1392) 
[ 8.260699][ T1] kernel_init_freeable (init/main.c:1635) 
[ 8.260699][ T1] ? console_on_rootfs (init/main.c:1601) 
[ 8.260699][ T1] ? usleep_range_state (kernel/time/timer.c:1897) 
[ 8.260699][ T1] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169) 
[ 8.260699][ T1] ? rest_init (init/main.c:1511) 
[ 8.260699][ T1] ? rest_init (init/main.c:1511) 
[ 8.260699][ T1] kernel_init (init/main.c:1521) 
[ 8.260699][ T1] ret_from_fork (arch/x86/entry/entry_64.S:312) 
[    8.260699][    T1]  </TASK>
[    8.260699][    T1]


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202211111357.9e363da2-yujie.liu@intel.com


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

--TR9O495S4ait0Bbo
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc2-00194-g8cbe83be2e63"

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
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
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
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
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
CONFIG_CMA_SIZE_MBYTES=0
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
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
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

--TR9O495S4ait0Bbo
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='ltp'
	export testcase='ltp'
	export category='functional'
	export need_memory='4G'
	export job_origin='ltp-syscalls.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-skl-d02'
	export tbox_group='lkp-skl-d02'
	export submit_id='636c70cd4a2ac8a0b2104880'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-writev03.writev03-debian-12-x86_64-20220629.cgz-8cbe83be2e63293c368eb2d580f2f69cb8b35e43-20221110-41138-1rk5rul-4.yaml'
	export id='69b60492fca7d4733027391d3a220f0f7f2c7267'
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
	export need_kconfig='BLK_DEV_SD
SCSI
{"BLOCK"=>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=>"y"}
F2FS_FS
BLK_DEV_LOOP
{"CAN"=>"m"}
{"CAN_RAW"=>"m"}
{"CAN_VCAN"=>"m"}
{"MINIX_FS"=>"m"}
{"EXPERT"=>"y"}
{"CHECKPOINT_RESTORE"=>"y"}'
	export commit='8cbe83be2e63293c368eb2d580f2f69cb8b35e43'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xf0'
	export bisect_dmesg=true
	export rootfs='debian-12-x86_64-20220629.cgz'
	export initrds='linux_headers'
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2022-11-10 11:32:29 +0800'
	export _id='636c70e24a2ac8a0b2104883'
	export _rt='/result/ltp/1HDD-f2fs-writev03.writev03/lkp-skl-d02/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='468a258547467261cf57d02efc7c8bbccd00180b'
	export base_commit='30a0b95b1335e12efef89dd78518ed3e4a71a763'
	export branch='linux-review/Yury-Norov/bitmap-remove-_reg_op/20221028-095005'
	export result_root='/result/ltp/1HDD-f2fs-writev03.writev03/lkp-skl-d02/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/1'
	export scheduler_version='/lkp/lkp/.src-20221109-191645'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-12-x86_64-20220629.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/ltp/1HDD-f2fs-writev03.writev03/lkp-skl-d02/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/1
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/vmlinuz-6.1.0-rc2-00194-g8cbe83be2e63
branch=linux-review/Yury-Norov/bitmap-remove-_reg_op/20221028-095005
job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-writev03.writev03-debian-12-x86_64-20220629.cgz-8cbe83be2e63293c368eb2d580f2f69cb8b35e43-20221110-41138-1rk5rul-4.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=8cbe83be2e63293c368eb2d580f2f69cb8b35e43
initcall_debug
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/linux-headers.cgz'
	export bm_initrd='/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/fs_20220824.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/ltp_20221031.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/ltp-x86_64-14c1f76-1_20221009.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20220629.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.1.0-rc3'
	export repeat_to=6
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.BUG:KASAN:slab-out-of-bounds_in__bitmap_set'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/vmlinuz-6.1.0-rc2-00194-g8cbe83be2e63'
	export dequeue_time='2022-11-10 12:23:18 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-writev03.writev03-debian-12-x86_64-20220629.cgz-8cbe83be2e63293c368eb2d580f2f69cb8b35e43-20221110-41138-1rk5rul-4.cgz'

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

	run_setup fs='f2fs' $LKP_SRC/setup/fs

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='writev03.writev03' $LKP_SRC/tests/wrapper ltp
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='writev03.writev03' $LKP_SRC/stats/wrapper ltp
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time ltp.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--TR9O495S4ait0Bbo
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--TR9O495S4ait0Bbo
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="ltp"

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
Linux version 6.1.0-rc2-00194-g8cbe83be2e63 (kbuild@31b20db543e9) (gcc-11 (Debian 11.3.0-8) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39) #1 SMP Thu Nov 10 06:27:03 CST 2022
Command line:  ip=::::lkp-skl-d02::dhcp root=/dev/ram0 RESULT_ROOT=/result/ltp/1HDD-f2fs-writev03.writev03/lkp-skl-d02/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/1 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/vmlinuz-6.1.0-rc2-00194-g8cbe83be2e63 branch=linux-review/Yury-Norov/bitmap-remove-_reg_op/20221028-095005 job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-writev03.writev03-debian-12-x86_64-20220629.cgz-8cbe83be2e63293c368eb2d580f2f69cb8b35e43-20221110-41138-1rk5rul-4.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-func commit=8cbe83be2e63293c368eb2d580f2f69cb8b35e43 initcall_debug max_uptime=2100 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_co
KERNEL supported cpus:
Intel GenuineIntel
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
signal: max sigframe size: 2032
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000100-0x000000000009c7ff] usable
BIOS-e820: [mem 0x000000000009c800-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x0000000077b40fff] usable
BIOS-e820: [mem 0x0000000077b41000-0x0000000077b41fff] ACPI NVS
BIOS-e820: [mem 0x0000000077b42000-0x0000000077b6bfff] reserved
BIOS-e820: [mem 0x0000000077b6c000-0x0000000077bbdfff] usable
BIOS-e820: [mem 0x0000000077bbe000-0x00000000783befff] reserved
BIOS-e820: [mem 0x00000000783bf000-0x0000000086f56fff] usable
BIOS-e820: [mem 0x0000000086f57000-0x00000000872bcfff] reserved
BIOS-e820: [mem 0x00000000872bd000-0x0000000087309fff] ACPI data
BIOS-e820: [mem 0x000000008730a000-0x0000000087abefff] ACPI NVS
BIOS-e820: [mem 0x0000000087abf000-0x0000000087ffefff] reserved
BIOS-e820: [mem 0x0000000087fff000-0x0000000087ffffff] usable
BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x0000000871ffffff] usable
printk: debug: ignoring loglevel setting.
printk: bootconsole [earlyser0] enabled
NX (Execute Disable) protection: active
SMBIOS 2.8 present.
DMI: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
tsc: Detected 3200.000 MHz processor
tsc: Detected 3199.980 MHz TSC
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x872000 max_arch_pfn = 0x400000000
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
last_pfn = 0x88000 max_arch_pfn = 0x400000000
Scan for SMP in [mem 0x00000000-0x000003ff]
Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Scan for SMP in [mem 0x000f0000-0x000fffff]
found SMP MP-table at [mem 0x000fcde0-0x000fcdef]
mpc: fcbb0-fcd5c
Using GB pages for direct mapping
RAMDISK: [mem 0x815d88000-0x86c9fffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F05B0 000024 (v02 DELL  )
ACPI: XSDT 0x00000000872DD0A0 0000C4 (v01 DELL   CBX3     01072009 AMI  00010013)
ACPI: FACP 0x00000000872FE7C0 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
ACPI: DSDT 0x00000000872DD1F8 0215C8 (v02 DELL   CBX3     01072009 INTL 20120913)
ACPI: FACS 0x0000000087ABEF80 000040
ACPI: APIC 0x00000000872FE8D0 000084 (v03 DELL   CBX3     01072009 AMI  00010013)
ACPI: FPDT 0x00000000872FE958 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
ACPI: FIDT 0x00000000872FE9A0 00009C (v01 DELL   CBX3     01072009 AMI  00010013)
ACPI: MCFG 0x00000000872FEA40 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
ACPI: HPET 0x00000000872FEA80 000038 (v01 DELL   CBX3     01072009 AMI. 0005000B)
ACPI: SSDT 0x00000000872FEAB8 00036D (v01 SataRe SataTabl 00001000 INTL 20120913)
ACPI: SSDT 0x00000000872FEE28 0053B2 (v02 SaSsdt SaSsdt   00003000 INTL 20120913)
ACPI: UEFI 0x00000000873041E0 000042 (v01                 00000000      00000000)
ACPI: LPIT 0x0000000087304228 000094 (v01 INTEL  SKL      00000000 MSFT 0000005F)
ACPI: SSDT 0x00000000873042C0 000248 (v02 INTEL  sensrhub 00000000 INTL 20120913)
ACPI: SSDT 0x0000000087304508 002BAE (v02 INTEL  PtidDevc 00001000 INTL 20120913)
ACPI: SSDT 0x00000000873070B8 000C45 (v02 INTEL  Ther_Rvp 00001000 INTL 20120913)
ACPI: DBGP 0x0000000087307D00 000034 (v01 INTEL           00000000 MSFT 0000005F)
ACPI: DBG2 0x0000000087307D38 000054 (v00 INTEL           00000000 MSFT 0000005F)
ACPI: SSDT 0x0000000087307D90 000613 (v02 INTEL  DELL__MT 00000000 INTL 20120913)
ACPI: SSDT 0x00000000873083A8 000E58 (v02 CpuRef CpuSsdt  00003000 INTL 20120913)
ACPI: SLIC 0x0000000087309200 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
ACPI: DMAR 0x0000000087309378 0000A8 (v01 INTEL  SKL      00000001 INTL 00000001)
ACPI: ASF! 0x0000000087309420 0000A5 (v32 INTEL   HCG     00000001 TFSM 000F4240)
ACPI: Reserving FACP table memory at [mem 0x872fe7c0-0x872fe8cb]
ACPI: Reserving DSDT table memory at [mem 0x872dd1f8-0x872fe7bf]
ACPI: Reserving FACS table memory at [mem 0x87abef80-0x87abefbf]
ACPI: Reserving APIC table memory at [mem 0x872fe8d0-0x872fe953]
ACPI: Reserving FPDT table memory at [mem 0x872fe958-0x872fe99b]
ACPI: Reserving FIDT table memory at [mem 0x872fe9a0-0x872fea3b]
ACPI: Reserving MCFG table memory at [mem 0x872fea40-0x872fea7b]
ACPI: Reserving HPET table memory at [mem 0x872fea80-0x872feab7]
ACPI: Reserving SSDT table memory at [mem 0x872feab8-0x872fee24]
ACPI: Reserving SSDT table memory at [mem 0x872fee28-0x873041d9]
ACPI: Reserving UEFI table memory at [mem 0x873041e0-0x87304221]
ACPI: Reserving LPIT table memory at [mem 0x87304228-0x873042bb]
ACPI: Reserving SSDT table memory at [mem 0x873042c0-0x87304507]
ACPI: Reserving SSDT table memory at [mem 0x87304508-0x873070b5]
ACPI: Reserving SSDT table memory at [mem 0x873070b8-0x87307cfc]
ACPI: Reserving DBGP table memory at [mem 0x87307d00-0x87307d33]
ACPI: Reserving DBG2 table memory at [mem 0x87307d38-0x87307d8b]
ACPI: Reserving SSDT table memory at [mem 0x87307d90-0x873083a2]
ACPI: Reserving SSDT table memory at [mem 0x873083a8-0x873091ff]
ACPI: Reserving SLIC table memory at [mem 0x87309200-0x87309375]
ACPI: Reserving DMAR table memory at [mem 0x87309378-0x8730941f]
ACPI: Reserving ASF! table memory at [mem 0x87309420-0x873094c4]
mapped APIC to ffffffffff5fc000 (        fee00000)
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x0000000871ffffff]
NODE_DATA(0) allocated [mem 0x871fd5000-0x871ffffff]
Zone ranges:
DMA      [mem 0x0000000000001000-0x0000000000ffffff]
DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Normal   [mem 0x0000000100000000-0x0000000871ffffff]
Device   empty
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x000000000009bfff]
node   0: [mem 0x0000000000100000-0x0000000077b40fff]
node   0: [mem 0x0000000077b6c000-0x0000000077bbdfff]
node   0: [mem 0x00000000783bf000-0x0000000086f56fff]
node   0: [mem 0x0000000087fff000-0x0000000087ffffff]
node   0: [mem 0x0000000100000000-0x0000000871ffffff]
Initmem setup node 0 [mem 0x0000000000001000-0x0000000871ffffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 100 pages in unavailable ranges
On node 0, zone DMA32: 43 pages in unavailable ranges
On node 0, zone DMA32: 2049 pages in unavailable ranges
On node 0, zone DMA32: 4264 pages in unavailable ranges
On node 0, zone Normal: 24576 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
Reserving Intel graphics memory at [mem 0x8a000000-0x8bffffff]
ACPI: PM-Timer IO Port: 0x1808
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a701 base: 0xfed00000
[Firmware Bug]: TSC_DEADLINE disabled due to Errata; please update microcode to version: 0xb2 (or later)
smpboot: Allowing 4 CPUs, 0 hotplug CPUs
mapped IOAPIC to ffffffffff5fb000 (fec00000)
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x0009c000-0x0009cfff]
PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0x77b41000-0x77b41fff]
PM: hibernation: Registered nosave memory: [mem 0x77b42000-0x77b6bfff]
PM: hibernation: Registered nosave memory: [mem 0x77bbe000-0x783befff]
PM: hibernation: Registered nosave memory: [mem 0x86f57000-0x872bcfff]
PM: hibernation: Registered nosave memory: [mem 0x872bd000-0x87309fff]
PM: hibernation: Registered nosave memory: [mem 0x8730a000-0x87abefff]
PM: hibernation: Registered nosave memory: [mem 0x87abf000-0x87ffefff]
PM: hibernation: Registered nosave memory: [mem 0x88000000-0x89ffffff]
PM: hibernation: Registered nosave memory: [mem 0x8a000000-0x8bffffff]
PM: hibernation: Registered nosave memory: [mem 0x8c000000-0xdfffffff]
PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xefffffff]
PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfdffffff]
PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[mem 0x8c000000-0xdfffffff] available for PCI devices
Booting paravirtualized kernel on bare hardware
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
percpu: Embedded 66 pages/cpu s233448 r8192 d28696 u524288
pcpu-alloc: s233448 r8192 d28696 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 
Fallback order for Node 0: 0 
Built 1 zonelists, mobility grouping on.  Total pages: 8226831
Policy zone: Normal
Kernel command line:  ip=::::lkp-skl-d02::dhcp root=/dev/ram0 RESULT_ROOT=/result/ltp/1HDD-f2fs-writev03.writev03/lkp-skl-d02/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/1 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/vmlinuz-6.1.0-rc2-00194-g8cbe83be2e63 branch=linux-review/Yury-Norov/bitmap-remove-_reg_op/20221028-095005 job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-writev03.writev03-debian-12-x86_64-20220629.cgz-8cbe83be2e63293c368eb2d580f2f69cb8b35e43-20221110-41138-1rk5rul-4.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-func commit=8cbe83be2e63293c368eb2d580f2f69cb8b35e43 initcall_debug max_uptime=2100 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.m
sysrq: sysrq always enabled.
ignoring the deprecated load_ramdisk= option
Unknown kernel command line parameters "nokaslr RESULT_ROOT=/result/ltp/1HDD-f2fs-writev03.writev03/lkp-skl-d02/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/1 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/vmlinuz-6.1.0-rc2-00194-g8cbe83be2e63 branch=linux-review/Yury-Norov/bitmap-remove-_reg_op/20221028-095005 job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-writev03.writev03-debian-12-x86_64-20220629.cgz-8cbe83be2e63293c368eb2d580f2f69cb8b35e43-20221110-41138-1rk5rul-4.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-func commit=8cbe83be2e63293c368eb2d580f2f69cb8b35e43 max_uptime=2100 LKP_SERVER=internal-lkp-server selinux=0 softlockup_panic=1 prompt_ramdisk=0 vga=normal", will be passed to user space.
random: crng init done
Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
software IO TLB: area num 4.
Memory: 2267056K/33430300K available (40969K kernel code, 13583K rwdata, 13204K rodata, 3108K init, 4508K bss, 6638256K reserved, 0K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Kernel/User page tables isolation: enabled
ftrace: allocating 46909 entries in 184 pages
ftrace: allocated 184 pages with 4 groups
rcu: Hierarchical RCU implementation.
rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
	Trampoline variant of Tasks RCU enabled.
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.
calling  con_init+0x0/0x579 @ 0
Console: colour VGA+ 80x25
printk: console [tty0] enabled
initcall con_init+0x0/0x579 returned 0 after 0 usecs
calling  hvc_console_init+0x0/0x14 @ 0
initcall hvc_console_init+0x0/0x14 returned 0 after 0 usecs
calling  univ8250_console_init+0x0/0x27 @ 0
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
printk: bootconsole [earlyser0] disabled
initcall univ8250_console_init+0x0/0x27 returned 0 after 0 usecs
ACPI: Core revision 20220331
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
APIC: Switch to symmetric I/O mode setup
DMAR: Host address width 39
DMAR: DRHD base: 0x000000fed90000 flags: 0x0
DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 7e3ff0505e
DMAR: DRHD base: 0x000000fed91000 flags: 0x1
DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
DMAR: RMRR base: 0x0000008715f000 end: 0x0000008717efff
DMAR: RMRR base: 0x00000089800000 end: 0x0000008bffffff
DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x0000000089800000-0x000000008bffffff], contact BIOS vendor for fixes
DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x0000000089800000-0x000000008bffffff]
BIOS vendor: Dell Inc.; Ver: 1.1.1; Product Version: 
DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
DMAR-IR: HPET id 0 under DRHD base 0xfed91000
DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
DMAR-IR: IRQ remapping was enabled on dmar1 but we are not in kdump mode
DMAR-IR: Enabled IRQ remapping in xapic mode
x2apic: IRQ remapping doesn't support X2APIC mode
masked ExtINT on CPU#0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
apic 2 pin 0 not connected
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-1 -> IRQ 1 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:30 Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-2 -> IRQ 0 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-3 -> IRQ 3 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-4 -> IRQ 4 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-5 -> IRQ 5 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-6 -> IRQ 6 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-7 -> IRQ 7 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-8 -> IRQ 8 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-9 -> IRQ 9 Level:1 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-10 -> IRQ 10 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-11 -> IRQ 11 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-12 -> IRQ 12 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-13 -> IRQ 13 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-14 -> IRQ 14 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-15 -> IRQ 15 Level:0 ActiveLow:0)
apic 2 pin 16 not connected
apic 2 pin 17 not connected
apic 2 pin 18 not connected
apic 2 pin 19 not connected
apic 2 pin 20 not connected
apic 2 pin 21 not connected
apic 2 pin 22 not connected
apic 2 pin 23 not connected
apic 2 pin 24 not connected
apic 2 pin 25 not connected
apic 2 pin 26 not connected
apic 2 pin 27 not connected
apic 2 pin 28 not connected
apic 2 pin 29 not connected
apic 2 pin 30 not connected
apic 2 pin 31 not connected
apic 2 pin 32 not connected
apic 2 pin 33 not connected
apic 2 pin 34 not connected
apic 2 pin 35 not connected
apic 2 pin 36 not connected
apic 2 pin 37 not connected
apic 2 pin 38 not connected
apic 2 pin 39 not connected
apic 2 pin 40 not connected
apic 2 pin 41 not connected
apic 2 pin 42 not connected
apic 2 pin 43 not connected
apic 2 pin 44 not connected
apic 2 pin 45 not connected
apic 2 pin 46 not connected
apic 2 pin 47 not connected
apic 2 pin 48 not connected
apic 2 pin 49 not connected
apic 2 pin 50 not connected
apic 2 pin 51 not connected
apic 2 pin 52 not connected
apic 2 pin 53 not connected
apic 2 pin 54 not connected
apic 2 pin 55 not connected
apic 2 pin 56 not connected
apic 2 pin 57 not connected
apic 2 pin 58 not connected
apic 2 pin 59 not connected
apic 2 pin 60 not connected
apic 2 pin 61 not connected
apic 2 pin 62 not connected
apic 2 pin 63 not connected
apic 2 pin 64 not connected
apic 2 pin 65 not connected
apic 2 pin 66 not connected
apic 2 pin 67 not connected
apic 2 pin 68 not connected
apic 2 pin 69 not connected
apic 2 pin 70 not connected
apic 2 pin 71 not connected
apic 2 pin 72 not connected
apic 2 pin 73 not connected
apic 2 pin 74 not connected
apic 2 pin 75 not connected
apic 2 pin 76 not connected
apic 2 pin 77 not connected
apic 2 pin 78 not connected
apic 2 pin 79 not connected
apic 2 pin 80 not connected
apic 2 pin 81 not connected
apic 2 pin 82 not connected
apic 2 pin 83 not connected
apic 2 pin 84 not connected
apic 2 pin 85 not connected
apic 2 pin 86 not connected
apic 2 pin 87 not connected
apic 2 pin 88 not connected
apic 2 pin 89 not connected
apic 2 pin 90 not connected
apic 2 pin 91 not connected
apic 2 pin 92 not connected
apic 2 pin 93 not connected
apic 2 pin 94 not connected
apic 2 pin 95 not connected
apic 2 pin 96 not connected
apic 2 pin 97 not connected
apic 2 pin 98 not connected
apic 2 pin 99 not connected
apic 2 pin 100 not connected
apic 2 pin 101 not connected
apic 2 pin 102 not connected
apic 2 pin 103 not connected
apic 2 pin 104 not connected
apic 2 pin 105 not connected
apic 2 pin 106 not connected
apic 2 pin 107 not connected
apic 2 pin 108 not connected
apic 2 pin 109 not connected
apic 2 pin 110 not connected
apic 2 pin 111 not connected
apic 2 pin 112 not connected
apic 2 pin 113 not connected
apic 2 pin 114 not connected
apic 2 pin 115 not connected
apic 2 pin 116 not connected
apic 2 pin 117 not connected
apic 2 pin 118 not connected
apic 2 pin 119 not connected
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e2036ff8d5, max_idle_ns: 440795275316 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. 6399.96 BogoMIPS (lpj=3199980)
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
Yama: becoming mindful.
Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
Spectre V2 : Vulnerable
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable to RETBleed attacks, data leaks possible!
RETBleed: Vulnerable
Speculative Store Bypass: Vulnerable
MDS: Vulnerable: Clear CPU buffers attempted, no microcode
TAA: Vulnerable: Clear CPU buffers attempted, no microcode
MMIO Stale Data: Vulnerable: Clear CPU buffers attempted, no microcode
SRBDS: Vulnerable: No microcode
Freeing SMP alternatives memory: 40K
lapic timer already calibrated 24060
smpboot: CPU0: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (family: 0x6, model: 0x5e, stepping: 0x3)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 2 and lim to 1.
cblist_init_generic: Setting shift to 2 and lim to 1.
cblist_init_generic: Setting shift to 2 and lim to 1.
calling  init_hw_perf_events+0x0/0x676 @ 1
Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
... version:                4
... bit width:              48
... generic registers:      8
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   3
... event mask:             00000007000000ff
initcall init_hw_perf_events+0x0/0x676 returned 0 after 8000 usecs
calling  init_real_mode+0x0/0xc1 @ 1
initcall init_real_mode+0x0/0xc1 returned 0 after 0 usecs
calling  trace_init_perf_perm_irq_work_exit+0x0/0x13 @ 1
initcall trace_init_perf_perm_irq_work_exit+0x0/0x13 returned 0 after 0 usecs
calling  bp_init_aperfmperf+0x0/0x5a @ 1
Estimated ratio of average max frequency by base frequency (times 1024): 1056
initcall bp_init_aperfmperf+0x0/0x5a returned 0 after 1000 usecs
calling  register_nmi_cpu_backtrace_handler+0x0/0x16 @ 1
initcall register_nmi_cpu_backtrace_handler+0x0/0x16 returned 0 after 0 usecs
calling  kvm_setup_vsyscall_timeinfo+0x0/0xdd @ 1
initcall kvm_setup_vsyscall_timeinfo+0x0/0xdd returned 0 after 0 usecs
calling  spawn_ksoftirqd+0x0/0x39 @ 1
initcall spawn_ksoftirqd+0x0/0x39 returned 0 after 1000 usecs
calling  migration_init+0x0/0xd1 @ 1
initcall migration_init+0x0/0xd1 returned 0 after 0 usecs
calling  srcu_bootup_announce+0x0/0x78 @ 1
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 400.
initcall srcu_bootup_announce+0x0/0x78 returned 0 after 2000 usecs
calling  rcu_spawn_gp_kthread+0x0/0x315 @ 1
initcall rcu_spawn_gp_kthread+0x0/0x315 returned 0 after 0 usecs
calling  check_cpu_stall_init+0x0/0x1b @ 1
initcall check_cpu_stall_init+0x0/0x1b returned 0 after 0 usecs
calling  rcu_sysrq_init+0x0/0x22 @ 1
initcall rcu_sysrq_init+0x0/0x22 returned 0 after 0 usecs
calling  trace_init_flags_sys_enter+0x0/0xf @ 1
initcall trace_init_flags_sys_enter+0x0/0xf returned 0 after 0 usecs
calling  trace_init_flags_sys_exit+0x0/0xf @ 1
initcall trace_init_flags_sys_exit+0x0/0xf returned 0 after 0 usecs
calling  cpu_stop_init+0x0/0x164 @ 1
initcall cpu_stop_init+0x0/0x164 returned 0 after 0 usecs
calling  init_kprobes+0x0/0x259 @ 1
initcall init_kprobes+0x0/0x259 returned 0 after 0 usecs
calling  init_events+0x0/0xc2 @ 1
initcall init_events+0x0/0xc2 returned 0 after 0 usecs
calling  init_trace_printk+0x0/0xc @ 1
initcall init_trace_printk+0x0/0xc returned 0 after 0 usecs
calling  event_trace_enable_again+0x0/0x1f @ 1
initcall event_trace_enable_again+0x0/0x1f returned 0 after 0 usecs
calling  irq_work_init_threads+0x0/0x3 @ 1
initcall irq_work_init_threads+0x0/0x3 returned 0 after 0 usecs
calling  static_call_init+0x0/0x81 @ 1
initcall static_call_init+0x0/0x81 returned 0 after 0 usecs
calling  jump_label_init_module+0x0/0x11 @ 1
initcall jump_label_init_module+0x0/0x11 returned 0 after 0 usecs
calling  init_zero_pfn+0x0/0xbb @ 1
initcall init_zero_pfn+0x0/0xbb returned 0 after 0 usecs
calling  init_fs_inode_sysctls+0x0/0x22 @ 1
initcall init_fs_inode_sysctls+0x0/0x22 returned 0 after 0 usecs
calling  init_fs_locks_sysctls+0x0/0x22 @ 1
initcall init_fs_locks_sysctls+0x0/0x22 returned 0 after 0 usecs
calling  dynamic_debug_init+0x0/0x3b9 @ 1
initcall dynamic_debug_init+0x0/0x3b9 returned 0 after 0 usecs
calling  efi_memreserve_root_init+0x0/0x26 @ 1
initcall efi_memreserve_root_init+0x0/0x26 returned 0 after 0 usecs
calling  efi_earlycon_remap_fb+0x0/0xe8 @ 1
initcall efi_earlycon_remap_fb+0x0/0xe8 returned 0 after 0 usecs
calling  bpf_dispatcher_xdp_init+0x0/0x11 @ 1
initcall bpf_dispatcher_xdp_init+0x0/0x11 returned 0 after 0 usecs
NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
masked ExtINT on CPU#1
#2
masked ExtINT on CPU#2
#3
masked ExtINT on CPU#3
smp: Brought up 1 node, 4 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 4 processors activated (25599.84 BogoMIPS)
node 0 deferred pages initialised in 79ms
devtmpfs: initialized
x86/mm: Memory block size: 128MB
calling  bpf_jit_charge_init+0x0/0x3c @ 1
initcall bpf_jit_charge_init+0x0/0x3c returned 0 after 0 usecs
calling  ipc_ns_init+0x0/0x11a @ 1
initcall ipc_ns_init+0x0/0x11a returned 0 after 0 usecs
calling  init_mmap_min_addr+0x0/0x16 @ 1
initcall init_mmap_min_addr+0x0/0x16 returned 0 after 0 usecs
calling  pci_realloc_setup_params+0x0/0x41 @ 1
initcall pci_realloc_setup_params+0x0/0x41 returned 0 after 0 usecs
calling  inet_frag_wq_init+0x0/0x42 @ 1
initcall inet_frag_wq_init+0x0/0x42 returned 0 after 0 usecs
calling  e820__register_nvs_regions+0x0/0x14c @ 1
ACPI: PM: Registering ACPI NVS region [mem 0x77b41000-0x77b41fff] (4096 bytes)
ACPI: PM: Registering ACPI NVS region [mem 0x8730a000-0x87abefff] (8081408 bytes)
initcall e820__register_nvs_regions+0x0/0x14c returned 0 after 5000 usecs
calling  cpufreq_register_tsc_scaling+0x0/0x76 @ 1
initcall cpufreq_register_tsc_scaling+0x0/0x76 returned 0 after 0 usecs
calling  reboot_init+0x0/0xa5 @ 1
initcall reboot_init+0x0/0xa5 returned 0 after 0 usecs
calling  init_lapic_sysfs+0x0/0x47 @ 1
initcall init_lapic_sysfs+0x0/0x47 returned 0 after 0 usecs
calling  alloc_frozen_cpus+0x0/0x21 @ 1
initcall alloc_frozen_cpus+0x0/0x21 returned 0 after 0 usecs
calling  cpu_hotplug_pm_sync_init+0x0/0x14 @ 1
initcall cpu_hotplug_pm_sync_init+0x0/0x14 returned 0 after 0 usecs
calling  wq_sysfs_init+0x0/0x2b @ 1
initcall wq_sysfs_init+0x0/0x2b returned 0 after 0 usecs
calling  ksysfs_init+0x0/0x99 @ 1
initcall ksysfs_init+0x0/0x99 returned 0 after 0 usecs
calling  schedutil_gov_init+0x0/0x11 @ 1
initcall schedutil_gov_init+0x0/0x11 returned 0 after 0 usecs
calling  pm_init+0x0/0xb0 @ 1
initcall pm_init+0x0/0xb0 returned 0 after 0 usecs
calling  pm_disk_init+0x0/0x3e @ 1
initcall pm_disk_init+0x0/0x3e returned 0 after 0 usecs
calling  swsusp_header_init+0x0/0x31 @ 1
initcall swsusp_header_init+0x0/0x31 returned 0 after 0 usecs
calling  rcu_set_runtime_mode+0x0/0x4b @ 1
initcall rcu_set_runtime_mode+0x0/0x4b returned 0 after 0 usecs
calling  init_jiffies_clocksource+0x0/0x18 @ 1
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 2000 usecs
calling  futex_init+0x0/0x23e @ 1
futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
initcall futex_init+0x0/0x23e returned 0 after 1000 usecs
calling  cgroup_wq_init+0x0/0x29 @ 1
initcall cgroup_wq_init+0x0/0x29 returned 0 after 0 usecs
calling  cgroup1_wq_init+0x0/0x29 @ 1
initcall cgroup1_wq_init+0x0/0x29 returned 0 after 0 usecs
calling  ftrace_mod_cmd_init+0x0/0xc @ 1
initcall ftrace_mod_cmd_init+0x0/0xc returned 0 after 0 usecs
calling  init_wakeup_tracer+0x0/0x2d @ 1
initcall init_wakeup_tracer+0x0/0x2d returned 0 after 0 usecs
calling  init_graph_trace+0x0/0x91 @ 1
initcall init_graph_trace+0x0/0x91 returned 0 after 0 usecs
calling  trace_events_eprobe_init_early+0x0/0x27 @ 1
initcall trace_events_eprobe_init_early+0x0/0x27 returned 0 after 0 usecs
calling  trace_events_synth_init_early+0x0/0x27 @ 1
initcall trace_events_synth_init_early+0x0/0x27 returned 0 after 0 usecs
calling  init_kprobe_trace_early+0x0/0x26 @ 1
initcall init_kprobe_trace_early+0x0/0x26 returned 0 after 0 usecs
calling  kasan_memhotplug_init+0x0/0xf @ 1
initcall kasan_memhotplug_init+0x0/0xf returned 0 after 0 usecs
calling  memory_failure_init+0x0/0x253 @ 1
initcall memory_failure_init+0x0/0x253 returned 0 after 0 usecs
calling  cma_init_reserved_areas+0x0/0x42 @ 1
initcall cma_init_reserved_areas+0x0/0x42 returned 0 after 0 usecs
calling  fsnotify_init+0x0/0x79 @ 1
initcall fsnotify_init+0x0/0x79 returned 0 after 0 usecs
calling  filelock_init+0x0/0x177 @ 1
initcall filelock_init+0x0/0x177 returned 0 after 0 usecs
calling  init_script_binfmt+0x0/0x16 @ 1
initcall init_script_binfmt+0x0/0x16 returned 0 after 0 usecs
calling  init_elf_binfmt+0x0/0x16 @ 1
initcall init_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
calling  init_compat_elf_binfmt+0x0/0x16 @ 1
initcall init_compat_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
calling  configfs_init+0x0/0xea @ 1
initcall configfs_init+0x0/0xea returned 0 after 0 usecs
calling  debugfs_init+0x0/0xb3 @ 1
initcall debugfs_init+0x0/0xb3 returned 0 after 0 usecs
calling  tracefs_init+0x0/0x63 @ 1
initcall tracefs_init+0x0/0x63 returned 0 after 0 usecs
calling  securityfs_init+0x0/0xba @ 1
initcall securityfs_init+0x0/0xba returned 0 after 0 usecs
calling  pinctrl_init+0x0/0xae @ 1
pinctrl core: initialized pinctrl subsystem
initcall pinctrl_init+0x0/0xae returned 0 after 1000 usecs
calling  gpiolib_dev_init+0x0/0x121 @ 1
initcall gpiolib_dev_init+0x0/0x121 returned 0 after 0 usecs
calling  virtio_init+0x0/0x20 @ 1
initcall virtio_init+0x0/0x20 returned 0 after 0 usecs
calling  iommu_init+0x0/0x51 @ 1
initcall iommu_init+0x0/0x51 returned 0 after 0 usecs
calling  component_debug_init+0x0/0x1d @ 1
initcall component_debug_init+0x0/0x1d returned 0 after 0 usecs
calling  cpufreq_core_init+0x0/0xca @ 1
initcall cpufreq_core_init+0x0/0xca returned 0 after 0 usecs
calling  cpufreq_gov_performance_init+0x0/0x11 @ 1
initcall cpufreq_gov_performance_init+0x0/0x11 returned 0 after 0 usecs
calling  cpufreq_gov_powersave_init+0x0/0x11 @ 1
initcall cpufreq_gov_powersave_init+0x0/0x11 returned 0 after 0 usecs
calling  cpufreq_gov_userspace_init+0x0/0x11 @ 1
initcall cpufreq_gov_userspace_init+0x0/0x11 returned 0 after 0 usecs
calling  CPU_FREQ_GOV_ONDEMAND_init+0x0/0x11 @ 1
initcall CPU_FREQ_GOV_ONDEMAND_init+0x0/0x11 returned 0 after 0 usecs
calling  CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x11 @ 1
initcall CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x11 returned 0 after 0 usecs
calling  cpuidle_init+0x0/0x46 @ 1
initcall cpuidle_init+0x0/0x46 returned 0 after 0 usecs
calling  sock_init+0x0/0x9f @ 1
initcall sock_init+0x0/0x9f returned 0 after 0 usecs
calling  net_inuse_init+0x0/0x29 @ 1
initcall net_inuse_init+0x0/0x29 returned 0 after 0 usecs
calling  net_defaults_init+0x0/0x29 @ 1
initcall net_defaults_init+0x0/0x29 returned 0 after 0 usecs
calling  init_default_flow_dissectors+0x0/0x50 @ 1
initcall init_default_flow_dissectors+0x0/0x50 returned 0 after 0 usecs
calling  netpoll_init+0x0/0x29 @ 1
initcall netpoll_init+0x0/0x29 returned 0 after 0 usecs
calling  netlink_proto_init+0x0/0x2c8 @ 1
NET: Registered PF_NETLINK/PF_ROUTE protocol family
initcall netlink_proto_init+0x0/0x2c8 returned 0 after 2000 usecs
calling  genl_init+0x0/0x43 @ 1
initcall genl_init+0x0/0x43 returned 0 after 0 usecs
calling  bsp_pm_check_init+0x0/0x14 @ 1
initcall bsp_pm_check_init+0x0/0x14 returned 0 after 0 usecs
calling  irq_sysfs_init+0x0/0xb8 @ 1
initcall irq_sysfs_init+0x0/0xb8 returned 0 after 0 usecs
calling  audit_init+0x0/0x1c9 @ 1
audit: initializing netlink subsys (disabled)
initcall audit_init+0x0/0x1c9 returned 0 after 1000 usecs
audit: type=2000 audit(1668107831.432:1): state=initialized audit_enabled=0 res=1
calling  release_early_probes+0x0/0x59 @ 1
initcall release_early_probes+0x0/0x59 returned 0 after 0 usecs
calling  bdi_class_init+0x0/0x6d @ 1
initcall bdi_class_init+0x0/0x6d returned 0 after 0 usecs
calling  mm_sysfs_init+0x0/0x4f @ 1
initcall mm_sysfs_init+0x0/0x4f returned 0 after 0 usecs
calling  init_per_zone_wmark_min+0x0/0x26 @ 1
initcall init_per_zone_wmark_min+0x0/0x26 returned 0 after 0 usecs
calling  mpi_init+0x0/0xe6 @ 1
initcall mpi_init+0x0/0xe6 returned 0 after 0 usecs
calling  gpiolib_sysfs_init+0x0/0x119 @ 1
initcall gpiolib_sysfs_init+0x0/0x119 returned 0 after 0 usecs
calling  acpi_gpio_setup_params+0x0/0x116 @ 1
initcall acpi_gpio_setup_params+0x0/0x116 returned 0 after 0 usecs
calling  pcibus_class_init+0x0/0x18 @ 1
initcall pcibus_class_init+0x0/0x18 returned 0 after 0 usecs
calling  pci_driver_init+0x0/0x22 @ 1
initcall pci_driver_init+0x0/0x22 returned 0 after 0 usecs
calling  backlight_class_init+0x0/0xee @ 1
initcall backlight_class_init+0x0/0xee returned 0 after 0 usecs
calling  tty_class_init+0x0/0x58 @ 1
initcall tty_class_init+0x0/0x58 returned 0 after 0 usecs
calling  vtconsole_class_init+0x0/0x1a0 @ 1
initcall vtconsole_class_init+0x0/0x1a0 returned 0 after 0 usecs
calling  iommu_dev_init+0x0/0x18 @ 1
initcall iommu_dev_init+0x0/0x18 returned 0 after 0 usecs
calling  mipi_dsi_bus_init+0x0/0x11 @ 1
initcall mipi_dsi_bus_init+0x0/0x11 returned 0 after 0 usecs
calling  devlink_class_init+0x0/0x46 @ 1
initcall devlink_class_init+0x0/0x46 returned 0 after 0 usecs
calling  software_node_init+0x0/0x51 @ 1
initcall software_node_init+0x0/0x51 returned 0 after 0 usecs
calling  wakeup_sources_debugfs_init+0x0/0x24 @ 1
initcall wakeup_sources_debugfs_init+0x0/0x24 returned 0 after 0 usecs
calling  wakeup_sources_sysfs_init+0x0/0x2d @ 1
initcall wakeup_sources_sysfs_init+0x0/0x2d returned 0 after 0 usecs
calling  regmap_initcall+0x0/0xd @ 1
initcall regmap_initcall+0x0/0xd returned 0 after 0 usecs
calling  spi_init+0x0/0xc7 @ 1
initcall spi_init+0x0/0xc7 returned 0 after 0 usecs
calling  i2c_init+0x0/0xe8 @ 1
initcall i2c_init+0x0/0xe8 returned 0 after 0 usecs
calling  thermal_init+0x0/0x192 @ 1
thermal_sys: Registered thermal governor 'fair_share'
thermal_sys: Registered thermal governor 'bang_bang'
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
initcall thermal_init+0x0/0x192 returned 0 after 3000 usecs
calling  init_menu+0x0/0x11 @ 1
cpuidle: using governor menu
initcall init_menu+0x0/0x11 returned 0 after 1000 usecs
calling  pcc_init+0x0/0xbd @ 1
initcall pcc_init+0x0/0xbd returned -19 after 0 usecs
calling  kobject_uevent_init+0x0/0xc @ 1
initcall kobject_uevent_init+0x0/0xc returned 0 after 0 usecs
calling  bts_init+0x0/0x130 @ 1
initcall bts_init+0x0/0x130 returned -19 after 0 usecs
calling  pt_init+0x0/0x2bd @ 1
initcall pt_init+0x0/0x2bd returned 0 after 0 usecs
calling  boot_params_ksysfs_init+0x0/0x92 @ 1
initcall boot_params_ksysfs_init+0x0/0x92 returned 0 after 0 usecs
calling  sbf_init+0x0/0xcf @ 1
initcall sbf_init+0x0/0xcf returned 0 after 0 usecs
calling  arch_kdebugfs_init+0x0/0x4d5 @ 1
initcall arch_kdebugfs_init+0x0/0x4d5 returned 0 after 0 usecs
calling  xfd_update_static_branch+0x0/0x44 @ 1
initcall xfd_update_static_branch+0x0/0x44 returned 0 after 0 usecs
calling  intel_pconfig_init+0x0/0xa5 @ 1
initcall intel_pconfig_init+0x0/0xa5 returned 0 after 0 usecs
calling  mtrr_if_init+0x0/0xab @ 1
initcall mtrr_if_init+0x0/0xab returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x32 @ 1
initcall activate_jump_labels+0x0/0x32 returned 0 after 0 usecs
calling  init_s4_sigcheck+0x0/0x8c @ 1
initcall init_s4_sigcheck+0x0/0x8c returned 0 after 0 usecs
calling  ffh_cstate_init+0x0/0x62 @ 1
initcall ffh_cstate_init+0x0/0x62 returned 0 after 0 usecs
calling  kvm_alloc_cpumask+0x0/0x1c6 @ 1
initcall kvm_alloc_cpumask+0x0/0x1c6 returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x32 @ 1
initcall activate_jump_labels+0x0/0x32 returned 0 after 0 usecs
calling  gigantic_pages_init+0x0/0x46 @ 1
initcall gigantic_pages_init+0x0/0x46 returned 0 after 0 usecs
calling  uv_rtc_setup_clock+0x0/0x276 @ 1
initcall uv_rtc_setup_clock+0x0/0x276 returned -19 after 0 usecs
calling  kcmp_cookies_init+0x0/0xa2 @ 1
initcall kcmp_cookies_init+0x0/0xa2 returned 0 after 0 usecs
calling  cryptomgr_init+0x0/0x11 @ 1
initcall cryptomgr_init+0x0/0x11 returned 0 after 0 usecs
calling  acpi_pci_init+0x0/0x149 @ 1
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
initcall acpi_pci_init+0x0/0x149 returned 0 after 2000 usecs
calling  dma_channel_table_init+0x0/0x178 @ 1
initcall dma_channel_table_init+0x0/0x178 returned 0 after 1000 usecs
calling  dma_bus_init+0x0/0x20b @ 1
initcall dma_bus_init+0x0/0x20b returned 0 after 0 usecs
calling  iommu_dma_init+0x0/0x50 @ 1
initcall iommu_dma_init+0x0/0x50 returned 0 after 0 usecs
calling  dmi_id_init+0x0/0x168 @ 1
initcall dmi_id_init+0x0/0x168 returned 0 after 0 usecs
calling  pci_arch_init+0x0/0x118 @ 1
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
PCI: Using configuration type 1 for base access
initcall pci_arch_init+0x0/0x118 returned 0 after 10000 usecs
calling  init_vdso+0x0/0x14 @ 1
initcall init_vdso+0x0/0x14 returned 0 after 0 usecs
calling  sysenter_setup+0x0/0x14 @ 1
initcall sysenter_setup+0x0/0x14 returned 0 after 0 usecs
calling  fixup_ht_bug+0x0/0x253 @ 1
initcall fixup_ht_bug+0x0/0x253 returned 0 after 0 usecs
calling  topology_init+0x0/0x9a @ 1
initcall topology_init+0x0/0x9a returned 0 after 0 usecs
calling  intel_epb_init+0x0/0xd4 @ 1
initcall intel_epb_init+0x0/0xd4 returned 0 after 0 usecs
calling  mtrr_init_finialize+0x0/0x71 @ 1
initcall mtrr_init_finialize+0x0/0x71 returned 0 after 0 usecs
calling  uid_cache_init+0x0/0xff @ 1
initcall uid_cache_init+0x0/0xff returned 0 after 0 usecs
calling  param_sysfs_init+0x0/0xcc @ 1
initcall param_sysfs_init+0x0/0xcc returned 0 after 12000 usecs
calling  user_namespace_sysctl_init+0x0/0x11b @ 1
initcall user_namespace_sysctl_init+0x0/0x11b returned 0 after 0 usecs
calling  proc_schedstat_init+0x0/0x25 @ 1
initcall proc_schedstat_init+0x0/0x25 returned 0 after 0 usecs
calling  pm_sysrq_init+0x0/0x19 @ 1
initcall pm_sysrq_init+0x0/0x19 returned 0 after 0 usecs
calling  create_proc_profile+0x0/0xe0 @ 1
initcall create_proc_profile+0x0/0xe0 returned 0 after 0 usecs
calling  crash_save_vmcoreinfo_init+0x0/0x73e @ 1
initcall crash_save_vmcoreinfo_init+0x0/0x73e returned 0 after 0 usecs
calling  crash_notes_memory_init+0x0/0x39 @ 1
initcall crash_notes_memory_init+0x0/0x39 returned 0 after 0 usecs
calling  cgroup_sysfs_init+0x0/0x3e @ 1
initcall cgroup_sysfs_init+0x0/0x3e returned 0 after 0 usecs
calling  cgroup_namespaces_init+0x0/0x8 @ 1
initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs
calling  user_namespaces_init+0x0/0x2d @ 1
initcall user_namespaces_init+0x0/0x2d returned 0 after 0 usecs
calling  init_optprobes+0x0/0x15 @ 1
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
initcall init_optprobes+0x0/0x15 returned 0 after 1000 usecs
calling  hung_task_init+0x0/0x75 @ 1
initcall hung_task_init+0x0/0x75 returned 0 after 0 usecs
calling  ftrace_check_for_weak_functions+0x0/0x62 @ 1
initcall ftrace_check_for_weak_functions+0x0/0x62 returned 0 after 0 usecs
calling  trace_eval_init+0x0/0x85 @ 1
initcall trace_eval_init+0x0/0x85 returned 0 after 0 usecs
calling  send_signal_irq_work_init+0x0/0x150 @ 1
initcall send_signal_irq_work_init+0x0/0x150 returned 0 after 0 usecs
calling  dev_map_init+0x0/0x126 @ 1
initcall dev_map_init+0x0/0x126 returned 0 after 0 usecs
calling  cpu_map_init+0x0/0x11a @ 1
initcall cpu_map_init+0x0/0x11a returned 0 after 0 usecs
calling  netns_bpf_init+0x0/0x11 @ 1
initcall netns_bpf_init+0x0/0x11 returned 0 after 0 usecs
calling  btf_vmlinux_init+0x0/0x84 @ 1
initcall btf_vmlinux_init+0x0/0x84 returned 0 after 0 usecs
calling  oom_init+0x0/0x4a @ 1
initcall oom_init+0x0/0x4a returned 0 after 1000 usecs
calling  default_bdi_init+0x0/0x29 @ 1
initcall default_bdi_init+0x0/0x29 returned 0 after 0 usecs
calling  cgwb_init+0x0/0x29 @ 1
initcall cgwb_init+0x0/0x29 returned 0 after 0 usecs
calling  percpu_enable_async+0x0/0xf @ 1
initcall percpu_enable_async+0x0/0xf returned 0 after 0 usecs
calling  kcompactd_init+0x0/0x98 @ 1
initcall kcompactd_init+0x0/0x98 returned 0 after 0 usecs
calling  init_user_reserve+0x0/0xa0 @ 1
initcall init_user_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_admin_reserve+0x0/0xa0 @ 1
initcall init_admin_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_reserve_notifier+0x0/0x1f @ 1
initcall init_reserve_notifier+0x0/0x1f returned 0 after 0 usecs
calling  swap_init_sysfs+0x0/0x8e @ 1
initcall swap_init_sysfs+0x0/0x8e returned 0 after 0 usecs
calling  swapfile_init+0x0/0x147 @ 1
initcall swapfile_init+0x0/0x147 returned 0 after 0 usecs
calling  hugetlb_init+0x0/0x450 @ 1
HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
initcall hugetlb_init+0x0/0x450 returned 0 after 4000 usecs
calling  ksm_init+0x0/0x242 @ 1
initcall ksm_init+0x0/0x242 returned 0 after 0 usecs
calling  memory_tier_init+0x0/0x146 @ 1
initcall memory_tier_init+0x0/0x146 returned 0 after 0 usecs
calling  numa_init_sysfs+0x0/0x8e @ 1
initcall numa_init_sysfs+0x0/0x8e returned 0 after 0 usecs
calling  hugepage_init+0x0/0x1b0 @ 1
initcall hugepage_init+0x0/0x1b0 returned 0 after 0 usecs
calling  mem_cgroup_init+0x0/0x359 @ 1
initcall mem_cgroup_init+0x0/0x359 returned 0 after 0 usecs
calling  mem_cgroup_swap_init+0x0/0x5c @ 1
initcall mem_cgroup_swap_init+0x0/0x5c returned 0 after 0 usecs
calling  page_idle_init+0x0/0x59 @ 1
initcall page_idle_init+0x0/0x59 returned 0 after 0 usecs
calling  seqiv_module_init+0x0/0x11 @ 1
initcall seqiv_module_init+0x0/0x11 returned 0 after 0 usecs
calling  rsa_init+0x0/0x3f @ 1
initcall rsa_init+0x0/0x3f returned 0 after 0 usecs
calling  hmac_module_init+0x0/0x11 @ 1
initcall hmac_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_null_mod_init+0x0/0x6d @ 1
initcall crypto_null_mod_init+0x0/0x6d returned 0 after 0 usecs
calling  md5_mod_init+0x0/0x11 @ 1
initcall md5_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  sha1_generic_mod_init+0x0/0x11 @ 1
initcall sha1_generic_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  sha256_generic_mod_init+0x0/0x16 @ 1
initcall sha256_generic_mod_init+0x0/0x16 returned 0 after 0 usecs
calling  sha512_generic_mod_init+0x0/0x16 @ 1
initcall sha512_generic_mod_init+0x0/0x16 returned 0 after 0 usecs
calling  crypto_ecb_module_init+0x0/0x11 @ 1
initcall crypto_ecb_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_cbc_module_init+0x0/0x11 @ 1
initcall crypto_cbc_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_cfb_module_init+0x0/0x11 @ 1
initcall crypto_cfb_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_ctr_module_init+0x0/0x16 @ 1
initcall crypto_ctr_module_init+0x0/0x16 returned 0 after 0 usecs
calling  crypto_gcm_module_init+0x0/0x63 @ 1
initcall crypto_gcm_module_init+0x0/0x63 returned 0 after 0 usecs
calling  cryptd_init+0x0/0x206 @ 1
cryptd: max_cpu_qlen set to 1000
initcall cryptd_init+0x0/0x206 returned 0 after 1000 usecs
calling  aes_init+0x0/0x11 @ 1
initcall aes_init+0x0/0x11 returned 0 after 0 usecs
calling  deflate_mod_init+0x0/0x44 @ 1
initcall deflate_mod_init+0x0/0x44 returned 0 after 0 usecs
calling  crc32c_mod_init+0x0/0x11 @ 1
initcall crc32c_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  crct10dif_mod_init+0x0/0x11 @ 1
initcall crct10dif_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  lzo_mod_init+0x0/0x3f @ 1
initcall lzo_mod_init+0x0/0x3f returned 0 after 0 usecs
calling  lzorle_mod_init+0x0/0x3f @ 1
initcall lzorle_mod_init+0x0/0x3f returned 0 after 0 usecs
calling  drbg_init+0x0/0xe4 @ 1
initcall drbg_init+0x0/0xe4 returned 0 after 0 usecs
calling  ghash_mod_init+0x0/0x11 @ 1
initcall ghash_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  init_bio+0x0/0x111 @ 1
initcall init_bio+0x0/0x111 returned 0 after 0 usecs
calling  blk_ioc_init+0x0/0x2a @ 1
initcall blk_ioc_init+0x0/0x2a returned 0 after 0 usecs
calling  blk_mq_init+0x0/0x177 @ 1
initcall blk_mq_init+0x0/0x177 returned 0 after 0 usecs
calling  genhd_device_init+0x0/0x88 @ 1
initcall genhd_device_init+0x0/0x88 returned 0 after 0 usecs
calling  blkcg_init+0x0/0x29 @ 1
initcall blkcg_init+0x0/0x29 returned 0 after 0 usecs
calling  io_wq_init+0x0/0x39 @ 1
initcall io_wq_init+0x0/0x39 returned 0 after 0 usecs
calling  sg_pool_init+0x0/0x1a5 @ 1
initcall sg_pool_init+0x0/0x1a5 returned 0 after 0 usecs
calling  irq_poll_setup+0x0/0x145 @ 1
initcall irq_poll_setup+0x0/0x145 returned 0 after 0 usecs
calling  gpiolib_debugfs_init+0x0/0x24 @ 1
initcall gpiolib_debugfs_init+0x0/0x24 returned 0 after 0 usecs
calling  pwm_debugfs_init+0x0/0x24 @ 1
initcall pwm_debugfs_init+0x0/0x24 returned 0 after 0 usecs
calling  pwm_sysfs_init+0x0/0x18 @ 1
initcall pwm_sysfs_init+0x0/0x18 returned 0 after 0 usecs
calling  pci_slot_init+0x0/0x40 @ 1
initcall pci_slot_init+0x0/0x40 returned 0 after 0 usecs
calling  fbmem_init+0x0/0xe1 @ 1
initcall fbmem_init+0x0/0xe1 returned 0 after 0 usecs
calling  scan_for_dmi_ipmi+0x0/0x52 @ 1
initcall scan_for_dmi_ipmi+0x0/0x52 returned 0 after 0 usecs
calling  acpi_init+0x0/0x26d @ 1
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 8 ACPI AML tables successfully acquired and loaded
ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF8881045B4000 0006A2 (v02 PmRef  Cpu0Ist  00003000 INTL 20120913)
ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888103919000 00037F (v02 PmRef  Cpu0Cst  00003001 INTL 20120913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF8881041CB500 00008E (v02 PmRef  Cpu0Hwp  00003000 INTL 20120913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF88810154F800 000130 (v02 PmRef  HwpLvt   00003000 INTL 20120913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF88810463C000 0005AA (v02 PmRef  ApIst    00003000 INTL 20120913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF88810154DC00 000119 (v02 PmRef  ApHwp    00003000 INTL 20120913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF88810154C400 000119 (v02 PmRef  ApCst    00003000 INTL 20120913)
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
PCI: Using E820 reservations for host bridge windows
ACPI: Enabled 7 GPEs in block 00 to 7F
ACPI: PM: Power Resource [PG00]
ACPI: PM: Power Resource [PG01]
ACPI: PM: Power Resource [PG02]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [FN00]
ACPI: PM: Power Resource [FN01]
ACPI: PM: Power Resource [FN02]
ACPI: PM: Power Resource [FN03]
ACPI: PM: Power Resource [FN04]
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0x8c000000-0xdfffffff window]
pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
pci_bus 0000:00: root bus resource [bus 00-fe]
pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x80 @ 1
pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x80 took 0 usecs
pci 0000:00:00.0: [8086:191f] type 00 class 0x060000
pci 0000:00:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:00.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:01.0: calling  quirk_cmd_compl+0x0/0x110 @ 1
pci 0000:00:01.0: quirk_cmd_compl+0x0/0x110 took 0 usecs
pci 0000:00:01.0: calling  quirk_no_aersid+0x0/0x100 @ 1
pci 0000:00:01.0: quirk_no_aersid+0x0/0x100 took 0 usecs
pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
pci 0000:00:01.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:01.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:01.0: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
pci 0000:00:01.0: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:02.0: [8086:1912] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xde000000-0xdeffffff 64bit]
pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
pci 0000:00:02.0: calling  efifb_fixup_resources+0x0/0x490 @ 1
pci 0000:00:02.0: efifb_fixup_resources+0x0/0x490 took 0 usecs
pci 0000:00:02.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:02.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:02.0: calling  pci_fixup_video+0x0/0x200 @ 1
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:02.0: pci_fixup_video+0x0/0x200 took 1953 usecs
pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
pci 0000:00:14.0: reg 0x10: [mem 0xdf030000-0xdf03ffff 64bit]
pci 0000:00:14.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:14.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
pci 0000:00:14.2: reg 0x10: [mem 0xdf04e000-0xdf04efff 64bit]
pci 0000:00:14.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:14.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
pci 0000:00:16.0: reg 0x10: [mem 0xdf04d000-0xdf04dfff 64bit]
pci 0000:00:16.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:16.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:16.0: PME# supported from D3hot
pci 0000:00:17.0: [8086:a102] type 00 class 0x010601
pci 0000:00:17.0: reg 0x10: [mem 0xdf048000-0xdf049fff]
pci 0000:00:17.0: reg 0x14: [mem 0xdf04c000-0xdf04c0ff]
pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
pci 0000:00:17.0: reg 0x24: [mem 0xdf04b000-0xdf04b7ff]
pci 0000:00:17.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:17.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:17.0: PME# supported from D3hot
pci 0000:00:1c.0: calling  quirk_cmd_compl+0x0/0x110 @ 1
pci 0000:00:1c.0: quirk_cmd_compl+0x0/0x110 took 0 usecs
pci 0000:00:1c.0: calling  quirk_no_aersid+0x0/0x100 @ 1
pci 0000:00:1c.0: quirk_no_aersid+0x0/0x100 took 0 usecs
pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
pci 0000:00:1c.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1c.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1c.0: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
pci 0000:00:1c.0: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1f.0: [8086:a146] type 00 class 0x060100
pci 0000:00:1f.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
pci 0000:00:1f.2: reg 0x10: [mem 0xdf044000-0xdf047fff]
pci 0000:00:1f.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
pci 0000:00:1f.3: reg 0x10: [mem 0xdf040000-0xdf043fff 64bit]
pci 0000:00:1f.3: reg 0x20: [mem 0xdf020000-0xdf02ffff 64bit]
pci 0000:00:1f.3: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.3: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.3: PME# supported from D3hot D3cold
pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
pci 0000:00:1f.4: reg 0x10: [mem 0xdf04a000-0xdf04a0ff 64bit]
pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
pci 0000:00:1f.4: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.4: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.6: calling  quirk_f0_vpd_link+0x0/0x210 @ 1
pci 0000:00:1f.6: quirk_f0_vpd_link+0x0/0x210 took 0 usecs
pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
pci 0000:00:1f.6: reg 0x10: [mem 0xdf000000-0xdf01ffff]
pci 0000:00:1f.6: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.6: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:02:00.0: [104c:8240] type 01 class 0x060400
pci 0000:02:00.0: supports D1 D2
pci 0000:00:1c.0: PCI bridge to [bus 02-03]
pci_bus 0000:03: extended config space not accessible
pci 0000:02:00.0: PCI bridge to [bus 03]
ACPI: PCI: Interrupt link LNKA configured for IRQ 7
ACPI: PCI: Interrupt link LNKA disabled
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKB disabled
ACPI: PCI: Interrupt link LNKC configured for IRQ 5
ACPI: PCI: Interrupt link LNKC disabled
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKD disabled
ACPI: PCI: Interrupt link LNKE configured for IRQ 7
ACPI: PCI: Interrupt link LNKE disabled
ACPI: PCI: Interrupt link LNKF configured for IRQ 3
ACPI: PCI: Interrupt link LNKF disabled
ACPI: PCI: Interrupt link LNKG configured for IRQ 4
ACPI: PCI: Interrupt link LNKG disabled
ACPI: PCI: Interrupt link LNKH configured for IRQ 11
ACPI: PCI: Interrupt link LNKH disabled
initcall acpi_init+0x0/0x26d returned 0 after 1142000 usecs
calling  adxl_init+0x0/0x24c @ 1
initcall adxl_init+0x0/0x24c returned -19 after 0 usecs
calling  pnp_init+0x0/0x11 @ 1
initcall pnp_init+0x0/0x11 returned 0 after 0 usecs
calling  misc_init+0x0/0xe4 @ 1
initcall misc_init+0x0/0xe4 returned 0 after 0 usecs
calling  tpm_init+0x0/0x218 @ 1
initcall tpm_init+0x0/0x218 returned 0 after 0 usecs
calling  iommu_subsys_init+0x0/0x1a5 @ 1
iommu: Default domain type: Translated 
iommu: DMA domain TLB invalidation policy: lazy mode 
initcall iommu_subsys_init+0x0/0x1a5 returned 0 after 2000 usecs
calling  cn_init+0x0/0x180 @ 1
initcall cn_init+0x0/0x180 returned 0 after 0 usecs
calling  dax_core_init+0x0/0xe3 @ 1
initcall dax_core_init+0x0/0xe3 returned 0 after 0 usecs
calling  dma_buf_init+0x0/0xc7 @ 1
initcall dma_buf_init+0x0/0xc7 returned 0 after 0 usecs
calling  init_scsi+0x0/0x88 @ 1
SCSI subsystem initialized
initcall init_scsi+0x0/0x88 returned 0 after 2000 usecs
calling  phy_init+0x0/0x65 @ 1
initcall phy_init+0x0/0x65 returned 0 after 0 usecs
calling  usb_common_init+0x0/0x1d @ 1
initcall usb_common_init+0x0/0x1d returned 0 after 0 usecs
calling  usb_init+0x0/0x150 @ 1
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
initcall usb_init+0x0/0x150 returned 0 after 6000 usecs
calling  xdbc_init+0x0/0x151 @ 1
initcall xdbc_init+0x0/0x151 returned 0 after 0 usecs
calling  typec_init+0x0/0xae @ 1
initcall typec_init+0x0/0xae returned 0 after 1000 usecs
calling  serio_init+0x0/0x2e @ 1
initcall serio_init+0x0/0x2e returned 0 after 0 usecs
calling  input_init+0x0/0x104 @ 1
initcall input_init+0x0/0x104 returned 0 after 0 usecs
calling  rtc_init+0x0/0x71 @ 1
initcall rtc_init+0x0/0x71 returned 0 after 0 usecs
calling  pps_init+0x0/0xd6 @ 1
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
initcall pps_init+0x0/0xd6 returned 0 after 3000 usecs
calling  ptp_init+0x0/0xc0 @ 1
PTP clock support registered
initcall ptp_init+0x0/0xc0 returned 0 after 1000 usecs
calling  power_supply_class_init+0x0/0x64 @ 1
initcall power_supply_class_init+0x0/0x64 returned 0 after 0 usecs
calling  hwmon_init+0x0/0x178 @ 1
initcall hwmon_init+0x0/0x178 returned 0 after 0 usecs
calling  md_init+0x0/0x15c @ 1
initcall md_init+0x0/0x15c returned 0 after 0 usecs
calling  edac_init+0x0/0x76 @ 1
EDAC MC: Ver: 3.0.0
initcall edac_init+0x0/0x76 returned 0 after 1000 usecs
calling  leds_init+0x0/0x7f @ 1
initcall leds_init+0x0/0x7f returned 0 after 0 usecs
calling  dmi_init+0x0/0x142 @ 1
initcall dmi_init+0x0/0x142 returned 0 after 1000 usecs
calling  efisubsys_init+0x0/0x272 @ 1
initcall efisubsys_init+0x0/0x272 returned 0 after 0 usecs
calling  ras_init+0x0/0xf @ 1
initcall ras_init+0x0/0xf returned 0 after 0 usecs
calling  nvmem_init+0x0/0x11 @ 1
initcall nvmem_init+0x0/0x11 returned 0 after 0 usecs
calling  proto_init+0x0/0x11 @ 1
initcall proto_init+0x0/0x11 returned 0 after 0 usecs
calling  net_dev_init+0x0/0x77d @ 1
initcall net_dev_init+0x0/0x77d returned 0 after 0 usecs
calling  neigh_init+0x0/0x85 @ 1
initcall neigh_init+0x0/0x85 returned 0 after 0 usecs
calling  fib_notifier_init+0x0/0x11 @ 1
initcall fib_notifier_init+0x0/0x11 returned 0 after 0 usecs
calling  fib_rules_init+0x0/0xb2 @ 1
initcall fib_rules_init+0x0/0xb2 returned 0 after 0 usecs
calling  init_cgroup_netprio+0x0/0x14 @ 1
initcall init_cgroup_netprio+0x0/0x14 returned 0 after 0 usecs
calling  bpf_lwt_init+0x0/0x16 @ 1
initcall bpf_lwt_init+0x0/0x16 returned 0 after 0 usecs
calling  pktsched_init+0x0/0x113 @ 1
initcall pktsched_init+0x0/0x113 returned 0 after 0 usecs
calling  tc_filter_init+0x0/0x100 @ 1
initcall tc_filter_init+0x0/0x100 returned 0 after 0 usecs
calling  tc_action_init+0x0/0x55 @ 1
initcall tc_action_init+0x0/0x55 returned 0 after 0 usecs
calling  ethnl_init+0x0/0x58 @ 1
initcall ethnl_init+0x0/0x58 returned 0 after 0 usecs
calling  nexthop_init+0x0/0xf6 @ 1
initcall nexthop_init+0x0/0xf6 returned 0 after 1000 usecs
calling  cipso_v4_init+0x0/0x114 @ 1
initcall cipso_v4_init+0x0/0x114 returned 0 after 0 usecs
calling  wireless_nlevent_init+0x0/0x3f @ 1
initcall wireless_nlevent_init+0x0/0x3f returned 0 after 0 usecs
calling  netlbl_init+0x0/0x88 @ 1
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
initcall netlbl_init+0x0/0x88 returned 0 after 5000 usecs
calling  pci_subsys_init+0x0/0x11e @ 1
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
e820: reserve RAM buffer [mem 0x77b41000-0x77ffffff]
e820: reserve RAM buffer [mem 0x77bbe000-0x77ffffff]
e820: reserve RAM buffer [mem 0x86f57000-0x87ffffff]
e820: reserve RAM buffer [mem 0x872000000-0x873ffffff]
initcall pci_subsys_init+0x0/0x11e returned 0 after 35000 usecs
calling  vsprintf_init_hashval+0x0/0xa @ 1
initcall vsprintf_init_hashval+0x0/0xa returned 0 after 0 usecs
calling  vga_arb_device_init+0x0/0x77 @ 1
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: bridge control possible
pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
initcall vga_arb_device_init+0x0/0x77 returned 0 after 2000 usecs
calling  watchdog_init+0x0/0x137 @ 1
initcall watchdog_init+0x0/0x137 returned 0 after 0 usecs
calling  nmi_warning_debugfs+0x0/0x4d @ 1
initcall nmi_warning_debugfs+0x0/0x4d returned 0 after 0 usecs
calling  save_microcode_in_initrd+0x0/0xc3 @ 1
initcall save_microcode_in_initrd+0x0/0xc3 returned 0 after 0 usecs
calling  hpet_late_init+0x0/0x16f @ 1
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 24.000000 MHz counter
initcall hpet_late_init+0x0/0x16f returned 0 after 5000 usecs
calling  iomem_init_inode+0x0/0xa7 @ 1
initcall iomem_init_inode+0x0/0xa7 returned 0 after 0 usecs
calling  clocksource_done_booting+0x0/0x42 @ 1
clocksource: Switched to clocksource tsc-early
initcall clocksource_done_booting+0x0/0x42 returned 0 after 6249 usecs
calling  tracer_init_tracefs+0x0/0x151 @ 1
initcall tracer_init_tracefs+0x0/0x151 returned 0 after 9 usecs
calling  init_trace_printk_function_export+0x0/0x28 @ 1
initcall init_trace_printk_function_export+0x0/0x28 returned 0 after 6 usecs
calling  init_graph_tracefs+0x0/0x28 @ 1
initcall init_graph_tracefs+0x0/0x28 returned 0 after 6 usecs
calling  trace_events_synth_init+0x0/0x47 @ 1
initcall trace_events_synth_init+0x0/0x47 returned 0 after 5 usecs
calling  bpf_event_init+0x0/0xf @ 1
initcall bpf_event_init+0x0/0xf returned 0 after 0 usecs
calling  init_kprobe_trace+0x0/0x30c @ 1
initcall init_kprobe_trace+0x0/0x30c returned 0 after 12 usecs
calling  init_dynamic_event+0x0/0x28 @ 1
initcall init_dynamic_event+0x0/0x28 returned 0 after 5 usecs
calling  init_uprobe_trace+0x0/0x5c @ 1
initcall init_uprobe_trace+0x0/0x5c returned 0 after 15 usecs
calling  bpf_init+0x0/0x99 @ 1
initcall bpf_init+0x0/0x99 returned 0 after 7 usecs
calling  btf_module_init+0x0/0x1f @ 1
initcall btf_module_init+0x0/0x1f returned 0 after 0 usecs
calling  secretmem_init+0x0/0x5c @ 1
initcall secretmem_init+0x0/0x5c returned 0 after 0 usecs
calling  init_fs_stat_sysctls+0x0/0x2e @ 1
initcall init_fs_stat_sysctls+0x0/0x2e returned 0 after 11 usecs
calling  init_fs_exec_sysctls+0x0/0x22 @ 1
initcall init_fs_exec_sysctls+0x0/0x22 returned 0 after 3 usecs
calling  init_pipe_fs+0x0/0x64 @ 1
initcall init_pipe_fs+0x0/0x64 returned 0 after 42 usecs
calling  init_fs_namei_sysctls+0x0/0x22 @ 1
initcall init_fs_namei_sysctls+0x0/0x22 returned 0 after 6 usecs
calling  init_fs_dcache_sysctls+0x0/0x22 @ 1
initcall init_fs_dcache_sysctls+0x0/0x22 returned 0 after 2 usecs
calling  init_fs_namespace_sysctls+0x0/0x22 @ 1
initcall init_fs_namespace_sysctls+0x0/0x22 returned 0 after 2 usecs
calling  cgroup_writeback_init+0x0/0x26 @ 1
initcall cgroup_writeback_init+0x0/0x26 returned 0 after 7 usecs
calling  inotify_user_setup+0x0/0x18a @ 1
initcall inotify_user_setup+0x0/0x18a returned 0 after 23 usecs
calling  eventpoll_init+0x0/0x141 @ 1
initcall eventpoll_init+0x0/0x141 returned 0 after 30 usecs
calling  anon_inode_init+0x0/0x8a @ 1
initcall anon_inode_init+0x0/0x8a returned 0 after 36 usecs
calling  init_dax_wait_table+0x0/0x34 @ 1
initcall init_dax_wait_table+0x0/0x34 returned 0 after 14 usecs
calling  proc_locks_init+0x0/0x28 @ 1
initcall proc_locks_init+0x0/0x28 returned 0 after 4 usecs
calling  init_fs_coredump_sysctls+0x0/0x22 @ 1
initcall init_fs_coredump_sysctls+0x0/0x22 returned 0 after 5 usecs
calling  iomap_init+0x0/0x20 @ 1
initcall iomap_init+0x0/0x20 returned 0 after 119 usecs
calling  dquot_init+0x0/0x163 @ 1
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
initcall dquot_init+0x0/0x163 returned 0 after 12327 usecs
calling  quota_init+0x0/0x24 @ 1
initcall quota_init+0x0/0x24 returned 0 after 32 usecs
calling  proc_cmdline_init+0x0/0x22 @ 1
initcall proc_cmdline_init+0x0/0x22 returned 0 after 3 usecs
calling  proc_consoles_init+0x0/0x25 @ 1
initcall proc_consoles_init+0x0/0x25 returned 0 after 3 usecs
calling  proc_cpuinfo_init+0x0/0x1f @ 1
initcall proc_cpuinfo_init+0x0/0x1f returned 0 after 2 usecs
calling  proc_devices_init+0x0/0x5e @ 1
initcall proc_devices_init+0x0/0x5e returned 0 after 2 usecs
calling  proc_interrupts_init+0x0/0x25 @ 1
initcall proc_interrupts_init+0x0/0x25 returned 0 after 2 usecs
calling  proc_loadavg_init+0x0/0x5b @ 1
initcall proc_loadavg_init+0x0/0x5b returned 0 after 2 usecs
calling  proc_meminfo_init+0x0/0x5b @ 1
initcall proc_meminfo_init+0x0/0x5b returned 0 after 2 usecs
calling  proc_stat_init+0x0/0x1f @ 1
initcall proc_stat_init+0x0/0x1f returned 0 after 3 usecs
calling  proc_uptime_init+0x0/0x5b @ 1
initcall proc_uptime_init+0x0/0x5b returned 0 after 2 usecs
calling  proc_version_init+0x0/0x5b @ 1
initcall proc_version_init+0x0/0x5b returned 0 after 2 usecs
calling  proc_softirqs_init+0x0/0x5b @ 1
initcall proc_softirqs_init+0x0/0x5b returned 0 after 2 usecs
calling  proc_kcore_init+0x0/0x142 @ 1
initcall proc_kcore_init+0x0/0x142 returned 0 after 25 usecs
calling  vmcore_init+0x0/0x2b9 @ 1
initcall vmcore_init+0x0/0x2b9 returned 0 after 0 usecs
calling  proc_kmsg_init+0x0/0x22 @ 1
initcall proc_kmsg_init+0x0/0x22 returned 0 after 2 usecs
calling  proc_page_init+0x0/0x56 @ 1
initcall proc_page_init+0x0/0x56 returned 0 after 46 usecs
calling  init_ramfs_fs+0x0/0x11 @ 1
initcall init_ramfs_fs+0x0/0x11 returned 0 after 0 usecs
calling  init_hugetlbfs_fs+0x0/0x2a0 @ 1
initcall init_hugetlbfs_fs+0x0/0x2a0 returned 0 after 89 usecs
calling  dynamic_debug_init_control+0x0/0x7c @ 1
initcall dynamic_debug_init_control+0x0/0x7c returned 0 after 23 usecs
calling  acpi_event_init+0x0/0x61 @ 1
initcall acpi_event_init+0x0/0x61 returned 0 after 34 usecs
calling  pnp_system_init+0x0/0x11 @ 1
initcall pnp_system_init+0x0/0x11 returned 0 after 40 usecs
calling  pnpacpi_init+0x0/0xd2 @ 1
pnp: PnP ACPI init
system 00:00: [io  0x0a00-0x0a3f] has been reserved
system 00:00: [io  0x0a40-0x0a7f] has been reserved
pnp 00:01: [dma 0 disabled]
system 00:02: [io  0x0680-0x069f] has been reserved
system 00:02: [io  0xffff] has been reserved
system 00:02: [io  0xffff] has been reserved
system 00:02: [io  0xffff] has been reserved
system 00:02: [io  0x1800-0x18fe] has been reserved
system 00:02: [io  0x164e-0x164f] has been reserved
system 00:03: [io  0x0800-0x087f] has been reserved
system 00:05: [io  0x1854-0x1857] has been reserved
system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:06: [mem 0xfed90000-0xfed93fff] could not be reserved
system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
system 00:06: [mem 0xff000000-0xffffffff] has been reserved
system 00:06: [mem 0xfee00000-0xfeefffff] could not be reserved
system 00:06: [mem 0xdffe0000-0xdfffffff] has been reserved
system 00:07: [mem 0xfd000000-0xfdabffff] has been reserved
system 00:07: [mem 0xfdad0000-0xfdadffff] has been reserved
system 00:07: [mem 0xfdb00000-0xfdffffff] has been reserved
system 00:07: [mem 0xfe000000-0xfe01ffff] could not be reserved
system 00:07: [mem 0xfe036000-0xfe03bfff] has been reserved
system 00:07: [mem 0xfe03d000-0xfe3fffff] has been reserved
system 00:07: [mem 0xfe410000-0xfe7fffff] has been reserved
system 00:08: [io  0xff00-0xfffe] has been reserved
system 00:09: [mem 0xfdaf0000-0xfdafffff] has been reserved
system 00:09: [mem 0xfdae0000-0xfdaeffff] has been reserved
system 00:09: [mem 0xfdac0000-0xfdacffff] has been reserved
pnp: PnP ACPI: found 10 devices
initcall pnpacpi_init+0x0/0xd2 returned 0 after 272473 usecs
calling  chr_dev_init+0x0/0x131 @ 1
initcall chr_dev_init+0x0/0x131 returned 0 after 5867 usecs
calling  hwrng_modinit+0x0/0xe6 @ 1
initcall hwrng_modinit+0x0/0xe6 returned 0 after 129 usecs
calling  firmware_class_init+0x0/0xfa @ 1
initcall firmware_class_init+0x0/0xfa returned 0 after 27 usecs
calling  init_acpi_pm_clocksource+0x0/0xd2 @ 1
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
initcall init_acpi_pm_clocksource+0x0/0xd2 returned 0 after 14118 usecs
calling  powercap_init+0x0/0x22 @ 1
initcall powercap_init+0x0/0x22 returned 0 after 151 usecs
calling  sysctl_core_init+0x0/0x2b @ 1
initcall sysctl_core_init+0x0/0x2b returned 0 after 24 usecs
calling  eth_offload_init+0x0/0x14 @ 1
initcall eth_offload_init+0x0/0x14 returned 0 after 0 usecs
calling  ipv4_offload_init+0x0/0x74 @ 1
initcall ipv4_offload_init+0x0/0x74 returned 0 after 0 usecs
calling  inet_init+0x0/0x341 @ 1
NET: Registered PF_INET protocol family
IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
TCP: Hash tables configured (established 262144 bind 65536)
UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
initcall inet_init+0x0/0x341 returned 0 after 77461 usecs
calling  af_unix_init+0x0/0x1a3 @ 1
NET: Registered PF_UNIX/PF_LOCAL protocol family
initcall af_unix_init+0x0/0x1a3 returned 0 after 6444 usecs
calling  ipv6_offload_init+0x0/0x7f @ 1
initcall ipv6_offload_init+0x0/0x7f returned 0 after 0 usecs
calling  init_sunrpc+0x0/0x88 @ 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
initcall init_sunrpc+0x0/0x88 returned 0 after 25176 usecs
calling  vlan_offload_init+0x0/0x20 @ 1
initcall vlan_offload_init+0x0/0x20 returned 0 after 0 usecs
calling  xsk_init+0x0/0x1b8 @ 1
NET: Registered PF_XDP protocol family
initcall xsk_init+0x0/0x1b8 returned 0 after 5546 usecs
calling  pcibios_assign_resources+0x0/0x236 @ 1
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:02:00.0: PCI bridge to [bus 03]
pci 0000:00:1c.0: PCI bridge to [bus 02-03]
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0x8c000000-0xdfffffff window]
pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
initcall pcibios_assign_resources+0x0/0x236 returned 0 after 55024 usecs
calling  pci_apply_final_quirks+0x0/0x32c @ 1
pci 0000:00:14.0: calling  quirk_usb_early_handoff+0x0/0x2d0 @ 1
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-18 -> IRQ 18 Level:1 ActiveLow:1)
pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x2d0 took 24942 usecs
pci 0000:00:1f.6: calling  quirk_e100_interrupt+0x0/0x290 @ 1
pci 0000:00:1f.6: quirk_e100_interrupt+0x0/0x290 took 0 usecs
PCI: CLS 0 bytes, default 64
initcall pci_apply_final_quirks+0x0/0x32c returned 0 after 61340 usecs
calling  acpi_reserve_resources+0x0/0x273 @ 1
initcall acpi_reserve_resources+0x0/0x273 returned 0 after 17 usecs
calling  populate_rootfs+0x0/0x3c @ 1
initcall populate_rootfs+0x0/0x3c returned 0 after 6 usecs
Trying to unpack rootfs image as initramfs...
calling  pci_iommu_init+0x0/0x55 @ 1
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x0000000082f57000-0x0000000086f57000] (64MB)
initcall pci_iommu_init+0x0/0x55 returned 0 after 29495 usecs
calling  ir_dev_scope_init+0x0/0x6d @ 1
initcall ir_dev_scope_init+0x0/0x6d returned 0 after 7 usecs
calling  ia32_binfmt_init+0x0/0x14 @ 1
initcall ia32_binfmt_init+0x0/0x14 returned 0 after 10 usecs
calling  amd_ibs_init+0x0/0xf6 @ 1
initcall amd_ibs_init+0x0/0xf6 returned -19 after 0 usecs
calling  msr_init+0x0/0x7c @ 1
initcall msr_init+0x0/0x7c returned 0 after 6 usecs
calling  register_kernel_offset_dumper+0x0/0x1b @ 1
initcall register_kernel_offset_dumper+0x0/0x1b returned 0 after 0 usecs
calling  i8259A_init_ops+0x0/0x21 @ 1
initcall i8259A_init_ops+0x0/0x21 returned 0 after 0 usecs
calling  init_tsc_clocksource+0x0/0xe2 @ 1
initcall init_tsc_clocksource+0x0/0xe2 returned 0 after 2 usecs
calling  add_rtc_cmos+0x0/0x1f0 @ 1
initcall add_rtc_cmos+0x0/0x1f0 returned 0 after 2 usecs
calling  i8237A_init_ops+0x0/0x37 @ 1
initcall i8237A_init_ops+0x0/0x37 returned -19 after 2 usecs
calling  umwait_init+0x0/0xdd @ 1
initcall umwait_init+0x0/0xdd returned -19 after 0 usecs
calling  msr_init+0x0/0xfd @ 1
initcall msr_init+0x0/0xfd returned 0 after 1048 usecs
calling  cpuid_init+0x0/0xfd @ 1
initcall cpuid_init+0x0/0xfd returned 0 after 824 usecs
calling  ioapic_init_ops+0x0/0x14 @ 1
initcall ioapic_init_ops+0x0/0x14 returned 0 after 0 usecs
calling  register_e820_pmem+0x0/0x5e @ 1
initcall register_e820_pmem+0x0/0x5e returned 0 after 3 usecs
calling  add_pcspkr+0x0/0xcf @ 1
initcall add_pcspkr+0x0/0xcf returned 0 after 76 usecs
calling  start_periodic_check_for_corruption+0x0/0x30 @ 1
initcall start_periodic_check_for_corruption+0x0/0x30 returned 0 after 0 usecs
calling  audit_classes_init+0x0/0xaf @ 1
initcall audit_classes_init+0x0/0xaf returned 0 after 26 usecs
calling  sha1_ssse3_mod_init+0x0/0xe7 @ 1
initcall sha1_ssse3_mod_init+0x0/0xe7 returned 0 after 25 usecs
calling  sha256_ssse3_mod_init+0x0/0xfb @ 1
initcall sha256_ssse3_mod_init+0x0/0xfb returned 0 after 29 usecs
calling  iosf_mbi_init+0x0/0x29 @ 1
initcall iosf_mbi_init+0x0/0x29 returned 0 after 48 usecs
calling  proc_execdomains_init+0x0/0x22 @ 1
initcall proc_execdomains_init+0x0/0x22 returned 0 after 5 usecs
calling  register_warn_debugfs+0x0/0x24 @ 1
initcall register_warn_debugfs+0x0/0x24 returned 0 after 10 usecs
calling  cpuhp_sysfs_init+0x0/0x140 @ 1
initcall cpuhp_sysfs_init+0x0/0x140 returned 0 after 58 usecs
calling  ioresources_init+0x0/0x4a @ 1
initcall ioresources_init+0x0/0x4a returned 0 after 7 usecs
calling  snapshot_device_init+0x0/0x11 @ 1
initcall snapshot_device_init+0x0/0x11 returned 0 after 90 usecs
calling  irq_pm_init_ops+0x0/0x14 @ 1
initcall irq_pm_init_ops+0x0/0x14 returned 0 after 0 usecs
calling  klp_init+0x0/0x4f @ 1
initcall klp_init+0x0/0x4f returned 0 after 8 usecs
calling  proc_modules_init+0x0/0x1f @ 1
initcall proc_modules_init+0x0/0x1f returned 0 after 5 usecs
calling  timer_sysctl_init+0x0/0x1b @ 1
initcall timer_sysctl_init+0x0/0x1b returned 0 after 14 usecs
calling  timekeeping_init_ops+0x0/0x14 @ 1
initcall timekeeping_init_ops+0x0/0x14 returned 0 after 0 usecs
calling  init_clocksource_sysfs+0x0/0x24 @ 1
initcall init_clocksource_sysfs+0x0/0x24 returned 0 after 129 usecs
calling  init_timer_list_procfs+0x0/0x32 @ 1
initcall init_timer_list_procfs+0x0/0x32 returned 0 after 5 usecs
calling  alarmtimer_init+0x0/0x105 @ 1
initcall alarmtimer_init+0x0/0x105 returned 0 after 34 usecs
calling  init_posix_timers+0x0/0x2a @ 1
initcall init_posix_timers+0x0/0x2a returned 0 after 20 usecs
calling  clockevents_init_sysfs+0x0/0x19a @ 1
initcall clockevents_init_sysfs+0x0/0x19a returned 0 after 290 usecs
calling  proc_dma_init+0x0/0x22 @ 1
initcall proc_dma_init+0x0/0x22 returned 0 after 4 usecs
calling  kallsyms_init+0x0/0x22 @ 1
initcall kallsyms_init+0x0/0x22 returned 0 after 4 usecs
calling  pid_namespaces_init+0x0/0x40 @ 1
initcall pid_namespaces_init+0x0/0x40 returned 0 after 30 usecs
calling  ikconfig_init+0x0/0x42 @ 1
initcall ikconfig_init+0x0/0x42 returned 0 after 4 usecs
calling  audit_watch_init+0x0/0x3c @ 1
initcall audit_watch_init+0x0/0x3c returned 0 after 10 usecs
calling  audit_fsnotify_init+0x0/0x3f @ 1
initcall audit_fsnotify_init+0x0/0x3f returned 0 after 2 usecs
calling  audit_tree_init+0x0/0xcb @ 1
initcall audit_tree_init+0x0/0xcb returned 0 after 23 usecs
calling  seccomp_sysctl_init+0x0/0x2c @ 1
initcall seccomp_sysctl_init+0x0/0x2c returned 0 after 14 usecs
calling  utsname_sysctl_init+0x0/0x14 @ 1
initcall utsname_sysctl_init+0x0/0x14 returned 0 after 13 usecs
calling  init_tracepoints+0x0/0x2c @ 1
initcall init_tracepoints+0x0/0x2c returned 0 after 1 usecs
calling  init_lstats_procfs+0x0/0x3c @ 1
initcall init_lstats_procfs+0x0/0x3c returned 0 after 16 usecs
calling  stack_trace_init+0x0/0xa4 @ 1
initcall stack_trace_init+0x0/0xa4 returned 0 after 20 usecs
calling  perf_event_sysfs_init+0x0/0x106 @ 1
initcall perf_event_sysfs_init+0x0/0x106 returned 0 after 675 usecs
calling  system_trusted_keyring_init+0x0/0x8a @ 1
Initialise system trusted keyrings
initcall system_trusted_keyring_init+0x0/0x8a returned 0 after 5206 usecs
calling  blacklist_init+0x0/0x162 @ 1
Key type blacklist registered
initcall blacklist_init+0x0/0x162 returned 0 after 4808 usecs
calling  kswapd_init+0x0/0x60 @ 1
initcall kswapd_init+0x0/0x60 returned 0 after 70 usecs
calling  extfrag_debug_init+0x0/0x57 @ 1
initcall extfrag_debug_init+0x0/0x57 returned 0 after 20 usecs
calling  mm_compute_batch_init+0x0/0x53 @ 1
initcall mm_compute_batch_init+0x0/0x53 returned 0 after 1 usecs
calling  slab_proc_init+0x0/0x22 @ 1
initcall slab_proc_init+0x0/0x22 returned 0 after 5 usecs
calling  workingset_init+0x0/0xd0 @ 1
workingset: timestamp_bits=36 max_order=23 bucket_order=0
initcall workingset_init+0x0/0xd0 returned 0 after 7190 usecs
calling  proc_vmalloc_init+0x0/0x64 @ 1
initcall proc_vmalloc_init+0x0/0x64 returned 0 after 9 usecs
calling  procswaps_init+0x0/0x1f @ 1
initcall procswaps_init+0x0/0x1f returned 0 after 4 usecs
calling  init_frontswap+0x0/0x93 @ 1
initcall init_frontswap+0x0/0x93 returned 0 after 35 usecs
calling  slab_sysfs_init+0x0/0xee @ 1
initcall slab_sysfs_init+0x0/0xee returned 0 after 12015 usecs
calling  slab_debugfs_init+0x0/0x4e @ 1
initcall slab_debugfs_init+0x0/0x4e returned 0 after 15 usecs
calling  init_zbud+0x0/0x20 @ 1
zbud: loaded
initcall init_zbud+0x0/0x20 returned 0 after 3302 usecs
calling  zs_init+0x0/0x73 @ 1
initcall zs_init+0x0/0x73 returned 0 after 26 usecs
calling  fcntl_init+0x0/0x2a @ 1
initcall fcntl_init+0x0/0x2a returned 0 after 115 usecs
calling  proc_filesystems_init+0x0/0x22 @ 1
initcall proc_filesystems_init+0x0/0x22 returned 0 after 5 usecs
calling  start_dirtytime_writeback+0x0/0x17 @ 1
initcall start_dirtytime_writeback+0x0/0x17 returned 0 after 1 usecs
calling  dio_init+0x0/0x2d @ 1
initcall dio_init+0x0/0x2d returned 0 after 108 usecs
calling  dnotify_init+0x0/0x9d @ 1
initcall dnotify_init+0x0/0x9d returned 0 after 205 usecs
calling  fanotify_user_setup+0x0/0x1f7 @ 1
initcall fanotify_user_setup+0x0/0x1f7 returned 0 after 363 usecs
calling  aio_setup+0x0/0x98 @ 1
initcall aio_setup+0x0/0x98 returned 0 after 228 usecs
calling  mbcache_init+0x0/0x31 @ 1
initcall mbcache_init+0x0/0x31 returned 0 after 91 usecs
calling  init_grace+0x0/0x11 @ 1
initcall init_grace+0x0/0x11 returned 0 after 3 usecs
calling  init_v2_quota_format+0x0/0x22 @ 1
initcall init_v2_quota_format+0x0/0x22 returned 0 after 0 usecs
calling  init_devpts_fs+0x0/0x2c @ 1
initcall init_devpts_fs+0x0/0x2c returned 0 after 18 usecs
calling  ext4_init_fs+0x0/0x19f @ 1
initcall ext4_init_fs+0x0/0x19f returned 0 after 1257 usecs
calling  journal_init+0x0/0x12e @ 1
initcall journal_init+0x0/0x12e returned 0 after 544 usecs
calling  init_nfs_fs+0x0/0x191 @ 1
initcall init_nfs_fs+0x0/0x191 returned 0 after 807 usecs
calling  init_nfs_v3+0x0/0x14 @ 1
initcall init_nfs_v3+0x0/0x14 returned 0 after 0 usecs
calling  init_nlm+0x0/0x62 @ 1
initcall init_nlm+0x0/0x62 returned 0 after 29 usecs
calling  init_nls_cp437+0x0/0x13 @ 1
initcall init_nls_cp437+0x0/0x13 returned 0 after 0 usecs
calling  init_nls_ascii+0x0/0x13 @ 1
initcall init_nls_ascii+0x0/0x13 returned 0 after 0 usecs
calling  init_autofs_fs+0x0/0x2a @ 1
initcall init_autofs_fs+0x0/0x2a returned 0 after 106 usecs
calling  init_v9fs+0x0/0x10f @ 1
9p: Installing v9fs 9p2000 file system support
initcall init_v9fs+0x0/0x10f returned 0 after 6337 usecs
calling  efivarfs_init+0x0/0x21 @ 1
initcall efivarfs_init+0x0/0x21 returned -19 after 0 usecs
calling  ipc_init+0x0/0x25 @ 1
initcall ipc_init+0x0/0x25 returned 0 after 33 usecs
calling  ipc_sysctl_init+0x0/0x2d @ 1
initcall ipc_sysctl_init+0x0/0x2d returned 0 after 34 usecs
calling  init_mqueue_fs+0x0/0xeb @ 1
initcall init_mqueue_fs+0x0/0xeb returned 0 after 162 usecs
tsc: Refined TSC clocksource calibration: 3191.999 MHz
calling  key_proc_init+0x0/0x6e @ 1
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e02c398820, max_idle_ns: 440795273435 ns
initcall key_proc_init+0x0/0x6e returned 0 after 13 usecs
calling  jent_mod_init+0x0/0x2e @ 1
clocksource: Switched to clocksource tsc
initcall jent_mod_init+0x0/0x2e returned 0 after 6987 usecs
calling  af_alg_init+0x0/0x41 @ 1
NET: Registered PF_ALG protocol family
initcall af_alg_init+0x0/0x41 returned 0 after 5651 usecs
calling  algif_hash_init+0x0/0x11 @ 1
initcall algif_hash_init+0x0/0x11 returned 0 after 2 usecs
calling  algif_skcipher_init+0x0/0x11 @ 1
initcall algif_skcipher_init+0x0/0x11 returned 0 after 2 usecs
calling  rng_init+0x0/0x11 @ 1
initcall rng_init+0x0/0x11 returned 0 after 2 usecs
calling  algif_aead_init+0x0/0x11 @ 1
initcall algif_aead_init+0x0/0x11 returned 0 after 2 usecs
calling  asymmetric_key_init+0x0/0x11 @ 1
Key type asymmetric registered
initcall asymmetric_key_init+0x0/0x11 returned 0 after 4880 usecs
calling  x509_key_init+0x0/0x19 @ 1
Asymmetric key parser 'x509' registered
initcall x509_key_init+0x0/0x19 returned 0 after 5652 usecs
calling  blkdev_init+0x0/0x20 @ 1
initcall blkdev_init+0x0/0x20 returned 0 after 25 usecs
calling  proc_genhd_init+0x0/0x42 @ 1
initcall proc_genhd_init+0x0/0x42 returned 0 after 8 usecs
calling  bsg_init+0x0/0x117 @ 1
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
initcall bsg_init+0x0/0x117 returned 0 after 8186 usecs
calling  throtl_init+0x0/0x41 @ 1
initcall throtl_init+0x0/0x41 returned 0 after 111 usecs
calling  deadline_init+0x0/0x11 @ 1
io scheduler mq-deadline registered
initcall deadline_init+0x0/0x11 returned 0 after 5323 usecs
calling  kyber_init+0x0/0x11 @ 1
io scheduler kyber registered
initcall kyber_init+0x0/0x11 returned 0 after 4781 usecs
calling  bfq_init+0x0/0x8b @ 1
io scheduler bfq registered
initcall bfq_init+0x0/0x8b returned 0 after 4831 usecs
calling  io_uring_init+0x0/0x32 @ 1
initcall io_uring_init+0x0/0x32 returned 0 after 117 usecs
calling  blake2s_mod_init+0x0/0x8 @ 1
initcall blake2s_mod_init+0x0/0x8 returned 0 after 0 usecs
calling  crc_t10dif_mod_init+0x0/0x4c @ 1
initcall crc_t10dif_mod_init+0x0/0x4c returned 0 after 187 usecs
calling  percpu_counter_startup+0x0/0x51 @ 1
initcall percpu_counter_startup+0x0/0x51 returned 0 after 32 usecs
calling  digsig_init+0x0/0x39 @ 1
initcall digsig_init+0x0/0x39 returned 0 after 89 usecs
calling  pcie_portdrv_init+0x0/0x49 @ 1
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
==================================================================
BUG: KASAN: slab-out-of-bounds in __bitmap_set+0xcb/0xe0
Read of size 8 at addr ffff88810023a000 by task swapper/0/1

CPU: 2 PID: 1 Comm: swapper/0 Tainted: G          I        6.1.0-rc2-00194-g8cbe83be2e63 #1
Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x44
print_address_description+0x87/0x2a1
print_report+0x103/0x1e9
? kasan_addr_to_slab+0x9/0xa0
? __bitmap_set+0xcb/0xe0
kasan_report+0xae/0xe0
? __bitmap_set+0xcb/0xe0
__bitmap_set+0xcb/0xe0
bitmap_find_free_region+0x6f/0x90
intel_irq_remapping_alloc+0x266/0x1660
? local_pci_probe+0xdc/0x170
? pci_call_probe+0x182/0x500
? driver_probe_device+0x49/0x120
? __driver_attach+0x178/0x4b0
? bus_add_driver+0x423/0x570
? do_one_initcall+0x87/0x2c0
? do_initcalls+0x1d2/0x202
? kernel_init_freeable+0x434/0x4a3
? kernel_init+0x19/0x140
? ret_from_fork+0x1f/0x30
? intel_irq_remapping_free+0x30/0x30
? __irq_domain_alloc_irqs+0x14a/0x980
? __irq_domain_alloc_irqs+0x14a/0x980
msi_domain_alloc+0x13a/0x300
? msi_domain_free+0x150/0x150
? __mutex_lock_slowpath+0x10/0x10
__irq_domain_alloc_irqs+0x274/0x980
__msi_domain_alloc_irqs+0x344/0xcd0
? _raw_write_lock_irq+0xd0/0xd0
? msi_domain_prepare_irqs+0x110/0x110
? xa_find+0x165/0x1a0
msi_domain_alloc_irqs_descs_locked+0xc2/0x220
? msi_find_desc+0x35/0x120
__pci_enable_msi_range+0x5a1/0xb70
? pci_disable_msi+0x60/0x60
? irq_spurious_proc_show+0xc0/0x120
? __pci_enable_msix_range+0x7b/0x250
pci_alloc_irq_vectors_affinity+0x13a/0x1c0
? pci_conf1_read+0xa0/0x1e0
? pci_enable_msix_range+0x10/0x10
? pci_bus_read_config_word+0xc9/0x1c0
? pci_bus_find_capability+0x120/0x120
pcie_port_enable_irq_vec+0x8d/0x4c0
? get_port_device_capability+0x4c0/0x4c0
? __pci_set_master+0x6e/0x1a0
? pci_ea_read+0x2e0/0x2e0
? pci_address_to_pio+0x20/0x20
? pci_enable_device_flags+0x1e4/0x2e0
pcie_port_device_register+0x146/0x5c0
? rpm_callback+0x200/0x200
? pcie_port_service_unregister+0x10/0x10
? _raw_read_unlock_irqrestore+0x40/0x40
? __cond_resched+0x1c/0x90
? pcie_portdrv_remove+0x60/0x60
pcie_portdrv_probe+0xa0/0x1b0
? pcie_portdrv_remove+0x60/0x60
local_pci_probe+0xdc/0x170
pci_call_probe+0x182/0x500
? _raw_spin_lock+0x81/0xd0
? local_pci_probe+0x170/0x170
? pci_assign_irq+0x81/0x280
? pci_match_device+0x351/0x6a0
? kernfs_put+0x18/0x30
pci_device_probe+0xee/0x230
? pci_dma_configure+0x11b/0x170
really_probe+0x1da/0xa60
__driver_probe_device+0x2a1/0x460
driver_probe_device+0x49/0x120
__driver_attach+0x178/0x4b0
? __device_attach_driver+0x260/0x260
bus_for_each_dev+0x11b/0x1a0
? subsys_dev_iter_exit+0x10/0x10
? __kmem_cache_alloc_node+0x17e/0x2a0
? klist_add_tail+0x12f/0x270
bus_add_driver+0x423/0x570
driver_register+0x20f/0x390
? dmi_pcie_pme_disable_msi+0x74/0x74
do_one_initcall+0x87/0x2c0
? trace_event_raw_event_initcall_level+0x190/0x190
? parse_one+0x3f0/0x3f0
? do_initcalls+0x30/0x202
? kasan_set_track+0x21/0x30
? __kasan_kmalloc+0x7a/0x90
do_initcalls+0x1d2/0x202
kernel_init_freeable+0x434/0x4a3
? console_on_rootfs+0x52/0x52
? usleep_range_state+0x180/0x180
? _raw_spin_lock_bh+0xe0/0xe0
? rest_init+0x170/0x170
? rest_init+0x170/0x170
kernel_init+0x19/0x140
ret_from_fork+0x1f/0x30
</TASK>

Allocated by task 0:
kasan_save_stack+0x1e/0x40
kasan_set_track+0x21/0x30
__kasan_kmalloc+0x7a/0x90
__kmalloc+0x5d/0x160
intel_setup_irq_remapping+0xbd/0x5b0
intel_prepare_irq_remapping+0x560/0x5a9
irq_remapping_prepare+0x40/0x50
enable_IR_x2apic+0x5b/0x2ee
default_setup_apic_routing+0x1e/0x116
apic_intr_mode_init+0x72/0x1cd
x86_late_time_init+0x89/0x99
start_kernel+0x2f5/0x3a8
secondary_startup_64_no_verify+0xe0/0xeb

The buggy address belongs to the object at ffff888100238000
which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 0 bytes to the right of
8192-byte region [ffff888100238000, ffff88810023a000)

The buggy address belongs to the physical page:
page:00000000d3d94233 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x100238
head:00000000d3d94233 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0010200 0000000000000000 dead000000000122 ffff888100043180
raw: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff888100239f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff888100239f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88810023a000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
^
ffff88810023a080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88810023a100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
Disabling lock debugging due to kernel taint
pcieport 0000:00:01.0: PME: Signaling with IRQ 122
DMAR-IR: IR1: can't allocate an IRTE
DMAR-IR: Failed to allocate IRTE
pcieport 0000:00:1c.0: PME: Signaling with IRQ 16
pcieport 0000:00:1c.0: AER: enabled with IRQ 16
initcall pcie_portdrv_init+0x0/0x49 returned 0 after 796262 usecs
calling  pci_proc_init+0x0/0x6c @ 1
initcall pci_proc_init+0x0/0x6c returned 0 after 47 usecs
calling  pci_hotplug_init+0x0/0x8 @ 1
initcall pci_hotplug_init+0x0/0x8 returned 0 after 0 usecs
calling  shpcd_init+0x0/0x5d @ 1
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
initcall shpcd_init+0x0/0x5d returned 0 after 7583 usecs
calling  pci_stub_init+0x0/0x1fb @ 1
initcall pci_stub_init+0x0/0x1fb returned 0 after 40 usecs
calling  vmd_drv_init+0x0/0x1a @ 1
initcall vmd_drv_init+0x0/0x1a returned 0 after 47 usecs
calling  vesafb_driver_init+0x0/0x13 @ 1
initcall vesafb_driver_init+0x0/0x13 returned 0 after 32 usecs
calling  efifb_driver_init+0x0/0x13 @ 1
initcall efifb_driver_init+0x0/0x13 returned 0 after 24 usecs
calling  intel_idle_init+0x0/0x503 @ 1
initcall intel_idle_init+0x0/0x503 returned 0 after 1447 usecs
calling  ged_driver_init+0x0/0x13 @ 1
initcall ged_driver_init+0x0/0x13 returned 0 after 35 usecs
calling  acpi_ac_init+0x0/0x78 @ 1
initcall acpi_ac_init+0x0/0x78 returned 0 after 116 usecs
calling  acpi_button_driver_init+0x0/0xaf @ 1
input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
ACPI: button: Sleep Button [SLPB]
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
ACPI: button: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
ACPI: button: Power Button [PWRF]
initcall acpi_button_driver_init+0x0/0xaf returned 0 after 43780 usecs
calling  acpi_fan_driver_init+0x0/0x13 @ 1
initcall acpi_fan_driver_init+0x0/0x13 returned 0 after 667 usecs
calling  acpi_processor_driver_init+0x0/0xeb @ 1
initcall acpi_processor_driver_init+0x0/0xeb returned 0 after 637 usecs
calling  acpi_thermal_init+0x0/0x82 @ 1
thermal LNXTHERM:00: registered as thermal_zone0
ACPI: thermal: Thermal Zone [TZ00] (28 C)
thermal LNXTHERM:01: registered as thermal_zone1
ACPI: thermal: Thermal Zone [TZ01] (30 C)
initcall acpi_thermal_init+0x0/0x82 returned 0 after 33901 usecs
calling  acpi_battery_init+0x0/0x6d @ 1
initcall acpi_battery_init+0x0/0x6d returned 0 after 8 usecs
calling  acpi_hed_driver_init+0x0/0x11 @ 1
initcall acpi_hed_driver_init+0x0/0x11 returned 0 after 112 usecs
calling  bgrt_init+0x0/0x19b @ 1
initcall bgrt_init+0x0/0x19b returned -19 after 0 usecs
calling  erst_init+0x0/0x4c3 @ 1
initcall erst_init+0x0/0x4c3 returned 0 after 1 usecs
calling  gpio_clk_driver_init+0x0/0x13 @ 1
initcall gpio_clk_driver_init+0x0/0x13 returned 0 after 36 usecs
calling  plt_clk_driver_init+0x0/0x13 @ 1
initcall plt_clk_driver_init+0x0/0x13 returned 0 after 23 usecs
calling  dw_pci_driver_init+0x0/0x1a @ 1
initcall dw_pci_driver_init+0x0/0x1a returned 0 after 98 usecs
calling  virtio_pci_driver_init+0x0/0x1a @ 1
initcall virtio_pci_driver_init+0x0/0x1a returned 0 after 47 usecs
calling  n_null_init+0x0/0x1a @ 1
initcall n_null_init+0x0/0x1a returned 0 after 0 usecs
calling  pty_init+0x0/0xd @ 1
initcall pty_init+0x0/0xd returned 0 after 234 usecs
calling  sysrq_init+0x0/0x4a @ 1
initcall sysrq_init+0x0/0x4a returned 0 after 6 usecs
calling  serial8250_init+0x0/0x2de @ 1
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
initcall serial8250_init+0x0/0x2de returned 0 after 16788 usecs
calling  serial_pci_driver_init+0x0/0x1a @ 1
initcall serial_pci_driver_init+0x0/0x1a returned 0 after 97 usecs
calling  exar_pci_driver_init+0x0/0x1a @ 1
initcall exar_pci_driver_init+0x0/0x1a returned 0 after 35 usecs
calling  dw8250_platform_driver_init+0x0/0x13 @ 1
initcall dw8250_platform_driver_init+0x0/0x13 returned 0 after 36 usecs
calling  lpss8250_pci_driver_init+0x0/0x1a @ 1
initcall lpss8250_pci_driver_init+0x0/0x1a returned 0 after 38 usecs
calling  mid8250_pci_driver_init+0x0/0x1a @ 1
initcall mid8250_pci_driver_init+0x0/0x1a returned 0 after 32 usecs
calling  pericom8250_pci_driver_init+0x0/0x1a @ 1
initcall pericom8250_pci_driver_init+0x0/0x1a returned 0 after 33 usecs
calling  random_sysctls_init+0x0/0x22 @ 1
initcall random_sysctls_init+0x0/0x22 returned 0 after 11 usecs
calling  hpet_init+0x0/0x72 @ 1
initcall hpet_init+0x0/0x72 returned 0 after 800 usecs
calling  nvram_module_init+0x0/0x89 @ 1
Non-volatile memory driver v1.3
initcall nvram_module_init+0x0/0x89 returned 0 after 5273 usecs
calling  virtio_rng_driver_init+0x0/0x11 @ 1
initcall virtio_rng_driver_init+0x0/0x11 returned 0 after 24 usecs
calling  init_tis+0x0/0x14a @ 1
initcall init_tis+0x0/0x14a returned 0 after 62 usecs
calling  crb_acpi_driver_init+0x0/0x11 @ 1
initcall crb_acpi_driver_init+0x0/0x11 returned 0 after 79 usecs
calling  cn_proc_init+0x0/0x3a @ 1
initcall cn_proc_init+0x0/0x3a returned 0 after 3 usecs
calling  topology_sysfs_init+0x0/0x2c @ 1
initcall topology_sysfs_init+0x0/0x2c returned 0 after 169 usecs
calling  cacheinfo_sysfs_init+0x0/0x2c @ 1
initcall cacheinfo_sysfs_init+0x0/0x2c returned 0 after 979 usecs
calling  intel_lpss_init+0x0/0x1d @ 1
initcall intel_lpss_init+0x0/0x1d returned 0 after 11 usecs
calling  intel_lpss_pci_driver_init+0x0/0x1a @ 1
initcall intel_lpss_pci_driver_init+0x0/0x1a returned 0 after 61 usecs
calling  intel_lpss_acpi_driver_init+0x0/0x13 @ 1
initcall intel_lpss_acpi_driver_init+0x0/0x13 returned 0 after 35 usecs
calling  mac_hid_init+0x0/0x29 @ 1
initcall mac_hid_init+0x0/0x29 returned 0 after 8 usecs
calling  rdac_init+0x0/0x75 @ 1
rdac: device handler registered
initcall rdac_init+0x0/0x75 returned 0 after 5226 usecs
calling  hp_sw_init+0x0/0x11 @ 1
hp_sw: device handler registered
initcall hp_sw_init+0x0/0x11 returned 0 after 5079 usecs
calling  clariion_init+0x0/0x33 @ 1
emc: device handler registered
initcall clariion_init+0x0/0x33 returned 0 after 4890 usecs
calling  alua_init+0x0/0x64 @ 1
alua: device handler registered
initcall alua_init+0x0/0x64 returned 0 after 5202 usecs
calling  blackhole_netdev_init+0x0/0xcb @ 1
initcall blackhole_netdev_init+0x0/0xcb returned 0 after 73 usecs
calling  phylink_init+0x0/0xab @ 1
initcall phylink_init+0x0/0xab returned 0 after 0 usecs
calling  phy_module_init+0x0/0x18 @ 1
initcall phy_module_init+0x0/0x18 returned 0 after 71 usecs
calling  fixed_mdio_bus_init+0x0/0x241 @ 1
initcall fixed_mdio_bus_init+0x0/0x241 returned 0 after 460 usecs
calling  phy_module_init+0x0/0x18 @ 1
initcall phy_module_init+0x0/0x18 returned 0 after 391 usecs
calling  cavium_ptp_driver_init+0x0/0x1a @ 1
initcall cavium_ptp_driver_init+0x0/0x1a returned 0 after 40 usecs
calling  e1000_init_module+0x0/0x77 @ 1
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
initcall e1000_init_module+0x0/0x77 returned 0 after 12309 usecs
calling  e1000_init_module+0x0/0x32 @ 1
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
DMAR-IR: IR1: can't allocate an IRTE
DMAR-IR: Failed to allocate IRTE
e1000e 0000:00:1f.6: PCI INT D: failed to register GSI
e1000e: probe of 0000:00:1f.6 failed with error -12
initcall e1000_init_module+0x0/0x32 returned 0 after 39028 usecs
calling  igb_init_module+0x0/0x40 @ 1
igb: Intel(R) Gigabit Ethernet Network Driver
igb: Copyright (c) 2007-2014 Intel Corporation.
initcall igb_init_module+0x0/0x40 returned 0 after 12624 usecs
calling  igc_init_module+0x0/0x40 @ 1
Intel(R) 2.5G Ethernet Linux Driver
Copyright(c) 2018 Intel Corporation.
initcall igc_init_module+0x0/0x40 returned 0 after 10854 usecs
calling  ixgbe_init_module+0x0/0xa9 @ 1
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
ixgbe: Copyright (c) 1999-2016 Intel Corporation.
initcall ixgbe_init_module+0x0/0xa9 returned 0 after 13738 usecs
calling  i40e_init_module+0x0/0x92 @ 1
i40e: Intel(R) Ethernet Connection XL710 Network Driver
i40e: Copyright (c) 2013 - 2019 Intel Corporation.
initcall i40e_init_module+0x0/0x92 returned 0 after 14012 usecs
calling  rtl8169_pci_driver_init+0x0/0x1a @ 1
initcall rtl8169_pci_driver_init+0x0/0x1a returned 0 after 83 usecs
calling  rtl8152_driver_init+0x0/0x1a @ 1
usbcore: registered new interface driver r8152
initcall rtl8152_driver_init+0x0/0x1a returned 0 after 9559 usecs
calling  asix_driver_init+0x0/0x1a @ 1
usbcore: registered new interface driver asix
initcall asix_driver_init+0x0/0x1a returned 0 after 6232 usecs
calling  ax88179_178a_driver_init+0x0/0x1a @ 1
usbcore: registered new interface driver ax88179_178a
initcall ax88179_178a_driver_init+0x0/0x1a returned 0 after 6914 usecs
calling  usbnet_init+0x0/0x2b @ 1
initcall usbnet_init+0x0/0x2b returned 0 after 1 usecs
calling  usbport_trig_init+0x0/0x11 @ 1
initcall usbport_trig_init+0x0/0x11 returned 0 after 40 usecs
calling  mon_init+0x0/0x194 @ 1
initcall mon_init+0x0/0x194 returned 0 after 257 usecs
calling  ehci_hcd_init+0x0/0x19c @ 1
initcall ehci_hcd_init+0x0/0x19c returned 0 after 8 usecs
calling  ehci_pci_init+0x0/0x52 @ 1
initcall ehci_pci_init+0x0/0x52 returned 0 after 45 usecs
calling  ohci_hcd_mod_init+0x0/0xa5 @ 1
initcall ohci_hcd_mod_init+0x0/0xa5 returned 0 after 63 usecs
calling  ohci_pci_init+0x0/0x52 @ 1
initcall ohci_pci_init+0x0/0x52 returned 0 after 116 usecs
calling  uhci_hcd_init+0x0/0x12b @ 1
initcall uhci_hcd_init+0x0/0x12b returned 0 after 161 usecs
calling  xhci_hcd_init+0x0/0x24 @ 1
initcall xhci_hcd_init+0x0/0x24 returned 0 after 6 usecs
calling  xhci_pci_init+0x0/0x4e @ 1
DMAR-IR: IR1: can't allocate an IRTE
DMAR-IR: Failed to allocate IRTE
xhci_hcd 0000:00:14.0: PCI INT C: failed to register GSI
initcall xhci_pci_init+0x0/0x4e returned 0 after 19516 usecs
calling  ucsi_acpi_platform_driver_init+0x0/0x13 @ 1
initcall ucsi_acpi_platform_driver_init+0x0/0x13 returned 0 after 83 usecs
calling  i8042_init+0x0/0x135 @ 1
i8042: PNP: No PS/2 controller found.
initcall i8042_init+0x0/0x135 returned 0 after 5583 usecs
calling  serport_init+0x0/0x2c @ 1
initcall serport_init+0x0/0x2c returned 0 after 0 usecs
calling  input_leds_init+0x0/0x11 @ 1
initcall input_leds_init+0x0/0x11 returned 0 after 1 usecs
calling  mousedev_init+0x0/0x5f @ 1
mousedev: PS/2 mouse device common for all mice
initcall mousedev_init+0x0/0x5f returned 0 after 6655 usecs
calling  evdev_init+0x0/0x11 @ 1
initcall evdev_init+0x0/0x11 returned 0 after 678 usecs
calling  atkbd_init+0x0/0x26 @ 1
initcall atkbd_init+0x0/0x26 returned 0 after 67 usecs
calling  psmouse_init+0x0/0x86 @ 1
initcall psmouse_init+0x0/0x86 returned 0 after 97 usecs
calling  uinput_misc_init+0x0/0x11 @ 1
initcall uinput_misc_init+0x0/0x11 returned 0 after 214 usecs
calling  cmos_init+0x0/0x70 @ 1
rtc_cmos 00:04: registered as rtc0
rtc_cmos 00:04: setting system clock to 2022-11-10T19:17:24 UTC (1668107844)
rtc_cmos 00:04: alarms up to one day, 242 bytes nvram, hpet irqs
rtc_cmos 00:04: RTC can wake from S4
initcall cmos_init+0x0/0x70 returned 0 after 28893 usecs
calling  thermal_throttle_init_device+0x0/0x4f @ 1
initcall thermal_throttle_init_device+0x0/0x4f returned 0 after 428 usecs
calling  esb_driver_init+0x0/0x1a @ 1
initcall esb_driver_init+0x0/0x1a returned 0 after 99 usecs
calling  iTCO_wdt_driver_init+0x0/0x13 @ 1
initcall iTCO_wdt_driver_init+0x0/0x13 returned 0 after 29 usecs
calling  iTCO_vendor_init_module+0x0/0x31 @ 1
iTCO_vendor_support: vendor-support=0
initcall iTCO_vendor_init_module+0x0/0x31 returned 0 after 5495 usecs
calling  intel_pstate_init+0x0/0x61d @ 1
intel_pstate: HWP enabled by BIOS
intel_pstate: Intel P-state driver initializing
intel_pstate: HWP enabled
initcall intel_pstate_init+0x0/0x61d returned 0 after 16538 usecs
calling  haltpoll_init+0x0/0xef @ 1
initcall haltpoll_init+0x0/0xef returned -19 after 0 usecs
calling  dmi_sysfs_init+0x0/0x148 @ 1
initcall dmi_sysfs_init+0x0/0x148 returned 0 after 2774 usecs
calling  fw_cfg_sysfs_init+0x0/0x86 @ 1
initcall fw_cfg_sysfs_init+0x0/0x86 returned 0 after 44 usecs
calling  sysfb_init+0x0/0x11e @ 1
initcall sysfb_init+0x0/0x11e returned 0 after 77 usecs
calling  esrt_sysfs_init+0x0/0x442 @ 1
initcall esrt_sysfs_init+0x0/0x442 returned -38 after 0 usecs
calling  efivars_pstore_init+0x0/0xb1 @ 1
initcall efivars_pstore_init+0x0/0xb1 returned 0 after 0 usecs
calling  hid_init+0x0/0x62 @ 1
hid: raw HID events driver (C) Jiri Kosina
initcall hid_init+0x0/0x62 returned 0 after 6126 usecs
calling  hid_generic_init+0x0/0x1a @ 1
initcall hid_generic_init+0x0/0x1a returned 0 after 40 usecs
calling  magicmouse_driver_init+0x0/0x1a @ 1
initcall magicmouse_driver_init+0x0/0x1a returned 0 after 47 usecs
calling  sensor_hub_driver_init+0x0/0x1a @ 1
initcall sensor_hub_driver_init+0x0/0x1a returned 0 after 28 usecs
calling  hid_init+0x0/0x5e @ 1
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
initcall hid_init+0x0/0x5e returned 0 after 11071 usecs
calling  pmc_atom_init+0x0/0x6f @ 1
initcall pmc_atom_init+0x0/0x6f returned -19 after 5 usecs
calling  sock_diag_init+0x0/0x2f @ 1
initcall sock_diag_init+0x0/0x2f returned 0 after 80 usecs
calling  init_net_drop_monitor+0x0/0x342 @ 1
drop_monitor: Initializing network drop monitor service
initcall init_net_drop_monitor+0x0/0x342 returned 0 after 7099 usecs
calling  blackhole_init+0x0/0x11 @ 1
initcall blackhole_init+0x0/0x11 returned 0 after 0 usecs
calling  fq_codel_module_init+0x0/0x11 @ 1
initcall fq_codel_module_init+0x0/0x11 returned 0 after 0 usecs
calling  init_cgroup_cls+0x0/0x11 @ 1
initcall init_cgroup_cls+0x0/0x11 returned 0 after 0 usecs
calling  xt_init+0x0/0x29e @ 1
initcall xt_init+0x0/0x29e returned 0 after 68 usecs
calling  tcpudp_mt_init+0x0/0x16 @ 1
initcall tcpudp_mt_init+0x0/0x16 returned 0 after 1 usecs
calling  gre_offload_init+0x0/0x4e @ 1
initcall gre_offload_init+0x0/0x4e returned 0 after 0 usecs
calling  sysctl_ipv4_init+0x0/0x4c @ 1
initcall sysctl_ipv4_init+0x0/0x4c returned 0 after 67 usecs
calling  cubictcp_register+0x0/0x6e @ 1
initcall cubictcp_register+0x0/0x6e returned 0 after 13655 usecs
calling  xfrm_user_init+0x0/0x30 @ 1
Initializing XFRM netlink socket
initcall xfrm_user_init+0x0/0x30 returned 0 after 5091 usecs
calling  inet6_init+0x0/0x4ba @ 1
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
initcall inet6_init+0x0/0x4ba returned 0 after 17159 usecs
calling  packet_init+0x0/0x7f @ 1
NET: Registered PF_PACKET protocol family
initcall packet_init+0x0/0x7f returned 0 after 5832 usecs
calling  strp_dev_init+0x0/0x33 @ 1
initcall strp_dev_init+0x0/0x33 returned 0 after 196 usecs
calling  init_p9+0x0/0x2a @ 1
9pnet: Installing 9P2000 support
initcall init_p9+0x0/0x2a returned 0 after 5322 usecs
calling  p9_trans_fd_init+0x0/0x2c @ 1
initcall p9_trans_fd_init+0x0/0x2c returned 0 after 0 usecs
calling  p9_virtio_init+0x0/0x4e @ 1
initcall p9_virtio_init+0x0/0x4e returned 0 after 88 usecs
calling  dcbnl_init+0x0/0x50 @ 1
initcall dcbnl_init+0x0/0x50 returned 0 after 7 usecs
calling  mpls_gso_init+0x0/0x2c @ 1
mpls_gso: MPLS GSO support
initcall mpls_gso_init+0x0/0x2c returned 0 after 4546 usecs
calling  nsh_init_module+0x0/0x14 @ 1
initcall nsh_init_module+0x0/0x14 returned 0 after 0 usecs
calling  pm_check_save_msr+0x0/0xf0 @ 1
initcall pm_check_save_msr+0x0/0xf0 returned 0 after 8 usecs
calling  mcheck_init_device+0x0/0x1e7 @ 1
initcall mcheck_init_device+0x0/0x1e7 returned 0 after 900 usecs
calling  dev_mcelog_init_device+0x0/0x16d @ 1
initcall dev_mcelog_init_device+0x0/0x16d returned 0 after 189 usecs
calling  kernel_do_mounts_initrd_sysctls_init+0x0/0x22 @ 1
initcall kernel_do_mounts_initrd_sysctls_init+0x0/0x22 returned 0 after 6 usecs
calling  tboot_late_init+0x0/0x22b @ 1
initcall tboot_late_init+0x0/0x22b returned 0 after 0 usecs
calling  mcheck_late_init+0x0/0x3d @ 1
initcall mcheck_late_init+0x0/0x3d returned 0 after 19 usecs
calling  severities_debugfs_init+0x0/0x2a @ 1
initcall severities_debugfs_init+0x0/0x2a returned 0 after 52 usecs
calling  microcode_init+0x0/0x2a0 @ 1
microcode: sig=0x506e3, pf=0x2, revision=0x39
microcode: Microcode Update Driver: v2.2.
initcall microcode_init+0x0/0x2a0 returned 0 after 6491 usecs
calling  hpet_insert_resource+0x0/0x23 @ 1
initcall hpet_insert_resource+0x0/0x23 returned 0 after 2 usecs
calling  start_sync_check_timer+0x0/0xaa @ 1
initcall start_sync_check_timer+0x0/0xaa returned 0 after 0 usecs
calling  update_mp_table+0x0/0x571 @ 1
initcall update_mp_table+0x0/0x571 returned 0 after 0 usecs
calling  lapic_insert_resource+0x0/0x43 @ 1
initcall lapic_insert_resource+0x0/0x43 returned 0 after 1 usecs
calling  print_ipi_mode+0x0/0x2d @ 1
IPI shorthand broadcast: enabled
initcall print_ipi_mode+0x0/0x2d returned 0 after 5040 usecs
calling  print_ICs+0x0/0x1d3 @ 1
... APIC ID:      00000000 (0)
... APIC VERSION: 01060015
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000008001000

number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 120.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00770020
.......     : max redirection entries: 77
.......     : PRQ implemented: 0
.......     : IO APIC version: 20
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
IOAPIC 0:
pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin01, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin02, enabled , edge , high, V(02), IRR(0), S(0), remapped, I(0001),  Z(0)
pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin08, enabled , edge , high, V(08), IRR(0), S(0), remapped, I(007F),  Z(0)
pin09, enabled , level, high, V(09), IRR(0), S(0), remapped, I(00FF),  Z(0)
pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin10, enabled , level, low , V(10), IRR(0), S(0), remapped, I(7FFF),  Z(0)
pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin15, disabled, edge , high, V(82), IRR(0), S(0), physical, D(5840), M(2)
pin16, disabled, edge , high, V(C1), IRR(0), S(0), physical, D(0C00), M(2)
pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin18, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin19, disabled, edge , high, V(35), IRR(0), S(0), physical, D(1010), M(2)
pin1a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1b, disabled, edge , high, V(11), IRR(0), S(0), remapped, I(3202),  Z(2)
pin1c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin20, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin21, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin22, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin23, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin24, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin25, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin26, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin27, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin28, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin29, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(2)
pin2f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin30, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin31, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin32, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin33, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin34, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin35, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin36, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin37, disabled, edge , high, V(20), IRR(0), S(0), physical, D(0090), M(2)
pin38, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin39, disabled, edge , high, V(02), IRR(0), S(0), physical, D(00A0), M(2)
pin3a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3e, disabled, edge , high, V(05), IRR(0), S(0), physical, D(0443), M(2)
pin3f, disabled, edge , high, V(40), IRR(0), S(0), physical, D(00D0), M(2)
pin40, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin41, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin42, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin43, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin44, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin45, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin46, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin47, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin48, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin49, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin50, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin51, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin52, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin53, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin54, disabled, edge , high, V(01), IRR(0), S(0), logical , D(4402), M(2)
pin55, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin56, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin57, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin58, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin59, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin60, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin61, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin62, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin63, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin64, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin65, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin66, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin67, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0004), M(2)
pin68, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin69, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin70, disabled, edge , high, V(00), IRR(0), S(0), physical, D(4824), M(2)
pin71, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin72, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin73, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin74, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin75, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin76, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin77, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
.................................... done.
initcall print_ICs+0x0/0x1d3 returned 0 after 1231237 usecs
calling  setup_efi_kvm_sev_migration+0x0/0x288 @ 1
initcall setup_efi_kvm_sev_migration+0x0/0x288 returned 0 after 0 usecs
calling  create_tlb_single_page_flush_ceiling+0x0/0x4f @ 1
initcall create_tlb_single_page_flush_ceiling+0x0/0x4f returned 0 after 68 usecs
calling  pat_memtype_list_init+0x0/0x58 @ 1
initcall pat_memtype_list_init+0x0/0x58 returned 0 after 7 usecs
calling  create_init_pkru_value+0x0/0x54 @ 1
initcall create_init_pkru_value+0x0/0x54 returned 0 after 0 usecs
calling  aesni_init+0x0/0x21f @ 1
AVX2 version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
initcall aesni_init+0x0/0x21f returned 0 after 13307 usecs
calling  kernel_panic_sysctls_init+0x0/0x22 @ 1
initcall kernel_panic_sysctls_init+0x0/0x22 returned 0 after 45 usecs
calling  reboot_ksysfs_init+0x0/0x90 @ 1
initcall reboot_ksysfs_init+0x0/0x90 returned 0 after 2678 usecs
calling  sched_core_sysctl_init+0x0/0x27 @ 1
initcall sched_core_sysctl_init+0x0/0x27 returned 0 after 50 usecs
calling  sched_fair_sysctl_init+0x0/0x22 @ 1
initcall sched_fair_sysctl_init+0x0/0x22 returned 0 after 7 usecs
calling  sched_rt_sysctl_init+0x0/0x22 @ 1
initcall sched_rt_sysctl_init+0x0/0x22 returned 0 after 5 usecs
calling  sched_dl_sysctl_init+0x0/0x22 @ 1
initcall sched_dl_sysctl_init+0x0/0x22 returned 0 after 5 usecs
calling  sched_clock_init_late+0x0/0xce @ 1
sched_clock: Marking stable (11582760175, 1107212730)->(17128030683, -4438057778)
initcall sched_clock_init_late+0x0/0xce returned 0 after 9375 usecs
calling  sched_init_debug+0x0/0x251 @ 1
initcall sched_init_debug+0x0/0x251 returned 0 after 391 usecs
calling  cpu_latency_qos_init+0x0/0x3a @ 1
initcall cpu_latency_qos_init+0x0/0x3a returned 0 after 164 usecs
calling  pm_debugfs_init+0x0/0x24 @ 1
initcall pm_debugfs_init+0x0/0x24 returned 0 after 6 usecs
calling  printk_late_init+0x0/0x1f3 @ 1
initcall printk_late_init+0x0/0x1f3 returned 0 after 13 usecs
calling  init_srcu_module_notifier+0x0/0x2c @ 1
initcall init_srcu_module_notifier+0x0/0x2c returned 0 after 1 usecs
calling  swiotlb_create_default_debugfs+0x0/0x68 @ 1
initcall swiotlb_create_default_debugfs+0x0/0x68 returned 0 after 22 usecs
calling  tk_debug_sleep_time_init+0x0/0x24 @ 1
initcall tk_debug_sleep_time_init+0x0/0x24 returned 0 after 8 usecs
calling  bpf_ksym_iter_register+0x0/0x51 @ 1
initcall bpf_ksym_iter_register+0x0/0x51 returned 0 after 3 usecs
calling  kernel_acct_sysctls_init+0x0/0x22 @ 1
initcall kernel_acct_sysctls_init+0x0/0x22 returned 0 after 6 usecs
calling  kexec_core_sysctl_init+0x0/0x22 @ 1
initcall kexec_core_sysctl_init+0x0/0x22 returned 0 after 5 usecs
calling  bpf_rstat_kfunc_init+0x0/0x16 @ 1
initcall bpf_rstat_kfunc_init+0x0/0x16 returned 0 after 5 usecs
calling  debugfs_kprobe_init+0x0/0x74 @ 1
initcall debugfs_kprobe_init+0x0/0x74 returned 0 after 22 usecs
calling  kernel_delayacct_sysctls_init+0x0/0x22 @ 1
initcall kernel_delayacct_sysctls_init+0x0/0x22 returned 0 after 13 usecs
calling  taskstats_init+0x0/0x3b @ 1
registered taskstats version 1
initcall taskstats_init+0x0/0x3b returned 0 after 4946 usecs
calling  ftrace_sysctl_init+0x0/0x1d @ 1
initcall ftrace_sysctl_init+0x0/0x1d returned 0 after 6 usecs
calling  init_hwlat_tracer+0x0/0x112 @ 1
initcall init_hwlat_tracer+0x0/0x112 returned 0 after 462 usecs
calling  bpf_key_sig_kfuncs_init+0x0/0x11 @ 1
initcall bpf_key_sig_kfuncs_init+0x0/0x11 returned 0 after 8 usecs
calling  bpf_syscall_sysctl_init+0x0/0x22 @ 1
initcall bpf_syscall_sysctl_init+0x0/0x22 returned 0 after 6 usecs
calling  kfunc_init+0x0/0x16 @ 1
initcall kfunc_init+0x0/0x16 returned 0 after 3 usecs
calling  bpf_map_iter_init+0x0/0x62 @ 1
initcall bpf_map_iter_init+0x0/0x62 returned 0 after 4 usecs
calling  task_iter_init+0x0/0x2d1 @ 1
initcall task_iter_init+0x0/0x2d1 returned 0 after 5 usecs
calling  bpf_prog_iter_init+0x0/0x51 @ 1
initcall bpf_prog_iter_init+0x0/0x51 returned 0 after 2 usecs
calling  bpf_link_iter_init+0x0/0x51 @ 1
initcall bpf_link_iter_init+0x0/0x51 returned 0 after 1 usecs
calling  init_trampolines+0x0/0x66 @ 1
initcall init_trampolines+0x0/0x66 returned 0 after 1 usecs
calling  bpf_cgroup_iter_init+0x0/0x51 @ 1
initcall bpf_cgroup_iter_init+0x0/0x51 returned 0 after 3 usecs
calling  load_system_certificate_list+0x0/0x51 @ 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: cc54966022aca92392d98b37a0eeaa504efc1eff'
initcall load_system_certificate_list+0x0/0x51 returned 0 after 18072 usecs
calling  fault_around_debugfs+0x0/0x24 @ 1
initcall fault_around_debugfs+0x0/0x24 returned 0 after 9 usecs
calling  max_swapfiles_check+0x0/0x8 @ 1
initcall max_swapfiles_check+0x0/0x8 returned 0 after 0 usecs
calling  init_zswap+0x0/0x3a6 @ 1
zswap: loaded using pool lzo/zbud
initcall init_zswap+0x0/0x3a6 returned 0 after 6052 usecs
calling  hugetlb_vmemmap_init+0x0/0x123 @ 1
initcall hugetlb_vmemmap_init+0x0/0x123 returned 0 after 6 usecs
calling  kasan_cpu_quarantine_init+0x0/0x44 @ 1
initcall kasan_cpu_quarantine_init+0x0/0x44 returned 217 after 249 usecs
calling  split_huge_pages_debugfs+0x0/0x24 @ 1
initcall split_huge_pages_debugfs+0x0/0x24 returned 0 after 11 usecs
calling  pageowner_init+0x0/0x34 @ 1
page_owner is disabled
initcall pageowner_init+0x0/0x34 returned 0 after 4174 usecs
calling  check_early_ioremap_leak+0x0/0x85 @ 1
initcall check_early_ioremap_leak+0x0/0x85 returned 0 after 0 usecs
calling  set_hardened_usercopy+0x0/0x20 @ 1
initcall set_hardened_usercopy+0x0/0x20 returned 1 after 0 usecs
calling  fscrypt_init+0x0/0xc9 @ 1
Key type .fscrypt registered
Key type fscrypt-provisioning registered
initcall fscrypt_init+0x0/0xc9 returned 0 after 10868 usecs
calling  pstore_init+0x0/0x7d @ 1
initcall pstore_init+0x0/0x7d returned 0 after 8 usecs
calling  init_root_keyring+0x0/0xe @ 1
initcall init_root_keyring+0x0/0xe returned 0 after 41 usecs
calling  init_trusted+0x0/0x252 @ 1
initcall init_trusted+0x0/0x252 returned 0 after 255 usecs
calling  init_encrypted+0x0/0x14d @ 1
Freeing initrd memory: 1421792K
Key type encrypted registered
initcall init_encrypted+0x0/0x14d returned 0 after 17322433 usecs
calling  integrity_fs_init+0x0/0x4e @ 1
initcall integrity_fs_init+0x0/0x4e returned 0 after 9 usecs
calling  crypto_algapi_init+0x0/0x128 @ 1
initcall crypto_algapi_init+0x0/0x128 returned 0 after 3648 usecs
calling  fail_make_request_debugfs+0x0/0x26 @ 1
initcall fail_make_request_debugfs+0x0/0x26 returned 0 after 52 usecs
calling  blk_timeout_init+0x0/0x13 @ 1
initcall blk_timeout_init+0x0/0x13 returned 0 after 0 usecs
calling  init_error_injection+0x0/0x6a @ 1
initcall init_error_injection+0x0/0x6a returned 0 after 1244 usecs
calling  pci_resource_alignment_sysfs_init+0x0/0x18 @ 1
initcall pci_resource_alignment_sysfs_init+0x0/0x18 returned 0 after 7 usecs
calling  pci_sysfs_init+0x0/0x6e @ 1
initcall pci_sysfs_init+0x0/0x6e returned 0 after 120 usecs
calling  bert_init+0x0/0x64f @ 1
initcall bert_init+0x0/0x64f returned 0 after 1 usecs
calling  clk_debug_init+0x0/0x135 @ 1
initcall clk_debug_init+0x0/0x135 returned 0 after 24 usecs
calling  dmar_free_unused_resources+0x0/0x190 @ 1
initcall dmar_free_unused_resources+0x0/0x190 returned 0 after 0 usecs
calling  sync_state_resume_initcall+0x0/0x10 @ 1
initcall sync_state_resume_initcall+0x0/0x10 returned 0 after 1 usecs
calling  deferred_probe_initcall+0x0/0xd0 @ 1
initcall deferred_probe_initcall+0x0/0xd0 returned 0 after 49 usecs
calling  firmware_memmap_init+0x0/0x5a @ 1
initcall firmware_memmap_init+0x0/0x5a returned 0 after 264 usecs
calling  register_update_efi_random_seed+0x0/0x1e @ 1
initcall register_update_efi_random_seed+0x0/0x1e returned 0 after 0 usecs
calling  efi_shutdown_init+0x0/0x74 @ 1
initcall efi_shutdown_init+0x0/0x74 returned -19 after 0 usecs
calling  efi_earlycon_unmap_fb+0x0/0x51 @ 1
initcall efi_earlycon_unmap_fb+0x0/0x51 returned 0 after 0 usecs
calling  itmt_legacy_init+0x0/0x49 @ 1
initcall itmt_legacy_init+0x0/0x49 returned -19 after 0 usecs
calling  bpf_sockmap_iter_init+0x0/0x51 @ 1
initcall bpf_sockmap_iter_init+0x0/0x51 returned 0 after 2 usecs
calling  bpf_sk_storage_map_iter_init+0x0/0x51 @ 1
initcall bpf_sk_storage_map_iter_init+0x0/0x51 returned 0 after 1 usecs
calling  sch_default_qdisc+0x0/0x11 @ 1
initcall sch_default_qdisc+0x0/0x11 returned 0 after 1 usecs
calling  bpf_prog_test_run_init+0x0/0x1be @ 1
initcall bpf_prog_test_run_init+0x0/0x1be returned 0 after 17 usecs
calling  tcp_congestion_default+0x0/0x18 @ 1
initcall tcp_congestion_default+0x0/0x18 returned 0 after 0 usecs
calling  ip_auto_config+0x0/0x812 @ 1
initcall ip_auto_config+0x0/0x812 returned -19 after 12278671 usecs
calling  tcp_bpf_v4_build_proto+0x0/0xeb @ 1
initcall tcp_bpf_v4_build_proto+0x0/0xeb returned 0 after 0 usecs
calling  udp_bpf_v4_build_proto+0x0/0x99 @ 1
initcall udp_bpf_v4_build_proto+0x0/0x99 returned 0 after 0 usecs
calling  bpf_tcp_ca_kfunc_init+0x0/0x16 @ 1
initcall bpf_tcp_ca_kfunc_init+0x0/0x16 returned 0 after 12 usecs
calling  pci_mmcfg_late_insert_resources+0x0/0xb5 @ 1
initcall pci_mmcfg_late_insert_resources+0x0/0xb5 returned 0 after 1 usecs
calling  software_resume+0x0/0x40 @ 1
initcall software_resume+0x0/0x40 returned -2 after 0 usecs
calling  ftrace_check_sync+0x0/0x14 @ 1
initcall ftrace_check_sync+0x0/0x14 returned 0 after 7 usecs
calling  latency_fsnotify_init+0x0/0x38 @ 1
initcall latency_fsnotify_init+0x0/0x38 returned 0 after 36 usecs
calling  trace_eval_sync+0x0/0x14 @ 1
initcall trace_eval_sync+0x0/0x14 returned 0 after 8 usecs
calling  late_trace_init+0x0/0x9c @ 1
initcall late_trace_init+0x0/0x9c returned 0 after 0 usecs
calling  acpi_gpio_handle_deferred_request_irqs+0x0/0xa1 @ 1
initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xa1 returned 0 after 4 usecs
calling  fb_logo_late_init+0x0/0xf @ 1
initcall fb_logo_late_init+0x0/0xf returned 0 after 0 usecs
calling  clk_disable_unused+0x0/0x18c @ 1
initcall clk_disable_unused+0x0/0x18c returned 0 after 0 usecs
Freeing unused kernel image (initmem) memory: 3108K
Write protecting the kernel read-only data: 57344k
Freeing unused kernel image (text/rodata gap) memory: 2036K
Freeing unused kernel image (rodata/data gap) memory: 1132K
Run /init as init process
with arguments:
/init
nokaslr
with environment:
HOME=/
TERM=linux
RESULT_ROOT=/result/ltp/1HDD-f2fs-writev03.writev03/lkp-skl-d02/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/1
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/vmlinuz-6.1.0-rc2-00194-g8cbe83be2e63
branch=linux-review/Yury-Norov/bitmap-remove-_reg_op/20221028-095005
job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-writev03.writev03-debian-12-x86_64-20220629.cgz-8cbe83be2e63293c368eb2d580f2f69cb8b35e43-20221110-41138-1rk5rul-4.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=8cbe83be2e63293c368eb2d580f2f69cb8b35e43
max_uptime=2100
LKP_SERVER=internal-lkp-server
selinux=0
softlockup_panic=1
prompt_ramdisk=0
vga=normal
systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
calling  ip_tables_init+0x0/0x1000 [ip_tables] @ 1
initcall ip_tables_init+0x0/0x1000 [ip_tables] returned 0 after 17 usecs


calling  drm_core_init+0x0/0xc6 [drm] @ 178
initcall drm_core_init+0x0/0xc6 [drm] returned 0 after 23918 usecs
calling  acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] @ 207
initcall acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] returned -17 after 0 usecs
[0m.
calling  pmc_core_driver_init+0x0/0x1000 [intel_pmc_core] @ 194
initcall acpi_pad_init+0x0/0x1000 [acpi_pad] returned 0 after 968 usecs
intel_pmc_core INT33A1:00:  initialized
calling  acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] @ 205
calling  acpi_wmi_init+0x0/0x1000 [wmi] @ 195
initcall acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] returned -17 after 0 usecs
wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control method not found
calling  smbalert_driver_init+0x0/0x1000 [i2c_smbus] @ 215
calling  ie31200_init+0x0/0x1000 [ie31200_edac] @ 219
calling  intel_pch_thermal_driver_init+0x0/0x1000 [intel_pch_thermal] @ 216
Startin[   44.341793][  T195] initcall acpi_wmi_init+0x0/0x1000 [wmi] returned 0 after 527 usecs
e Volatile Files[   44.357757][  T219] EDAC ie31200: No ECC support
and Directories[   44.363199][  T219] initcall ie31200_init+0x0/0x1000 [ie31200_edac] returned -19 after 21933 usecs
DMAR-IR: IR1: can't allocate an IRTE
initcall smbalert_driver_init+0x0/0x1000 [i2c_smbus] returned 0 after 31926 usecs
DMAR-IR: Failed to allocate IRTE
calling  mei_init+0x0/0xb3 [mei] @ 222
intel_pch_thermal 0000:00:14.2: PCI INT C: failed to register GSI
initcall mei_init+0x0/0xb3 [mei] returned 0 after 2426 usecs
intel_pch_thermal 0000:00:14.2: failed to enable pci device
intel_pch_thermal: probe of 0000:00:14.2 failed with error -12
initcall intel_pch_thermal_driver_init+0x0/0x1000 [intel_pch_thermal] returned 0 after 28979 usecs
synchronize boot[   44.451890][  T203] initcall acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] returned -17 after 0 usecs
calling  i2c_i801_init+0x0/0x1000 [i2c_i801] @ 215
calling  acpi_video_init+0x0/0x1000 [video] @ 195
calling  intel_uncore_init+0x0/0x3a1 [intel_uncore] @ 194
initcall acpi_video_init+0x0/0x1000 [video] returned 0 after 10 usecs
initcall i2c_i801_init+0x0/0x1000 [i2c_i801] returned 0 after 438 usecs
i801_smbus 0000:00:1f.4: SPD Write Disable is set
initcall intel_uncore_init+0x0/0x3a1 [intel_uncore] returned 0 after 23642 usecs
Mountin[   44.539499][    T9] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[0m...
pci 0000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
pci 0000:00:1f.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 9
libata version 3.00 loaded.
pci 0000:00:1f.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
initcall ata_init+0x0/0x86 [libata] returned 0 after 28738 usecs
iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
0m.
initcall acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] returned -17 after 0 usecs
calling  mei_me_driver_init+0x0/0x1000 [mei_me] @ 222
i2c i2c-0: 4/4 memory slots populated (from DMI)
calling  wmi_bmof_driver_init+0x0/0x1000 [wmi_bmof] @ 219
initcall wmi_bmof_driver_init+0x0/0x1000 [wmi_bmof] returned 0 after 228 usecs
initcall mei_me_driver_init+0x0/0x1000 [mei_me] returned 0 after 143 usecs
mei_me 0000:00:16.0: enabling device (0000 -> 0002)
initcall cstate_pmu_init+0x0/0x1000 [intel_cstate] returned 0 after 1327 usecs
DMAR-IR: IR1: can't allocate an IRTE
DMAR-IR: Failed to allocate IRTE
i2c i2c-0: Successfully instantiated SPD at 0x50
0m] Reached targ[   44.768144][    T9] i2c i2c-0: Successfully instantiated SPD at 0x52
calling  rapl_pmu_init+0x0/0xf0a [rapl] @ 217
m.
m.
calling  ahci_pci_driver_init+0x0/0x1000 [ahci] @ 202
calling  drm_display_helper_module_init+0x0/0x1000 [drm_display_helper] @ 221
initcall drm_display_helper_module_init+0x0/0x1000 [drm_display_helper] returned 0 after 66 usecs
RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
ahci 0000:00:17.0: version 3.0
RAPL PMU: hw unit of domain package 2^-14 Joules
RAPL PMU: hw unit of domain dram 2^-14 Joules
RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
initcall rapl_pmu_init+0x0/0xf0a [rapl] returned 0 after 8766 usecs
DMAR-IR: IR1: can't allocate an IRTE
DMAR-IR: Failed to allocate IRTE
ahci 0000:00:17.0: PCI INT B: failed to register GSI
0m] Reached targ[   44.917864][  T219] calling  mei_wdt_driver_init+0x0/0x1000 [mei_wdt] @ 219
initcall ahci_pci_driver_init+0x0/0x1000 [ahci] returned 0 after 85366 usecs
calling  sha512_ssse3_mod_init+0x0/0x1000 [sha512_ssse3] @ 194
0m] Reached targ[   44.971129][  T201] initcall acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] returned -17 after 0 usecs
[0m.
initcall drm_buddy_module_init+0x0/0x1000 [drm_buddy] returned 0 after 149 usecs
calling  ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] @ 217
calling  crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] @ 218
initcall crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] returned 0 after 121 usecs
calling  acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] @ 196
initcall acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] returned -17 after 1 usecs
calling  crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] @ 199
initcall crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] returned 0 after 143 usecs
rc.local[301]: mk[   45.805051][  T292] microcode: Attempting late microcode loading - it is dangerous and taints the kernel.
dir: cannot crea[   45.815088][  T292] microcode: You should switch to early loading, if possible.
microcode: updated to revision 0xf0, date = 2021-11-12
x86/CPU: CPU features have changed after loading microcode, but might not take effect.
x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.
microcode: Reload completed, microcode revision: 0x39 -> 0xf0
1;39mSystem Logg[   45.979350][  T208] calling  acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] @ 208

initcall crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] returned 0 after 5755 usecs
calling  i915_init+0x0/0x15d [i915] @ 221
Console: switching to colour dummy device 80x25
i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver1_27.bin failed with error -2
LKP: ttyS0: 292: Kernel tests: Boot OK!
LKP: ttyS0: 292:[   46.244968][   T17] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/skl_dmc_ver1_27.bin. Disabling runtime power management.
HOSTNAME lkp-sk[   46.246134][  T218] calling  kvm_x86_init+0x0/0xd [kvm] @ 218
l-d02, MAC , ker[   46.258292][   T17] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
nel 6.1.0-rc2-00[   46.265375][  T218] initcall kvm_x86_init+0x0/0xd [kvm] returned 0 after 1 usecs
194-g8cbe83be2e63 1
calling  vmx_init+0x0/0x272 [kvm_intel] @ 217
initcall vmx_init+0x0/0x272 [kvm_intel] returned 0 after 20012 usecs
calling  coretemp_init+0x0/0x1000 [coretemp] @ 199
ure Shell server[   46.409509][  T358] IPMI message handler: version 39.2
initcall coretemp_init+0x0/0x1000 [coretemp] returned 0 after 7156 usecs
initcall ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] returned 0 after 7185 usecs
ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
calling  init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] @ 358
input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
ipmi device interface
initcall i915_init+0x0/0x15d [i915] returned 0 after 13614 usecs
initcall init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] returned 0 after 14596 usecs
Load kernel imag[   46.495697][  T199] initcall powerclamp_init+0x0/0x1000 [intel_powerclamp] returned 0 after 703 usecs
fbcon: i915drmfb (fb0) is primary device
Console: switching to colour frame buffer device 160x64
i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
calling  pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] @ 199
initcall pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] returned 0 after 5632 usecs
calling  init_ipmi_si+0x0/0x276 [ipmi_si] @ 391
ipmi_si: IPMI System Interface driver
calling  acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] @ 194
initcall acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] returned -17 after 0 usecs
ipmi_si: Unable to find any System Interface(s)
initcall init_ipmi_si+0x0/0x276 [ipmi_si] returned -19 after 16983 usecs
calling  acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] @ 217
initcall acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] returned -17 after 0 usecs
See 'systemctl status openipmi.service' for details.
calling  acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] @ 218
initcall acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] returned -17 after 1 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 217
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 77 usecs
calling  acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] @ 199
initcall acpi_cpufreq_init+0x0/0xc03 [acpi_cpufreq] returned -17 after 1 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 218
calling  rapl_init+0x0/0x1000 [intel_rapl_common] @ 194
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 55 usecs
initcall rapl_init+0x0/0x1000 [intel_rapl_common] returned 0 after 8337 usecs
calling  intel_rapl_msr_driver_init+0x0/0x1000 [intel_rapl_msr] @ 206
1;39mRPC bind po[   46.870102][   T18] intel_rapl_common: Found RAPL domain uncore
m.
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 199
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 70 usecs
LKP: stdout: 292: Kernel tests: Boot OK!

LKP: stdout: 292: HOSTNAME lkp-skl-d02, MAC , kernel 6.1.0-rc2-00194-g8cbe83be2e63 1

install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/python3-ntp_1.2.1+dfsg1-7+b1_amd64.deb

/opt/deb/ntpsec-ntpdate_1.2.1+dfsg1-7+b1_amd64.deb

/opt/deb/ntpdate_1%3a4.2.8p15+dfsg-2~1.2.1+dfsg1-7_all.deb

/opt/deb/rpcbind_1.2.6-6+b1_amd64.deb

/opt/deb/gcc-12-base_12.2.0-3_amd64.deb

/opt/deb/libgcc-s1_12.2.0-3_amd64.deb

/opt/deb/cron_3.0pl1-150+b1_amd64.deb

/opt/deb/apache2-bin_2.4.54-3_amd64.deb

/opt/deb/apache2-data_2.4.54-3_all.deb

/opt/deb/apache2-utils_2.4.54-3_amd64.deb

/opt/deb/mime-support_3.66_all.deb

/opt/deb/apache2_2.4.54-3_amd64.deb

/opt/deb/bind9-libs_1%3a9.18.7-1_amd64.deb

/opt/deb/bind9-utils_1%3a9.18.7-1_amd64.deb

/opt/deb/dns-root-data_2021011101_all.deb

/opt/deb/bind9_1%3a9.18.7-1_amd64.deb

/opt/deb/libntfs-3g89_1%3a2022.5.17-1_amd64.deb

/opt/deb/ntfs-3g_1%3a2022.5.17-1_amd64.deb

/opt/deb/update-inetd_4.51_all.deb

/opt/deb/openbsd-inetd_0.20160825-5+b1_amd64.deb

/opt/deb/python3.10_3.10.8-1_amd64.deb

/opt/deb/libpython3.10-stdlib_3.10.8-1_amd64.deb

/opt/deb/python3.10-minimal_3.10.8-1_amd64.deb

/opt/deb/libpython3.10-minimal_3.10.8-1_amd64.deb

/opt/deb/trousers_0.3.15-0.2+b1_amd64.deb

/opt/deb/uuid-runtime_2.38.1-1.1+b1_amd64.deb

/opt/deb/bind9-host_1%3a9.18.7-1_amd64.deb

/opt/deb/bind9-dnsutils_1%3a9.18.7-1_amd64.deb

/opt/deb/inetutils-telnet_2%3a2.4-1_amd64.deb

/opt/deb/traceroute_1%3a2.1.0-3_amd64.deb

/opt/deb/at_3.2.5-1+b1_amd64.deb

/opt/deb/automake_1%3a1.16.5-1.3_all.deb

/opt/deb/dosfstools_4.2-1_amd64.deb

/opt/deb/exfat-fuse_1.3.0+git20220115-2_amd64.deb

/opt/deb/exfatprogs_1.1.3-1+b1_amd64.deb

/opt/deb/tnftp_20210827-4+b1_amd64.deb

/opt/deb/ftp_20210827-4_all.deb

/opt/deb/libatomic1_12.2.0-3_amd64.deb

/opt/deb/libquadmath0_12.2.0-3_amd64.deb

/opt/deb/libgcc-12-dev_12.2.0-3_amd64.deb

/opt/deb/gcc-12_12.2.0-3_amd64.deb

/opt/deb/gcc_4%3a12.2.0-1_amd64.deb

/opt/deb/libpython3.10_3.10.8-1_amd64.deb

/opt/deb/liberror-perl_0.17029-2_all.deb

/opt/deb/iputils-tracepath_3%3a20211215-1_amd64.deb

/opt/deb/libatasmart4_0.19-5_amd64.deb

/opt/deb/libopencryptoki0_3.8.1+dfsg-3.2+b3_amd64.deb

/opt/deb/libudisks2-0_2.9.4-3+b1_amd64.deb

/opt/deb/opencryptoki_3.8.1+dfsg-3.2+b3_amd64.deb

/opt/deb/patch_2.7.6-7_amd64.deb

/opt/deb/rstatd_4.0.1-11+b1_amd64.deb

/opt/deb/rsyslog_8.2210.0-1_amd64.deb

/opt/deb/rusersd_0.17-12_amd64.deb

/opt/deb/sysstat_12.5.6-1+b1_amd64.deb

/opt/deb/telnet_0.17+2.4-1_all.deb

/opt/deb/telnetd-ssl_0.17.41+really0.17-2_amd64.deb

/opt/deb/udisks2_2.9.4-3+b1_amd64.deb

/opt/deb/vsftpd_3.0.3-13+b2_amd64.deb

/opt/deb/python3.10_3.10.6-1_amd64.deb

/opt/deb/libpython3.10-stdlib_3.10.6-1_amd64.deb

/opt/deb/python3.10-minimal_3.10.6-1_amd64.deb

/opt/deb/libpython3.10-minimal_3.10.6-1_amd64.deb

/opt/deb/python3-dnspython_2.2.1-2_all.deb

/opt/deb/libpython3.10_3.10.6-1_amd64.deb

/opt/deb/python3-ldb_2%3a2.5.2+samba4.16.4-2_amd64.deb

/opt/deb/python3-tdb_1.4.6-3_amd64.deb

/opt/deb/libavahi-common-data_0.8-6_amd64.deb

/opt/deb/python3-talloc_2.3.3-4_amd64.deb

/opt/deb/python3-samba_2%3a4.16.4+dfsg-2_amd64.deb

/opt/deb/gawk_1%3a5.1.0-1_amd64.deb

Selecting previously unselected package python3-ntp.

(Reading database ... 16784 files and directories currently installed.)

Preparing to unpack .../python3-ntp_1.2.1+dfsg1-7+b1_amd64.deb ...

Unpacking python3-ntp (1.2.1+dfsg1-7+b1) ...

Selecting previously unselected package ntpsec-ntpdate.

Preparing to unpack .../ntpsec-ntpdate_1.2.1+dfsg1-7+b1_amd64.deb ...

Unpacking ntpsec-ntpdate (1.2.1+dfsg1-7+b1) ...

Selecting previously unselected package ntpdate.

Preparing to unpack .../ntpdate_1%3a4.2.8p15+dfsg-2~1.2.1+dfsg1-7_all.deb ...

Unpacking ntpdate (1:4.2.8p15+dfsg-2~1.2.1+dfsg1-7) ...

Preparing to unpack .../rpcbind_1.2.6-6+b1_amd64.deb ...

Unpacking rpcbind (1.2.6-6+b1) over (1.2.6-3) ...

Preparing to unpack .../gcc-12-base_12.2.0-3_amd64.deb ...

Unpacking gcc-12-base:amd64 (12.2.0-3) over (12.1.0-2) ...

Preparing to unpack .../libgcc-s1_12.2.0-3_amd64.deb ...

Unpacking libgcc-s1:amd64 (12.2.0-3) over (12.1.0-2) ...

Preparing to unpack .../cron_3.0pl1-150+b1_amd64.deb ...

Unpacking cron (3.0pl1-150+b1) over (3.0pl1-144) ...

Selecting previously unselected package apache2-bin.

Preparing to unpack .../apache2-bin_2.4.54-3_amd64.deb ...

Unpacking apache2-bin (2.4.54-3) ...

Selecting previously unselected package apache2-data.

Preparing to unpack .../apache2-data_2.4.54-3_all.deb ...

Unpacking apache2-data (2.4.54-3) ...

Selecting previously unselected package apache2-utils.

Preparing to unpack .../apache2-utils_2.4.54-3_amd64.deb ...

Unpacking apache2-utils (2.4.54-3) ...

Selecting previously unselected package mime-support.

Preparing to unpack .../deb/mime-support_3.66_all.deb ...

Unpacking mime-support (3.66) ...

Selecting previously unselected package apache2.

Preparing to unpack .../deb/apache2_2.4.54-3_amd64.deb ...

Unpacking apache2 (2.4.54-3) ...

Selecting previously unselected package bind9-libs:amd64.

Preparing to unpack .../bind9-libs_1%3a9.18.7-1_amd64.deb ...

Unpacking bind9-libs:amd64 (1:9.18.7-1) ...

Selecting previously unselected package bind9-utils.

Preparing to unpack .../bind9-utils_1%3a9.18.7-1_amd64.deb ...

Unpacking bind9-utils (1:9.18.7-1) ...

Selecting previously unselected package dns-root-data.

Preparing to unpack .../dns-root-data_2021011101_all.deb ...

Unpacking dns-root-data (2021011101) ...

Selecting previously unselected package bind9.

Preparing to unpack .../bind9_1%3a9.18.7-1_amd64.deb ...

Unpacking bind9 (1:9.18.7-1) ...

Selecting previously unselected package libntfs-3g89.

Preparing to unpack .../libntfs-3g89_1%3a2022.5.17-1_amd64.deb ...

Unpacking libntfs-3g89 (1:2022.5.17-1) ...

Selecting previously unselected package ntfs-3g.

Preparing to unpack .../ntfs-3g_1%3a2022.5.17-1_amd64.deb ...

Unpacking ntfs-3g (1:2022.5.17-1) ...

Selecting previously unselected package update-inetd.

Preparing to unpack .../deb/update-inetd_4.51_all.deb ...

Unpacking update-inetd (4.51) ...

Selecting previously unselected package openbsd-inetd.

Preparing to unpack .../openbsd-inetd_0.20160825-5+b1_amd64.deb ...

Unpacking openbsd-inetd (0.20160825-5+b1) ...

Preparing to unpack .../python3.10_3.10.8-1_amd64.deb ...

Unpacking python3.10 (3.10.8-1) over (3.10.5-1) ...

Preparing to unpack .../libpython3.10-stdlib_3.10.8-1_amd64.deb ...

Unpacking libpython3.10-stdlib:amd64 (3.10.8-1) over (3.10.5-1) ...

Preparing to unpack .../python3.10-minimal_3.10.8-1_amd64.deb ...

Unpacking python3.10-minimal (3.10.8-1) over (3.10.5-1) ...

Preparing to unpack .../libpython3.10-minimal_3.10.8-1_amd64.deb ...

Unpacking libpython3.10-minimal:amd64 (3.10.8-1) over (3.10.5-1) ...

Selecting previously unselected package trousers.

Preparing to unpack .../trousers_0.3.15-0.2+b1_amd64.deb ...

Unpacking trousers (0.3.15-0.2+b1) ...

Selecting previously unselected package uuid-runtime.

Preparing to unpack .../uuid-runtime_2.38.1-1.1+b1_amd64.deb ...

Unpacking uuid-runtime (2.38.1-1.1+b1) ...

Selecting previously unselected package bind9-host.

Preparing to unpack .../bind9-host_1%3a9.18.7-1_amd64.deb ...

Unpacking bind9-host (1:9.18.7-1) ...

Selecting previously unselected package bind9-dnsutils.

Preparing to unpack .../bind9-dnsutils_1%3a9.18.7-1_amd64.deb ...

Unpacking bind9-dnsutils (1:9.18.7-1) ...

Selecting previously unselected package inetutils-telnet.

Preparing to unpack .../inetutils-telnet_2%3a2.4-1_amd64.deb ...

Unpacking inetutils-telnet (2:2.4-1) ...

Selecting previously unselected package traceroute.

Preparing to unpack .../traceroute_1%3a2.1.0-3_amd64.deb ...

Unpacking traceroute (1:2.1.0-3) ...

Selecting previously unselected package at.

Preparing to unpack .../deb/at_3.2.5-1+b1_amd64.deb ...

Unpacking at (3.2.5-1+b1) ...

Selecting previously unselected package automake.

Preparing to unpack .../automake_1%3a1.16.5-1.3_all.deb ...

Unpacking automake (1:1.16.5-1.3) ...

Selecting previously unselected package dosfstools.

Preparing to unpack .../deb/dosfstools_4.2-1_amd64.deb ...

Unpacking dosfstools (4.2-1) ...

Selecting previously unselected package exfat-fuse.

Preparing to unpack .../exfat-fuse_1.3.0+git20220115-2_amd64.deb ...

Unpacking exfat-fuse (1.3.0+git20220115-2) ...

Selecting previously unselected package exfatprogs.

Preparing to unpack .../exfatprogs_1.1.3-1+b1_amd64.deb ...

Unpacking exfatprogs (1.1.3-1+b1) ...

Selecting previously unselected package tnftp.

Preparing to unpack .../tnftp_20210827-4+b1_amd64.deb ...

Unpacking tnftp (20210827-4+b1) ...

Selecting previously unselected package ftp.

Preparing to unpack .../opt/deb/ftp_20210827-4_all.deb ...

Unpacking ftp (20210827-4) ...

Selecting previously unselected package libatomic1:amd64.

Preparing to unpack .../libatomic1_12.2.0-3_amd64.deb ...

Unpacking libatomic1:amd64 (12.2.0-3) ...

Selecting previously unselected package libquadmath0:amd64.

Preparing to unpack .../libquadmath0_12.2.0-3_amd64.deb ...

Unpacking libquadmath0:amd64 (12.2.0-3) ...

Selecting previously unselected package libgcc-12-dev:amd64.

Preparing to unpack .../libgcc-12-dev_12.2.0-3_amd64.deb ...

Unpacking libgcc-12-dev:amd64 (12.2.0-3) ...

Selecting previously unselected package gcc-12.

Preparing to unpack .../deb/gcc-12_12.2.0-3_amd64.deb ...

Unpacking gcc-12 (12.2.0-3) ...

Selecting previously unselected package gcc.

Preparing to unpack .../deb/gcc_4%3a12.2.0-1_amd64.deb ...

Unpacking gcc (4:12.2.0-1) ...

Selecting previously unselected package libpython3.10:amd64.

Preparing to unpack .../libpython3.10_3.10.8-1_amd64.deb ...

Unpacking libpython3.10:amd64 (3.10.8-1) ...

Selecting previously unselected package liberror-perl.

Preparing to unpack .../liberror-perl_0.17029-2_all.deb ...

Unpacking liberror-perl (0.17029-2) ...

Selecting previously unselected package iputils-tracepath.

Preparing to unpack .../iputils-tracepath_3%3a20211215-1_amd64.deb ...

Unpacking iputils-tracepath (3:20211215-1) ...

Selecting previously unselected package libatasmart4:amd64.

Preparing to unpack .../libatasmart4_0.19-5_amd64.deb ...

Unpacking libatasmart4:amd64 (0.19-5) ...

Selecting previously unselected package libopencryptoki0:amd64.

Preparing to unpack .../libopencryptoki0_3.8.1+dfsg-3.2+b3_amd64.deb ...

Unpacking libopencryptoki0:amd64 (3.8.1+dfsg-3.2+b3) ...

Selecting previously unselected package libudisks2-0:amd64.

Preparing to unpack .../libudisks2-0_2.9.4-3+b1_amd64.deb ...

Unpacking libudisks2-0:amd64 (2.9.4-3+b1) ...

Selecting previously unselected package opencryptoki.

Preparing to unpack .../opencryptoki_3.8.1+dfsg-3.2+b3_amd64.deb ...

Unpacking opencryptoki (3.8.1+dfsg-3.2+b3) ...

Selecting previously unselected package patch.

Preparing to unpack .../deb/patch_2.7.6-7_amd64.deb ...

Unpacking patch (2.7.6-7) ...

Selecting previously unselected package rstatd.

Preparing to unpack .../rstatd_4.0.1-11+b1_amd64.deb ...

Unpacking rstatd (4.0.1-11+b1) ...

Preparing to unpack .../rsyslog_8.2210.0-1_amd64.deb ...

Unpacking rsyslog (8.2210.0-1) over (8.2206.0-1) ...

Selecting previously unselected package rusersd.

Preparing to unpack .../deb/rusersd_0.17-12_amd64.deb ...

Unpacking rusersd (0.17-12) ...

Selecting previously unselected package sysstat.

Preparing to unpack .../sysstat_12.5.6-1+b1_amd64.deb ...

Unpacking sysstat (12.5.6-1+b1) ...

Selecting previously unselected package telnet.

Preparing to unpack .../deb/telnet_0.17+2.4-1_all.deb ...

Unpacking telnet (0.17+2.4-1) ...

Selecting previously unselected package telnetd-ssl.

Preparing to unpack .../telnetd-ssl_0.17.41+really0.17-2_amd64.deb ...

Unpacking telnetd-ssl (0.17.41+really0.17-2) ...

Selecting previously unselected package udisks2.

Preparing to unpack .../udisks2_2.9.4-3+b1_amd64.deb ...

Unpacking udisks2 (2.9.4-3+b1) ...

Selecting previously unselected package vsftpd.

Preparing to unpack .../vsftpd_3.0.3-13+b2_amd64.deb ...

Unpacking vsftpd (3.0.3-13+b2) ...

Preparing to unpack .../python3.10_3.10.6-1_amd64.deb ...

Unpacking python3.10 (3.10.6-1) over (3.10.8-1) ...

Preparing to unpack .../libpython3.10-stdlib_3.10.6-1_amd64.deb ...

Unpacking libpython3.10-stdlib:amd64 (3.10.6-1) over (3.10.8-1) ...

Preparing to unpack .../python3.10-minimal_3.10.6-1_amd64.deb ...

Unpacking python3.10-minimal (3.10.6-1) over (3.10.8-1) ...

Preparing to unpack .../libpython3.10-minimal_3.10.6-1_amd64.deb ...

Unpacking libpython3.10-minimal:amd64 (3.10.6-1) over (3.10.8-1) ...

Selecting previously unselected package python3-dnspython.

Preparing to unpack .../python3-dnspython_2.2.1-2_all.deb ...

Unpacking python3-dnspython (2.2.1-2) ...

Preparing to unpack .../libpython3.10_3.10.6-1_amd64.deb ...

Unpacking libpython3.10:amd64 (3.10.6-1) over (3.10.8-1) ...

Selecting previously unselected package python3-ldb.

Preparing to unpack .../python3-ldb_2%3a2.5.2+samba4.16.4-2_amd64.deb ...

Unpacking python3-ldb (2:2.5.2+samba4.16.4-2) ...

Selecting previously unselected package python3-tdb.

Preparing to unpack .../python3-tdb_1.4.6-3_amd64.deb ...

Unpacking python3-tdb (1.4.6-3) ...

Selecting previously unselected package libavahi-common-data:amd64.

Preparing to unpack .../libavahi-common-data_0.8-6_amd64.deb ...

Unpacking libavahi-common-data:amd64 (0.8-6) ...

Selecting previously unselected package python3-talloc:amd64.

Preparing to unpack .../python3-talloc_2.3.3-4_amd64.deb ...

Unpacking python3-talloc:amd64 (2.3.3-4) ...

Selecting previously unselected package python3-samba.

Preparing to unpack .../python3-samba_2%3a4.16.4+dfsg-2_amd64.deb ...

Unpacking python3-samba (2:4.16.4+dfsg-2) ...

Selecting previously unselected package gawk.

Preparing to unpack .../deb/gawk_1%3a5.1.0-1_amd64.deb ...

Unpacking gawk (1:5.1.0-1) ...

More than one copy of package python3.10 has been unpacked

in this run !  Only configuring it once.

More than one copy of package libpython3.10-stdlib:amd64 has been unpacked

in this run !  Only configuring it once.

More than one copy of package python3.10-minimal has been unpacked

in this run !  Only configuring it once.

More than one copy of package libpython3.10-minimal:amd64 has been unpacked

in this run !  Only configuring it once.

More than one copy of package libpython3.10:amd64 has been unpacked

in this run !  Only configuring it once.

Setting up python3-ntp (1.2.1+dfsg1-7+b1) ...

Setting up gcc-12-base:amd64 (12.2.0-3) ...

Setting up apache2-data (2.4.54-3) ...

Setting up dns-root-data (2021011101) ...

Setting up libntfs-3g89 (1:2022.5.17-1) ...

Setting up update-inetd (4.51) ...

Setting up libpython3.10-minimal:amd64 (3.10.6-1) ...

Setting up traceroute (1:2.1.0-3) ...

update-alternatives: using /usr/bin/traceroute.db to provide /usr/bin/traceroute (traceroute) in auto mode

update-alternatives: using /usr/bin/traceroute6.db to provide /usr/bin/traceroute6 (traceroute6) in auto mode

update-alternatives: using /usr/bin/lft.db to provide /usr/bin/lft (lft) in auto mode

update-alternatives: using /usr/bin/traceproto.db to provide /usr/bin/traceproto (traceproto) in auto mode

update-alternatives: using /usr/sbin/tcptraceroute.db to provide /usr/sbin/tcptraceroute (tcptraceroute) in auto mode

Setting up dosfstools (4.2-1) ...

Setting up tnftp (20210827-4+b1) ...

update-alternatives: using /usr/bin/tnftp to provide /usr/bin/ftp (ftp) in auto mode

Setting up ftp (20210827-4) ...

Setting up libatomic1:amd64 (12.2.0-3) ...

Setting up libquadmath0:amd64 (12.2.0-3) ...

Setting up liberror-perl (0.17029-2) ...

Setting up iputils-tracepath (3:20211215-1) ...

Setting up libatasmart4:amd64 (0.19-5) ...

Setting up patch (2.7.6-7) ...

Setting up python3-dnspython (2.2.1-2) ...

Setting up libavahi-common-data:amd64 (0.8-6) ...

Setting up libgcc-s1:amd64 (12.2.0-3) ...

Setting up mime-support (3.66) ...

Setting up apache2 (2.4.54-3) ...

Enabling module mpm_event.

Enabling module authz_core.

Enabling module authz_host.

Enabling module authn_core.

Enabling module auth_basic.

Enabling module access_compat.

Enabling module authn_file.

Enabling module authz_user.

Enabling module alias.

Enabling module dir.

Enabling module autoindex.

Enabling module env.

Enabling module mime.

Enabling module negotiation.

Enabling module setenvif.

Enabling module filter.

Startin[   70.428697][  T327] Enabling module deflate.
...

Enabling module reqtimeout.

Enabling conf localized-error-pages.

Enabling conf other-vhosts-access-log.

Enabling conf security.

Enabling conf serve-cgi-bin.

Enabling site 000-default.

Setting up bind9-libs:amd64 (1:9.18.7-1) ...

Setting up bind9-utils (1:9.18.7-1) ...

Setting up bind9 (1:9.18.7-1) ...

Adding group `bind' (GID 112) ...

Done.

Adding system user `bind' (UID 107) ...

Adding new user `bind' (UID 107) with group `bind' ...

Not creating home directory `/var/cache/bind'.

wrote key file "/etc/bind/rndc.key"

Setting up ntfs-3g (1:2022.5.17-1) ...

Setting up openbsd-inetd (0.20160825-5+b1) ...

Setting up python3.10 (3.10.6-1) ...

Setting up libpython3.10-stdlib:amd64 (3.10.6-1) ...

Setting up python3.10-minimal (3.10.6-1) ...

Setting up trousers (0.3.15-0.2+b1) ...

Setting up uuid-runtime (2.38.1-1.1+b1) ...

Adding group `uuidd' (GID 113) ...

Done.

Setting up bind9-host (1:9.18.7-1) ...

Setting up bind9-dnsutils (1:9.18.7-1) ...

Setting up inetutils-telnet (2:2.4-1) ...

update-alternatives: using /usr/bin/inetutils-telnet to provide /usr/bin/telnet (telnet) in auto mode

Setting up at (3.2.5-1+b1) ...

Setting up automake (1:1.16.5-1.3) ...

update-alternatives: using /usr/bin/automake-1.16 to provide /usr/bin/automake (automake) in auto mode

Setting up exfat-fuse (1.3.0+git20220115-2) ...

Setting up exfatprogs (1.1.3-1+b1) ...

Setting up libgcc-12-dev:amd64 (12.2.0-3) ...

Setting up gcc-12 (12.2.0-3) ...

Setting up gcc (4:12.2.0-1) ...

Setting up libpython3.10:amd64 (3.10.6-1) ...

Setting up libopencryptoki0:amd64 (3.8.1+dfsg-3.2+b3) ...

Setting up libudisks2-0:amd64 (2.9.4-3+b1) ...

Setting up opencryptoki (3.8.1+dfsg-3.2+b3) ...

Adding group `pkcs11' (GID 114) ...

Done.

Adding user `root' to group `pkcs11' ...

Done.

Setting up rstatd (4.0.1-11+b1) ...

Setting up rsyslog (8.2210.0-1) ...

Setting up rusersd (0.17-12) ...

Setting up sysstat (12.5.6-1+b1) ...

Setting up telnet (0.17+2.4-1) ...

Setting up telnetd-ssl (0.17.41+really0.17-2) ...

Setting up udisks2 (2.9.4-3+b1) ...

Setting up vsftpd (3.0.3-13+b2) ...

Setting up python3-ldb (2:2.5.2+samba4.16.4-2) ...

Setting up python3-tdb (1.4.6-3) ...

Setting up python3-talloc:amd64 (2.3.3-4) ...

Setting up python3-samba (2:4.16.4+dfsg-2) ...

Setting up gawk (1:5.1.0-1) ...

Setting up ntpsec-ntpdate (1.2.1+dfsg1-7+b1) ...

Setting up ntpdate (1:4.2.8p15+dfsg-2~1.2.1+dfsg1-7) ...

Setting up rpcbind (1.2.6-6+b1) ...

Installing new version of config file /etc/init.d/rpcbind ...

Setting up cron (3.0pl1-150+b1) ...

Setting up apache2-bin (2.4.54-3) ...

Setting up apache2-utils (2.4.54-3) ...

Processing triggers for libc-bin (2.33-7) ...

Processing triggers for dbus (1.14.0-1) ...

dpkg: regarding .../ntfs-3g_1%3a2022.5.17-1_amd64.deb containing ntfs-3g, pre-dependency problem:

ntfs-3g pre-depends on fuse

fuse is not installed.



dpkg: warning: ignoring pre-dependency problem!

dpkg: regarding .../python3.10-minimal_3.10.8-1_amd64.deb containing python3.10-minimal, pre-dependency problem:

python3.10-minimal pre-depends on libc6 (>= 2.35)

libc6:amd64 is installed, but is version 2.33-7.



dpkg: warning: ignoring pre-dependency problem!

dpkg: warning: downgrading python3.10 from 3.10.8-1 to 3.10.6-1

dpkg: warning: downgrading libpython3.10-stdlib:amd64 from 3.10.8-1 to 3.10.6-1

dpkg: warning: downgrading python3.10-minimal from 3.10.8-1 to 3.10.6-1

dpkg: regarding .../python3.10-minimal_3.10.6-1_amd64.deb containing python3.10-minimal, pre-dependency problem:

python3.10-minimal pre-depends on libc6 (>= 2.34)

libc6:amd64 is installed, but is version 2.33-7.



dpkg: warning: ignoring pre-dependency problem!

dpkg: warning: downgrading libpython3.10-minimal:amd64 from 3.10.8-1 to 3.10.6-1

dpkg: warning: downgrading libpython3.10:amd64 from 3.10.8-1 to 3.10.6-1

dpkg: regarding .../deb/gawk_1%3a5.1.0-1_amd64.deb containing gawk, pre-dependency problem:

gawk pre-depends on libmpfr6 (>= 3.1.3)

libmpfr6 is not installed.



dpkg: warning: ignoring pre-dependency problem!

dpkg: regarding .../deb/gawk_1%3a5.1.0-1_amd64.deb containing gawk, pre-dependency problem:

gawk pre-depends on libsigsegv2 (>= 2.9)

libsigsegv2 is not installed.



dpkg: warning: ignoring pre-dependency problem!

debconf: unable to initialize frontend: Dialog

debconf: (TERM is not set, so the dialog frontend is not usable.)

debconf: falling back to frontend: Readline

debconf: unable to initialize frontend: Readline

debconf: (This frontend requires a controlling tty.)

debconf: falling back to frontend: Teletype

dpkg: mime-support: dependency problems, but configuring anyway as you requested:

mime-support depends on mailcap; however:

Package mailcap is not installed.



dpkg: apache2: dependency problems, but configuring anyway as you requested:

apache2 depends on apache2-bin (= 2.4.54-3).

apache2 depends on apache2-utils (= 2.4.54-3).





dpkg: bind9-libs:amd64: dependency problems, but configuring anyway as you requested:

bind9-libs:amd64 depends on libuv1 (>= 1.40.0); however:

Package libuv1 is not installed.

bind9-libs:amd64 depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.

bind9-libs:amd64 depends on libfstrm0 (>= 0.2.0); however:

Package libfstrm0 is not installed.

bind9-libs:amd64 depends on libjemalloc2 (>= 4.0.0); however:

Package libjemalloc2 is not installed.

bind9-libs:amd64 depends on liblmdb0 (>= 0.9.7); however:

Package liblmdb0 is not installed.

bind9-libs:amd64 depends on libmaxminddb0 (>= 1.3.0); however:

Package libmaxminddb0 is not installed.

bind9-libs:amd64 depends on libprotobuf-c1 (>= 1.0.1); however:

Package libprotobuf-c1 is not installed.

bind9-libs:amd64 depends on libxml2 (>= 2.7.4); however:

Package libxml2 is not installed.



dpkg: bind9-utils: dependency problems, but configuring anyway as you requested:

bind9-utils depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: bind9: dependency problems, but configuring anyway as you requested:

bind9 depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.

bind9 depends on libfstrm0 (>= 0.2.0); however:

Package libfstrm0 is not installed.

bind9 depends on liblmdb0 (>= 0.9.7); however:

Package liblmdb0 is not installed.

bind9 depends on libmaxminddb0 (>= 1.3.0); however:

Package libmaxminddb0 is not installed.

bind9 depends on libprotobuf-c1 (>= 1.0.0); however:

Package libprotobuf-c1 is not installed.

bind9 depends on libuv1 (>= 1.40.0); however:

Package libuv1 is not installed.

bind9 depends on libxml2 (>= 2.7.4); however:

Package libxml2 is not installed.



named-resolvconf.service is a disabled or a static unit, not starting it.



dpkg: ntfs-3g: dependency problems, but configuring anyway as you requested:

ntfs-3g depends on fuse; however:

Package fuse is not installed.



dpkg: openbsd-inetd: dependency problems, but configuring anyway as you requested:

openbsd-inetd depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.

openbsd-inetd depends on libevent-2.1-7 (>= 2.1.8-stable); however:

Package libevent-2.1-7 is not installed.

openbsd-inetd depends on tcpd; however:

Package tcpd is not installed.




dpkg: python3.10: dependency problems, but configuring anyway as you requested:

python3.10 depends on python3.10-minimal (= 3.10.6-1).

python3.10 depends on libpython3.10-stdlib (= 3.10.6-1).



dpkg: libpython3.10-stdlib:amd64: dependency problems, but configuring anyway as you requested:

libpython3.10-stdlib:amd64 depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: python3.10-minimal: dependency problems, but configuring anyway as you requested:

python3.10-minimal depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: trousers: dependency problems, but configuring anyway as you requested:

trousers depends on tpm-udev; however:

Package tpm-udev is not installed.




dpkg: error processing package trousers (--install):

installed trousers package post-installation script subprocess returned error exit status 1

dpkg: uuid-runtime: dependency problems, but configuring anyway as you requested:

uuid-runtime depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.




uuidd.service is a disabled or a static unit, not starting it.

dpkg: bind9-host: dependency problems, but configuring anyway as you requested:

bind9-host depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: bind9-dnsutils: dependency problems, but configuring anyway as you requested:

bind9-dnsutils depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.

bind9-dnsutils depends on libprotobuf-c1 (>= 1.0.0); however:

Package libprotobuf-c1 is not installed.



dpkg: inetutils-telnet: dependency problems, but configuring anyway as you requested:

inetutils-telnet depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: at: dependency problems, but configuring anyway as you requested:

at depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.




dpkg: automake: dependency problems, but configuring anyway as you requested:

automake depends on autoconf; however:

Package autoconf is not installed.

automake depends on autotools-dev; however:

Package autotools-dev is not installed.



dpkg: exfat-fuse: dependency problems, but configuring anyway as you requested:

exfat-fuse depends on libfuse2 (>= 2.6); however:

Package libfuse2 is not installed.

exfat-fuse depends on fuse; however:

Package fuse is not installed.



dpkg: exfatprogs: dependency problems, but configuring anyway as you requested:

exfatprogs depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: libgcc-12-dev:amd64: dependency problems, but configuring anyway as you requested:

libgcc-12-dev:amd64 depends on libgomp1 (>= 12.2.0-3); however:

Package libgomp1 is not installed.

libgcc-12-dev:amd64 depends on libitm1 (>= 12.2.0-3); however:

Package libitm1 is not installed.

libgcc-12-dev:amd64 depends on libasan8 (>= 12.2.0-3); however:

Stoppin[   79.087117][  T327]   Package libasan8 is not installed.
libgcc-12-dev:amd64 depends on liblsan0 (>= 12.2.0-3); however:

m.

;39mRPCbind Server Activation So[   79.149717][  T327]  libgcc-12-dev:amd64 depends on libubsan1 (>= 12.2.0-3); however:

Package libubsan1 is not installed.



dpkg: gcc-12: dependency problems, but configuring anyway as you requested:

gcc-12 depends on cpp-12 (= 12.2.0-3); however:

Package cpp-12 is not installed.

gcc-12 depends on libcc1-0 (>= 12.2.0-3); however:

Package libcc1-0 is not installed.

gcc-12 depends on binutils (>= 2.38.90.20220713); however:

Package binutils is not installed.

gcc-12 depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.

gcc-12 depends on libisl23 (>= 0.15); however:

Package libisl23 is not installed.

gcc-12 depends on libmpc3 (>= 1.1.0); however:

Package libmpc3 is not installed.

gcc-12 depends on libmpfr6 (>= 3.1.3); however:

Package libmpfr6 is not installed.



dpkg: gcc: dependency problems, but configuring anyway as you requested:

gcc depends on cpp (= 4:12.2.0-1); however:

Package cpp is not installed.



dpkg: libpython3.10:amd64: dependency problems, but configuring anyway as you requested:

libpython3.10:amd64 depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: libopencryptoki0:amd64: dependency problems, but configuring anyway as you requested:

libopencryptoki0:amd64 depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.

libopencryptoki0:amd64 depends on libitm1 (>= 4.7); however:

Package libitm1 is not installed.

libopencryptoki0:amd64 depends on libtspi1 (>= 0.3.1); however:

Package libtspi1 is not installed.



dpkg: libudisks2-0:amd64: dependency problems, but configuring anyway as you requested:

libudisks2-0:amd64 depends on libglib2.0-0 (>= 2.50); however:

Package libglib2.0-0 is not installed.



dpkg: opencryptoki: dependency problems, but configuring anyway as you requested:

opencryptoki depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.




dpkg: rstatd: dependency problems, but configuring anyway as you requested:

rstatd depends on rpcbind | netbase (<< 4.00); however:

Version of netbase on system is 6.3.

rstatd depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: rsyslog: dependency problems, but configuring anyway as you requested:

rsyslog depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: rusersd: dependency problems, but configuring anyway as you requested:

rusersd depends on rpcbind | portmap; however:

Package portmap is not installed.

rusersd depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: sysstat: dependency problems, but configuring anyway as you requested:

sysstat depends on xz-utils; however:

Package xz-utils is not installed.

sysstat depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



debconf: unable to initialize frontend: Dialog

debconf: (TERM is not set, so the dialog frontend is not usable.)

debconf: falling back to frontend: Readline

debconf: unable to initialize frontend: Readline

debconf: (This frontend requires a controlling tty.)

debconf: falling back to frontend: Teletype



Creating config file /etc/default/sysstat with new version

update-alternatives: using /usr/bin/sar.sysstat to provide /usr/bin/sar (sar) in auto mode




dpkg: telnetd-ssl: dependency problems, but configuring anyway as you requested:

telnetd-ssl depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: udisks2: dependency problems, but configuring anyway as you requested:

udisks2 depends on libblockdev-fs2; however:

Package libblockdev-fs2 is not installed.

udisks2 depends on libblockdev-loop2; however:

Package libblockdev-loop2 is not installed.

udisks2 depends on libblockdev-part2; however:

Package libblockdev-part2 is not installed.

udisks2 depends on libblockdev-swap2; however:

Package libblockdev-swap2 is not installed.

udisks2 depends on parted; however:

Package parted is not installed.

udisks2 depends on libblockdev-utils2 (>= 2.24); however:

Package libblockdev-utils2 is not installed.

udisks2 depends on libblockdev2 (>= 2.25); however:

Package libblockdev2 is not installed.

udisks2 depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.

udisks2 depends on libglib2.0-0 (>= 2.50); however:

Package libglib2.0-0 is not installed.

udisks2 depends on libgudev-1.0-0 (>= 165); however:

Package libgudev-1.0-0 is not installed.

udisks2 depends on libpolkit-agent-1-0 (>= 0.102); however:

Package libpolkit-agent-1-0 is not installed.

udisks2 depends on libpolkit-gobject-1-0 (>= 0.102); however:

Package libpolkit-gobject-1-0 is not installed.




dpkg: vsftpd: dependency problems, but configuring anyway as you requested:

vsftpd depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



debconf: unable to initialize frontend: Dialog

debconf: (TERM is not set, so the dialog frontend is not usable.)

debconf: falling back to frontend: Readline

debconf: unable to initialize frontend: Readline

debconf: (This frontend requires a controlling tty.)

debconf: falling back to frontend: Teletype


dpkg: python3-ldb: dependency problems, but configuring anyway as you requested:

Stoppin[   81.222974][  T327]  python3-ldb depends on libldb2 (= 2:2.5.2+samba4.16.4-2); however:
ar background program processing[   81.236372][  T327]   Package libldb2 is not installed.

1;39mRegular background program [   81.261802][  T327]   Package libtalloc2 is not installed.
processing daemo[   81.261806][  T327] 


dpkg: python3-tdb: dependency problems, but configuring anyway as you requested:

python3-tdb depends on libtdb1 (= 1.4.6-3); however:

1;39mRegular bac[   81.317883][  T327] 
kground program [   81.317887][  T327] 
dpkg: python3-talloc:amd64: dependency problems, but configuring anyway as you requested:

python3-talloc:amd64 depends on libtalloc2 (= 2.3.3-4); however:

Package libtalloc2 is not installed.



dpkg: python3-samba: dependency problems, but configuring anyway as you requested:

python3-samba depends on samba-libs (= 2:4.16.4+dfsg-2); however:

Package samba-libs is not installed.

python3-samba depends on libldb2 (>= 0.9.21); however:

Package libldb2 is not installed.

python3-samba depends on libtalloc2 (>= 2.3.3-3~); however:

Package libtalloc2 is not installed.

python3-samba depends on libtevent0 (>= 0.11.0~); however:

Package libtevent0 is not installed.



dpkg: gawk: dependency problems, but configuring anyway as you requested:

gawk depends on libmpfr6 (>= 3.1.3); however:

Package libmpfr6 is not installed.

gawk depends on libsigsegv2 (>= 2.9); however:

Package libsigsegv2 is not installed.



dpkg: ntpsec-ntpdate: dependency problems, but configuring anyway as you requested:

ntpsec-ntpdate depends on ntpsec-ntpdig (= 1.2.1+dfsg1-7+b1); however:

Package ntpsec-ntpdig is not installed.



dpkg: rpcbind: dependency problems, but configuring anyway as you requested:

rpcbind depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: cron: dependency problems, but configuring anyway as you requested:

cron depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



dpkg: apache2-bin: dependency problems, but configuring anyway as you requested:

apache2-bin depends on libapr1 (>= 1.7.0); however:

Package libapr1 is not installed.

apache2-bin depends on libaprutil1 (>= 1.6.0); however:

Package libaprutil1 is not installed.

apache2-bin depends on libaprutil1-dbd-sqlite3 | libaprutil1-dbd-mysql | libaprutil1-dbd-odbc | libaprutil1-dbd-pgsql | libaprutil1-dbd-freetds; however:

Package libaprutil1-dbd-sqlite3 is not installed.

Package libaprutil1-dbd-mysql is not installed.

Package libaprutil1-dbd-odbc is not installed.

Package libaprutil1-dbd-pgsql is not installed.

Package libaprutil1-dbd-freetds is not installed.

apache2-bin depends on libaprutil1-ldap; however:

Package libaprutil1-ldap is not installed.

apache2-bin depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.

apache2-bin depends on liblua5.3-0; however:

Package liblua5.3-0 is not installed.

apache2-bin depends on libxml2 (>= 2.7.4); however:

Package libxml2 is not installed.



dpkg: apache2-utils: dependency problems, but configuring anyway as you requested:

apache2-utils depends on libapr1 (>= 1.4.8-2~); however:

Package libapr1 is not installed.

apache2-utils depends on libaprutil1 (>= 1.5.0); however:

Package libaprutil1 is not installed.

apache2-utils depends on libc6 (>= 2.34); however:

Version of libc6:amd64 on system is 2.33-7.



ldconfig: /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 is not a symbolic link



Stoppin[   83.463005][  T327] Errors were encountered while processing:
mon for Apache H[   83.480302][  T327] 
.

1;39mDisk Cache [   83.502425][  T327] 

Preparing to unpack .../deb/gawk_1%3a5.1.0-1_amd64.deb ...

Unpacking gawk (1:5.1.0-1) over (1:5.1.0-1) ...

Setting up gawk (1:5.1.0-1) ...

Startin[   83.569265][  T327] handle /opt/deb/keep-deb.hw...
.
(Reading database ... 19587 files and directories currently installed.)

for Apache HTTP[   83.628522][  T327] 
Setting up python3-ntp (1.2.1+dfsg1-7+b1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/ntpsec-ntpdate_1.2.1+dfsg1-7+b1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../ntpsec-ntpdate_1.2.1+dfsg1-7+b1_amd64.deb ...

Unpacking ntpsec-ntpdate (1.2.1+dfsg1-7+b1) over (1.2.1+dfsg1-7+b1) ...

Setting up ntpsec-ntpdate (1.2.1+dfsg1-7+b1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/ntpdate_1%3a4.2.8p15+dfsg-2~1.2.1+dfsg1-7_all.deb

(Reading database ... 19587 files and directories currently installed.)

.

1;39mDisk Cache [   83.811721][  T327] handle /opt/deb/keep-deb.fs...
install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3.10_3.10.6-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../python3.10_3.10.6-1_amd64.deb ...

Startin[   83.869640][  T327] Unpacking python3.10 (3.10.6-1) over (3.10.6-1) ...
mon for Apache H[   83.883357][  T327] 
install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/libpython3.10-stdlib_3.10.6-1_amd64.deb

Preparing to unpack .../libpython3.10-stdlib_3.10.6-1_amd64.deb ...

Unpacking libpython3.10-stdlib:amd64 (3.10.6-1) over (3.10.6-1) ...

Setting up libpython3.10-stdlib:amd64 (3.10.6-1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3.10-minimal_3.10.6-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../python3.10-minimal_3.10.6-1_amd64.deb ...

Unpacking python3.10-minimal (3.10.6-1) over (3.10.6-1) ...

Setting up python3.10-minimal (3.10.6-1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/libpython3.10-minimal_3.10.6-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../libpython3.10-minimal_3.10.6-1_amd64.deb ...

Unpacking libpython3.10-minimal:amd64 (3.10.6-1) over (3.10.6-1) ...

Setting up libpython3.10-minimal:amd64 (3.10.6-1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3-dnspython_2.2.1-2_all.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../python3-dnspython_2.2.1-2_all.deb ...

Unpacking python3-dnspython (2.2.1-2) over (2.2.1-2) ...

Setting up python3-dnspython (2.2.1-2) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/libpython3.10_3.10.6-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../libpython3.10_3.10.6-1_amd64.deb ...

Unpacking libpython3.10:amd64 (3.10.6-1) over (3.10.6-1) ...

Setting up libpython3.10:amd64 (3.10.6-1) ...

Processing triggers for libc-bin (2.33-7) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3-ldb_2%3a2.5.2+samba4.16.4-2_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../python3-ldb_2%3a2.5.2+samba4.16.4-2_amd64.deb ...

Unpacking python3-ldb (2:2.5.2+samba4.16.4-2) over (2:2.5.2+samba4.16.4-2) ...

Setting up python3-ldb (2:2.5.2+samba4.16.4-2) ...

Processing triggers for libc-bin (2.33-7) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3-tdb_1.4.6-3_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../python3-tdb_1.4.6-3_amd64.deb ...

Unpacking python3-tdb (1.4.6-3) over (1.4.6-3) ...

Setting up python3-tdb (1.4.6-3) ...

Processing triggers for libc-bin (2.33-7) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/libavahi-common-data_0.8-6_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../libavahi-common-data_0.8-6_amd64.deb ...

Unpacking libavahi-common-data:amd64 (0.8-6) over (0.8-6) ...

Setting up libavahi-common-data:amd64 (0.8-6) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3-talloc_2.3.3-4_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../python3-talloc_2.3.3-4_amd64.deb ...

Unpacking python3-talloc:amd64 (2.3.3-4) over (2.3.3-4) ...

Setting up python3-talloc:amd64 (2.3.3-4) ...

Processing triggers for libc-bin (2.33-7) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3-samba_2%3a4.16.4+dfsg-2_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../python3-samba_2%3a4.16.4+dfsg-2_amd64.deb ...

Unpacking python3-samba (2:4.16.4+dfsg-2) over (2:4.16.4+dfsg-2) ...

Setting up python3-samba (2:4.16.4+dfsg-2) ...

Processing triggers for libc-bin (2.33-7) ...

handle /opt/deb/keep-deb.ltp...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/rpcbind_1.2.6-6+b1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../rpcbind_1.2.6-6+b1_amd64.deb ...

Unpacking rpcbind (1.2.6-6+b1) over (1.2.6-6+b1) ...

Setting up rpcbind (1.2.6-6+b1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/gcc-12-base_12.2.0-3_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../gcc-12-base_12.2.0-3_amd64.deb ...

Unpacking gcc-12-base:amd64 (12.2.0-3) over (12.2.0-3) ...

Setting up gcc-12-base:amd64 (12.2.0-3) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/libgcc-s1_12.2.0-3_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../libgcc-s1_12.2.0-3_amd64.deb ...

Unpacking libgcc-s1:amd64 (12.2.0-3) over (12.2.0-3) ...

Setting up libgcc-s1:amd64 (12.2.0-3) ...

Processing triggers for libc-bin (2.33-7) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/cron_3.0pl1-150+b1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../cron_3.0pl1-150+b1_amd64.deb ...

Unpacking cron (3.0pl1-150+b1) over (3.0pl1-150+b1) ...

Setting up cron (3.0pl1-150+b1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/apache2-bin_2.4.54-3_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../apache2-bin_2.4.54-3_amd64.deb ...

Unpacking apache2-bin (2.4.54-3) over (2.4.54-3) ...

Setting up apache2-bin (2.4.54-3) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/apache2-data_2.4.54-3_all.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../apache2-data_2.4.54-3_all.deb ...

Unpacking apache2-data (2.4.54-3) over (2.4.54-3) ...

Setting up apache2-data (2.4.54-3) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/apache2-utils_2.4.54-3_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../apache2-utils_2.4.54-3_amd64.deb ...

Unpacking apache2-utils (2.4.54-3) over (2.4.54-3) ...

Setting up apache2-utils (2.4.54-3) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/mime-support_3.66_all.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../deb/mime-support_3.66_all.deb ...

Unpacking mime-support (3.66) over (3.66) ...

Setting up mime-support (3.66) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/apache2_2.4.54-3_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../deb/apache2_2.4.54-3_amd64.deb ...

Unpacking apache2 (2.4.54-3) over (2.4.54-3) ...

Setting up apache2 (2.4.54-3) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/bind9-libs_1%3a9.18.7-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../bind9-libs_1%3a9.18.7-1_amd64.deb ...

Unpacking bind9-libs:amd64 (1:9.18.7-1) over (1:9.18.7-1) ...

Setting up bind9-libs:amd64 (1:9.18.7-1) ...

Processing triggers for libc-bin (2.33-7) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/bind9-utils_1%3a9.18.7-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../bind9-utils_1%3a9.18.7-1_amd64.deb ...

Unpacking bind9-utils (1:9.18.7-1) over (1:9.18.7-1) ...

Setting up bind9-utils (1:9.18.7-1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/dns-root-data_2021011101_all.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../dns-root-data_2021011101_all.deb ...

Unpacking dns-root-data (2021011101) over (2021011101) ...

Setting up dns-root-data (2021011101) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/bind9_1%3a9.18.7-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../bind9_1%3a9.18.7-1_amd64.deb ...

Unpacking bind9 (1:9.18.7-1) over (1:9.18.7-1) ...

Setting up bind9 (1:9.18.7-1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/libntfs-3g89_1%3a2022.5.17-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../libntfs-3g89_1%3a2022.5.17-1_amd64.deb ...

Unpacking libntfs-3g89 (1:2022.5.17-1) over (1:2022.5.17-1) ...

Setting up libntfs-3g89 (1:2022.5.17-1) ...

Processing triggers for libc-bin (2.33-7) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/ntfs-3g_1%3a2022.5.17-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../ntfs-3g_1%3a2022.5.17-1_amd64.deb ...

Unpacking ntfs-3g (1:2022.5.17-1) over (1:2022.5.17-1) ...

Setting up ntfs-3g (1:2022.5.17-1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/update-inetd_4.51_all.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../deb/update-inetd_4.51_all.deb ...

Unpacking update-inetd (4.51) over (4.51) ...

Setting up update-inetd (4.51) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/openbsd-inetd_0.20160825-5+b1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../openbsd-inetd_0.20160825-5+b1_amd64.deb ...

Unpacking openbsd-inetd (0.20160825-5+b1) over (0.20160825-5+b1) ...

Setting up openbsd-inetd (0.20160825-5+b1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3.10_3.10.8-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../python3.10_3.10.8-1_amd64.deb ...

Unpacking python3.10 (3.10.8-1) over (3.10.6-1) ...

Setting up python3.10 (3.10.8-1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/libpython3.10-stdlib_3.10.8-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../libpython3.10-stdlib_3.10.8-1_amd64.deb ...

Unpacking libpython3.10-stdlib:amd64 (3.10.8-1) over (3.10.6-1) ...

Setting up libpython3.10-stdlib:amd64 (3.10.8-1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3.10-minimal_3.10.8-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../python3.10-minimal_3.10.8-1_amd64.deb ...

Unpacking python3.10-minimal (3.10.8-1) over (3.10.6-1) ...

Setting up python3.10-minimal (3.10.8-1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/libpython3.10-minimal_3.10.8-1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../libpython3.10-minimal_3.10.8-1_amd64.deb ...

Unpacking libpython3.10-minimal:amd64 (3.10.8-1) over (3.10.6-1) ...

Setting up libpython3.10-minimal:amd64 (3.10.8-1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/trousers_0.3.15-0.2+b1_amd64.deb

(Reading database ... 19587 files and directories currently installed.)

Preparing to unpack .../trousers_0.3.15-0.2+b1_amd64.deb ...

Unpacking trousers (0.3.15-0.2+b1) over (0.3.15-0.2+b1) ...

Setting up trousers (0.3.15-0.2+b1) ...

dpkg: trousers: dependency problems, but configuring anyway as you requested:

trousers depends on tpm-udev; however:

Package tpm-udev is not installed.




dpkg: error processing package trousers (--install):

installed trousers package post-installation script subprocess returned error exit status 1

Errors were encountered while processing:

trousers

LKP: waiting for network...

error: dpkg -i /opt/deb/trousers_0.3.15-0.2+b1_amd64.deb failed.

ldconfig: /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 is not a symbolic link



ls /sys/class/net

!!! IP-Config: No eth0/1/.. under /sys/class/net/ !!!
lo


watchdog: watchdog0: watchdog did not stop!
watchdog: watchdog0: watchdog did not stop!
kvm: exiting hardware virtualization
intel_rapl_msr intel_rapl_msr.0: shutdown
coretemp coretemp.0: shutdown
i2c i2c-6: shutdown
i2c i2c-5: shutdown
i2c i2c-4: shutdown
i2c i2c-3: shutdown
i2c i2c-2: shutdown
i2c i2c-1: shutdown
i2c 0-0053: shutdown
i2c 0-0052: shutdown
i2c 0-0051: shutdown
i2c 0-0050: shutdown
i2c i2c-0: shutdown
iTCO_wdt iTCO_wdt: shutdown
platform microcode: shutdown
platform Fixed MDIO bus.0: shutdown
serial8250 serial8250: shutdown
aer 0000:00:1c.0:pcie002: shutdown
pcie_pme 0000:00:1c.0:pcie001: shutdown
pcie_pme 0000:00:01.0:pcie001: shutdown
platform pcspkr: shutdown
system 00:09: shutdown
system 00:08: shutdown
system 00:07: shutdown
system 00:06: shutdown
system 00:05: shutdown
rtc_cmos 00:04: shutdown
system 00:03: shutdown
system 00:02: shutdown
serial 00:01: shutdown
system 00:00: shutdown
acpi-fan PNP0C0B:04: shutdown
acpi-fan PNP0C0B:03: shutdown
acpi-fan PNP0C0B:02: shutdown
acpi-fan PNP0C0B:01: shutdown
acpi-fan PNP0C0B:00: shutdown
acpi-wmi PNP0C14:00: shutdown
platform PNP0C0C:00: shutdown
intel_pmc_core INT33A1:00: shutdown
platform PNP0C0E:00: shutdown
platform ACPI000C:00: shutdown
platform PNP0C04:00: shutdown
platform PNP0103:00: shutdown
platform INT0800:00: shutdown
pci 0000:02:00.0: shutdown
pci 0000:00:1f.6: shutdown
i801_smbus 0000:00:1f.4: shutdown
pci 0000:00:1f.3: shutdown
pci 0000:00:1f.2: shutdown
pci 0000:00:1f.0: shutdown
pcieport 0000:00:1c.0: shutdown
pci 0000:00:17.0: shutdown
mei_me 0000:00:16.0: shutdown
pci 0000:00:14.2: shutdown
pci 0000:00:14.0: shutdown
i915 0000:00:02.0: shutdown
pcieport 0000:00:01.0: shutdown
skl_uncore 0000:00:00.0: shutdown
ACPI: PM: Preparing to enter system sleep state S5
PM: Calling mce_syscore_shutdown+0x0/0x10
PM: Calling i8259A_shutdown+0x0/0x10
reboot: Restarting system

--TR9O495S4ait0Bbo
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/ltp-syscalls.yaml
suite: ltp
testcase: ltp
category: functional
need_memory: 4G
disk: 1HDD
fs: f2fs
ltp:
  test: writev03.writev03
job_origin: ltp-syscalls.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d02
tbox_group: lkp-skl-d02
submit_id: 636c238e4a2ac894df47da13
job_file: "/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-writev03.writev03-debian-12-x86_64-20220629.cgz-8cbe83be2e63293c368eb2d580f2f69cb8b35e43-20221110-38111-wueeec-0.yaml"
id: 7ca89deceb3bf2e0c21b86d39c3439a842d7e228
queuer_version: "/zday/lkp"

#! hosts/lkp-skl-d02
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c500746fa0cc-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e41514d5105-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e41514d5105-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

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
- F2FS_FS
- BLK_DEV_LOOP
- CAN: m
- CAN_RAW: m
- CAN_VCAN: m
- MINIX_FS: m
- EXPERT: y
- CHECKPOINT_RESTORE: y

#! include/queue/cyclic
commit: 8cbe83be2e63293c368eb2d580f2f69cb8b35e43

#! include/testbox/lkp-skl-d02
need_kconfig_hw:
- PTP_1588_CLOCK: y
- E1000E: y
- SATA_AHCI
- DRM_I915
ucode: '0xf0'
bisect_dmesg: true

#! include/fs/OTHERS

#! include/ltp
rootfs: debian-12-x86_64-20220629.cgz
initrds:
- linux_headers
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2022-11-10 06:02:54.771813297 +08:00
_id: 636c238e4a2ac894df47da13
_rt: "/result/ltp/1HDD-f2fs-writev03.writev03/lkp-skl-d02/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 468a258547467261cf57d02efc7c8bbccd00180b
base_commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
branch: linux-devel/devel-hourly-20221106-042607
result_root: "/result/ltp/1HDD-f2fs-writev03.writev03/lkp-skl-d02/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-12-x86_64-20220629.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/ltp/1HDD-f2fs-writev03.writev03/lkp-skl-d02/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/vmlinuz-6.1.0-rc2-00194-g8cbe83be2e63
- branch=linux-devel/devel-hourly-20221106-042607
- job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-f2fs-writev03.writev03-debian-12-x86_64-20220629.cgz-8cbe83be2e63293c368eb2d580f2f69cb8b35e43-20221110-38111-wueeec-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=8cbe83be2e63293c368eb2d580f2f69cb8b35e43
- initcall_debug
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

#! runtime status
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/linux-headers.cgz"
bm_initrd: "/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/fs_20220824.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/ltp_20221031.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/ltp-x86_64-14c1f76-1_20221009.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20220629.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /db/releases/20221107090955/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.1.0-rc4-next-20221109
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/8cbe83be2e63293c368eb2d580f2f69cb8b35e43/vmlinuz-6.1.0-rc2-00194-g8cbe83be2e63"
dequeue_time: 2022-11-10 07:16:20.612270401 +08:00

#! /db/releases/20221109190458/lkp-src/include/site/inn
job_state: booting

--TR9O495S4ait0Bbo--
