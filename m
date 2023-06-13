Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C553472ECAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbjFMUNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbjFMUM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:12:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772E51BFB;
        Tue, 13 Jun 2023 13:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQPLCKgnAdruHlomaGBJho5jo1Yj/iXaSTSQCkd42fMcJuP1+qp2uyMP0Kv1s/nHjZPiX0Qjj44DN2buKyx+/cRrayx5iUsjBFwIjOF1gH1vBFXEYrQ2CwLwO0dalYEoHD0CxqBgbl1Wl5vjlm5WuCQizzI3ctpxb44+2fP1krRAgcrzhCkIuryrt8fSMWPAhkXy4sx9XMcjNIzxqCjv58m3FDYxxaILU8QaenPZ83xUHID0j9qsBX6MvdMhJilZ11FnWNOm4WaFQ5o3SksTLAyfyxk/lQsTzujYHY/2yBYFyb4AQsn90AvAdD35qBfh+2kfqih+dGCJ2BBXo0elqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFKVnSXPjdLrljPosol9fuAJPCWx85tft15xxfQ5LN0=;
 b=Hs0tr/WpBicatoWkOKNdqk7g+gv9kVhituaHth0R6EyhTVWgeGDXGscKByrbocuBTYtdiFrSsd/WR/OkgAzrjLAegttgntKWzs6NXese4Q4uLcqWT7jZw3pUJS2HNH8gwtsRfYzknmwrWpanpa4dtGoZw+ElJv/IXqrm8Yk1/7ZWkgxPhW3YE53wmvn9SqaO1WL3tbouEth44V2CZVMQe7vO6+Vep2Lq+0wI9plZapEBoKwTTRfRn989eVl9tSW/NOoHYgIJPCZoWiwAbP2tase11bvG73bAiYexCqfUAa7bfT8504aYM2heNCoUpDl78TlqBrPJtGnTmnl53DQfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFKVnSXPjdLrljPosol9fuAJPCWx85tft15xxfQ5LN0=;
 b=vyuUkGWUBJKzKCpCr1TDN7f59+lWC0UJWbeb2yH/8U7DalyCzcT53Sl8HWljf7Fy+d8AK0BLfEEVEP3w+jAfigepiWcAhZhsAksPVuKyTzaxK/3Zun9WEsooMWziC3B8rxRfgja3S6SvzCgLafKx3/UGYS5RdB/mdjsgje5XUyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 20:12:35 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 20:12:35 +0000
