Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9EF6560CC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 08:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiLZHgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 02:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZHgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:36:35 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6119533F;
        Sun, 25 Dec 2022 23:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672040191; x=1703576191;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LBQ9wZqY6i7NRfcWgG58wiGGI93j4o4XpMxUu6Kk6JI=;
  b=fvovW49L0S+P2LpYgormHhxup7ian1vRjAMWJIWaezpunJ2XF7mnPGgj
   Phs0ArxbjivEXUBY6FyPkW2aQWedxe9lyO0HbP2aNqjMltaOFH4aDmRQq
   elwsa//VPoI7apiFsDO8A9fy7gWoXQgQ6QWLJE08iysqYzbIjkiyoMB84
   tZrY3TQY+KNRMF0YMol1g1pVQFxiLVsM2ENr21WpRoIddMv+eu+GBIwHF
   tdxl8tgyNW/kPjF9uwldox4kP8Dwpp0r4M9nLOE+ZE+83JBGQKahkpAql
   Z5HDMRuPG0qOA9qMiYyOhAnWjDO0T6t19WHdEz8aLMVFqDrnyEASi/Nd2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="304035795"
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="xz'?yaml'?scan'208";a="304035795"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 23:36:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="981467097"
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="xz'?yaml'?scan'208";a="981467097"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 25 Dec 2022 23:36:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 25 Dec 2022 23:36:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 25 Dec 2022 23:36:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 25 Dec 2022 23:36:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 25 Dec 2022 23:36:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8hOdII2FlBhM9Vbz9ySjwOe9Ze6uuANYz+u2UmqcVCPNG67tKEKD/wnEDcZE9kA33Qhcom0Ze/Wei1Auu6HqUTvKghcrXboQsyT6ANsPd1GaUPcO4Mk6gW0dQX2b509/qDFikxK0UN+/8y2VCoKooNZZ9zQCDojQQk4LA1cWrA40t3Cw0gp0FL9wlzYXan0VAf/KTnXQRJSHMgpb1Fdn5sdrauCp06HQXNFJI5t6v6/x//xGJiA3irq53bHIRZmw2IRXrheOklWh6sZdktFURo5xgQAriMZ0NEBrRK73yz3yeL5PDN+q/bYLn4+fvsdInKMtYLB4Ql1C8S4XkI0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJbHHSJlJhBfhDoI6e6uRX9iq53jKkbsPBNBP3wEtq4=;
 b=NMWmdPn1PvBTFyS+Z2t1wJrCNkXXzJyhGcwvhK0zFQ85cWcSBHVuoLfEa1cFlDxBdz1bE4X5rOWuk0Son37r0U3tAH3licMLUlLAX0ncdtLsogRsktrEbC5n26kTTL2cZ5KNyE8hQv7IiiA+tbv17q+HCKbWnNrjG65OMWlI/6RIXsL+aVWHNSTUdmah9liHu8TfhXzCMK9Ik7Vip7+hfsdqMlQnnr8LdSkeXc2QJsSd5GAZbJhfKV2HLZrDXuZwHs5MG1k8sqjDDjq9cyeI+3VUyDIyOhAqRkTqHCl6byjCehgarll72IaMeh0qo8fKJhbawntIQq75Wi90YUg/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BL1PR11MB5239.namprd11.prod.outlook.com (2603:10b6:208:31a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Mon, 26 Dec
 2022 07:36:22 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241%7]) with mapi id 15.20.5944.013; Mon, 26 Dec 2022
 07:36:21 +0000
Date:   Mon, 26 Dec 2022 15:36:10 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Yu Kuai <yukuai3@huawei.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
Subject: [linus:master] [block, bfq]  64dc8c732f:
 BUG:KASAN:use-after-free_in_bfq_exit_icq_bfqq
