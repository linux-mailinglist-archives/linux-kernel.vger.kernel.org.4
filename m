Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739FC6AD48B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCGCTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCGCTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:19:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8774E31E3E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678155536; x=1709691536;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=vq/lfdb1myQ11Nryr6/lzrLBdOG/b/jL9i4ILcX6mPk=;
  b=CyDK/fOSCyyQtWr8sfJVIi92D8Y/euahjtUB+3n3qGwANaNHDHpLdlGJ
   UQow1gOG/uJ5IiZrNuLQLWGAbpbbBz+sMKjYjoMkwqxCTZI2G0NcafPgG
   kkKB8lA+SHPMnjwnk8PAEmdgEGqoAdsHjALXJSaMsKhXFcRhnflPWb2MF
   6+w8xW/wuye7+xaKGhbEMMG/d0f+fHYhGpC0Ihw1zHcr9U3eXt4dwnXKK
   ePIOA7F3AvdxzfPEu1J+8JnIDW0LI2nZaZKwXDki91BuQxFmZLI32Cg0u
   /7Ri3hGnJMFngQJ8bhzBA/Ysu/ZASLCrG9P0QcKncaBxW1Spj07jeZKRy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="337261682"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="xz'341?scan'341,208,341";a="337261682"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 18:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745281390"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="xz'341?scan'341,208,341";a="745281390"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2023 18:17:05 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 18:17:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 18:17:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 18:17:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 18:17:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8DAx2UodUfpR/F/83yY1kxGH/6+1IGj5VQfKIBSLN7s9PW6xpOypcVGCmqkDBM02vaFhgLAr3n2lHw+5DLeuDkiudhBiFZcBDdAGZ8wNzjc2llSOJV5qT9mwQjPcI3REsUYI9x08G01Rq5cGnFPAn+/0TAKjOG4R6WQB60J5wgQcMlHMYesmcIaY4EmgEZJxVZcri+yPDRQ/6brXhAo5oF255wkU6Wwpq5yhZBLEtDZYsQQgzYsRtwKzfQdKAqKx2VawD6RGigOlZxPV1QGcDKRXIZpGzQ2onQB1DbeX3opR8xQlu39ZmTamxu1A3IlQ5zvjyF/oklya+ApA4CCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADpLgTzuzme0fLddg6K5yuHnGDi5N/vaqgSFi9njxaA=;
 b=PBim3+D4LuuXd4Tpkc2TG6N4kjH7ePdSgL96MdSelFIHUCabO7wjBmkD1SFp4Ev7llofL6PfhuCflybmHd9mF58offPATWJcpKhy75yGntWfVSjHdDCH/RJ7KNvKyckehgW+RoKAiqv8uczO39w747N6EaWTOrdZTHyds4Uxdt/YCsa1vreT8jPxwWRA4A5HheopW06N3pnFwRTnz72wnZp4cdg0CN1T6Hj85b8t8rxGM7i3/hAuBi5YiDMGJ4j+QRNuE9CzuAiC3RY+v3rr95HuLte2jQPegGsNTayv0qjk5ygGRwcztdJkwDOU94HZfJnMjzewz6DVM7KPsRKkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 02:16:59 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4%8]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 02:16:59 +0000
