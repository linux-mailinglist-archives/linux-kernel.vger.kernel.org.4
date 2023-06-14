Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4F772F595
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243283AbjFNHK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243269AbjFNHKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:10:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A436F1FC2;
        Wed, 14 Jun 2023 00:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhKNTOCXzrMsofxcJsqTUAU0QVX58xYlAhRmkYks4BFRjI0cc5o8n/Wvx8ily9nm8y7E9QR7Mtvs1xumFgJK1rWCPkjX0SeXjqRVTkEvbuVL4Q7+Sefc6qlKqIA/WJ/CKxsR+mRVevW9cAJk2QaNfdZUAv8k/9OwFA4heXSheWHDXOYGiTRciY1cDxZHgQjSoWMLf2vwwORM5XCcSFiE7/CSR+/A3DcQU4OYo0/sIloRhf14z8O+PPDwS7n4PwTVPfW9etfHUIwJcP22n3aJpzv3T+mSeKqlEHInhzg8SYuXA8fr58OQbV1qkymPSH/hAjsgqaMio7wOO6GPxoWiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1xfFtW1Nzm00UaT9nb3Zu3gOpDoNitvMbGxVcbiq18=;
 b=XIrGD9tNtIRTgeJhbIpvxS8Ka80vrih6KnLTlB1cTeWqjvjl7FACTdyhVXg+M84Qu17oVzxx7mIE6HDZSuSgiXo55uVQKVoDvIVjkIHqw9rK8XMOJIh2u5pBGf5tQWjUkGzfWo1YBT5fWYu3f4CpctAo1PQ2ZB/sbakj9QT+8okMT9P8PZOh3PVkZuL8DDaJA6mAoE0OnlCAfJkMNCTGFS2cMOSkQD1icE7X49Km0l8Fq/gznTl54QV9DmjFYOlaMFljb6vPX6Nn2W+eT21zBjt7+IiIbEvW/lHg5TDUjOTag2/uBBF0g9JTFlFwUOhBDv4uqKbz284OAqRSB0PApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1xfFtW1Nzm00UaT9nb3Zu3gOpDoNitvMbGxVcbiq18=;
 b=WErq+X/q1SHn5i6p5ip+8wEGBws78ZpVfKu2vBhv9op3AYQNdLAW3Z9HePceBgfZLnExzuhwtaFvt96WFnZjgrqZ3gQRcT9+QL/1zks+aC9ceEYBvrYnXeMHQzFabj4GwbsKGtQqLA4s7b8IgYYDMhbZXt+X8RVvDFQx2ep+qO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 07:10:43 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed%4]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 07:10:43 +0000