Message-ID: <202212261504.41a8268b-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="eNp+rwtCxTPiKWyb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BL1PR11MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: a2997d7e-91a1-4d30-bf06-08dae713e1f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtG4ifnWSJ+evrLDvqqqRErcaRxLDt/trIwtcoUm/G971R03Mj1FHS5ulKvl3wEvJxzRF+6fNYvutqLvmLTlGI+8cHD4mCM85fIGcK73Ee/olWUMPhEEg12O7wM5pVZenFPccEoDDqEr8WOu4ahh6oG9ahQ7ejv5mfuNezoIT5I9fUS7yAekwOz0RnTQqx+mKD8v1ICcxCxhtXGJkRRLyDz5puHcfYNILlABpBUnPkfd/bdaXDlYwg5EqAFGIfV4TApQY+2CFKXUYNvwlU1JW/Kqr926qAQkDW0D1h+qJPaOtnZwsIqzpMlXMw3SIVWct0CTnAz6iiWFHd6AWB9eMewyZ0d1KyqUUoNT37bbVX4BBG8DHjOlRFtpIl4BVqOmtRb8ZniAkvgwqCiApcHsgjlcMf1WD2aexkP1nRguQqIC6nDnYJfPg1cuLn5yyLEZOk3NotUxBkaeZGmdgxmDovh41dffp+UQDvkSv3rU68Etar83kVnsjS7N9duq1cLf6fOFKbUsF6VvvQQbFXatId59XApkHU0VfX0O9Z1CFrNp2pKLtcBTxfbAfbQFrw4cnt3avEQvMlYTAS0AB+yhNJMhzaZLncT7atjKMuxxRwlkulAe5kJVLlgrNKeQbfeESHcu12ZSDiPeU4NLxRrc6yMl82j7BGdaEBIChKCbwkE164ggNcI6lrAgk5t+56Rtd/5OrFS5nJR/3DPyaRzKF9tgm7XrvjQGu72xtYb9APbD5r1RJiUWuMfvDUM6Lr+6+dxg7CTISX99Pl+DhnAeLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(83380400001)(86362001)(38100700002)(82960400001)(2906002)(30864003)(41300700001)(235185007)(5660300002)(8936002)(6666004)(44144004)(6506007)(478600001)(21490400003)(1076003)(2616005)(186003)(26005)(6512007)(966005)(316002)(4326008)(8676002)(66946007)(66556008)(66476007)(6486002)(54906003)(6916009)(36756003)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hb9Z94gL7/VzAiPhzcv8N5CunwgUbwQ1ES8MvI4rK54h0eCmu5j+CY/yLP3x?=
 =?us-ascii?Q?YqDOnkFUcywkFlUPds6SwmQSrMseckeAnL3k4hxsW/cVMOwUU3GFM0Ba0Nzk?=
 =?us-ascii?Q?axUpTv5HWEIW3QW6lF8FJFYz691kDAfb2Xat4f6jJ0LbP/Avf7tOfCpAWeRB?=
 =?us-ascii?Q?jHL/K6g9bXGGZYlwxnyx95x/nqpBjtPaDdaAasolPNDrnLqgz4JAbXagdvim?=
 =?us-ascii?Q?ZEzwbskB5Dy/F8ecQOuBsoxbF5QXhKWUZX9hj49qRdquhQ1M3XqtqW922DKr?=
 =?us-ascii?Q?LIWVSEkmt6MM5HAZCTlcIBsmA+CgVo9Pbs/9IIBnPI5C3T3GWOtwxc0fZljk?=
 =?us-ascii?Q?jGy59Cq8D0G41Kj1tLHHnuyeabECpnrwqQECFSW9K4ZqqKu5U2utYW/sP4so?=
 =?us-ascii?Q?qjwhnCh3BbFzTu2HpraUmCuwJITykuhwFhkCuTkn9yv6EmNn/xjDUvJ4NKEq?=
 =?us-ascii?Q?8vRtrl7UWF8fOwzNn6T5vty04fNjrqN60npMNyMeEu2ER3M86iJ4GH5vZlla?=
 =?us-ascii?Q?CtHhdYd4r4RJO5oUyx5W8FZPN1BKpCr3XhNptdd3quFTzwgVHcVB/FAy6Chk?=
 =?us-ascii?Q?eUs9UTJ34uMc13u2QMiytIIvThaGM+KkR6Yh2NZocU74efIOzYUZKv0m7T5O?=
 =?us-ascii?Q?opxsQZWuxzvmNzNm4lNieVb4x53NRvE83Jup2OPNeR1J6xwbHKJIG3GSQ9q9?=
 =?us-ascii?Q?tZANGebD8r2gKrOYJ/gMVygVUTb8rOhNkzXrmX6128ZKu8dS2vf9vdywwdoA?=
 =?us-ascii?Q?nNg7ojKTQ3lyTJcQOfjk2+Q7dN7k/fjb37E0sGyjmtK9ZvbvlR1vAiyDDbzO?=
 =?us-ascii?Q?CCiOvIOlAxllM6grrMqXZ18IGp3DHz9SlMqD0zXfs6y7Qfsvotr0ooaLkHrr?=
 =?us-ascii?Q?M3mHl15ybytwrGYEvrI9xN1oJXAKdkqGc8FD2f9HRqz74UH4PaU0DtEn5FtK?=
 =?us-ascii?Q?3lUk7orlH49o5z114XNthQrMXb18V8SfYT2UkgYs7cHCzhtlSJEImRxrB+HT?=
 =?us-ascii?Q?1QoOPl+tHx2TMGlPYM21bosJy1HpAEwlEd6WendM7VDLgjOYct79/G1eEFEB?=
 =?us-ascii?Q?+xx9IokkSs99a5kDY8ePd2Uj31xgmjMgahE6TmUArKsKo2MI6Cu3XgFNntBO?=
 =?us-ascii?Q?vKfAiM2Ot60UlU8FsH9pMg0KX0Ui6nhukWUapu1OXgbG5rAwxbnNI6JsVRDP?=
 =?us-ascii?Q?s43t2W3tDKen8RZrYyYyUjTp9GCmurCfPjxictvz3z0pZFRLOEgqAO+VBgk7?=
 =?us-ascii?Q?WcH6uVmSVpWbpWGSDpzdOWCg3zT2RjVnyU2jBLPwOo/yS6HkzEDEiljnuW/g?=
 =?us-ascii?Q?D0C8RdFPl/d5/QPfj2E6RskW+nLqsSDxd+RIQeeJgBHvNy2JkTEZwg8Jd3wp?=
 =?us-ascii?Q?mhjAo1b9Oo9Ap53gEV7af5e4U7hpdnhEgTLZpG4vPPwRk3CLyR4/ekUI7Yyn?=
 =?us-ascii?Q?h8n3d14/QngbVspRvW2URQNIUVngbTzd1Rq3xiGVHSFRvo48ecxqmB/yiUGD?=
 =?us-ascii?Q?I/WkV4ryPB99xVAQIUuEdXlFGVTd2WTt6w9IWdh6vwGO3Ah/K+hC9QwcKXfL?=
 =?us-ascii?Q?/jgZJeEZujfU8M24d9OBZQKD4MAo/rIcTbCgivunA8tyn0fhDCdaA+dL2nu0?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2997d7e-91a1-4d30-bf06-08dae713e1f8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2022 07:36:21.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMqUB/LFKv74hENmzRpvRKBfIlV/i63PWUYW6RpXaPgMKz7d/D9RkaSoCRugr5rqLgD0Vhr6C3QIKbd/mHJx2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5239
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--eNp+rwtCxTPiKWyb
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Greeting,