Message-ID: <e78344ad-8d57-91d8-0bfb-724c740c7c72@amd.com>
Date:   Wed, 14 Jun 2023 01:42:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
From:   "Jain, Ayush" <ayush.jain3@amd.com>
To:     sfr@canb.auug.org.au,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Kernel null pointer dereference on stopping raid device
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0220.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::18) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: af08a8d7-1489-4624-79a2-08db6c4a8703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4r158NXuwOSMJFdCQEsuXralfcSzQRxip6M93DiWaZNS9qjRRLFnU04vDji0vbVB2AcJdJ8q8bs47EIOq1Oss44e3SiBvl4R4/ArSgjs2y8UG40F+kRE+SEJZUUt+cl3r2mn8r9qpBjqP26r8PLWOOQRh/9ISg/MS+oVKE56D6YeWweq1qqgrgjxxup6UMfNYx/LKjWFMt6spivZp38IOQEm1/PAI8aJol6Ndty2+RFuNWjgKLYZj6XZOOBo5KQfeLw5Kkdzbh+i4pY4TpJr4DsYDcU+XVj0VEHLR3LcOYzS5Asgw1whh4kkOsCJkncBl673uPYOyTm5CwVJlDhGjtHNZNVG7dW05d6Z8Oq0PWEhECssi2Ll9oA0YQPbpBnEQlsOTiG0BMDmfEzH3cI4TZSTCIV7VGj7FZNqm1eWRsXnLbqRZF87RZocUfQz12wZiRzJXQauvo9Lb8HP9XNfMPL8Qfi8Hx7ZEQkxJw6iH7gEEUtp1Jw6HK2E0Ee9v/L4P2Ak64rCS7+YTLUfJQItgGDfCM/87trsgvLNKr9OdReWIjV+m/8oZWbBuRB3dRYWrB8lmtw7nwUDmn+pEy3ZK6caot84Hi1mtJNlD59StG7yNVEnVXoh5EE2GPIsTnFpB6GMWh1pXenxGPaf03Iiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(31686004)(66946007)(66556008)(36756003)(186003)(478600001)(110136005)(2616005)(2906002)(66476007)(8676002)(6666004)(316002)(41300700001)(31696002)(86362001)(6486002)(6506007)(8936002)(83380400001)(26005)(5660300002)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWdLckFXYk9ZL0RVKzVTZTYweThkR2U3cjF3VzdXRXduNGlCeStOQllGN2NI?=
 =?utf-8?B?dHRxSTFPb1ZQeURPdlMzdVBTUVZGOGpxazlXYWJGbmQ3bjY0b0lQUjVTRFpr?=
 =?utf-8?B?UzAxaUI3WVhhYllGZGNzbnM0SElkUUhPSXM5UE1QUk42M2pMSlcvZ3ZMUXcw?=
 =?utf-8?B?a05nd1VwVUJYVFZFVk1hRVdzNC9jVFd3Q3hmOEpHL0d0YnZscVBqZEJGaFov?=
 =?utf-8?B?Y1A0QlVJN2pGS1FQSkpXdFJmUUN2OXRpclZwM3N5djFaQ2xsUUxhaTZkSEFL?=
 =?utf-8?B?dUo1NjdGWkZjK3pUQVVxMkN4VGhhZk9LaCsvbDFQSkNFVlpnbW95VjRDR29J?=
 =?utf-8?B?dGVHTEJQaURQRldJTWFxM2pPZXVvNVV1c1Fqb0h6MmZtT2l6eW1BQXpHN2s5?=
 =?utf-8?B?R3dONGJ5a3c3bzl5MnRRR1dxc05RdXc0RGhHdm1DbmNiZHNBQStYc2RsR3Bs?=
 =?utf-8?B?NC9xd0RFeFhaSklUSmZGWVg4OWgvR0xMNTl6QXNuVDB4UFpjSm9ZRExNL2VZ?=
 =?utf-8?B?U0NMZXUrWnpnaHRWbGM4M2Jvb2tRK1ZLa0lLVnk1ZzhjRFlrVkxna241anFr?=
 =?utf-8?B?YXVQWTQ2MUFqcFBHYzFrQ2VjVUNWd05WamtPNFAvOUZTOUZQTk9oWEdheXI5?=
 =?utf-8?B?THRQUDlwaVpLajRreTBXM3lqWkwyb2V6MzVmbTdIeXlvSW1uMG5wSVQxT0p5?=
 =?utf-8?B?V0hqM2Q2c2l2eFlCenZHaWNvMy9pT3R3ZnhZbThVZHVuMEhlL2Y2eWhnaWwz?=
 =?utf-8?B?eU5PTW1sOG1UWTZNZ2tDMk5Yc2c2c0FndlQzWmUwNHNqdTVDRVM4SysweWtH?=
 =?utf-8?B?TGNkNkhBS0Q1Q00vaTVIeXVoNlIzeTF6dDNuNlNmaFovZm9HYVJnV2R3OFVv?=
 =?utf-8?B?M2V5U0RJK0FwUGhxQi93U3czUmRBMDlHSXdZeE5OekpKcmJ4TExUcWZIdmpw?=
 =?utf-8?B?dDFpblJsdlpka015WUE1RXkzNE16ZllxeWNuaUd1N1VnQzhHazVZdTh2alBM?=
 =?utf-8?B?SkxnZUVmY3RrL0tFMS9yMmRLQkZDdnc5UmhxQ0I1STc0cVYwY1RiRmVXRGI2?=
 =?utf-8?B?RmpJZnFCKzJvcEkwaE1LZlRmWXJHQUw5MUVQR015N1JvMVYweXhuaGVSODg3?=
 =?utf-8?B?U1pYSmgySy9xZE10WW5wdnN0dGxIZjZJREF4YW55djR4bnRxa3JVOUh5Uld1?=
 =?utf-8?B?U2ZkSXp5NWQvdHc3NFRIRlFkMHRXLy8vM1ZDeDhJYUxkd0pCbGtOdGQxZUlz?=
 =?utf-8?B?SEdJaERiaWl5S0RxYWU4NzZTTTRQQU1jaUJNZ0RLczQ3dURnNVdoZWpHTFlE?=
 =?utf-8?B?S3g1TzZ0UWVjMHhTNGthV0hnVkZDZHYvd2FjbWtjc2ZUZmVVc2wrbTJnZGQy?=
 =?utf-8?B?QjB1c3RLOHRIU0dkZG5aODdrUTRTL1VqTDg4WTBuUGFSZ3BybnpUeVdCUWFh?=
 =?utf-8?B?V0ZtMU40TzNhNENSSWZTUVVmN0p1Z3JwSjA1bVJnNlpLcHFSenArdEFSc09G?=
 =?utf-8?B?elErVE5FTS9kdktwNDd2NklKaFNDZjdKbnE3eGhyb3pkWHpBbmVSMmFPVXNX?=
 =?utf-8?B?QlFSejhIUTVJNHVQQjRWSWFab1Z2dExxc3pOSkt1R245SExuVDdnUmo1OTU2?=
 =?utf-8?B?RUZsbVJxM25xMGJsT2VlN0FmQWxTWVBWMy8vQmNNUFh6RkdobkptRHNxMjh1?=
 =?utf-8?B?UnhrN0dMdjdxbjc2bWtMNE1ZektkZ2lQT2paNnAzZjdkeXpQTEs2Qm9QeXdO?=
 =?utf-8?B?T25QclJaV240V3VEaW9Hc216QkZKcW5nL2hNRmNIWHhJYmwrUlI5cHNMd3ZG?=
 =?utf-8?B?YUNtMVFrS05pOXdJYlEzVG5CSEJETEtVR3ZteUpBd1NwWVZSR2xnVk5QdEpv?=
 =?utf-8?B?WnVKSTlWZVNqQUxPVXJiQUU1UlUwKzhRc0Qxc2RpR0ZTSTBPUVZXRCtOL3dk?=
 =?utf-8?B?MzU1NmlXSWg1djJXU21FTE0xRzNVRk52dHBtajlzMVRrNVpLeUFma28rMVBq?=
 =?utf-8?B?UkFBNFA0cE1kQ2YzVkl0R05TTG92dHdoQy9hU1I0eUJYdTlDcC9HaTEyTU84?=
 =?utf-8?B?Y2NqL1FuMlNSMk1DUnFWa29jTm9OdmtWckcyUC8xa1Vmc2U0OVVzYnNyRS9J?=
 =?utf-8?Q?IBAHTHlCyBQwiNtaXVALtC7K2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af08a8d7-1489-4624-79a2-08db6c4a8703
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 20:12:35.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVz23CggzsR4COZSYBIDHm/PX6gKXUDBfuSfQY2Lr988GJuLAM9EUMgXFwoE4eqx/5Tdof1IEBU+sbbGJYS0Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

