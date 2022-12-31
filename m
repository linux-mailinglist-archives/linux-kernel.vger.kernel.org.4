Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2F965A585
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 16:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbiLaP0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 10:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiLaP0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:26:45 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEB02DE3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 07:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672500405; x=1704036405;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eQH9uva5qhvG6wxHp7tcehmFoVQN++jle7Sjtln06fs=;
  b=Tbes8sKSM9Uzw+bDe9BMdQ6thHlVAJpuCQe9k7wzpc7HfXqoA9rgj2e7
   5DpETr1FVcN7o+fjCCyZS5mHFOVYhKPzp1G8hATGbtVAnJZalGnSw5KJX
   eo2Wu1iNny4UUzxKxucz16JQqINcdKUVCwRsKn60tC1tLqpP2/pd9jdT0
   OYVXvZk7HANbaCooenuN5cAln5rHks7GrrsWzHH5mnnZw82tD0r9Knqgk
   280XynEWxMVPdO3+8844L83C5aL23Facr0JLa0s46NQojR4rj1dgHK1Hs
   REG0M6/KN3bFig/JLIca2rkX42KOlgwzZqh5Hz3/66NpLDS1Rgof3q9i5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="301001286"
X-IronPort-AV: E=Sophos;i="5.96,290,1665471600"; 
   d="xz'?scan'208";a="301001286"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2022 07:26:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="742794128"
X-IronPort-AV: E=Sophos;i="5.96,290,1665471600"; 
   d="xz'?scan'208";a="742794128"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Dec 2022 07:26:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 31 Dec 2022 07:26:41 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 31 Dec 2022 07:26:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 31 Dec 2022 07:26:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 31 Dec 2022 07:26:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msImGGMf2hmie6wPTxPO8MxeQZ1NcU8SQEjJG8P15iB+YXtBG6TeicBs4P++ulgLjI6zIVc8k7SJRSDztZL+KY+vNu4fN0TVOxHUCmnQm58Pl3k+3bG1g88dkEJSDL8Gc94BovuJDKlELW6pNNTTVNqDNpaDQmcdHfsDVorT3O6rQvfUuJ1kUrxwiPW3kZ6Jy3ZiMYO1pGGQRiUfjjBWLfACUqdYvHfmUhoFHH0Rxk/OLXUrf3X+IYGdM2VlxracSHro8GH3dxDFO561hKim25qfs2VyGCZWZfd0n4SdC6BH6JXzdHPPN5sX4Q1SQjphFEZ0rbSRQoXn2Kt0pgFfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoUSg84EiWiypxOC4XksJG+6jgOGOiOZumDWOnvQpy4=;
 b=mMK46a8gdFmjPKc9pSmDSVmF28IGixClKzYs6pT46W/O6cTnlGru4UdYDlGN6nluwrkYNrgwc3fM+jO5EEu8S9pvNaIv0JvNz0JgHG6qBGWhNGR4f1l6Qm2eUxag84NcTi6tRhtBRX7NejfoG2TdGSb+iG4cuono2rv/SA7TlSqkd3fmz/7mAjJ1nsKJQ5K71A2+6efiFVZDtGQF79YMoZI6uwWQ5LOkKmTrKirf5I2Fzxbq+1nAREmBkd1c17q7AYfu6Ha6TTJEzCdoomJlkSPGgwKn2mdq0lJnh/EJShvfOT4YlpH6aWTziwoGVVy37RETPd3gVrPYPsGK5OUPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ0PR11MB5647.namprd11.prod.outlook.com (2603:10b6:a03:3af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 15:26:36 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241%9]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 15:26:36 +0000
Date:   Sat, 31 Dec 2022 23:26:25 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [linus:master] [mm, slub]  0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <202212312021.bc1efe86-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="veVQscFeJEhLZOz5"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ0PR11MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 7596f707-0ac6-4c5d-737d-08daeb436718
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZlrzQrY8b8f5Xq2fM1G5fCc6ESyWOuykq2IrtXdHx0C8ZUnyJBbK0ZP5PpPRhxY/JbVc56tdM9GEI8W61Xolww6mUXj0IDWOos3agkhh2ikEi1bRYMwJm9UBdlpX9Mp3cnDD8HZ+MK3c626hN5iJyk4pppzyAW5BhaXt72ZaaZqh4bGb5tbJ5DqTHsaIt/qkbzVAD6W6TbPAGOYELJtnZuEzX1J0QmuRQ3D9vANuVZVMotY/KIu4WlKapt6LkNGZB+BtmgjJfyDUMXcKlZb4jHDPwFE5sxFYQ8rILaPyrWJ4jnfAVZadI/IUGKItBdTryBUYpmWpK+NDagZOe8PpZYO+t83mf9D41HtKwM25gtu/1yQRyJm5n8qD3c1fzVgaM4zk9ybk58x6PnNdTHkUyj+/HwXCsHKLiFUPxXm/VatJDndnstagaG8ehonV+8OZsj7LX2dVQhSfLfVapcKMlMaHQcnx3HX+mv0cSGqUPW76WbgDdFcJaLt1BUNo4Y5qygDo12rMqW10xBqSGwGrCT19Wot/eqQzP+sAjaPOIEjmT3g4wBNtPCqGvBGHfbNcyBTMC792x2D/drfWXpHQKA1sb8BqpfRT3enoPuqUATtpyqosa7X+l7HZ/LvdwvYwI4gEFpGZtZoHHGi6SawYndneio4JHh5AxIMyom4AihPoDKmTUbONzLyK6PWTikpW7qNbD9sa7BmuHOWgk92P6jyRiuA5n2F2M7gMs0ZR6IjGf9a9qLVlu+HQ5cnWtxEmpwcL2D/re3DZNkaaJTp1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(82960400001)(38100700002)(83380400001)(86362001)(4326008)(235185007)(5660300002)(66556008)(8676002)(66476007)(66946007)(2906002)(44144004)(186003)(6512007)(26005)(41300700001)(1076003)(8936002)(6666004)(54906003)(6916009)(316002)(2616005)(966005)(6486002)(478600001)(6506007)(36756003)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Em+yoUF+kwjr7+lT7iOA+7/1cPCBgm6HtP9B/il5XGNdFG6L22vgGev7r9si?=
 =?us-ascii?Q?FsUUk6KH4HDxRtwnJaD+dUchAXYdIF1PCLq7gtF3rpTzAcsjoxCiXZGip2hS?=
 =?us-ascii?Q?nPM6kkDmI7ztTrcTBlyDEaYe0bDHG9l8oKFhu06WsqxxKxB3PfDqOYL8pS2L?=
 =?us-ascii?Q?TwSnGg2oYVCWMJgzveTEqP2zzu/g6lnCEzM398D2qXxQA251BSl7NXF4Jx+Z?=
 =?us-ascii?Q?HvBlfvZ6Q8E5PJ+d0TEB1pqgL8zANf3w48hn0bqtauL1pQXiC/dZsPe4+PCa?=
 =?us-ascii?Q?TNlTDC0wy/iTK8gLoDn7llrXR2bR8mS6uMzlq0utyHTqcuiQGwOMJjCSuBiy?=
 =?us-ascii?Q?WjtSxgAFRZQQG4qHy38gVLVSNv2O+nRr4PR+V6pbyZI8FQGgq087FjwzmzOz?=
 =?us-ascii?Q?q3gDrVbZBbvZMV4x7UkCGi3oXzy0PLg0uR8lZxHX3WlDIDmkVP05lfTDR1tK?=
 =?us-ascii?Q?IeNRdd2DBgg4ECCdWTIVKKyt8tOsxGPBIYP1X9YBjwzZ5K24gFFuL6o4mZyL?=
 =?us-ascii?Q?5uliaQTfXEyUgCuV30tIrg6onpWUmXANW1PMpkqP0gaNx1PeHbQ/oX9uytKg?=
 =?us-ascii?Q?MadRZgSd4Z53ExMb8+WCIdIFDncs3wPu6FTPfgVTEKrPh6fIBJLQtcig6oYe?=
 =?us-ascii?Q?fYzcA0KicnyfDAOAgNQIGpYIWGp64kLKUgPueSOoZgFJ6f2OhVRv6wdgOVW6?=
 =?us-ascii?Q?mtA46FHRYuLTal+UluVTw10LGpB+7oytxNvtSzJHQVh/w8oXQWv7zpbX8haR?=
 =?us-ascii?Q?FoKo9A0BfLgptomgM59UKunfyxtHiZRwhbduU4R5p1NBpA8pwrOVS2h3JWrU?=
 =?us-ascii?Q?KeZ7YEobWAFxWk5v/3noAmlfylsEaDuHXDq8Ct9DjFYzFs/AXtAkno7YFuX4?=
 =?us-ascii?Q?bqbC5AfFvRjByFkYyT+5R2+h72NmPTsJuPtrxasN2g0RQQqs9d+wXqEAZ9MQ?=
 =?us-ascii?Q?3SIta2k3rJFCeRpf7BfIQrlj7arZiEirvNVhzpWTk63q4TtJGA2iOkE1nbQM?=
 =?us-ascii?Q?Kq0sg8BUokK3o8/a739L75uoF0hGKoe1rDmCvMC6LYcd9P3y4D6MDHWnSYTX?=
 =?us-ascii?Q?Er+1QGA/jjfjsWMKoaG8DNUFgW9k+CzEBowGRe6lom8wVhHPuUnF7rlZdTGP?=
 =?us-ascii?Q?Q04bNwyoKjw9oaKMK4RQd2+1yILRmip/TZgv74m2T4ZMUpUc+uE5tyoOmTdE?=
 =?us-ascii?Q?dffx8WliRh8SgvQ+gL7uVZOYus5O5qj5u8QpTV4dNs9rDRTXDiLwmcQMrDxF?=
 =?us-ascii?Q?b+opOwySDadOtI9d92u+U9rDCOYK9SSSs4B1NK4DFkVjngiDbZKz4I5VpGdu?=
 =?us-ascii?Q?cwLkpClG+WDWh4Nvr2Ox42J72zR5tp3RZ6c3jsqDq9t1nIcBeG0C1F8BKXH0?=
 =?us-ascii?Q?vI80zSba4b0khFmj11UViVMQ7FQZ3e5ZGzkZCOgbOag/7sSiwVB6UnmJ8YJJ?=
 =?us-ascii?Q?g/7IXNzteouIBUi1yVVk/6L1iM/qFyEGUgy50RECi2oHPHlo0tg30DdMio7Q?=
 =?us-ascii?Q?RFM2vJGHH1ETRQPU4l2lkGWoWIO6jKWXntpsnuxo+dikp5PBIKvU61TS/KEE?=
 =?us-ascii?Q?otHovKi9UzZTgqlvEVoYCX2e97i6omex+wo06AJ4h5nFJ0+4w/5DIrU2/jRB?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7596f707-0ac6-4c5d-737d-08daeb436718
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 15:26:35.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbOczrW9RdnxDjElyBGJMloejeF6zARDkwkRUz0df4drIcxiWuerv3UsxrMaWU7e2+guN7j1CnJ7yltk10YW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5647
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--veVQscFeJEhLZOz5
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed kernel_BUG_at_include/linux/mm.h due to commit (built with gcc-11):

commit: 0af8489b0216fa1dd83e264bef8063f2632633d7 ("mm, slub: remove percpu slabs with CONFIG_SLUB_TINY")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master c76083fac3bae1a87ae3d005b5cb1cbc761e31d5]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: tasks-tracing

test-description: rcutorture is rcutorture kernel module load/unload test.
test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202212312021.bc1efe86-oliver.sang@intel.com


[   25.804432][  T214] ------------[ cut here ]------------
[   25.804917][  T214] kernel BUG at include/linux/mm.h:825!
[   25.805402][  T214] invalid opcode: 0000 [#1] SMP
[   25.805820][  T214] CPU: 0 PID: 214 Comm: udevadm Tainted: G S                 6.1.0-rc2-00014-g0af8489b0216 #2 1c4d7707ec0ce574ed62a77e82a8580202758048
[ 25.806944][ T214] EIP: __dump_page.cold (include/linux/mm.h:825 mm/debug.c:97) 
[ 25.807376][ T214] Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
All code
========
   0:	ff                   	(bad)  
   1:	ff 83 05 e8 5d bb    	incl   -0x44a217fb(%rbx)
   7:	c5 01 ba             	(bad)  
   a:	4c c4                	rex.WR (bad) 
   c:	2f                   	(bad)  
   d:	c4                   	(bad)  
   e:	89 f8                	mov    %edi,%eax
  10:	83 15 ec 5d bb c5 00 	adcl   $0x0,-0x3a44a214(%rip)        # 0xffffffffc5bb5e03
  17:	e8 f2 92 ed fd       	callq  0xfffffffffded930e
  1c:	83 05 f8 5d bb c5 01 	addl   $0x1,-0x3a44a208(%rip)        # 0xffffffffc5bb5e1b
  23:	83 15 fc 5d bb c5 00 	adcl   $0x0,-0x3a44a204(%rip)        # 0xffffffffc5bb5e26
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	83 05 00 5e bb c5 01 	addl   $0x1,-0x3a44a200(%rip)        # 0xffffffffc5bb5e33
  33:	b8 ac 85 a3 c4       	mov    $0xc4a385ac,%eax
  38:	83 15 04 5e bb c5 00 	adcl   $0x0,-0x3a44a1fc(%rip)        # 0xffffffffc5bb5e43
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	83 05 00 5e bb c5 01 	addl   $0x1,-0x3a44a200(%rip)        # 0xffffffffc5bb5e09
   9:	b8 ac 85 a3 c4       	mov    $0xc4a385ac,%eax
   e:	83 15 04 5e bb c5 00 	adcl   $0x0,-0x3a44a1fc(%rip)        # 0xffffffffc5bb5e19
  15:	e8                   	.byte 0xe8
[   25.808960][  T214] EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
[   25.809578][  T214] ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
[   25.810168][  T214] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
[   25.810803][  T214] CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
[   25.811407][  T214] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   25.811999][  T214] DR6: fffe0ff0 DR7: 00000400
[   25.812390][  T214] Call Trace:
[ 25.812675][ T214] dump_page (mm/debug.c:131) 
[ 25.813025][ T214] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:162) 
[ 25.813492][ T214] folio_flags+0x23/0x70 
[ 25.813945][ T214] get_partial_node (include/linux/page-flags.h:483 mm/slab.h:140 mm/slub.c:2967 mm/slub.c:2225) 
[ 25.814357][ T214] __slab_alloc_node+0xbb/0x270 
[ 25.814860][ T214] kmem_cache_alloc_lru (mm/slub.c:3404 mm/slub.c:3418 mm/slub.c:3425 mm/slub.c:3441) 
[ 25.815289][ T214] ? __lock_release (kernel/locking/lockdep.c:355 kernel/locking/lockdep.c:5350) 
[ 25.815697][ T214] ? iget_locked (fs/inode.c:1275) 
[ 25.816096][ T214] alloc_inode (include/linux/fs.h:3117 fs/inode.c:261) 
[ 25.816469][ T214] iget_locked (fs/inode.c:1286) 
[ 25.816829][ T214] ? lock_is_held_type (kernel/locking/lockdep.c:5409 kernel/locking/lockdep.c:5711) 
[ 25.817264][ T214] kernfs_get_inode (fs/kernfs/inode.c:255) 
[ 25.817670][ T214] kernfs_iop_lookup (fs/kernfs/dir.c:1154) 
[ 25.818087][ T214] __lookup_slow (fs/namei.c:1685) 
[ 25.818479][ T214] lookup_slow (fs/namei.c:1702) 
[ 25.818847][ T214] walk_component (fs/namei.c:1993) 
[ 25.819244][ T214] path_lookupat (fs/namei.c:2450 fs/namei.c:2474) 
[ 25.819627][ T214] path_openat (fs/namei.c:3684 fs/namei.c:3706) 
[ 25.820007][ T214] do_filp_open (fs/namei.c:3740) 
[ 25.820409][ T214] do_sys_openat2 (fs/open.c:1311) 
[ 25.820807][ T214] do_sys_open (fs/open.c:1326) 
[ 25.821211][ T214] __ia32_sys_openat (fs/open.c:1337) 
[ 25.821622][ T214] __do_fast_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:178) 
[ 25.822057][ T214] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:50 (discriminator 19)) 
[ 25.822480][ T214] ? __fput (fs/file_table.c:59 fs/file_table.c:333) 
[ 25.822842][ T214] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4262 kernel/locking/lockdep.c:4321) 
[ 25.823346][ T214] ? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
[ 25.823823][ T214] ? __do_fast_syscall_32 (arch/x86/entry/common.c:183) 
[ 25.824259][ T214] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4262 kernel/locking/lockdep.c:4321) 
[ 25.824767][ T214] ? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
[ 25.825254][ T214] ? __do_fast_syscall_32 (arch/x86/entry/common.c:183) 
[ 25.825696][ T214] ? __do_fast_syscall_32 (arch/x86/entry/common.c:183) 
[ 25.826155][ T214] ? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
[ 25.826627][ T214] ? __do_fast_syscall_32 (arch/x86/entry/common.c:183) 
[ 25.827056][ T214] ? __do_fast_syscall_32 (arch/x86/entry/common.c:183) 
[ 25.827486][ T214] ? __do_fast_syscall_32 (arch/x86/entry/common.c:183) 
[ 25.827929][ T214] ? irqentry_exit_to_user_mode (kernel/entry/common.c:312) 
[ 25.828423][ T214] ? irqentry_exit (kernel/entry/common.c:445) 
[ 25.828812][ T214] do_fast_syscall_32 (arch/x86/entry/common.c:203) 
[ 25.829223][ T214] do_SYSENTER_32 (arch/x86/entry/common.c:247) 
[ 25.829589][ T214] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:867) 
[   25.830003][  T214] EIP: 0xb7f8c549
[ 25.830330][ T214] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
All code
========
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter 
  28:	cd 80                	int    $0x80
  2a:*	5d                   	pop    %rbp		<-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq   
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d 76 00             	lea    0x0(%rsi),%esi
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	8d                   	.byte 0x8d
  3f:	76                   	.byte 0x76

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	retq   
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d 76 00             	lea    0x0(%rsi),%esi
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	8d                   	.byte 0x8d
  15:	76                   	.byte 0x76


To reproduce:

        # build kernel
	cd linux
	cp config-6.1.0-rc2-00014-g0af8489b0216 .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
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



--veVQscFeJEhLZOz5
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc2-00014-g0af8489b0216"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.1.0-rc2 Kernel Configuration
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
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

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
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
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
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
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
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
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
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

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
CONFIG_ARCH_NR_GPIO=512
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_QUARK=y
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_32_NON_STANDARD=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_STA2X11=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
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
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
# CONFIG_CPU_SUP_UMC_32 is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
# CONFIG_SCHED_CLUSTER is not set
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_X86_16BIT is not set
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_HIGHPTE=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
# CONFIG_MTRR is not set
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_STRICT_SIGALTSTACK_SIZE=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
# CONFIG_SPECULATION_MITIGATIONS is not set
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set
# CONFIG_ENERGY_MODEL is not set
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
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
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
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=y
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_SCx200 is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
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
CONFIG_UPROBES=y
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
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
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
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
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
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
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
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

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
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
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
# CONFIG_SLOB is not set
CONFIG_SLUB_TINY=y
CONFIG_SLAB_MERGE_DEFAULT=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
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
# CONFIG_BOUNCE is not set
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y
CONFIG_ANON_VMA_NAME=y
# CONFIG_USERFAULTFD is not set
CONFIG_LRU_GEN=y
# CONFIG_LRU_GEN_ENABLED is not set
# CONFIG_LRU_GEN_STATS is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
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
# CONFIG_NETWORK_SECMARK is not set
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
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
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
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
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
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_VGA_ARB is not set
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y

#
# DesignWare PCI Core Support
#
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
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
CONFIG_I82092=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
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
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MOXTET is not set
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
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
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_ISCSI_IBFT is not set
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

# CONFIG_GNSS is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=y
# CONFIG_NFTL is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=y
CONFIG_MTD_SWAP=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
CONFIG_MTD_ESB2ROM=y
CONFIG_MTD_CK804XROM=y
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=y
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
CONFIG_MTD_PMC551_DEBUG=y
CONFIG_MTD_DATAFLASH=y
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_MCHP48L640=y
CONFIG_MTD_SST25L=y
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
CONFIG_MTD_SPI_NAND=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_MTD_HYPERBUS=y
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=y
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_COMMON=y
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
CONFIG_NVME_AUTH=y
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HI6421V600_IRQ is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_HISI_HIKEY_USB=y
CONFIG_OPEN_DICE=y
CONFIG_VCPU_STALL_DETECTOR=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
CONFIG_INTEL_MEI_TXE=y
# CONFIG_VMWARE_VMCI is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
CONFIG_HABANA_AI=y
CONFIG_UACCE=y
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=y
CONFIG_PVPANIC_PCI=y
CONFIG_GP_PCI1XXXX=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_HPSA=y
CONFIG_SCSI_3W_9XXX=y
CONFIG_SCSI_3W_SAS=y
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=y
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=y
CONFIG_SCSI_MVSAS_DEBUG=y
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_ARCMSR=y
CONFIG_SCSI_ESAS2R=y
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
CONFIG_MEGARAID_MAILBOX=y
CONFIG_MEGARAID_LEGACY=y
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
CONFIG_SCSI_MPI3MR=y
CONFIG_SCSI_SMARTPQI=y
CONFIG_SCSI_HPTIOP=y
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_SCSI_MYRB=y
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=y
CONFIG_SCSI_SNIC=y
CONFIG_SCSI_SNIC_DEBUG_FS=y
CONFIG_SCSI_DMX3191D=y
CONFIG_SCSI_FDOMAIN=y
CONFIG_SCSI_FDOMAIN_PCI=y
CONFIG_SCSI_ISCI=y
CONFIG_SCSI_IPS=y
CONFIG_SCSI_INITIO=y
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
CONFIG_SCSI_IMM=y
# CONFIG_SCSI_IZIP_EPP16 is not set
CONFIG_SCSI_IZIP_SLOW_CTR=y
CONFIG_SCSI_STEX=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_MMIO is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_SCSI_DC395x=y
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_NSP32=y
CONFIG_SCSI_WD719X=y
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=y
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_AHCI_DWC=y
CONFIG_AHCI_CEVA=y
# CONFIG_AHCI_QORIQ is not set
CONFIG_SATA_INIC162X=y
CONFIG_SATA_ACARD_AHCI=y
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=y
# CONFIG_FIREWIRE_NET is not set
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
# CONFIG_NET_FC is not set
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
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
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
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
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
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
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
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
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
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
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
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
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
# CONFIG_PCMCIA_RAYCS is not set
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
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
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
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ADS7846=y
CONFIG_TOUCHSCREEN_AD7877=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_AD7879_SPI=y
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMA140=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP_SPI=y
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DA9034 is not set
CONFIG_TOUCHSCREEN_DA9052=y
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=y
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=y
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_IMAGIS=y
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_WM831X=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
# CONFIG_TOUCHSCREEN_MC13783 is not set
# CONFIG_TOUCHSCREEN_USB_EGALAX is not set
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
# CONFIG_TOUCHSCREEN_USB_ITM is not set
# CONFIG_TOUCHSCREEN_USB_ETURBO is not set
# CONFIG_TOUCHSCREEN_USB_GUNZE is not set
# CONFIG_TOUCHSCREEN_USB_DMC_TSC10 is not set
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
# CONFIG_TOUCHSCREEN_USB_IDEALTEK is not set
# CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH is not set
# CONFIG_TOUCHSCREEN_USB_GOTOP is not set
CONFIG_TOUCHSCREEN_USB_JASTEC=y
# CONFIG_TOUCHSCREEN_USB_ELO is not set
# CONFIG_TOUCHSCREEN_USB_E2I is not set
# CONFIG_TOUCHSCREEN_USB_ZYTRONIC is not set
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2005=y
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_TOUCHSCREEN_ZINITIX=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=y
# CONFIG_RMI4_F03 is not set
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
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
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
CONFIG_GAMEPORT_FM801=y
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
# CONFIG_LDISC_AUTOLOAD is not set

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
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_CS=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
# CONFIG_SERIAL_8250_LPSS is not set
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_8250_PERICOM=y
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
CONFIG_SERIAL_LANTIQ=y
# CONFIG_SERIAL_LANTIQ_CONSOLE is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_SC16IS7XX_SPI=y
# CONFIG_SERIAL_TIMBERDALE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_PCH_UART=y
# CONFIG_SERIAL_PCH_UART_CONSOLE is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# CONFIG_SERIAL_LITEUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=y
CONFIG_SYNCLINK_GT=y
CONFIG_N_HDLC=y
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=y
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
CONFIG_RPMSG_TTY=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
# CONFIG_HW_RANDOM_GEODE is not set
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_CCTRNG is not set
CONFIG_HW_RANDOM_XIPHERA=y
CONFIG_APPLICOM=y
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

CONFIG_MWAVE=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS_CLASS=y
# CONFIG_XILLYBUS is not set
CONFIG_XILLYUSB=y
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
CONFIG_I2C_NVIDIA_GPU=y
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
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=y
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
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
CONFIG_I2C_PCI1XXXX=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_FSI=y
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
CONFIG_SVC_I3C_MASTER=y
CONFIG_MIPI_I3C_HCI=y
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_ALTERA_DFL=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CADENCE_QUADSPI is not set
# CONFIG_SPI_CADENCE_XSPI is not set
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_FSI=y
# CONFIG_SPI_NXP_FLEXSPI is not set
CONFIG_SPI_GPIO=y
CONFIG_SPI_INTEL=y
# CONFIG_SPI_INTEL_PCI is not set
CONFIG_SPI_INTEL_PLATFORM=y
# CONFIG_SPI_LM70_LLP is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_MICROCHIP_CORE=y
CONFIG_SPI_MICROCHIP_CORE_QSPI=y
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_MXIC=y
CONFIG_SPI_TOPCLIFF_PCH=y
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
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
# CONFIG_HSI_CHAR is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
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
# CONFIG_PINCTRL_AS3722 is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_PINCTRL_MAX77620=y
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_PALMAS=y
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_STMFX is not set
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
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
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SIOX is not set
# CONFIG_GPIO_STA2X11 is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=y
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
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
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TC3589X=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
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
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
CONFIG_IP5XXX_POWER=y
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_OLPC is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MT6360=y
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65217=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
# CONFIG_SENSORS_ADT7310 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AHT10=y
CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=y
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
CONFIG_I8K=y
CONFIG_SENSORS_DA9052_ADC=y
CONFIG_SENSORS_DA9055=y
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_GSC=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=y
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX31760=y
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT6775_I2C=y
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_NZXT_KRAKEN2=y
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1266=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_DPS920AB=y
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_IR36021=y
CONFIG_SENSORS_IR38064=y
# CONFIG_SENSORS_IR38064_REGULATOR is not set
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LT7182S=y
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_MP2888=y
CONFIG_SENSORS_MP2975=y
CONFIG_SENSORS_MP5023=y
CONFIG_SENSORS_PIM4328=y
CONFIG_SENSORS_PLI1209BC=y
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
CONFIG_SENSORS_PM6764TR=y
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_Q54SJ108A2=y
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_TPS546D24=y
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_XDPE152=y
CONFIG_SENSORS_XDPE122=y
# CONFIG_SENSORS_XDPE122_REGULATOR is not set
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_SY7636A=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC2305=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA238=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_CPU_THERMAL=y
# CONFIG_CPU_FREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
# CONFIG_MAX77620_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set
CONFIG_INTEL_QUARK_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
CONFIG_INTEL_TCC_COOLING=y
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_MADERA_SPI=y
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_GATEWORKS_GSC=y
CONFIG_MFD_MC13XXX=y
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_HI6421_SPMI=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_INTEL_SOC_PMIC_MRFLD is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=y
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6370=y
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_OCELOT=y
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_NTXEC is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_SY7636A=y
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RT5120 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_STA2X11=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STPMIC1=y
# CONFIG_MFD_STMFX is not set
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_QCOM_PM8008=y
# CONFIG_MFD_INTEL_M10_BMC is not set
CONFIG_MFD_RSMU_I2C=y
# CONFIG_MFD_RSMU_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=y
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_ATC260X=y
# CONFIG_REGULATOR_BCM590XX is not set
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_HI6421V600=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=y
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=y
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=y
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=y
CONFIG_REGULATOR_MT6360=y
CONFIG_REGULATOR_MT6370=y
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PF8X00=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_RT5190A=y
# CONFIG_REGULATOR_RT5759 is not set
CONFIG_REGULATOR_RT6160=y
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STPMIC1=y
CONFIG_REGULATOR_SY7636A=y
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=y
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=y
CONFIG_LIRC=y
CONFIG_RC_MAP=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_IMON_DECODER is not set
CONFIG_IR_JVC_DECODER=y
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=y
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_RCMM_DECODER=y
CONFIG_IR_SANYO_DECODER=y
CONFIG_IR_SHARP_DECODER=y
# CONFIG_IR_SONY_DECODER is not set
CONFIG_IR_XMP_DECODER=y
CONFIG_RC_DEVICES=y
# CONFIG_IR_ENE is not set
# CONFIG_IR_FINTEK is not set
CONFIG_IR_GPIO_CIR=y
CONFIG_IR_GPIO_TX=y
# CONFIG_IR_HIX5HD2 is not set
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=y
CONFIG_IR_IMON=y
CONFIG_IR_IMON_RAW=y
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_PWM_TX is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_SERIAL is not set
CONFIG_IR_SPI=y
CONFIG_IR_STREAMZAP=y
CONFIG_IR_TOY=y
CONFIG_IR_TTUSBIR=y
# CONFIG_IR_WINBOND_CIR is not set
CONFIG_RC_ATI_REMOTE=y
CONFIG_RC_LOOPBACK=y
# CONFIG_RC_XBOX_DVD is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
CONFIG_USB_PULSE8_CEC=y
CONFIG_USB_RAINSHADOW_CEC=y
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_DMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
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
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=y
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_RCAR_DW_HDMI=y
CONFIG_DRM_RCAR_USE_LVDS=y
# CONFIG_DRM_RCAR_MIPI_DSI is not set
CONFIG_DRM_QXL=y
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ABT_Y030XX067A is not set
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0=y
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
CONFIG_DRM_PANEL_DSI_CM=y
CONFIG_DRM_PANEL_LVDS=y
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set
CONFIG_DRM_PANEL_ELIDA_KD35T133=y
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_INNOLUX_EJ030NA=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_JDI_R63452 is not set
CONFIG_DRM_PANEL_KHADAS_TS050=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
CONFIG_DRM_PANEL_LG_LB035Q02=y
CONFIG_DRM_PANEL_LG_LG4573=y
CONFIG_DRM_PANEL_NEC_NL8048HL11=y
CONFIG_DRM_PANEL_NEWVISION_NV3052C=y
CONFIG_DRM_PANEL_NOVATEK_NT35510=y
CONFIG_DRM_PANEL_NOVATEK_NT35560=y
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
CONFIG_DRM_PANEL_NOVATEK_NT39016=y
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=y
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
CONFIG_DRM_PANEL_SAMSUNG_DB7430=y
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
# CONFIG_DRM_PANEL_SAMSUNG_S6D27A1 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
CONFIG_DRM_PANEL_SHARP_LS060T1SX01=y
CONFIG_DRM_PANEL_SITRONIX_ST7701=y
CONFIG_DRM_PANEL_SITRONIX_ST7703=y
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
# CONFIG_DRM_PANEL_SONY_ACX565AKM is not set
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
CONFIG_DRM_PANEL_TDO_TL070WSH30=y
CONFIG_DRM_PANEL_TPO_TD028TTEC1=y
CONFIG_DRM_PANEL_TPO_TD043MTEA1=y
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
CONFIG_DRM_PANEL_WIDECHIPS_WS2401=y
CONFIG_DRM_PANEL_XINPENG_XPP055C272=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=y
CONFIG_DRM_CHIPONE_ICN6211=y
CONFIG_DRM_CHRONTEL_CH7033=y
CONFIG_DRM_DISPLAY_CONNECTOR=y
# CONFIG_DRM_ITE_IT6505 is not set
CONFIG_DRM_LONTIUM_LT8912B=y
CONFIG_DRM_LONTIUM_LT9211=y
CONFIG_DRM_LONTIUM_LT9611=y
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
CONFIG_DRM_ITE_IT66121=y
CONFIG_DRM_LVDS_CODEC=y
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NWL_MIPI_DSI=y
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_PARADE_PS8640=y
CONFIG_DRM_SIL_SII8620=y
# CONFIG_DRM_SII902X is not set
CONFIG_DRM_SII9234=y
CONFIG_DRM_SIMPLE_BRIDGE=y
CONFIG_DRM_THINE_THC63LVD1024=y
CONFIG_DRM_TOSHIBA_TC358762=y
# CONFIG_DRM_TOSHIBA_TC358764 is not set
# CONFIG_DRM_TOSHIBA_TC358767 is not set
# CONFIG_DRM_TOSHIBA_TC358768 is not set
# CONFIG_DRM_TOSHIBA_TC358775 is not set
CONFIG_DRM_TI_DLPC3433=y
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_TI_SN65DSI83=y
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=y
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_ANALOGIX_ANX7625=y
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7511_CEC is not set
CONFIG_DRM_CDNS_MHDP8546=y
CONFIG_DRM_DW_HDMI=y
# CONFIG_DRM_DW_HDMI_CEC is not set
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
# CONFIG_DRM_LOGICVC is not set
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
# CONFIG_DRM_IMX_LCDIF is not set
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_BOCHS=y
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_GM12U320=y
CONFIG_DRM_PANEL_MIPI_DBI=y
CONFIG_DRM_SIMPLEDRM=y
# CONFIG_TINYDRM_HX8357D is not set
CONFIG_TINYDRM_ILI9163=y
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
CONFIG_TINYDRM_ILI9486=y
CONFIG_TINYDRM_MI0283QT=y
CONFIG_TINYDRM_REPAPER=y
# CONFIG_TINYDRM_ST7586 is not set
CONFIG_TINYDRM_ST7735R=y
CONFIG_DRM_VBOXVIDEO=y
CONFIG_DRM_GUD=y
CONFIG_DRM_SSD130X=y
# CONFIG_DRM_SSD130X_I2C is not set
# CONFIG_DRM_SSD130X_SPI is not set
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_R128 is not set
CONFIG_DRM_MGA=y
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
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
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=y
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=y
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=y
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
# CONFIG_LCD_VGG2432A4 is not set
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_MT6370 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_LP8788 is not set
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_BIGBEN_FF=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_COUGAR=y
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CREATIVE_SB0540=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELAN=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_FT260 is not set
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=y
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_VRC2=y
CONFIG_HID_XIAOMI=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=y
CONFIG_HID_LETSKETCH=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_MEGAWORLD_FF=y
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
CONFIG_HID_PICOLCD_LCD=y
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=y
CONFIG_PLAYSTATION_FF=y
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SEMITEK=y
# CONFIG_HID_SIGMAMICRO is not set
CONFIG_HID_SONY=y
# CONFIG_SONY_FF is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_TOPRE=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_U2FZERO=y
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set
CONFIG_I2C_HID_OF_ELAN=y
CONFIG_I2C_HID_OF_GOODIX=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_PCI is not set
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_SL811_CS=y
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=y
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=y
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_CDNSP_PCI is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y
# CONFIG_USB_MUSB_GADGET is not set
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_ULPI is not set
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
# CONFIG_USB_DWC3_OF_SIMPLE is not set
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PERIPHERAL=y
# CONFIG_USB_DWC2_DUAL_ROLE is not set
CONFIG_USB_DWC2_PCI=y
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=y
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_SIMPLE=y
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
CONFIG_USB_SERIAL_BELKIN=y
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
CONFIG_USB_SERIAL_CP210X=y
CONFIG_USB_SERIAL_CYPRESS_M8=y
CONFIG_USB_SERIAL_EMPEG=y
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=y
CONFIG_USB_SERIAL_IPAQ=y
CONFIG_USB_SERIAL_IR=y
CONFIG_USB_SERIAL_EDGEPORT=y
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
CONFIG_USB_SERIAL_F81232=y
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=y
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_IUU=y
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=y
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=y
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
CONFIG_USB_SERIAL_MXUPORT=y
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
CONFIG_USB_SERIAL_QCAUX=y
# CONFIG_USB_SERIAL_QUALCOMM is not set
CONFIG_USB_SERIAL_SPCP8X5=y
CONFIG_USB_SERIAL_SAFE=y
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=y
CONFIG_USB_SERIAL_SYMBOL=y
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=y
# CONFIG_USB_SERIAL_OPTION is not set
CONFIG_USB_SERIAL_OMNINET=y
CONFIG_USB_SERIAL_OPTICON=y
CONFIG_USB_SERIAL_XSENS_MT=y
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=y
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=y
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ONBOARD_HUB=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_VERBOSE=y
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
# CONFIG_U_SERIAL_CONSOLE is not set

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=y
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=y
CONFIG_USB_R8A66597=y
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=y
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_GADGET_XILINX is not set
CONFIG_USB_MAX3420_UDC=y
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_ACM=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_MASS_STORAGE=y
CONFIG_USB_F_HID=y
CONFIG_USB_F_PRINTER=y
# CONFIG_USB_CONFIGFS is not set

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=y
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=y
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_MASS_STORAGE is not set
CONFIG_USB_G_SERIAL=y
CONFIG_USB_G_PRINTER=y
# CONFIG_USB_CDC_COMPOSITE is not set
CONFIG_USB_G_ACM_MS=y
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=y
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
# CONFIG_MMC is not set
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CPCAP is not set
CONFIG_LEDS_CR0014114=y
CONFIG_LEDS_EL15203000=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_SPI_BYTE=y
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_TPS6105X=y
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=y
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_KTD2692=y
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_MAX77693=y
CONFIG_LEDS_MT6360=y
CONFIG_LEDS_RT4505=y
CONFIG_LEDS_RT8515=y
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set
# CONFIG_LEDS_QCOM_LPG is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set

#
# Simple LED drivers
#
CONFIG_LEDS_SIEMENS_SIMATIC_IPC=y
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

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

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=y
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_HT16K33=y
CONFIG_LCD2S=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=y
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
# CONFIG_VDPA is not set
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
CONFIG_COMEDI_SSV_DNP=y
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
CONFIG_COMEDI_PCL726=y
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
# CONFIG_COMEDI_PCL816 is not set
CONFIG_COMEDI_PCL818=y
CONFIG_COMEDI_PCM3724=y
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=y
CONFIG_COMEDI_AMPLC_PC263_ISA=y
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=y
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=y
CONFIG_COMEDI_DAS6402=y
CONFIG_COMEDI_DT2801=y
# CONFIG_COMEDI_DT2811 is not set
CONFIG_COMEDI_DT2814=y
# CONFIG_COMEDI_DT2815 is not set
# CONFIG_COMEDI_DT2817 is not set
CONFIG_COMEDI_DT282X=y
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=y
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=y
# CONFIG_COMEDI_II_PCI20KC is not set
# CONFIG_COMEDI_C6XDIGIO is not set
# CONFIG_COMEDI_MPC624 is not set
# CONFIG_COMEDI_ADQ12B is not set
# CONFIG_COMEDI_NI_AT_A2150 is not set
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=y
# CONFIG_COMEDI_NI_ATMIO16D is not set
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=y
CONFIG_COMEDI_MULTIQ3=y
CONFIG_COMEDI_S526=y
CONFIG_COMEDI_PCI_DRIVERS=y
# CONFIG_COMEDI_8255_PCI is not set
CONFIG_COMEDI_ADDI_WATCHDOG=y
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
CONFIG_COMEDI_ADDI_APCI_1500=y
CONFIG_COMEDI_ADDI_APCI_1516=y
CONFIG_COMEDI_ADDI_APCI_1564=y
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
# CONFIG_COMEDI_ADDI_APCI_2032 is not set
CONFIG_COMEDI_ADDI_APCI_2200=y
CONFIG_COMEDI_ADDI_APCI_3120=y
# CONFIG_COMEDI_ADDI_APCI_3501 is not set
CONFIG_COMEDI_ADDI_APCI_3XXX=y
CONFIG_COMEDI_ADL_PCI6208=y
# CONFIG_COMEDI_ADL_PCI7X3X is not set
CONFIG_COMEDI_ADL_PCI8164=y
CONFIG_COMEDI_ADL_PCI9111=y
CONFIG_COMEDI_ADL_PCI9118=y
CONFIG_COMEDI_ADV_PCI1710=y
# CONFIG_COMEDI_ADV_PCI1720 is not set
CONFIG_COMEDI_ADV_PCI1723=y
CONFIG_COMEDI_ADV_PCI1724=y
CONFIG_COMEDI_ADV_PCI1760=y
CONFIG_COMEDI_ADV_PCI_DIO=y
CONFIG_COMEDI_AMPLC_DIO200_PCI=y
CONFIG_COMEDI_AMPLC_PC236_PCI=y
CONFIG_COMEDI_AMPLC_PC263_PCI=y
CONFIG_COMEDI_AMPLC_PCI224=y
# CONFIG_COMEDI_AMPLC_PCI230 is not set
CONFIG_COMEDI_CONTEC_PCI_DIO=y
CONFIG_COMEDI_DAS08_PCI=y
# CONFIG_COMEDI_DT3000 is not set
CONFIG_COMEDI_DYNA_PCI10XX=y
CONFIG_COMEDI_GSC_HPDI=y
# CONFIG_COMEDI_MF6X4 is not set
CONFIG_COMEDI_ICP_MULTI=y
CONFIG_COMEDI_DAQBOARD2000=y
# CONFIG_COMEDI_JR3_PCI is not set
CONFIG_COMEDI_KE_COUNTER=y
CONFIG_COMEDI_CB_PCIDAS64=y
CONFIG_COMEDI_CB_PCIDAS=y
# CONFIG_COMEDI_CB_PCIDDA is not set
# CONFIG_COMEDI_CB_PCIMDAS is not set
CONFIG_COMEDI_CB_PCIMDDA=y
CONFIG_COMEDI_ME4000=y
CONFIG_COMEDI_ME_DAQ=y
CONFIG_COMEDI_NI_6527=y
# CONFIG_COMEDI_NI_65XX is not set
CONFIG_COMEDI_NI_660X=y
CONFIG_COMEDI_NI_670X=y
# CONFIG_COMEDI_NI_LABPC_PCI is not set
CONFIG_COMEDI_NI_PCIDIO=y
CONFIG_COMEDI_NI_PCIMIO=y
CONFIG_COMEDI_RTD520=y
CONFIG_COMEDI_S626=y
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_NI_TIOCMD=y
CONFIG_COMEDI_PCMCIA_DRIVERS=y
CONFIG_COMEDI_CB_DAS16_CS=y
CONFIG_COMEDI_DAS08_CS=y
CONFIG_COMEDI_NI_DAQ_700_CS=y
CONFIG_COMEDI_NI_DAQ_DIO24_CS=y
CONFIG_COMEDI_NI_LABPC_CS=y
CONFIG_COMEDI_NI_MIO_CS=y
CONFIG_COMEDI_QUATECH_DAQP_CS=y
CONFIG_COMEDI_USB_DRIVERS=y
CONFIG_COMEDI_DT9812=y
CONFIG_COMEDI_NI_USB6501=y
CONFIG_COMEDI_USBDUX=y
# CONFIG_COMEDI_USBDUXFAST is not set
# CONFIG_COMEDI_USBDUXSIGMA is not set
CONFIG_COMEDI_VMK80XX=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_EC=y
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_AMD_PMF is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_TF103C_DOCK is not set
CONFIG_MERAKI_MX100=y
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
CONFIG_DCDBAS=y
CONFIG_DELL_RBU=y
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_SMO8800=m
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_IBM_RTL=y
CONFIG_SENSORS_HDAPS=y
# CONFIG_THINKPAD_ACPI is not set
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=y
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_PMT_CLASS=y
# CONFIG_INTEL_PMT_TELEMETRY is not set
CONFIG_INTEL_PMT_CRASHLOG=y
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_VSEC=y
# CONFIG_XO15_EBOOK is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_BARCO_P50_GPIO=y
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IMR=y
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_SIEMENS_SIMATIC_IPC=y
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
CONFIG_LMK04832=y
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_SI5341=y
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_COMMON_CLK_RS9_PCIE=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_VC7=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_LGM_CGU=y
CONFIG_XILINX_VCU=y
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

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
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_CTRL is not set
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
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
CONFIG_FPGA_DFL_EMIF=y
# CONFIG_IIO is not set
CONFIG_NTB=y
CONFIG_NTB_IDT=y
# CONFIG_NTB_EPF is not set
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=y
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_INTEL_LGM is not set
# CONFIG_PWM_IQS620A is not set
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_TWL is not set
# CONFIG_PWM_TWL_LED is not set
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=y
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_TUSB1210=y
# CONFIG_PHY_INTEL_LGM_COMBO is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
# CONFIG_IDLE_INJECT is not set
CONFIG_DTPM=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_RAS_CEC_DEBUG is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_SPMI_SDAM=y
CONFIG_NVMEM_U_BOOT_ENV=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_MGR_ICE40_SPI=y
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=y
# CONFIG_FPGA_DFL_FME is not set
CONFIG_FPGA_DFL_AFU=y
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
CONFIG_FPGA_DFL_PCI=y
CONFIG_FPGA_MGR_MICROCHIP_SPI=y
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=y
# CONFIG_FSI_MASTER_HUB is not set
# CONFIG_FSI_MASTER_ASPEED is not set
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=y
# CONFIG_FSI_OCC is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
CONFIG_INTERRUPT_CNT=y
# CONFIG_FTM_QUADDEC is not set
CONFIG_MICROCHIP_TCB_CAPTURE=y
CONFIG_INTEL_QEP=y
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
# CONFIG_F2FS_FS_SECURITY is not set
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_F2FS_IOSTAT is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
CONFIG_CACHEFILES_ONDEMAND=y
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set
CONFIG_NTFS3_FS=y
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=y
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
# CONFIG_JFFS2_FS is not set
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_UBIFS_FS_LZO=y
# CONFIG_UBIFS_FS_ZLIB is not set
CONFIG_UBIFS_FS_ZSTD=y
CONFIG_UBIFS_ATIME_SUPPORT=y
# CONFIG_UBIFS_FS_XATTR is not set
CONFIG_UBIFS_FS_AUTHENTICATION=y
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_BLOCKDEV is not set
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
# CONFIG_SQUASHFS_LZO is not set
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
CONFIG_ROMFS_BACKED_BY_MTD=y
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_MTD=y
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
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
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
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
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_LOADPIN=y
# CONFIG_SECURITY_LOADPIN_ENFORCE is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#
CONFIG_GCC_PLUGIN_STRUCTLEAK=y

#
# Memory initialization
#
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
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
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
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
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XCTR=y
# CONFIG_CRYPTO_XTS is not set
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLYVAL=y
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_VMAC is not set
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
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
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
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
CONFIG_CRYPTO_AES_NI_INTEL=y
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
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE=y
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
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_RESTRICTED_POOL is not set
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
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
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
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
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
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
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
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
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
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
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SHRINKER_DEBUG=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_MAPLE_TREE=y
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
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
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
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
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
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
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
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
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_WATCHDOG is not set
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
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_DEBUG_IMR_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--veVQscFeJEhLZOz5
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='rcutorture'
	export testcase='rcutorture'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='rcutorture.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-next/master'
	export commit='0af8489b0216fa1dd83e264bef8063f2632633d7'
	export kconfig='i386-randconfig-a012-20221226'
	export nr_vm=300
	export submit_id='63afa4e915415736749b4802'
	export job_file='/lkp/jobs/scheduled/vm-meta-173/rcutorture-300s-default-tasks-tracing-debian-11.1-i386-20220923.cgz-0af8489b0216fa1dd83e264bef8063f2632633d7-20221231-13940-1j3s4jz-4.yaml'
	export id='9ead3e2ebd67900688fe2e885602ec64ddfef65f'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kernel_version='>= v4.17, gcc
>= v5.12, clang'
	export need_kconfig=\{\"RCU_TORTURE_TEST\"\=\>\"m\"\}'
'\{\"X86_VSMP\"\=\>\"n\"\}'
'\{\"SECURITY_LOADPIN_ENABLED\"\=\>\"n\"\}'
'\{\"SECURITY_LOADPIN_ENFORCE\"\=\>\"n\"\}'
'\{\"MODULE_UNLOAD\"\=\>\"y\"\}'
'\{\"RCU_EXPERT\"\=\>\"y\"\}'
'\{\"FORCE_TASKS_RCU\"\=\>\"y\"\}'
'\{\"TASKS_RCU\"\=\>\"y\"\}'
'\{\"FORCE_TASKS_TRACE_RCU\"\=\>\"y\"\}'
'\{\"TASKS_TRACE_RCU\"\=\>\"y\"\}'
'\{\"FORCE_TASKS_RUDE_RCU\"\=\>\"y\"\}'
'\{\"TASKS_RUDE_RCU\"\=\>\"y\"\}'
'\{\"RCU_REF_SCALE_TEST\"\=\>\"m\"\}'
'\{\"MODULE_UNLOAD\"\=\>\"y\"\}'
'\{\"RCU_EXPERT\"\=\>\"y\"\}'
'\{\"FORCE_TASKS_RCU\"\=\>\"y\"\}'
'\{\"TASKS_RCU\"\=\>\"y\"\}'
'\{\"FORCE_TASKS_TRACE_RCU\"\=\>\"y\"\}'
'\{\"TASKS_TRACE_RCU\"\=\>\"y\"\}'
'\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-i386-20220923.cgz'
	export compiler='gcc-11'
	export enqueue_time='2022-12-31 10:56:41 +0800'
	export _id='63afa50215415736749b4806'
	export _rt='/result/rcutorture/300s-default-tasks-tracing/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/rcutorture/300s-default-tasks-tracing/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/19'
	export scheduler_version='/lkp/lkp/src'
	export arch='i386'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/rcutorture/300s-default-tasks-tracing/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/19
BOOT_IMAGE=/pkg/linux/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/vmlinuz-6.1.0-rc2-00014-g0af8489b0216
branch=linux-next/master
job=/lkp/jobs/scheduled/vm-meta-173/rcutorture-300s-default-tasks-tracing-debian-11.1-i386-20220923.cgz-0af8489b0216fa1dd83e264bef8063f2632633d7-20221231-13940-1j3s4jz-4.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-a012-20221226
commit=0af8489b0216fa1dd83e264bef8063f2632633d7
vmalloc=256M initramfs_async=0 page_owner=on
initcall_debug
mem=4G
nmi_watchdog=0
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
	export modules_initrd='/pkg/linux/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export stop_repeat_if_found='dmesg.kernel_BUG_at_include/linux/page-flags.h'
	export kbuild_queue_analysis=1
	export schedule_notify_address=
	export meta_host='vm-meta-173'
	export kernel='/pkg/linux/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/vmlinuz-6.1.0-rc2-00014-g0af8489b0216'
	export dequeue_time='2022-12-31 10:58:09 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-173/rcutorture-300s-default-tasks-tracing-debian-11.1-i386-20220923.cgz-0af8489b0216fa1dd83e264bef8063f2632633d7-20221231-13940-1j3s4jz-4.cgz'

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

	run_test test='default' torture_type='tasks-tracing' $LKP_SRC/tests/wrapper rcutorture
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='default' torture_type='tasks-tracing' $LKP_SRC/stats/wrapper rcutorture
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time rcutorture.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--veVQscFeJEhLZOz5
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--veVQscFeJEhLZOz5
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="rcutorture"

early console in setup code
early console in extract_kernel
input_data: 0x044f3079
input_len: 0x021fa74f
output: 0x01000000
output_len: 0x043615f0
kernel_total_size: 0x05704000
needed_size: 0x05704000

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
Linux version 6.1.0-rc2-00014-g0af8489b0216 (kbuild@d10e562dce7f) (gcc-11 (Debian 11.3.0-8) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39) #2 SMP Thu Dec 29 14:09:30 CST 2022
KERNEL supported cpus:
Intel GenuineIntel
Vortex Vortex86 SoC
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
signal: max sigframe size: 1760
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000043fffffff] usable
e820: remove [mem 0x100000000-0xfffffffffffffffe] usable
printk: debug: ignoring loglevel setting.
printk: bootconsole [earlyser0] enabled
e820: remove [mem 0x100000000-0xfffffffffffffffe] usable
Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
user-defined physical RAM map:
user: [mem 0x0000000000000000-0x000000000009fbff] usable
user: [mem 0x000000000009fc00-0x000000000009ffff] reserved
user: [mem 0x00000000000f0000-0x00000000000fffff] reserved
user: [mem 0x0000000000100000-0x00000000bffdffff] usable
user: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
user: [mem 0x00000000feffc000-0x00000000feffffff] reserved
user: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
Hypervisor detected: KVM
kvm-clock: Using msrs 4b564d01 and 4b564d00
kvm-clock: using sched offset of 820359527 cycles
clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
tsc: Detected 2194.916 MHz processor
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0xbffe0 max_arch_pfn = 0x100000
x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
Scan for SMP in [mem 0x00000000-0x000003ff]
Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Scan for SMP in [mem 0x000f0000-0x000fffff]
found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
mpc: f5bb0-f5c80
initial memory mapped: [mem 0x00000000-0x06bfffff]
RAMDISK: [mem 0x7a52c000-0x7fffffff]
Allocated new RAMDISK: [mem 0x28d2a000-0x2e7fd498]
Move RAMDISK from [mem 0x7a52c000-0x7ffff498] to [mem 0x28d2a000-0x2e7fd498]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F59B0 000014 (v00 BOCHS )
ACPI: RSDT 0x00000000BFFE198D 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: FACP 0x00000000BFFE1839 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: DSDT 0x00000000BFFE0040 0017F9 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: FACS 0x00000000BFFE0000 000040
ACPI: APIC 0x00000000BFFE18AD 000080 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: HPET 0x00000000BFFE192D 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: WAET 0x00000000BFFE1965 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: Reserving FACP table memory at [mem 0xbffe1839-0xbffe18ac]
ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe1838]
ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
ACPI: Reserving APIC table memory at [mem 0xbffe18ad-0xbffe192c]
ACPI: Reserving HPET table memory at [mem 0xbffe192d-0xbffe1964]
ACPI: Reserving WAET table memory at [mem 0xbffe1965-0xbffe198c]
mapped APIC to         ffffb000 (        fee00000)
2327MB HIGHMEM available.
743MB LOWMEM available.
mapped low ram: 0 - 2e7fe000
low ram: 0 - 2e7fe000
Zone ranges:
Normal   [mem 0x0000000000001000-0x000000002e7fdfff]
HighMem  [mem 0x000000002e7fe000-0x00000000bffdffff]
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x000000000009efff]
node   0: [mem 0x0000000000100000-0x00000000bffdffff]
Initmem setup node 0 [mem 0x0000000000001000-0x00000000bffdffff]
On node 0, zone Normal: 1 pages in unavailable ranges
On node 0, zone Normal: 97 pages in unavailable ranges
Using APIC driver default
ACPI: PM-Timer IO Port: 0x608
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
TSC deadline timer available
smpboot: Allowing 2 CPUs, 0 hotplug CPUs
mapped IOAPIC to ffffa000 (fec00000)
[mem 0xc0000000-0xfeffbfff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
percpu: Embedded 351 pages/cpu s1407324 r0 d30372 u1437696
pcpu-alloc: s1407324 r0 d30372 u1437696 alloc=351*4096
pcpu-alloc: [0] 0 [0] 1 
kvm-guest: PV spinlocks disabled, no host support
Built 1 zonelists, mobility grouping on.  Total pages: 784442
Kernel command line: ip=::::vm-meta-173::dhcp root=/dev/ram0 RESULT_ROOT=/result/rcutorture/300s-default-tasks-tracing/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/19 BOOT_IMAGE=/pkg/linux/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/vmlinuz-6.1.0-rc2-00014-g0af8489b0216 branch=linux-next/master job=/lkp/jobs/scheduled/vm-meta-173/rcutorture-300s-default-tasks-tracing-debian-11.1-i386-20220923.cgz-0af8489b0216fa1dd83e264bef8063f2632633d7-20221231-13940-1j3s4jz-4.yaml user=lkp ARCH=i386 kconfig=i386-randconfig-a012-20221226 commit=0af8489b0216fa1dd83e264bef8063f2632633d7 vmalloc=256M initramfs_async=0 page_owner=on initcall_debug mem=4G nmi_watchdog=0 max_uptime=1200 LKP_SERVER=internal-lkp-server selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oo
sysrq: sysrq always enabled.
ignoring the deprecated load_ramdisk= option
Unknown kernel command line parameters "RESULT_ROOT=/result/rcutorture/300s-default-tasks-tracing/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/19 BOOT_IMAGE=/pkg/linux/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/vmlinuz-6.1.0-rc2-00014-g0af8489b0216 branch=linux-next/master job=/lkp/jobs/scheduled/vm-meta-173/rcutorture-300s-default-tasks-tracing-debian-11.1-i386-20220923.cgz-0af8489b0216fa1dd83e264bef8063f2632633d7-20221231-13940-1j3s4jz-4.yaml user=lkp ARCH=i386 kconfig=i386-randconfig-a012-20221226 commit=0af8489b0216fa1dd83e264bef8063f2632633d7 max_uptime=1200 LKP_SERVER=internal-lkp-server selinux=0 softlockup_panic=1 prompt_ramdisk=0 vga=normal", will be passed to user space.
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
allocated 47245380 bytes of page_ext
mem auto-init: stack:byref_all(zero), heap alloc:off, heap free:off
stackdepot hash table entries: 65536 (order: 6, 262144 bytes, linear)
Initializing HighMem for node 0 (0002e7fe:000bffe0)
Initializing Movable for node 0 (00000000:00000000)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
Memory: 2882744K/3145208K available (40135K kernel code, 10445K rwdata, 15300K rodata, 2904K init, 19000K bss, 262464K reserved, 0K cma-reserved, 2383752K highmem)
SLUB: HWalign=64, Order=0-1, MinObjects=0, CPUs=2, Nodes=1
Node 0, zone   Normal: page owner found early allocated 10 pages
Node 0, zone  HighMem: page owner found early allocated 0 pages
trace event string verifier disabled
Running RCU self tests
rcu: Hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
	Trampoline variant of Tasks RCU enabled.
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 2304, nr_irqs: 56, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.
calling  hvc_console_init+0x0/0x4a @ 0
initcall hvc_console_init+0x0/0x4a returned 0 after 0 usecs
calling  univ8250_console_init+0x0/0x8b @ 0
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
initcall univ8250_console_init+0x0/0x8b returned 0 after 0 usecs
calling  altera_jtaguart_console_init+0x0/0x4a @ 0
initcall altera_jtaguart_console_init+0x0/0x4a returned 0 after 0 usecs
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
memory used by lock dependency info: 4061 kB
memory used for stack traces: 2112 kB
per task-struct memory footprint: 2112 bytes
ACPI: Core revision 20220331
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
APIC: Switch to symmetric I/O mode setup
Enabling APIC mode:  Flat.  Using 1 I/O APICs
masked ExtINT on CPU#0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
apic 0 pin 0 not connected
IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 0 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-4 -> IRQ 4 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-5 -> IRQ 5 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-6 -> IRQ 6 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-7 -> IRQ 7 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-8 -> IRQ 8 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-9 -> IRQ 9 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-10 -> IRQ 10 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-11 -> IRQ 11 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-12 -> IRQ 12 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-13 -> IRQ 13 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-14 -> IRQ 14 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-15 -> IRQ 15 Level:0 ActiveLow:0)
apic 0 pin 16 not connected
apic 0 pin 17 not connected
apic 0 pin 18 not connected
apic 0 pin 19 not connected
apic 0 pin 20 not connected
apic 0 pin 21 not connected
apic 0 pin 22 not connected
apic 0 pin 23 not connected
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1fa3704c1a9, max_idle_ns: 440795296692 ns
Calibrating delay loop (skipped) preset value.. 4389.83 BogoMIPS (lpj=2194916)
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
landlock: Up and running.
LoadPin: ready to pin (currently not enforcing)
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
Spectre V2 : Vulnerable
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Speculative Store Bypass: Vulnerable
L1TF: Kernel not compiled for PAE. No mitigation for L1TF
MDS: Vulnerable: Clear CPU buffers attempted, no microcode
MMIO Stale Data: Unknown: No mitigations
Freeing SMP alternatives memory: 40K
smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 1 and lim to 1.
cblist_init_generic: Setting shift to 1 and lim to 1.
cblist_init_generic: Setting shift to 1 and lim to 1.
Running RCU-tasks wait API self tests
calling  init_hw_perf_events+0x0/0xa30 @ 1
Performance Events: unsupported p6 CPU model 42 no PMU driver, software events only.
initcall init_hw_perf_events+0x0/0xa30 returned 0 after 1000 usecs
calling  init_real_mode+0x0/0x114 @ 1
initcall init_real_mode+0x0/0x114 returned 0 after 0 usecs
calling  trace_init_perf_perm_irq_work_exit+0x0/0x38 @ 1
initcall trace_init_perf_perm_irq_work_exit+0x0/0x38 returned 0 after 0 usecs
calling  bp_init_aperfmperf+0x0/0x77 @ 1
initcall bp_init_aperfmperf+0x0/0x77 returned 0 after 0 usecs
calling  validate_x2apic+0x0/0x13a @ 1
initcall validate_x2apic+0x0/0x13a returned 0 after 0 usecs
calling  register_nmi_cpu_backtrace_handler+0x0/0x4c @ 1
initcall register_nmi_cpu_backtrace_handler+0x0/0x4c returned 0 after 0 usecs
calling  kvm_setup_vsyscall_timeinfo+0x0/0xc5 @ 1
initcall kvm_setup_vsyscall_timeinfo+0x0/0xc5 returned 0 after 0 usecs
calling  spawn_ksoftirqd+0x0/0xa6 @ 1
initcall spawn_ksoftirqd+0x0/0xa6 returned 0 after 1000 usecs
calling  migration_init+0x0/0x4b @ 1
initcall migration_init+0x0/0x4b returned 0 after 0 usecs
calling  srcu_bootup_announce+0x0/0x13b @ 1
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 400.
initcall srcu_bootup_announce+0x0/0x13b returned 0 after 1000 usecs
calling  rcu_spawn_gp_kthread+0x0/0x301 @ 1
initcall rcu_spawn_gp_kthread+0x0/0x301 returned 0 after 1000 usecs
calling  check_cpu_stall_init+0x0/0x4f @ 1
initcall check_cpu_stall_init+0x0/0x4f returned 0 after 0 usecs
calling  rcu_sysrq_init+0x0/0x73 @ 1
initcall rcu_sysrq_init+0x0/0x73 returned 0 after 0 usecs
calling  trace_init_flags_sys_enter+0x0/0x35 @ 1
initcall trace_init_flags_sys_enter+0x0/0x35 returned 0 after 0 usecs
calling  trace_init_flags_sys_exit+0x0/0x35 @ 1
initcall trace_init_flags_sys_exit+0x0/0x35 returned 0 after 0 usecs
calling  cpu_stop_init+0x0/0x16d @ 1
Callback from call_rcu_tasks_trace() invoked.
initcall cpu_stop_init+0x0/0x16d returned 0 after 1000 usecs
calling  init_kprobes+0x0/0x273 @ 1
initcall init_kprobes+0x0/0x273 returned 0 after 1000 usecs
calling  init_events+0x0/0x16a @ 1
initcall init_events+0x0/0x16a returned 0 after 0 usecs
calling  init_trace_printk+0x0/0x49 @ 1
initcall init_trace_printk+0x0/0x49 returned 0 after 0 usecs
calling  event_trace_enable_again+0x0/0x86 @ 1
initcall event_trace_enable_again+0x0/0x86 returned 0 after 0 usecs
calling  irq_work_init_threads+0x0/0x2e @ 1
initcall irq_work_init_threads+0x0/0x2e returned 0 after 0 usecs
calling  jump_label_init_module+0x0/0x49 @ 1
initcall jump_label_init_module+0x0/0x49 returned 0 after 0 usecs
calling  init_zero_pfn+0x0/0x4b @ 1
initcall init_zero_pfn+0x0/0x4b returned 0 after 0 usecs
calling  init_fs_inode_sysctls+0x0/0x54 @ 1
initcall init_fs_inode_sysctls+0x0/0x54 returned 0 after 0 usecs
calling  init_fs_locks_sysctls+0x0/0x54 @ 1
initcall init_fs_locks_sysctls+0x0/0x54 returned 0 after 0 usecs
calling  dynamic_debug_init+0x0/0x3c7 @ 1
initcall dynamic_debug_init+0x0/0x3c7 returned 0 after 4000 usecs
NMI watchdog: Perf NMI watchdog permanently disabled
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
masked ExtINT on CPU#1
smp: Brought up 1 node, 2 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 2 processors activated (8779.66 BogoMIPS)
devtmpfs: initialized
version magic: 0x4231332a
calling  ipc_ns_init+0x0/0x7c @ 1
initcall ipc_ns_init+0x0/0x7c returned 0 after 0 usecs
calling  init_mmap_min_addr+0x0/0x3a @ 1
initcall init_mmap_min_addr+0x0/0x3a returned 0 after 0 usecs
calling  pci_realloc_setup_params+0x0/0xa5 @ 1
initcall pci_realloc_setup_params+0x0/0xa5 returned 0 after 0 usecs
calling  inet_frag_wq_init+0x0/0x7f @ 1
initcall inet_frag_wq_init+0x0/0x7f returned 0 after 1000 usecs
calling  e820__register_nvs_regions+0x0/0xad @ 1
initcall e820__register_nvs_regions+0x0/0xad returned 0 after 0 usecs
calling  cpufreq_register_tsc_scaling+0x0/0x98 @ 1
initcall cpufreq_register_tsc_scaling+0x0/0x98 returned 0 after 0 usecs
calling  reboot_init+0x0/0x2e @ 1
initcall reboot_init+0x0/0x2e returned 0 after 0 usecs
calling  wq_sysfs_init+0x0/0x8b @ 1
initcall wq_sysfs_init+0x0/0x8b returned 0 after 0 usecs
calling  ksysfs_init+0x0/0x16c @ 1
initcall ksysfs_init+0x0/0x16c returned 0 after 0 usecs
calling  schedutil_gov_init+0x0/0x49 @ 1
initcall schedutil_gov_init+0x0/0x49 returned 0 after 0 usecs
calling  rcu_set_runtime_mode+0x0/0x9b @ 1
initcall rcu_set_runtime_mode+0x0/0x9b returned 0 after 0 usecs
calling  init_jiffies_clocksource+0x0/0x50 @ 1
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
initcall init_jiffies_clocksource+0x0/0x50 returned 0 after 1000 usecs
calling  futex_init+0x0/0x1df @ 1
futex hash table entries: 512 (order: 3, 32768 bytes, linear)
initcall futex_init+0x0/0x1df returned 0 after 1000 usecs
calling  cgroup_wq_init+0x0/0x8a @ 1
initcall cgroup_wq_init+0x0/0x8a returned 0 after 0 usecs
calling  cgroup1_wq_init+0x0/0x87 @ 1
initcall cgroup1_wq_init+0x0/0x87 returned 0 after 0 usecs
calling  trace_events_eprobe_init_early+0x0/0x8d @ 1
initcall trace_events_eprobe_init_early+0x0/0x8d returned 0 after 0 usecs
calling  init_kprobe_trace_early+0x0/0xac @ 1
initcall init_kprobe_trace_early+0x0/0xac returned 0 after 0 usecs
calling  memory_failure_init+0x0/0x183 @ 1
initcall memory_failure_init+0x0/0x183 returned 0 after 0 usecs
calling  cma_init_reserved_areas+0x0/0xa4 @ 1
initcall cma_init_reserved_areas+0x0/0xa4 returned 0 after 0 usecs
calling  fsnotify_init+0x0/0xa3 @ 1
initcall fsnotify_init+0x0/0xa3 returned 0 after 0 usecs
calling  filelock_init+0x0/0x17f @ 1
initcall filelock_init+0x0/0x17f returned 0 after 0 usecs
calling  init_script_binfmt+0x0/0x4c @ 1
initcall init_script_binfmt+0x0/0x4c returned 0 after 0 usecs
calling  init_elf_binfmt+0x0/0x4c @ 1
initcall init_elf_binfmt+0x0/0x4c returned 0 after 0 usecs
calling  configfs_init+0x0/0x160 @ 1
initcall configfs_init+0x0/0x160 returned 0 after 0 usecs
calling  debugfs_init+0x0/0xfc @ 1
initcall debugfs_init+0x0/0xfc returned -1 after 0 usecs
calling  tracefs_init+0x0/0xb6 @ 1
initcall tracefs_init+0x0/0xb6 returned 0 after 0 usecs
calling  pinctrl_init+0x0/0x5f @ 1
pinctrl core: initialized pinctrl subsystem
pinctrl core: failed to create debugfs directory
initcall pinctrl_init+0x0/0x5f returned 0 after 1000 usecs
calling  gpiolib_dev_init+0x0/0x249 @ 1
initcall gpiolib_dev_init+0x0/0x249 returned 0 after 0 usecs
calling  virtio_init+0x0/0x40 @ 1
Callback from call_rcu_tasks_rude() invoked.
initcall virtio_init+0x0/0x40 returned 0 after 2000 usecs
calling  regulator_init+0x0/0x130 @ 1
regulator-dummy: no parameters, enabled
initcall regulator_init+0x0/0x130 returned 0 after 1000 usecs
calling  iommu_init+0x0/0x89 @ 1
initcall iommu_init+0x0/0x89 returned 0 after 0 usecs
calling  component_debug_init+0x0/0x51 @ 1
initcall component_debug_init+0x0/0x51 returned 0 after 0 usecs
calling  opp_debug_init+0x0/0x51 @ 1
initcall opp_debug_init+0x0/0x51 returned 0 after 0 usecs
calling  cpufreq_core_init+0x0/0x15c @ 1
initcall cpufreq_core_init+0x0/0x15c returned 0 after 0 usecs
calling  cpufreq_gov_performance_init+0x0/0x49 @ 1
initcall cpufreq_gov_performance_init+0x0/0x49 returned 0 after 0 usecs
calling  cpufreq_gov_powersave_init+0x0/0x49 @ 1
initcall cpufreq_gov_powersave_init+0x0/0x49 returned 0 after 0 usecs
calling  cpufreq_gov_userspace_init+0x0/0x49 @ 1
initcall cpufreq_gov_userspace_init+0x0/0x49 returned 0 after 0 usecs
calling  CPU_FREQ_GOV_ONDEMAND_init+0x0/0x49 @ 1
initcall CPU_FREQ_GOV_ONDEMAND_init+0x0/0x49 returned 0 after 0 usecs
calling  cpufreq_dt_platdev_init+0x0/0x292 @ 1
initcall cpufreq_dt_platdev_init+0x0/0x292 returned -19 after 0 usecs
calling  cpuidle_init+0x0/0x76 @ 1
initcall cpuidle_init+0x0/0x76 returned 0 after 0 usecs
calling  sock_init+0x0/0x191 @ 1
initcall sock_init+0x0/0x191 returned 0 after 0 usecs
calling  net_inuse_init+0x0/0x6b @ 1
initcall net_inuse_init+0x0/0x6b returned 0 after 0 usecs
calling  net_defaults_init+0x0/0x6b @ 1
initcall net_defaults_init+0x0/0x6b returned 0 after 0 usecs
calling  init_default_flow_dissectors+0x0/0x98 @ 1
initcall init_default_flow_dissectors+0x0/0x98 returned 0 after 0 usecs
calling  netlink_proto_init+0x0/0x29c @ 1
NET: Registered PF_NETLINK/PF_ROUTE protocol family
initcall netlink_proto_init+0x0/0x29c returned 0 after 2000 usecs
calling  genl_init+0x0/0x9e @ 1
initcall genl_init+0x0/0x9e returned 0 after 0 usecs
calling  olpc_init+0x0/0x32b @ 1
initcall olpc_init+0x0/0x32b returned 0 after 0 usecs
calling  pi_init+0x0/0xb4 @ 1
initcall pi_init+0x0/0xb4 returned 0 after 0 usecs
calling  irq_sysfs_init+0x0/0x164 @ 1
initcall irq_sysfs_init+0x0/0x164 returned 0 after 1000 usecs
calling  release_early_probes+0x0/0x81 @ 1
initcall release_early_probes+0x0/0x81 returned 0 after 0 usecs
calling  bdi_class_init+0x0/0xbf @ 1
initcall bdi_class_init+0x0/0xbf returned 0 after 0 usecs
calling  mm_sysfs_init+0x0/0x7e @ 1
initcall mm_sysfs_init+0x0/0x7e returned 0 after 0 usecs
calling  init_per_zone_wmark_min+0x0/0x7e @ 1
initcall init_per_zone_wmark_min+0x0/0x7e returned 0 after 0 usecs
calling  mpi_init+0x0/0x108 @ 1
initcall mpi_init+0x0/0x108 returned 0 after 0 usecs
calling  mhi_init+0x0/0x5c @ 1
initcall mhi_init+0x0/0x5c returned 0 after 0 usecs
calling  mhi_ep_init+0x0/0x49 @ 1
initcall mhi_ep_init+0x0/0x49 returned 0 after 0 usecs
calling  gpiolib_sysfs_init+0x0/0x162 @ 1
initcall gpiolib_sysfs_init+0x0/0x162 returned 0 after 0 usecs
calling  acpi_gpio_setup_params+0x0/0x5e @ 1
initcall acpi_gpio_setup_params+0x0/0x5e returned 0 after 0 usecs
calling  pcibus_class_init+0x0/0x4e @ 1
initcall pcibus_class_init+0x0/0x4e returned 0 after 0 usecs
calling  pci_driver_init+0x0/0x6c @ 1
initcall pci_driver_init+0x0/0x6c returned 0 after 0 usecs
calling  lcd_class_init+0x0/0xa6 @ 1
initcall lcd_class_init+0x0/0xa6 returned 0 after 0 usecs
calling  backlight_class_init+0x0/0x112 @ 1
initcall backlight_class_init+0x0/0x112 returned 0 after 0 usecs
calling  tty_class_init+0x0/0x84 @ 1
initcall tty_class_init+0x0/0x84 returned 0 after 0 usecs
calling  iommu_dev_init+0x0/0x4e @ 1
initcall iommu_dev_init+0x0/0x4e returned 0 after 0 usecs
calling  mipi_dsi_bus_init+0x0/0x49 @ 1
initcall mipi_dsi_bus_init+0x0/0x49 returned 0 after 0 usecs
calling  devlink_class_init+0x0/0xc5 @ 1
initcall devlink_class_init+0x0/0xc5 returned 0 after 0 usecs
calling  software_node_init+0x0/0x80 @ 1
initcall software_node_init+0x0/0x80 returned 0 after 0 usecs
calling  isa_bus_init+0x0/0xc0 @ 1
initcall isa_bus_init+0x0/0xc0 returned 0 after 0 usecs
calling  regmap_initcall+0x0/0x45 @ 1
initcall regmap_initcall+0x0/0x45 returned 0 after 0 usecs
calling  sram_init+0x0/0x4b @ 1
initcall sram_init+0x0/0x4b returned 0 after 0 usecs
calling  syscon_init+0x0/0x4b @ 1
initcall syscon_init+0x0/0x4b returned 0 after 0 usecs
calling  spi_init+0x0/0x187 @ 1
initcall spi_init+0x0/0x187 returned 0 after 0 usecs
calling  spmi_init+0x0/0x73 @ 1
initcall spmi_init+0x0/0x73 returned 0 after 0 usecs
calling  spmi_controller_init+0x0/0x4b @ 1
initcall spmi_controller_init+0x0/0x4b returned 0 after 0 usecs
calling  hsi_init+0x0/0x49 @ 1
initcall hsi_init+0x0/0x49 returned 0 after 0 usecs
calling  i2c_init+0x0/0x193 @ 1
initcall i2c_init+0x0/0x193 returned 0 after 0 usecs
calling  thermal_init+0x0/0x176 @ 1
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
initcall thermal_init+0x0/0x176 returned 0 after 1000 usecs
calling  init_ladder+0x0/0x53 @ 1
cpuidle: using governor ladder
initcall init_ladder+0x0/0x53 returned 0 after 1000 usecs
calling  rpmsg_init+0x0/0x119 @ 1
initcall rpmsg_init+0x0/0x119 returned 0 after 0 usecs
calling  rpmsg_ns_init+0x0/0x50 @ 1
initcall rpmsg_ns_init+0x0/0x50 returned 0 after 0 usecs
calling  fsi_init+0x0/0x132 @ 1
initcall fsi_init+0x0/0x132 returned 0 after 0 usecs
calling  kobject_uevent_init+0x0/0x49 @ 1
initcall kobject_uevent_init+0x0/0x49 returned 0 after 0 usecs
calling  bts_init+0x0/0x13e @ 1
initcall bts_init+0x0/0x13e returned -19 after 0 usecs
calling  pt_init+0x0/0x389 @ 1
initcall pt_init+0x0/0x389 returned -19 after 0 usecs
calling  boot_params_ksysfs_init+0x0/0x11e @ 1
initcall boot_params_ksysfs_init+0x0/0x11e returned 0 after 0 usecs
calling  sbf_init+0x0/0x24f @ 1
initcall sbf_init+0x0/0x24f returned 0 after 0 usecs
calling  arch_kdebugfs_init+0x0/0x51 @ 1
initcall arch_kdebugfs_init+0x0/0x51 returned 0 after 0 usecs
calling  init_pit_clocksource+0x0/0xe1 @ 1
initcall init_pit_clocksource+0x0/0xe1 returned 0 after 0 usecs
calling  intel_pconfig_init+0x0/0x1e1 @ 1
initcall intel_pconfig_init+0x0/0x1e1 returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0xb1 @ 1
initcall activate_jump_labels+0x0/0xb1 returned 0 after 0 usecs
calling  ffh_cstate_init+0x0/0xa4 @ 1
initcall ffh_cstate_init+0x0/0xa4 returned 0 after 0 usecs
calling  kvm_alloc_cpumask+0x0/0x1a6 @ 1
initcall kvm_alloc_cpumask+0x0/0x1a6 returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0xb3 @ 1
initcall activate_jump_labels+0x0/0xb3 returned 0 after 0 usecs
calling  kcmp_cookies_init+0x0/0xe1 @ 1
initcall kcmp_cookies_init+0x0/0xe1 returned 0 after 0 usecs
calling  cryptomgr_init+0x0/0x49 @ 1
initcall cryptomgr_init+0x0/0x49 returned 0 after 0 usecs
calling  acpi_pci_init+0x0/0xb6 @ 1
initcall acpi_pci_init+0x0/0xb6 returned 0 after 0 usecs
calling  cdns_uart_init+0x0/0x4b @ 1
initcall cdns_uart_init+0x0/0x4b returned 0 after 0 usecs
calling  olpc_ec_init_module+0x0/0x4b @ 1
initcall olpc_ec_init_module+0x0/0x4b returned 0 after 0 usecs
calling  pci_arch_init+0x0/0x19c @ 1
PCI: PCI BIOS revision 2.10 entry at 0xfd1ca, last bus=0
PCI: Using configuration type 1 for base access
initcall pci_arch_init+0x0/0x19c returned 0 after 2000 usecs
calling  of_platform_default_populate_init+0x0/0x1a3 @ 1
initcall of_platform_default_populate_init+0x0/0x1a3 returned -19 after 0 usecs
calling  fixup_ht_bug+0x0/0x1ce @ 1
initcall fixup_ht_bug+0x0/0x1ce returned 0 after 0 usecs
calling  topology_init+0x0/0xb1 @ 1
initcall topology_init+0x0/0xb1 returned 0 after 1000 usecs
calling  uid_cache_init+0x0/0x144 @ 1
initcall uid_cache_init+0x0/0x144 returned 0 after 0 usecs
calling  param_sysfs_init+0x0/0x1cb @ 1
initcall param_sysfs_init+0x0/0x1cb returned 0 after 91000 usecs
calling  user_namespace_sysctl_init+0x0/0x19a @ 1
initcall user_namespace_sysctl_init+0x0/0x19a returned 0 after 0 usecs
calling  proc_schedstat_init+0x0/0x59 @ 1
initcall proc_schedstat_init+0x0/0x59 returned 0 after 0 usecs
calling  pm_sysrq_init+0x0/0x4f @ 1
initcall pm_sysrq_init+0x0/0x4f returned 0 after 0 usecs
calling  create_proc_profile+0x0/0x190 @ 1
initcall create_proc_profile+0x0/0x190 returned 0 after 0 usecs
calling  crash_save_vmcoreinfo_init+0x0/0x977 @ 1
initcall crash_save_vmcoreinfo_init+0x0/0x977 returned 0 after 0 usecs
calling  crash_notes_memory_init+0x0/0x98 @ 1
initcall crash_notes_memory_init+0x0/0x98 returned 0 after 0 usecs
calling  cgroup_sysfs_init+0x0/0x4e @ 1
initcall cgroup_sysfs_init+0x0/0x4e returned 0 after 0 usecs
calling  cgroup_namespaces_init+0x0/0x2e @ 1
initcall cgroup_namespaces_init+0x0/0x2e returned 0 after 0 usecs
calling  init_optprobes+0x0/0x73 @ 1
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
initcall init_optprobes+0x0/0x73 returned 0 after 1000 usecs
calling  hung_task_init+0x0/0xf7 @ 1
initcall hung_task_init+0x0/0xf7 returned 0 after 0 usecs
calling  trace_eval_init+0x0/0x123 @ 1
initcall trace_eval_init+0x0/0x123 returned 0 after 0 usecs
calling  oom_init+0x0/0xb3 @ 1
initcall oom_init+0x0/0xb3 returned 0 after 1000 usecs
calling  default_bdi_init+0x0/0x81 @ 1
initcall default_bdi_init+0x0/0x81 returned 0 after 0 usecs
calling  percpu_enable_async+0x0/0x35 @ 1
initcall percpu_enable_async+0x0/0x35 returned 0 after 0 usecs
calling  init_user_reserve+0x0/0x40 @ 1
initcall init_user_reserve+0x0/0x40 returned 0 after 0 usecs
calling  init_admin_reserve+0x0/0x40 @ 1
initcall init_admin_reserve+0x0/0x40 returned 0 after 0 usecs
calling  init_reserve_notifier+0x0/0x2e @ 1
initcall init_reserve_notifier+0x0/0x2e returned 0 after 0 usecs
calling  swap_init_sysfs+0x0/0xff @ 1
initcall swap_init_sysfs+0x0/0xff returned 0 after 0 usecs
calling  swapfile_init+0x0/0xe3 @ 1
initcall swapfile_init+0x0/0xe3 returned 0 after 0 usecs
calling  hugetlb_init+0x0/0x768 @ 1
HugeTLB: registered 4.00 MiB page size, pre-allocated 0 pages
HugeTLB: 0 KiB vmemmap can be freed for a 4.00 MiB page
initcall hugetlb_init+0x0/0x768 returned 0 after 1000 usecs
calling  ksm_init+0x0/0x20a @ 1
initcall ksm_init+0x0/0x20a returned 0 after 1000 usecs
calling  mem_cgroup_init+0x0/0x28c @ 1
initcall mem_cgroup_init+0x0/0x28c returned 0 after 0 usecs
calling  mem_cgroup_swap_init+0x0/0x10e @ 1
Callback from call_rcu_tasks() invoked.
initcall mem_cgroup_swap_init+0x0/0x10e returned 0 after 1000 usecs
calling  page_idle_init+0x0/0x92 @ 1
initcall page_idle_init+0x0/0x92 returned 0 after 0 usecs
calling  seqiv_module_init+0x0/0x49 @ 1
initcall seqiv_module_init+0x0/0x49 returned 0 after 0 usecs
calling  dh_init+0x0/0xc2 @ 1
initcall dh_init+0x0/0xc2 returned 0 after 0 usecs
calling  rsa_init+0x0/0xc0 @ 1
initcall rsa_init+0x0/0xc0 returned 0 after 0 usecs
calling  ecdsa_init+0x0/0x121 @ 1
initcall ecdsa_init+0x0/0x121 returned 0 after 0 usecs
calling  hmac_module_init+0x0/0x49 @ 1
initcall hmac_module_init+0x0/0x49 returned 0 after 0 usecs
calling  crypto_xcbc_module_init+0x0/0x49 @ 1
initcall crypto_xcbc_module_init+0x0/0x49 returned 0 after 0 usecs
calling  crypto_null_mod_init+0x0/0x124 @ 1
initcall crypto_null_mod_init+0x0/0x124 returned 0 after 0 usecs
calling  md4_mod_init+0x0/0x49 @ 1
initcall md4_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  md5_mod_init+0x0/0x49 @ 1
initcall md5_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  rmd160_mod_init+0x0/0x49 @ 1
initcall rmd160_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  sha1_generic_mod_init+0x0/0x49 @ 1
initcall sha1_generic_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  sha256_generic_mod_init+0x0/0x4e @ 1
initcall sha256_generic_mod_init+0x0/0x4e returned 0 after 0 usecs
calling  sha512_generic_mod_init+0x0/0x4e @ 1
initcall sha512_generic_mod_init+0x0/0x4e returned 0 after 0 usecs
calling  sm3_generic_mod_init+0x0/0x49 @ 1
initcall sm3_generic_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  wp512_mod_init+0x0/0x4e @ 1
initcall wp512_mod_init+0x0/0x4e returned 0 after 0 usecs
calling  blake2b_mod_init+0x0/0x4e @ 1
initcall blake2b_mod_init+0x0/0x4e returned 0 after 0 usecs
calling  crypto_ecb_module_init+0x0/0x49 @ 1
initcall crypto_ecb_module_init+0x0/0x49 returned 0 after 0 usecs
calling  crypto_cbc_module_init+0x0/0x49 @ 1
initcall crypto_cbc_module_init+0x0/0x49 returned 0 after 0 usecs
calling  crypto_cfb_module_init+0x0/0x49 @ 1
initcall crypto_cfb_module_init+0x0/0x49 returned 0 after 0 usecs
calling  crypto_ctr_module_init+0x0/0x4e @ 1
initcall crypto_ctr_module_init+0x0/0x4e returned 0 after 0 usecs
calling  crypto_xctr_module_init+0x0/0x49 @ 1
initcall crypto_xctr_module_init+0x0/0x49 returned 0 after 0 usecs
calling  hctr2_module_init+0x0/0x4e @ 1
initcall hctr2_module_init+0x0/0x4e returned 0 after 0 usecs
calling  crypto_kw_init+0x0/0x49 @ 1
initcall crypto_kw_init+0x0/0x49 returned 0 after 0 usecs
calling  crypto_gcm_module_init+0x0/0xf1 @ 1
initcall crypto_gcm_module_init+0x0/0xf1 returned 0 after 0 usecs
calling  crypto_ccm_module_init+0x0/0x4e @ 1
initcall crypto_ccm_module_init+0x0/0x4e returned 0 after 0 usecs
calling  crypto_aegis128_module_init+0x0/0x6c @ 1
initcall crypto_aegis128_module_init+0x0/0x6c returned 0 after 0 usecs
calling  pcrypt_init+0x0/0x151 @ 1
initcall pcrypt_init+0x0/0x151 returned 0 after 1000 usecs
calling  cryptd_init+0x0/0x124 @ 1
cryptd: max_cpu_qlen set to 1000
initcall cryptd_init+0x0/0x124 returned 0 after 1000 usecs
calling  fcrypt_mod_init+0x0/0x49 @ 1
initcall fcrypt_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  blowfish_mod_init+0x0/0x49 @ 1
initcall blowfish_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  twofish_mod_init+0x0/0x49 @ 1
initcall twofish_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  serpent_mod_init+0x0/0x49 @ 1
initcall serpent_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  aes_init+0x0/0x49 @ 1
initcall aes_init+0x0/0x49 returned 0 after 0 usecs
calling  sm4_init+0x0/0x49 @ 1
initcall sm4_init+0x0/0x49 returned 0 after 0 usecs
calling  camellia_init+0x0/0x49 @ 1
initcall camellia_init+0x0/0x49 returned 0 after 0 usecs
calling  cast6_mod_init+0x0/0x49 @ 1
initcall cast6_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  chacha_generic_mod_init+0x0/0x4e @ 1
initcall chacha_generic_mod_init+0x0/0x4e returned 0 after 0 usecs
calling  deflate_mod_init+0x0/0xc5 @ 1
initcall deflate_mod_init+0x0/0xc5 returned 0 after 0 usecs
calling  michael_mic_init+0x0/0x49 @ 1
initcall michael_mic_init+0x0/0x49 returned 0 after 0 usecs
calling  crc32c_mod_init+0x0/0x49 @ 1
initcall crc32c_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  crc32_mod_init+0x0/0x49 @ 1
initcall crc32_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  crct10dif_mod_init+0x0/0x49 @ 1
initcall crct10dif_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  crypto_authenc_module_init+0x0/0x49 @ 1
initcall crypto_authenc_module_init+0x0/0x49 returned 0 after 0 usecs
calling  crypto_authenc_esn_module_init+0x0/0x49 @ 1
initcall crypto_authenc_esn_module_init+0x0/0x49 returned 0 after 0 usecs
calling  lzo_mod_init+0x0/0xc0 @ 1
initcall lzo_mod_init+0x0/0xc0 returned 0 after 0 usecs
calling  lzorle_mod_init+0x0/0xbf @ 1
initcall lzorle_mod_init+0x0/0xbf returned 0 after 0 usecs
calling  lz4hc_mod_init+0x0/0xbf @ 1
initcall lz4hc_mod_init+0x0/0xbf returned 0 after 0 usecs
calling  xxhash_mod_init+0x0/0x49 @ 1
initcall xxhash_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  prng_mod_init+0x0/0x4e @ 1
initcall prng_mod_init+0x0/0x4e returned 0 after 0 usecs
calling  drbg_init+0x0/0x1a7 @ 1
initcall drbg_init+0x0/0x1a7 returned 0 after 0 usecs
calling  ghash_mod_init+0x0/0x49 @ 1
initcall ghash_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  polyval_mod_init+0x0/0x49 @ 1
initcall polyval_mod_init+0x0/0x49 returned 0 after 0 usecs
calling  zstd_mod_init+0x0/0xc0 @ 1
initcall zstd_mod_init+0x0/0xc0 returned 0 after 0 usecs
calling  crypto_ofb_module_init+0x0/0x49 @ 1
initcall crypto_ofb_module_init+0x0/0x49 returned 0 after 0 usecs
calling  essiv_module_init+0x0/0x49 @ 1
initcall essiv_module_init+0x0/0x49 returned 0 after 0 usecs
calling  curve25519_init+0x0/0x49 @ 1
initcall curve25519_init+0x0/0x49 returned 0 after 0 usecs
calling  ecdh_init+0x0/0x121 @ 1
initcall ecdh_init+0x0/0x121 returned 0 after 0 usecs
calling  init_bio+0x0/0xf8 @ 1
initcall init_bio+0x0/0xf8 returned 0 after 0 usecs
calling  blk_ioc_init+0x0/0x5f @ 1
initcall blk_ioc_init+0x0/0x5f returned 0 after 0 usecs
calling  blk_mq_init+0x0/0x15d @ 1
initcall blk_mq_init+0x0/0x15d returned 0 after 0 usecs
calling  genhd_device_init+0x0/0xd1 @ 1
initcall genhd_device_init+0x0/0xd1 returned 0 after 1000 usecs
calling  io_wq_init+0x0/0x8b @ 1
initcall io_wq_init+0x0/0x8b returned 0 after 0 usecs
calling  sg_pool_init+0x0/0x1ae @ 1
initcall sg_pool_init+0x0/0x1ae returned 0 after 0 usecs
calling  irq_poll_setup+0x0/0x129 @ 1
initcall irq_poll_setup+0x0/0x129 returned 0 after 0 usecs
calling  mcp23s08_i2c_init+0x0/0x4b @ 1
initcall mcp23s08_i2c_init+0x0/0x4b returned 0 after 0 usecs
calling  mcp23s08_spi_init+0x0/0x4b @ 1
initcall mcp23s08_spi_init+0x0/0x4b returned 0 after 0 usecs
calling  sx150x_init+0x0/0x4b @ 1
initcall sx150x_init+0x0/0x4b returned 0 after 0 usecs
calling  gpiolib_debugfs_init+0x0/0x5a @ 1
initcall gpiolib_debugfs_init+0x0/0x5a returned 0 after 0 usecs
calling  altera_gpio_init+0x0/0x4b @ 1
initcall altera_gpio_init+0x0/0x4b returned 0 after 0 usecs
calling  da9055_gpio_init+0x0/0x4b @ 1
initcall da9055_gpio_init+0x0/0x4b returned 0 after 0 usecs
calling  f7188x_gpio_init+0x0/0x16c @ 1
gpio-f7188x: Unsupported Fintek device 0xffff
gpio-f7188x: Unsupported Fintek device 0xffff
initcall f7188x_gpio_init+0x0/0x16c returned -19 after 1000 usecs
calling  max7300_init+0x0/0x4b @ 1
initcall max7300_init+0x0/0x4b returned 0 after 0 usecs
calling  max7301_init+0x0/0x4b @ 1
initcall max7301_init+0x0/0x4b returned 0 after 0 usecs
calling  max732x_init+0x0/0x4b @ 1
initcall max732x_init+0x0/0x4b returned 0 after 0 usecs
calling  mc33880_init+0x0/0x4b @ 1
initcall mc33880_init+0x0/0x4b returned 0 after 0 usecs
calling  palmas_gpio_init+0x0/0x4b @ 1
initcall palmas_gpio_init+0x0/0x4b returned 0 after 0 usecs
calling  pca953x_init+0x0/0x4b @ 1
initcall pca953x_init+0x0/0x4b returned 0 after 0 usecs
calling  rc5t583_gpio_init+0x0/0x4b @ 1
initcall rc5t583_gpio_init+0x0/0x4b returned 0 after 0 usecs
calling  tc3589x_gpio_init+0x0/0x4b @ 1
initcall tc3589x_gpio_init+0x0/0x4b returned 0 after 0 usecs
calling  tps6586x_gpio_init+0x0/0x4b @ 1
initcall tps6586x_gpio_init+0x0/0x4b returned 0 after 0 usecs
calling  wm831x_gpio_init+0x0/0x4b @ 1
initcall wm831x_gpio_init+0x0/0x4b returned 0 after 0 usecs
calling  wm8994_gpio_init+0x0/0x4b @ 1
initcall wm8994_gpio_init+0x0/0x4b returned 0 after 0 usecs
calling  pwm_debugfs_init+0x0/0x5a @ 1
initcall pwm_debugfs_init+0x0/0x5a returned 0 after 0 usecs
calling  pwm_sysfs_init+0x0/0x4e @ 1
initcall pwm_sysfs_init+0x0/0x4e returned 0 after 0 usecs
calling  pci_slot_init+0x0/0x60 @ 1
initcall pci_slot_init+0x0/0x60 returned 0 after 0 usecs
calling  fbmem_init+0x0/0x1a6 @ 1
initcall fbmem_init+0x0/0x1a6 returned 0 after 0 usecs
calling  acpi_init+0x0/0x2b4 @ 1
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 1 ACPI AML tables successfully acquired and loaded
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
PCI: Using E820 reservations for host bridge windows
ACPI: Enabled 2 GPEs in block 00 to 0F
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A03:00: _OSC: OS supports [Segments HPX-Type3]
acpi PNP0A03:00: PCIe port services disabled; not requesting _OSC control
acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
acpi resource window ([0x440000000-0x4bfffffff] ignored, not CPU addressable)
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x20 @ 1
pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x20 took 0 usecs
pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
pci 0000:00:01.3: calling  acpi_pm_check_blacklist+0x0/0x40 @ 1
pci 0000:00:01.3: acpi_pm_check_blacklist+0x0/0x40 took 0 usecs
pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
pci 0000:00:01.3: calling  quirk_piix4_acpi+0x0/0x230 @ 1
pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
pci 0000:00:01.3: quirk_piix4_acpi+0x0/0x230 took 1953 usecs
pci 0000:00:01.3: calling  pci_fixup_piix4_acpi+0x0/0x20 @ 1
pci 0000:00:01.3: pci_fixup_piix4_acpi+0x0/0x20 took 0 usecs
pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
pci 0000:00:02.0: calling  pci_fixup_video+0x0/0x160 @ 1
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:02.0: pci_fixup_video+0x0/0x160 took 976 usecs
pci 0000:00:03.0: calling  quirk_f0_vpd_link+0x0/0xe0 @ 1
pci 0000:00:03.0: quirk_f0_vpd_link+0x0/0xe0 took 0 usecs
pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000
pci 0000:00:04.0: reg 0x10: [mem 0xfebf1000-0xfebf100f]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI: Interrupt link LNKA configured for IRQ 10
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKC configured for IRQ 11
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKS configured for IRQ 9
initcall acpi_init+0x0/0x2b4 returned 0 after 167000 usecs
calling  pnp_init+0x0/0x49 @ 1
initcall pnp_init+0x0/0x49 returned 0 after 0 usecs
calling  regulator_fixed_voltage_init+0x0/0x4b @ 1
initcall regulator_fixed_voltage_init+0x0/0x4b returned 0 after 0 usecs
calling  aat2870_regulator_init+0x0/0x4b @ 1
initcall aat2870_regulator_init+0x0/0x4b returned 0 after 0 usecs
calling  ad5398_init+0x0/0x4b @ 1
initcall ad5398_init+0x0/0x4b returned 0 after 0 usecs
calling  da9052_regulator_init+0x0/0x4b @ 1
initcall da9052_regulator_init+0x0/0x4b returned 0 after 0 usecs
calling  da9063_regulator_init+0x0/0x4b @ 1
initcall da9063_regulator_init+0x0/0x4b returned 0 after 0 usecs
calling  isl6271a_init+0x0/0x4b @ 1
initcall isl6271a_init+0x0/0x4b returned 0 after 0 usecs
calling  lp8788_buck_init+0x0/0x4b @ 1
initcall lp8788_buck_init+0x0/0x4b returned 0 after 0 usecs
calling  lp8788_ldo_init+0x0/0x50 @ 1
initcall lp8788_ldo_init+0x0/0x50 returned 0 after 0 usecs
calling  max1586_pmic_init+0x0/0x4b @ 1
initcall max1586_pmic_init+0x0/0x4b returned 0 after 0 usecs
calling  max8649_init+0x0/0x4b @ 1
initcall max8649_init+0x0/0x4b returned 0 after 0 usecs
calling  max8952_pmic_init+0x0/0x4b @ 1
initcall max8952_pmic_init+0x0/0x4b returned 0 after 0 usecs
calling  max8973_init+0x0/0x4b @ 1
initcall max8973_init+0x0/0x4b returned 0 after 0 usecs
calling  mc13783_regulator_init+0x0/0x4b @ 1
initcall mc13783_regulator_init+0x0/0x4b returned 0 after 0 usecs
calling  mc13892_regulator_init+0x0/0x4b @ 1
initcall mc13892_regulator_init+0x0/0x4b returned 0 after 0 usecs
calling  palmas_init+0x0/0x4b @ 1
initcall palmas_init+0x0/0x4b returned 0 after 0 usecs
calling  tps51632_init+0x0/0x4b @ 1
initcall tps51632_init+0x0/0x4b returned 0 after 0 usecs
calling  rc5t583_regulator_init+0x0/0x4b @ 1
initcall rc5t583_regulator_init+0x0/0x4b returned 0 after 0 usecs
calling  tps62360_init+0x0/0x4b @ 1
initcall tps62360_init+0x0/0x4b returned 0 after 0 usecs
calling  tps_65023_init+0x0/0x4b @ 1
initcall tps_65023_init+0x0/0x4b returned 0 after 0 usecs
calling  tps65217_regulator_init+0x0/0x4b @ 1
initcall tps65217_regulator_init+0x0/0x4b returned 0 after 0 usecs
calling  tps6586x_regulator_init+0x0/0x4b @ 1
initcall tps6586x_regulator_init+0x0/0x4b returned 0 after 0 usecs
calling  twlreg_init+0x0/0x4b @ 1
initcall twlreg_init+0x0/0x4b returned 0 after 0 usecs
calling  twlreg_init+0x0/0x4b @ 1
initcall twlreg_init+0x0/0x4b returned 0 after 0 usecs
calling  wm831x_dcdc_init+0x0/0x50 @ 1
initcall wm831x_dcdc_init+0x0/0x50 returned 0 after 0 usecs
calling  wm831x_isink_init+0x0/0x91 @ 1
initcall wm831x_isink_init+0x0/0x91 returned 0 after 0 usecs
calling  wm831x_ldo_init+0x0/0x50 @ 1
initcall wm831x_ldo_init+0x0/0x50 returned 0 after 0 usecs
calling  wm8400_regulator_init+0x0/0x4b @ 1
initcall wm8400_regulator_init+0x0/0x4b returned 0 after 0 usecs
calling  misc_init+0x0/0x17e @ 1
initcall misc_init+0x0/0x17e returned 0 after 0 usecs
calling  iommu_subsys_init+0x0/0x2a0 @ 1
iommu: Default domain type: Translated 
iommu: DMA domain TLB invalidation policy: lazy mode 
initcall iommu_subsys_init+0x0/0x2a0 returned 0 after 1000 usecs
calling  dp_aux_bus_init+0x0/0x6c @ 1
initcall dp_aux_bus_init+0x0/0x6c returned 0 after 0 usecs
calling  parport_default_proc_register+0x0/0xc3 @ 1
initcall parport_default_proc_register+0x0/0xc3 returned 0 after 1000 usecs
calling  tifm_init+0x0/0x132 @ 1
initcall tifm_init+0x0/0x132 returned 0 after 1000 usecs
calling  uacce_init+0x0/0xdf @ 1
initcall uacce_init+0x0/0xdf returned 0 after 0 usecs
calling  pm805_i2c_init+0x0/0x4b @ 1
initcall pm805_i2c_init+0x0/0x4b returned 0 after 0 usecs
calling  act8945a_i2c_init+0x0/0x4b @ 1
initcall act8945a_i2c_init+0x0/0x4b returned 0 after 0 usecs
calling  sta2x11_drivers_init+0x0/0x50 @ 1
initcall sta2x11_drivers_init+0x0/0x50 returned 0 after 0 usecs
calling  tc3589x_init+0x0/0x4b @ 1
initcall tc3589x_init+0x0/0x4b returned 0 after 0 usecs
calling  wm8400_driver_init+0x0/0x91 @ 1
initcall wm8400_driver_init+0x0/0x91 returned 0 after 0 usecs
calling  wm831x_spi_init+0x0/0x8c @ 1
initcall wm831x_spi_init+0x0/0x8c returned 0 after 0 usecs
calling  tps6105x_init+0x0/0x4b @ 1
initcall tps6105x_init+0x0/0x4b returned 0 after 0 usecs
calling  tps65217_init+0x0/0x4b @ 1
initcall tps65217_init+0x0/0x4b returned 0 after 0 usecs
calling  mc13xxx_i2c_init+0x0/0x4b @ 1
initcall mc13xxx_i2c_init+0x0/0x4b returned 0 after 0 usecs
calling  da903x_init+0x0/0x4b @ 1
initcall da903x_init+0x0/0x4b returned 0 after 0 usecs
calling  da9052_i2c_init+0x0/0x91 @ 1
initcall da9052_i2c_init+0x0/0x91 returned 0 after 0 usecs
calling  lp8788_init+0x0/0x4b @ 1
initcall lp8788_init+0x0/0x4b returned 0 after 0 usecs
calling  da9055_i2c_init+0x0/0x91 @ 1
initcall da9055_i2c_init+0x0/0x91 returned 0 after 0 usecs
calling  tps6586x_init+0x0/0x4b @ 1
initcall tps6586x_init+0x0/0x4b returned 0 after 0 usecs
calling  aat2870_init+0x0/0x4b @ 1
initcall aat2870_init+0x0/0x4b returned 0 after 0 usecs
calling  palmas_i2c_init+0x0/0x4b @ 1
initcall palmas_i2c_init+0x0/0x4b returned 0 after 0 usecs
calling  rc5t583_i2c_init+0x0/0x4b @ 1
initcall rc5t583_i2c_init+0x0/0x4b returned 0 after 0 usecs
calling  lm3533_i2c_init+0x0/0x4b @ 1
initcall lm3533_i2c_init+0x0/0x4b returned 0 after 0 usecs
calling  rsmu_i2c_init+0x0/0x4b @ 1
initcall rsmu_i2c_init+0x0/0x4b returned 0 after 0 usecs
calling  dax_core_init+0x0/0x1dc @ 1
initcall dax_core_init+0x0/0x1dc returned 0 after 1000 usecs
calling  dma_buf_init+0x0/0xbf @ 1
initcall dma_buf_init+0x0/0xbf returned 0 after 0 usecs
calling  dma_resv_lockdep+0x0/0x5dc @ 1
initcall dma_resv_lockdep+0x0/0x5dc returned 0 after 0 usecs
calling  init_scsi+0x0/0x1a2 @ 1
SCSI subsystem initialized
initcall init_scsi+0x0/0x1a2 returned 0 after 2000 usecs
calling  ata_init+0x0/0xb4 @ 1
libata version 3.00 loaded.
initcall ata_init+0x0/0xb4 returned 0 after 0 usecs
calling  pxa2xx_spi_init+0x0/0x4b @ 1
initcall pxa2xx_spi_init+0x0/0x4b returned 0 after 0 usecs
calling  init_pcmcia_cs+0x0/0x7a @ 1
initcall init_pcmcia_cs+0x0/0x7a returned 0 after 0 usecs
calling  usb_common_init+0x0/0x51 @ 1
initcall usb_common_init+0x0/0x51 returned 0 after 0 usecs
calling  ulpi_init+0x0/0xa4 @ 1
initcall ulpi_init+0x0/0xa4 returned 0 after 0 usecs
calling  usb_init+0x0/0x354 @ 1
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
initcall usb_init+0x0/0x354 returned 0 after 3000 usecs
calling  usb_phy_generic_init+0x0/0x4b @ 1
initcall usb_phy_generic_init+0x0/0x4b returned 0 after 0 usecs
calling  xdbc_init+0x0/0x2a2 @ 1
initcall xdbc_init+0x0/0x2a2 returned 0 after 0 usecs
calling  usb_udc_init+0x0/0xf8 @ 1
initcall usb_udc_init+0x0/0xf8 returned 0 after 0 usecs
calling  usb_roles_init+0x0/0x7d @ 1
initcall usb_roles_init+0x0/0x7d returned 0 after 0 usecs
calling  serio_init+0x0/0x8f @ 1
initcall serio_init+0x0/0x8f returned 0 after 0 usecs
calling  gameport_init+0x0/0x8f @ 1
initcall gameport_init+0x0/0x8f returned 0 after 0 usecs
calling  input_init+0x0/0x155 @ 1
initcall input_init+0x0/0x155 returned 0 after 0 usecs
calling  dw_i2c_init_driver+0x0/0x4b @ 1
initcall dw_i2c_init_driver+0x0/0x4b returned 0 after 0 usecs
calling  i2c_gpio_init+0x0/0x8e @ 1
initcall i2c_gpio_init+0x0/0x8e returned 0 after 0 usecs
calling  i2c_adap_pxa_init+0x0/0x4b @ 1
initcall i2c_adap_pxa_init+0x0/0x4b returned 0 after 0 usecs
calling  i3c_init+0x0/0xca @ 1
initcall i3c_init+0x0/0xca returned 0 after 0 usecs
calling  rc_core_init+0x0/0x110 @ 1
initcall rc_core_init+0x0/0x110 returned 0 after 0 usecs
calling  cec_devnode_init+0x0/0x1aa @ 1
cec: Failed to create debugfs cec dir
initcall cec_devnode_init+0x0/0x1aa returned 0 after 1000 usecs
calling  power_supply_class_init+0x0/0x9c @ 1
initcall power_supply_class_init+0x0/0x9c returned 0 after 0 usecs
calling  hwmon_init+0x0/0xa5 @ 1
initcall hwmon_init+0x0/0xa5 returned 0 after 0 usecs
calling  leds_init+0x0/0x8b @ 1
initcall leds_init+0x0/0x8b returned 0 after 0 usecs
calling  intel_scu_ipc_init+0x0/0x4e @ 1
initcall intel_scu_ipc_init+0x0/0x4e returned 0 after 0 usecs
calling  remoteproc_init+0x0/0x109 @ 1
initcall remoteproc_init+0x0/0x109 returned 0 after 0 usecs
calling  glink_rpm_init+0x0/0x4b @ 1
initcall glink_rpm_init+0x0/0x4b returned 0 after 0 usecs
calling  rpmsg_init+0x0/0x95 @ 1
initcall rpmsg_init+0x0/0x95 returned 0 after 0 usecs
calling  rt8973a_muic_i2c_init+0x0/0x4b @ 1
initcall rt8973a_muic_i2c_init+0x0/0x4b returned 0 after 0 usecs
calling  ras_init+0x0/0x57 @ 1
initcall ras_init+0x0/0x57 returned 0 after 0 usecs
calling  nvmem_init+0x0/0x49 @ 1
initcall nvmem_init+0x0/0x49 returned 0 after 0 usecs
calling  sdam_init+0x0/0x4b @ 1
initcall sdam_init+0x0/0x4b returned 0 after 0 usecs
calling  fpga_mgr_class_init+0x0/0xa6 @ 1
FPGA manager framework
initcall fpga_mgr_class_init+0x0/0xa6 returned 0 after 1000 usecs
calling  fpga_bridge_dev_init+0x0/0x8b @ 1
initcall fpga_bridge_dev_init+0x0/0x8b returned 0 after 0 usecs
calling  fpga_region_init+0x0/0x8b @ 1
initcall fpga_region_init+0x0/0x8b returned 0 after 0 usecs
calling  mux_init+0x0/0xa4 @ 1
initcall mux_init+0x0/0xa4 returned 0 after 0 usecs
calling  siox_init+0x0/0x96 @ 1
initcall siox_init+0x0/0x96 returned 0 after 0 usecs
calling  counter_init+0x0/0xd2 @ 1
initcall counter_init+0x0/0xd2 returned 0 after 0 usecs
calling  init_soundcore+0x0/0x84 @ 1
initcall init_soundcore+0x0/0x84 returned 0 after 0 usecs
calling  proto_init+0x0/0x49 @ 1
initcall proto_init+0x0/0x49 returned 0 after 0 usecs
calling  net_dev_init+0x0/0x531 @ 1
initcall net_dev_init+0x0/0x531 returned 0 after 2000 usecs
calling  neigh_init+0x0/0xe9 @ 1
initcall neigh_init+0x0/0xe9 returned 0 after 0 usecs
calling  fib_notifier_init+0x0/0x49 @ 1
initcall fib_notifier_init+0x0/0x49 returned 0 after 0 usecs
calling  ethnl_init+0x0/0x112 @ 1
initcall ethnl_init+0x0/0x112 returned 0 after 0 usecs
calling  nexthop_init+0x0/0x191 @ 1
initcall nexthop_init+0x0/0x191 returned 0 after 0 usecs
calling  pci_subsys_init+0x0/0x173 @ 1
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]
initcall pci_subsys_init+0x0/0x173 returned 0 after 2000 usecs
calling  vsprintf_init_hashval+0x0/0x47 @ 1
initcall vsprintf_init_hashval+0x0/0x47 returned 0 after 0 usecs
calling  dcdbas_init+0x0/0xca @ 1
dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.4)
initcall dcdbas_init+0x0/0xca returned 0 after 2000 usecs
calling  nmi_warning_debugfs+0x0/0x5c @ 1
initcall nmi_warning_debugfs+0x0/0x5c returned 0 after 0 usecs
calling  save_microcode_in_initrd+0x0/0x110 @ 1
initcall save_microcode_in_initrd+0x0/0x110 returned 0 after 0 usecs
calling  hpet_late_init+0x0/0x1ef @ 1
initcall hpet_late_init+0x0/0x1ef returned 0 after 0 usecs
calling  iomem_init_inode+0x0/0x126 @ 1
initcall iomem_init_inode+0x0/0x126 returned 0 after 1000 usecs
calling  clocksource_done_booting+0x0/0xae @ 1
clocksource: Switched to clocksource kvm-clock
initcall clocksource_done_booting+0x0/0xae returned 0 after 2142 usecs
calling  tracer_init_tracefs+0x0/0x1ec @ 1
initcall tracer_init_tracefs+0x0/0x1ec returned 0 after 78 usecs
calling  init_trace_printk_function_export+0x0/0x92 @ 1
initcall init_trace_printk_function_export+0x0/0x92 returned 0 after 407 usecs
calling  init_kprobe_trace+0x0/0xcc @ 1
initcall init_kprobe_trace+0x0/0xcc returned 0 after 102 usecs
calling  init_dynamic_event+0x0/0x92 @ 1
initcall init_dynamic_event+0x0/0x92 returned 0 after 38 usecs
calling  init_uprobe_trace+0x0/0xf6 @ 1
initcall init_uprobe_trace+0x0/0xf6 returned 0 after 114 usecs
calling  secretmem_init+0x0/0xa2 @ 1
initcall secretmem_init+0x0/0xa2 returned 0 after 1 usecs
calling  init_fs_stat_sysctls+0x0/0x54 @ 1
initcall init_fs_stat_sysctls+0x0/0x54 returned 0 after 30 usecs
calling  init_fs_exec_sysctls+0x0/0x54 @ 1
initcall init_fs_exec_sysctls+0x0/0x54 returned 0 after 15 usecs
calling  init_pipe_fs+0x0/0xea @ 1
initcall init_pipe_fs+0x0/0xea returned 0 after 260 usecs
calling  init_fs_namei_sysctls+0x0/0x54 @ 1
initcall init_fs_namei_sysctls+0x0/0x54 returned 0 after 34 usecs
calling  init_fs_dcache_sysctls+0x0/0x54 @ 1
initcall init_fs_dcache_sysctls+0x0/0x54 returned 0 after 14 usecs
calling  init_fs_namespace_sysctls+0x0/0x54 @ 1
initcall init_fs_namespace_sysctls+0x0/0x54 returned 0 after 14 usecs
calling  inotify_user_setup+0x0/0x12a @ 1
initcall inotify_user_setup+0x0/0x12a returned 0 after 46 usecs
calling  eventpoll_init+0x0/0x150 @ 1
initcall eventpoll_init+0x0/0x150 returned 0 after 51 usecs
calling  anon_inode_init+0x0/0xb5 @ 1
initcall anon_inode_init+0x0/0xb5 returned 0 after 290 usecs
calling  proc_locks_init+0x0/0x59 @ 1
initcall proc_locks_init+0x0/0x59 returned 0 after 18 usecs
calling  init_fs_coredump_sysctls+0x0/0x54 @ 1
initcall init_fs_coredump_sysctls+0x0/0x54 returned 0 after 21 usecs
calling  iomap_init+0x0/0x57 @ 1
initcall iomap_init+0x0/0x57 returned 0 after 363 usecs
calling  dquot_init+0x0/0x22b @ 1
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
initcall dquot_init+0x0/0x22b returned 0 after 1683 usecs
calling  proc_cmdline_init+0x0/0x57 @ 1
initcall proc_cmdline_init+0x0/0x57 returned 0 after 17 usecs
calling  proc_consoles_init+0x0/0x59 @ 1
initcall proc_consoles_init+0x0/0x59 returned 0 after 15 usecs
calling  proc_cpuinfo_init+0x0/0x55 @ 1
initcall proc_cpuinfo_init+0x0/0x55 returned 0 after 13 usecs
calling  proc_devices_init+0x0/0x60 @ 1
initcall proc_devices_init+0x0/0x60 returned 0 after 13 usecs
calling  proc_interrupts_init+0x0/0x59 @ 1
initcall proc_interrupts_init+0x0/0x59 returned 0 after 27 usecs
calling  proc_loadavg_init+0x0/0x5e @ 1
initcall proc_loadavg_init+0x0/0x5e returned 0 after 12 usecs
calling  proc_meminfo_init+0x0/0x5e @ 1
initcall proc_meminfo_init+0x0/0x5e returned 0 after 12 usecs
calling  proc_stat_init+0x0/0x55 @ 1
initcall proc_stat_init+0x0/0x55 returned 0 after 13 usecs
calling  proc_uptime_init+0x0/0x5e @ 1
initcall proc_uptime_init+0x0/0x5e returned 0 after 13 usecs
calling  proc_version_init+0x0/0x5e @ 1
initcall proc_version_init+0x0/0x5e returned 0 after 12 usecs
calling  proc_softirqs_init+0x0/0x5e @ 1
initcall proc_softirqs_init+0x0/0x5e returned 0 after 11 usecs
calling  proc_kmsg_init+0x0/0x58 @ 1
initcall proc_kmsg_init+0x0/0x58 returned 0 after 13 usecs
calling  proc_page_init+0x0/0xa0 @ 1
initcall proc_page_init+0x0/0xa0 returned 0 after 25 usecs
calling  fscache_init+0x0/0x16e @ 1
FS-Cache: Loaded
initcall fscache_init+0x0/0x16e returned 0 after 575 usecs
calling  init_ramfs_fs+0x0/0x49 @ 1
initcall init_ramfs_fs+0x0/0x49 returned 0 after 6 usecs
calling  init_hugetlbfs_fs+0x0/0x342 @ 1
initcall init_hugetlbfs_fs+0x0/0x342 returned 0 after 297 usecs
calling  cachefiles_init+0x0/0x134 @ 1
CacheFiles: Loaded
initcall cachefiles_init+0x0/0x134 returned 0 after 1195 usecs
calling  dynamic_debug_init_control+0x0/0x13a @ 1
initcall dynamic_debug_init_control+0x0/0x13a returned 0 after 26 usecs
calling  acpi_event_init+0x0/0xcc @ 1
initcall acpi_event_init+0x0/0xcc returned 0 after 107 usecs
calling  pnp_system_init+0x0/0x49 @ 1
initcall pnp_system_init+0x0/0x49 returned 0 after 85 usecs
calling  pnpacpi_init+0x0/0x11c @ 1
pnp: PnP ACPI init
pnp 00:02: [dma 2]
pnp: PnP ACPI: found 7 devices
initcall pnpacpi_init+0x0/0x11c returned 0 after 6750 usecs
calling  chr_dev_init+0x0/0x1e0 @ 1
initcall chr_dev_init+0x0/0x1e0 returned 0 after 2085 usecs
calling  hwrng_modinit+0x0/0x170 @ 1
initcall hwrng_modinit+0x0/0x170 returned 0 after 315 usecs
calling  firmware_class_init+0x0/0xe0 @ 1
initcall firmware_class_init+0x0/0xe0 returned 0 after 100 usecs
calling  init_pcmcia_bus+0x0/0xfe @ 1
initcall init_pcmcia_bus+0x0/0xfe returned 0 after 143 usecs
calling  init_acpi_pm_clocksource+0x0/0x27a @ 1
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
initcall init_acpi_pm_clocksource+0x0/0x27a returned 0 after 40021 usecs
calling  ssb_modinit+0x0/0x13b @ 1
initcall ssb_modinit+0x0/0x13b returned 0 after 219 usecs
calling  bcma_init_bus_register+0x0/0x9e @ 1
initcall bcma_init_bus_register+0x0/0x9e returned 0 after 134 usecs
calling  intel_punit_ipc_init+0x0/0x4b @ 1
initcall intel_punit_ipc_init+0x0/0x4b returned 0 after 89 usecs
calling  powercap_init+0x0/0x84 @ 1
initcall powercap_init+0x0/0x84 returned 0 after 484 usecs
calling  rapl_init+0x0/0x13b @ 1
initcall rapl_init+0x0/0x13b returned 0 after 212 usecs
calling  mcb_init+0x0/0x30 @ 1
initcall mcb_init+0x0/0x30 returned 0 after 100 usecs
calling  sysctl_core_init+0x0/0x6b @ 1
initcall sysctl_core_init+0x0/0x6b returned 0 after 85 usecs
calling  eth_offload_init+0x0/0x4a @ 1
kwatchdog (35) used greatest stack depth: 7152 bytes left
initcall eth_offload_init+0x0/0x4a returned 0 after 24 usecs
calling  ipv4_offload_init+0x0/0x16a @ 1
initcall ipv4_offload_init+0x0/0x16a returned 0 after 4 usecs
calling  inet_init+0x0/0x59e @ 1
NET: Registered PF_INET protocol family
IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 512 (order: 2, 24576 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
TCP bind hash table entries: 8192 (order: 7, 786432 bytes, linear)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 3, 57344 bytes, linear)
UDP-Lite hash table entries: 512 (order: 3, 57344 bytes, linear)
initcall inet_init+0x0/0x59e returned 0 after 13965 usecs
calling  af_unix_init+0x0/0x1de @ 1
NET: Registered PF_UNIX/PF_LOCAL protocol family
initcall af_unix_init+0x0/0x1de returned 0 after 950 usecs
calling  ipv6_offload_init+0x0/0x14d @ 1
initcall ipv6_offload_init+0x0/0x14d returned 0 after 4 usecs
calling  init_sunrpc+0x0/0x1e0 @ 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
initcall init_sunrpc+0x0/0x1e0 returned 0 after 4272 usecs
calling  pcibios_assign_resources+0x0/0xc6 @ 1
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
initcall pcibios_assign_resources+0x0/0xc6 returned 0 after 4332 usecs
calling  pci_apply_final_quirks+0x0/0x281 @ 1
pci 0000:00:00.0: calling  quirk_passive_release+0x0/0xb0 @ 1
pci 0000:00:01.0: PIIX3: Enabling Passive Release
pci 0000:00:00.0: quirk_passive_release+0x0/0xb0 took 851 usecs
pci 0000:00:00.0: calling  quirk_natoma+0x0/0x20 @ 1
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
pci 0000:00:00.0: quirk_natoma+0x0/0x20 took 781 usecs
pci 0000:00:01.0: calling  quirk_isa_dma_hangs+0x0/0x20 @ 1
pci 0000:00:01.0: Activating ISA DMA hang workarounds
pci 0000:00:01.0: quirk_isa_dma_hangs+0x0/0x20 took 840 usecs
pci 0000:00:03.0: calling  quirk_e100_interrupt+0x0/0x230 @ 1
pci 0000:00:03.0: quirk_e100_interrupt+0x0/0x230 took 1 usecs
PCI: CLS 0 bytes, default 64
initcall pci_apply_final_quirks+0x0/0x281 returned 0 after 10608 usecs
calling  acpi_reserve_resources+0x0/0x1c0 @ 1
initcall acpi_reserve_resources+0x0/0x1c0 returned 0 after 97 usecs
calling  populate_rootfs+0x0/0xb2 @ 1
Unpacking initramfs...
Freeing initrd memory: 93008K
initcall populate_rootfs+0x0/0xb2 returned 0 after 9707313 usecs
calling  pci_iommu_init+0x0/0xaf @ 1
initcall pci_iommu_init+0x0/0xaf returned 0 after 2 usecs
calling  sta2x11_mfd_init+0x0/0x6f @ 1
sta2x11_mfd_init
initcall sta2x11_mfd_init+0x0/0x6f returned 0 after 642 usecs
calling  rapl_pmu_init+0x0/0x2c1 @ 1
RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
initcall rapl_pmu_init+0x0/0x2c1 returned 0 after 1516 usecs
calling  amd_ibs_init+0x0/0x1e7 @ 1
initcall amd_ibs_init+0x0/0x1e7 returned -19 after 1 usecs
calling  msr_init+0x0/0xbf @ 1
initcall msr_init+0x0/0xbf returned 0 after 25 usecs
calling  cstate_pmu_init+0x0/0x21f @ 1
initcall cstate_pmu_init+0x0/0x21f returned -19 after 1 usecs
calling  register_kernel_offset_dumper+0x0/0x4f @ 1
initcall register_kernel_offset_dumper+0x0/0x4f returned 0 after 3 usecs
calling  i8259A_init_ops+0x0/0x75 @ 1
initcall i8259A_init_ops+0x0/0x75 returned 0 after 7 usecs
calling  init_tsc_clocksource+0x0/0x18a @ 1
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fa3704c1a9, max_idle_ns: 440795296692 ns
initcall init_tsc_clocksource+0x0/0x18a returned 0 after 1358 usecs
calling  add_rtc_cmos+0x0/0x1b6 @ 1
initcall add_rtc_cmos+0x0/0x1b6 returned 0 after 4 usecs
calling  i8237A_init_ops+0x0/0x96 @ 1
initcall i8237A_init_ops+0x0/0x96 returned 0 after 14 usecs
calling  umwait_init+0x0/0x173 @ 1
initcall umwait_init+0x0/0x173 returned -19 after 1 usecs
calling  msr_init+0x0/0x19b @ 1
initcall msr_init+0x0/0x19b returned 0 after 1773 usecs
calling  ioapic_init_ops+0x0/0x4a @ 1
initcall ioapic_init_ops+0x0/0x4a returned 0 after 79 usecs
calling  add_bus_probe+0x0/0x77 @ 1
initcall add_bus_probe+0x0/0x77 returned 0 after 1 usecs
calling  pt_dump_init+0x0/0x8d @ 1
initcall pt_dump_init+0x0/0x8d returned 0 after 1 usecs
calling  pt_dump_debug_init+0x0/0xa3 @ 1
initcall pt_dump_debug_init+0x0/0xa3 returned 0 after 2 usecs
calling  twofish_glue_init+0x0/0x49 @ 1
initcall twofish_glue_init+0x0/0x49 returned 0 after 43 usecs
calling  serpent_sse2_init+0x0/0x9d @ 1
initcall serpent_sse2_init+0x0/0x9d returned 0 after 1623 usecs
calling  crc32c_intel_mod_init+0x0/0x89 @ 1
initcall crc32c_intel_mod_init+0x0/0x89 returned 0 after 17 usecs
calling  crc32_pclmul_mod_init+0x0/0xa4 @ 1
initcall crc32_pclmul_mod_init+0x0/0xa4 returned 0 after 20 usecs
calling  punit_atom_debug_init+0x0/0xdd @ 1
initcall punit_atom_debug_init+0x0/0xdd returned -19 after 1 usecs
calling  alix_init+0x0/0x196 @ 1
initcall alix_init+0x0/0x196 returned 0 after 2 usecs
calling  net5501_init+0x0/0x115 @ 1
initcall net5501_init+0x0/0x115 returned 0 after 1 usecs
calling  iris_init+0x0/0xf0 @ 1
The force parameter has not been set to 1. The Iris poweroff handler will not be installed.
initcall iris_init+0x0/0xf0 returned -19 after 1191 usecs
calling  iosf_mbi_init+0x0/0x6b @ 1
initcall iosf_mbi_init+0x0/0x6b returned 0 after 190 usecs
calling  imr_init+0x0/0x239 @ 1
initcall imr_init+0x0/0x239 returned -19 after 1 usecs
calling  proc_execdomains_init+0x0/0x57 @ 1
initcall proc_execdomains_init+0x0/0x57 returned 0 after 60 usecs
calling  register_warn_debugfs+0x0/0x5a @ 1
initcall register_warn_debugfs+0x0/0x5a returned 0 after 1 usecs
calling  cpuhp_sysfs_init+0x0/0x1a1 @ 1
initcall cpuhp_sysfs_init+0x0/0x1a1 returned 0 after 148 usecs
calling  ioresources_init+0x0/0x84 @ 1
initcall ioresources_init+0x0/0x84 returned 0 after 26 usecs
calling  lockdep_proc_init+0x0/0xd1 @ 1
initcall lockdep_proc_init+0x0/0xd1 returned 0 after 39 usecs
calling  irq_gc_init_ops+0x0/0x4a @ 1
initcall irq_gc_init_ops+0x0/0x4a returned 0 after 6 usecs
calling  irq_debugfs_init+0x0/0x12e @ 1
initcall irq_debugfs_init+0x0/0x12e returned 0 after 17 usecs
calling  proc_modules_init+0x0/0x55 @ 1
initcall proc_modules_init+0x0/0x55 returned 0 after 23 usecs
calling  timekeeping_init_ops+0x0/0x4a @ 1
initcall timekeeping_init_ops+0x0/0x4a returned 0 after 6 usecs
calling  init_clocksource_sysfs+0x0/0x86 @ 1
initcall init_clocksource_sysfs+0x0/0x86 returned 0 after 345 usecs
calling  init_timer_list_procfs+0x0/0x88 @ 1
initcall init_timer_list_procfs+0x0/0x88 returned 0 after 19 usecs
calling  alarmtimer_init+0x0/0x13a @ 1
initcall alarmtimer_init+0x0/0x13a returned 0 after 108 usecs
calling  clockevents_init_sysfs+0x0/0x81 @ 1
initcall clockevents_init_sysfs+0x0/0x81 returned 0 after 623 usecs
calling  proc_dma_init+0x0/0x57 @ 1
initcall proc_dma_init+0x0/0x57 returned 0 after 17 usecs
calling  kallsyms_init+0x0/0x58 @ 1
initcall kallsyms_init+0x0/0x58 returned 0 after 14 usecs
calling  ikconfig_init+0x0/0xa5 @ 1
initcall ikconfig_init+0x0/0xa5 returned 0 after 23 usecs
calling  gcov_init+0x0/0x49 @ 1
initcall gcov_init+0x0/0x49 returned 0 after 5 usecs
calling  gcov_fs_init+0x0/0xaa @ 1
initcall gcov_fs_init+0x0/0xaa returned 0 after 1582605 usecs
calling  utsname_sysctl_init+0x0/0x4a @ 1
initcall utsname_sysctl_init+0x0/0x4a returned 0 after 30 usecs
calling  init_tracepoints+0x0/0x8c @ 1
initcall init_tracepoints+0x0/0x8c returned 0 after 5 usecs
calling  init_lstats_procfs+0x0/0x7a @ 1
initcall init_lstats_procfs+0x0/0x7a returned 0 after 36 usecs
calling  perf_event_sysfs_init+0x0/0x198 @ 1
initcall perf_event_sysfs_init+0x0/0x198 returned 0 after 1098 usecs
calling  system_trusted_keyring_init+0x0/0x158 @ 1
Initialise system trusted keyrings
initcall system_trusted_keyring_init+0x0/0x158 returned 0 after 902 usecs
calling  blacklist_init+0x0/0x1cc @ 1
Key type blacklist registered
initcall blacklist_init+0x0/0x1cc returned 0 after 690 usecs
calling  kswapd_init+0x0/0x5a @ 1
initcall kswapd_init+0x0/0x5a returned 0 after 500 usecs
calling  mm_compute_batch_init+0x0/0x4a @ 1
initcall mm_compute_batch_init+0x0/0x4a returned 0 after 1 usecs
calling  workingset_init+0x0/0x155 @ 1
workingset: timestamp_bits=14 max_order=20 bucket_order=6
initcall workingset_init+0x0/0x155 returned 0 after 913 usecs
calling  proc_vmalloc_init+0x0/0x5c @ 1
initcall proc_vmalloc_init+0x0/0x5c returned 0 after 30 usecs
calling  procswaps_init+0x0/0x55 @ 1
initcall procswaps_init+0x0/0x55 returned 0 after 16 usecs
calling  pfn_inject_init+0x0/0x196 @ 1
initcall pfn_inject_init+0x0/0x196 returned 0 after 3 usecs
calling  fcntl_init+0x0/0x5f @ 1
initcall fcntl_init+0x0/0x5f returned 0 after 9 usecs
calling  proc_filesystems_init+0x0/0x57 @ 1
initcall proc_filesystems_init+0x0/0x57 returned 0 after 20 usecs
calling  start_dirtytime_writeback+0x0/0x4f @ 1
initcall start_dirtytime_writeback+0x0/0x4f returned 0 after 7 usecs
calling  dio_init+0x0/0x62 @ 1
initcall dio_init+0x0/0x62 returned 0 after 9 usecs
calling  mbcache_init+0x0/0x8a @ 1
initcall mbcache_init+0x0/0x8a returned 0 after 69 usecs
calling  init_grace+0x0/0x49 @ 1
initcall init_grace+0x0/0x49 returned 0 after 19 usecs
calling  init_v2_quota_format+0x0/0x84 @ 1
initcall init_v2_quota_format+0x0/0x84 returned 0 after 53 usecs
calling  init_devpts_fs+0x0/0x89 @ 1
initcall init_devpts_fs+0x0/0x89 returned 0 after 98 usecs
calling  init_reiserfs_fs+0x0/0x11a @ 1
initcall init_reiserfs_fs+0x0/0x11a returned 0 after 31 usecs
calling  ext4_init_fs+0x0/0x4c0 @ 1
initcall ext4_init_fs+0x0/0x4c0 returned 0 after 599 usecs
calling  init_ext2_fs+0x0/0x11f @ 1
initcall init_ext2_fs+0x0/0x11f returned 0 after 16 usecs
calling  journal_init+0x0/0xba @ 1
initcall journal_init+0x0/0xba returned 0 after 83 usecs
calling  init_cramfs_fs+0x0/0xb6 @ 1
initcall init_cramfs_fs+0x0/0xb6 returned 0 after 127 usecs
calling  init_squashfs_fs+0x0/0x133 @ 1
squashfs: version 4.0 (2009/01/31) Phillip Lougher
initcall init_squashfs_fs+0x0/0x133 returned 0 after 893 usecs
calling  init_fat_fs+0x0/0x116 @ 1
initcall init_fat_fs+0x0/0x116 returned 0 after 24 usecs
calling  init_vfat_fs+0x0/0x49 @ 1
initcall init_vfat_fs+0x0/0x49 returned 0 after 6 usecs
calling  init_msdos_fs+0x0/0x49 @ 1
initcall init_msdos_fs+0x0/0x49 returned 0 after 5 usecs
calling  init_bfs_fs+0x0/0x11a @ 1
initcall init_bfs_fs+0x0/0x11a returned 0 after 22 usecs
calling  init_iso9660_fs+0x0/0x168 @ 1
initcall init_iso9660_fs+0x0/0x168 returned 0 after 118 usecs
calling  init_hfs_fs+0x0/0xde @ 1
initcall init_hfs_fs+0x0/0xde returned 0 after 18 usecs
calling  ecryptfs_init+0x0/0x490 @ 1
initcall ecryptfs_init+0x0/0x490 returned 0 after 1228 usecs
calling  vxfs_init+0x0/0xe3 @ 1
initcall vxfs_init+0x0/0xe3 returned 0 after 33 usecs
calling  init_nfs_fs+0x0/0x40b @ 1
initcall init_nfs_fs+0x0/0x40b returned 0 after 1125 usecs
calling  init_nfs_v2+0x0/0x4a @ 1
initcall init_nfs_v2+0x0/0x4a returned 0 after 44 usecs
calling  init_nfs_v3+0x0/0x4a @ 1
initcall init_nfs_v3+0x0/0x4a returned 0 after 3 usecs
calling  init_nlm+0x0/0x11b @ 1
initcall init_nlm+0x0/0x11b returned 0 after 106 usecs
calling  init_nls_cp437+0x0/0x4b @ 1
initcall init_nls_cp437+0x0/0x4b returned 0 after 45 usecs
calling  init_nls_cp775+0x0/0x4b @ 1
initcall init_nls_cp775+0x0/0x4b returned 0 after 2 usecs
calling  init_nls_cp850+0x0/0x4b @ 1
initcall init_nls_cp850+0x0/0x4b returned 0 after 2 usecs
calling  init_nls_cp852+0x0/0x4b @ 1
initcall init_nls_cp852+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp857+0x0/0x4b @ 1
initcall init_nls_cp857+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp860+0x0/0x4b @ 1
initcall init_nls_cp860+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp861+0x0/0x4b @ 1
initcall init_nls_cp861+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp862+0x0/0x4b @ 1
initcall init_nls_cp862+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp863+0x0/0x4b @ 1
initcall init_nls_cp863+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp864+0x0/0x4b @ 1
initcall init_nls_cp864+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp866+0x0/0x4b @ 1
initcall init_nls_cp866+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp869+0x0/0x4b @ 1
initcall init_nls_cp869+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp874+0x0/0x4b @ 1
initcall init_nls_cp874+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp932+0x0/0x4b @ 1
initcall init_nls_cp932+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_euc_jp+0x0/0xa1 @ 1
initcall init_nls_euc_jp+0x0/0xa1 returned 0 after 5 usecs
calling  init_nls_cp936+0x0/0x4b @ 1
initcall init_nls_cp936+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp949+0x0/0x4b @ 1
initcall init_nls_cp949+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp950+0x0/0x4b @ 1
initcall init_nls_cp950+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp1250+0x0/0x4b @ 1
initcall init_nls_cp1250+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_cp1251+0x0/0x4b @ 1
initcall init_nls_cp1251+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_ascii+0x0/0x4b @ 1
initcall init_nls_ascii+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_iso8859_2+0x0/0x4b @ 1
initcall init_nls_iso8859_2+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_iso8859_3+0x0/0x4b @ 1
initcall init_nls_iso8859_3+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_iso8859_5+0x0/0x4b @ 1
initcall init_nls_iso8859_5+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_iso8859_6+0x0/0x4b @ 1
initcall init_nls_iso8859_6+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_iso8859_7+0x0/0x4b @ 1
initcall init_nls_iso8859_7+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_iso8859_9+0x0/0x4b @ 1
initcall init_nls_iso8859_9+0x0/0x4b returned 0 after 4 usecs
calling  init_nls_iso8859_13+0x0/0x4b @ 1
initcall init_nls_iso8859_13+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_iso8859_14+0x0/0x4b @ 1
initcall init_nls_iso8859_14+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_iso8859_15+0x0/0x4b @ 1
initcall init_nls_iso8859_15+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_koi8_r+0x0/0x4b @ 1
initcall init_nls_koi8_r+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_koi8_u+0x0/0x4b @ 1
initcall init_nls_koi8_u+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_koi8_ru+0x0/0xa1 @ 1
initcall init_nls_koi8_ru+0x0/0xa1 returned 0 after 5 usecs
calling  init_nls_utf8+0x0/0xac @ 1
initcall init_nls_utf8+0x0/0xac returned 0 after 5 usecs
calling  init_nls_maccyrillic+0x0/0x4b @ 1
initcall init_nls_maccyrillic+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_macgaelic+0x0/0x4b @ 1
initcall init_nls_macgaelic+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_maciceland+0x0/0x4b @ 1
initcall init_nls_maciceland+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_macinuit+0x0/0x4b @ 1
initcall init_nls_macinuit+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_macromanian+0x0/0x4b @ 1
initcall init_nls_macromanian+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_macroman+0x0/0x4b @ 1
initcall init_nls_macroman+0x0/0x4b returned 0 after 3 usecs
calling  init_nls_macturkish+0x0/0x4b @ 1
initcall init_nls_macturkish+0x0/0x4b returned 0 after 3 usecs
calling  init_sysv_fs+0x0/0x10d @ 1
initcall init_sysv_fs+0x0/0x10d returned 0 after 31 usecs
calling  init_hpfs_fs+0x0/0x105 @ 1
initcall init_hpfs_fs+0x0/0x105 returned 0 after 19 usecs
calling  init_ntfs_fs+0x0/0x45c @ 1
ntfs: driver 2.1.32 [Flags: R/O DEBUG].
initcall init_ntfs_fs+0x0/0x45c returned 0 after 769 usecs
calling  init_ntfs_fs+0x0/0x17c @ 1
ntfs3: Max link count 4000
ntfs3: Enabled Linux POSIX ACLs support
ntfs3: Read-only LZX/Xpress compression included
initcall init_ntfs_fs+0x0/0x17c returned 0 after 2106 usecs
calling  init_efs_fs+0x0/0x11d @ 1
efs: 1.0a - http://aeschi.ch.eu.org/efs/
initcall init_efs_fs+0x0/0x11d returned 0 after 731 usecs
calling  init_affs_fs+0x0/0x11a @ 1
initcall init_affs_fs+0x0/0x11a returned 0 after 19 usecs
calling  init_romfs_fs+0x0/0x129 @ 1
romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
initcall init_romfs_fs+0x0/0x129 returned 0 after 730 usecs
calling  init_qnx4_fs+0x0/0x133 @ 1
QNX4 filesystem 0.2.3 registered.
initcall init_qnx4_fs+0x0/0x133 returned 0 after 671 usecs
calling  init_qnx6_fs+0x0/0x133 @ 1
qnx6: QNX6 filesystem 1.0.0 registered.
initcall init_qnx6_fs+0x0/0x133 returned 0 after 714 usecs
calling  init_adfs_fs+0x0/0x11a @ 1
initcall init_adfs_fs+0x0/0x11a returned 0 after 17 usecs
calling  ovl_init+0x0/0x12c @ 1
initcall ovl_init+0x0/0x12c returned 0 after 21 usecs
calling  orangefs_init+0x0/0x3ad @ 1
orangefs_debugfs_init: called with debug mask: :none: :0:
orangefs_init: module version upstream loaded
initcall orangefs_init+0x0/0x3ad returned 0 after 2316 usecs
calling  init_udf_fs+0x0/0x119 @ 1
initcall init_udf_fs+0x0/0x119 returned 0 after 19 usecs
calling  init_jfs_fs+0x0/0x52f @ 1
JFS: nTxBlock = 8192, nTxLock = 65536
initcall init_jfs_fs+0x0/0x52f returned 0 after 15922 usecs
calling  init_xfs_fs+0x0/0x470 @ 1
SGI XFS with ACLs, security attributes, scrub, repair, no debug enabled
initcall init_xfs_fs+0x0/0x470 returned 0 after 2131 usecs
calling  init_nilfs_fs+0x0/0x122 @ 1
NILFS version 2 loaded
initcall init_nilfs_fs+0x0/0x122 returned 0 after 619 usecs
calling  init_befs_fs+0x0/0x12a @ 1
befs: version: 0.9.3
initcall init_befs_fs+0x0/0x12a returned 0 after 533 usecs
calling  init_gfs2_fs+0x0/0x7b3 @ 1
gfs2: GFS2 installed
initcall init_gfs2_fs+0x0/0x7b3 returned 0 after 3021 usecs
calling  init_f2fs_fs+0x0/0x4ae @ 1
initcall init_f2fs_fs+0x0/0x4ae returned 0 after 1308 usecs
calling  ipc_init+0x0/0x85 @ 1
initcall ipc_init+0x0/0x85 returned 0 after 97 usecs
calling  ipc_sysctl_init+0x0/0x8e @ 1
initcall ipc_sysctl_init+0x0/0x8e returned 0 after 65 usecs
calling  key_proc_init+0x0/0xc5 @ 1
initcall key_proc_init+0x0/0xc5 returned 0 after 23 usecs
calling  crc64_rocksoft_init+0x0/0x49 @ 1
initcall crc64_rocksoft_init+0x0/0x49 returned 0 after 31 usecs
calling  jent_mod_init+0x0/0xa1 @ 1
initcall jent_mod_init+0x0/0xa1 returned 0 after 23336 usecs
calling  asymmetric_key_init+0x0/0x49 @ 1
Key type asymmetric registered
initcall asymmetric_key_init+0x0/0x49 returned 0 after 615 usecs
calling  x509_key_init+0x0/0x50 @ 1
Asymmetric key parser 'x509' registered
initcall x509_key_init+0x0/0x50 returned 0 after 798 usecs
calling  pkcs8_key_init+0x0/0x49 @ 1
Asymmetric key parser 'pkcs8' registered
initcall pkcs8_key_init+0x0/0x49 returned 0 after 710 usecs
calling  blkdev_init+0x0/0x57 @ 1
initcall blkdev_init+0x0/0x57 returned 0 after 125 usecs
calling  proc_genhd_init+0x0/0x7e @ 1
initcall proc_genhd_init+0x0/0x7e returned 0 after 86 usecs
calling  bsg_init+0x0/0x131 @ 1
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
initcall bsg_init+0x0/0x131 returned 0 after 1087 usecs
calling  deadline_init+0x0/0x49 @ 1
io scheduler mq-deadline registered
initcall deadline_init+0x0/0x49 returned 0 after 734 usecs
calling  kyber_init+0x0/0x49 @ 1
io scheduler kyber registered
initcall kyber_init+0x0/0x49 returned 0 after 633 usecs
calling  bfq_init+0x0/0x135 @ 1
io scheduler bfq registered
initcall bfq_init+0x0/0x135 returned 0 after 633 usecs
calling  io_uring_init+0x0/0x75 @ 1
initcall io_uring_init+0x0/0x75 returned 0 after 11 usecs
calling  primes_init+0x0/0x49 @ 1
initcall primes_init+0x0/0x49 returned 0 after 2 usecs
calling  blake2s_mod_init+0x0/0x2e @ 1
initcall blake2s_mod_init+0x0/0x2e returned 0 after 1 usecs
calling  chacha20poly1305_init+0x0/0x2e @ 1
initcall chacha20poly1305_init+0x0/0x2e returned 0 after 1 usecs
calling  crc_t10dif_mod_init+0x0/0xb6 @ 1
initcall crc_t10dif_mod_init+0x0/0xb6 returned 0 after 889 usecs
calling  libcrc32c_mod_init+0x0/0x7a @ 1
initcall libcrc32c_mod_init+0x0/0x7a returned 0 after 1033 usecs
calling  crc64_rocksoft_mod_init+0x0/0xb6 @ 1
initcall crc64_rocksoft_mod_init+0x0/0xb6 returned 0 after 826 usecs
calling  percpu_counter_startup+0x0/0xf3 @ 1
initcall percpu_counter_startup+0x0/0xf3 returned 0 after 400 usecs
calling  madera_irq_driver_init+0x0/0x4b @ 1
initcall madera_irq_driver_init+0x0/0x4b returned 0 after 130 usecs
calling  simple_pm_bus_driver_init+0x0/0x4b @ 1
initcall simple_pm_bus_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  phy_core_init+0x0/0xa6 @ 1
initcall phy_core_init+0x0/0xa6 returned 0 after 65 usecs
calling  lgm_phy_driver_init+0x0/0x4b @ 1
initcall lgm_phy_driver_init+0x0/0x4b returned 0 after 153 usecs
calling  bcm_kona_usb2_driver_init+0x0/0x4b @ 1
initcall bcm_kona_usb2_driver_init+0x0/0x4b returned 0 after 206 usecs
calling  cdns_torrent_phy_driver_init+0x0/0x4b @ 1
initcall cdns_torrent_phy_driver_init+0x0/0x4b returned 0 after 99 usecs
calling  cdns_dphy_platform_driver_init+0x0/0x4b @ 1
initcall cdns_dphy_platform_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  cdns_salvo_phy_driver_init+0x0/0x4b @ 1
initcall cdns_salvo_phy_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  intel_emmc_driver_init+0x0/0x4b @ 1
initcall intel_emmc_driver_init+0x0/0x4b returned 0 after 99 usecs
calling  mv_hsic_phy_driver_init+0x0/0x4b @ 1
initcall mv_hsic_phy_driver_init+0x0/0x4b returned 0 after 161 usecs
calling  mv_usb2_phy_driver_init+0x0/0x4b @ 1
initcall mv_usb2_phy_driver_init+0x0/0x4b returned 0 after 165 usecs
calling  phy_mdm6600_driver_init+0x0/0x4b @ 1
initcall phy_mdm6600_driver_init+0x0/0x4b returned 0 after 92 usecs
calling  mscc_ocelot_serdes_init+0x0/0x4b @ 1
initcall mscc_ocelot_serdes_init+0x0/0x4b returned 0 after 136 usecs
calling  tusb1210_driver_init+0x0/0x4b @ 1
initcall tusb1210_driver_init+0x0/0x4b returned 0 after 92 usecs
calling  max77620_pinctrl_driver_init+0x0/0x4b @ 1
initcall max77620_pinctrl_driver_init+0x0/0x4b returned 0 after 105 usecs
calling  microchip_sgpio_pinctrl_driver_init+0x0/0x4b @ 1
initcall microchip_sgpio_pinctrl_driver_init+0x0/0x4b returned 0 after 84 usecs
calling  palmas_pinctrl_driver_init+0x0/0x4b @ 1
initcall palmas_pinctrl_driver_init+0x0/0x4b returned 0 after 104 usecs
calling  madera_pin_driver_init+0x0/0x4b @ 1
initcall madera_pin_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  bgpio_driver_init+0x0/0x4b @ 1
initcall bgpio_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  dio48e_driver_init+0x0/0xa1 @ 1
initcall dio48e_driver_init+0x0/0xa1 returned -19 after 228 usecs
calling  idi_48_driver_init+0x0/0xa1 @ 1
initcall idi_48_driver_init+0x0/0xa1 returned -19 after 165 usecs
calling  idio_16_driver_init+0x0/0xa1 @ 1
initcall idio_16_driver_init+0x0/0xa1 returned -19 after 197 usecs
calling  gen_74x164_driver_init+0x0/0x4b @ 1
initcall gen_74x164_driver_init+0x0/0x4b returned 0 after 222 usecs
calling  mmio_74xx_gpio_driver_init+0x0/0x4b @ 1
initcall mmio_74xx_gpio_driver_init+0x0/0x4b returned 0 after 104 usecs
calling  adnp_i2c_driver_init+0x0/0x4b @ 1
initcall adnp_i2c_driver_init+0x0/0x4b returned 0 after 172 usecs
calling  adp5520_gpio_driver_init+0x0/0x4b @ 1
initcall adp5520_gpio_driver_init+0x0/0x4b returned 0 after 105 usecs
calling  gpio_aggregator_init+0x0/0x4b @ 1
initcall gpio_aggregator_init+0x0/0x4b returned 0 after 115 usecs
calling  arizona_gpio_driver_init+0x0/0x4b @ 1
initcall arizona_gpio_driver_init+0x0/0x4b returned 0 after 108 usecs
calling  bd9571mwv_gpio_driver_init+0x0/0x4b @ 1
initcall bd9571mwv_gpio_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  cdns_gpio_driver_init+0x0/0x4b @ 1
initcall cdns_gpio_driver_init+0x0/0x4b returned 0 after 105 usecs
calling  da9052_gpio_driver_init+0x0/0x4b @ 1
initcall da9052_gpio_driver_init+0x0/0x4b returned 0 after 100 usecs
calling  ftgpio_gpio_driver_init+0x0/0x4b @ 1
initcall ftgpio_gpio_driver_init+0x0/0x4b returned 0 after 114 usecs
calling  gpiomm_driver_init+0x0/0x4f @ 1
initcall gpiomm_driver_init+0x0/0x4f returned -19 after 173 usecs
calling  gw_pld_driver_init+0x0/0x4b @ 1
initcall gw_pld_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  hlwd_gpio_driver_init+0x0/0x4b @ 1
initcall hlwd_gpio_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  ichx_gpio_driver_init+0x0/0x4b @ 1
initcall ichx_gpio_driver_init+0x0/0x4b returned 0 after 130 usecs
calling  it87_gpio_init+0x0/0x665 @ 1
gpio_it87: no device
initcall it87_gpio_init+0x0/0x665 returned -19 after 573 usecs
calling  kempld_gpio_driver_init+0x0/0x4b @ 1
initcall kempld_gpio_driver_init+0x0/0x4b returned 0 after 125 usecs
calling  madera_gpio_driver_init+0x0/0x4b @ 1
initcall madera_gpio_driver_init+0x0/0x4b returned 0 after 112 usecs
calling  max77620_gpio_driver_init+0x0/0x4b @ 1
initcall max77620_gpio_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  mb86s70_gpio_driver_init+0x0/0x4b @ 1
initcall mb86s70_gpio_driver_init+0x0/0x4b returned 0 after 119 usecs
calling  men_z127_driver_init+0x0/0x50 @ 1
initcall men_z127_driver_init+0x0/0x50 returned 0 after 180 usecs
calling  gpio_mockup_init+0x0/0x250 @ 1
initcall gpio_mockup_init+0x0/0x250 returned 0 after 145 usecs
calling  pch_gpio_driver_init+0x0/0x50 @ 1
initcall pch_gpio_driver_init+0x0/0x50 returned 0 after 162 usecs
calling  idio_16_driver_init+0x0/0x50 @ 1
initcall idio_16_driver_init+0x0/0x50 returned 0 after 143 usecs
calling  sch311x_gpio_init+0x0/0x1a3 @ 1
initcall sch311x_gpio_init+0x0/0x1a3 returned -19 after 97 usecs
calling  gpio_sim_init+0x0/0x156 @ 1
initcall gpio_sim_init+0x0/0x156 returned 0 after 532 usecs
calling  sdv_gpio_driver_init+0x0/0x50 @ 1
initcall sdv_gpio_driver_init+0x0/0x50 returned 0 after 132 usecs
calling  syscon_gpio_driver_init+0x0/0x4b @ 1
initcall syscon_gpio_driver_init+0x0/0x4b returned 0 after 104 usecs
calling  tpic2810_driver_init+0x0/0x4b @ 1
initcall tpic2810_driver_init+0x0/0x4b returned 0 after 95 usecs
calling  tps65086_gpio_driver_init+0x0/0x4b @ 1
initcall tps65086_gpio_driver_init+0x0/0x4b returned 0 after 101 usecs
calling  virtio_gpio_driver_init+0x0/0x49 @ 1
initcall virtio_gpio_driver_init+0x0/0x49 returned 0 after 86 usecs
calling  winbond_gpio_idriver_init+0x0/0x4e @ 1
gpio_winbond: chip ID at 2e is ffff
gpio_winbond: not an our chip
gpio_winbond: chip ID at 4e is ffff
gpio_winbond: not an our chip
initcall winbond_gpio_idriver_init+0x0/0x4e returned -19 after 3184 usecs
calling  ws16c48_driver_init+0x0/0xa1 @ 1
initcall ws16c48_driver_init+0x0/0xa1 returned -19 after 152 usecs
calling  pci_proc_init+0x0/0xe1 @ 1
initcall pci_proc_init+0x0/0xe1 returned 0 after 163 usecs
calling  pci_stub_init+0x0/0x2a5 @ 1
initcall pci_stub_init+0x0/0x2a5 returned 0 after 155 usecs
calling  pf_stub_driver_init+0x0/0x50 @ 1
initcall pf_stub_driver_init+0x0/0x50 returned 0 after 147 usecs
calling  gen_pci_driver_init+0x0/0x4b @ 1
initcall gen_pci_driver_init+0x0/0x4b returned 0 after 116 usecs
calling  switchtec_init+0x0/0x163 @ 1
switchtec: loaded.
initcall switchtec_init+0x0/0x163 returned 0 after 784 usecs
calling  ams369fg06_driver_init+0x0/0x4b @ 1
initcall ams369fg06_driver_init+0x0/0x4b returned 0 after 95 usecs
calling  hx8357_driver_init+0x0/0x4b @ 1
SPI driver hx8357 has no spi_device_id for himax,hx8369
initcall hx8357_driver_init+0x0/0x4b returned 0 after 978 usecs
calling  ili922x_driver_init+0x0/0x4b @ 1
initcall ili922x_driver_init+0x0/0x4b returned 0 after 94 usecs
calling  lms501kf03_driver_init+0x0/0x4b @ 1
initcall lms501kf03_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  otm3225a_driver_init+0x0/0x4b @ 1
initcall otm3225a_driver_init+0x0/0x4b returned 0 after 129 usecs
calling  tdo24m_driver_init+0x0/0x4b @ 1
initcall tdo24m_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  adp5520_bl_driver_init+0x0/0x4b @ 1
initcall adp5520_bl_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  adp8860_driver_init+0x0/0x4b @ 1
initcall adp8860_driver_init+0x0/0x4b returned 0 after 99 usecs
calling  adp8870_driver_init+0x0/0x4b @ 1
initcall adp8870_driver_init+0x0/0x4b returned 0 after 108 usecs
calling  bd6107_driver_init+0x0/0x4b @ 1
initcall bd6107_driver_init+0x0/0x4b returned 0 after 101 usecs
calling  da903x_backlight_driver_init+0x0/0x4b @ 1
initcall da903x_backlight_driver_init+0x0/0x4b returned 0 after 101 usecs
calling  da9052_wled_driver_init+0x0/0x4b @ 1
initcall da9052_wled_driver_init+0x0/0x4b returned 0 after 92 usecs
calling  gpio_backlight_driver_init+0x0/0x4b @ 1
initcall gpio_backlight_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  ktd253_backlight_driver_init+0x0/0x4b @ 1
initcall ktd253_backlight_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  lm3639_i2c_driver_init+0x0/0x4b @ 1
initcall lm3639_i2c_driver_init+0x0/0x4b returned 0 after 196 usecs
calling  lv5207lp_driver_init+0x0/0x4b @ 1
initcall lv5207lp_driver_init+0x0/0x4b returned 0 after 153 usecs
calling  wled_driver_init+0x0/0x4b @ 1
initcall wled_driver_init+0x0/0x4b returned 0 after 107 usecs
calling  sky81452_bl_driver_init+0x0/0x4b @ 1
initcall sky81452_bl_driver_init+0x0/0x4b returned 0 after 122 usecs
calling  tps65217_bl_driver_init+0x0/0x4b @ 1
initcall tps65217_bl_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  wm831x_backlight_driver_init+0x0/0x4b @ 1
initcall wm831x_backlight_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  arcxcnn_driver_init+0x0/0x4b @ 1
initcall arcxcnn_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  led_bl_driver_init+0x0/0x4b @ 1
initcall led_bl_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  arcfb_init+0x0/0x14b @ 1
initcall arcfb_init+0x0/0x14b returned -6 after 1 usecs
calling  pm2fb_init+0x0/0xd1 @ 1
initcall pm2fb_init+0x0/0xd1 returned 0 after 150 usecs
calling  pm3fb_init+0x0/0xd1 @ 1
initcall pm3fb_init+0x0/0xd1 returned 0 after 177 usecs
calling  i740fb_init+0x0/0xd0 @ 1
initcall i740fb_init+0x0/0xd0 returned 0 after 251 usecs
calling  rivafb_init+0x0/0x70 @ 1
rivafb_setup START
initcall rivafb_init+0x0/0x70 returned 0 after 615 usecs
calling  nvidiafb_init+0x0/0x70 @ 1
nvidiafb_setup START
initcall nvidiafb_init+0x0/0x70 returned 0 after 637 usecs
calling  atyfb_init+0x0/0xf7 @ 1
initcall atyfb_init+0x0/0xf7 returned 0 after 129 usecs
calling  aty128fb_init+0x0/0xb0 @ 1
initcall aty128fb_init+0x0/0xb0 returned 0 after 217 usecs
calling  sisfb_init+0x0/0xd1 @ 1
initcall sisfb_init+0x0/0xd1 returned 0 after 153 usecs
calling  via_core_init+0x0/0xac @ 1
VIA Graphics Integration Chipset framebuffer 2.4 initializing
initcall via_core_init+0x0/0xac returned 0 after 1241 usecs
calling  kyrofb_init+0x0/0xd1 @ 1
initcall kyrofb_init+0x0/0xd1 returned 0 after 128 usecs
calling  savagefb_init+0x0/0x16d @ 1
initcall savagefb_init+0x0/0x16d returned 0 after 122 usecs
calling  neofb_init+0x0/0xd1 @ 1
initcall neofb_init+0x0/0xd1 returned 0 after 189 usecs
calling  imsttfb_init+0x0/0xd1 @ 1
initcall imsttfb_init+0x0/0xd1 returned 0 after 146 usecs
calling  vt8623fb_init+0x0/0x167 @ 1
initcall vt8623fb_init+0x0/0x167 returned 0 after 162 usecs
calling  arkfb_init+0x0/0x167 @ 1
initcall arkfb_init+0x0/0x167 returned 0 after 168 usecs
calling  sstfb_init+0x0/0xb0 @ 1
initcall sstfb_init+0x0/0xb0 returned 0 after 162 usecs
calling  goldfish_fb_driver_init+0x0/0x4b @ 1
initcall goldfish_fb_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  cirrusfb_init+0x0/0xd1 @ 1
initcall cirrusfb_init+0x0/0xd1 returned 0 after 144 usecs
calling  s1d13xxxfb_init+0x0/0x8d @ 1
initcall s1d13xxxfb_init+0x0/0x8d returned 0 after 110 usecs
calling  sm501fb_driver_init+0x0/0x4b @ 1
initcall sm501fb_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  carminefb_init+0x0/0x98 @ 1
initcall carminefb_init+0x0/0x98 returned 0 after 240 usecs
calling  mb862xxfb_init+0x0/0x40 @ 1
initcall mb862xxfb_init+0x0/0x40 returned 0 after 129 usecs
calling  vesafb_driver_init+0x0/0x4b @ 1
initcall vesafb_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  ssd1307fb_driver_init+0x0/0x4b @ 1
initcall ssd1307fb_driver_init+0x0/0x4b returned 0 after 99 usecs
calling  vfb_init+0x0/0x2dd @ 1
initcall vfb_init+0x0/0x2dd returned -6 after 2 usecs
calling  ipmb_driver_init+0x0/0x4b @ 1
initcall ipmb_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  ged_driver_init+0x0/0x4b @ 1
initcall ged_driver_init+0x0/0x4b returned 0 after 117 usecs
calling  acpi_ac_init+0x0/0xd8 @ 1
initcall acpi_ac_init+0x0/0xd8 returned 0 after 343 usecs
calling  acpi_button_driver_init+0x0/0xc1 @ 1
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
initcall acpi_button_driver_init+0x0/0xc1 returned 0 after 2639 usecs
calling  acpi_fan_driver_init+0x0/0x4b @ 1
initcall acpi_fan_driver_init+0x0/0x4b returned 0 after 184 usecs
calling  acpi_processor_driver_init+0x0/0x1a5 @ 1
initcall acpi_processor_driver_init+0x0/0x1a5 returned 0 after 1031 usecs
calling  acpi_thermal_init+0x0/0x11b @ 1
initcall acpi_thermal_init+0x0/0x11b returned 0 after 640 usecs
calling  acpi_battery_init+0x0/0x8a @ 1
initcall acpi_battery_init+0x0/0x8a returned 0 after 27 usecs
calling  of_fixed_factor_clk_driver_init+0x0/0x4b @ 1
initcall of_fixed_factor_clk_driver_init+0x0/0x4b returned 0 after 579 usecs
calling  of_fixed_clk_driver_init+0x0/0x4b @ 1
initcall of_fixed_clk_driver_init+0x0/0x4b returned 0 after 109 usecs
calling  gpio_clk_driver_init+0x0/0x4b @ 1
initcall gpio_clk_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  lmk04832_driver_init+0x0/0x4b @ 1
initcall lmk04832_driver_init+0x0/0x4b returned 0 after 89 usecs
calling  max77686_clk_driver_init+0x0/0x4b @ 1
initcall max77686_clk_driver_init+0x0/0x4b returned 0 after 108 usecs
calling  max9485_driver_init+0x0/0x4b @ 1
initcall max9485_driver_init+0x0/0x4b returned 0 after 94 usecs
calling  s2mps11_clk_driver_init+0x0/0x4b @ 1
initcall s2mps11_clk_driver_init+0x0/0x4b returned 0 after 172 usecs
calling  si5341_driver_init+0x0/0x4b @ 1
initcall si5341_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  si514_driver_init+0x0/0x4b @ 1
initcall si514_driver_init+0x0/0x4b returned 0 after 86 usecs
calling  si544_driver_init+0x0/0x4b @ 1
initcall si544_driver_init+0x0/0x4b returned 0 after 182 usecs
calling  si570_driver_init+0x0/0x4b @ 1
initcall si570_driver_init+0x0/0x4b returned 0 after 88 usecs
calling  rs9_driver_init+0x0/0x4b @ 1
initcall rs9_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  vc5_driver_init+0x0/0x4b @ 1
initcall vc5_driver_init+0x0/0x4b returned 0 after 107 usecs
calling  vc7_i2c_driver_init+0x0/0x4b @ 1
initcall vc7_i2c_driver_init+0x0/0x4b returned 0 after 126 usecs
calling  wm831x_clk_driver_init+0x0/0x4b @ 1
initcall wm831x_clk_driver_init+0x0/0x4b returned 0 after 142 usecs
calling  lgm_cgu_driver_init+0x0/0x4b @ 1
initcall lgm_cgu_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  xvcu_driver_init+0x0/0x4b @ 1
initcall xvcu_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  litex_soc_ctrl_driver_init+0x0/0x4b @ 1
initcall litex_soc_ctrl_driver_init+0x0/0x4b returned 0 after 116 usecs
calling  virtio_mmio_init+0x0/0x4b @ 1
initcall virtio_mmio_init+0x0/0x4b returned 0 after 106 usecs
calling  virtio_balloon_driver_init+0x0/0x49 @ 1
initcall virtio_balloon_driver_init+0x0/0x49 returned 0 after 83 usecs
calling  virtio_input_driver_init+0x0/0x49 @ 1
initcall virtio_input_driver_init+0x0/0x49 returned 0 after 98 usecs
calling  pg86x_regulator_driver_init+0x0/0x4b @ 1
initcall pg86x_regulator_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  cpcap_regulator_driver_init+0x0/0x4b @ 1
initcall cpcap_regulator_driver_init+0x0/0x4b returned 0 after 110 usecs
calling  act8865_pmic_driver_init+0x0/0x4b @ 1
initcall act8865_pmic_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  act8945a_pmic_driver_init+0x0/0x4b @ 1
initcall act8945a_pmic_driver_init+0x0/0x4b returned 0 after 113 usecs
calling  atc260x_regulator_driver_init+0x0/0x4b @ 1
initcall atc260x_regulator_driver_init+0x0/0x4b returned 0 after 107 usecs
calling  bd9571mwv_regulator_driver_init+0x0/0x4b @ 1
initcall bd9571mwv_regulator_driver_init+0x0/0x4b returned 0 after 104 usecs
calling  da9121_regulator_driver_init+0x0/0x4b @ 1
initcall da9121_regulator_driver_init+0x0/0x4b returned 0 after 108 usecs
calling  da9210_regulator_driver_init+0x0/0x4b @ 1
initcall da9210_regulator_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  da9211_regulator_driver_init+0x0/0x4b @ 1
initcall da9211_regulator_driver_init+0x0/0x4b returned 0 after 88 usecs
calling  fan53555_regulator_driver_init+0x0/0x4b @ 1
initcall fan53555_regulator_driver_init+0x0/0x4b returned 0 after 94 usecs
calling  fan53880_regulator_driver_init+0x0/0x4b @ 1
initcall fan53880_regulator_driver_init+0x0/0x4b returned 0 after 92 usecs
calling  hi6421_regulator_driver_init+0x0/0x4b @ 1
initcall hi6421_regulator_driver_init+0x0/0x4b returned 0 after 110 usecs
calling  hi6421v530_regulator_driver_init+0x0/0x4b @ 1
initcall hi6421v530_regulator_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  hi6421_spmi_regulator_driver_init+0x0/0x4b @ 1
initcall hi6421_spmi_regulator_driver_init+0x0/0x4b returned 0 after 106 usecs
calling  isl9305_regulator_driver_init+0x0/0x4b @ 1
initcall isl9305_regulator_driver_init+0x0/0x4b returned 0 after 147 usecs
calling  lp3971_i2c_driver_init+0x0/0x4b @ 1
initcall lp3971_i2c_driver_init+0x0/0x4b returned 0 after 186 usecs
calling  lp872x_driver_init+0x0/0x4b @ 1
initcall lp872x_driver_init+0x0/0x4b returned 0 after 105 usecs
calling  lp873x_regulator_driver_init+0x0/0x4b @ 1
initcall lp873x_regulator_driver_init+0x0/0x4b returned 0 after 108 usecs
calling  ltc3589_driver_init+0x0/0x4b @ 1
initcall ltc3589_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  ltc3676_driver_init+0x0/0x4b @ 1
initcall ltc3676_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  max77620_regulator_driver_init+0x0/0x4b @ 1
initcall max77620_regulator_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  max8893_driver_init+0x0/0x4b @ 1
initcall max8893_driver_init+0x0/0x4b returned 0 after 95 usecs
calling  max20086_regulator_driver_init+0x0/0x4b @ 1
initcall max20086_regulator_driver_init+0x0/0x4b returned 0 after 88 usecs
calling  max77686_pmic_driver_init+0x0/0x4b @ 1
initcall max77686_pmic_driver_init+0x0/0x4b returned 0 after 138 usecs
calling  max77802_pmic_driver_init+0x0/0x4b @ 1
initcall max77802_pmic_driver_init+0x0/0x4b returned 0 after 118 usecs
calling  max77826_regulator_driver_init+0x0/0x4b @ 1
initcall max77826_regulator_driver_init+0x0/0x4b returned 0 after 113 usecs
calling  mcp16502_drv_init+0x0/0x4b @ 1
initcall mcp16502_drv_init+0x0/0x4b returned 0 after 95 usecs
calling  mp5416_regulator_driver_init+0x0/0x4b @ 1
initcall mp5416_regulator_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  mp8859_regulator_driver_init+0x0/0x4b @ 1
initcall mp8859_regulator_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  mp886x_regulator_driver_init+0x0/0x4b @ 1
initcall mp886x_regulator_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  mt6315_regulator_driver_init+0x0/0x4b @ 1
initcall mt6315_regulator_driver_init+0x0/0x4b returned 0 after 113 usecs
calling  mt6360_regulator_driver_init+0x0/0x4b @ 1
initcall mt6360_regulator_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  mt6370_regulator_driver_init+0x0/0x4b @ 1
initcall mt6370_regulator_driver_init+0x0/0x4b returned 0 after 99 usecs
calling  qcom_labibb_regulator_driver_init+0x0/0x4b @ 1
initcall qcom_labibb_regulator_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  qcom_spmi_regulator_driver_init+0x0/0x4b @ 1
initcall qcom_spmi_regulator_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  qcom_usb_vbus_regulator_driver_init+0x0/0x4b @ 1
initcall qcom_usb_vbus_regulator_driver_init+0x0/0x4b returned 0 after 112 usecs
calling  pf8x00_regulator_driver_init+0x0/0x4b @ 1
initcall pf8x00_regulator_driver_init+0x0/0x4b returned 0 after 105 usecs
calling  pfuze_driver_init+0x0/0x4b @ 1
initcall pfuze_driver_init+0x0/0x4b returned 0 after 123 usecs
calling  pv88060_regulator_driver_init+0x0/0x4b @ 1
initcall pv88060_regulator_driver_init+0x0/0x4b returned 0 after 94 usecs
calling  attiny_regulator_driver_init+0x0/0x4b @ 1
initcall attiny_regulator_driver_init+0x0/0x4b returned 0 after 92 usecs
calling  rn5t618_regulator_driver_init+0x0/0x4b @ 1
initcall rn5t618_regulator_driver_init+0x0/0x4b returned 0 after 116 usecs
calling  rt4801_driver_init+0x0/0x4b @ 1
initcall rt4801_driver_init+0x0/0x4b returned 0 after 155 usecs
calling  rt5033_regulator_driver_init+0x0/0x4b @ 1
initcall rt5033_regulator_driver_init+0x0/0x4b returned 0 after 181 usecs
calling  rt5190a_driver_init+0x0/0x4b @ 1
initcall rt5190a_driver_init+0x0/0x4b returned 0 after 174 usecs
calling  rt6160_driver_init+0x0/0x4b @ 1
initcall rt6160_driver_init+0x0/0x4b returned 0 after 110 usecs
calling  rtmv20_driver_init+0x0/0x4b @ 1
initcall rtmv20_driver_init+0x0/0x4b returned 0 after 116 usecs
calling  rtq6752_driver_init+0x0/0x4b @ 1
initcall rtq6752_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  s2mpa01_pmic_driver_init+0x0/0x4b @ 1
initcall s2mpa01_pmic_driver_init+0x0/0x4b returned 0 after 109 usecs
calling  s2mps11_pmic_driver_init+0x0/0x4b @ 1
initcall s2mps11_pmic_driver_init+0x0/0x4b returned 0 after 112 usecs
calling  sky81452_reg_driver_init+0x0/0x4b @ 1
initcall sky81452_reg_driver_init+0x0/0x4b returned 0 after 156 usecs
calling  slg51000_regulator_driver_init+0x0/0x4b @ 1
initcall slg51000_regulator_driver_init+0x0/0x4b returned 0 after 175 usecs
calling  stpmic1_regulator_driver_init+0x0/0x4b @ 1
initcall stpmic1_regulator_driver_init+0x0/0x4b returned 0 after 119 usecs
calling  sy7636a_regulator_driver_init+0x0/0x4b @ 1
initcall sy7636a_regulator_driver_init+0x0/0x4b returned 0 after 116 usecs
calling  sy8106a_regulator_driver_init+0x0/0x4b @ 1
initcall sy8106a_regulator_driver_init+0x0/0x4b returned 0 after 106 usecs
calling  sy8827n_regulator_driver_init+0x0/0x4b @ 1
initcall sy8827n_regulator_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  tps65086_regulator_driver_init+0x0/0x4b @ 1
initcall tps65086_regulator_driver_init+0x0/0x4b returned 0 after 147 usecs
calling  pmic_driver_init+0x0/0x4b @ 1
initcall pmic_driver_init+0x0/0x4b returned 0 after 136 usecs
calling  tps65912_regulator_driver_init+0x0/0x4b @ 1
initcall tps65912_regulator_driver_init+0x0/0x4b returned 0 after 110 usecs
calling  tps65132_i2c_driver_init+0x0/0x4b @ 1
initcall tps65132_i2c_driver_init+0x0/0x4b returned 0 after 173 usecs
calling  vctrl_driver_init+0x0/0x4b @ 1
initcall vctrl_driver_init+0x0/0x4b returned 0 after 106 usecs
calling  wm8994_ldo_driver_init+0x0/0x4b @ 1
initcall wm8994_ldo_driver_init+0x0/0x4b returned 0 after 119 usecs
calling  tps380x_reset_driver_init+0x0/0x4b @ 1
initcall tps380x_reset_driver_init+0x0/0x4b returned 0 after 105 usecs
calling  n_null_init+0x0/0x79 @ 1
initcall n_null_init+0x0/0x79 returned 0 after 3 usecs
calling  pty_init+0x0/0x58 @ 1
initcall pty_init+0x0/0x58 returned 0 after 173498 usecs
calling  sysrq_init+0x0/0x123 @ 1
initcall sysrq_init+0x0/0x123 returned 0 after 75 usecs
calling  n_hdlc_init+0x0/0xcd @ 1
N_HDLC line discipline registered with maxframe=4096
initcall n_hdlc_init+0x0/0xcd returned 0 after 825 usecs
calling  serial8250_init+0x0/0x39f @ 1
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial 00:04: GPIO lookup for consumer rs485-term
serial 00:04: using ACPI for GPIO lookup
acpi PNP0501:00: GPIO: looking up rs485-term-gpios
acpi PNP0501:00: GPIO: looking up rs485-term-gpio
serial 00:04: using lookup tables for GPIO lookup
serial 00:04: No GPIO consumer rs485-term found
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
serial 00:05: GPIO lookup for consumer rs485-term
serial 00:05: using ACPI for GPIO lookup
acpi PNP0501:01: GPIO: looking up rs485-term-gpios
acpi PNP0501:01: GPIO: looking up rs485-term-gpio
serial 00:05: using lookup tables for GPIO lookup
serial 00:05: No GPIO consumer rs485-term found
00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
initcall serial8250_init+0x0/0x39f returned 0 after 17201 usecs
calling  serial_cs_driver_init+0x0/0x49 @ 1
initcall serial_cs_driver_init+0x0/0x49 returned 0 after 152 usecs
calling  pericom8250_pci_driver_init+0x0/0x50 @ 1
initcall pericom8250_pci_driver_init+0x0/0x50 returned 0 after 155 usecs
calling  of_platform_serial_driver_init+0x0/0x4b @ 1
initcall of_platform_serial_driver_init+0x0/0x4b returned 0 after 94 usecs
calling  sc16is7xx_init+0x0/0xfc @ 1
initcall sc16is7xx_init+0x0/0xfc returned 0 after 191 usecs
calling  jsm_init_module+0x0/0xc7 @ 1
initcall jsm_init_module+0x0/0xc7 returned 0 after 326 usecs
calling  ulite_init+0x0/0xac @ 1
initcall ulite_init+0x0/0xac returned 0 after 95 usecs
calling  altera_uart_init+0x0/0xc2 @ 1
initcall altera_uart_init+0x0/0xc2 returned 0 after 161 usecs
calling  altera_jtaguart_init+0x0/0xc2 @ 1
initcall altera_jtaguart_init+0x0/0xc2 returned 0 after 172 usecs
calling  pch_uart_module_init+0x0/0xc7 @ 1
initcall pch_uart_module_init+0x0/0xc7 returned 0 after 220 usecs
calling  init_lqasc+0x0/0xc2 @ 1
initcall init_lqasc+0x0/0xc2 returned 0 after 175 usecs
calling  arc_serial_init+0x0/0xbf @ 1
initcall arc_serial_init+0x0/0xbf returned 0 after 131 usecs
calling  digicolor_uart_init+0x0/0xd5 @ 1
initcall digicolor_uart_init+0x0/0xd5 returned 0 after 135 usecs
calling  sifive_serial_init+0x0/0xc2 @ 1
initcall sifive_serial_init+0x0/0xc2 returned 0 after 139 usecs
calling  moxa_init+0x0/0x615 @ 1
MOXA Intellio family driver version 6.0k
initcall moxa_init+0x0/0x615 returned 0 after 924 usecs
calling  mxser_module_init+0x0/0x1a5 @ 1
initcall mxser_module_init+0x0/0x1a5 returned 0 after 130 usecs
calling  nozomi_init+0x0/0x1aa @ 1
initcall nozomi_init+0x0/0x1aa returned 0 after 175 usecs
calling  ttynull_init+0x0/0x17f @ 1
initcall ttynull_init+0x0/0x17f returned 0 after 407 usecs
calling  slgt_init+0x0/0x2bd @ 1
SyncLink GT
SyncLink GT, tty major#235
SyncLink GT no devices found
initcall slgt_init+0x0/0x2bd returned 0 after 1740 usecs
calling  goldfish_tty_platform_driver_init+0x0/0x4b @ 1
initcall goldfish_tty_platform_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  rpmsg_tty_init+0x0/0x19d @ 1
initcall rpmsg_tty_init+0x0/0x19d returned 0 after 113 usecs
calling  random_sysctls_init+0x0/0x54 @ 1
initcall random_sysctls_init+0x0/0x54 returned 0 after 41 usecs
calling  ttyprintk_init+0x0/0x1c6 @ 1
initcall ttyprintk_init+0x0/0x1c6 returned 0 after 455 usecs
calling  virtio_console_init+0x0/0x1df @ 1
initcall virtio_console_init+0x0/0x1df returned 0 after 161 usecs
calling  lp_init_module+0x0/0x334 @ 1
kworker/u4:1 (59) used greatest stack depth: 6528 bytes left
lp: driver loaded but no devices found
initcall lp_init_module+0x0/0x334 returned 0 after 3329 usecs
calling  applicom_init+0x0/0xccf @ 1
Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:57 dwmw2 Exp $
ac.o: No PCI boards found.
ac.o: For an ISA board you must supply memory and irq parameters.
initcall applicom_init+0x0/0xccf returned -6 after 2551 usecs
calling  nvram_module_init+0x0/0x164 @ 1
Non-volatile memory driver v1.3
initcall nvram_module_init+0x0/0x164 returned 0 after 1098 usecs
calling  toshiba_init+0x0/0x25d @ 1
toshiba: not a supported Toshiba laptop
initcall toshiba_init+0x0/0x25d returned -19 after 769 usecs
calling  timeriomem_rng_driver_init+0x0/0x4b @ 1
initcall timeriomem_rng_driver_init+0x0/0x4b returned 0 after 331 usecs
calling  intel_rng_mod_init+0x0/0x41b @ 1
initcall intel_rng_mod_init+0x0/0x41b returned -19 after 318 usecs
calling  via_rng_mod_init+0x0/0xcf @ 1
initcall via_rng_mod_init+0x0/0xcf returned -19 after 1 usecs
calling  virtio_rng_driver_init+0x0/0x49 @ 1
initcall virtio_rng_driver_init+0x0/0x49 returned 0 after 115 usecs
calling  xiphera_trng_driver_init+0x0/0x4b @ 1
initcall xiphera_trng_driver_init+0x0/0x4b returned 0 after 200 usecs
calling  pc8736x_gpio_init+0x0/0x670 @ 1
platform pc8736x_gpio.0: NatSemi pc8736x GPIO Driver Initializing
platform pc8736x_gpio.0: no device found
initcall pc8736x_gpio_init+0x0/0x670 returned -19 after 2398 usecs
calling  nsc_gpio_init+0x0/0x4c @ 1
nsc_gpio initializing
initcall nsc_gpio_init+0x0/0x4c returned 0 after 517 usecs
calling  mwave_init+0x0/0x502 @ 1
smapi::smapi_init, ERROR invalid usSmapiID
mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAPI is not available on this machine
mwave: mwavedd::mwave_init: Error: Failed to initialize board data
mwave: mwavedd::mwave_init: Error: Failed to initialize
initcall mwave_init+0x0/0x502 returned -5 after 4027 usecs
calling  cmm_init+0x0/0x182 @ 1
initcall cmm_init+0x0/0x182 returned 0 after 200 usecs
calling  scr24x_init+0x0/0x154 @ 1
initcall scr24x_init+0x0/0x154 returned 0 after 132 usecs
calling  hangcheck_init+0x0/0xd7 @ 1
Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
initcall hangcheck_init+0x0/0xd7 returned 0 after 1170 usecs
calling  xillybus_class_init+0x0/0x9d @ 1
initcall xillybus_class_init+0x0/0x9d returned 0 after 60 usecs
calling  xillyusb_init+0x0/0x5a @ 1
usbcore: registered new interface driver xillyusb
initcall xillyusb_init+0x0/0x5a returned 0 after 1017 usecs
calling  drm_core_init+0x0/0x207 @ 1
ACPI: bus type drm_connector registered
initcall drm_core_init+0x0/0x207 returned 0 after 778 usecs
calling  komeda_platform_driver_init+0x0/0xa2 @ 1
initcall komeda_platform_driver_init+0x0/0xa2 returned 0 after 101 usecs
calling  drm_display_helper_module_init+0x0/0x44 @ 1
initcall drm_display_helper_module_init+0x0/0x44 returned 0 after 60 usecs
calling  drm_sched_fence_slab_init+0x0/0x8a @ 1
initcall drm_sched_fence_slab_init+0x0/0x8a returned 0 after 7 usecs
calling  tdfx_init+0x0/0x4e @ 1
initcall tdfx_init+0x0/0x4e returned 0 after 60 usecs
calling  mga_init+0x0/0x58 @ 1
initcall mga_init+0x0/0x58 returned 0 after 41 usecs
calling  vgem_init+0x0/0x260 @ 1
[drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
initcall vgem_init+0x0/0x260 returned 0 after 3111 usecs
calling  ast_pci_driver_init+0x0/0xf5 @ 1
initcall ast_pci_driver_init+0x0/0xf5 returned 0 after 187 usecs
calling  rcar_dw_hdmi_platform_driver_init+0x0/0x4b @ 1
initcall rcar_dw_hdmi_platform_driver_init+0x0/0x4b returned 0 after 119 usecs
calling  qxl_pci_driver_init+0x0/0xf5 @ 1
initcall qxl_pci_driver_init+0x0/0xf5 returned 0 after 233 usecs
calling  boe_bf060y8m_aj0_driver_init+0x0/0x4b @ 1
initcall boe_bf060y8m_aj0_driver_init+0x0/0x4b returned 0 after 87 usecs
calling  panel_driver_init+0x0/0x4b @ 1
initcall panel_driver_init+0x0/0x4b returned 0 after 157 usecs
calling  boe_panel_driver_init+0x0/0x4b @ 1
initcall boe_panel_driver_init+0x0/0x4b returned 0 after 95 usecs
calling  dsicm_driver_init+0x0/0x4b @ 1
initcall dsicm_driver_init+0x0/0x4b returned 0 after 87 usecs
calling  panel_lvds_driver_init+0x0/0x4b @ 1
initcall panel_lvds_driver_init+0x0/0x4b returned 0 after 112 usecs
calling  kd35t133_driver_init+0x0/0x4b @ 1
initcall kd35t133_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  ej030na_driver_init+0x0/0x4b @ 1
SPI driver panel-innolux-ej030na has no spi_device_id for innolux,ej030na
initcall ej030na_driver_init+0x0/0x4b returned 0 after 1360 usecs
calling  innolux_panel_driver_init+0x0/0x4b @ 1
initcall innolux_panel_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  khadas_ts050_panel_driver_init+0x0/0x4b @ 1
initcall khadas_ts050_panel_driver_init+0x0/0x4b returned 0 after 89 usecs
calling  kingdisplay_panel_driver_init+0x0/0x4b @ 1
initcall kingdisplay_panel_driver_init+0x0/0x4b returned 0 after 94 usecs
calling  lb035q02_driver_init+0x0/0x4b @ 1
initcall lb035q02_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  lg4573_driver_init+0x0/0x4b @ 1
initcall lg4573_driver_init+0x0/0x4b returned 0 after 165 usecs
calling  nl8048_driver_init+0x0/0x4b @ 1
initcall nl8048_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  nv3052c_driver_init+0x0/0x4b @ 1
SPI driver nv3052c has no spi_device_id for leadtek,ltk035c5444t
initcall nv3052c_driver_init+0x0/0x4b returned 0 after 1040 usecs
calling  nt35510_driver_init+0x0/0x4b @ 1
initcall nt35510_driver_init+0x0/0x4b returned 0 after 90 usecs
calling  nt35560_driver_init+0x0/0x4b @ 1
initcall nt35560_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  nt39016_driver_init+0x0/0x4b @ 1
SPI driver nt39016 has no spi_device_id for kingdisplay,kd035g6-54nt
initcall nt39016_driver_init+0x0/0x4b returned 0 after 1088 usecs
calling  mantix_driver_init+0x0/0x4b @ 1
initcall mantix_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  lcd_olinuxino_driver_init+0x0/0x4b @ 1
initcall lcd_olinuxino_driver_init+0x0/0x4b returned 0 after 188 usecs
calling  wuxga_nt_panel_driver_init+0x0/0x4b @ 1
initcall wuxga_nt_panel_driver_init+0x0/0x4b returned 0 after 92 usecs
calling  rad_panel_driver_init+0x0/0x4b @ 1
initcall rad_panel_driver_init+0x0/0x4b returned 0 after 160 usecs
calling  raydium_rm68200_driver_init+0x0/0x4b @ 1
initcall raydium_rm68200_driver_init+0x0/0x4b returned 0 after 182 usecs
calling  rb070d30_panel_driver_init+0x0/0x4b @ 1
initcall rb070d30_panel_driver_init+0x0/0x4b returned 0 after 86 usecs
calling  db7430_driver_init+0x0/0x4b @ 1
SPI driver db7430-panel has no spi_device_id for samsung,lms397kf04
initcall db7430_driver_init+0x0/0x4b returned 0 after 1088 usecs
calling  ld9040_driver_init+0x0/0x4b @ 1
initcall ld9040_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  s6d16d0_driver_init+0x0/0x4b @ 1
initcall s6d16d0_driver_init+0x0/0x4b returned 0 after 90 usecs
calling  s6e3ha2_driver_init+0x0/0x4b @ 1
initcall s6e3ha2_driver_init+0x0/0x4b returned 0 after 89 usecs
calling  s6e63j0x03_driver_init+0x0/0x4b @ 1
initcall s6e63j0x03_driver_init+0x0/0x4b returned 0 after 86 usecs
calling  s6e88a0_ams452ef01_driver_init+0x0/0x4b @ 1
initcall s6e88a0_ams452ef01_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  sofef00_panel_driver_init+0x0/0x4b @ 1
initcall sofef00_panel_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  seiko_panel_platform_driver_init+0x0/0x4b @ 1
initcall seiko_panel_platform_driver_init+0x0/0x4b returned 0 after 125 usecs
calling  sharp_nt_panel_driver_init+0x0/0x4b @ 1
initcall sharp_nt_panel_driver_init+0x0/0x4b returned 0 after 107 usecs
calling  sharp_ls060_driver_init+0x0/0x4b @ 1
initcall sharp_ls060_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  st7701_dsi_driver_init+0x0/0x4b @ 1
initcall st7701_dsi_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  st7703_driver_init+0x0/0x4b @ 1
initcall st7703_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  tdo_tl070wsh30_panel_driver_init+0x0/0x4b @ 1
initcall tdo_tl070wsh30_panel_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  td028ttec1_driver_init+0x0/0x4b @ 1
initcall td028ttec1_driver_init+0x0/0x4b returned 0 after 94 usecs
calling  td043mtea1_driver_init+0x0/0x4b @ 1
initcall td043mtea1_driver_init+0x0/0x4b returned 0 after 88 usecs
calling  truly_nt35597_driver_init+0x0/0x4b @ 1
initcall truly_nt35597_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  ws2401_driver_init+0x0/0x4b @ 1
SPI driver ws2401-panel has no spi_device_id for samsung,lms380kf01
initcall ws2401_driver_init+0x0/0x4b returned 0 after 1096 usecs
calling  xpp055c272_driver_init+0x0/0x4b @ 1
initcall xpp055c272_driver_init+0x0/0x4b returned 0 after 95 usecs
calling  cdns_dsi_platform_driver_init+0x0/0x4b @ 1
initcall cdns_dsi_platform_driver_init+0x0/0x4b returned 0 after 133 usecs
calling  chipone_init+0x0/0x65 @ 1
initcall chipone_init+0x0/0x65 returned 0 after 185 usecs
calling  ch7033_driver_init+0x0/0x4b @ 1
initcall ch7033_driver_init+0x0/0x4b returned 0 after 192 usecs
calling  display_connector_driver_init+0x0/0x4b @ 1
initcall display_connector_driver_init+0x0/0x4b returned 0 after 124 usecs
calling  lt8912_i2c_driver_init+0x0/0x4b @ 1
initcall lt8912_i2c_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  lt9211_driver_init+0x0/0x4b @ 1
initcall lt9211_driver_init+0x0/0x4b returned 0 after 164 usecs
calling  lt9611_driver_init+0x0/0x4b @ 1
initcall lt9611_driver_init+0x0/0x4b returned 0 after 133 usecs
calling  lvds_codec_driver_init+0x0/0x4b @ 1
initcall lvds_codec_driver_init+0x0/0x4b returned 0 after 120 usecs
calling  stdpxxxx_ge_b850v3_init+0x0/0x88 @ 1
initcall stdpxxxx_ge_b850v3_init+0x0/0x88 returned 0 after 181 usecs
calling  ps8640_driver_init+0x0/0x4b @ 1
initcall ps8640_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  sii8620_driver_init+0x0/0x4b @ 1
initcall sii8620_driver_init+0x0/0x4b returned 0 after 92 usecs
calling  sii9234_driver_init+0x0/0x4b @ 1
initcall sii9234_driver_init+0x0/0x4b returned 0 after 107 usecs
calling  simple_bridge_driver_init+0x0/0x4b @ 1
initcall simple_bridge_driver_init+0x0/0x4b returned 0 after 135 usecs
calling  thc63_driver_init+0x0/0x4b @ 1
initcall thc63_driver_init+0x0/0x4b returned 0 after 118 usecs
calling  tc358762_driver_init+0x0/0x4b @ 1
initcall tc358762_driver_init+0x0/0x4b returned 0 after 92 usecs
calling  adv7511_init+0x0/0xc4 @ 1
initcall adv7511_init+0x0/0xc4 returned 0 after 179 usecs
calling  dlpc3433_driver_init+0x0/0x4b @ 1
initcall dlpc3433_driver_init+0x0/0x4b returned 0 after 241 usecs
calling  sn65dsi83_driver_init+0x0/0x4b @ 1
initcall sn65dsi83_driver_init+0x0/0x4b returned 0 after 120 usecs
calling  ti_sn65dsi86_init+0x0/0x21e @ 1
initcall ti_sn65dsi86_init+0x0/0x21e returned 0 after 603 usecs
calling  tfp410_module_init+0x0/0x12d @ 1
initcall tfp410_module_init+0x0/0x12d returned 0 after 206 usecs
calling  tpd12s015_driver_init+0x0/0x4b @ 1
initcall tpd12s015_driver_init+0x0/0x4b returned 0 after 115 usecs
calling  nwl_dsi_driver_init+0x0/0x4b @ 1
initcall nwl_dsi_driver_init+0x0/0x4b returned 0 after 243 usecs
calling  it66121_driver_init+0x0/0x4b @ 1
initcall it66121_driver_init+0x0/0x4b returned 0 after 246 usecs
calling  anx6345_driver_init+0x0/0x4b @ 1
initcall anx6345_driver_init+0x0/0x4b returned 0 after 106 usecs
calling  anx7625_driver_init+0x0/0x4b @ 1
initcall anx7625_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  anx78xx_driver_init+0x0/0x4b @ 1
initcall anx78xx_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  mhdp_driver_init+0x0/0x4b @ 1
initcall mhdp_driver_init+0x0/0x4b returned 0 after 117 usecs
calling  etnaviv_init+0x0/0x229 @ 1
initcall etnaviv_init+0x0/0x229 returned 0 after 197 usecs
calling  mxsfb_platform_driver_init+0x0/0xa2 @ 1
initcall mxsfb_platform_driver_init+0x0/0xa2 returned 0 after 104 usecs
calling  arcpgu_platform_driver_init+0x0/0xa2 @ 1
initcall arcpgu_platform_driver_init+0x0/0xa2 returned 0 after 108 usecs
calling  bochs_pci_driver_init+0x0/0xf5 @ 1
[drm] Found bochs VGA, ID 0xb0c5.
[drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
[drm] Found EDID data blob.
[drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 1
bochs-drm 0000:00:02.0: [drm] fb0: bochs-drmdrmfb frame buffer device
initcall bochs_pci_driver_init+0x0/0xf5 returned 0 after 21788 usecs
calling  gm12u320_usb_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver gm12u320
initcall gm12u320_usb_driver_init+0x0/0x50 returned 0 after 1041 usecs
calling  panel_mipi_dbi_spi_driver_init+0x0/0x4b @ 1
initcall panel_mipi_dbi_spi_driver_init+0x0/0x4b returned 0 after 110 usecs
calling  simpledrm_platform_driver_init+0x0/0x4b @ 1
initcall simpledrm_platform_driver_init+0x0/0x4b returned 0 after 106 usecs
calling  ili9163_spi_driver_init+0x0/0x4b @ 1
SPI driver ili9163 has no spi_device_id for newhaven,1.8-128160EF
initcall ili9163_spi_driver_init+0x0/0x4b returned 0 after 1049 usecs
calling  ili9486_spi_driver_init+0x0/0x4b @ 1
SPI driver ili9486 has no spi_device_id for waveshare,rpi-lcd-35
SPI driver ili9486 has no spi_device_id for ozzmaker,piscreen
initcall ili9486_spi_driver_init+0x0/0x4b returned 0 after 2117 usecs
calling  mi0283qt_spi_driver_init+0x0/0x4b @ 1
initcall mi0283qt_spi_driver_init+0x0/0x4b returned 0 after 83 usecs
calling  repaper_spi_driver_init+0x0/0x4b @ 1
initcall repaper_spi_driver_init+0x0/0x4b returned 0 after 123 usecs
calling  st7735r_spi_driver_init+0x0/0x4b @ 1
initcall st7735r_spi_driver_init+0x0/0x4b returned 0 after 76 usecs
calling  vbox_pci_driver_init+0x0/0xf4 @ 1
initcall vbox_pci_driver_init+0x0/0xf4 returned 0 after 174 usecs
calling  gud_usb_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver gud
initcall gud_usb_driver_init+0x0/0x50 returned 0 after 983 usecs
calling  parport_pc_init+0x0/0x31d @ 1
parport_pc 00:03: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
parport_pc parport_pc.956: Unable to set coherent dma mask: disabling DMA
parport_pc parport_pc.888: Unable to set coherent dma mask: disabling DMA
parport_pc parport_pc.632: Unable to set coherent dma mask: disabling DMA
initcall parport_pc_init+0x0/0x31d returned 0 after 105229 usecs
calling  parport_cs_driver_init+0x0/0x49 @ 1
initcall parport_cs_driver_init+0x0/0x49 returned 0 after 109 usecs
calling  topology_sysfs_init+0x0/0x61 @ 1
initcall topology_sysfs_init+0x0/0x61 returned 0 after 481 usecs
calling  cacheinfo_sysfs_init+0x0/0x61 @ 1
initcall cacheinfo_sysfs_init+0x0/0x61 returned 0 after 1553 usecs
calling  ibmasm_init+0x0/0x119 @ 1
ibmasm: IBM ASM Service Processor Driver version 1.0 loaded
initcall ibmasm_init+0x0/0x119 returned 0 after 1111 usecs
calling  dummy_irq_init+0x0/0x110 @ 1
dummy-irq: no IRQ given.  Use irq=N
initcall dummy_irq_init+0x0/0x110 returned -5 after 656 usecs
calling  ics932s401_driver_init+0x0/0x4b @ 1
initcall ics932s401_driver_init+0x0/0x4b returned 0 after 138 usecs
calling  tifm_7xx1_driver_init+0x0/0x50 @ 1
initcall tifm_7xx1_driver_init+0x0/0x50 returned 0 after 194 usecs
calling  bh1770_driver_init+0x0/0x4b @ 1
initcall bh1770_driver_init+0x0/0x4b returned 0 after 129 usecs
calling  apds990x_driver_init+0x0/0x4b @ 1
initcall apds990x_driver_init+0x0/0x4b returned 0 after 142 usecs
calling  apds9802als_driver_init+0x0/0x4b @ 1
initcall apds9802als_driver_init+0x0/0x4b returned 0 after 161 usecs
calling  isl29003_driver_init+0x0/0x4b @ 1
initcall isl29003_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  isl29020_driver_init+0x0/0x4b @ 1
initcall isl29020_driver_init+0x0/0x4b returned 0 after 138 usecs
calling  tsl2550_driver_init+0x0/0x4b @ 1
initcall tsl2550_driver_init+0x0/0x4b returned 0 after 114 usecs
calling  ds1682_driver_init+0x0/0x4b @ 1
initcall ds1682_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  c2port_init+0x0/0xbd @ 1
Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Giometti
initcall c2port_init+0x0/0xbd returned 0 after 1049 usecs
calling  hmc6352_driver_init+0x0/0x4b @ 1
initcall hmc6352_driver_init+0x0/0x4b returned 0 after 120 usecs
calling  at24_init+0x0/0xf3 @ 1
initcall at24_init+0x0/0xf3 returned 0 after 122 usecs
calling  at25_driver_init+0x0/0x4b @ 1
initcall at25_driver_init+0x0/0x4b returned 0 after 104 usecs
calling  eeprom_93xx46_driver_init+0x0/0x4b @ 1
initcall eeprom_93xx46_driver_init+0x0/0x4b returned 0 after 113 usecs
calling  idt_init+0x0/0xa0 @ 1
initcall idt_init+0x0/0xa0 returned 0 after 168 usecs
calling  mei_init+0x0/0x188 @ 1
initcall mei_init+0x0/0x188 returned 0 after 236 usecs
calling  mei_txe_driver_init+0x0/0x50 @ 1
initcall mei_txe_driver_init+0x0/0x50 returned 0 after 150 usecs
calling  lattice_ecp3_driver_init+0x0/0x4b @ 1
initcall lattice_ecp3_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  dw_xdata_pcie_driver_init+0x0/0x50 @ 1
initcall dw_xdata_pcie_driver_init+0x0/0x50 returned 0 after 153 usecs
calling  rtsx_usb_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver rtsx_usb
initcall rtsx_usb_driver_init+0x0/0x50 returned 0 after 991 usecs
calling  pvpanic_init+0x0/0x80 @ 1
initcall pvpanic_init+0x0/0x80 returned 0 after 4 usecs
calling  pvpanic_mmio_driver_init+0x0/0x4b @ 1
initcall pvpanic_mmio_driver_init+0x0/0x4b returned 0 after 122 usecs
calling  pvpanic_pci_driver_init+0x0/0x50 @ 1
initcall pvpanic_pci_driver_init+0x0/0x50 returned 0 after 168 usecs
calling  hl_init+0x0/0x264 @ 1
habanalabs: loading driver
initcall hl_init+0x0/0x264 returned 0 after 868 usecs
calling  xsdfec_driver_init+0x0/0x4b @ 1
initcall xsdfec_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  hisi_hikey_usb_driver_init+0x0/0x4b @ 1
initcall hisi_hikey_usb_driver_init+0x0/0x4b returned 0 after 172 usecs
calling  open_dice_init+0x0/0x76 @ 1
initcall open_dice_init+0x0/0x76 returned 0 after 172 usecs
calling  pci1xxxx_gp_driver_init+0x0/0x50 @ 1
initcall pci1xxxx_gp_driver_init+0x0/0x50 returned 0 after 163 usecs
calling  pci1xxxx_gpio_driver_init+0x0/0x50 @ 1
initcall pci1xxxx_gpio_driver_init+0x0/0x50 returned 0 after 128 usecs
calling  vcpu_stall_detect_driver_init+0x0/0x4b @ 1
initcall vcpu_stall_detect_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  sm501_base_init+0x0/0x8d @ 1
initcall sm501_base_init+0x0/0x8d returned 0 after 223 usecs
calling  bcm590xx_i2c_driver_init+0x0/0x4b @ 1
initcall bcm590xx_i2c_driver_init+0x0/0x4b returned 0 after 85 usecs
calling  bd9571mwv_driver_init+0x0/0x4b @ 1
initcall bd9571mwv_driver_init+0x0/0x4b returned 0 after 85 usecs
calling  gsc_driver_init+0x0/0x4b @ 1
initcall gsc_driver_init+0x0/0x4b returned 0 after 167 usecs
calling  pasic3_driver_init+0x0/0x50 @ 1
initcall pasic3_driver_init+0x0/0x50 returned -19 after 123 usecs
calling  lp873x_driver_init+0x0/0x4b @ 1
initcall lp873x_driver_init+0x0/0x4b returned 0 after 78 usecs
calling  ti_tscadc_driver_init+0x0/0x4b @ 1
initcall ti_tscadc_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  arizona_i2c_driver_init+0x0/0x4b @ 1
initcall arizona_i2c_driver_init+0x0/0x4b returned 0 after 83 usecs
calling  wm8994_i2c_driver_init+0x0/0x4b @ 1
initcall wm8994_i2c_driver_init+0x0/0x4b returned 0 after 128 usecs
calling  madera_spi_driver_init+0x0/0x4b @ 1
initcall madera_spi_driver_init+0x0/0x4b returned 0 after 106 usecs
calling  tps65086_driver_init+0x0/0x4b @ 1
initcall tps65086_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  tps65912_i2c_driver_init+0x0/0x4b @ 1
initcall tps65912_i2c_driver_init+0x0/0x4b returned 0 after 79 usecs
calling  tps65912_spi_driver_init+0x0/0x4b @ 1
initcall tps65912_spi_driver_init+0x0/0x4b returned 0 after 74 usecs
calling  twl_driver_init+0x0/0x4b @ 1
initcall twl_driver_init+0x0/0x4b returned 0 after 83 usecs
calling  twl4030_audio_driver_init+0x0/0x4b @ 1
initcall twl4030_audio_driver_init+0x0/0x4b returned 0 after 151 usecs
calling  ocelot_spi_driver_init+0x0/0x4b @ 1
initcall ocelot_spi_driver_init+0x0/0x4b returned 0 after 131 usecs
calling  cpcap_driver_init+0x0/0x4b @ 1
initcall cpcap_driver_init+0x0/0x4b returned 0 after 69 usecs
calling  lp3943_driver_init+0x0/0x4b @ 1
initcall lp3943_driver_init+0x0/0x4b returned 0 after 83 usecs
calling  da9063_i2c_driver_init+0x0/0x4b @ 1
initcall da9063_i2c_driver_init+0x0/0x4b returned 0 after 79 usecs
calling  da9150_driver_init+0x0/0x4b @ 1
initcall da9150_driver_init+0x0/0x4b returned 0 after 76 usecs
calling  max77620_driver_init+0x0/0x4b @ 1
initcall max77620_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  max77686_i2c_driver_init+0x0/0x4b @ 1
initcall max77686_i2c_driver_init+0x0/0x4b returned 0 after 75 usecs
calling  max77693_i2c_driver_init+0x0/0x4b @ 1
initcall max77693_i2c_driver_init+0x0/0x4b returned 0 after 79 usecs
calling  max77714_driver_init+0x0/0x4b @ 1
initcall max77714_driver_init+0x0/0x4b returned 0 after 77 usecs
calling  mp2629_driver_init+0x0/0x4b @ 1
initcall mp2629_driver_init+0x0/0x4b returned 0 after 165 usecs
calling  mt6360_driver_init+0x0/0x4b @ 1
initcall mt6360_driver_init+0x0/0x4b returned 0 after 74 usecs
calling  mt6370_driver_init+0x0/0x4b @ 1
initcall mt6370_driver_init+0x0/0x4b returned 0 after 82 usecs
calling  adp5520_driver_init+0x0/0x4b @ 1
initcall adp5520_driver_init+0x0/0x4b returned 0 after 59 usecs
calling  kempld_init+0x0/0x16e @ 1
initcall kempld_init+0x0/0x16e returned 0 after 107 usecs
calling  intel_quark_mfd_driver_init+0x0/0x50 @ 1
initcall intel_quark_mfd_driver_init+0x0/0x50 returned 0 after 190 usecs
calling  lpc_sch_driver_init+0x0/0x50 @ 1
initcall lpc_sch_driver_init+0x0/0x50 returned 0 after 138 usecs
calling  lpc_ich_driver_init+0x0/0x50 @ 1
initcall lpc_ich_driver_init+0x0/0x50 returned 0 after 181 usecs
calling  atmel_flexcom_driver_init+0x0/0x4b @ 1
initcall atmel_flexcom_driver_init+0x0/0x4b returned 0 after 121 usecs
calling  atmel_hlcdc_driver_init+0x0/0x4b @ 1
initcall atmel_hlcdc_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  intel_lpss_init+0x0/0x51 @ 1
initcall intel_lpss_init+0x0/0x51 returned 0 after 1 usecs
calling  intel_lpss_pci_driver_init+0x0/0x50 @ 1
initcall intel_lpss_pci_driver_init+0x0/0x50 returned 0 after 159 usecs
calling  rn5t618_i2c_driver_init+0x0/0x4b @ 1
initcall rn5t618_i2c_driver_init+0x0/0x4b returned 0 after 86 usecs
calling  sec_pmic_driver_init+0x0/0x4b @ 1
initcall sec_pmic_driver_init+0x0/0x4b returned 0 after 85 usecs
calling  as3722_i2c_driver_init+0x0/0x4b @ 1
initcall as3722_i2c_driver_init+0x0/0x4b returned 0 after 85 usecs
calling  iqs62x_i2c_driver_init+0x0/0x4b @ 1
initcall iqs62x_i2c_driver_init+0x0/0x4b returned 0 after 101 usecs
calling  hi6421_pmic_driver_init+0x0/0x4b @ 1
initcall hi6421_pmic_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  hi6421_spmi_pmic_driver_init+0x0/0x4b @ 1
initcall hi6421_spmi_pmic_driver_init+0x0/0x4b returned 0 after 68 usecs
calling  rt5033_driver_init+0x0/0x4b @ 1
initcall rt5033_driver_init+0x0/0x4b returned 0 after 109 usecs
calling  sky81452_driver_init+0x0/0x4b @ 1
initcall sky81452_driver_init+0x0/0x4b returned 0 after 86 usecs
calling  stpmic1_driver_init+0x0/0x4b @ 1
initcall stpmic1_driver_init+0x0/0x4b returned 0 after 82 usecs
calling  pm8008_mfd_driver_init+0x0/0x4b @ 1
initcall pm8008_mfd_driver_init+0x0/0x4b returned 0 after 163 usecs
calling  simple_mfd_i2c_driver_init+0x0/0x4b @ 1
initcall simple_mfd_i2c_driver_init+0x0/0x4b returned 0 after 81 usecs
calling  atc260x_i2c_driver_init+0x0/0x4b @ 1
initcall atc260x_i2c_driver_init+0x0/0x4b returned 0 after 86 usecs
calling  cxl_core_init+0x0/0x155 @ 1
initcall cxl_core_init+0x0/0x155 returned 0 after 245 usecs
calling  cxl_pci_driver_init+0x0/0x50 @ 1
initcall cxl_pci_driver_init+0x0/0x50 returned 0 after 235 usecs
calling  cxl_mem_driver_init+0x0/0x50 @ 1
initcall cxl_mem_driver_init+0x0/0x50 returned 0 after 84 usecs
calling  cxl_acpi_driver_init+0x0/0x4b @ 1
initcall cxl_acpi_driver_init+0x0/0x4b returned 0 after 140 usecs
calling  cxl_port_driver_init+0x0/0x50 @ 1
initcall cxl_port_driver_init+0x0/0x50 returned 0 after 78 usecs
calling  raid_init+0x0/0x49 @ 1
initcall raid_init+0x0/0x49 returned 0 after 45 usecs
calling  spi_transport_init+0x0/0x220 @ 1
initcall spi_transport_init+0x0/0x220 returned 0 after 83 usecs
calling  sas_transport_init+0x0/0x223 @ 1
initcall sas_transport_init+0x0/0x223 returned 0 after 196 usecs
calling  sas_class_init+0x0/0xfa @ 1
initcall sas_class_init+0x0/0xfa returned 0 after 10 usecs
calling  srp_transport_init+0x0/0xc0 @ 1
initcall srp_transport_init+0x0/0xc0 returned 0 after 222 usecs
calling  snic_init_module+0x0/0x149 @ 1
snic:SNIC Driver is supported only for x86_64 platforms!
snic:Cisco SCSI NIC Driver, ver 0.0.1.18
snic:Trace Facility Enabled.
Trace Buffer SZ 16 Pages.
initcall snic_init_module+0x0/0x149 returned 0 after 3622 usecs
calling  advansys_init+0x0/0xcc @ 1
initcall advansys_init+0x0/0xcc returned 0 after 2322 usecs
calling  arcmsr_module_init+0x0/0x40 @ 1
initcall arcmsr_module_init+0x0/0x40 returned 0 after 147 usecs
calling  ahc_linux_init+0x0/0x117 @ 1
initcall ahc_linux_init+0x0/0x117 returned 0 after 165 usecs
calling  ahd_linux_init+0x0/0x153 @ 1
initcall ahd_linux_init+0x0/0x153 returned 0 after 197 usecs
calling  aac_init+0x0/0xaf @ 1
Adaptec aacraid driver 1.2.1[50983]-custom
initcall aac_init+0x0/0xaf returned 0 after 918 usecs
calling  aic94xx_init+0x0/0x1a1 @ 1
aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.3 loaded
initcall aic94xx_init+0x0/0x1a1 returned 0 after 1234 usecs
calling  pm8001_init+0x0/0x143 @ 1
initcall pm8001_init+0x0/0x143 returned 0 after 292 usecs
calling  isci_init+0x0/0xf6 @ 1
isci: Intel(R) C600 SAS Controller Driver - version 1.2.0
initcall isci_init+0x0/0xf6 returned 0 after 1217 usecs
calling  ips_module_init+0x0/0x1c8 @ 1
initcall ips_module_init+0x0/0x1c8 returned -19 after 246 usecs
calling  fdomain_pci_driver_init+0x0/0x50 @ 1
initcall fdomain_pci_driver_init+0x0/0x50 returned 0 after 120 usecs
calling  dmx3191d_pci_driver_init+0x0/0x50 @ 1
initcall dmx3191d_pci_driver_init+0x0/0x50 returned 0 after 158 usecs
calling  hpsa_init+0x0/0xce @ 1
initcall hpsa_init+0x0/0xce returned 0 after 193 usecs
calling  pqi_init+0x0/0x32f @ 1
Microchip SmartPQI Driver (v2.1.18-045)
initcall pqi_init+0x0/0x32f returned 0 after 900 usecs
calling  sym2_init+0x0/0xe2 @ 1
initcall sym2_init+0x0/0xe2 returned 0 after 199 usecs
calling  dc395x_driver_init+0x0/0x50 @ 1
initcall dc395x_driver_init+0x0/0x50 returned 0 after 115 usecs
calling  megaraid_init+0x0/0x1b9 @ 1
initcall megaraid_init+0x0/0x1b9 returned 0 after 252 usecs
calling  mraid_mm_init+0x0/0x13a @ 1
megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
initcall mraid_mm_init+0x0/0x13a returned 0 after 1419 usecs
calling  megaraid_init+0x0/0x189 @ 1
megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
initcall megaraid_init+0x0/0x189 returned 0 after 1156 usecs
calling  megasas_init+0x0/0x4df @ 1
megasas: 07.719.03.00-rc1
initcall megasas_init+0x0/0x4df returned 0 after 793 usecs
calling  _mpt3sas_init+0x0/0x267 @ 1
mpt3sas version 43.100.00.00 loaded
initcall _mpt3sas_init+0x0/0x267 returned 0 after 1680 usecs
calling  atp870u_driver_init+0x0/0x50 @ 1
initcall atp870u_driver_init+0x0/0x50 returned 0 after 134 usecs
calling  initio_pci_driver_init+0x0/0x50 @ 1
initcall initio_pci_driver_init+0x0/0x50 returned 0 after 119 usecs
calling  myrb_init_module+0x0/0xcf @ 1
initcall myrb_init_module+0x0/0xcf returned 0 after 141 usecs
calling  tw_init+0x0/0x6f @ 1
3ware Storage Controller device driver for Linux v1.26.02.003.
initcall tw_init+0x0/0x6f returned 0 after 1246 usecs
calling  twa_init+0x0/0x6f @ 1
3ware 9000 Storage Controller device driver for Linux v2.26.02.014.
initcall twa_init+0x0/0x6f returned 0 after 1223 usecs
calling  twl_init+0x0/0x6f @ 1
LSI 3ware SAS/SATA-RAID Controller device driver for Linux v3.26.02.000.
initcall twl_init+0x0/0x6f returned 0 after 1191 usecs
calling  imm_driver_init+0x0/0x50 @ 1
initcall imm_driver_init+0x0/0x50 returned 0 after 1850 usecs
calling  init_nsp32+0x0/0x76 @ 1
nsp32: loading...
initcall init_nsp32+0x0/0x76 returned 0 after 594 usecs
calling  hptiop_module_init+0x0/0x74 @ 1
RocketRAID 3xxx/4xxx Controller driver v1.10.0
initcall hptiop_module_init+0x0/0x74 returned 0 after 923 usecs
calling  stex_init+0x0/0x6f @ 1
stex: Promise SuperTrak EX Driver version: 6.02.0000.01
initcall stex_init+0x0/0x6f returned 0 after 1039 usecs
calling  mvs_init+0x0/0xcf @ 1
initcall mvs_init+0x0/0xcf returned 0 after 193 usecs
calling  mvumi_pci_driver_init+0x0/0x50 @ 1
initcall mvumi_pci_driver_init+0x0/0x50 returned 0 after 121 usecs
calling  esas2r_init+0x0/0x45a @ 1
initcall esas2r_init+0x0/0x45a returned 0 after 224 usecs
calling  virtio_scsi_init+0x0/0x18f @ 1
initcall virtio_scsi_init+0x0/0x18f returned 0 after 440 usecs
calling  pvscsi_init+0x0/0x74 @ 1
VMware PVSCSI driver - version 1.0.7.0-k
initcall pvscsi_init+0x0/0x74 returned 0 after 943 usecs
calling  wd719x_pci_driver_init+0x0/0x50 @ 1
initcall wd719x_pci_driver_init+0x0/0x50 returned 0 after 126 usecs
calling  init_sg+0x0/0x222 @ 1
initcall init_sg+0x0/0x222 returned 0 after 138 usecs
calling  scsi_debug_init+0x0/0xf09 @ 1
scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
scsi host0: scsi_debug: version 0191 [20210520]
dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
initcall scsi_debug_init+0x0/0xf09 returned 0 after 30989 usecs
calling  nvme_core_init+0x0/0x35c @ 1
scsi 0:0:0:0: Attached scsi generic sg0 type 0
initcall nvme_core_init+0x0/0x35c returned 0 after 3460 usecs
calling  nvmf_init+0x0/0x2f4 @ 1
initcall nvmf_init+0x0/0x2f4 returned 0 after 678 usecs
calling  nvme_fc_init_module+0x0/0x1d5 @ 1
initcall nvme_fc_init_module+0x0/0x1d5 returned 0 after 529 usecs
calling  ahci_pci_driver_init+0x0/0x50 @ 1
initcall ahci_pci_driver_init+0x0/0x50 returned 0 after 181 usecs
calling  acard_ahci_pci_driver_init+0x0/0x50 @ 1
initcall acard_ahci_pci_driver_init+0x0/0x50 returned 0 after 157 usecs
calling  ahci_driver_init+0x0/0x4b @ 1
initcall ahci_driver_init+0x0/0x4b returned 0 after 104 usecs
calling  inic_pci_driver_init+0x0/0x50 @ 1
initcall inic_pci_driver_init+0x0/0x50 returned 0 after 204 usecs
calling  ceva_ahci_driver_init+0x0/0x4b @ 1
initcall ceva_ahci_driver_init+0x0/0x4b returned 0 after 174 usecs
calling  ahci_dwc_driver_init+0x0/0x4b @ 1
initcall ahci_dwc_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  init_mtd+0x0/0x2b6 @ 1
initcall init_mtd+0x0/0x2b6 returned 0 after 344 usecs
calling  ar7_parser_init+0x0/0x4b @ 1
initcall ar7_parser_init+0x0/0x4b returned 0 after 38 usecs
calling  cmdline_parser_init+0x0/0x76 @ 1
initcall cmdline_parser_init+0x0/0x76 returned 0 after 3 usecs
calling  ofpart_parser_init+0x0/0x66 @ 1
initcall ofpart_parser_init+0x0/0x66 returned 0 after 4 usecs
calling  redboot_parser_init+0x0/0x4b @ 1
initcall redboot_parser_init+0x0/0x4b returned 0 after 3 usecs
calling  mtdblock_tr_init+0x0/0x49 @ 1
initcall mtdblock_tr_init+0x0/0x49 returned 0 after 71 usecs
calling  ftl_tr_init+0x0/0x49 @ 1
initcall ftl_tr_init+0x0/0x49 returned 0 after 15 usecs
calling  inftl_tr_init+0x0/0x49 @ 1
initcall inftl_tr_init+0x0/0x49 returned 0 after 13 usecs
calling  rfd_ftl_tr_init+0x0/0x49 @ 1
initcall rfd_ftl_tr_init+0x0/0x49 returned 0 after 12 usecs
calling  init_ssfdcr+0x0/0x63 @ 1
SSFDC read-only Flash Translation layer
initcall init_ssfdcr+0x0/0x63 returned 0 after 689 usecs
calling  mtdoops_init+0x0/0x2f8 @ 1
mtdoops: mtd device (mtddev=name/number) must be supplied
initcall mtdoops_init+0x0/0x2f8 returned -22 after 870 usecs
calling  mtdswap_ops_init+0x0/0x49 @ 1
initcall mtdswap_ops_init+0x0/0x49 returned 0 after 17 usecs
calling  cfi_probe_init+0x0/0x4a @ 1
initcall cfi_probe_init+0x0/0x4a returned 0 after 77 usecs
calling  jedec_probe_init+0x0/0x4a @ 1
initcall jedec_probe_init+0x0/0x4a returned 0 after 3 usecs
calling  map_ram_init+0x0/0x4a @ 1
initcall map_ram_init+0x0/0x4a returned 0 after 3 usecs
calling  map_rom_init+0x0/0x4a @ 1
initcall map_rom_init+0x0/0x4a returned 0 after 3 usecs
calling  map_absent_init+0x0/0x4a @ 1
initcall map_absent_init+0x0/0x4a returned 0 after 3 usecs
calling  lpddr_probe_init+0x0/0x4a @ 1
initcall lpddr_probe_init+0x0/0x4a returned 0 after 3 usecs
calling  init_l440gx+0x0/0x584 @ 1
L440GX flash mapping: failed to find PIIX4 ISA bridge, cannot continue
initcall init_l440gx+0x0/0x584 returned -19 after 1054 usecs
calling  init_esb2rom+0x0/0x159 @ 1
device id = 2440
device id = 2480
device id = 24c0
device id = 24d0
device id = 25a1
device id = 2670
initcall init_esb2rom+0x0/0x159 returned -6 after 2825 usecs
calling  init_ichxrom+0x0/0xc4 @ 1
initcall init_ichxrom+0x0/0xc4 returned -6 after 46 usecs
calling  init_ck804xrom+0x0/0xe7 @ 1
initcall init_ck804xrom+0x0/0xe7 returned -6 after 92 usecs
calling  init_pcmciamtd+0x0/0x132 @ 1
initcall init_pcmciamtd+0x0/0x132 returned 0 after 112 usecs
calling  platram_driver_init+0x0/0x4b @ 1
initcall platram_driver_init+0x0/0x4b returned 0 after 124 usecs
calling  init_phram+0x0/0xfe @ 1
initcall init_phram+0x0/0xfe returned 0 after 91 usecs
calling  init_pmc551+0x0/0x83d @ 1
Ramix PMC551 PCI Mezzanine Ram Driver. (C) 1999,2000 Nortel Networks.
pmc551: not detected
initcall init_pmc551+0x0/0x83d returned -19 after 1492 usecs
calling  dataflash_driver_init+0x0/0x4b @ 1
initcall dataflash_driver_init+0x0/0x4b returned 0 after 113 usecs
calling  mchp48l640_driver_init+0x0/0x4b @ 1
initcall mchp48l640_driver_init+0x0/0x4b returned 0 after 85 usecs
calling  sst25l_driver_init+0x0/0x4b @ 1
initcall sst25l_driver_init+0x0/0x4b returned 0 after 82 usecs
calling  spinand_drv_init+0x0/0x4b @ 1
initcall spinand_drv_init+0x0/0x4b returned 0 after 84 usecs
calling  ubi_gluebi_init+0x0/0x4b @ 1
initcall ubi_gluebi_init+0x0/0x4b returned 0 after 79 usecs
calling  spi_mux_driver_init+0x0/0x4b @ 1
initcall spi_mux_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  spidev_init+0x0/0x176 @ 1
initcall spidev_init+0x0/0x176 returned 0 after 154 usecs
calling  altera_spi_driver_init+0x0/0x4b @ 1
initcall altera_spi_driver_init+0x0/0x4b returned 0 after 109 usecs
calling  dfl_spi_altera_driver_init+0x0/0x4b @ 1
Driver 'dfl-spi-altera' was unable to register with bus_type 'dfl' because the bus was not initialized.
initcall dfl_spi_altera_driver_init+0x0/0x4b returned -22 after 1346 usecs
calling  butterfly_driver_init+0x0/0x50 @ 1
parport0: powerup/reset Butterfly
parport_pc 00:03: registered master spi42
spi spi42.1: spi_bitbang_setup, 66 nsec/bit
spi spi42.1: setup mode 0, 8 bits/w, 15000000 Hz max --> 0
parport_pc 00:03: registered child spi42.1
parport0: dataflash at spi42.1
parport0: AVR Butterfly
initcall butterfly_driver_init+0x0/0x50 returned 0 after 126593 usecs
calling  fsi_spi_driver_init+0x0/0x49 @ 1
initcall fsi_spi_driver_init+0x0/0x49 returned 0 after 94 usecs
calling  fsl_spi_init+0x0/0x4b @ 1
initcall fsl_spi_init+0x0/0x4b returned 0 after 108 usecs
calling  spi_gpio_driver_init+0x0/0x4b @ 1
initcall spi_gpio_driver_init+0x0/0x4b returned 0 after 147 usecs
calling  intel_spi_platform_driver_init+0x0/0x4b @ 1
initcall intel_spi_platform_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  mchp_corespi_driver_init+0x0/0x4b @ 1
initcall mchp_corespi_driver_init+0x0/0x4b returned 0 after 108 usecs
calling  mchp_coreqspi_driver_init+0x0/0x4b @ 1
initcall mchp_coreqspi_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  mxic_spi_driver_init+0x0/0x4b @ 1
initcall mxic_spi_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  tiny_spi_driver_init+0x0/0x4b @ 1
initcall tiny_spi_driver_init+0x0/0x4b returned 0 after 86 usecs
calling  pxa2xx_spi_pci_driver_init+0x0/0x50 @ 1
initcall pxa2xx_spi_pci_driver_init+0x0/0x50 returned 0 after 128 usecs
calling  rockchip_spi_driver_init+0x0/0x4b @ 1
initcall rockchip_spi_driver_init+0x0/0x4b returned 0 after 99 usecs
calling  sc18is602_driver_init+0x0/0x4b @ 1
initcall sc18is602_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  tle62x0_driver_init+0x0/0x4b @ 1
initcall tle62x0_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  pch_spi_init+0x0/0xc9 @ 1
initcall pch_spi_init+0x0/0xc9 returned 0 after 253 usecs
calling  blackhole_netdev_init+0x0/0xe8 @ 1
initcall blackhole_netdev_init+0x0/0xe8 returned 0 after 65 usecs
calling  e1000_init_module+0x0/0x111 @ 1
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
ACPI: \_SB_.LNKC: Enabled at IRQ 11
e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
initcall e1000_init_module+0x0/0x111 returned 0 after 1309808 usecs
calling  fw_core_init+0x0/0x1e7 @ 1
initcall fw_core_init+0x0/0x1e7 returned 0 after 612 usecs
calling  sbp2_init+0x0/0x49 @ 1
initcall sbp2_init+0x0/0x49 returned 0 after 73 usecs
calling  vfio_init+0x0/0x233 @ 1
VFIO - User Level meta-driver version: 0.3
initcall vfio_init+0x0/0x233 returned 0 after 1502 usecs
calling  vfio_virqfd_init+0x0/0x86 @ 1
initcall vfio_virqfd_init+0x0/0x86 returned 0 after 535 usecs
calling  vfio_iommu_type1_init+0x0/0x49 @ 1
initcall vfio_iommu_type1_init+0x0/0x49 returned 0 after 9 usecs
calling  vfio_pci_core_init+0x0/0x44 @ 1
initcall vfio_pci_core_init+0x0/0x44 returned 0 after 43 usecs
calling  vfio_pci_init+0x0/0xef @ 1
initcall vfio_pci_init+0x0/0xef returned 0 after 269 usecs
calling  ks0108_parport_driver_init+0x0/0x50 @ 1
parport0: cannot grant exclusive access for device ks0108
ks0108: ERROR: parport didn't register new device
initcall ks0108_parport_driver_init+0x0/0x50 returned 0 after 4431 usecs
calling  cfag12864b_init+0x0/0x304 @ 1
cfag12864b: ERROR: ks0108 is not initialized
initcall cfag12864b_init+0x0/0x304 returned -22 after 832 usecs
calling  cfag12864bfb_init+0x0/0x1c7 @ 1
cfag12864bfb: ERROR: cfag12864b is not initialized
initcall cfag12864bfb_init+0x0/0x1c7 returned -22 after 799 usecs
calling  hd44780_driver_init+0x0/0x4b @ 1
initcall hd44780_driver_init+0x0/0x4b returned 0 after 125 usecs
calling  ht16k33_driver_init+0x0/0x4b @ 1
initcall ht16k33_driver_init+0x0/0x4b returned 0 after 89 usecs
calling  panel_init_module+0x0/0x492 @ 1
panel: could not claim access to parport0. Aborting.
panel: panel driver not yet registered
initcall panel_init_module+0x0/0x492 returned 0 after 2782 usecs
calling  lcd2s_i2c_driver_init+0x0/0x4b @ 1
initcall lcd2s_i2c_driver_init+0x0/0x4b returned 0 after 100 usecs
calling  nonstatic_sysfs_init+0x0/0x49 @ 1
initcall nonstatic_sysfs_init+0x0/0x49 returned 0 after 7 usecs
calling  i82092aa_module_init+0x0/0x50 @ 1
initcall i82092aa_module_init+0x0/0x50 returned 0 after 166 usecs
calling  usb_conn_driver_init+0x0/0x4b @ 1
initcall usb_conn_driver_init+0x0/0x4b returned 0 after 104 usecs
calling  gpio_vbus_driver_init+0x0/0x4b @ 1
initcall gpio_vbus_driver_init+0x0/0x4b returned 0 after 128 usecs
calling  dwc3_driver_init+0x0/0x4b @ 1
initcall dwc3_driver_init+0x0/0x4b returned 0 after 106 usecs
calling  dwc3_pci_driver_init+0x0/0x50 @ 1
initcall dwc3_pci_driver_init+0x0/0x50 returned 0 after 129 usecs
calling  dwc3_haps_driver_init+0x0/0x50 @ 1
initcall dwc3_haps_driver_init+0x0/0x50 returned 0 after 132 usecs
calling  dwc2_platform_driver_init+0x0/0x4b @ 1
initcall dwc2_platform_driver_init+0x0/0x4b returned 0 after 140 usecs
calling  dwc2_pci_driver_init+0x0/0x50 @ 1
initcall dwc2_pci_driver_init+0x0/0x50 returned 0 after 198 usecs
calling  mon_init+0x0/0x295 @ 1
initcall mon_init+0x0/0x295 returned 0 after 600 usecs
calling  oxu_driver_init+0x0/0x4b @ 1
initcall oxu_driver_init+0x0/0x4b returned 0 after 104 usecs
calling  isp116x_driver_init+0x0/0x4b @ 1
initcall isp116x_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  ohci_hcd_mod_init+0x0/0x188 @ 1
initcall ohci_hcd_mod_init+0x0/0x188 returned 0 after 99 usecs
calling  ohci_platform_init+0x0/0xa3 @ 1
initcall ohci_platform_init+0x0/0xa3 returned 0 after 91 usecs
calling  xhci_hcd_init+0x0/0x84 @ 1
initcall xhci_hcd_init+0x0/0x84 returned 0 after 2 usecs
calling  xhci_pci_init+0x0/0x6d @ 1
initcall xhci_pci_init+0x0/0x6d returned 0 after 138 usecs
calling  xhci_plat_init+0x0/0x68 @ 1
initcall xhci_plat_init+0x0/0x68 returned 0 after 119 usecs
calling  sl811h_driver_init+0x0/0x4b @ 1
initcall sl811h_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  sl811_cs_driver_init+0x0/0x49 @ 1
initcall sl811_cs_driver_init+0x0/0x49 returned 0 after 109 usecs
calling  r8a66597_driver_init+0x0/0x4b @ 1
initcall r8a66597_driver_init+0x0/0x4b returned 0 after 108 usecs
calling  bcma_hcd_driver_init+0x0/0x4b @ 1
initcall bcma_hcd_driver_init+0x0/0x4b returned 0 after 77 usecs
calling  ssb_hcd_init+0x0/0x4b @ 1
initcall ssb_hcd_init+0x0/0x4b returned 0 after 70 usecs
calling  fotg210_hcd_init+0x0/0x1fa @ 1
Warning! fotg210_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
initcall fotg210_hcd_init+0x0/0x1fa returned 0 after 1374 usecs
calling  c67x00_driver_init+0x0/0x4b @ 1
initcall c67x00_driver_init+0x0/0x4b returned 0 after 99 usecs
calling  acm_init+0x0/0x19e @ 1
usbcore: registered new interface driver cdc_acm
cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
initcall acm_init+0x0/0x19e returned 0 after 2219 usecs
calling  usblp_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver usblp
initcall usblp_driver_init+0x0/0x50 returned 0 after 1020 usecs
calling  wdm_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver cdc_wdm
initcall wdm_driver_init+0x0/0x50 returned 0 after 1009 usecs
calling  usbtmc_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver usbtmc
initcall usbtmc_driver_init+0x0/0x50 returned 0 after 1125 usecs
calling  usb_mdc800_init+0x0/0x49c @ 1
usbcore: registered new interface driver mdc800
mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800 Digital Camera
initcall usb_mdc800_init+0x0/0x49c returned 0 after 2833 usecs
calling  mts_usb_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver microtekX6
initcall mts_usb_driver_init+0x0/0x50 returned 0 after 1143 usecs
calling  usb_serial_init+0x0/0x251 @ 1
initcall usb_serial_init+0x0/0x251 returned 0 after 158 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver belkin_sa
usbserial: USB Serial support registered for Belkin / Peracom / GoHubs USB Serial Adapter
initcall usb_serial_module_init+0x0/0x53 returned 0 after 6850 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver cp210x
usbserial: USB Serial support registered for cp210x
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1731 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver cyberjack
usbserial: USB Serial support registered for Reiner SCT Cyberjack USB card reader
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1980 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver cypress_m8
usbserial: USB Serial support registered for DeLorme Earthmate USB
usbserial: USB Serial support registered for HID->COM RS232 Adapter
usbserial: USB Serial support registered for Nokia CA-42 V2 Adapter
initcall usb_serial_module_init+0x0/0x53 returned 0 after 3813 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver io_edgeport
usbserial: USB Serial support registered for Edgeport 2 port adapter
usbserial: USB Serial support registered for Edgeport 4 port adapter
usbserial: USB Serial support registered for Edgeport 8 port adapter
usbserial: USB Serial support registered for EPiC device
initcall usb_serial_module_init+0x0/0x53 returned 0 after 4745 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver empeg
usbserial: USB Serial support registered for empeg
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1686 usecs
calling  f81232_init+0x0/0xd1 @ 1
usbcore: registered new interface driver f81534a_ctrl
usbcore: registered new interface driver f81232
usbserial: USB Serial support registered for f81232
usbserial: USB Serial support registered for f81534a
initcall f81232_init+0x0/0xd1 returned 0 after 3478 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver garmin_gps
usbserial: USB Serial support registered for Garmin GPS usb/tty
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1837 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver ipaq
usbserial: USB Serial support registered for PocketPC PDA
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1690 usecs
calling  ir_init+0x0/0x85 @ 1
usbcore: registered new interface driver ir_usb
usbserial: USB Serial support registered for IR Dongle
initcall ir_init+0x0/0x85 returned 0 after 1765 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver iuu_phoenix
usbserial: USB Serial support registered for iuu_phoenix
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1782 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver keyspan
usbserial: USB Serial support registered for Keyspan - (without firmware)
usbserial: USB Serial support registered for Keyspan 1 port adapter
usbserial: USB Serial support registered for Keyspan 2 port adapter
usbserial: USB Serial support registered for Keyspan 4 port adapter
initcall usb_serial_module_init+0x0/0x53 returned 0 after 4942 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver keyspan_pda
usbserial: USB Serial support registered for Keyspan PDA
usbserial: USB Serial support registered for Keyspan PDA - (prerenumeration)
initcall usb_serial_module_init+0x0/0x53 returned 0 after 2960 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver kl5kusb105
usbserial: USB Serial support registered for KL5KUSB105D / PalmConnect
initcall usb_serial_module_init+0x0/0x53 returned 0 after 2103 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver mct_u232
usbserial: USB Serial support registered for MCT U232
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1779 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver mxuport
usbserial: USB Serial support registered for MOXA UPort
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1825 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver omninet
usbserial: USB Serial support registered for ZyXEL - omni.net usb
initcall usb_serial_module_init+0x0/0x53 returned 0 after 2008 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver opticon
usbserial: USB Serial support registered for opticon
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1425 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver qcaux
usbserial: USB Serial support registered for qcaux
initcall usb_serial_module_init+0x0/0x53 returned 0 after 5795 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver safe_serial
usbserial: USB Serial support registered for safe_serial
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1997 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver sierra
usbserial: USB Serial support registered for Sierra USB modem
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1917 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver usb_serial_simple
usbserial: USB Serial support registered for carelink
usbserial: USB Serial support registered for zio
usbserial: USB Serial support registered for funsoft
usbserial: USB Serial support registered for flashloader
usbserial: USB Serial support registered for google
usbserial: USB Serial support registered for libtransistor
usbserial: USB Serial support registered for vivopay
usbserial: USB Serial support registered for moto_modem
usbserial: USB Serial support registered for motorola_tetra
usbserial: USB Serial support registered for nokia
usbserial: USB Serial support registered for novatel_gps
usbserial: USB Serial support registered for hp4x
usbserial: USB Serial support registered for suunto
usbserial: USB Serial support registered for siemens_mpi
initcall usb_serial_module_init+0x0/0x53 returned 0 after 13437 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver spcp8x5
usbserial: USB Serial support registered for SPCP8x5
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1773 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver ssu100
usbserial: USB Serial support registered for Quatech SSU-100 USB to Serial Driver
initcall usb_serial_module_init+0x0/0x53 returned 0 after 2096 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver symbolserial
usbserial: USB Serial support registered for symbol
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1834 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver visor
usbserial: USB Serial support registered for Handspring Visor / Palm OS
usbserial: USB Serial support registered for Sony Clie 5.0
usbserial: USB Serial support registered for Sony Clie 3.5
initcall usb_serial_module_init+0x0/0x53 returned 0 after 3849 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver wishbone_serial
usbserial: USB Serial support registered for wishbone_serial
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1901 usecs
calling  usb_serial_module_init+0x0/0x53 @ 1
usbcore: registered new interface driver xsens_mt
usbserial: USB Serial support registered for xsens_mt
initcall usb_serial_module_init+0x0/0x53 returned 0 after 1806 usecs
calling  cypress_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver cypress_cy7c63
initcall cypress_driver_init+0x0/0x50 returned 0 after 942 usecs
calling  cytherm_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver cytherm
initcall cytherm_driver_init+0x0/0x50 returned 0 after 987 usecs
calling  emi26_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver emi26 - firmware loader
initcall emi26_driver_init+0x0/0x50 returned 0 after 1045 usecs
calling  emi62_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver emi62 - firmware loader
initcall emi62_driver_init+0x0/0x50 returned 0 after 1073 usecs
calling  mfi_fc_driver_init+0x0/0x4b @ 1
usbcore: registered new device driver apple-mfi-fastcharge
initcall mfi_fc_driver_init+0x0/0x4b returned 0 after 953 usecs
calling  idmouse_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver idmouse
initcall idmouse_driver_init+0x0/0x50 returned 0 after 928 usecs
calling  iowarrior_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver iowarrior
initcall iowarrior_driver_init+0x0/0x50 returned 0 after 881 usecs
calling  lcd_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver usblcd
initcall lcd_driver_init+0x0/0x50 returned 0 after 894 usecs
calling  tower_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver legousbtower
initcall tower_driver_init+0x0/0x50 returned 0 after 904 usecs
calling  tv_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver trancevibrator
initcall tv_driver_init+0x0/0x50 returned 0 after 942 usecs
calling  uss720_init+0x0/0xde @ 1
usbcore: registered new interface driver uss720
uss720: USB Parport Cable driver for Cables using the Lucent Technologies USS720 Chip
uss720: NOTE: this is a special purpose driver to allow nonstandard
uss720: protocols (eg. bitbang) over USS720 usb to parallel cables
uss720: If you just want to connect to a printer, use usblp instead
initcall uss720_init+0x0/0xde returned 0 after 6877 usecs
calling  sevseg_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver usbsevseg
initcall sevseg_driver_init+0x0/0x50 returned 0 after 949 usecs
calling  yurex_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver yurex
initcall yurex_driver_init+0x0/0x50 returned 0 after 887 usecs
calling  usb251xb_i2c_driver_init+0x0/0x4b @ 1
initcall usb251xb_i2c_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  usb3503_init+0x0/0x100 @ 1
initcall usb3503_init+0x0/0x100 returned 0 after 190 usecs
calling  usb4604_i2c_driver_init+0x0/0x4b @ 1
initcall usb4604_i2c_driver_init+0x0/0x4b returned 0 after 79 usecs
calling  usb_sisusb_init+0x0/0x50 @ 1
usbcore: registered new interface driver sisusb
initcall usb_sisusb_init+0x0/0x50 returned 0 after 871 usecs
calling  onboard_hub_init+0x0/0xc3 @ 1
usbcore: registered new device driver onboard-usb-hub
initcall onboard_hub_init+0x0/0xc3 returned 0 after 965 usecs
calling  musb_driver_init+0x0/0x4b @ 1
initcall musb_driver_init+0x0/0x4b returned 0 after 123 usecs
calling  gadget_cfs_init+0x0/0x61 @ 1
initcall gadget_cfs_init+0x0/0x61 returned 0 after 57 usecs
calling  dummy_hcd_init+0x0/0xc8e @ 1
dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.0: Dummy host controller
dummy_hcd dummy_hcd.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
initcall dummy_hcd_init+0x0/0xc8e returned 0 after 11016 usecs
calling  net2272_init+0x0/0xc9 @ 1
initcall net2272_init+0x0/0xc9 returned 0 after 322 usecs
calling  udc_driver_init+0x0/0x4b @ 1
initcall udc_driver_init+0x0/0x4b returned 0 after 112 usecs
calling  m66592_driver_init+0x0/0x50 @ 1
initcall m66592_driver_init+0x0/0x50 returned -19 after 150 usecs
calling  r8a66597_driver_init+0x0/0x50 @ 1
initcall r8a66597_driver_init+0x0/0x50 returned -19 after 160 usecs
calling  udc_driver_init+0x0/0x4b @ 1
initcall udc_driver_init+0x0/0x4b returned 0 after 115 usecs
calling  fusb300_driver_init+0x0/0x50 @ 1
initcall fusb300_driver_init+0x0/0x50 returned -19 after 164 usecs
calling  gr_driver_init+0x0/0x4b @ 1
initcall gr_driver_init+0x0/0x4b returned 0 after 139 usecs
calling  udc_plat_driver_init+0x0/0x4b @ 1
initcall udc_plat_driver_init+0x0/0x4b returned 0 after 119 usecs
calling  bdc_driver_init+0x0/0x4b @ 1
initcall bdc_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  max3420_driver_init+0x0/0x4b @ 1
SPI driver max3420-udc has no spi_device_id for maxim,max3421-udc
initcall max3420_driver_init+0x0/0x4b returned 0 after 1063 usecs
calling  acmmod_init+0x0/0x49 @ 1
initcall acmmod_init+0x0/0x49 returned 0 after 53 usecs
calling  sslb_modinit+0x0/0xbb @ 1
initcall sslb_modinit+0x0/0xbb returned 0 after 32 usecs
calling  userial_init+0x0/0x213 @ 1
userial_init: registered 8 ttyGS* devices
initcall userial_init+0x0/0x213 returned 0 after 755 usecs
calling  gsermod_init+0x0/0x49 @ 1
initcall gsermod_init+0x0/0x49 returned 0 after 5 usecs
calling  obexmod_init+0x0/0x49 @ 1
initcall obexmod_init+0x0/0x49 returned 0 after 5 usecs
calling  mass_storagemod_init+0x0/0x49 @ 1
initcall mass_storagemod_init+0x0/0x49 returned 0 after 4 usecs
calling  hidmod_init+0x0/0x49 @ 1
initcall hidmod_init+0x0/0x49 returned 0 after 4 usecs
calling  printermod_init+0x0/0x49 @ 1
initcall printermod_init+0x0/0x49 returned 0 after 4 usecs
calling  zero_driver_init+0x0/0x49 @ 1
udc dummy_udc.0: binding gadget driver [zero]
zero gadget.0: adding 'source/sink'/(ptrval) to config 'source/sink'/(ptrval)
zero gadget.0: dual speed source/sink: IN/ep1in-bulk, OUT/ep2out-bulk, ISO-IN/<none>, ISO-OUT/<none>
zero gadget.0: adding 'loopback'/(ptrval) to config 'loopback'/(ptrval)
zero gadget.0: dual speed loopback: IN/ep1in-bulk, OUT/ep2out-bulk
zero gadget.0: Gadget Zero, version: Cinco de Mayo 2008
zero gadget.0: zero ready
dummy_hcd dummy_hcd.0: port status 0x00010101 has changes
dummy_hcd dummy_hcd.0: port status 0x00010101 has changes
initcall zero_driver_init+0x0/0x49 returned 0 after 10257 usecs
calling  gadgetfs_init+0x0/0x99 @ 1
gadgetfs: USB Gadget filesystem, version 24 Aug 2004
initcall gadgetfs_init+0x0/0x99 returned 0 after 935 usecs
calling  gserial_init+0x0/0x104 @ 1
UDC core: g_serial: couldn't find an available UDC
initcall gserial_init+0x0/0x104 returned 0 after 1009 usecs
calling  printer_driver_init+0x0/0x49 @ 1
UDC core: printer: couldn't find an available UDC
initcall printer_driver_init+0x0/0x49 returned 0 after 929 usecs
calling  hidg_init+0x0/0xc7 @ 1
initcall hidg_init+0x0/0xc7 returned -19 after 174 usecs
calling  acm_ms_driver_init+0x0/0x49 @ 1
UDC core: g_acm_ms: couldn't find an available UDC
initcall acm_ms_driver_init+0x0/0x49 returned 0 after 937 usecs
calling  i8042_init+0x0/0x25f @ 1
i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
initcall i8042_init+0x0/0x25f returned 0 after 5359 usecs
calling  parkbd_parport_driver_init+0x0/0x50 @ 1
parport0: cannot grant exclusive access for device parkbd
initcall parkbd_parport_driver_init+0x0/0x50 returned 0 after 691 usecs
calling  serport_init+0x0/0x8d @ 1
initcall serport_init+0x0/0x8d returned 0 after 2 usecs
calling  ct82c710_init+0x0/0x1a2 @ 1
initcall ct82c710_init+0x0/0x1a2 returned -19 after 25 usecs
calling  pcips2_driver_init+0x0/0x50 @ 1
initcall pcips2_driver_init+0x0/0x50 returned 0 after 143 usecs
calling  ps2mult_drv_init+0x0/0x50 @ 1
initcall ps2mult_drv_init+0x0/0x50 returned 0 after 138 usecs
calling  serio_raw_drv_init+0x0/0x50 @ 1
initcall serio_raw_drv_init+0x0/0x50 returned 0 after 136 usecs
calling  altera_ps2_driver_init+0x0/0x4b @ 1
initcall altera_ps2_driver_init+0x0/0x4b returned 0 after 75 usecs
calling  apbps2_of_driver_init+0x0/0x4b @ 1
initcall apbps2_of_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  ps2_gpio_driver_init+0x0/0x4b @ 1
initcall ps2_gpio_driver_init+0x0/0x4b returned 0 after 84 usecs
calling  userio_misc_init+0x0/0x49 @ 1
initcall userio_misc_init+0x0/0x49 returned 0 after 360 usecs
calling  fm801_gp_driver_init+0x0/0x50 @ 1
initcall fm801_gp_driver_init+0x0/0x50 returned 0 after 138 usecs
calling  l4_init+0x0/0x14d @ 1
initcall l4_init+0x0/0x14d returned -19 after 38 usecs
calling  ns558_init+0x0/0x171 @ 1
initcall ns558_init+0x0/0x171 returned 0 after 47429 usecs
calling  input_leds_init+0x0/0x49 @ 1
initcall input_leds_init+0x0/0x49 returned 0 after 11 usecs
calling  joydev_init+0x0/0x49 @ 1
initcall joydev_init+0x0/0x49 returned 0 after 28 usecs
calling  evdev_init+0x0/0x49 @ 1
initcall evdev_init+0x0/0x49 returned 0 after 702 usecs
calling  evbug_init+0x0/0x49 @ 1
evbug: Connected device: input0 (Power Button at LNXPWRBN/button/input0)
initcall evbug_init+0x0/0x49 returned 0 after 1043 usecs
calling  atkbd_init+0x0/0x50 @ 1
initcall atkbd_init+0x0/0x50 returned 0 after 144 usecs
calling  ad7877_driver_init+0x0/0x4b @ 1
initcall ad7877_driver_init+0x0/0x4b returned 0 after 964 usecs
calling  ad7879_i2c_driver_init+0x0/0x4b @ 1
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
initcall ad7879_i2c_driver_init+0x0/0x4b returned 0 after 2599 usecs
calling  ad7879_spi_driver_init+0x0/0x4b @ 1
evbug: Connected device: input1 (AT Translated Set 2 keyboard at isa0060/serio0/input0)
initcall ad7879_spi_driver_init+0x0/0x4b returned 0 after 3156 usecs
calling  ads7846_driver_init+0x0/0x4b @ 1
SPI driver ads7846 has no spi_device_id for ti,tsc2046
SPI driver ads7846 has no spi_device_id for ti,ads7843
SPI driver ads7846 has no spi_device_id for ti,ads7845
SPI driver ads7846 has no spi_device_id for ti,ads7873
initcall ads7846_driver_init+0x0/0x4b returned 0 after 3241 usecs
calling  auo_pixcir_driver_init+0x0/0x4b @ 1
initcall auo_pixcir_driver_init+0x0/0x4b returned 0 after 89 usecs
calling  bu21013_driver_init+0x0/0x4b @ 1
initcall bu21013_driver_init+0x0/0x4b returned 0 after 77 usecs
calling  bu21029_driver_init+0x0/0x4b @ 1
initcall bu21029_driver_init+0x0/0x4b returned 0 after 73 usecs
calling  icn8318_driver_init+0x0/0x4b @ 1
initcall icn8318_driver_init+0x0/0x4b returned 0 after 101 usecs
calling  cy8ctma140_driver_init+0x0/0x4b @ 1
initcall cy8ctma140_driver_init+0x0/0x4b returned 0 after 75 usecs
calling  cyttsp_spi_driver_init+0x0/0x4b @ 1
SPI driver cyttsp-spi has no spi_device_id for cypress,cy8ctma340
SPI driver cyttsp-spi has no spi_device_id for cypress,cy8ctst341
initcall cyttsp_spi_driver_init+0x0/0x4b returned 0 after 1893 usecs
calling  da9052_tsi_driver_init+0x0/0x4b @ 1
initcall da9052_tsi_driver_init+0x0/0x4b returned 0 after 137 usecs
calling  hampshire_drv_init+0x0/0x50 @ 1
initcall hampshire_drv_init+0x0/0x50 returned 0 after 125 usecs
calling  hycon_hy46xx_driver_init+0x0/0x4b @ 1
initcall hycon_hy46xx_driver_init+0x0/0x4b returned 0 after 140 usecs
calling  gunze_drv_init+0x0/0x50 @ 1
initcall gunze_drv_init+0x0/0x50 returned 0 after 129 usecs
calling  eeti_ts_driver_init+0x0/0x4b @ 1
initcall eeti_ts_driver_init+0x0/0x4b returned 0 after 137 usecs
calling  elants_i2c_driver_init+0x0/0x4b @ 1
initcall elants_i2c_driver_init+0x0/0x4b returned 0 after 100 usecs
calling  egalax_drv_init+0x0/0x50 @ 1
initcall egalax_drv_init+0x0/0x50 returned 0 after 173 usecs
calling  exc3000_driver_init+0x0/0x4b @ 1
initcall exc3000_driver_init+0x0/0x4b returned 0 after 131 usecs
calling  fujitsu_drv_init+0x0/0x50 @ 1
initcall fujitsu_drv_init+0x0/0x50 returned 0 after 112 usecs
calling  goodix_ts_driver_init+0x0/0x4b @ 1
initcall goodix_ts_driver_init+0x0/0x4b returned 0 after 160 usecs
calling  imagis_ts_driver_init+0x0/0x4b @ 1
initcall imagis_ts_driver_init+0x0/0x4b returned 0 after 80 usecs
calling  inexio_drv_init+0x0/0x50 @ 1
initcall inexio_drv_init+0x0/0x50 returned 0 after 128 usecs
calling  max11801_ts_driver_init+0x0/0x4b @ 1
initcall max11801_ts_driver_init+0x0/0x4b returned 0 after 147 usecs
calling  mip4_driver_init+0x0/0x4b @ 1
initcall mip4_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  mms114_driver_init+0x0/0x4b @ 1
initcall mms114_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  mtouch_drv_init+0x0/0x50 @ 1
initcall mtouch_drv_init+0x0/0x50 returned 0 after 136 usecs
calling  mk712_init+0x0/0x35a @ 1
mk712: device not present
initcall mk712_init+0x0/0x35a returned -19 after 577 usecs
calling  usbtouch_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver usbtouchscreen
initcall usbtouch_driver_init+0x0/0x50 returned 0 after 1022 usecs
calling  pm_drv_init+0x0/0x50 @ 1
initcall pm_drv_init+0x0/0x50 returned 0 after 163 usecs
calling  pixcir_i2c_ts_driver_init+0x0/0x4b @ 1
initcall pixcir_i2c_ts_driver_init+0x0/0x4b returned 0 after 143 usecs
calling  s6sy761_driver_init+0x0/0x4b @ 1
initcall s6sy761_driver_init+0x0/0x4b returned 0 after 80 usecs
calling  silead_ts_driver_init+0x0/0x4b @ 1
initcall silead_ts_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  st1232_ts_driver_init+0x0/0x4b @ 1
initcall st1232_ts_driver_init+0x0/0x4b returned 0 after 75 usecs
calling  touchit213_drv_init+0x0/0x50 @ 1
zero gadget.0: resume
initcall touchit213_drv_init+0x0/0x50 returned 0 after 129 usecs
zero gadget.0: zero_resume
calling  tw_drv_init+0x0/0x50 @ 1
dummy_hcd dummy_hcd.0: port status 0x00100503 has changes
initcall tw_drv_init+0x0/0x50 returned 0 after 160 usecs
calling  tsc2005_driver_init+0x0/0x4b @ 1
initcall tsc2005_driver_init+0x0/0x4b returned 0 after 119 usecs
calling  tsc2007_driver_init+0x0/0x4b @ 1
initcall tsc2007_driver_init+0x0/0x4b returned 0 after 84 usecs
calling  wdt87xx_driver_init+0x0/0x4b @ 1
initcall wdt87xx_driver_init+0x0/0x4b returned 0 after 75 usecs
calling  wm831x_ts_driver_init+0x0/0x4b @ 1
initcall wm831x_ts_driver_init+0x0/0x4b returned 0 after 136 usecs
calling  sx8654_driver_init+0x0/0x4b @ 1
initcall sx8654_driver_init+0x0/0x4b returned 0 after 78 usecs
calling  tps6507x_ts_driver_init+0x0/0x4b @ 1
initcall tps6507x_ts_driver_init+0x0/0x4b returned 0 after 158 usecs
calling  zet6223_driver_init+0x0/0x4b @ 1
initcall zet6223_driver_init+0x0/0x4b returned 0 after 79 usecs
calling  zforce_driver_init+0x0/0x4b @ 1
initcall zforce_driver_init+0x0/0x4b returned 0 after 88 usecs
calling  iqs5xx_i2c_driver_init+0x0/0x4b @ 1
initcall iqs5xx_i2c_driver_init+0x0/0x4b returned 0 after 75 usecs
calling  zinitix_ts_driver_init+0x0/0x4b @ 1
initcall zinitix_ts_driver_init+0x0/0x4b returned 0 after 68 usecs
calling  rmi_bus_init+0x0/0x240 @ 1
initcall rmi_bus_init+0x0/0x240 returned 0 after 492 usecs
calling  rmi_i2c_driver_init+0x0/0x4b @ 1
initcall rmi_i2c_driver_init+0x0/0x4b returned 0 after 78 usecs
calling  rmi_smb_driver_init+0x0/0x4b @ 1
initcall rmi_smb_driver_init+0x0/0x4b returned 0 after 81 usecs
calling  smbalert_driver_init+0x0/0x4b @ 1
initcall smbalert_driver_init+0x0/0x4b returned 0 after 77 usecs
calling  i2c_dev_init+0x0/0x19c @ 1
i2c_dev: i2c /dev entries driver
initcall i2c_dev_init+0x0/0x19c returned 0 after 611 usecs
calling  ali1535_driver_init+0x0/0x50 @ 1
initcall ali1535_driver_init+0x0/0x50 returned 0 after 127 usecs
calling  ali1563_pci_driver_init+0x0/0x50 @ 1
initcall ali1563_pci_driver_init+0x0/0x50 returned 0 after 111 usecs
calling  ali15x3_driver_init+0x0/0x50 @ 1
initcall ali15x3_driver_init+0x0/0x50 returned 0 after 109 usecs
calling  nforce2_driver_init+0x0/0x50 @ 1
initcall nforce2_driver_init+0x0/0x50 returned 0 after 137 usecs
calling  nforce2_s4985_init+0x0/0x42b @ 1
initcall nforce2_s4985_init+0x0/0x42b returned -19 after 1 usecs
calling  gpu_i2c_driver_init+0x0/0x50 @ 1
initcall gpu_i2c_driver_init+0x0/0x50 returned 0 after 141 usecs
calling  piix4_driver_init+0x0/0x50 @ 1
piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
initcall piix4_driver_init+0x0/0x50 returned 0 after 4821 usecs
calling  sis630_driver_init+0x0/0x50 @ 1
initcall sis630_driver_init+0x0/0x50 returned 0 after 168 usecs
calling  sis96x_driver_init+0x0/0x50 @ 1
initcall sis96x_driver_init+0x0/0x50 returned 0 after 112 usecs
calling  vt586b_driver_init+0x0/0x50 @ 1
initcall vt586b_driver_init+0x0/0x50 returned 0 after 108 usecs
calling  i2c_vt596_init+0x0/0x50 @ 1
initcall i2c_vt596_init+0x0/0x50 returned 0 after 99 usecs
calling  cbus_i2c_driver_init+0x0/0x4b @ 1
initcall cbus_i2c_driver_init+0x0/0x4b returned 0 after 135 usecs
calling  dw_i2c_driver_init+0x0/0x50 @ 1
usb 1-1: new high-speed USB device number 2 using dummy_hcd
initcall dw_i2c_driver_init+0x0/0x50 returned 0 after 120 usecs
calling  em_i2c_driver_init+0x0/0x4b @ 1
initcall em_i2c_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  kempld_i2c_driver_init+0x0/0x4b @ 1
initcall kempld_i2c_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  ce4100_i2c_driver_init+0x0/0x50 @ 1
initcall ce4100_i2c_driver_init+0x0/0x50 returned 0 after 127 usecs
calling  simtec_i2c_driver_init+0x0/0x4b @ 1
initcall simtec_i2c_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  diolan_u2c_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver i2c-diolan-u2c
initcall diolan_u2c_driver_init+0x0/0x50 returned 0 after 968 usecs
calling  cp2615_i2c_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver i2c-cp2615
initcall cp2615_i2c_driver_init+0x0/0x50 returned 0 after 933 usecs
calling  i2c_parport_driver_init+0x0/0x50 @ 1
i2c-parport: adapter type unspecified
initcall i2c_parport_driver_init+0x0/0x50 returned 0 after 785 usecs
calling  pci1xxxx_i2c_pci_driver_init+0x0/0x50 @ 1
initcall pci1xxxx_i2c_pci_driver_init+0x0/0x50 returned 0 after 117 usecs
calling  osif_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver RobotFuzz Open Source InterFace, OSIF
initcall osif_driver_init+0x0/0x50 returned 0 after 1149 usecs
calling  taos_drv_init+0x0/0x50 @ 1
initcall taos_drv_init+0x0/0x50 returned 0 after 170 usecs
calling  i2c_tiny_usb_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver i2c-tiny-usb
initcall i2c_tiny_usb_driver_init+0x0/0x50 returned 0 after 965 usecs
calling  fsi_i2c_driver_init+0x0/0x49 @ 1
initcall fsi_i2c_driver_init+0x0/0x49 returned 0 after 65 usecs
calling  virtio_i2c_driver_init+0x0/0x49 @ 1
initcall virtio_i2c_driver_init+0x0/0x49 returned 0 after 67 usecs
calling  i2c_slave_eeprom_driver_init+0x0/0x4b @ 1
initcall i2c_slave_eeprom_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  cdns_i3c_master_init+0x0/0x4b @ 1
initcall cdns_i3c_master_init+0x0/0x4b returned 0 after 113 usecs
calling  dw_i3c_driver_init+0x0/0x4b @ 1
initcall dw_i3c_driver_init+0x0/0x4b returned 0 after 126 usecs
calling  svc_i3c_master_init+0x0/0x4b @ 1
initcall svc_i3c_master_init+0x0/0x4b returned 0 after 95 usecs
calling  i3c_hci_driver_init+0x0/0x4b @ 1
initcall i3c_hci_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  init_rc_map_adstech_dvb_t_pci+0x0/0x49 @ 1
initcall init_rc_map_adstech_dvb_t_pci+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_alink_dtu_m+0x0/0x49 @ 1
initcall init_rc_map_alink_dtu_m+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_anysee+0x0/0x49 @ 1
initcall init_rc_map_anysee+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_apac_viewcomp+0x0/0x49 @ 1
initcall init_rc_map_apac_viewcomp+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_t2hybrid+0x0/0x49 @ 1
initcall init_rc_map_t2hybrid+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_asus_pc39+0x0/0x49 @ 1
initcall init_rc_map_asus_pc39+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_asus_ps3_100+0x0/0x49 @ 1
initcall init_rc_map_asus_ps3_100+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_ati_tv_wonder_hd_600+0x0/0x49 @ 1
initcall init_rc_map_ati_tv_wonder_hd_600+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_ati_x10+0x0/0x49 @ 1
initcall init_rc_map_ati_x10+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_avermedia_a16d+0x0/0x49 @ 1
initcall init_rc_map_avermedia_a16d+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_avermedia_cardbus+0x0/0x49 @ 1
initcall init_rc_map_avermedia_cardbus+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_avermedia_dvbt+0x0/0x49 @ 1
initcall init_rc_map_avermedia_dvbt+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_avermedia_m135a+0x0/0x49 @ 1
initcall init_rc_map_avermedia_m135a+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_avermedia_m733a_rm_k6+0x0/0x49 @ 1
initcall init_rc_map_avermedia_m733a_rm_k6+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_avermedia+0x0/0x49 @ 1
initcall init_rc_map_avermedia+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_avermedia_rm_ks+0x0/0x49 @ 1
initcall init_rc_map_avermedia_rm_ks+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_avertv_303+0x0/0x49 @ 1
zero gadget.0: resume
initcall init_rc_map_avertv_303+0x0/0x49 returned 0 after 2 usecs
zero gadget.0: zero_resume
dummy_hcd dummy_hcd.0: port status 0x00100503 has changes
calling  init_rc_map_azurewave_ad_tu700+0x0/0x49 @ 1
initcall init_rc_map_azurewave_ad_tu700+0x0/0x49 returned 0 after 4 usecs
calling  init_rc_map_beelink_gs1+0x0/0x49 @ 1
initcall init_rc_map_beelink_gs1+0x0/0x49 returned 0 after 4 usecs
calling  init_rc_map_behold_columbus+0x0/0x49 @ 1
initcall init_rc_map_behold_columbus+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_behold+0x0/0x49 @ 1
initcall init_rc_map_behold+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_budget_ci_old+0x0/0x49 @ 1
initcall init_rc_map_budget_ci_old+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_cinergy_1400+0x0/0x49 @ 1
initcall init_rc_map_cinergy_1400+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_cinergy+0x0/0x49 @ 1
initcall init_rc_map_cinergy+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_ct_90405+0x0/0x49 @ 1
initcall init_rc_map_ct_90405+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_d680_dmb+0x0/0x49 @ 1
initcall init_rc_map_d680_dmb+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_delock_61959+0x0/0x49 @ 1
initcall init_rc_map_delock_61959+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map+0x0/0x49 @ 1
initcall init_rc_map+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map+0x0/0x49 @ 1
initcall init_rc_map+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_digitalnow_tinytwin+0x0/0x49 @ 1
initcall init_rc_map_digitalnow_tinytwin+0x0/0x49 returned 0 after 4 usecs
calling  init_rc_map_digittrade+0x0/0x49 @ 1
initcall init_rc_map_digittrade+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_dm1105_nec+0x0/0x49 @ 1
initcall init_rc_map_dm1105_nec+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_dntv_live_dvb_t+0x0/0x49 @ 1
initcall init_rc_map_dntv_live_dvb_t+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_dntv_live_dvbt_pro+0x0/0x49 @ 1
initcall init_rc_map_dntv_live_dvbt_pro+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_dtt200u+0x0/0x49 @ 1
initcall init_rc_map_dtt200u+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_rc5_dvbsky+0x0/0x49 @ 1
initcall init_rc_map_rc5_dvbsky+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_dvico_mce+0x0/0x49 @ 1
initcall init_rc_map_dvico_mce+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_dvico_portable+0x0/0x49 @ 1
initcall init_rc_map_dvico_portable+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_em_terratec+0x0/0x49 @ 1
initcall init_rc_map_em_terratec+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_encore_enltv2+0x0/0x49 @ 1
initcall init_rc_map_encore_enltv2+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_encore_enltv_fm53+0x0/0x49 @ 1
initcall init_rc_map_encore_enltv_fm53+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_encore_enltv+0x0/0x49 @ 1
initcall init_rc_map_encore_enltv+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_evga_indtube+0x0/0x49 @ 1
initcall init_rc_map_evga_indtube+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_eztv+0x0/0x49 @ 1
initcall init_rc_map_eztv+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_flydvb+0x0/0x49 @ 1
initcall init_rc_map_flydvb+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_flyvideo+0x0/0x49 @ 1
initcall init_rc_map_flyvideo+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_fusionhdtv_mce+0x0/0x49 @ 1
initcall init_rc_map_fusionhdtv_mce+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_gadmei_rm008z+0x0/0x49 @ 1
dummy_udc dummy_udc.0: set_address = 2
initcall init_rc_map_gadmei_rm008z+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_geekbox+0x0/0x49 @ 1
initcall init_rc_map_geekbox+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_genius_tvgo_a11mce+0x0/0x49 @ 1
initcall init_rc_map_genius_tvgo_a11mce+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_gotview7135+0x0/0x49 @ 1
initcall init_rc_map_gotview7135+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_rc5_hauppauge_new+0x0/0x49 @ 1
initcall init_rc_map_rc5_hauppauge_new+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_hisi_poplar+0x0/0x49 @ 1
initcall init_rc_map_hisi_poplar+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_hisi_tv_demo+0x0/0x49 @ 1
initcall init_rc_map_hisi_tv_demo+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_imon_mce+0x0/0x49 @ 1
initcall init_rc_map_imon_mce+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_imon_pad+0x0/0x49 @ 1
initcall init_rc_map_imon_pad+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_imon_rsc+0x0/0x49 @ 1
initcall init_rc_map_imon_rsc+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_iodata_bctv7e+0x0/0x49 @ 1
initcall init_rc_map_iodata_bctv7e+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_it913x_v1_map+0x0/0x49 @ 1
initcall init_rc_it913x_v1_map+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_it913x_v2_map+0x0/0x49 @ 1
initcall init_rc_it913x_v2_map+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_kaiomy+0x0/0x49 @ 1
initcall init_rc_map_kaiomy+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_khadas+0x0/0x49 @ 1
initcall init_rc_map_khadas+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_khamsin+0x0/0x49 @ 1
initcall init_rc_map_khamsin+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_kworld_315u+0x0/0x49 @ 1
initcall init_rc_map_kworld_315u+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_kworld_pc150u+0x0/0x49 @ 1
initcall init_rc_map_kworld_pc150u+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_kworld_plus_tv_analog+0x0/0x49 @ 1
initcall init_rc_map_kworld_plus_tv_analog+0x0/0x49 returned 0 after 3 usecs
zero gadget.0: high-speed config #3: source/sink
calling  init_rc_map_leadtek_y04g0051+0x0/0x49 @ 1
zero gadget.0: source/sink disabled
initcall init_rc_map_leadtek_y04g0051+0x0/0x49 returned 0 after 3 usecs
dummy_udc dummy_udc.0: enabled ep1in-bulk (ep1in-bulk) maxpacket 512 stream disabled
dummy_udc dummy_udc.0: enabled ep2out-bulk (ep2out-bulk) maxpacket 512 stream disabled
calling  init_rc_lme2510_map+0x0/0x49 @ 1
zero gadget.0: source/sink enabled, alt intf 0
initcall init_rc_lme2510_map+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_manli+0x0/0x49 @ 1
initcall init_rc_map_manli+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_mecool_kiii_pro+0x0/0x49 @ 1
initcall init_rc_map_mecool_kiii_pro+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_mecool_kii_pro+0x0/0x49 @ 1
initcall init_rc_map_mecool_kii_pro+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_medion_x10_digitainer+0x0/0x49 @ 1
initcall init_rc_map_medion_x10_digitainer+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_medion_x10+0x0/0x49 @ 1
initcall init_rc_map_medion_x10+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_medion_x10_or2x+0x0/0x49 @ 1
initcall init_rc_map_medion_x10_or2x+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_minix_neo+0x0/0x49 @ 1
initcall init_rc_map_minix_neo+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_msi_digivox_iii+0x0/0x49 @ 1
initcall init_rc_map_msi_digivox_iii+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_msi_digivox_ii+0x0/0x49 @ 1
initcall init_rc_map_msi_digivox_ii+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_msi_tvanywhere+0x0/0x49 @ 1
initcall init_rc_map_msi_tvanywhere+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_msi_tvanywhere_plus+0x0/0x49 @ 1
initcall init_rc_map_msi_tvanywhere_plus+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_nebula+0x0/0x49 @ 1
initcall init_rc_map_nebula+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_nec_terratec_cinergy_xs+0x0/0x49 @ 1
initcall init_rc_map_nec_terratec_cinergy_xs+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_norwood+0x0/0x49 @ 1
initcall init_rc_map_norwood+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_npgtech+0x0/0x49 @ 1
initcall init_rc_map_npgtech+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_odroid+0x0/0x49 @ 1
initcall init_rc_map_odroid+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_pctv_sedna+0x0/0x49 @ 1
initcall init_rc_map_pctv_sedna+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_pine64+0x0/0x49 @ 1
initcall init_rc_map_pine64+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_pinnacle_color+0x0/0x49 @ 1
initcall init_rc_map_pinnacle_color+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_pinnacle_grey+0x0/0x49 @ 1
initcall init_rc_map_pinnacle_grey+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_pinnacle_pctv_hd+0x0/0x49 @ 1
initcall init_rc_map_pinnacle_pctv_hd+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_pixelview+0x0/0x49 @ 1
initcall init_rc_map_pixelview+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_pixelview+0x0/0x49 @ 1
initcall init_rc_map_pixelview+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_pixelview_new+0x0/0x49 @ 1
initcall init_rc_map_pixelview_new+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_pixelview+0x0/0x49 @ 1
initcall init_rc_map_pixelview+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_powercolor_real_angel+0x0/0x49 @ 1
initcall init_rc_map_powercolor_real_angel+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_proteus_2309+0x0/0x49 @ 1
initcall init_rc_map_proteus_2309+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_purpletv+0x0/0x49 @ 1
initcall init_rc_map_purpletv+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_pv951+0x0/0x49 @ 1
initcall init_rc_map_pv951+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_rc6_mce+0x0/0x49 @ 1
initcall init_rc_map_rc6_mce+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_real_audio_220_32_keys+0x0/0x49 @ 1
initcall init_rc_map_real_audio_220_32_keys+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_reddo+0x0/0x49 @ 1
initcall init_rc_map_reddo+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_snapstream_firefly+0x0/0x49 @ 1
initcall init_rc_map_snapstream_firefly+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_streamzap+0x0/0x49 @ 1
initcall init_rc_map_streamzap+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_su3000+0x0/0x49 @ 1
initcall init_rc_map_su3000+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_tanix_tx3mini+0x0/0x49 @ 1
initcall init_rc_map_tanix_tx3mini+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_tanix_tx5max+0x0/0x49 @ 1
initcall init_rc_map_tanix_tx5max+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_tbs_nec+0x0/0x49 @ 1
initcall init_rc_map_tbs_nec+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map+0x0/0x49 @ 1
initcall init_rc_map+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map+0x0/0x49 @ 1
initcall init_rc_map+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_terratec_cinergy_c_pci+0x0/0x49 @ 1
initcall init_rc_map_terratec_cinergy_c_pci+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_terratec_cinergy_s2_hd+0x0/0x49 @ 1
initcall init_rc_map_terratec_cinergy_s2_hd+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_terratec_cinergy_xs+0x0/0x49 @ 1
initcall init_rc_map_terratec_cinergy_xs+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_terratec_slim_2+0x0/0x49 @ 1
initcall init_rc_map_terratec_slim_2+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_terratec_slim+0x0/0x49 @ 1
initcall init_rc_map_terratec_slim+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_tevii_nec+0x0/0x49 @ 1
initcall init_rc_map_tevii_nec+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_tivo+0x0/0x49 @ 1
initcall init_rc_map_tivo+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_total_media_in_hand_02+0x0/0x49 @ 1
initcall init_rc_map_total_media_in_hand_02+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_total_media_in_hand+0x0/0x49 @ 1
initcall init_rc_map_total_media_in_hand+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_trekstor+0x0/0x49 @ 1
initcall init_rc_map_trekstor+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_tt_1500+0x0/0x49 @ 1
initcall init_rc_map_tt_1500+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_twinhan_vp1027+0x0/0x49 @ 1
initcall init_rc_map_twinhan_vp1027+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_twinhan_dtv_cab_ci+0x0/0x49 @ 1
initcall init_rc_map_twinhan_dtv_cab_ci+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_vega_s9x+0x0/0x49 @ 1
initcall init_rc_map_vega_s9x+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_videomate_k100+0x0/0x49 @ 1
initcall init_rc_map_videomate_k100+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_videomate_s350+0x0/0x49 @ 1
initcall init_rc_map_videomate_s350+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_videomate_tv_pvr+0x0/0x49 @ 1
initcall init_rc_map_videomate_tv_pvr+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_kii_pro+0x0/0x49 @ 1
initcall init_rc_map_kii_pro+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_wetek_hub+0x0/0x49 @ 1
initcall init_rc_map_wetek_hub+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_wetek_play2+0x0/0x49 @ 1
initcall init_rc_map_wetek_play2+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_winfast+0x0/0x49 @ 1
initcall init_rc_map_winfast+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_winfast_usbii_deluxe+0x0/0x49 @ 1
initcall init_rc_map_winfast_usbii_deluxe+0x0/0x49 returned 0 after 2 usecs
calling  init_rc_map_x96max+0x0/0x49 @ 1
initcall init_rc_map_x96max+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map+0x0/0x49 @ 1
initcall init_rc_map+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map+0x0/0x49 @ 1
initcall init_rc_map+0x0/0x49 returned 0 after 3 usecs
calling  init_rc_map_zx_irdec+0x0/0x49 @ 1
initcall init_rc_map_zx_irdec+0x0/0x49 returned 0 after 3 usecs
calling  ir_jvc_decode_init+0x0/0x64 @ 1
IR JVC protocol handler initialized
initcall ir_jvc_decode_init+0x0/0x64 returned 0 after 723 usecs
calling  ir_rc5_decode_init+0x0/0x64 @ 1
IR RC5(x/sz) protocol handler initialized
initcall ir_rc5_decode_init+0x0/0x64 returned 0 after 698 usecs
calling  ir_rc6_decode_init+0x0/0x64 @ 1
IR RC6 protocol handler initialized
initcall ir_rc6_decode_init+0x0/0x64 returned 0 after 615 usecs
calling  ir_rcmm_decode_init+0x0/0x64 @ 1
IR RCMM protocol handler initialized
initcall ir_rcmm_decode_init+0x0/0x64 returned 0 after 645 usecs
calling  ir_sanyo_decode_init+0x0/0x64 @ 1
IR SANYO protocol handler initialized
initcall ir_sanyo_decode_init+0x0/0x64 returned 0 after 671 usecs
calling  ir_sharp_decode_init+0x0/0x64 @ 1
IR Sharp protocol handler initialized
initcall ir_sharp_decode_init+0x0/0x64 returned 0 after 642 usecs
calling  ir_xmp_decode_init+0x0/0x64 @ 1
IR XMP protocol handler initialized
initcall ir_xmp_decode_init+0x0/0x64 returned 0 after 614 usecs
calling  gpio_ir_recv_driver_init+0x0/0x4b @ 1
initcall gpio_ir_recv_driver_init+0x0/0x4b returned 0 after 138 usecs
calling  gpio_ir_tx_driver_init+0x0/0x4b @ 1
initcall gpio_ir_tx_driver_init+0x0/0x4b returned 0 after 104 usecs
calling  iguanair_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver iguanair
initcall iguanair_driver_init+0x0/0x50 returned 0 after 889 usecs
calling  imon_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver imon
initcall imon_driver_init+0x0/0x50 returned 0 after 918 usecs
calling  imon_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver imon_raw
initcall imon_driver_init+0x0/0x50 returned 0 after 915 usecs
calling  ir_spi_driver_init+0x0/0x4b @ 1
SPI driver ir-spi has no spi_device_id for ir-spi-led
initcall ir_spi_driver_init+0x0/0x4b returned 0 after 993 usecs
calling  streamzap_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver streamzap
initcall streamzap_driver_init+0x0/0x50 returned 0 after 921 usecs
calling  irtoy_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver ir_toy
initcall irtoy_driver_init+0x0/0x50 returned 0 after 912 usecs
calling  ttusbir_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver ttusbir
initcall ttusbir_driver_init+0x0/0x50 returned 0 after 907 usecs
calling  ati_remote_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver ati_remote
initcall ati_remote_driver_init+0x0/0x50 returned 0 after 941 usecs
calling  loop_init+0x0/0x229 @ 1
Registered IR keymap rc-empty
rc rc0: rc-core loopback device as /devices/virtual/rc/rc0
rc rc0: lirc_dev: driver rc-loopback registered at minor = 0, raw IR receiver, raw IR transmitter
input: rc-core loopback device as /devices/virtual/rc/rc0/input3
evbug: Connected device: input3 (rc-core loopback device at rc-core/virtual)
initcall loop_init+0x0/0x229 returned 0 after 6217 usecs
calling  ch7322_i2c_driver_init+0x0/0x4b @ 1
initcall ch7322_i2c_driver_init+0x0/0x4b returned 0 after 129 usecs
calling  pulse8_drv_init+0x0/0x50 @ 1
initcall pulse8_drv_init+0x0/0x50 returned 0 after 171 usecs
calling  rain_drv_init+0x0/0x50 @ 1
initcall rain_drv_init+0x0/0x50 returned 0 after 198 usecs
calling  w1_init+0x0/0x198 @ 1
Driver for 1-wire Dallas network protocol.
initcall w1_init+0x0/0x198 returned 0 after 975 usecs
calling  ds_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver DS9490R
initcall ds_driver_init+0x0/0x50 returned 0 after 840 usecs
calling  w1_therm_init+0x0/0xf6 @ 1
initcall w1_therm_init+0x0/0xf6 returned 0 after 90 usecs
calling  w1_smem_init+0x0/0xc0 @ 1
initcall w1_smem_init+0x0/0xc0 returned 0 after 8 usecs
calling  w1_family_ds2405_init+0x0/0x49 @ 1
initcall w1_family_ds2405_init+0x0/0x49 returned 0 after 5 usecs
calling  w1_family_3a_init+0x0/0x49 @ 1
initcall w1_family_3a_init+0x0/0x49 returned 0 after 5 usecs
calling  w1_family_12_init+0x0/0x49 @ 1
initcall w1_family_12_init+0x0/0x49 returned 0 after 5 usecs
calling  w1_family_1d_init+0x0/0x49 @ 1
initcall w1_family_1d_init+0x0/0x49 returned 0 after 5 usecs
calling  w1_family_2d_init+0x0/0x49 @ 1
initcall w1_family_2d_init+0x0/0x49 returned 0 after 6 usecs
calling  w1_family_0d_init+0x0/0x49 @ 1
initcall w1_family_0d_init+0x0/0x49 returned 0 after 6 usecs
calling  w1_family_23_init+0x0/0x49 @ 1
initcall w1_family_23_init+0x0/0x49 returned 0 after 6 usecs
calling  w1_ds2438_family_init+0x0/0x49 @ 1
initcall w1_ds2438_family_init+0x0/0x49 returned 0 after 5 usecs
calling  w1_ds250x_init+0x0/0x170 @ 1
initcall w1_ds250x_init+0x0/0x170 returned 0 after 13 usecs
calling  w1_ds2780_family_init+0x0/0x49 @ 1
initcall w1_ds2780_family_init+0x0/0x49 returned 0 after 5 usecs
calling  w1_ds2781_family_init+0x0/0x49 @ 1
initcall w1_ds2781_family_init+0x0/0x49 returned 0 after 6 usecs
calling  pda_power_pdrv_init+0x0/0x4b @ 1
initcall pda_power_pdrv_init+0x0/0x4b returned 0 after 175 usecs
calling  ip5xxx_power_driver_init+0x0/0x4b @ 1
initcall ip5xxx_power_driver_init+0x0/0x4b returned 0 after 94 usecs
calling  wm831x_backup_driver_init+0x0/0x4b @ 1
initcall wm831x_backup_driver_init+0x0/0x4b returned 0 after 106 usecs
calling  wm831x_power_driver_init+0x0/0x4b @ 1
initcall wm831x_power_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  adp5061_driver_init+0x0/0x4b @ 1
initcall adp5061_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  act8945a_charger_driver_init+0x0/0x4b @ 1
initcall act8945a_charger_driver_init+0x0/0x4b returned 0 after 105 usecs
calling  cw_bat_driver_init+0x0/0x4b @ 1
initcall cw_bat_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  w1_ds2760_family_init+0x0/0x49 @ 1
initcall w1_ds2760_family_init+0x0/0x49 returned 0 after 8 usecs
calling  ds2780_battery_driver_init+0x0/0x4b @ 1
initcall ds2780_battery_driver_init+0x0/0x4b returned 0 after 117 usecs
calling  ds278x_battery_driver_init+0x0/0x4b @ 1
initcall ds278x_battery_driver_init+0x0/0x4b returned 0 after 95 usecs
calling  goldfish_battery_device_init+0x0/0x4b @ 1
initcall goldfish_battery_device_init+0x0/0x4b returned 0 after 113 usecs
calling  sbs_battery_driver_init+0x0/0x4b @ 1
initcall sbs_battery_driver_init+0x0/0x4b returned 0 after 114 usecs
calling  bq27xxx_battery_i2c_driver_init+0x0/0x4b @ 1
initcall bq27xxx_battery_i2c_driver_init+0x0/0x4b returned 0 after 81 usecs
calling  bq27xxx_battery_hdq_init+0x0/0x76 @ 1
initcall bq27xxx_battery_hdq_init+0x0/0x76 returned -17 after 7 usecs
calling  da9150_fg_driver_init+0x0/0x4b @ 1
initcall da9150_fg_driver_init+0x0/0x4b returned 0 after 120 usecs
calling  max17040_i2c_driver_init+0x0/0x4b @ 1
initcall max17040_i2c_driver_init+0x0/0x4b returned 0 after 95 usecs
calling  max17042_i2c_driver_init+0x0/0x4b @ 1
initcall max17042_i2c_driver_init+0x0/0x4b returned 0 after 83 usecs
calling  w1_max1721x_family_init+0x0/0x49 @ 1
initcall w1_max1721x_family_init+0x0/0x49 returned -17 after 7 usecs
calling  rt9455_driver_init+0x0/0x4b @ 1
initcall rt9455_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  max8903_driver_init+0x0/0x4b @ 1
initcall max8903_driver_init+0x0/0x4b returned 0 after 127 usecs
calling  lp8727_driver_init+0x0/0x4b @ 1
initcall lp8727_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  gpio_charger_driver_init+0x0/0x4b @ 1
initcall gpio_charger_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  lt3651_charger_driver_init+0x0/0x4b @ 1
initcall lt3651_charger_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  ltc4162l_driver_init+0x0/0x4b @ 1
initcall ltc4162l_driver_init+0x0/0x4b returned 0 after 88 usecs
calling  max14656_i2c_driver_init+0x0/0x4b @ 1
initcall max14656_i2c_driver_init+0x0/0x4b returned 0 after 86 usecs
calling  max77693_charger_driver_init+0x0/0x4b @ 1
initcall max77693_charger_driver_init+0x0/0x4b returned 0 after 103 usecs
calling  mt6360_charger_driver_init+0x0/0x4b @ 1
initcall mt6360_charger_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  bq24190_driver_init+0x0/0x4b @ 1
initcall bq24190_driver_init+0x0/0x4b returned 0 after 87 usecs
calling  bq2515x_driver_init+0x0/0x4b @ 1
initcall bq2515x_driver_init+0x0/0x4b returned 0 after 81 usecs
calling  bq25890_driver_init+0x0/0x4b @ 1
initcall bq25890_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  bq25980_driver_init+0x0/0x4b @ 1
initcall bq25980_driver_init+0x0/0x4b returned 0 after 71 usecs
calling  bq256xx_driver_init+0x0/0x4b @ 1
initcall bq256xx_driver_init+0x0/0x4b returned 0 after 74 usecs
calling  smb347_driver_init+0x0/0x4b @ 1
initcall smb347_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  tps65217_charger_driver_init+0x0/0x4b @ 1
initcall tps65217_charger_driver_init+0x0/0x4b returned 0 after 107 usecs
calling  ucs1002_driver_init+0x0/0x4b @ 1
initcall ucs1002_driver_init+0x0/0x4b returned 0 after 88 usecs
calling  bd9995x_driver_init+0x0/0x4b @ 1
initcall bd9995x_driver_init+0x0/0x4b returned 0 after 81 usecs
calling  ug3105_i2c_driver_init+0x0/0x4b @ 1
initcall ug3105_i2c_driver_init+0x0/0x4b returned 0 after 78 usecs
calling  w83773_driver_init+0x0/0x4b @ 1
initcall w83773_driver_init+0x0/0x4b returned 0 after 73 usecs
calling  w83792d_driver_init+0x0/0x4b @ 1
initcall w83792d_driver_init+0x0/0x4b returned 0 after 8328 usecs
calling  w83793_driver_init+0x0/0x4b @ 1
initcall w83793_driver_init+0x0/0x4b returned 0 after 8295 usecs
calling  sensors_w83781d_init+0x0/0x6e @ 1
initcall sensors_w83781d_init+0x0/0x6e returned 0 after 16278 usecs
calling  w83791d_driver_init+0x0/0x4b @ 1
initcall w83791d_driver_init+0x0/0x4b returned 0 after 8402 usecs
calling  ad7314_driver_init+0x0/0x4b @ 1
initcall ad7314_driver_init+0x0/0x4b returned 0 after 132 usecs
calling  ad7414_driver_init+0x0/0x4b @ 1
initcall ad7414_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  adc128_driver_init+0x0/0x4b @ 1
initcall adc128_driver_init+0x0/0x4b returned 0 after 11873 usecs
calling  adcxx_driver_init+0x0/0x4b @ 1
initcall adcxx_driver_init+0x0/0x4b returned 0 after 105 usecs
calling  adm1021_driver_init+0x0/0x4b @ 1
initcall adm1021_driver_init+0x0/0x4b returned 0 after 17561 usecs
calling  adm1025_driver_init+0x0/0x4b @ 1
initcall adm1025_driver_init+0x0/0x4b returned 0 after 6220 usecs
calling  adm1026_driver_init+0x0/0x4b @ 1
initcall adm1026_driver_init+0x0/0x4b returned 0 after 6238 usecs
calling  adm1031_driver_init+0x0/0x4b @ 1
initcall adm1031_driver_init+0x0/0x4b returned 0 after 6210 usecs
calling  adm1177_driver_init+0x0/0x4b @ 1
initcall adm1177_driver_init+0x0/0x4b returned 0 after 212 usecs
calling  adm9240_driver_init+0x0/0x4b @ 1
initcall adm9240_driver_init+0x0/0x4b returned 0 after 8300 usecs
calling  adt7411_driver_init+0x0/0x4b @ 1
initcall adt7411_driver_init+0x0/0x4b returned 0 after 6142 usecs
calling  adt7475_driver_init+0x0/0x4b @ 1
initcall adt7475_driver_init+0x0/0x4b returned 0 after 6208 usecs
calling  aht10_driver_init+0x0/0x4b @ 1
initcall aht10_driver_init+0x0/0x4b returned 0 after 207 usecs
calling  as370_hwmon_driver_init+0x0/0x4b @ 1
initcall as370_hwmon_driver_init+0x0/0x4b returned 0 after 198 usecs
calling  sm_asc7621_init+0x0/0x26d @ 1
initcall sm_asc7621_init+0x0/0x26d returned 0 after 6274 usecs
calling  atxp1_driver_init+0x0/0x4b @ 1
initcall atxp1_driver_init+0x0/0x4b returned 0 after 339 usecs
calling  axi_fan_control_driver_init+0x0/0x4b @ 1
initcall axi_fan_control_driver_init+0x0/0x4b returned 0 after 116 usecs
calling  coretemp_init+0x0/0x1a2 @ 1
initcall coretemp_init+0x0/0x1a2 returned -19 after 2 usecs
calling  da9052_hwmon_driver_init+0x0/0x4b @ 1
initcall da9052_hwmon_driver_init+0x0/0x4b returned 0 after 209 usecs
calling  da9055_hwmon_driver_init+0x0/0x4b @ 1
initcall da9055_hwmon_driver_init+0x0/0x4b returned 0 after 198 usecs
calling  i8k_init+0x0/0x1e0 @ 1
initcall i8k_init+0x0/0x1e0 returned -19 after 1 usecs
calling  dme1737_init+0x0/0x262 @ 1
initcall dme1737_init+0x0/0x262 returned 0 after 5693 usecs
calling  drivetemp_init+0x0/0x49 @ 1
initcall drivetemp_init+0x0/0x49 returned 0 after 324 usecs
calling  ds620_driver_init+0x0/0x4b @ 1
initcall ds620_driver_init+0x0/0x4b returned 0 after 115 usecs
calling  emc2103_driver_init+0x0/0x4b @ 1
initcall emc2103_driver_init+0x0/0x4b returned 0 after 1482 usecs
calling  emc2305_driver_init+0x0/0x4b @ 1
initcall emc2305_driver_init+0x0/0x4b returned 0 after 181 usecs
calling  f71805f_init+0x0/0x17e @ 1
initcall f71805f_init+0x0/0x17e returned -19 after 64 usecs
calling  f71882fg_init+0x0/0x167 @ 1
f71882fg: Not a Fintek device
f71882fg: Not a Fintek device
initcall f71882fg_init+0x0/0x167 returned -19 after 1459 usecs
calling  fschmd_driver_init+0x0/0x4b @ 1
initcall fschmd_driver_init+0x0/0x4b returned 0 after 2455 usecs
calling  g760a_driver_init+0x0/0x4b @ 1
initcall g760a_driver_init+0x0/0x4b returned 0 after 110 usecs
calling  g762_driver_init+0x0/0x4b @ 1
initcall g762_driver_init+0x0/0x4b returned 0 after 95 usecs
calling  gl518_driver_init+0x0/0x4b @ 1
initcall gl518_driver_init+0x0/0x4b returned 0 after 3631 usecs
calling  gl520_driver_init+0x0/0x4b @ 1
initcall gl520_driver_init+0x0/0x4b returned 0 after 4258 usecs
calling  gsc_hwmon_driver_init+0x0/0x4b @ 1
initcall gsc_hwmon_driver_init+0x0/0x4b returned 0 after 216 usecs
calling  gpio_fan_driver_init+0x0/0x4b @ 1
initcall gpio_fan_driver_init+0x0/0x4b returned 0 after 214 usecs
calling  i5k_amb_init+0x0/0x15b @ 1
initcall i5k_amb_init+0x0/0x15b returned 0 after 819 usecs
calling  ina209_driver_init+0x0/0x4b @ 1
initcall ina209_driver_init+0x0/0x4b returned 0 after 108 usecs
calling  ina2xx_driver_init+0x0/0x4b @ 1
initcall ina2xx_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  ina238_driver_init+0x0/0x4b @ 1
initcall ina238_driver_init+0x0/0x4b returned 0 after 87 usecs
calling  sm_it87_init+0x0/0x2df @ 1
initcall sm_it87_init+0x0/0x2df returned -19 after 349 usecs
calling  jc42_driver_init+0x0/0x4b @ 1
initcall jc42_driver_init+0x0/0x4b returned 0 after 16299 usecs
calling  pem_driver_init+0x0/0x4b @ 1
initcall pem_driver_init+0x0/0x4b returned 0 after 117 usecs
calling  lm63_driver_init+0x0/0x4b @ 1
initcall lm63_driver_init+0x0/0x4b returned 0 after 6446 usecs
calling  lm70_driver_init+0x0/0x4b @ 1
initcall lm70_driver_init+0x0/0x4b returned 0 after 199 usecs
calling  lm73_driver_init+0x0/0x4b @ 1
initcall lm73_driver_init+0x0/0x4b returned 0 after 12416 usecs
calling  lm75_driver_init+0x0/0x4b @ 1
initcall lm75_driver_init+0x0/0x4b returned 0 after 16219 usecs
calling  lm77_driver_init+0x0/0x4b @ 1
initcall lm77_driver_init+0x0/0x4b returned 0 after 8309 usecs
calling  sm_lm78_init+0x0/0x6e @ 1
initcall sm_lm78_init+0x0/0x6e returned 0 after 16344 usecs
calling  lm85_driver_init+0x0/0x4b @ 1
initcall lm85_driver_init+0x0/0x4b returned 0 after 6210 usecs
calling  lm92_driver_init+0x0/0x4b @ 1
initcall lm92_driver_init+0x0/0x4b returned 0 after 8314 usecs
calling  lm95234_driver_init+0x0/0x4b @ 1
initcall lm95234_driver_init+0x0/0x4b returned 0 after 10261 usecs
calling  lm95245_driver_init+0x0/0x4b @ 1
initcall lm95245_driver_init+0x0/0x4b returned 0 after 10245 usecs
calling  ltc2990_i2c_driver_init+0x0/0x4b @ 1
initcall ltc2990_i2c_driver_init+0x0/0x4b returned 0 after 125 usecs
calling  ltc2992_i2c_driver_init+0x0/0x4b @ 1
initcall ltc2992_i2c_driver_init+0x0/0x4b returned 0 after 140 usecs
calling  ltc4215_driver_init+0x0/0x4b @ 1
initcall ltc4215_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  ltc4222_driver_init+0x0/0x4b @ 1
initcall ltc4222_driver_init+0x0/0x4b returned 0 after 92 usecs
calling  ltc4245_driver_init+0x0/0x4b @ 1
initcall ltc4245_driver_init+0x0/0x4b returned 0 after 88 usecs
calling  ltc4260_driver_init+0x0/0x4b @ 1
initcall ltc4260_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  max1111_driver_init+0x0/0x4b @ 1
initcall max1111_driver_init+0x0/0x4b returned 0 after 78 usecs
calling  max16065_driver_init+0x0/0x4b @ 1
initcall max16065_driver_init+0x0/0x4b returned 0 after 171 usecs
calling  max1619_driver_init+0x0/0x4b @ 1
initcall max1619_driver_init+0x0/0x4b returned 0 after 18000 usecs
calling  max1668_driver_init+0x0/0x4b @ 1
initcall max1668_driver_init+0x0/0x4b returned 0 after 18056 usecs
calling  max197_driver_init+0x0/0x4b @ 1
initcall max197_driver_init+0x0/0x4b returned 0 after 211 usecs
calling  max31722_driver_init+0x0/0x4b @ 1
initcall max31722_driver_init+0x0/0x4b returned 0 after 113 usecs
calling  max31730_driver_init+0x0/0x4b @ 1
initcall max31730_driver_init+0x0/0x4b returned 0 after 16020 usecs
calling  max31760_driver_init+0x0/0x4b @ 1
initcall max31760_driver_init+0x0/0x4b returned 0 after 128 usecs
calling  max6639_driver_init+0x0/0x4b @ 1
initcall max6639_driver_init+0x0/0x4b returned 0 after 5972 usecs
calling  max6642_driver_init+0x0/0x4b @ 1
initcall max6642_driver_init+0x0/0x4b returned 0 after 16171 usecs
calling  max6697_driver_init+0x0/0x4b @ 1
initcall max6697_driver_init+0x0/0x4b returned 0 after 124 usecs
calling  max31790_driver_init+0x0/0x4b @ 1
initcall max31790_driver_init+0x0/0x4b returned 0 after 174 usecs
calling  mc13783_adc_driver_init+0x0/0x50 @ 1
initcall mc13783_adc_driver_init+0x0/0x50 returned -19 after 213 usecs
calling  mcp3021_driver_init+0x0/0x4b @ 1
initcall mcp3021_driver_init+0x0/0x4b returned 0 after 237 usecs
calling  tc654_driver_init+0x0/0x4b @ 1
initcall tc654_driver_init+0x0/0x4b returned 0 after 86 usecs
calling  moortec_pvt_driver_init+0x0/0x4b @ 1
initcall moortec_pvt_driver_init+0x0/0x4b returned 0 after 112 usecs
calling  sensors_nct6683_init+0x0/0x473 @ 1
initcall sensors_nct6683_init+0x0/0x473 returned -19 after 275 usecs
calling  sensors_nct6775_platform_init+0x0/0x48b @ 1
initcall sensors_nct6775_platform_init+0x0/0x48b returned -19 after 291 usecs
calling  nct6775_i2c_driver_init+0x0/0x4b @ 1
initcall nct6775_i2c_driver_init+0x0/0x4b returned 0 after 125 usecs
calling  pc87360_init+0x0/0x232 @ 1
pc87360: PC8736x not detected, module not inserted
initcall pc87360_init+0x0/0x232 returned -19 after 831 usecs
calling  powr1220_driver_init+0x0/0x4b @ 1
initcall powr1220_driver_init+0x0/0x4b returned 0 after 121 usecs
calling  sht15_driver_init+0x0/0x4b @ 1
initcall sht15_driver_init+0x0/0x4b returned 0 after 115 usecs
calling  sht21_driver_init+0x0/0x4b @ 1
initcall sht21_driver_init+0x0/0x4b returned 0 after 99 usecs
calling  sht4x_driver_init+0x0/0x4b @ 1
initcall sht4x_driver_init+0x0/0x4b returned 0 after 89 usecs
calling  shtc1_i2c_driver_init+0x0/0x4b @ 1
initcall shtc1_i2c_driver_init+0x0/0x4b returned 0 after 107 usecs
calling  sm_sis5595_init+0x0/0x50 @ 1
initcall sm_sis5595_init+0x0/0x50 returned 0 after 125 usecs
calling  smm665_driver_init+0x0/0x4b @ 1
initcall smm665_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  smsc47b397_init+0x0/0xf5 @ 1
initcall smsc47b397_init+0x0/0xf5 returned -19 after 32 usecs
calling  sy7636a_sensor_driver_init+0x0/0x4b @ 1
initcall sy7636a_sensor_driver_init+0x0/0x4b returned 0 after 124 usecs
calling  tc74_driver_init+0x0/0x4b @ 1
initcall tc74_driver_init+0x0/0x4b returned 0 after 153 usecs
calling  thmc50_driver_init+0x0/0x4b @ 1
initcall thmc50_driver_init+0x0/0x4b returned 0 after 5806 usecs
calling  tmp102_driver_init+0x0/0x4b @ 1
initcall tmp102_driver_init+0x0/0x4b returned 0 after 196 usecs
calling  tmp103_driver_init+0x0/0x4b @ 1
initcall tmp103_driver_init+0x0/0x4b returned 0 after 96 usecs
calling  tmp108_driver_init+0x0/0x4b @ 1
initcall tmp108_driver_init+0x0/0x4b returned 0 after 99 usecs
calling  tmp421_driver_init+0x0/0x4b @ 1
initcall tmp421_driver_init+0x0/0x4b returned 0 after 9455 usecs
calling  tmp464_driver_init+0x0/0x4b @ 1
initcall tmp464_driver_init+0x0/0x4b returned 0 after 8239 usecs
calling  tmp51x_driver_init+0x0/0x4b @ 1
initcall tmp51x_driver_init+0x0/0x4b returned 0 after 225 usecs
calling  via_cputemp_init+0x0/0x12a @ 1
initcall via_cputemp_init+0x0/0x12a returned -19 after 1 usecs
calling  sm_via686a_init+0x0/0x50 @ 1
initcall sm_via686a_init+0x0/0x50 returned 0 after 143 usecs
calling  vt1211_init+0x0/0x1f8 @ 1
initcall vt1211_init+0x0/0x1f8 returned -19 after 62 usecs
calling  sm_vt8231_init+0x0/0x50 @ 1
initcall sm_vt8231_init+0x0/0x50 returned 0 after 163 usecs
calling  sensors_w83627ehf_init+0x0/0x1a7 @ 1
initcall sensors_w83627ehf_init+0x0/0x1a7 returned -19 after 83 usecs
calling  w83l785ts_driver_init+0x0/0x4b @ 1
initcall w83l785ts_driver_init+0x0/0x4b returned 0 after 1824 usecs
calling  w83l786ng_driver_init+0x0/0x4b @ 1
initcall w83l786ng_driver_init+0x0/0x4b returned 0 after 4068 usecs
calling  pmbus_core_init+0x0/0x81 @ 1
initcall pmbus_core_init+0x0/0x81 returned 0 after 2 usecs
calling  pmbus_driver_init+0x0/0x4b @ 1
initcall pmbus_driver_init+0x0/0x4b returned 0 after 121 usecs
calling  adm1266_driver_init+0x0/0x4b @ 1
initcall adm1266_driver_init+0x0/0x4b returned 0 after 100 usecs
calling  adm1275_driver_init+0x0/0x4b @ 1
initcall adm1275_driver_init+0x0/0x4b returned 0 after 98 usecs
calling  pfe_pmbus_driver_init+0x0/0x4b @ 1
initcall pfe_pmbus_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  fsp3y_driver_init+0x0/0x4b @ 1
initcall fsp3y_driver_init+0x0/0x4b returned 0 after 115 usecs
calling  ibm_cffps_driver_init+0x0/0x4b @ 1
initcall ibm_cffps_driver_init+0x0/0x4b returned 0 after 88 usecs
calling  dps920ab_driver_init+0x0/0x4b @ 1
initcall dps920ab_driver_init+0x0/0x4b returned 0 after 113 usecs
calling  ir35221_driver_init+0x0/0x4b @ 1
initcall ir35221_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  ir36021_driver_init+0x0/0x4b @ 1
initcall ir36021_driver_init+0x0/0x4b returned 0 after 86 usecs
calling  ir38064_driver_init+0x0/0x4b @ 1
initcall ir38064_driver_init+0x0/0x4b returned 0 after 87 usecs
calling  isl68137_driver_init+0x0/0x4b @ 1
initcall isl68137_driver_init+0x0/0x4b returned 0 after 82 usecs
calling  lt7182s_driver_init+0x0/0x4b @ 1
initcall lt7182s_driver_init+0x0/0x4b returned 0 after 88 usecs
calling  ltc2978_driver_init+0x0/0x4b @ 1
initcall ltc2978_driver_init+0x0/0x4b returned 0 after 106 usecs
calling  ltc3815_driver_init+0x0/0x4b @ 1
initcall ltc3815_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  max16064_driver_init+0x0/0x4b @ 1
initcall max16064_driver_init+0x0/0x4b returned 0 after 88 usecs
calling  max20730_driver_init+0x0/0x4b @ 1
initcall max20730_driver_init+0x0/0x4b returned 0 after 87 usecs
calling  max20751_driver_init+0x0/0x4b @ 1
initcall max20751_driver_init+0x0/0x4b returned 0 after 263 usecs
calling  max31785_driver_init+0x0/0x4b @ 1
initcall max31785_driver_init+0x0/0x4b returned 0 after 87 usecs
calling  mp2888_driver_init+0x0/0x4b @ 1
initcall mp2888_driver_init+0x0/0x4b returned 0 after 107 usecs
calling  mp2975_driver_init+0x0/0x4b @ 1
initcall mp2975_driver_init+0x0/0x4b returned 0 after 91 usecs
calling  mp5023_driver_init+0x0/0x4b @ 1
initcall mp5023_driver_init+0x0/0x4b returned 0 after 87 usecs
calling  pli1209bc_driver_init+0x0/0x4b @ 1
initcall pli1209bc_driver_init+0x0/0x4b returned 0 after 89 usecs
calling  pm6764tr_driver_init+0x0/0x4b @ 1
initcall pm6764tr_driver_init+0x0/0x4b returned 0 after 85 usecs
calling  pxe1610_driver_init+0x0/0x4b @ 1
initcall pxe1610_driver_init+0x0/0x4b returned 0 after 87 usecs
calling  q54sj108a2_driver_init+0x0/0x4b @ 1
initcall q54sj108a2_driver_init+0x0/0x4b returned 0 after 81 usecs
calling  tps546d24_driver_init+0x0/0x4b @ 1
initcall tps546d24_driver_init+0x0/0x4b returned 0 after 137 usecs
calling  ucd9000_driver_init+0x0/0x4b @ 1
initcall ucd9000_driver_init+0x0/0x4b returned 0 after 118 usecs
calling  xdpe122_driver_init+0x0/0x4b @ 1
initcall xdpe122_driver_init+0x0/0x4b returned 0 after 128 usecs
calling  xdpe152_driver_init+0x0/0x4b @ 1
initcall xdpe152_driver_init+0x0/0x4b returned 0 after 109 usecs
calling  pim4328_driver_init+0x0/0x4b @ 1
initcall pim4328_driver_init+0x0/0x4b returned 0 after 99 usecs
calling  powerclamp_init+0x0/0x2bb @ 1
intel_powerclamp: CPU does not support MWAIT
initcall powerclamp_init+0x0/0x2bb returned -19 after 813 usecs
calling  pkg_temp_thermal_init+0x0/0x1e4 @ 1
initcall pkg_temp_thermal_init+0x0/0x1e4 returned -19 after 1 usecs
calling  intel_quark_thermal_init+0x0/0xfc @ 1
initcall intel_quark_thermal_init+0x0/0xfc returned -19 after 1 usecs
calling  intel_pch_thermal_driver_init+0x0/0x50 @ 1
initcall intel_pch_thermal_driver_init+0x0/0x50 returned 0 after 195 usecs
calling  tcc_cooling_init+0x0/0x16e @ 1
initcall tcc_cooling_init+0x0/0x16e returned -19 after 2 usecs
calling  thermal_throttle_init_device+0x0/0x93 @ 1
initcall thermal_throttle_init_device+0x0/0x93 returned 0 after 1 usecs
calling  dt_cpufreq_platdrv_init+0x0/0x4b @ 1
initcall dt_cpufreq_platdrv_init+0x0/0x4b returned 0 after 146 usecs
calling  powernow_k6_init+0x0/0x13b @ 1
initcall powernow_k6_init+0x0/0x13b returned -19 after 1 usecs
calling  longrun_init+0x0/0x89 @ 1
initcall longrun_init+0x0/0x89 returned -19 after 1 usecs
calling  speedstep_init+0x0/0x24b @ 1
initcall speedstep_init+0x0/0x24b returned -19 after 1 usecs
calling  speedstep_init+0x0/0x32d @ 1
initcall speedstep_init+0x0/0x32d returned -19 after 1 usecs
calling  nforce2_init+0x0/0x119 @ 1
cpufreq_nforce2: No nForce2 chipset
initcall nforce2_init+0x0/0x119 returned -19 after 810 usecs
calling  intel_pstate_init+0x0/0x788 @ 1
intel_pstate: CPU model not supported
initcall intel_pstate_init+0x0/0x788 returned -19 after 773 usecs
calling  haltpoll_init+0x0/0x24d @ 1
initcall haltpoll_init+0x0/0x24d returned -19 after 4 usecs
calling  memstick_init+0x0/0x136 @ 1
initcall memstick_init+0x0/0x136 returned 0 after 10534 usecs
calling  msb_init+0x0/0x8f @ 1
initcall msb_init+0x0/0x8f returned 0 after 69 usecs
calling  mspro_block_init+0x0/0x121 @ 1
initcall mspro_block_init+0x0/0x121 returned 0 after 179 usecs
calling  tifm_ms_init+0x0/0x49 @ 1
initcall tifm_ms_init+0x0/0x49 returned 0 after 66 usecs
calling  jmb38x_ms_driver_init+0x0/0x50 @ 1
initcall jmb38x_ms_driver_init+0x0/0x50 returned 0 after 170 usecs
calling  rtsx_usb_ms_driver_init+0x0/0x4b @ 1
initcall rtsx_usb_ms_driver_init+0x0/0x4b returned 0 after 116 usecs
calling  an30259a_driver_init+0x0/0x4b @ 1
initcall an30259a_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  aw2013_driver_init+0x0/0x4b @ 1
initcall aw2013_driver_init+0x0/0x4b returned 0 after 92 usecs
calling  bcm6328_leds_driver_init+0x0/0x4b @ 1
initcall bcm6328_leds_driver_init+0x0/0x4b returned 0 after 113 usecs
calling  bd2802_i2c_driver_init+0x0/0x4b @ 1
initcall bd2802_i2c_driver_init+0x0/0x4b returned 0 after 99 usecs
calling  blinkm_driver_init+0x0/0x4b @ 1
initcall blinkm_driver_init+0x0/0x4b returned 0 after 2431 usecs
calling  da903x_led_driver_init+0x0/0x4b @ 1
initcall da903x_led_driver_init+0x0/0x4b returned 0 after 215 usecs
calling  da9052_led_driver_init+0x0/0x4b @ 1
initcall da9052_led_driver_init+0x0/0x4b returned 0 after 212 usecs
calling  gpio_led_driver_init+0x0/0x4b @ 1
initcall gpio_led_driver_init+0x0/0x4b returned 0 after 183 usecs
calling  is31fl319x_driver_init+0x0/0x4b @ 1
initcall is31fl319x_driver_init+0x0/0x4b returned 0 after 130 usecs
calling  is31fl32xx_driver_init+0x0/0x4b @ 1
initcall is31fl32xx_driver_init+0x0/0x4b returned 0 after 104 usecs
calling  lm3530_i2c_driver_init+0x0/0x4b @ 1
initcall lm3530_i2c_driver_init+0x0/0x4b returned 0 after 197 usecs
calling  lm3532_i2c_driver_init+0x0/0x4b @ 1
initcall lm3532_i2c_driver_init+0x0/0x4b returned 0 after 180 usecs
calling  lm3533_led_driver_init+0x0/0x4b @ 1
initcall lm3533_led_driver_init+0x0/0x4b returned 0 after 114 usecs
calling  lm355x_i2c_driver_init+0x0/0x4b @ 1
initcall lm355x_i2c_driver_init+0x0/0x4b returned 0 after 99 usecs
calling  lm3642_i2c_driver_init+0x0/0x4b @ 1
initcall lm3642_i2c_driver_init+0x0/0x4b returned 0 after 11370 usecs
calling  lm3692x_driver_init+0x0/0x4b @ 1
initcall lm3692x_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  lp3952_i2c_driver_init+0x0/0x4b @ 1
initcall lp3952_i2c_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  lp50xx_driver_init+0x0/0x4b @ 1
initcall lp50xx_driver_init+0x0/0x4b returned 0 after 97 usecs
calling  lp5521_driver_init+0x0/0x4b @ 1
initcall lp5521_driver_init+0x0/0x4b returned 0 after 92 usecs
calling  lp5523_driver_init+0x0/0x4b @ 1
initcall lp5523_driver_init+0x0/0x4b returned 0 after 95 usecs
calling  lp8501_driver_init+0x0/0x4b @ 1
initcall lp8501_driver_init+0x0/0x4b returned 0 after 94 usecs
calling  lp8860_driver_init+0x0/0x4b @ 1
initcall lp8860_driver_init+0x0/0x4b returned 0 after 109 usecs
calling  lt3593_led_driver_init+0x0/0x4b @ 1
initcall lt3593_led_driver_init+0x0/0x4b returned 0 after 140 usecs
calling  mlxreg_led_driver_init+0x0/0x4b @ 1
initcall mlxreg_led_driver_init+0x0/0x4b returned 0 after 112 usecs
calling  ot200_led_driver_init+0x0/0x4b @ 1
initcall ot200_led_driver_init+0x0/0x4b returned 0 after 139 usecs
calling  pca9532_driver_init+0x0/0x4b @ 1
initcall pca9532_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  pca963x_driver_init+0x0/0x4b @ 1
initcall pca963x_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  regulator_led_driver_init+0x0/0x4b @ 1
initcall regulator_led_driver_init+0x0/0x4b returned 0 after 113 usecs
calling  tca6507_driver_init+0x0/0x4b @ 1
initcall tca6507_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  tlc591xx_driver_init+0x0/0x4b @ 1
initcall tlc591xx_driver_init+0x0/0x4b returned 0 after 102 usecs
calling  led_driver_init+0x0/0x4b @ 1
initcall led_driver_init+0x0/0x4b returned 0 after 112 usecs
calling  cr0014114_driver_init+0x0/0x4b @ 1
SPI driver leds_cr0014114 has no spi_device_id for crane,cr0014114
initcall cr0014114_driver_init+0x0/0x4b returned 0 after 1161 usecs
calling  el15203000_driver_init+0x0/0x4b @ 1
SPI driver leds_el15203000 has no spi_device_id for crane,el15203000
initcall el15203000_driver_init+0x0/0x4b returned 0 after 1162 usecs
calling  spi_byte_driver_init+0x0/0x4b @ 1
SPI driver leds_spi_byte has no spi_device_id for ubnt,acb-spi-led
initcall spi_byte_driver_init+0x0/0x4b returned 0 after 1141 usecs
calling  mt6360_led_driver_init+0x0/0x4b @ 1
initcall mt6360_led_driver_init+0x0/0x4b returned 0 after 198 usecs
calling  aat1290_led_driver_init+0x0/0x4b @ 1
initcall aat1290_led_driver_init+0x0/0x4b returned 0 after 112 usecs
calling  ktd2692_driver_init+0x0/0x4b @ 1
initcall ktd2692_driver_init+0x0/0x4b returned 0 after 100 usecs
calling  max77693_led_driver_init+0x0/0x4b @ 1
initcall max77693_led_driver_init+0x0/0x4b returned 0 after 101 usecs
calling  rt4505_driver_init+0x0/0x4b @ 1
initcall rt4505_driver_init+0x0/0x4b returned 0 after 111 usecs
calling  rt8515_driver_init+0x0/0x4b @ 1
initcall rt8515_driver_init+0x0/0x4b returned 0 after 183 usecs
calling  intel_sso_led_driver_init+0x0/0x4b @ 1
initcall intel_sso_led_driver_init+0x0/0x4b returned 0 after 106 usecs
calling  simatic_ipc_led_driver_init+0x0/0x4b @ 1
initcall simatic_ipc_led_driver_init+0x0/0x4b returned 0 after 175 usecs
calling  simatic_ipc_led_gpio_driver_init+0x0/0x4b @ 1
initcall simatic_ipc_led_gpio_driver_init+0x0/0x4b returned 0 after 10681 usecs
calling  fw_cfg_sysfs_init+0x0/0xeb @ 1
initcall fw_cfg_sysfs_init+0x0/0xeb returned 0 after 2131 usecs
calling  sysfb_init+0x0/0x271 @ 1
initcall sysfb_init+0x0/0x271 returned 0 after 5 usecs
calling  hid_init+0x0/0x12b @ 1
hid: raw HID events driver (C) Jiri Kosina
initcall hid_init+0x0/0x12b returned 0 after 953 usecs
calling  uhid_misc_init+0x0/0x49 @ 1
initcall uhid_misc_init+0x0/0x49 returned 0 after 448 usecs
calling  hid_generic_init+0x0/0x50 @ 1
initcall hid_generic_init+0x0/0x50 returned 0 after 182 usecs
calling  a4_driver_init+0x0/0x50 @ 1
initcall a4_driver_init+0x0/0x50 returned 0 after 95 usecs
calling  alps_driver_init+0x0/0x50 @ 1
initcall alps_driver_init+0x0/0x50 returned 0 after 111 usecs
calling  apple_driver_init+0x0/0x50 @ 1
initcall apple_driver_init+0x0/0x50 returned 0 after 132 usecs
calling  creative_sb0540_driver_init+0x0/0x50 @ 1
initcall creative_sb0540_driver_init+0x0/0x50 returned 0 after 95 usecs
calling  asus_driver_init+0x0/0x50 @ 1
initcall asus_driver_init+0x0/0x50 returned 0 after 88 usecs
calling  bigben_driver_init+0x0/0x50 @ 1
initcall bigben_driver_init+0x0/0x50 returned 0 after 95 usecs
calling  ch_driver_init+0x0/0x50 @ 1
initcall ch_driver_init+0x0/0x50 returned 0 after 94 usecs
calling  ch_driver_init+0x0/0x50 @ 1
initcall ch_driver_init+0x0/0x50 returned 0 after 104 usecs
calling  cmedia_init+0x0/0xa0 @ 1
initcall cmedia_init+0x0/0xa0 returned 0 after 286 usecs
calling  cougar_driver_init+0x0/0x50 @ 1
initcall cougar_driver_init+0x0/0x50 returned 0 after 138 usecs
calling  cp_driver_init+0x0/0x50 @ 1
initcall cp_driver_init+0x0/0x50 returned 0 after 100 usecs
calling  dr_driver_init+0x0/0x50 @ 1
initcall dr_driver_init+0x0/0x50 returned 0 after 110 usecs
calling  ems_driver_init+0x0/0x50 @ 1
initcall ems_driver_init+0x0/0x50 returned 0 after 187 usecs
calling  elan_driver_init+0x0/0x50 @ 1
initcall elan_driver_init+0x0/0x50 returned 0 after 188 usecs
calling  elecom_driver_init+0x0/0x50 @ 1
initcall elecom_driver_init+0x0/0x50 returned 0 after 188 usecs
calling  ez_driver_init+0x0/0x50 @ 1
initcall ez_driver_init+0x0/0x50 returned 0 after 219 usecs
calling  gfrm_driver_init+0x0/0x50 @ 1
initcall gfrm_driver_init+0x0/0x50 returned 0 after 107 usecs
calling  hid_vivaldi_init+0x0/0x50 @ 1
initcall hid_vivaldi_init+0x0/0x50 returned 0 after 114 usecs
calling  gt683r_led_driver_init+0x0/0x50 @ 1
initcall gt683r_led_driver_init+0x0/0x50 returned 0 after 117 usecs
calling  gyration_driver_init+0x0/0x50 @ 1
initcall gyration_driver_init+0x0/0x50 returned 0 after 112 usecs
calling  holtek_kbd_driver_init+0x0/0x50 @ 1
initcall holtek_kbd_driver_init+0x0/0x50 returned 0 after 186 usecs
calling  holtek_mouse_driver_init+0x0/0x50 @ 1
initcall holtek_mouse_driver_init+0x0/0x50 returned 0 after 9282 usecs
calling  holtek_driver_init+0x0/0x50 @ 1
initcall holtek_driver_init+0x0/0x50 returned 0 after 199 usecs
calling  icade_driver_init+0x0/0x50 @ 1
initcall icade_driver_init+0x0/0x50 returned 0 after 172 usecs
calling  ite_driver_init+0x0/0x50 @ 1
initcall ite_driver_init+0x0/0x50 returned 0 after 120 usecs
calling  keytouch_driver_init+0x0/0x50 @ 1
initcall keytouch_driver_init+0x0/0x50 returned 0 after 120 usecs
calling  kye_driver_init+0x0/0x50 @ 1
initcall kye_driver_init+0x0/0x50 returned 0 after 210 usecs
calling  ts_driver_init+0x0/0x50 @ 1
initcall ts_driver_init+0x0/0x50 returned 0 after 148 usecs
calling  lenovo_driver_init+0x0/0x50 @ 1
initcall lenovo_driver_init+0x0/0x50 returned 0 after 126 usecs
calling  letsketch_driver_init+0x0/0x50 @ 1
initcall letsketch_driver_init+0x0/0x50 returned 0 after 132 usecs
calling  lg_driver_init+0x0/0x50 @ 1
initcall lg_driver_init+0x0/0x50 returned 0 after 195 usecs
calling  lg_g15_driver_init+0x0/0x50 @ 1
initcall lg_g15_driver_init+0x0/0x50 returned 0 after 455 usecs
calling  logi_djreceiver_driver_init+0x0/0x50 @ 1
initcall logi_djreceiver_driver_init+0x0/0x50 returned 0 after 138 usecs
calling  hidpp_driver_init+0x0/0x50 @ 1
initcall hidpp_driver_init+0x0/0x50 returned 0 after 183 usecs
calling  maltron_driver_init+0x0/0x50 @ 1
initcall maltron_driver_init+0x0/0x50 returned 0 after 220 usecs
calling  mf_driver_init+0x0/0x50 @ 1
initcall mf_driver_init+0x0/0x50 returned 0 after 151 usecs
calling  mwctrl_driver_init+0x0/0x50 @ 1
initcall mwctrl_driver_init+0x0/0x50 returned 0 after 141 usecs
calling  ms_driver_init+0x0/0x50 @ 1
initcall ms_driver_init+0x0/0x50 returned 0 after 162 usecs
calling  mt_driver_init+0x0/0x50 @ 1
initcall mt_driver_init+0x0/0x50 returned 0 after 146 usecs
calling  ortek_driver_init+0x0/0x50 @ 1
initcall ortek_driver_init+0x0/0x50 returned 0 after 137 usecs
calling  penmount_driver_init+0x0/0x50 @ 1
initcall penmount_driver_init+0x0/0x50 returned 0 after 146 usecs
calling  pl_driver_init+0x0/0x50 @ 1
initcall pl_driver_init+0x0/0x50 returned 0 after 144 usecs
calling  picolcd_driver_init+0x0/0x50 @ 1
initcall picolcd_driver_init+0x0/0x50 returned 0 after 137 usecs
calling  plantronics_driver_init+0x0/0x50 @ 1
initcall plantronics_driver_init+0x0/0x50 returned 0 after 155 usecs
calling  ps_init+0x0/0x50 @ 1
initcall ps_init+0x0/0x50 returned 0 after 156 usecs
calling  retrode_driver_init+0x0/0x50 @ 1
initcall retrode_driver_init+0x0/0x50 returned 0 after 177 usecs
calling  roccat_init+0x0/0x15e @ 1
initcall roccat_init+0x0/0x15e returned 0 after 18 usecs
calling  arvo_init+0x0/0xdd @ 1
initcall arvo_init+0x0/0xdd returned 0 after 200 usecs
calling  isku_init+0x0/0xdd @ 1
initcall isku_init+0x0/0xdd returned 0 after 191 usecs
calling  kone_init+0x0/0xdd @ 1
initcall kone_init+0x0/0xdd returned 0 after 188 usecs
calling  koneplus_init+0x0/0xdd @ 1
initcall koneplus_init+0x0/0xdd returned 0 after 284 usecs
calling  konepure_init+0x0/0xdc @ 1
initcall konepure_init+0x0/0xdc returned 0 after 180 usecs
calling  kovaplus_init+0x0/0xdd @ 1
initcall kovaplus_init+0x0/0xdd returned 0 after 201 usecs
calling  lua_driver_init+0x0/0x50 @ 1
initcall lua_driver_init+0x0/0x50 returned 0 after 150 usecs
calling  pyra_init+0x0/0xdc @ 1
initcall pyra_init+0x0/0xdc returned 0 after 180 usecs
calling  ryos_init+0x0/0xdd @ 1
initcall ryos_init+0x0/0xdd returned 0 after 244 usecs
calling  savu_init+0x0/0xdd @ 1
initcall savu_init+0x0/0xdd returned 0 after 182 usecs
calling  saitek_driver_init+0x0/0x50 @ 1
initcall saitek_driver_init+0x0/0x50 returned 0 after 156 usecs
calling  samsung_driver_init+0x0/0x50 @ 1
initcall samsung_driver_init+0x0/0x50 returned 0 after 153 usecs
calling  semitek_driver_init+0x0/0x50 @ 1
initcall semitek_driver_init+0x0/0x50 returned 0 after 163 usecs
calling  sony_init+0x0/0x9f @ 1
initcall sony_init+0x0/0x9f returned 0 after 203 usecs
calling  sp_driver_init+0x0/0x50 @ 1
initcall sp_driver_init+0x0/0x50 returned 0 after 164 usecs
calling  ga_driver_init+0x0/0x50 @ 1
initcall ga_driver_init+0x0/0x50 returned 0 after 163 usecs
calling  tm_driver_init+0x0/0x50 @ 1
initcall tm_driver_init+0x0/0x50 returned 0 after 169 usecs
calling  thrustmaster_driver_init+0x0/0x50 @ 1
initcall thrustmaster_driver_init+0x0/0x50 returned 0 after 152 usecs
calling  tivo_driver_init+0x0/0x50 @ 1
initcall tivo_driver_init+0x0/0x50 returned 0 after 240 usecs
calling  ts_driver_init+0x0/0x50 @ 1
initcall ts_driver_init+0x0/0x50 returned 0 after 182 usecs
calling  topre_driver_init+0x0/0x50 @ 1
initcall topre_driver_init+0x0/0x50 returned 0 after 197 usecs
calling  u2fzero_driver_init+0x0/0x50 @ 1
initcall u2fzero_driver_init+0x0/0x50 returned 0 after 153 usecs
calling  uclogic_driver_init+0x0/0x50 @ 1
initcall uclogic_driver_init+0x0/0x50 returned 0 after 131 usecs
calling  xiaomi_driver_init+0x0/0x50 @ 1
initcall xiaomi_driver_init+0x0/0x50 returned 0 after 105 usecs
calling  xinmo_driver_init+0x0/0x50 @ 1
initcall xinmo_driver_init+0x0/0x50 returned 0 after 166 usecs
calling  zp_driver_init+0x0/0x50 @ 1
initcall zp_driver_init+0x0/0x50 returned 0 after 183 usecs
calling  zc_driver_init+0x0/0x50 @ 1
initcall zc_driver_init+0x0/0x50 returned 0 after 178 usecs
calling  viewsonic_driver_init+0x0/0x50 @ 1
initcall viewsonic_driver_init+0x0/0x50 returned 0 after 160 usecs
calling  vrc2_driver_init+0x0/0x50 @ 1
initcall vrc2_driver_init+0x0/0x50 returned 0 after 124 usecs
calling  waltop_driver_init+0x0/0x50 @ 1
initcall waltop_driver_init+0x0/0x50 returned 0 after 106 usecs
calling  wiimote_hid_driver_init+0x0/0x50 @ 1
initcall wiimote_hid_driver_init+0x0/0x50 returned 0 after 177 usecs
calling  sensor_hub_driver_init+0x0/0x50 @ 1
initcall sensor_hub_driver_init+0x0/0x50 returned 0 after 193 usecs
calling  hid_sensor_custom_platform_driver_init+0x0/0x4b @ 1
initcall hid_sensor_custom_platform_driver_init+0x0/0x4b returned 0 after 113 usecs
calling  hid_init+0x0/0xf0 @ 1
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
initcall hid_init+0x0/0xf0 returned 0 after 1515 usecs
calling  elan_i2c_hid_ts_driver_init+0x0/0x4b @ 1
initcall elan_i2c_hid_ts_driver_init+0x0/0x4b returned 0 after 107 usecs
calling  goodix_i2c_hid_ts_driver_init+0x0/0x4b @ 1
initcall goodix_i2c_hid_ts_driver_init+0x0/0x4b returned 0 after 124 usecs
calling  bcma_modinit+0x0/0xb8 @ 1
initcall bcma_modinit+0x0/0xb8 returned 0 after 155 usecs
calling  gb_init+0x0/0x1b3 @ 1
initcall gb_init+0x0/0x1b3 returned 0 after 135 usecs
calling  es2_ap_driver_init+0x0/0x50 @ 1
usbcore: registered new interface driver es2_ap_driver
initcall es2_ap_driver_init+0x0/0x50 returned 0 after 979 usecs
calling  comedi_pci_init+0x0/0x2e @ 1
initcall comedi_pci_init+0x0/0x2e returned 0 after 1 usecs
calling  comedi_pcmcia_init+0x0/0x2e @ 1
initcall comedi_pcmcia_init+0x0/0x2e returned 0 after 1 usecs
calling  comedi_usb_init+0x0/0x2e @ 1
initcall comedi_usb_init+0x0/0x2e returned 0 after 1 usecs
calling  comedi_init+0x0/0x388 @ 1
comedi: version 0.7.76 - http://www.comedi.org
initcall comedi_init+0x0/0x388 returned 0 after 887 usecs
calling  kcomedilib_module_init+0x0/0x2e @ 1
initcall kcomedilib_module_init+0x0/0x2e returned 0 after 1 usecs
calling  comedi_8254_module_init+0x0/0x2e @ 1
initcall comedi_8254_module_init+0x0/0x2e returned 0 after 1 usecs
calling  comedi_isadma_init+0x0/0x2e @ 1
initcall comedi_isadma_init+0x0/0x2e returned 0 after 1 usecs
calling  bonding_driver_init+0x0/0x49 @ 1
initcall bonding_driver_init+0x0/0x49 returned 0 after 44 usecs
calling  parport_driver_init+0x0/0x49 @ 1
initcall parport_driver_init+0x0/0x49 returned 0 after 5 usecs
calling  amplc_dio200_driver_init+0x0/0x49 @ 1
initcall amplc_dio200_driver_init+0x0/0x49 returned 0 after 4 usecs
calling  amplc_pc236_driver_init+0x0/0x49 @ 1
initcall amplc_pc236_driver_init+0x0/0x49 returned 0 after 4 usecs
calling  amplc_pc263_driver_init+0x0/0x49 @ 1
initcall amplc_pc263_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  pcl711_driver_init+0x0/0x49 @ 1
initcall pcl711_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  pcl724_driver_init+0x0/0x49 @ 1
initcall pcl724_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  pcl726_driver_init+0x0/0x49 @ 1
initcall pcl726_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  pcl730_driver_init+0x0/0x49 @ 1
initcall pcl730_driver_init+0x0/0x49 returned 0 after 4 usecs
calling  pcl812_driver_init+0x0/0x49 @ 1
initcall pcl812_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  pcl818_driver_init+0x0/0x49 @ 1
initcall pcl818_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  pcm3724_driver_init+0x0/0x49 @ 1
initcall pcm3724_driver_init+0x0/0x49 returned 0 after 4 usecs
calling  rti802_driver_init+0x0/0x49 @ 1
initcall rti802_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  dac02_driver_init+0x0/0x49 @ 1
initcall dac02_driver_init+0x0/0x49 returned 0 after 65 usecs
calling  das16m1_driver_init+0x0/0x49 @ 1
initcall das16m1_driver_init+0x0/0x49 returned 0 after 4 usecs
calling  das08_isa_driver_init+0x0/0x49 @ 1
initcall das08_isa_driver_init+0x0/0x49 returned 0 after 2 usecs
calling  das16_driver_init+0x0/0x49 @ 1
initcall das16_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  das1800_driver_init+0x0/0x49 @ 1
initcall das1800_driver_init+0x0/0x49 returned 0 after 4 usecs
calling  das6402_driver_init+0x0/0x49 @ 1
initcall das6402_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  dt2801_driver_init+0x0/0x49 @ 1
initcall dt2801_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  dt2814_driver_init+0x0/0x49 @ 1
initcall dt2814_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  dt282x_driver_init+0x0/0x49 @ 1
initcall dt282x_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  fl512_driver_init+0x0/0x49 @ 1
initcall fl512_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  aio_iiro_16_driver_init+0x0/0x49 @ 1
initcall aio_iiro_16_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  ni_at_ao_driver_init+0x0/0x49 @ 1
initcall ni_at_ao_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  ni_atmio_driver_init+0x0/0x49 @ 1
initcall ni_atmio_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  labpc_driver_init+0x0/0x49 @ 1
initcall labpc_driver_init+0x0/0x49 returned 0 after 15 usecs
calling  pcmad_driver_init+0x0/0x49 @ 1
initcall pcmad_driver_init+0x0/0x49 returned 0 after 4 usecs
calling  pcmda12_driver_init+0x0/0x49 @ 1
initcall pcmda12_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  pcmmio_driver_init+0x0/0x49 @ 1
initcall pcmmio_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  pcmuio_driver_init+0x0/0x49 @ 1
initcall pcmuio_driver_init+0x0/0x49 returned 0 after 4 usecs
calling  multiq3_driver_init+0x0/0x49 @ 1
initcall multiq3_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  s526_driver_init+0x0/0x49 @ 1
initcall s526_driver_init+0x0/0x49 returned 0 after 4 usecs
calling  addi_watchdog_module_init+0x0/0x2e @ 1
initcall addi_watchdog_module_init+0x0/0x2e returned 0 after 1 usecs
calling  apci1500_driver_init+0x0/0x4e @ 1
initcall apci1500_driver_init+0x0/0x4e returned 0 after 159 usecs
calling  apci1516_driver_init+0x0/0x4e @ 1
initcall apci1516_driver_init+0x0/0x4e returned 0 after 70 usecs
calling  apci1564_driver_init+0x0/0x4e @ 1
initcall apci1564_driver_init+0x0/0x4e returned 0 after 64 usecs
calling  apci2200_driver_init+0x0/0x4e @ 1
initcall apci2200_driver_init+0x0/0x4e returned 0 after 129 usecs
calling  apci3120_driver_init+0x0/0x4e @ 1
initcall apci3120_driver_init+0x0/0x4e returned 0 after 115 usecs
calling  apci3xxx_driver_init+0x0/0x4e @ 1
initcall apci3xxx_driver_init+0x0/0x4e returned 0 after 95 usecs
calling  adl_pci6208_driver_init+0x0/0x4e @ 1
initcall adl_pci6208_driver_init+0x0/0x4e returned 0 after 114 usecs
calling  adl_pci8164_driver_init+0x0/0x4e @ 1
initcall adl_pci8164_driver_init+0x0/0x4e returned 0 after 136 usecs
calling  adl_pci9111_driver_init+0x0/0x4e @ 1
initcall adl_pci9111_driver_init+0x0/0x4e returned 0 after 114 usecs
calling  adl_pci9118_driver_init+0x0/0x4e @ 1
initcall adl_pci9118_driver_init+0x0/0x4e returned 0 after 139 usecs
calling  adv_pci1710_driver_init+0x0/0x4e @ 1
initcall adv_pci1710_driver_init+0x0/0x4e returned 0 after 122 usecs
calling  adv_pci1723_driver_init+0x0/0x4e @ 1
initcall adv_pci1723_driver_init+0x0/0x4e returned 0 after 112 usecs
calling  adv_pci1724_driver_init+0x0/0x4e @ 1
initcall adv_pci1724_driver_init+0x0/0x4e returned 0 after 111 usecs
calling  pci1760_driver_init+0x0/0x4e @ 1
initcall pci1760_driver_init+0x0/0x4e returned 0 after 136 usecs
calling  adv_pci_dio_driver_init+0x0/0x4e @ 1
initcall adv_pci_dio_driver_init+0x0/0x4e returned 0 after 120 usecs
calling  dio200_pci_comedi_driver_init+0x0/0x4e @ 1
initcall dio200_pci_comedi_driver_init+0x0/0x4e returned 0 after 114 usecs
calling  amplc_pci236_driver_init+0x0/0x4e @ 1
initcall amplc_pci236_driver_init+0x0/0x4e returned 0 after 152 usecs
calling  amplc_pci263_driver_init+0x0/0x4e @ 1
initcall amplc_pci263_driver_init+0x0/0x4e returned 0 after 113 usecs
calling  amplc_pci224_driver_init+0x0/0x4e @ 1
initcall amplc_pci224_driver_init+0x0/0x4e returned 0 after 112 usecs
calling  contec_pci_dio_driver_init+0x0/0x4e @ 1
initcall contec_pci_dio_driver_init+0x0/0x4e returned 0 after 111 usecs
calling  das08_pci_comedi_driver_init+0x0/0x4e @ 1
initcall das08_pci_comedi_driver_init+0x0/0x4e returned 0 after 141 usecs
calling  dyna_pci10xx_driver_init+0x0/0x4e @ 1
initcall dyna_pci10xx_driver_init+0x0/0x4e returned 0 after 123 usecs
calling  gsc_hpdi_driver_init+0x0/0x4e @ 1
initcall gsc_hpdi_driver_init+0x0/0x4e returned 0 after 127 usecs
calling  icp_multi_driver_init+0x0/0x4e @ 1
initcall icp_multi_driver_init+0x0/0x4e returned 0 after 118 usecs
calling  db2k_driver_init+0x0/0x4e @ 1
initcall db2k_driver_init+0x0/0x4e returned 0 after 118 usecs
calling  ke_counter_driver_init+0x0/0x4e @ 1
initcall ke_counter_driver_init+0x0/0x4e returned 0 after 117 usecs
calling  cb_pcidas64_driver_init+0x0/0x4e @ 1
initcall cb_pcidas64_driver_init+0x0/0x4e returned 0 after 144 usecs
calling  cb_pcidas_driver_init+0x0/0x4e @ 1
initcall cb_pcidas_driver_init+0x0/0x4e returned 0 after 110 usecs
calling  cb_pcimdda_driver_init+0x0/0x4e @ 1
initcall cb_pcimdda_driver_init+0x0/0x4e returned 0 after 124 usecs
calling  me4000_driver_init+0x0/0x4e @ 1
initcall me4000_driver_init+0x0/0x4e returned 0 after 142 usecs
calling  me_daq_driver_init+0x0/0x4e @ 1
initcall me_daq_driver_init+0x0/0x4e returned 0 after 109 usecs
calling  ni6527_driver_init+0x0/0x4e @ 1
initcall ni6527_driver_init+0x0/0x4e returned 0 after 125 usecs
calling  ni_660x_driver_init+0x0/0x4e @ 1
initcall ni_660x_driver_init+0x0/0x4e returned 0 after 111 usecs
calling  ni_670x_driver_init+0x0/0x4e @ 1
initcall ni_670x_driver_init+0x0/0x4e returned 0 after 123 usecs
calling  ni_pcidio_driver_init+0x0/0x4e @ 1
initcall ni_pcidio_driver_init+0x0/0x4e returned 0 after 111 usecs
calling  ni_pcimio_driver_init+0x0/0x4e @ 1
initcall ni_pcimio_driver_init+0x0/0x4e returned 0 after 140 usecs
calling  rtd520_driver_init+0x0/0x4e @ 1
initcall rtd520_driver_init+0x0/0x4e returned 0 after 103 usecs
calling  s626_driver_init+0x0/0x4e @ 1
initcall s626_driver_init+0x0/0x4e returned 0 after 111 usecs
calling  dnp_driver_init+0x0/0x49 @ 1
initcall dnp_driver_init+0x0/0x49 returned 0 after 3 usecs
calling  driver_das16cs_init+0x0/0x4e @ 1
initcall driver_das16cs_init+0x0/0x4e returned 0 after 89 usecs
calling  driver_das08_cs_init+0x0/0x4e @ 1
initcall driver_das08_cs_init+0x0/0x4e returned 0 after 95 usecs
calling  daq700_driver_init+0x0/0x4e @ 1
initcall daq700_driver_init+0x0/0x4e returned 0 after 85 usecs
calling  driver_dio24_init+0x0/0x4e @ 1
initcall driver_dio24_init+0x0/0x4e returned 0 after 75 usecs
calling  driver_labpc_cs_init+0x0/0x4e @ 1
initcall driver_labpc_cs_init+0x0/0x4e returned 0 after 97 usecs
calling  driver_ni_mio_cs_init+0x0/0x4e @ 1
initcall driver_ni_mio_cs_init+0x0/0x4e returned 0 after 82 usecs
calling  driver_daqp_init+0x0/0x4e @ 1
initcall driver_daqp_init+0x0/0x4e returned 0 after 76 usecs
calling  dt9812_driver_init+0x0/0x4e @ 1
usbcore: registered new interface driver dt9812
initcall dt9812_driver_init+0x0/0x4e returned 0 after 893 usecs
calling  ni6501_driver_init+0x0/0x4e @ 1
usbcore: registered new interface driver ni6501
initcall ni6501_driver_init+0x0/0x4e returned 0 after 923 usecs
calling  usbdux_driver_init+0x0/0x4e @ 1
usbcore: registered new interface driver usbdux
initcall usbdux_driver_init+0x0/0x4e returned 0 after 888 usecs
calling  vmk80xx_driver_init+0x0/0x4e @ 1
usbcore: registered new interface driver vmk80xx
initcall vmk80xx_driver_init+0x0/0x4e returned 0 after 930 usecs
calling  mite_module_init+0x0/0x2e @ 1
initcall mite_module_init+0x0/0x2e returned 0 after 1 usecs
calling  ni_tio_init_module+0x0/0x2e @ 1
initcall ni_tio_init_module+0x0/0x2e returned 0 after 1 usecs
calling  ni_tiocmd_init_module+0x0/0x2e @ 1
initcall ni_tiocmd_init_module+0x0/0x2e returned 0 after 1 usecs
calling  ni_routes_module_init+0x0/0x8d @ 1
initcall ni_routes_module_init+0x0/0x8d returned 0 after 2722 usecs
calling  labpc_common_init+0x0/0x2e @ 1
initcall labpc_common_init+0x0/0x2e returned 0 after 1 usecs
calling  ni_labpc_isadma_init_module+0x0/0x2e @ 1
initcall ni_labpc_isadma_init_module+0x0/0x2e returned 0 after 1 usecs
calling  comedi_8255_module_init+0x0/0x2e @ 1
initcall comedi_8255_module_init+0x0/0x2e returned 0 after 1 usecs
calling  dev_8255_driver_init+0x0/0x49 @ 1
initcall dev_8255_driver_init+0x0/0x49 returned 0 after 6 usecs
calling  amplc_dio200_common_init+0x0/0x2e @ 1
initcall amplc_dio200_common_init+0x0/0x2e returned 0 after 1 usecs
calling  amplc_pc236_common_init+0x0/0x2e @ 1
initcall amplc_pc236_common_init+0x0/0x2e returned 0 after 1 usecs
calling  das08_init+0x0/0x2e @ 1
initcall das08_init+0x0/0x2e returned 0 after 1 usecs
calling  tink_board_init+0x0/0x31 @ 1
initcall tink_board_init+0x0/0x31 returned -19 after 1 usecs
calling  dcdrbu_init+0x0/0x1b2 @ 1
initcall dcdrbu_init+0x0/0x1b2 returned 0 after 650 usecs
calling  dell_smbios_init+0x0/0x4f @ 1
dell_smbios: Unable to run on non-Dell system
initcall dell_smbios_init+0x0/0x4f returned -19 after 788 usecs
calling  ibm_rtl_init+0x0/0x625 @ 1
initcall ibm_rtl_init+0x0/0x625 returned -19 after 1 usecs
calling  hdaps_init+0x0/0x69 @ 1
hdaps: supported laptop not found!
hdaps: driver init failed (ret=-19)!
initcall hdaps_init+0x0/0x69 returned -19 after 1317 usecs
calling  atomisp2_led_init+0x0/0x31 @ 1
initcall atomisp2_led_init+0x0/0x31 returned -19 after 1 usecs
calling  pmt_class_init+0x0/0x4e @ 1
initcall pmt_class_init+0x0/0x4e returned 0 after 234 usecs
calling  pmt_crashlog_init+0x0/0x50 @ 1
initcall pmt_crashlog_init+0x0/0x50 returned 0 after 117 usecs
calling  intel_vsec_pci_driver_init+0x0/0x50 @ 1
initcall intel_vsec_pci_driver_init+0x0/0x50 returned 0 after 126 usecs
calling  p50_module_init+0x0/0x31 @ 1
initcall p50_module_init+0x0/0x31 returned -19 after 1 usecs
calling  samsung_init+0x0/0x4fd @ 1
initcall samsung_init+0x0/0x4fd returned -19 after 1 usecs
calling  intel_scu_pci_driver_init+0x0/0x50 @ 1
initcall intel_scu_pci_driver_init+0x0/0x50 returned 0 after 146 usecs
calling  ipc_module_init+0x0/0x65 @ 1
initcall ipc_module_init+0x0/0x65 returned 0 after 22 usecs
calling  simatic_ipc_init_module+0x0/0x2e @ 1
initcall simatic_ipc_init_module+0x0/0x2e returned 0 after 1 usecs
calling  goldfish_pipe_driver_init+0x0/0x4b @ 1
initcall goldfish_pipe_driver_init+0x0/0x4b returned 0 after 146 usecs
calling  platform_mhu_driver_init+0x0/0x4b @ 1
initcall platform_mhu_driver_init+0x0/0x4b returned 0 after 101 usecs
calling  altera_mbox_driver_init+0x0/0x4b @ 1
initcall altera_mbox_driver_init+0x0/0x4b returned 0 after 129 usecs
calling  rproc_virtio_driver_init+0x0/0x4b @ 1
initcall rproc_virtio_driver_init+0x0/0x4b returned 0 after 112 usecs
calling  qcom_glink_ssr_driver_init+0x0/0x4b @ 1
initcall qcom_glink_ssr_driver_init+0x0/0x4b returned 0 after 89 usecs
calling  vmgenid_driver_init+0x0/0x49 @ 1
initcall vmgenid_driver_init+0x0/0x49 returned 0 after 158 usecs
calling  extcon_class_init+0x0/0x44 @ 1
initcall extcon_class_init+0x0/0x44 returned 0 after 44 usecs
calling  gpio_extcon_driver_init+0x0/0x4b @ 1
initcall gpio_extcon_driver_init+0x0/0x4b returned 0 after 114 usecs
calling  max77693_muic_driver_init+0x0/0x4b @ 1
initcall max77693_muic_driver_init+0x0/0x4b returned 0 after 106 usecs
calling  palmas_usb_driver_init+0x0/0x4b @ 1
initcall palmas_usb_driver_init+0x0/0x4b returned 0 after 93 usecs
calling  ptn5150_i2c_driver_init+0x0/0x4b @ 1
initcall ptn5150_i2c_driver_init+0x0/0x4b returned 0 after 100 usecs
calling  usb_extcon_driver_init+0x0/0x4b @ 1
initcall usb_extcon_driver_init+0x0/0x4b returned 0 after 127 usecs
calling  dfl_emif_driver_init+0x0/0x4b @ 1
Driver 'dfl-emif' was unable to register with bus_type 'dfl' because the bus was not initialized.
initcall dfl_emif_driver_init+0x0/0x4b returned -22 after 1279 usecs
calling  ipack_init+0x0/0x9f @ 1
initcall ipack_init+0x0/0x9f returned 0 after 105 usecs
calling  ipoctal_init+0x0/0x50 @ 1
initcall ipoctal_init+0x0/0x50 returned 0 after 71 usecs
calling  tpci200_pci_drv_init+0x0/0x50 @ 1
initcall tpci200_pci_drv_init+0x0/0x50 returned 0 after 172 usecs
calling  ntb_driver_init+0x0/0x49 @ 1
initcall ntb_driver_init+0x0/0x49 returned 0 after 86 usecs
calling  idt_pci_driver_init+0x0/0xc9 @ 1
IDT PCI-E Non-Transparent Bridge Driver 2.0
initcall idt_pci_driver_init+0x0/0xc9 returned 0 after 911 usecs
calling  switchtec_ntb_init+0x0/0x53 @ 1
initcall switchtec_ntb_init+0x0/0x53 returned 0 after 71 usecs
calling  pp_init+0x0/0xe5 @ 1
initcall pp_init+0x0/0xe5 returned 0 after 80 usecs
calling  tool_init+0x0/0xe5 @ 1
initcall tool_init+0x0/0xe5 returned 0 after 70 usecs
calling  intel_rapl_msr_driver_init+0x0/0x4b @ 1
initcall intel_rapl_msr_driver_init+0x0/0x4b returned 0 after 750 usecs
calling  mcb_lpc_init+0x0/0x31 @ 1
initcall mcb_lpc_init+0x0/0x31 returned -19 after 1 usecs
calling  rmem_driver_init+0x0/0x4b @ 1
initcall rmem_driver_init+0x0/0x4b returned 0 after 127 usecs
calling  u_boot_env_driver_init+0x0/0x4b @ 1
initcall u_boot_env_driver_init+0x0/0x4b returned 0 after 150 usecs
calling  altera_ps_driver_init+0x0/0x4b @ 1
initcall altera_ps_driver_init+0x0/0x4b returned 0 after 112 usecs
calling  ice40_fpga_driver_init+0x0/0x4b @ 1
initcall ice40_fpga_driver_init+0x0/0x4b returned 0 after 75 usecs
calling  xilinx_slave_spi_driver_init+0x0/0x4b @ 1
SPI driver xlnx-slave-spi has no spi_device_id for xlnx,fpga-slave-serial
initcall xilinx_slave_spi_driver_init+0x0/0x4b returned 0 after 1111 usecs
calling  mpf_driver_init+0x0/0x4b @ 1
initcall mpf_driver_init+0x0/0x4b returned 0 after 74 usecs
calling  alt_pr_platform_driver_init+0x0/0x4b @ 1
initcall alt_pr_platform_driver_init+0x0/0x4b returned 0 after 119 usecs
calling  altera_freeze_br_driver_init+0x0/0x4b @ 1
initcall altera_freeze_br_driver_init+0x0/0x4b returned 0 after 110 usecs
calling  xlnx_pr_decoupler_driver_init+0x0/0x4b @ 1
initcall xlnx_pr_decoupler_driver_init+0x0/0x4b returned 0 after 105 usecs
calling  dfl_fpga_init+0x0/0x258 @ 1
initcall dfl_fpga_init+0x0/0x258 returned 0 after 96 usecs
calling  afu_init+0x0/0xa3 @ 1
initcall afu_init+0x0/0xa3 returned 0 after 173 usecs
calling  cci_pci_driver_init+0x0/0x50 @ 1
initcall cci_pci_driver_init+0x0/0x50 returned 0 after 156 usecs
calling  fsi_master_gpio_driver_init+0x0/0x4b @ 1
initcall fsi_master_gpio_driver_init+0x0/0x4b returned 0 after 130 usecs
calling  sbefifo_init+0x0/0x30 @ 1
initcall sbefifo_init+0x0/0x30 returned 0 after 66 usecs
calling  adg792a_driver_init+0x0/0x4b @ 1
initcall adg792a_driver_init+0x0/0x4b returned 0 after 127 usecs
calling  adgs1408_driver_init+0x0/0x4b @ 1
initcall adgs1408_driver_init+0x0/0x4b returned 0 after 71 usecs
calling  mux_gpio_driver_init+0x0/0x4b @ 1
initcall mux_gpio_driver_init+0x0/0x4b returned 0 after 120 usecs
calling  mux_mmio_driver_init+0x0/0x4b @ 1
initcall mux_mmio_driver_init+0x0/0x4b returned 0 after 127 usecs
calling  quad8_driver_init+0x0/0xa1 @ 1
initcall quad8_driver_init+0x0/0xa1 returned -19 after 155 usecs
calling  interrupt_cnt_driver_init+0x0/0x4b @ 1
initcall interrupt_cnt_driver_init+0x0/0x4b returned 0 after 150 usecs
calling  mchp_tc_driver_init+0x0/0x4b @ 1
initcall mchp_tc_driver_init+0x0/0x4b returned 0 after 115 usecs
calling  intel_qep_driver_init+0x0/0x50 @ 1
initcall intel_qep_driver_init+0x0/0x50 returned 0 after 156 usecs
calling  sock_diag_init+0x0/0x9e @ 1
initcall sock_diag_init+0x0/0x9e returned 0 after 89 usecs
calling  gre_offload_init+0x0/0xcc @ 1
initcall gre_offload_init+0x0/0xcc returned 0 after 2 usecs
calling  sysctl_ipv4_init+0x0/0xce @ 1
initcall sysctl_ipv4_init+0x0/0xce returned 0 after 167 usecs
calling  tunnel4_init+0x0/0xf3 @ 1
initcall tunnel4_init+0x0/0xf3 returned 0 after 1 usecs
calling  inet_diag_init+0x0/0x13f @ 1
initcall inet_diag_init+0x0/0x13f returned 0 after 85 usecs
calling  tcp_diag_init+0x0/0x49 @ 1
initcall tcp_diag_init+0x0/0x49 returned 0 after 49 usecs
calling  cubictcp_register+0x0/0xc5 @ 1
initcall cubictcp_register+0x0/0xc5 returned 0 after 4 usecs
calling  inet6_init+0x0/0xb56 @ 1
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
initcall inet6_init+0x0/0xb56 returned 0 after 4334 usecs
calling  sit_init+0x0/0x1dd @ 1
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
initcall sit_init+0x0/0x1dd returned 0 after 2404 usecs
calling  packet_init+0x0/0x172 @ 1
NET: Registered PF_PACKET protocol family
initcall packet_init+0x0/0x172 returned 0 after 757 usecs
calling  init_p9+0x0/0x9b @ 1
9pnet: Installing 9P2000 support
initcall init_p9+0x0/0x9b returned 0 after 806 usecs
calling  p9_trans_fd_init+0x0/0x7a @ 1
initcall p9_trans_fd_init+0x0/0x7a returned 0 after 37 usecs
calling  p9_virtio_init+0x0/0xb5 @ 1
initcall p9_virtio_init+0x0/0xb5 returned 0 after 96 usecs
calling  plist_test+0x0/0x39c @ 1
start plist test
end plist test
initcall plist_test+0x0/0x39c returned 0 after 7116 usecs
calling  mcheck_init_device+0x0/0x28d @ 1
initcall mcheck_init_device+0x0/0x28d returned 0 after 1014 usecs
calling  kernel_do_mounts_initrd_sysctls_init+0x0/0x54 @ 1
initcall kernel_do_mounts_initrd_sysctls_init+0x0/0x54 returned 0 after 20 usecs
calling  mcheck_late_init+0x0/0x9c @ 1
initcall mcheck_late_init+0x0/0x9c returned 0 after 3 usecs
calling  severities_debugfs_init+0x0/0x6d @ 1
initcall severities_debugfs_init+0x0/0x6d returned 0 after 2 usecs
calling  microcode_init+0x0/0x3c3 @ 1
initcall microcode_init+0x0/0x3c3 returned -22 after 1 usecs
calling  hpet_insert_resource+0x0/0x77 @ 1
initcall hpet_insert_resource+0x0/0x77 returned 0 after 6 usecs
calling  start_sync_check_timer+0x0/0xdf @ 1
initcall start_sync_check_timer+0x0/0xdf returned 0 after 1 usecs
calling  update_mp_table+0x0/0x5ee @ 1
initcall update_mp_table+0x0/0x5ee returned 0 after 1 usecs
calling  lapic_insert_resource+0x0/0x8a @ 1
initcall lapic_insert_resource+0x0/0x8a returned 0 after 5 usecs
calling  print_ipi_mode+0x0/0x7f @ 1
IPI shorthand broadcast: enabled
initcall print_ipi_mode+0x0/0x7f returned 0 after 628 usecs
calling  print_ICs+0x0/0x11c @ 1
... APIC ID:      00000000 (0)
... APIC VERSION: 00050014
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000001000

number of MP IRQ sources: 15.
number of IO-APIC #0 registers: 24.
testing the IO APIC.......................
IO APIC #0......
.... register #00: 00000000
.......    : physical APIC id: 00
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 17
.......     : PRQ implemented: 0
.......     : IO APIC version: 11
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
IOAPIC 0:
pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin01, enabled , edge , high, V(22), IRR(0), S(0), logical , D(0001), M(0)
pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(0001), M(0)
pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin07, enabled , edge , high, V(21), IRR(0), S(0), logical , D(0001), M(0)
pin08, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin09, enabled , level, high, V(21), IRR(0), S(0), logical , D(0002), M(0)
pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0c, enabled , edge , high, V(22), IRR(0), S(0), logical , D(0002), M(0)
pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
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
.................................... done.
initcall print_ICs+0x0/0x11c returned 0 after 48798 usecs
calling  setup_efi_kvm_sev_migration+0x0/0x2e @ 1
initcall setup_efi_kvm_sev_migration+0x0/0x2e returned 0 after 1 usecs
calling  create_tlb_single_page_flush_ceiling+0x0/0x5e @ 1
initcall create_tlb_single_page_flush_ceiling+0x0/0x5e returned 0 after 2 usecs
calling  aesni_init+0x0/0x170 @ 1
initcall aesni_init+0x0/0x170 returned 0 after 1193 usecs
calling  kernel_panic_sysctls_init+0x0/0x54 @ 1
initcall kernel_panic_sysctls_init+0x0/0x54 returned 0 after 20 usecs
calling  reboot_ksysfs_init+0x0/0x10b @ 1
initcall reboot_ksysfs_init+0x0/0x10b returned 0 after 79 usecs
calling  sched_core_sysctl_init+0x0/0x54 @ 1
initcall sched_core_sysctl_init+0x0/0x54 returned 0 after 14 usecs
calling  sched_fair_sysctl_init+0x0/0x54 @ 1
initcall sched_fair_sysctl_init+0x0/0x54 returned 0 after 15 usecs
calling  sched_rt_sysctl_init+0x0/0x54 @ 1
initcall sched_rt_sysctl_init+0x0/0x54 returned 0 after 18 usecs
calling  sched_dl_sysctl_init+0x0/0x54 @ 1
initcall sched_dl_sysctl_init+0x0/0x54 returned 0 after 16 usecs
calling  sched_clock_init_late+0x0/0x99 @ 1
sched_clock: Marking stable (19407421062, 43970306)->(19808796044, -357404676)
initcall sched_clock_init_late+0x0/0x99 returned 0 after 1122 usecs
calling  sched_init_debug+0x0/0x27d @ 1
initcall sched_init_debug+0x0/0x27d returned 0 after 10 usecs
calling  kernel_lockdep_sysctls_init+0x0/0x54 @ 1
initcall kernel_lockdep_sysctls_init+0x0/0x54 returned 0 after 22 usecs
calling  cpu_latency_qos_init+0x0/0x99 @ 1
initcall cpu_latency_qos_init+0x0/0x99 returned 0 after 426 usecs
calling  printk_late_init+0x0/0x384 @ 1
initcall printk_late_init+0x0/0x384 returned 0 after 35 usecs
calling  rcu_verify_early_boot_tests+0x0/0xe0 @ 1
initcall rcu_verify_early_boot_tests+0x0/0xe0 returned 0 after 1 usecs
calling  rcu_tasks_verify_schedule_work+0x0/0xd0 @ 1
initcall rcu_tasks_verify_schedule_work+0x0/0xd0 returned 0 after 2 usecs
calling  init_srcu_module_notifier+0x0/0x8d @ 1
initcall init_srcu_module_notifier+0x0/0x8d returned 0 after 6 usecs
calling  swiotlb_create_default_debugfs+0x0/0xec @ 1
initcall swiotlb_create_default_debugfs+0x0/0xec returned 0 after 2 usecs
calling  tk_debug_sleep_time_init+0x0/0x5a @ 1
initcall tk_debug_sleep_time_init+0x0/0x5a returned 0 after 2 usecs
calling  kexec_core_sysctl_init+0x0/0x54 @ 1
initcall kexec_core_sysctl_init+0x0/0x54 returned 0 after 20 usecs
calling  bpf_rstat_kfunc_init+0x0/0x2e @ 1
initcall bpf_rstat_kfunc_init+0x0/0x2e returned 0 after 1 usecs
calling  debugfs_kprobe_init+0x0/0xc5 @ 1
initcall debugfs_kprobe_init+0x0/0xc5 returned 0 after 2 usecs
calling  load_system_certificate_list+0x0/0x76 @ 1
Loading compiled-in X.509 certificates
initcall load_system_certificate_list+0x0/0x76 returned 0 after 836 usecs
calling  load_revocation_certificate_list+0x0/0x98 @ 1
initcall load_revocation_certificate_list+0x0/0x98 returned 0 after 1 usecs
calling  init_lru_gen+0x0/0xd9 @ 1
initcall init_lru_gen+0x0/0xd9 returned 0 after 40 usecs
calling  fault_around_debugfs+0x0/0x5a @ 1
initcall fault_around_debugfs+0x0/0x5a returned 0 after 2 usecs
calling  max_swapfiles_check+0x0/0x2e @ 1
initcall max_swapfiles_check+0x0/0x2e returned 0 after 1 usecs
calling  pageowner_init+0x0/0xb5 @ 1
initcall pageowner_init+0x0/0xb5 returned 0 after 2 usecs
calling  check_early_ioremap_leak+0x0/0x115 @ 1
initcall check_early_ioremap_leak+0x0/0x115 returned 0 after 1 usecs
calling  cma_debugfs_init+0x0/0xc4 @ 1
initcall cma_debugfs_init+0x0/0xc4 returned 0 after 2 usecs
calling  set_hardened_usercopy+0x0/0x75 @ 1
initcall set_hardened_usercopy+0x0/0x75 returned 1 after 1 usecs
calling  shrinker_debugfs_init+0x0/0x148 @ 1
initcall shrinker_debugfs_init+0x0/0x148 returned -2 after 1 usecs
calling  fsverity_init+0x0/0x126 @ 1
fs-verity: Initialized fs-verity
initcall fsverity_init+0x0/0x126 returned 0 after 14095 usecs
calling  ubifs_init+0x0/0x22c @ 1
initcall ubifs_init+0x0/0x22c returned 0 after 4166 usecs
calling  init_root_keyring+0x0/0x48 @ 1
initcall init_root_keyring+0x0/0x48 returned 0 after 362 usecs
calling  init_trusted+0x0/0x2e @ 1
initcall init_trusted+0x0/0x2e returned 0 after 1 usecs
calling  init_encrypted+0x0/0x1cc @ 1
Key type encrypted registered
initcall init_encrypted+0x0/0x1cc returned 0 after 23829 usecs
calling  integrity_fs_init+0x0/0x3b @ 1
initcall integrity_fs_init+0x0/0x3b returned -19 after 1 usecs
calling  init_evm+0x0/0x199 @ 1
evm: Initialising EVM extended attributes:
evm: security.selinux (disabled)
evm: security.SMACK64 (disabled)
evm: security.SMACK64EXEC (disabled)
evm: security.SMACK64TRANSMUTE (disabled)
evm: security.SMACK64MMAP (disabled)
evm: security.apparmor (disabled)
evm: security.ima (disabled)
evm: security.capability
evm: HMAC attrs: 0x1
evm: Error registering secfs
initcall init_evm+0x0/0x199 returned -14 after 7030 usecs
calling  crypto_algapi_init+0x0/0x58 @ 1
initcall crypto_algapi_init+0x0/0x58 returned 0 after 48894 usecs
calling  blk_timeout_init+0x0/0x38 @ 1
initcall blk_timeout_init+0x0/0x38 returned 0 after 1 usecs
calling  init_error_injection+0x0/0x181 @ 1
initcall init_error_injection+0x0/0x181 returned 0 after 1139 usecs
calling  pci_resource_alignment_sysfs_init+0x0/0x4e @ 1
initcall pci_resource_alignment_sysfs_init+0x0/0x4e returned 0 after 23 usecs
calling  pci_sysfs_init+0x0/0x14d @ 1
initcall pci_sysfs_init+0x0/0x14d returned 0 after 187 usecs
calling  clk_debug_init+0x0/0x1df @ 1
initcall clk_debug_init+0x0/0x1df returned 0 after 64 usecs
calling  sync_state_resume_initcall+0x0/0x30 @ 1
initcall sync_state_resume_initcall+0x0/0x30 returned 0 after 5 usecs
calling  deferred_probe_initcall+0x0/0x110 @ 1
initcall deferred_probe_initcall+0x0/0x110 returned 0 after 4800 usecs
calling  wl1273_core_init+0x0/0x8f @ 1
initcall wl1273_core_init+0x0/0x8f returned 0 after 127 usecs
calling  block2mtd_init+0x0/0xd6 @ 1
initcall block2mtd_init+0x0/0xd6 returned 0 after 1 usecs
calling  ubi_init+0x0/0x4cc @ 1
UBI error: cannot create "ubi" debugfs directory, error -2
UBI error: cannot initialize UBI, error -2
initcall ubi_init+0x0/0x4cc returned -2 after 1828 usecs
calling  aqc_init+0x0/0x50 @ 1
initcall aqc_init+0x0/0x50 returned 0 after 121 usecs
calling  kraken2_init+0x0/0x50 @ 1
initcall kraken2_init+0x0/0x50 returned 0 after 112 usecs
calling  powernow_init+0x0/0x84 @ 1
initcall powernow_init+0x0/0x84 returned -19 after 1 usecs
calling  centrino_init+0x0/0x89 @ 1
initcall centrino_init+0x0/0x89 returned -19 after 1 usecs
calling  cpufreq_p4_init+0x0/0xf6 @ 1
initcall cpufreq_p4_init+0x0/0xf6 returned -19 after 1 usecs
calling  edd_init+0x0/0x2e0 @ 1
initcall edd_init+0x0/0x2e0 returned -19 after 1 usecs
calling  of_fdt_raw_init+0x0/0xd2 @ 1
initcall of_fdt_raw_init+0x0/0xd2 returned 0 after 1 usecs
calling  cec_init+0x0/0x247 @ 1
RAS: Correctable Errors collector initialized.
initcall cec_init+0x0/0x247 returned 0 after 906 usecs
calling  tcp_congestion_default+0x0/0x4e @ 1
initcall tcp_congestion_default+0x0/0x4e returned 0 after 3 usecs
calling  ip_auto_config+0x0/0xa3a @ 1
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
IP-Config: Complete:
device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
host=vm-meta-173, domain=, nis-domain=(none)
bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
nameserver0=10.0.2.3
initcall ip_auto_config+0x0/0xa3a returned 0 after 1019813 usecs
calling  pci_mmcfg_late_insert_resources+0x0/0xdb @ 1
initcall pci_mmcfg_late_insert_resources+0x0/0xdb returned 0 after 1 usecs
calling  trace_eval_sync+0x0/0x6d @ 1
initcall trace_eval_sync+0x0/0x6d returned 0 after 176 usecs
calling  late_trace_init+0x0/0x20d @ 1
initcall late_trace_init+0x0/0x20d returned 0 after 1 usecs
calling  acpi_gpio_handle_deferred_request_irqs+0x0/0xbc @ 1
initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xbc returned 0 after 601 usecs
calling  clk_disable_unused+0x0/0x2e3 @ 1
initcall clk_disable_unused+0x0/0x2e3 returned 0 after 52 usecs
calling  regulator_init_complete+0x0/0xa7 @ 1
initcall regulator_init_complete+0x0/0xa7 returned 0 after 4 usecs
calling  of_platform_sync_state_init+0x0/0x45 @ 1
initcall of_platform_sync_state_init+0x0/0x45 returned 0 after 33 usecs
Freeing unused kernel image (initmem) memory: 2904K
Write protecting kernel text and read-only data: 55436k
Run /init as init process
with arguments:
/init
with environment:
HOME=/
TERM=linux
RESULT_ROOT=/result/rcutorture/300s-default-tasks-tracing/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/19
BOOT_IMAGE=/pkg/linux/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/vmlinuz-6.1.0-rc2-00014-g0af8489b0216
branch=linux-next/master
job=/lkp/jobs/scheduled/vm-meta-173/rcutorture-300s-default-tasks-tracing-debian-11.1-i386-20220923.cgz-0af8489b0216fa1dd83e264bef8063f2632633d7-20221231-13940-1j3s4jz-4.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-a012-20221226
commit=0af8489b0216fa1dd83e264bef8063f2632633d7
max_uptime=1200
LKP_SERVER=internal-lkp-server
selinux=0
softlockup_panic=1
prompt_ramdisk=0
vga=normal
systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
systemd[1]: Failed to find module 'autofs4'

Welcome to Debian GNU/Linux 11 (bullseye)!

process 162 ((sd-executor)) attempted a POSIX timer syscall while CONFIG_POSIX_TIMERS is not set
systemd-getty-g (167) used greatest stack depth: 5828 bytes left
systemd-bless-b (163) used greatest stack depth: 5748 bytes left
systemd-debug-g (165) used greatest stack depth: 5716 bytes left
systemd-veritys (174) used greatest stack depth: 5696 bytes left
random: crng init done
Created slice system-getty.slice.
Created slice system-modprobe.slice.
Created slice User and Session Slice.
Reached target Local Encrypted Volumes.
Reached target Paths.
Reached target Slices.
Reached target Swap.
Listening on RPCbind Server Activation Socket.
Listening on Syslog Socket.
Listening on initctl Compatibility Named Pipe.
Listening on Journal Socket (/dev/log).
Listening on Journal Socket.
Listening on udev Control Socket.
Listening on udev Kernel Socket.
Mounting Huge Pages File System...
Mounting RPC Pipe File System...
Mounting Kernel Trace File System...
Starting Load Kernel Module configfs...
Starting Load Kernel Module drm...
Starting Load Kernel Module fuse...
Starting Journal Service...
Starting Load Kernel Modules...
Starting Remount Root and Kernel File Systems...
Starting Coldplug All udev Devices...
Mounted Huge Pages File System.
Mounted RPC Pipe File System.
Mounted Kernel Trace File System.
Finished Load Kernel Module configfs.
Finished Load Kernel Module drm.
Finished Load Kernel Module fuse.
Finished Remount Root and Kernel File Systems.
Mounting Kernel Configuration File System...
Starting Load/Save Random Seed...
Starting Create System Users...
Finished Load Kernel Modules.
Mounted Kernel Configuration File System.
Starting Apply Kernel Variables...
Finished Load/Save Random Seed.
Finished Create System Users.
Starting Create Static Device Nodes in /dev...
Finished Apply Kernel Variables.
systemd-tmpfile (191) used greatest stack depth: 5504 bytes left
Finished Create Static Device Nodes in /dev.
Reached target Local File Systems (Pre).
Reached target Local File Systems.
Starting Preprocess NFS configuration...
Finished Preprocess NFS configuration.
Reached target NFS client services.
Started Rule-based Manager for Device Events and Files.
Started Journal Service.
Starting Flush Journal to Persistent Storage...
Finished Flush Journal to Persistent Storage.
Starting Create Volatile Files and Directories...
Finished Create Volatile Files and Directories.
Starting RPC bind portmap service...
Starting Update UTMP about System Boot/Shutdown...
Started RPC bind portmap service.
Reached target Remote File Systems (Pre).
Reached target Remote File Systems.
Reached target RPC Port Mapper.
Failed to start Update UTMP about System Boot/Shutdown.
See 'systemctl status systemd-update-utmp.service' for details.
page:e660911a refcount:0 mapcount:0 mapping:00000000 index:0xedaeef00 pfn:0x2daee
page:0946d53a refcount:0 mapcount:0 mapping:00000000 index:0x0 pfn:0x2daec
flags: 0x0(zone=0)
raw: 00000000 e764d494 e6f205b4 00000000 00000000 00020000 ffffffff 00000000
raw: 00000000 00000000
page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
page_owner tracks the page as freed
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 208, tgid 208 (systemd-udevd), ts 25780391126, free_ts 25780421356
post_alloc_hook+0x1fa/0x280
get_page_from_freelist+0x226/0x310
__alloc_pages+0xdd/0x360
alloc_slab_page+0x12d/0x200
allocate_slab+0x6a/0x350
new_slab+0x48/0xc0
__slab_alloc_node+0xfb/0x270
kmem_cache_alloc+0x8f/0x4e0
getname_flags+0x33/0x2f0
getname+0x1a/0x30
do_sys_openat2+0xa5/0x1f0
do_sys_open+0x8e/0xe0
__ia32_sys_openat+0x2b/0x40
__do_fast_syscall_32+0x72/0xd0
do_fast_syscall_32+0x32/0x70
do_SYSENTER_32+0x15/0x20
page last free stack trace:
free_pcp_prepare+0x34f/0x940
free_unref_page_prepare+0x29/0x210
free_unref_page+0x3a/0x3b0
__free_pages+0x187/0x1f0
__free_slab+0x1fd/0x350
free_slab+0x22/0x70
free_to_partial_list+0x125/0x260
do_slab_free+0x30/0x70
kmem_cache_free+0x171/0x1e0
putname+0x9f/0xf0
do_sys_openat2+0xe2/0x1f0
do_sys_open+0x8e/0xe0
__ia32_sys_openat+0x2b/0x40
__do_fast_syscall_32+0x72/0xd0
do_fast_syscall_32+0x32/0x70
do_SYSENTER_32+0x15/0x20
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:825!
invalid opcode: 0000 [#1] SMP
CPU: 0 PID: 214 Comm: udevadm Tainted: G S                 6.1.0-rc2-00014-g0af8489b0216 #2 1c4d7707ec0ce574ed62a77e82a8580202758048
EIP: __dump_page.cold+0x282/0x369
Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
DR6: fffe0ff0 DR7: 00000400
Call Trace:
dump_page+0x2a/0xc0
? _raw_spin_lock_irqsave+0x16/0x30
folio_flags+0x23/0x70
get_partial_node+0x89/0x290
__slab_alloc_node+0xbb/0x270
kmem_cache_alloc_lru+0x8d/0x4e0
? __lock_release+0x3ec/0x410
? iget_locked+0x78/0x310
alloc_inode+0x93/0x150
iget_locked+0xdd/0x310
? lock_is_held_type+0x80/0xf0
kernfs_get_inode+0x24/0xb0
kernfs_iop_lookup+0xb5/0x1a0
__lookup_slow+0xd9/0x2a0
lookup_slow+0x50/0x90
walk_component+0x19c/0x2c0
path_lookupat+0xa3/0x270
path_openat+0x307/0x3e0
do_filp_open+0x7c/0x130
do_sys_openat2+0x113/0x1f0
do_sys_open+0x8e/0xe0
__ia32_sys_openat+0x2b/0x40
__do_fast_syscall_32+0x72/0xd0
? trace_hardirqs_on+0xa2/0x110
? __fput+0x19f/0x390
? lockdep_hardirqs_on_prepare+0x242/0x400
? syscall_exit_to_user_mode+0x5f/0x90
? __do_fast_syscall_32+0x7c/0xd0
? lockdep_hardirqs_on_prepare+0x242/0x400
? syscall_exit_to_user_mode+0x5f/0x90
? __do_fast_syscall_32+0x7c/0xd0
? __do_fast_syscall_32+0x7c/0xd0
? syscall_exit_to_user_mode+0x5f/0x90
? __do_fast_syscall_32+0x7c/0xd0
? __do_fast_syscall_32+0x7c/0xd0
? __do_fast_syscall_32+0x7c/0xd0
? irqentry_exit_to_user_mode+0x23/0x30
? irqentry_exit+0x7f/0xc0
do_fast_syscall_32+0x32/0x70
do_SYSENTER_32+0x15/0x20
entry_SYSENTER_32+0xa2/0xfb
EIP: 0xb7f8c549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
EAX: ffffffda EBX: 00000006 ECX: 006142a1 EDX: 002a8000
ESI: 00000000 EDI: 00000001 EBP: 00614024 ESP: bff3c4a0
DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200246
Modules linked in:
---[ end trace 0000000000000000 ]---
EIP: __dump_page.cold+0x282/0x369
Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
DR6: fffe0ff0 DR7: 00000400
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled

Kboot worker: lkp-worker32
Elapsed time: 60

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu SandyBridge
	-kernel $kernel
	-initrd initrd-vm-meta-173.cgz
	-m 16384
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::32032-:22
	-boot order=nc
	-no-reboot
	-device i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	ip=::::vm-meta-173::dhcp
	root=/dev/ram0
	RESULT_ROOT=/result/rcutorture/300s-default-tasks-tracing/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/19
	BOOT_IMAGE=/pkg/linux/i386-randconfig-a012-20221226/gcc-11/0af8489b0216fa1dd83e264bef8063f2632633d7/vmlinuz-6.1.0-rc2-00014-g0af8489b0216
	branch=linux-next/master
	job=/job-script
	user=lkp
	ARCH=i386
	kconfig=i386-randconfig-a012-20221226
	commit=0af8489b0216fa1dd83e264bef8063f2632633d7
	vmalloc=256M
	initramfs_async=0
	page_owner=on
	initcall_debug
	mem=4G
	nmi_watchdog=0
	max_uptime=1200
	result_service=tmpfs
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
	rw
	mem=4G
	rcuperf.shutdown=0
	watchdog_thresh=240
)

"${kvm[@]}" -append "${append[*]}"

--veVQscFeJEhLZOz5--