FYI, we noticed BUG:KASAN:use-after-free_in_bfq_exit_icq_bfqq due to commit (built with gcc-11):

commit: 64dc8c732f5c2b406cc752e6aaa1bd5471159cab ("block, bfq: fix possible uaf for 'bfqq->bic'")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master e45fb347b630ee76482fe938ba76cf8eab811290]

in testcase: blktests
version: blktests-x86_64-b35866f-1_20221206
with following parameters:

	disk: 1SSD
	test: block-027



on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202212261504.41a8268b-oliver.sang@intel.com


[ 68.195492][ T862] BUG: KASAN: use-after-free in bfq_exit_icq_bfqq (block/bfq-iosched.c:392 block/bfq-iosched.c:5321) 
[   68.203861][  T862] Read of size 8 at addr ffff8888019ded20 by task check/862
[   68.212059][  T862]
[   68.215294][  T862] CPU: 2 PID: 862 Comm: check Not tainted 6.1.0-09942-g64dc8c732f5c #1
[   68.224446][  T862] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[   68.233607][  T862] Call Trace:
[   68.237830][  T862]  <TASK>
[ 68.241700][ T862] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 68.247130][ T862] print_address_description+0x87/0x2a1 
[ 68.254648][ T862] print_report (mm/kasan/report.c:418) 
[ 68.260075][ T862] ? kasan_addr_to_slab (mm/kasan/common.c:35) 
[ 68.265933][ T862] ? bfq_exit_icq_bfqq (block/bfq-iosched.c:392 block/bfq-iosched.c:5321) 
[ 68.271970][ T862] kasan_report (mm/kasan/report.c:519) 
[ 68.277213][ T862] ? bfq_exit_icq_bfqq (block/bfq-iosched.c:392 block/bfq-iosched.c:5321) 
[ 68.283232][ T862] bfq_exit_icq_bfqq (block/bfq-iosched.c:392 block/bfq-iosched.c:5321) 
[ 68.289077][ T862] bfq_exit_icq (block/bfq-iosched.c:5349) 
[ 68.294394][ T862] ioc_destroy_icq (block/blk-ioc.c:56 block/blk-ioc.c:93) 
[ 68.300055][ T862] ioc_clear_queue (block/blk-ioc.c:187) 
[ 68.305717][ T862] ? ioc_find_get_icq (block/blk-ioc.c:173) 
[ 68.311633][ T862] ? mutex_lock (arch/x86/include/asm/atomic64_64.h:190 include/linux/atomic/atomic-long.h:443 include/linux/atomic/atomic-instrumented.h:1781 kernel/locking/mutex.c:171 kernel/locking/mutex.c:285) 
[ 68.316855][ T862] ? __mutex_lock_slowpath (kernel/locking/mutex.c:282) 
[ 68.323034][ T862] elevator_exit (block/elevator.c:164) 
[ 68.328355][ T862] del_gendisk (block/genhd.c:660) 
[ 68.333667][ T862] ? __pm_runtime_resume (drivers/base/power/runtime.c:1174) 
[ 68.339759][ T862] sd_remove (drivers/scsi/sd.c:3577) sd_mod
[ 68.345507][ T862] device_release_driver_internal (drivers/base/dd.c:1251 drivers/base/dd.c:1275) 
[ 68.352473][ T862] ? klist_put (include/linux/kref.h:66 lib/klist.c:206 lib/klist.c:217) 
[ 68.357778][ T862] bus_remove_device (drivers/base/bus.c:530) 
[ 68.363592][ T862] device_del (drivers/base/core.c:3705) 
[ 68.368811][ T862] ? __device_link_del (drivers/base/core.c:3660) 
[ 68.374815][ T862] ? __kmem_cache_free (mm/slub.c:1807 mm/slub.c:3787 mm/slub.c:3800) 
[ 68.380815][ T862] ? kobject_put (arch/x86/include/asm/atomic.h:190 include/linux/atomic/atomic-instrumented.h:177 include/linux/refcount.h:272 include/linux/refcount.h:315 include/linux/refcount.h:333 include/linux/kref.h:64 lib/kobject.c:721) 
[ 68.386114][ T862] ? sysfs_kf_bin_read (fs/sysfs/file.c:129) 
[ 68.392104][ T862] __scsi_remove_device (drivers/scsi/scsi_sysfs.c:1475) 
[ 68.398182][ T862] sdev_store_delete (drivers/scsi/scsi_sysfs.c:1516 drivers/scsi/scsi_sysfs.c:797) 
[ 68.403917][ T862] kernfs_fop_write_iter (fs/kernfs/file.c:334) 
[ 68.410059][ T862] vfs_write (include/linux/fs.h:2186 fs/read_write.c:491 fs/read_write.c:584) 
[ 68.415130][ T862] ? kernel_write (fs/read_write.c:565) 
[ 68.420608][ T862] ? __fget_light (include/linux/atomic/atomic-arch-fallback.h:227 include/linux/atomic/atomic-instrumented.h:35 fs/file.c:1015) 
[ 68.425971][ T862] ksys_write (fs/read_write.c:637) 
[ 68.430950][ T862] ? __ia32_sys_read (fs/read_write.c:627) 
[ 68.436450][ T862] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 68.441057][ T862] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 68.446152][ T862] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   68.452696][  T862] RIP: 0033:0x7f746cf6a8f3
[ 68.457767][ T862] Code: 8b 15 a1 25 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
All code
========
   0:	8b 15 a1 25 0e 00    	mov    0xe25a1(%rip),%edx        # 0xe25a7
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
[   68.478908][  T862] RSP: 002b:00007ffcb26ee558 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   68.488041][  T862] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f746cf6a8f3
[   68.496744][  T862] RDX: 0000000000000002 RSI: 000055dcfd0b7750 RDI: 0000000000000001
[   68.505450][  T862] RBP: 000055dcfd0b7750 R08: 000000000000000a R09: 0000000000000001
[   68.514154][  T862] R10: 000055dcfd122a00 R11: 0000000000000246 R12: 0000000000000002
[   68.522852][  T862] R13: 00007f746d04e6a0 R14: 0000000000000002 R15: 00007f746d049880
[   68.531556][  T862]  </TASK>
[   68.535303][  T862]
[   68.538338][  T862] Allocated by task 1400:
[ 68.543367][ T862] kasan_save_stack (mm/kasan/common.c:46) 
[ 68.548731][ T862] kasan_set_track (mm/kasan/common.c:52) 
[ 68.554011][ T862] __kasan_slab_alloc (mm/kasan/common.c:328) 
[ 68.559529][ T862] kmem_cache_alloc_node (mm/slab.h:761 mm/slub.c:3452 mm/slub.c:3497) 
[ 68.565469][ T862] bfq_get_queue (block/bfq-iosched.c:5689) 
[ 68.570714][ T862] bfq_get_bfqq_handle_split (block/bfq-iosched.c:6591) 
[ 68.576912][ T862] bfq_init_rq (block/bfq-iosched.c:6710) 
[ 68.582053][ T862] bfq_insert_request+0xdd/0x700 
[ 68.588230][ T862] bfq_insert_requests (include/linux/list.h:292 block/bfq-iosched.c:6134) 
[ 68.593961][ T862] blk_mq_sched_insert_request (block/blk-mq-sched.c:457) 
[ 68.600379][ T862] blk_mq_submit_bio (block/blk-mq.c:2995) 
[ 68.606010][ T862] submit_bio_noacct_nocheck (include/linux/bio.h:609 block/blk-core.c:682 block/blk-core.c:698 block/blk-core.c:687) 
[ 68.612243][ T862] __blkdev_direct_IO_async (block/fops.c:355) 
[ 68.618382][ T862] blkdev_read_iter (block/fops.c:362 block/fops.c:581) 
[ 68.623828][ T862] aio_read (fs/aio.c:1520 fs/aio.c:1560) 
[ 68.628583][ T862] io_submit_one (include/linux/instrumented.h:102 include/linux/atomic/atomic-instrumented.h:176 include/linux/refcount.h:272 include/linux/refcount.h:315 include/linux/refcount.h:333 fs/aio.c:1186 fs/aio.c:2022) 
[ 68.633764][ T862] __x64_sys_io_submit (fs/aio.c:2078 fs/aio.c:2048 fs/aio.c:2048) 
[ 68.639467][ T862] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 68.644473][ T862] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   68.650960][  T862]
[   68.653882][  T862] Freed by task 862:
[ 68.658366][ T862] kasan_save_stack (mm/kasan/common.c:46) 
[ 68.663632][ T862] kasan_set_track (mm/kasan/common.c:52) 
[ 68.668810][ T862] kasan_save_free_info (mm/kasan/generic.c:520) 
[ 68.674425][ T862] __kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244) 
[ 68.679954][ T862] kmem_cache_free (mm/slub.c:1807 mm/slub.c:3787 mm/slub.c:3809) 
[ 68.685313][ T862] bfq_put_queue (block/bfq-iosched.c:5266) 
[ 68.690504][ T862] bfq_exit_icq_bfqq (block/bfq-iosched.c:389 block/bfq-iosched.c:5321) 
[ 68.696030][ T862] bfq_exit_icq (block/bfq-iosched.c:5349) 
[ 68.701037][ T862] ioc_destroy_icq (block/blk-ioc.c:56 block/blk-ioc.c:93) 
[ 68.706388][ T862] ioc_clear_queue (block/blk-ioc.c:187) 
[ 68.711737][ T862] elevator_exit (block/elevator.c:164) 
[ 68.716734][ T862] del_gendisk (block/genhd.c:660) 
[ 68.721731][ T862] sd_remove (drivers/scsi/sd.c:3577) sd_mod
[ 68.727158][ T862] device_release_driver_internal (drivers/base/dd.c:1251 drivers/base/dd.c:1275) 
[ 68.733799][ T862] bus_remove_device (drivers/base/bus.c:530) 
[ 68.739318][ T862] device_del (drivers/base/core.c:3705) 
[ 68.744228][ T862] __scsi_remove_device (drivers/scsi/scsi_sysfs.c:1475) 
[ 68.750005][ T862] sdev_store_delete (drivers/scsi/scsi_sysfs.c:1516 drivers/scsi/scsi_sysfs.c:797) 
[ 68.755442][ T862] kernfs_fop_write_iter (fs/kernfs/file.c:334) 
[ 68.761313][ T862] vfs_write (include/linux/fs.h:2186 fs/read_write.c:491 fs/read_write.c:584) 
[ 68.766145][ T862] ksys_write (fs/read_write.c:637) 
[ 68.770971][ T862] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 68.775963][ T862] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   68.782442][  T862]
[   68.785361][  T862] The buggy address belongs to the object at ffff8888019deb80
[   68.785361][  T862]  which belongs to the cache bfq_queue of size 568
[   68.800590][  T862] The buggy address is located 416 bytes inside of
[   68.800590][  T862]  568-byte region [ffff8888019deb80, ffff8888019dedb8)
[   68.815221][  T862]
[   68.818171][  T862] The buggy address belongs to the physical page:
[   68.825204][  T862] page:0000000059db31a7 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8019dc
[   68.836068][  T862] head:0000000059db31a7 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
[   68.846747][  T862] flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[   68.855593][  T862] raw: 0017ffffc0010200 ffff8881103ea500 dead000000000122 0000000000000000
[   68.864771][  T862] raw: 0000000000000000 0000000080170017 00000001ffffffff 0000000000000000
[   68.873944][  T862] page dumped because: kasan: bad access detected
[   68.880954][  T862]
[   68.883885][  T862] Memory state around the buggy address:
[   68.890120][  T862]  ffff8888019dec00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   68.898794][  T862]  ffff8888019dec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   68.907453][  T862] >ffff8888019ded00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   68.916109][  T862]                                ^
[   68.921828][  T862]  ffff8888019ded80: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
[   68.930509][  T862]  ffff8888019dee00: fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb
[   68.939190][  T862] ==================================================================
[   68.947879][  T862] Disabling lock debugging due to kernel taint


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



