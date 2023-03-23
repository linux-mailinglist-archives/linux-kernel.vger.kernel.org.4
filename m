Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB7B6C61BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCWIcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCWIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:32:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BE42597B;
        Thu, 23 Mar 2023 01:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/WQnQoZojcwLGdTH4u4LZ0Z3kC5YCp9WBWcHBwIhxTpYLe5yQlDA/YcBsK68Z4Qn4NzyEL7+ScSHizVfpsRQN7+s9CEjZZj0E4WRZf0oMg8Tvsg3X7ZXcT8EMiVacEwL0zxGOPToSJE1SmqMEY+ysu/GsX99NnSHtTPvcyKcefDq8+hK3Cy0Mf81jVKv4KOEeiRnhdalcroqhNOjwYW9qLWUbloBJxb7ziPBs4Zse646HNvJawbb0a7WVSjYpObOUSYHKLNGKYJEaGm4Ul73O8X+6mRqd8L7PaD1+lmrYyKk3FDfC7zAyWa+JttQyaYzx0Ggn+0qBuQBmMaJNEDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swU9xXaIVFePWAWjwnU/NxizAJNtN9pGrbjjvLoUkCA=;
 b=aEzmAa0PC2SlnRtv/+uipV3NzrHotd1L1J1x4Ofjtf658+v4z3QMQJjssfuhT33ZMFMTIZAODaPHAVnJ42cj4/xLoUXzsk+sO1Z62OyuYsCnfzSMAS81T/oMyGIBulqIJdAMv66PDotzLv0smhWeyYAJaGRX4QJcaHy+O6NXW+HwNve1G+SFvhRYWPvP3iZ0Q67D/JkaN85XyWTkW2NdKil0Z0CqlUCPH7fFIUW8SIIoACIm7wXSyLi8zEEA5/KeMOLXA1NOTcowrSbQJh7g5c5yJRVZnmY/YHehl1/BwuAN84ybgE9C1g3pP7khLhyGlzv8OvSQCXDp/qcM42Km+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swU9xXaIVFePWAWjwnU/NxizAJNtN9pGrbjjvLoUkCA=;
 b=z5uJ8ZIPIgvhzZ0QyloWTSLgp7hT3WrvhV3XbzDkgKaLENGa6AVPaJtZzREq0F2SV26ztrj5LABQrU66Nh9I8aoYYYef+UlbM0zL9pbB0gucLz72GXy8ANQm6dVw1fTk61a9RR7R9l2JsaUh32ncWDFWz23Oubo5ILOBP8YJ9cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 08:32:00 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::e748:b085:209a:1a71]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::e748:b085:209a:1a71%9]) with mapi id 15.20.6156.028; Thu, 23 Mar 2023
 08:32:00 +0000
Message-ID: <1c496b56-7b82-2f18-ab53-1c5a930a4511@amd.com>
Date:   Thu, 23 Mar 2023 14:01:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: next-20230323: arm64: vma_merge (mm/mmap.c:952 (discriminator 1))
 - Unable to handle kernel paging request at virtual address 0000000000100111
 -
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lstoakes@gmail.com,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <liam.howlett@oracle.com>, willy@infradead.org,
        vernon2gm@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYvBxp38KEggtvtvVtGMaSBdL3NDV9ns=Zi9-Jtx7H9g1A@mail.gmail.com>
 <f8628535-05a4-4d42-217f-88d68749010f@suse.cz>
 <56499ad1-3d82-457e-9886-12b4665c4f9f@spud>