Message-ID: <3c4911c4-d3d7-a93e-5f14-e97384ae4f21@amd.com>
Date:   Wed, 14 Jun 2023 12:40:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Kernel null pointer dereference on stopping raid device
Content-Language: en-US
From:   Ayush Jain <ayush.jain3@amd.com>
To:     sfr@canb.auug.org.au,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <e78344ad-8d57-91d8-0bfb-724c740c7c72@amd.com>
Cc:     Wyes Karny <wyes.karny@amd.com>, hch@infradead.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
In-Reply-To: <e78344ad-8d57-91d8-0bfb-724c740c7c72@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::10) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 2077f8df-4189-49d3-2445-08db6ca67762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30FdY/FaiTKqhSlfPBJnRh2xcB/px9P+34IhfDPL1sFJs2VQS1tuuHjm/9pLu0ymznBjaT7Ptru47t7osQfK8uw1/iDLkfZkbvzBBmBdnSFjOX7/d3HdMXEYklRqnGpYuRt3noKoE5zWsS2/lfaX+vjTqJ64zPmmCa5HNYlY3NmuGUCAdFMsmtNO+c9ouRQUSos90l5jdhJzAqKop24d9aVsV8JMKR2HJTpKiH6J4fqa+Z57VJyKL2Dhad1V3XCiJ8D9oSmaA35FkXmun9K0HPovBkbYnkJyuK8TzI/BvkjBX9AobvN6daiENLUDZ3fIRNXhjfKppWSU5Hmxg3lV7pM20GuZFQymFsGd8fMTfF7v6ZcovouV8qu5v0Y6ZANfFb9bdPpZYllgHIEoqZyoKbpWlfmuYjB5WE8pmwA2jSgbEbb2B9X1ECg7wXwy47xemyUrBbGaN9TZNO0IZ+x/55y1Y+rw7zl5ek/DJ13IHjxZhzA9V/aEWTF3gzQUzQR4ZrD3ZUYrVZdJGO4YWoGBOKxaG+6SQ53KsjIFcQCVkpMzRapenJ6WxMCacCJOrazW1IcOxEwNfx2O1ZgU/ziEGHKYL6STG8KJOxSyC8FuGXpRNjIH3YgUMcihlgYjmzrcHwWXXFJsQ2eawsaDXQUgIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(86362001)(6486002)(31696002)(6666004)(316002)(8676002)(41300700001)(5660300002)(26005)(83380400001)(6512007)(38100700002)(53546011)(6506007)(8936002)(66556008)(36756003)(66946007)(4326008)(478600001)(186003)(54906003)(31686004)(2906002)(66476007)(2616005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFYrRVk5NWt5L1BWN1lvUjl2b3pueDBWWFlUYXpuK0lMWEQrdjVjZHNubDRq?=
 =?utf-8?B?ME50MWUxdkhHVTFGLzIwVWFvR2FrQWdEZWp3RENwMmZtbDBub2tkNmhtOXli?=
 =?utf-8?B?MGVDWmpsU0Fub3RrVE1ZN3JWYmFHL2c2dkh3TEU0U25hdURzSTJobXdHd2FC?=
 =?utf-8?B?ckl3Q2ZzMUlCZUV5Y0RkWFZCd01qYjUyS1FUZ0RqSUZzbjFHVGp4Z1NXQmRM?=
 =?utf-8?B?Ym5qaUhvY1ljMEM4ejdoMTJnN2JRVitnRTE5cStBQU1jZTZjMXpXWnFSVExK?=
 =?utf-8?B?M1gyK2dPMlBSVzErY255aHB0RmpLUzFwcE1jY1d4TTFsdVFiOEZLcUNibTlp?=
 =?utf-8?B?R254TUZTUUs1Ykh2YnBkZ1RYUjZtbDhWVFJKTDVoS25lWUlMOFlYdG4xZVI1?=
 =?utf-8?B?Q1pydnJJOW9rdVhBOUhENG5ZUEt0c2xpcGRseVEyVzBRRm5VdFRYSFFmK2k1?=
 =?utf-8?B?YXl5VmppVkN2RTVzZjNMTHorSm9qdHhuMEhQQjVVcEYrRWdhQzFmWlBDNnh5?=
 =?utf-8?B?UFdZc0NrNUo5QTZHVkhkNUp2ZjFmWEtZektFQjRxU1pyT0NMYkEvKzBTZG45?=
 =?utf-8?B?NDE4akxiMVloekFIbUd0R3pFcWNaQ2RsM25XcXFEcFhOKzdWRi9rUzM3Mmpa?=
 =?utf-8?B?RDVIZjgrWExzWEdiUUhLL2Y2NDlOMlR2Qnh2WXdtUUpvSWN2NDlob0x1eFNm?=
 =?utf-8?B?Zjd1UTUwS1ZpNVFKQmsrdVo3WUo4NEwrOWNlM3lNM01Tc0tFTEZCWkNVNDla?=
 =?utf-8?B?VGozdFR1UlJmT0R0Q1BPbWdXR1c3UHVLbjRuMUJ0TVJIaGoxbGE3RjY1K1c0?=
 =?utf-8?B?TG5BMnMvNzNqTmUvbmNabzcwMkZGQytTWU0vQjhxOHA1cXBQRU9ZRERMV0ZY?=
 =?utf-8?B?cmtaalpGaHY1ZHB0dXkrWWNuOW9ROGlON0EvNFJVeHRoc0MwUEpkbmxRZVRH?=
 =?utf-8?B?clA5UUlodmhZZUZMYUd1YWZLNVBjTlBHMllHNXRid3lvalFOdlNyb3k0aXJ3?=
 =?utf-8?B?RXBleUFuaFMxM0szK0s1MVRRYnNYK2lvY3ZTckRPZzBUUWNPV0J5L0M2Wno1?=
 =?utf-8?B?N0FkcnNaNnJ2WmNRZHFVcjlaYzkrVm11MDh1UHYwdE9vZ0lZSm1KU3prbUNG?=
 =?utf-8?B?T0xaQnkrOXZ1eGFBdDZlbm9YZlNiQWtJOXJqYnN5S1o1Q0MyRUc1S040cnJx?=
 =?utf-8?B?aDFWem1qVzlPMEZ5eVoxUjVhRTF6MjljMXdoaGI1Y3VTMkpTRmU0OURsUW8v?=
 =?utf-8?B?V29jMmNicHRteXVTZ2VKQWhudVBsSmhUcTJKZWtOeVo3ZVczZFVDSmcydVpW?=
 =?utf-8?B?RitPQUJQVTNRdytNenRLbXFEM1o4M1hFZnM1SEJUUjY2c2QwWlg4NVMrWDBa?=
 =?utf-8?B?NEV6eGo4aFB6M2tpaWJDejc2ZXllL1pUQXVpcm0zK1pYazE2Y3M2bWtsUHJk?=
 =?utf-8?B?UHlKMmphM2MyUnpkeU9PcmdVNFdpR0JPdHc1ckdTNnF0NitGK240aVRCUTlK?=
 =?utf-8?B?RnJORDd2d014WDR2d3pxNlZDSlRFK2ZYZFkwTFJUTnpSUmZ4VXh1Umo5ZkpS?=
 =?utf-8?B?TE85TGozYXN1bDlsaEtVaDFKKzF4K0ZPSlpWdGtQWFhFeDR0eGxSaThnbE8y?=
 =?utf-8?B?MUR6TUt5bTlEZ3NpeEluK2hYZ1BuUVZreHBVZ1UzUlpTcDRGR0lBSE95M3Rx?=
 =?utf-8?B?TUNHdkpaS3I1Tno5K0lTOE42S3lIcHJWNnozT2QvRFNXYUc4bkJHczFGUkJ6?=
 =?utf-8?B?V0tWY1ZCYjZzRzQ3NlN5d0tPWHAreXNYTWNlQ0dJWXdENWcwNzZIUXAxVVV5?=
 =?utf-8?B?OE9tM3Z6V2NlZFhRWlVGMDFQZE9OUHRzTXJqRzkyNDFubU4ybzhrUUl2RUhp?=
 =?utf-8?B?MlFZWGFoUWZTdkJ1L2RaelZRVER0YzA4eDFzai91STNjLzFtOU9IRVVDcmU1?=
 =?utf-8?B?cmtJVDRsTTIvZHkxK2hjN3lJUkJ0SmlOQ1VoeDhFTFk4amVFQjdoNzdiVUQr?=
 =?utf-8?B?MGMzNXBpTjEyUXRHak9IWkYvRGNmcElwOFBkZDYrejhrSzMzbGRva093RWp6?=
 =?utf-8?B?cVAzRGswMjdvOEU5NXhJajhxUFJGZ2l2T0VzNDgrVnFpYitLVTBuNytSaVk3?=
 =?utf-8?Q?NMPYQM79f1U6LvZeXhol38m12?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2077f8df-4189-49d3-2445-08db6ca67762
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 07:10:42.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/v0hbnoH9wVAflqlDzCGEdDI44rS7RvLn88vbBmP3M0eNpjwZsTyhsgGZr+cOL3umm+LgcRFNj5n+jsaAY+KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 6/14/2023 1:42 AM, Jain, Ayush wrote:
> Hello All,
> 
> On next-20230613 release after creation of raid devices while stopping
> the same hitting kernel NULL pointer dereference situation on
> AMD x86 systems.
> 
> Kernel: 6.4.0-rc6-next-20230613
> Commit: 1f6ce8392d6ff48
> 
>   $ mdadm --create --assume-clean /dev/md/mdsraid --level=0 --raid-devices=1 /dev/loop0 --metadata=1.2 --verbose --force
>   $ mdadm --stop /dev/md/mdsraid
> 
> 
> Attaching Kernel trace below
> [   32.260763] PEFILE: Unsigned PE binary
> [  117.236671] block device autoloading is deprecated and will be removed.
> [  117.262329] md127: detected capacity change from 0 to 25581568
> [  180.249007] md127: detected capacity change from 25581568 to 0
> [  180.255540] md: md127 stopped.
> [  180.268433] BUG: kernel NULL pointer dereference, address: 00000000000000a4
> [  180.276210] #PF: supervisor read access in kernel mode
> [  180.281947] #PF: error_code(0x0000) - not-present page
> [  180.287676] PGD 0 P4D 0
> [  180.290508] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  180.295374] CPU: 5 PID: 7674 Comm: mdadm Kdump: loaded Not tainted 6.4.0-rc6-next-20230613 #1
> [  180.315092] RIP: 0010:export_rdev+0xb2/0x1f0
> [  180.319869] Code: c7 43 40 00 00 00 00 48 8d bb 48 01 00 00 e8 c5 c0 c5 ff 48 8b 83 b8 00 00 00 a8 10 74 0c 48 8b 43 30 8b 78 34 e8 ae fe ff ff <83> bd a4 00 00 00 fe 48 c7 c6 c0 f9 aa 9d 48 8b 7b 30 48 0f 45 f3
> [  180.340820] RSP: 0018:ffffb1dadc677da0 EFLAGS: 00010246
> [  180.346655] RAX: 0000000000000002 RBX: ffff9ca944130e00 RCX: 0000000080080007
> [  180.354622] RDX: 0000000080080008 RSI: fffffc7fc20f2c00 RDI: 0000000000000000
> [  180.362588] RBP: 0000000000000000 R08: ffff9d0943cb0000 R09: 0000000080080007
> [  180.370553] R10: 0000000040000000 R11: 0000000000000001 R12: 0000000000000000
> [  180.378512] R13: 0000000000000000 R14: ffff9d0943cb21d8 R15: ffff9ca94307c400
> [  180.386470] FS:  00007f2a63448740(0000) GS:ffff9ca8fef40000(0000) knlGS:0000000000000000
> [  180.395502] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  180.401917] CR2: 00000000000000a4 CR3: 0000000102fcc000 CR4: 00000000003506e0
> [  180.409875] Call Trace:
> [  180.412608]  <TASK>
> [  180.414957]  ? __die+0x24/0x70
> [  180.418372]  ? page_fault_oops+0x82/0x150
> [  180.422852]  ? exc_page_fault+0x69/0x150
> [  180.427237]  ? asm_exc_page_fault+0x26/0x30
> [  180.431916]  ? export_rdev+0xb2/0x1f0
> [  180.436005]  ? md_kick_rdev_from_array+0x118/0x150
> [  180.441354]  do_md_stop+0x28e/0x580
> [  180.445241]  ? security_capable+0x3a/0x60
> [  180.449721]  md_ioctl+0x540/0x940
> [  180.453423]  ? selinux_bprm_creds_for_exec+0x291/0x2a0
> [  180.459163]  blkdev_ioctl+0x142/0x280
> [  180.463255]  __x64_sys_ioctl+0x91/0xd0
> [  180.467447]  do_syscall_64+0x3f/0x90
> [  180.471440]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  180.477081] RIP: 0033:0x7f2a6323ec6b
> [  180.481073] Code: 73 01 c3 48 8b 0d b5 b1 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 85 b1 1b 00 f7 d8 64 89 01 48
> [  180.502032] RSP: 002b:00007ffc29d52238 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  180.510484] RAX: ffffffffffffffda RBX: 0000000000000019 RCX: 00007f2a6323ec6b
> [  180.518449] RDX: 0000000000000000 RSI: 0000000000000932 RDI: 0000000000000003
> [  180.526415] RBP: 0000000000000003 R08: 0000000000000207 R09: 00007ffc29d51eb5
> [  180.534373] R10: 000000000000007f R11: 0000000000000246 R12: 0000555c79876280
> [  180.542338] R13: 00007ffc29d55379 R14: 00007ffc29d52330 R15: 00007ffc29d523d0
> [  180.550305]  </TASK>
> 

After reverting commit: 2736e8eeb0ccdc71d1f4256c9c9a28f58cc43307

Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Jun 8 13:02:43 2023 +0200

block: use the holder as indication for exclusive opens

Able to see problem resolved.

Can you please look over the issue Christoph.

> Thanks & Regards,
> Ayush Jain

Thanks & Regards,
Ayush Jain