--eNp+rwtCxTPiKWyb
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="config-6.1.0-09942-g64dc8c732f5c"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.1.0 Kernel Configuration
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
# CONFIG_TEST_MAPLE_TREE is not set
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

--eNp+rwtCxTPiKWyb
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='blktests'
	export testcase='blktests'
	export category='functional'
	export need_memory='3G'
	export job_origin='blktests-block.yaml'
	export queue_cmdline_keys=
	export queue='vip'
	export testbox='lkp-skl-d05'
	export tbox_group='lkp-skl-d05'
	export submit_id='63a90a470b9a931dee466247'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d05/blktests-1SSD-block-027-debian-11.1-x86_64-20220510.cgz-64dc8c732f5c2b406cc752e6aaa1bd5471159cab-20221226-73198-1r496rf-3.yaml'
	export id='7890eb55c092db5b113c1bbce3f0354f8e769417'
	export queuer_version='/lkp/xsang/.src-20221225-153151'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c50091e544de-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export commit='64dc8c732f5c2b406cc752e6aaa1bd5471159cab'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xf0'
	export bisect_dmesg=true
	export kernel_cmdline='cgroup_no_v1=all'
	export need_kconfig='BLK_DEV_SD
SCSI
{"BLOCK"=>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=>"y"}
{"BLK_DEV_NULL_BLK_FAULT_INJECTION"=>"y"}
{"RDMA_RXE"=>"m, x86_64"}
{"RDMA_SIW"=>"m, x86_64"}
{"BTRFS_FS"=>"m"}
{"BTRFS_FS_POSIX_ACL"=>"y"}'
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2022-12-26 10:43:19 +0800'
	export _id='63a90a4a0b9a931dee46624a'
	export _rt='/result/blktests/1SSD-block-027/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/64dc8c732f5c2b406cc752e6aaa1bd5471159cab'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='fd9a21443f9272935930ab2e8c71ab1f1bd0dba8'
	export base_commit='830b3c68c1fb1e9176028d02ef86f3cf76aa2476'
	export branch='linus/master'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/blktests/1SSD-block-027/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/64dc8c732f5c2b406cc752e6aaa1bd5471159cab/8'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/blktests/1SSD-block-027/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/64dc8c732f5c2b406cc752e6aaa1bd5471159cab/8
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/64dc8c732f5c2b406cc752e6aaa1bd5471159cab/vmlinuz-6.1.0-09942-g64dc8c732f5c
branch=linus/master
job=/lkp/jobs/scheduled/lkp-skl-d05/blktests-1SSD-block-027-debian-11.1-x86_64-20220510.cgz-64dc8c732f5c2b406cc752e6aaa1bd5471159cab-20221226-73198-1r496rf-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=64dc8c732f5c2b406cc752e6aaa1bd5471159cab
cgroup_no_v1=all
initcall_debug
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/64dc8c732f5c2b406cc752e6aaa1bd5471159cab/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/blktests_20221206.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/blktests-x86_64-b35866f-1_20221206.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.1.0-14015-gfd9a21443f92'
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/64dc8c732f5c2b406cc752e6aaa1bd5471159cab/vmlinuz-6.1.0-09942-g64dc8c732f5c'
	export dequeue_time='2022-12-26 12:21:55 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d05/blktests-1SSD-block-027-debian-11.1-x86_64-20220510.cgz-64dc8c732f5c2b406cc752e6aaa1bd5471159cab-20221226-73198-1r496rf-3.cgz'

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

	run_setup nr_ssd=1 $LKP_SRC/setup/disk

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='block-027' $LKP_SRC/tests/wrapper blktests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='block-027' $LKP_SRC/stats/wrapper blktests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time blktests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--eNp+rwtCxTPiKWyb
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--eNp+rwtCxTPiKWyb
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="blktests"