From:   "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <56499ad1-3d82-457e-9886-12b4665c4f9f@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::23) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 79070830-953e-4427-4738-08db2b791206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCM8PvF9M/h3KU3UA5VbbnFuzqYhgqffOpciHj6LrtOMJR+pM/Z6ePkUipAHAPXC/ywuJn+9pnZFZYtMns0GrTKTlQBsDJ+0eGeOKTXZ+DyiuvCNMUeslk9WHbkhfmuoxaFGPI4zyX5ldxCfmk+kKDzShtZQzkn2k2+v9rV69SZwPxcui9CVD3SVX5M9ev9iB6qTx1KCZE0bqSgS1E5RiWgl3LTcv/2hd6/5Z6Rpodc9QlkASC4jnVoowRiLv2V7bC6SDqcJ5rorh8/h0Mu5HuGclQ8+uIxmXDVipoUlzPWJIeSx+jH2aMeHCWQQbqgc+++CInXIseksrl7ltjz+roU2I67jRfL9s11kxe3YbJZ5HYv5WWUPIb84yj496+hkyyIt0FehqIfP+pzZAtCAH723ouR/bpPD7TnskHIOgiTAlJXxckUnxp2ynGEw+Nk3TlhIizf3T831r27KjWrD/Lq9LjPx1PTURyvbKv6z1x8c7m+oe2TKfyBPyqm4qoSzybuEZEkLX9+KCVQT+6Um+xJHcfIrit1/viMZ0hTmLIKlLY2rhlHR05Jb9y6tVtttjEkAjKKl6U718FATXc6QcF9yT/wvpnTsrCo1lE2JWHMABL6t3BCmRHETtzb9S82bbMgBQQGhBwI3VmVk/DIRwnyzXgqyCooChmcFNdPRjRMyjnI6Fvhsl/A1hAoG4tZicNClHIgjWDYyU8FY2IN1Zvsi8dK2vf0mov20WAi0YebKziEs3ljJRTl3nPou0tStdVBzvUo11YlM89PL/Mj2WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199018)(31696002)(36756003)(38100700002)(41300700001)(2906002)(8676002)(66476007)(4326008)(7416002)(5660300002)(8936002)(83380400001)(2616005)(53546011)(186003)(66946007)(6512007)(478600001)(110136005)(54906003)(316002)(6506007)(45080400002)(66556008)(6666004)(966005)(6486002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlNnWFhqMEFmUFlzUkNKd2cvNUE1MG9CcW1Ua0FzaVJhemRGZGFyQzZFT0Zs?=
 =?utf-8?B?cjFnUTJPRnFJcUVoSnpIVWNWcVhSMW1MVjZjMFE0bmdkUytrN1ZMekVOVmFD?=
 =?utf-8?B?RlVFTmV6M3M5aWJlbkkybzFYQTJObElVSEltRWJKWnNXbm14eWJqc0g4VXpL?=
 =?utf-8?B?RWgzTjBSRmZBUDlYQnJRRUJUL2FCTzhHMk00cXRCSkJBRkZ4MWI1TEpSYWV1?=
 =?utf-8?B?eW0wb0JXNXZHZmZFTEhwWTRzcldDek5aMTNKQ1NrY05hdnRpenl5Y0hXRC82?=
 =?utf-8?B?NStxSEFPNXlwbU5aUjUxNjZNM0RGTzlsMFFVU3JEUHlGci9zZGJVdHg3SkpX?=
 =?utf-8?B?SUFvMzA0OHErN0w0b0x2bmlyZldXM2FNM2lDWDMydEJ2cVhCeUxYZlRnQy9Q?=
 =?utf-8?B?QW43aTJ5VEdVNWtEeUZ2WTF1SXBsYWM3eUZLN1k0MHhQRHFNT0FKUmd6QW9G?=
 =?utf-8?B?MGdvV2ZlWE5NQnZjb2ZENE9yci9QZFdJczRQUHdkZFYvU0JZckFPTTQ0ZERU?=
 =?utf-8?B?YlFLaFJpSkcvNlBoVGp3a055eU1ZeHM4TlFFY0lSUU5mVnpPUnpJMHE4MmE4?=
 =?utf-8?B?OUpxbm5WYTdTOHFrS0M4YUsxalExc3V4VC9BcDIzWEptODVESFNRc0pEQVpX?=
 =?utf-8?B?YzlYWnRrdERjNEw2eWxQVnRkWHAyOXorajlhNFNZRlFrU0pnRFdDSVVoRXRZ?=
 =?utf-8?B?MmJoYVdlWGZFU0tRRUlHOXViRXhjRG4rck1qZ2YxRGJCM1hLUmhwSDhVejk4?=
 =?utf-8?B?VzdNLzgwRzVnOGVvRjhHL1djZ1JHWUYvdmNqd2d0WTcrK2F6aG9Vdi9DMWFT?=
 =?utf-8?B?Q1FDbTRLbEZHQzU4Y0gxbktndWRIK21MSjF0K2xTeUl5R2pnUTBRZk92SFNr?=
 =?utf-8?B?SWQvQUhDc0NaMmlWanRYNWZyN1RDNmNtLzNHUGF6dGV5alNXQVRnemhyQ2Zk?=
 =?utf-8?B?V3NBbkx5L1FEeFlGandSTlVYalI3eUM2ZzhodGxwZXdpR240ak96QW9mT1BX?=
 =?utf-8?B?V3dDTEU3N20yT0lEOFQ1RGMrYmNiWkx4ejRZKzdPSzkxTnFYc2dGZGxKOTM0?=
 =?utf-8?B?WTlBb0pWTmpDcVI4U292TFRWblBHeEU2WTAxeHNncG1IYmFQZ2lUeXVlSGhF?=
 =?utf-8?B?ckFQUklYSVF3NFpNbzZPZytITVRONm1iV1pTVHgyaWlxaFVPSzBFT3lJZHl1?=
 =?utf-8?B?WDFkKzZqY0o3NVZjQUROUFM0cUkyZjkzMm0yWkRxc3VJVnk5UXgwTFZmN2tj?=
 =?utf-8?B?NEMzVVVOOEpENGM4dkJFMzNEUmxXemwzOXdSQWk3cW9CbUJSTUVTTEtrRlNs?=
 =?utf-8?B?eTUvM29qeCtZcWRFelpIRFk2Nzl6d2tFc3dwKzN5QzkwWDVuWVIxc2MxVWZR?=
 =?utf-8?B?UUhRWHRMU3NhaktJVnRoS2cxaHlHT1FnbENUTmtnSk5DdVcwNVAweDRpRmhs?=
 =?utf-8?B?NTBXRnN6amhEaE1IWU9tU2ZMTFhXVzgrMUdhVTZuOG4zUGhoOWR1TVZteVRn?=
 =?utf-8?B?dDYxT29TRHN6anQ3NDFTeFBHV0w1ZkdXOFFmTUptcTQ5UlJOZElRMHJ0VTcr?=
 =?utf-8?B?NzNvaVd6U3ovamxUbkFTWFY3bnAxenJKaUZEK0MzeHgrRlMrZDZabGVyZ1Rw?=
 =?utf-8?B?RjJkN25pcllOdEtVK3FTelFsUzA0OVZ6Wk96WkRkUUJ2eGdTbGtBcXgxUUdI?=
 =?utf-8?B?SjQrR3g2b1hUdndyeStTZGE4Mk9KRDZSTW5pSGhUUE8xV2tzcXQ0NVF4WHEz?=
 =?utf-8?B?bWZ2dndZRVlvZkp4ekg3YW9sRHJYK1hkUW45ejNobDdqcXB3QnFCTGZ2SC9P?=
 =?utf-8?B?MkQxbk9QaGdORGJhM0ZYWXAyZTJWRGRsdWZ0TWhrMmJSVWJRaGZnRVR2RzNP?=
 =?utf-8?B?cGFkUGdFWjhYeEFxVktocmsrejJ5dGVmSzlYVVMxK3VaZlJrODF5dVd3MVA4?=
 =?utf-8?B?RndFajJ6aGtHWmNHL0Q3TXIydmd3cHdFV0pvQ0U2dzVRdzVTU1ZHWDlTWVhq?=
 =?utf-8?B?OXZYbUt1TXRLWHhRRnErUjlYMWhsWXNVVGY4amg0ZTEvQm1pcE5UYklTaVU0?=
 =?utf-8?B?SkUrUEJtd1RmY1AzV2h4Z1RtR0Vvd2lXMWtPbi90UWltNFdiR3d2Y3BiVjFE?=
 =?utf-8?Q?Gs1bIegthfb/5ZfZzBSvSz/6m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79070830-953e-4427-4738-08db2b791206
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 08:32:00.1195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sM/k7by66AUy2V4CkmvAtURX8vfw0t8I/wf/PhJ14vAo2SgbRNRzevV5XFdmkwLJJkTHNgojsFOaGmV4VQtSUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/2023 1:43 PM, Conor Dooley wrote:
> On Thu, Mar 23, 2023 at 08:51:25AM +0100, Vlastimil Babka wrote:
>> On 3/23/23 08:35, Naresh Kamboju wrote:
>>> The following kernel crash was noticed on arm x15, arm64 hikey-6220, Juno-r2,
>>> x86_64 and i386 devices on Linux next-20230323.
> 
> To add one more to the sample size, it's falling over on RISC-V too!
> 
Its failing on AMD arch, with below trace:

  2.510619] BUG: unable to handle page fault for address: 0000000008100111^M