On next-20230613 release after creation of raid devices while stopping
the same hitting kernel NULL pointer dereference situation on
AMD x86 systems.

Kernel: 6.4.0-rc6-next-20230613
Commit: 1f6ce8392d6ff48

  $ mdadm --create --assume-clean /dev/md/mdsraid --level=0 --raid-devices=1 /dev/loop0 --metadata=1.2 --verbose --force
  $ mdadm --stop /dev/md/mdsraid


Attaching Kernel trace below
   
[   32.260763] PEFILE: Unsigned PE binary
[  117.236671] block device autoloading is deprecated and will be removed.
[  117.262329] md127: detected capacity change from 0 to 25581568
[  180.249007] md127: detected capacity change from 25581568 to 0
[  180.255540] md: md127 stopped.
[  180.268433] BUG: kernel NULL pointer dereference, address: 00000000000000a4
[  180.276210] #PF: supervisor read access in kernel mode
[  180.281947] #PF: error_code(0x0000) - not-present page
[  180.287676] PGD 0 P4D 0
[  180.290508] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  180.295374] CPU: 5 PID: 7674 Comm: mdadm Kdump: loaded Not tainted 6.4.0-rc6-next-20230613 #1
[  180.315092] RIP: 0010:export_rdev+0xb2/0x1f0
[  180.319869] Code: c7 43 40 00 00 00 00 48 8d bb 48 01 00 00 e8 c5 c0 c5 ff 48 8b 83 b8 00 00 00 a8 10 74 0c 48 8b 43 30 8b 78 34 e8 ae fe ff ff <83> bd a4 00 00 00 fe 48 c7 c6 c0 f9 aa 9d 48 8b 7b 30 48 0f 45 f3
[  180.340820] RSP: 0018:ffffb1dadc677da0 EFLAGS: 00010246
[  180.346655] RAX: 0000000000000002 RBX: ffff9ca944130e00 RCX: 0000000080080007
[  180.354622] RDX: 0000000080080008 RSI: fffffc7fc20f2c00 RDI: 0000000000000000
[  180.362588] RBP: 0000000000000000 R08: ffff9d0943cb0000 R09: 0000000080080007
[  180.370553] R10: 0000000040000000 R11: 0000000000000001 R12: 0000000000000000
[  180.378512] R13: 0000000000000000 R14: ffff9d0943cb21d8 R15: ffff9ca94307c400
[  180.386470] FS:  00007f2a63448740(0000) GS:ffff9ca8fef40000(0000) knlGS:0000000000000000
[  180.395502] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  180.401917] CR2: 00000000000000a4 CR3: 0000000102fcc000 CR4: 00000000003506e0
[  180.409875] Call Trace:
[  180.412608]  <TASK>
[  180.414957]  ? __die+0x24/0x70
[  180.418372]  ? page_fault_oops+0x82/0x150
[  180.422852]  ? exc_page_fault+0x69/0x150
[  180.427237]  ? asm_exc_page_fault+0x26/0x30
[  180.431916]  ? export_rdev+0xb2/0x1f0
[  180.436005]  ? md_kick_rdev_from_array+0x118/0x150
[  180.441354]  do_md_stop+0x28e/0x580
[  180.445241]  ? security_capable+0x3a/0x60
[  180.449721]  md_ioctl+0x540/0x940
[  180.453423]  ? selinux_bprm_creds_for_exec+0x291/0x2a0
[  180.459163]  blkdev_ioctl+0x142/0x280
[  180.463255]  __x64_sys_ioctl+0x91/0xd0
[  180.467447]  do_syscall_64+0x3f/0x90
[  180.471440]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  180.477081] RIP: 0033:0x7f2a6323ec6b
[  180.481073] Code: 73 01 c3 48 8b 0d b5 b1 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 85 b1 1b 00 f7 d8 64 89 01 48
[  180.502032] RSP: 002b:00007ffc29d52238 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  180.510484] RAX: ffffffffffffffda RBX: 0000000000000019 RCX: 00007f2a6323ec6b
[  180.518449] RDX: 0000000000000000 RSI: 0000000000000932 RDI: 0000000000000003
[  180.526415] RBP: 0000000000000003 R08: 0000000000000207 R09: 00007ffc29d51eb5
[  180.534373] R10: 000000000000007f R11: 0000000000000246 R12: 0000555c79876280
[  180.542338] R13: 00007ffc29d55379 R14: 00007ffc29d52330 R15: 00007ffc29d523d0
[  180.550305]  </TASK>

Thanks & Regards,
Ayush Jain