2022-12-26 04:23:56 echo block/027
2022-12-26 04:23:56 ./check block/027
block/027 (stress device hotplugging with running fio jobs and different schedulers)
block/027 (stress device hotplugging with running fio jobs and different schedulers) [failed]
    runtime    ...  21.367s
    something found in dmesg:
    [   55.578507] run blktests block/027 at 2022-12-26 04:23:56
    [   55.641203] calling  scsi_debug_init+0x0/0x1000 [scsi_debug] @ 881
    [   55.651416] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
    [   55.662039] scsi host4: scsi_debug: version 0191 [20210520]
                     dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
    [   55.678046] scsi 4:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
    [   55.678589] initcall scsi_debug_init+0x0/0x1000 [scsi_debug] returned 0 after 29835 usecs
    [   55.687512] scsi 4:0:0:1: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
    [   55.707563] scsi 4:0:0:2: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
    [   55.717751] scsi 4:0:0:3: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
    ...
    (See '/lkp/benchmarks/blktests/results/nodev/block/027.dmesg' for the entire message)

--eNp+rwtCxTPiKWyb
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/blktests-block.yaml
suite: blktests
testcase: blktests
category: functional
need_memory: 3G
disk: 1SSD
blktests:
  test: block-027
job_origin: blktests-block.yaml