[    2.513951] #PF: supervisor read access in kernel mode^M
[    2.521156] usb 3-1.1: New USB device found, idVendor=1604, 
idProduct=10c0, bcdDevice= 0.00^M
[    2.513951] #PF: error_code(0x0000) - not-present page^M
[    2.530981] usb 3-1.1: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0^M
[    2.513951] PGD 0 P4D 0 ^M
[    2.513951] Oops: 0000 [#1] PREEMPT SMP NOPTI^M
[    2.513951] CPU: 95 PID: 868 Comm: modprobe Not tainted 
6.3.0-rc3-next-20230323-next-20230323-814642c #1^M
[    2.513951] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 
2.8.5 08/18/2022^M
[    2.513951] RIP: 0010:vma_merge+0xe4/0xc50^M
[    2.513951] Code: 0f 84 59 08 00 00 48 8b 45 88 49 39 47 08 0f 84 27 
02 00 00 4d 85 f6 74 0a 4d 39 6e 08 0f 84 a7 01 00 00 31 c9 48 85 db 74 
79 <48> 8b b3 a0 00 00 00 4c 39 e6 0f 84 98 00 00 00 4c 89 e7 88 8d 4f^M
[    2.577270] hub 3-1.1:1.0: USB hub found^M
[    2.513951] RSP: 0018:ffffb5e98ec47c88 EFLAGS: 00010206^M
[    2.513951] RAX: 0000000000000000 RBX: 0000000008100071 RCX: 
0000000000000000^M
[    2.513951] RDX: ffff9857508c2c30 RSI: 0000000000100001 RDI: 
ffff985754569870^M
[    2.513951] RBP: ffffb5e98ec47d40 R08: 00000000000001bb R09: 
0000000000000000^M
[    2.513951] R10: 0000000000000000 R11: ffff98575452ef0c R12: 
0000000000000000^M
[    2.513951] R13: 00007f8be41f4000 R14: ffff985754569870 R15: 
ffff985754568958^M
[    2.594281] hub 3-1.1:1.0: 4 ports detected^M
[    2.513951] FS:  00007f8be4f64740(0000) GS:ffff987640dc0000(0000) 
knlGS:0000000000000000^M
[    2.513951] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
[    2.513951] CR2: 0000000008100111 CR3: 0008000114566002 CR4: 
0000000000770ee0^M
[    2.513951] PKRU: 55555554^M
[    2.620194] Call Trace:^M
[    2.620194]  <TASK>^M
[    2.620194]  mprotect_fixup+0x13e/0x320^M
[    2.620194]  do_mprotect_pkey+0x43c/0x4d0^M
[    2.620194]  ? do_user_addr_fault+0x34f/0x8e0^M
[    2.620194]  ? exit_to_user_mode_prepare+0x32/0x190^M
[    2.620194]  __x64_sys_mprotect+0x23/0x30^M
[    2.688176] usb 3-1.4: new high-speed USB device number 4 using 
xhci_hcd^M
[    2.620194]  do_syscall_64+0x3e/0x90^M
[    2.620194]  entry_SYSCALL_64_after_hwframe+0x72/0xdc^M
[    2.620194] RIP: 0033:0x7f8be4d40ebb^M
[    2.620194] Code: 73 01 c3 48 8d 0d 2d e3 22 00 f7 d8 89 01 48 83 c8 
ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa b8 0a 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d fd e2 22 00 f7 d8 89 01 48 83^M
[    2.620194] RSP: 002b:00007fff1da6b298 EFLAGS: 00000206 ORIG_RAX: 
000000000000000a^M
[    2.620194] RAX: ffffffffffffffda RBX: 00007f8be4f6a3d0 RCX: 
00007f8be4d40ebb^M
[    2.620194] RDX: 0000000000000001 RSI: 0000000000004000 RDI: 
00007f8be41f4000^M
[    2.620194] RBP: 00007fff1da6b3c0 R08: 0000000000000000 R09: 
00007f8be3e39000^M
[    2.620194] R10: 00007f8be4f6a3d0 R11: 0000000000000206 R12: 
0000000000000000^M
[    2.620194] R13: 00007f8be41f8018 R14: 00007f8be4f6a3d0 R15: 
00007f8be4f6a3d0^M
[    2.620194]  </TASK>^M
[    2.620194] Modules linked in:^M
[    2.620194] CR2: 0000000008100111^M
[    2.620194] ---[ end trace 0000000000000000 ]---^M
[    2.620194] pstore: backend (erst) writing error (-28)^M
[    2.854021] usb 3-1.4: New USB device found, idVendor=1604, 
idProduct=10c0, bcdDevice= 0.00^M
[    2.620194] RIP: 0010:vma_merge+0xe4/0xc50^M

>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> crash log on arm64:
>>> ---------------
>>> [   19.281223] Unable to handle kernel paging request at virtual
>>> address 0000000000100111
>>> [   19.289189] Mem abort info:
>>> [   19.291995]   ESR = 0x0000000096000006
>>> [   19.295757]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [   19.301086]   SET = 0, FnV = 0
>>> [   19.304151]   EA = 0, S1PTW = 0
>>> [   19.307302]   FSC = 0x06: level 2 translation fault
>>> [   19.312194] Data abort info:
>>> [   19.315083]   ISV = 0, ISS = 0x00000006
>>> [   19.318930]   CM = 0, WnR = 0
>>> [   19.321901] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008a23c5000
>>> [   19.328374] [0000000000100111] pgd=08000008a14c5003,
>>> p4d=08000008a14c5003, pud=08000008a14c6003, pmd=0000000000000000
>>> [   19.339037] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
>>> [   19.345315] Modules linked in:
>>> [   19.348373] CPU: 2 PID: 1 Comm: init Not tainted 6.3.0-rc3-next-20230323 #1
>>
>> next-20230323 seems to contain v2 of Lorenzo's vma_merge cleanups
>>
>>> [   19.355347] Hardware name: ARM Juno development board (r2) (DT)
>>> [   19.361273] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [   19.368246] pc : vma_merge (mm/mmap.c:952 (discriminator 1))
>>
>> And this is a line involving 'next' and Liam pointed out a possibly
>> unitialized next in v2, so that's probably it.
>> Andrew replaced it with a fixed version so it should make its way to -next
>> as well.
> 
> Cool, hopefully it is fixed tomorrow :)
Thanks will keep an eye on it.
Srikanth Aithal
> 
> Cheers,
> Conor.
> 
>>> [   19.371917] lr : vma_merge (mm/mmap.c:945)
>>> [   19.375670] sp : ffff80000b37bb40
>>> [   19.378985] x29: ffff80000b37bb40 x28: ffff000820c0ff20 x27: 0000000000000000
>>> [   19.386139] x26: ffff000820c17210 x25: ffff000800bfac00 x24: 0000ffff8e8b7000
>>> [   19.393293] x23: 0000000000100071 x22: ffff000800898d80 x21: 0000000000100071
>>> [   19.400446] x20: ffff80000b37bd18 x19: 0000ffff8e8ba000 x18: ffff80000b37bd18
>>> [   19.407599] x17: 0000000000000000 x16: ffff8000099a58c8 x15: 0000ffff8e9aefff
>>> [   19.414752] x14: 0000ffff8e8b7000 x13: 1fffe001041bb361 x12: ffff80000b37baf8
>>> [   19.421905] x11: ffff000822473400 x10: ffff000820dd9b08 x9 : ffff80000830fc64
>>> [   19.429057] x8 : 0000ffff8e8b7000 x7 : 0000ffff8e8b7000 x6 : ffff000820dd9b50
>>> [   19.436210] x5 : ffff000820c0ff20 x4 : 0000000000000187 x3 : ffff000800bfac00
>>> [   19.443363] x2 : 0000000000000000 x1 : 0000000000100071 x0 : 0000000000000000
>>> [   19.450515] Call trace:
>>> [   19.452960] vma_merge (mm/mmap.c:952 (discriminator 1))
>>> [   19.456279] mprotect_fixup (mm/mprotect.c:676)
>>> [   19.460034] do_mprotect_pkey.constprop.0 (mm/mprotect.c:862)
>>> [   19.465094] __arm64_sys_mprotect (mm/mprotect.c:880)
>>> [   19.469283] invoke_syscall (arch/arm64/include/asm/current.h:19
>>> arch/arm64/kernel/syscall.c:57)
>>> [   19.473041] el0_svc_common (arch/arm64/include/asm/daifflags.h:28
>>> arch/arm64/kernel/syscall.c:150)
>>> [   19.476796] do_el0_svc (arch/arm64/kernel/syscall.c:194)
>>> [   19.480117] el0_svc (arch/arm64/include/asm/daifflags.h:28
>>> arch/arm64/kernel/entry-common.c:133
>>> arch/arm64/kernel/entry-common.c:142
>>> arch/arm64/kernel/entry-common.c:638)
>>> [   19.483177] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
>>> [   19.487454] el0t_64_sync (arch/arm64/kernel/entry.S:591)
>>> [ 19.491123] Code: eb18001f 54000800 52800002 b40004d7 (f94052e1)
>>> All code
>>> ========
>>>     0:* 1f                    (bad)  <-- trapping instruction
>>>     1: 00 18                add    %bl,(%rax)
>>>     3: eb 00                jmp    0x5
>>>     5: 08 00                or     %al,(%rax)
>>>     7: 54                    push   %rsp
>>>     8: 02 00                add    (%rax),%al
>>>     a: 80 52 d7 04          adcb   $0x4,-0x29(%rdx)
>>>     e: 00                    .byte 0x0
>>>     f: b4 e1                mov    $0xe1,%ah
>>>    11: 52                    push   %rdx
>>>    12: 40 f9                rex stc
>>>
>>> Code starting with the faulting instruction
>>> ===========================================
>>>     0: e1 52                loope  0x54
>>>     2: 40 f9                rex stc
>>
>> Looks like an x86 decodecode of arm64 code :) calling a wrong objdump or
>> something?
>>
>>> [   19.497226] ---[ end trace 0000000000000000 ]---
>>> [   19.501883] Kernel panic - not syncing: Attempted to kill init!
>>> exitcode=0x0000000b
>>> [   19.509551] SMP: stopping secondary CPUs
>>> [   19.513665] Kernel Offset: disabled
>>> [   19.517152] CPU features: 0x400002,0c3c0400,0000421b
>>> [   19.522123] Memory Limit: none
>>> [   19.525181] ---[ end Kernel panic - not syncing: Attempted to kill
>>> init! exitcode=0x0000000b ]---
>>>
>>>
>>> metadata:
>>>    git_ref: master
>>>    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>>>    git_sha: 7c4a254d78f89546d0e74a40617ef24c6151c8d1
>>>    git_describe: next-20230323
>>>    kernel_version: 6.3.0-rc3
>>>    kernel-config:
>>> https://storage.tuxsuite.com/public/linaro/lkft/builds/2NOjwfRUa0fjWWZBWCUG4Ypift7/config
>>>    build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/815177945
>>>    artifact-location:
>>> https://storage.tuxsuite.com/public/linaro/lkft/builds/2NOjwfRUa0fjWWZBWCUG4Ypift7
>>>    toolchain: gcc-11
>>>
>>>
>>> --
>>> Linaro LKFT
>>> https://lkft.linaro.org
>>>
>>
>>