Date:   Tue, 7 Mar 2023 10:16:47 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <rkagan@amazon.de>, <zhangqiao22@huawei.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Message-ID: <202303070945.c7b65897-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="HVDkdhahCmMikrVf"
Content-Disposition: inline
In-Reply-To: <20230306132418.50389-1-zhangqiao22@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0102.apcprd02.prod.outlook.com
 (2603:1096:4:92::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 87491847-ed98-4756-fe7d-08db1eb207b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jp4j8ZH2PEB40Zo7s2WpD8g26lyc+dpn4bOQ3udWVW6JMOlR2iiXAW3lsA51J88KDDC+S4RjEKUB4MWzPcwA5iUDeKoitoUB6Nplwckcr1U1MpkPg1et/nMFWq34LourMQAN4rFXWUHgaGaisEOA7KTWqn6sPwyRSBc+qAKEksngUFKTE22PsNbBIXED9RpWIkTb2N10UWwekCvzpuHsKoeGxEUqPS3qhGnnmMYgFgGQl9aQhsNxqS84q1b3Ewhoejqinq7fluxLytgaU9MeeQr1L1J9MRToahnwUJUUcZut3Jxi84RuILYKe8vNJqx0YPfhGVCV5Eg/qesIxdxkXomxn3HcJFbIWb7gw56XD4Ut4847KmVGgThp8RgyxG4pKkCSWOcanQe3txNYdmaoBb4OWO6YsfFSCgvwYNvamqdxrgKXm+STojTSd3sHQP+oMqv50PhyV+Zp5LS95CD8mTbsd8EPoVS+Mai+sSHnrKxH9MpPB8ivMEDTrRt2KPHKLgnKYY6QHgtUKnpw0mZkUYXx7lxT8OPatgXMj+fx71QmW05xYDW34rzJuvyc5Z8iqIw7v8k2z3Nv6VisjAWQqSkb+bFd9HzkmBDhXTfDNVY9mwRdj14A/qPomf3i1204z9XhYkl+VaYohOWmLjCsOvVKJoiVl3InF/uMKz4OD1kH0RnKxreXqxZwVoMTa2QX9921YKSS8qUJJtq+wJ4k+G/ZVCh0Ll8P3a1eOqDXnX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199018)(36756003)(6486002)(6512007)(6506007)(966005)(26005)(1076003)(2616005)(186003)(6666004)(44144004)(316002)(41300700001)(66946007)(66476007)(4326008)(66556008)(8676002)(30864003)(45080400002)(6916009)(8936002)(478600001)(5660300002)(2906002)(7416002)(82960400001)(235185007)(86362001)(38100700002)(83380400001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6gzkHiE1qX8wvROJ3t1KqpeAI6rMtYNA4seZdYMdzIshsh1vvnpgvjZ5qGB9?=
 =?us-ascii?Q?EmAp+2Z3gOs7/YxqgN20HaVSaI6Q8CDpYca0HSspNCPf1X97S3pghvPsejh6?=
 =?us-ascii?Q?rUA8u88nLjDEdHe+dzw+WtCBWEhZRIJKB1SGKdK5TZHe6iR8toFVh7Vcmlb5?=
 =?us-ascii?Q?hzLpdeE8RtMRj8ALYtajG8W1d/B1bxWAqFl0SommcZjNSYKq8GhyWSM7cydX?=
 =?us-ascii?Q?QMVBUvi97Gqbc2XApV0R2AhIDAlgB7CU8oio6wjUhhEiB5I4Emb1ZhCKNN9k?=
 =?us-ascii?Q?mSVTYn9lz0X5PFPgt3qGjTkZXNEmolpN2/qR5pDhIXauAs8UVX1BzvEuOVy8?=
 =?us-ascii?Q?Se5BXBA4heXfHl7Wc2928mKdcvxosAVzybf5e8C+AUdV7KS/vBbnAlLUY1Bn?=
 =?us-ascii?Q?t1psM38t+114BFFsBtoyBs6P+pK3/jORGQObMtNs2lfzj+VsUP4cLOnMKOzD?=
 =?us-ascii?Q?klAQOudTkk15uP4KyAW1JjhP6ved7E5Lrdb+8lAMW8TZEdq+5InYZbU4hAir?=
 =?us-ascii?Q?xzNYFmrhnSXO9Ovqf0rNVn63/5xDHSKRI3dGqKhn8Glv6o8TkYo9qflawtfe?=
 =?us-ascii?Q?3bM1VBzSypeXVvGXrWgPG9FYL+DBWlKU6sHU/oQZpNNoamgRAiiLl71qnzSN?=
 =?us-ascii?Q?6S0MOR8LjeaYz41xgkwqVFVZDh3TrFODp+QWDrCwi+biJVmuT6cPCzHsf8Kb?=
 =?us-ascii?Q?81fbth2mKwUeKqcAtBhYquciLLbbsZPfrny11t83b+Q+C/PWOq2+d2TFCv7g?=
 =?us-ascii?Q?VEMbTPFRlTUKPTZZhV52yvF90zyM+LBM78EN5ZptHfF5ZXhRmyHv+xR3IHCD?=
 =?us-ascii?Q?moblyhFlvgszKLtyJtKb2NwKs8g0HaS+K23uWOhac5mu2wIloUy0FEbZpkOU?=
 =?us-ascii?Q?kqwXO8uyI03JxoUFTqnxoqOATfwiGieLOpoFXb2xueabmPPR+6VrA3fgtsx2?=
 =?us-ascii?Q?rV8zX0rYYFjDXGTohuzersxXrVVDN/2fx2ZFCPsCvc0aSBoii0GETIp4t7G3?=
 =?us-ascii?Q?kufUQXDHo8zp+Bf3XnrmghXrCh9HQwgbjVpq7HpssGhZ259Ry8x4VTvPDLXJ?=
 =?us-ascii?Q?nN425jbLit1Htz+3FbwDAdwyeSLg7xadRoF7jiXhhaGjETK5vKPwjXd2wHYg?=
 =?us-ascii?Q?trI8BiLdK0br2h3SbzX4D0jZCeddrw97f4DUsQVzccgsdJcd0sNhFqFYkqx2?=
 =?us-ascii?Q?96tXxOctcxSjsK4prWUhWvubMFWECVL5xmlKOEmBOB9QBBcVU9CCMGxNoYnx?=
 =?us-ascii?Q?4JIyBY3/pLL+pghUjlyLo4KWuSsUi9sbXJJyLGKmgPm6gh1zStBZ8Mgih/Q/?=
 =?us-ascii?Q?m21mZJgShHxU7LATdRUxQwydDf2Rq2FBpvW9cDhUnOo6leypnbMS8dHYlh4m?=
 =?us-ascii?Q?iJHExgi8MPkCkAUEEWlpXGK4ArH5QqgCZs7bqgU4sokS592XYc6XJNLPdVPk?=
 =?us-ascii?Q?l4HelN87/VXw10YcL+93HNTV0LfJogTNe1vn20v02k/uWpZ/ukd+3VFHV3bH?=
 =?us-ascii?Q?OF00VN5ARaYSAwDVFEIs9t3daD5rveYmInpy3x51T/hToSRuAw2HThcqe1HS?=
 =?us-ascii?Q?GBgXBpbJLAAL4uaVkNrPhhryPv8egzgb0CsHfbWt55Ys4f8esjysMypNLggd?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87491847-ed98-4756-fe7d-08db1eb207b2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 02:16:59.2873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+D04fMRl84+KezGnRnhm1Z4NZ3Uym2RDSW+ZUVnJE47HE5Og3E0OEfrS1UTg0WU9jLtYmqPy8lr6Q/+1NdSOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5862
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--HVDkdhahCmMikrVf
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed WARNING:at_kernel/sched/sched.h:#assert_clock_updated due to commit (built with gcc-11):

commit: 77900e3a6934d2a2e33f26775447e1dceeb1c503 ("[PATCH v2] sched/fair: sanitize vruntime of entity being migrated")
url: https://github.com/intel-lab-lkp/linux/commits/Zhang-Qiao/sched-fair-sanitize-vruntime-of-entity-being-migrated/20230306-205822
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 7c4a5b89a0b5a57a64b601775b296abf77a9fe97
patch link: https://lore.kernel.org/all/20230306132418.50389-1-zhangqiao22@huawei.com/
patch subject: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202303070945.c7b65897-oliver.sang@intel.com


[    0.702980][    T1] ------------[ cut here ]------------
[    0.704539][    T1] rq->clock_update_flags < RQCF_ACT_SKIP
[ 0.704551][ T1] WARNING: CPU: 0 PID: 1 at kernel/sched/sched.h:1496 assert_clock_updated+0x21/0x24 
[    0.706944][    T1] Modules linked in:
[    0.706944][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc6-00112-g77900e3a6934 #11
[    0.706944][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[ 0.706944][ T1] RIP: assert_clock_updated+0x21/0x24 
[ 0.706944][ T1] Code: 01 85 c0 7e 03 ff 47 60 c3 83 ff 01 77 1e 80 3d 1a 1c 89 01 00 75 15 48 c7 c7 ce fd 22 82 c6 05 0a 1c 89 01 01 e8 27 ea fc ff <0f> 0b c3 0f 1f 44 00 00 41 55 41 54 49 89 fc 55 53 48 8b af 30 01
All code
========
   0:	01 85 c0 7e 03 ff    	add    %eax,-0xfc8140(%rbp)
   6:	47 60                	rex.RXB (bad) 
   8:	c3                   	retq   
   9:	83 ff 01             	cmp    $0x1,%edi
   c:	77 1e                	ja     0x2c
   e:	80 3d 1a 1c 89 01 00 	cmpb   $0x0,0x1891c1a(%rip)        # 0x1891c2f
  15:	75 15                	jne    0x2c
  17:	48 c7 c7 ce fd 22 82 	mov    $0xffffffff8222fdce,%rdi
  1e:	c6 05 0a 1c 89 01 01 	movb   $0x1,0x1891c0a(%rip)        # 0x1891c2f
  25:	e8 27 ea fc ff       	callq  0xfffffffffffcea51
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	c3                   	retq   
  2d:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  32:	41 55                	push   %r13
  34:	41 54                	push   %r12
  36:	49 89 fc             	mov    %rdi,%r12
  39:	55                   	push   %rbp
  3a:	53                   	push   %rbx
  3b:	48                   	rex.W
  3c:	8b                   	.byte 0x8b
  3d:	af                   	scas   %es:(%rdi),%eax
  3e:	30 01                	xor    %al,(%rcx)

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	c3                   	retq   
   3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   8:	41 55                	push   %r13
   a:	41 54                	push   %r12
   c:	49 89 fc             	mov    %rdi,%r12
   f:	55                   	push   %rbp
  10:	53                   	push   %rbx
  11:	48                   	rex.W
  12:	8b                   	.byte 0x8b
  13:	af                   	scas   %es:(%rdi),%eax
  14:	30 01                	xor    %al,(%rcx)
[    0.706944][    T1] RSP: 0000:ffffc90000013d28 EFLAGS: 00010082
[    0.706944][    T1] RAX: 0000000000000000 RBX: ffff88810cba1fc0 RCX: 0000000000000003
[    0.706944][    T1] RDX: 0000000000000105 RSI: 0000000000000001 RDI: 0000000000000001
[    0.706944][    T1] RBP: ffff88842fc2c580 R08: 0000000000000000 R09: 0000000000000026
[    0.706944][    T1] R10: 0000000000000000 R11: 000000002d2d2d2d R12: ffff88842fc2c600
[    0.706944][    T1] R13: 0000000000000001 R14: 0000000000000001 R15: ffff88810cba1f40
[    0.706944][    T1] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[    0.706944][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.706944][    T1] CR2: ffff88843ffff000 CR3: 0000000002412000 CR4: 00000000000406f0
[    0.706944][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.706944][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.706944][    T1] Call Trace:
[    0.706944][    T1]  <TASK>
[ 0.706944][ T1] entity_is_long_sleep+0x1b/0x38 
[ 0.706944][ T1] migrate_task_rq_fair (fair.c:?) 
[ 0.706944][ T1] set_task_cpu (??:?) 
[ 0.706944][ T1] try_to_wake_up (core.c:?) 
[ 0.706944][ T1] ? __kthread_bind_mask (kthread.c:?) 
[ 0.706944][ T1] bringup_cpu (cpu.c:?) 
[ 0.706944][ T1] ? cpu_smt_allowed (cpu.c:?) 
[ 0.706944][ T1] cpuhp_invoke_callback (cpu.c:?) 
[ 0.706944][ T1] __cpuhp_invoke_callback_range (cpu.c:?) 
[ 0.706944][ T1] _cpu_up (cpu.c:?) 
[ 0.706944][ T1] cpu_up (cpu.c:?) 
[ 0.706944][ T1] bringup_nonboot_cpus (??:?) 
[ 0.706944][ T1] smp_init (??:?) 
[ 0.706944][ T1] kernel_init_freeable (main.c:?) 
[ 0.706944][ T1] ? rest_init (main.c:?) 
[ 0.706944][ T1] kernel_init (main.c:?) 
[ 0.706944][ T1] ret_from_fork (??:?) 
[    0.706944][    T1]  </TASK>
[    0.706944][    T1] ---[ end trace 0000000000000000 ]---
[    0.707026][    T1] smp: Brought up 1 node, 2 CPUs
[    0.707887][    T1] smpboot: Max logical packages: 1
[    0.708793][    T1] smpboot: Total of 2 processors activated (8779.66 BogoMIPS)
[    0.711760][    T1] devtmpfs: initialized
[    0.711827][    T1] x86/mm: Memory block size: 128MB
[ 0.716871][ T1] calling ipc_ns_init+0x0/0x18 @ 1 
[ 0.717857][ T1] initcall ipc_ns_init+0x0/0x18 returned 0 after 0 usecs 
[ 0.718963][ T1] calling init_mmap_min_addr+0x0/0x1a @ 1 
[ 0.719972][ T1] initcall init_mmap_min_addr+0x0/0x1a returned 0 after 0 usecs 
[ 0.721432][ T1] calling pci_realloc_setup_params+0x0/0x49 @ 1 
[ 0.722492][ T1] initcall pci_realloc_setup_params+0x0/0x49 returned 0 after 0 usecs 
[ 0.723421][ T1] calling inet_frag_wq_init+0x0/0x41 @ 1 
[ 0.726984][ T1] initcall inet_frag_wq_init+0x0/0x41 returned 0 after 4000 usecs 
[ 0.728809][ T1] calling e820__register_nvs_regions+0x0/0x3c @ 1 
[ 0.729914][ T1] initcall e820__register_nvs_regions+0x0/0x3c returned 0 after 0 usecs 
[ 0.730959][ T1] calling cpufreq_register_tsc_scaling+0x0/0x2e @ 1 
[ 0.732104][ T1] initcall cpufreq_register_tsc_scaling+0x0/0x2e returned 0 after 0 usecs 
[ 0.733576][ T1] calling cache_ap_register+0x0/0x2c @ 1 
[ 0.734609][ T1] initcall cache_ap_register+0x0/0x2c returned 0 after 0 usecs 
[ 0.735412][ T1] calling reboot_init+0x0/0x41 @ 1 
[ 0.736372][ T1] initcall reboot_init+0x0/0x41 returned 0 after 0 usecs 
[ 0.737551][ T1] calling init_lapic_sysfs+0x0/0x25 @ 1 
[ 0.738527][ T1] initcall init_lapic_sysfs+0x0/0x25 returned 0 after 0 usecs 
[ 0.739387][ T1] calling alloc_frozen_cpus+0x0/0xc @ 1 
[ 0.740351][ T1] initcall alloc_frozen_cpus+0x0/0xc returned 0 after 0 usecs 
[ 0.743426][ T1] calling cpu_hotplug_pm_sync_init+0x0/0x18 @ 1 
[ 0.744547][ T1] initcall cpu_hotplug_pm_sync_init+0x0/0x18 returned 0 after 0 usecs 
[ 0.745965][ T1] calling wq_sysfs_init+0x0/0x2f @ 1 
[ 0.746922][ T1] initcall wq_sysfs_init+0x0/0x2f returned 0 after 0 usecs 
[ 0.747307][ T1] calling ksysfs_init+0x0/0x9d @ 1 
[ 0.748263][ T1] initcall ksysfs_init+0x0/0x9d returned 0 after 0 usecs 
[ 0.749522][ T1] calling schedutil_gov_init+0x0/0x15 @ 1 
[ 0.750537][ T1] initcall schedutil_gov_init+0x0/0x15 returned 0 after 0 usecs 
[ 0.751416][ T1] calling pm_init+0x0/0x77 @ 1 
[ 0.752336][ T1] initcall pm_init+0x0/0x77 returned 0 after 0 usecs 
[ 0.753480][ T1] calling pm_disk_init+0x0/0x1c @ 1 
[ 0.754434][ T1] initcall pm_disk_init+0x0/0x1c returned 0 after 0 usecs 
[ 0.755378][ T1] calling swsusp_header_init+0x0/0x30 @ 1 
[ 0.756414][ T1] initcall swsusp_header_init+0x0/0x30 returned 0 after 0 usecs 
[ 0.757816][ T1] calling rcu_set_runtime_mode+0x0/0x1b @ 1 
[ 0.758858][ T1] initcall rcu_set_runtime_mode+0x0/0x1b returned 0 after 0 usecs 
[ 0.759395][ T1] calling init_jiffies_clocksource+0x0/0x1c @ 1 
[    0.760446][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[ 0.762235][ T1] initcall init_jiffies_clocksource+0x0/0x1c returned 0 after 0 usecs 
[ 0.763415][ T1] calling futex_init+0x0/0xcf @ 1 
[    0.764361][    T1] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[ 0.765718][ T1] initcall futex_init+0x0/0xcf returned 0 after 0 usecs 
[ 0.766890][ T1] calling cgroup_wq_init+0x0/0x2d @ 1 
[ 0.767275][ T1] initcall cgroup_wq_init+0x0/0x2d returned 0 after 0 usecs 
[ 0.768502][ T1] calling cgroup1_wq_init+0x0/0x2d @ 1 
[ 0.769581][ T1] initcall cgroup1_wq_init+0x0/0x2d returned 0 after 0 usecs 
[ 0.770943][ T1] calling ftrace_mod_cmd_init+0x0/0x10 @ 1 
[ 0.772006][ T1] initcall ftrace_mod_cmd_init+0x0/0x10 returned 0 after 0 usecs 
[ 0.773409][ T1] calling init_graph_trace+0x0/0x61 @ 1 
[ 0.774336][ T1] initcall init_graph_trace+0x0/0x61 returned 0 after 0 usecs 
[ 0.778960][ T1] calling trace_events_eprobe_init_early+0x0/0x2b @ 1 
[ 0.780166][ T1] initcall trace_events_eprobe_init_early+0x0/0x2b returned 0 after 0 usecs 
[ 0.781739][ T1] calling trace_events_synth_init_early+0x0/0x2b @ 1 
[ 0.782877][ T1] initcall trace_events_synth_init_early+0x0/0x2b returned 0 after 0 usecs 
[ 0.783421][ T1] calling init_kprobe_trace_early+0x0/0x2a @ 1 
[ 0.784494][ T1] initcall init_kprobe_trace_early+0x0/0x2a returned 0 after 0 usecs 
[ 0.785931][ T1] calling memory_failure_init+0x0/0x9a @ 1 
[ 0.786956][ T1] initcall memory_failure_init+0x0/0x9a returned 0 after 0 usecs 
[ 0.788354][ T1] calling cma_init_reserved_areas+0x0/0x2f @ 1 
[ 0.790834][ T1] initcall cma_init_reserved_areas+0x0/0x2f returned 0 after 0 usecs 
[ 0.791422][ T1] calling fsnotify_init+0x0/0x4d @ 1 
[ 0.792399][ T1] initcall fsnotify_init+0x0/0x4d returned 0 after 0 usecs 
[ 0.793578][ T1] calling filelock_init+0x0/0xa4 @ 1 
[ 0.794580][ T1] initcall filelock_init+0x0/0xa4 returned 0 after 0 usecs 
[ 0.795312][ T1] calling init_script_binfmt+0x0/0x1a @ 1 
[ 0.796310][ T1] initcall init_script_binfmt+0x0/0x1a returned 0 after 0 usecs 
[ 0.797654][ T1] calling init_elf_binfmt+0x0/0x1a @ 1 
[ 0.798613][ T1] initcall init_elf_binfmt+0x0/0x1a returned 0 after 0 usecs 
[ 0.799388][ T1] calling init_compat_elf_binfmt+0x0/0x1a @ 1 
[ 0.800453][ T1] initcall init_compat_elf_binfmt+0x0/0x1a returned 0 after 0 usecs 


To reproduce:

        # build kernel
	cd linux
	cp config-6.2.0-rc6-00112-g77900e3a6934 .config
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



--HVDkdhahCmMikrVf
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.2.0-rc6-00112-g77900e3a6934"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.2.0-rc6 Kernel Configuration
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
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
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
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
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
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
# CONFIG_PROFILING is not set
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
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
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
# CONFIG_X86_UV is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
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
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=512
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# end of Performance monitoring

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
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
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
CONFIG_SUSPEND_SKIP_SYNC=y
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
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
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
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
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
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
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
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
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
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
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
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
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
# CONFIG_GCC_PLUGINS is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
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
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_WBT is not set
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
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
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
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SWAP=y
# CONFIG_ZSWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB_DEPRECATED is not set
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
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
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_VMAP_PFN=y
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
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=m
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
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
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
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
# CONFIG_MCTP is not set
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
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
# CONFIG_FAILOVER is not set
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
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
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
# CONFIG_VMD is not set
# CONFIG_PCI_HYPERV_INTERFACE is not set

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
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
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
CONFIG_REGMAP_MMIO=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=m

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
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
# CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set
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
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
# CONFIG_CDROM_PKTCDVD is not set
CONFIG_ATA_OVER_ETH=y
# CONFIG_BLK_DEV_RBD is not set
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
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# CONFIG_PVPANIC is not set
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
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
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
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=y
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
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

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
CONFIG_PATA_SIS=m
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
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
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
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
# CONFIG_DM_ERA is not set
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
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_AUDIT is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=y
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=y
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
CONFIG_B44=y
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=y
CONFIG_CNIC=y
# CONFIG_TIGON3 is not set
CONFIG_BNX2X=y
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=y
# CONFIG_CHELSIO_T1_1G is not set
CONFIG_CHELSIO_T3=y
CONFIG_CHELSIO_T4=y
# CONFIG_CHELSIO_T4VF is not set
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
CONFIG_SUNDANCE=y
CONFIG_SUNDANCE_MMIO=y
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=y
# CONFIG_BE2NET_HWMON is not set
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=y
# CONFIG_E1000E_HWTS is not set
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=y
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_JME=y
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
CONFIG_KS8851_MLL=y
CONFIG_KSZ884X_PCI=y
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=y
CONFIG_NS83820=y
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=y
# CONFIG_NET_VENDOR_NETRONOME is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=y
CONFIG_QLCNIC=y
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=y
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=y
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=y
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
CONFIG_SIS190=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=y
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=y
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=y
# CONFIG_STMMAC_SELFTESTS is not set
CONFIG_STMMAC_PLATFORM=y
# CONFIG_DWMAC_GENERIC is not set
CONFIG_DWMAC_INTEL=y
# CONFIG_DWMAC_LOONGSON is not set
# CONFIG_STMMAC_PCI is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NIU=y
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=y
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=y
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
CONFIG_BROADCOM_PHY=y
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
CONFIG_CICADA_PHY=y
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_LXT_PHY=y
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
CONFIG_MICREL_PHY=y
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
# CONFIG_CAN_SLCAN is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

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
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
CONFIG_PCS_XPCS=y
# end of PCS device drivers

CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=y
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOE=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_SLIP=y
CONFIG_SLHC=y
# CONFIG_SLIP_COMPRESSED is not set
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
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
CONFIG_USB_NET_CDCETHER=m
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
CONFIG_USB_NET_RNDIS_HOST=m
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
CONFIG_USB_NET_CX82310_ETH=y
CONFIG_USB_NET_KALMIA=y
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_USB_RTL8153_ECM=m
CONFIG_WLAN=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
# CONFIG_WLAN_VENDOR_ATH is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
# CONFIG_WLAN_VENDOR_BROADCOM is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
# CONFIG_WLAN_VENDOR_INTEL is not set
# CONFIG_WLAN_VENDOR_INTERSIL is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
# CONFIG_WLAN_VENDOR_RALINK is not set
# CONFIG_WLAN_VENDOR_REALTEK is not set
# CONFIG_WLAN_VENDOR_RSI is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
CONFIG_USB_NET_RNDIS_WLAN=m
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
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
# CONFIG_INPUT_FF_MEMLESS is not set
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=y
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
# CONFIG_MOUSE_PS2_BYD is not set
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
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
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_HYPERV_KEYBOARD=y
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=16
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=y
# CONFIG_NULL_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
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
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y

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
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
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
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
# CONFIG_POWER_RESET is not set
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
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX127 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
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
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
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

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
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
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SYSCON=y
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
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set

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
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set

#
# ARM devices
#
# end of ARM devices

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
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

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
# CONFIG_FB_VESA is not set
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
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_HYPERV is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_CTL_FAST_LOOKUP=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
# CONFIG_SND_CTL_DEBUG is not set
# CONFIG_SND_JACK_INJECTION_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
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
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
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
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=y
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
# CONFIG_SND_HDA_CODEC_CS8409 is not set
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CA0110=y
CONFIG_SND_HDA_CODEC_CA0132=y
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_FT260 is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LETSKETCH is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_HYPERV_MOUSE is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_TOPRE is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
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
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
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
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
CONFIG_USB_STORAGE_CYPRESS_ATACB=y
CONFIG_USB_STORAGE_ENE_UB6250=y
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
# CONFIG_USB_SERIAL is not set

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

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_FAULT_INJECTION is not set
# CONFIG_SCSI_UFS_HWMON is not set
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
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
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXCPLD is not set
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
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="n"
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
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
# CONFIG_VFIO is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
# CONFIG_HYPERV_UTILS is not set
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
# CONFIG_P2SB is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

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
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

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

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
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

# CONFIG_POWERCAP is not set
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
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
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
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
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
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
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
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
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
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
# CONFIG_SQUASHFS_LZO is not set
# CONFIG_SQUASHFS_XZ is not set
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
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=y
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=y
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFS_V4_2_READ_PLUS=y
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
CONFIG_CIFS_DEBUG2=y
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_ROOT is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=y
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_INTEL_TXT is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
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
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
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
# CONFIG_CRYPTO_ARIA is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_TWOFISH is not set
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_CHACHA20 is not set
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set
CONFIG_CRYPTO_ESSIV=m
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
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_VMAC is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
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
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
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
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
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
# CONFIG_CORDIC is not set
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
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
# CONFIG_CRC64_ROCKSOFT is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BTREE=y
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
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
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
CONFIG_SBITMAP=y
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
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
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
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
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
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
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
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
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
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
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
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
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
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
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
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
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
# CONFIG_RING_BUFFER_BENCHMARK is not set
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
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
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
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
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
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
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
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--HVDkdhahCmMikrVf
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
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-review/Zhang-Qiao/sched-fair-sanitize-vruntime-of-entity-being-migrated/20230306-205822'
	export commit='77900e3a6934d2a2e33f26775447e1dceeb1c503'
	export kconfig='x86_64-kexec'
	export repeat_to=6
	export nr_vm=300
	export submit_id='64063a2b66ad4ec83bb971fa'
	export job_file='/lkp/jobs/scheduled/vm-meta-51/boot-1-debian-11.1-x86_64-20220510.cgz-77900e3a6934d2a2e33f26775447e1dceeb1c503-20230307-51259-1be80sy-3.yaml'
	export id='cb243be973c79163d5f9fda33f74b4e7c9d9c205'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export compiler='gcc-11'
	export enqueue_time='2023-03-07 03:08:27 +0800'
	export _id='64063a4266ad4ec83bb971fb'
	export _rt='/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-kexec/gcc-11/77900e3a6934d2a2e33f26775447e1dceeb1c503'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-kexec/gcc-11/77900e3a6934d2a2e33f26775447e1dceeb1c503/3'
	export scheduler_version='/lkp/lkp/.src-20230306-195820'
	export arch='x86_64'
	export max_uptime=600
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-kexec/gcc-11/77900e3a6934d2a2e33f26775447e1dceeb1c503/3
BOOT_IMAGE=/pkg/linux/x86_64-kexec/gcc-11/77900e3a6934d2a2e33f26775447e1dceeb1c503/vmlinuz-6.2.0-rc6-00112-g77900e3a6934
branch=linux-review/Zhang-Qiao/sched-fair-sanitize-vruntime-of-entity-being-migrated/20230306-205822
job=/lkp/jobs/scheduled/vm-meta-51/boot-1-debian-11.1-x86_64-20220510.cgz-77900e3a6934d2a2e33f26775447e1dceeb1c503-20230307-51259-1be80sy-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-kexec
commit=77900e3a6934d2a2e33f26775447e1dceeb1c503
initcall_debug
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
	export modules_initrd='/pkg/linux/x86_64-kexec/gcc-11/77900e3a6934d2a2e33f26775447e1dceeb1c503/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.WARNING:at_kernel/sched/sched.h:#assert_clock_updated'
	export kbuild_queue_analysis=1
	export meta_host='vm-meta-51'
	export kernel='/pkg/linux/x86_64-kexec/gcc-11/77900e3a6934d2a2e33f26775447e1dceeb1c503/vmlinuz-6.2.0-rc6-00112-g77900e3a6934'
	export dequeue_time='2023-03-07 03:11:22 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-51/boot-1-debian-11.1-x86_64-20220510.cgz-77900e3a6934d2a2e33f26775447e1dceeb1c503-20230307-51259-1be80sy-3.cgz'

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

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
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

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--HVDkdhahCmMikrVf
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--HVDkdhahCmMikrVf--