#! queue options
queue_cmdline_keys: []
queue: vip
testbox: lkp-skl-d05
tbox_group: lkp-skl-d05
submit_id: 63a90a470b9a931dee466247
job_file: "/lkp/jobs/scheduled/lkp-skl-d05/blktests-1SSD-block-027-debian-11.1-x86_64-20220510.cgz-64dc8c732f5c2b406cc752e6aaa1bd5471159cab-20221226-73198-1r496rf-6.yaml"
id: 1f4ad10bff11f2e88cae5c80ba586dacbdef7058
queuer_version: "/lkp/xsang/.src-20221225-153151"

#! hosts/lkp-skl-d05
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50091e544de-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

#! include/category/functional
kmsg:
heartbeat:
meminfo:

#! include/queue/cyclic
commit: 64dc8c732f5c2b406cc752e6aaa1bd5471159cab

#! include/testbox/lkp-skl-d05
need_kconfig_hw:
- PTP_1588_CLOCK: y
- E1000E: y
- SATA_AHCI
- DRM_I915
ucode: '0xf0'
bisect_dmesg: true
kernel_cmdline: cgroup_no_v1=all

#! include/disk/nr_ssd
need_kconfig:
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- BLK_DEV_NULL_BLK_FAULT_INJECTION: y
- RDMA_RXE: m, x86_64
- RDMA_SIW: m, x86_64
- BTRFS_FS: m
- BTRFS_FS_POSIX_ACL: y

#! include/blktests
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2022-12-26 10:43:19.669193100 +08:00
_id: 63a90a4a0b9a931dee46624d
_rt: "/result/blktests/1SSD-block-027/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/64dc8c732f5c2b406cc752e6aaa1bd5471159cab"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: fd9a21443f9272935930ab2e8c71ab1f1bd0dba8
base_commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
branch: linus/master
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/blktests/1SSD-block-027/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/64dc8c732f5c2b406cc752e6aaa1bd5471159cab/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/blktests/1SSD-block-027/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/64dc8c732f5c2b406cc752e6aaa1bd5471159cab/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/64dc8c732f5c2b406cc752e6aaa1bd5471159cab/vmlinuz-6.1.0-09942-g64dc8c732f5c
- branch=linus/master
- job=/lkp/jobs/scheduled/lkp-skl-d05/blktests-1SSD-block-027-debian-11.1-x86_64-20220510.cgz-64dc8c732f5c2b406cc752e6aaa1bd5471159cab-20221226-73198-1r496rf-6.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=64dc8c732f5c2b406cc752e6aaa1bd5471159cab
- cgroup_no_v1=all
- initcall_debug
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/64dc8c732f5c2b406cc752e6aaa1bd5471159cab/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/blktests_20221206.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/blktests-x86_64-b35866f-1_20221206.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /db/releases/20221215193445/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.1.0
schedule_notify_address:
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/64dc8c732f5c2b406cc752e6aaa1bd5471159cab/vmlinuz-6.1.0-09942-g64dc8c732f5c"
dequeue_time: 2022-12-26 11:38:21.269417683 +08:00

#! /db/releases/20221225110937/lkp-src/include/site/inn
job_state: finished
loadavg: 6.44 1.88 0.65 1/160 1594
start_time: '1672026037'
end_time: '1672026059'
version: "/lkp/lkp/.src-20221223-102205:74b53200a:300cb7ba1"

--eNp+rwtCxTPiKWyb
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

echo block/027
./check block/027

--eNp+rwtCxTPiKWyb--
