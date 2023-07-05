Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533CB747E37
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjGEH10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGEH1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:27:24 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB33197
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QahCcWGrnrUUptWTCVLK6L5YXYgir3DRWw/m3EHgLjhwH3TG0/wJA9dwpD0vAAyWOGQNcPpJpfPsCuw9JGozJpn56iE+6JSy8A5uTuia0edYvZ/vLtNvsqCtpcgJMPigVIU7LsED5Rl786ONr910EYaXWoy85UAyjEXVZ/+fuBwJLLyGRDx8XUtNv8daZTD8QEjDCE2I05NiQdCMDVmOyepxSOpQflzPJpO+7RtQptS0UKIKaYehUd9gQA/DbYSi8Xie1QpB55unhvmcbUQKknhMbSKku4EyGdL2dxkzjUbIbxwuJpVqAj4I6a6qLnL3dj9Hhkvz2AUMj+OR3Rrc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBqdFF937jakjo2DTEOfibFD45v53J6ACIVZ9L9cTjA=;
 b=nxBwMPUjQXY2gI8Fp6/Is9R4CP5hif9sBtc7lz7B27br04/RB3inGhDJzE4FCSuvMNoxbeVcdgU5l1VQDNdVCzX/CNLHdS+5/9N9DyO6iaJL3/e+EsBZjNfUpGnrZqBqULi+5XJyoIG7PDJxHFEszjS0xhZz4d6yc/51Eeq1UUXTNPVvAG1uDcvBpBUVhZF55wDAi8Ff+44SQWZoAN+MUSQzwXk8hjq1I7zO3ZfGbWk2bYTNBB161cdI9xEPHUR8c+qkdTNe2B+uppHdZVBJINsElBvsD7dYXLPG2mj21CXz2y+oQPYsUwlRt4/8jFCbPaINBV457Kb8aTlYF/nrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBqdFF937jakjo2DTEOfibFD45v53J6ACIVZ9L9cTjA=;
 b=bauKotKdirzYiIra2hMLwZLPM/BmwLuPktjY7fCud2Fclo9NThmn9fHkQM4FMsFAvEfAFnBrYNaOb5a7HuS2LwW7+T2BbyS+5I0t37beTj+kIQw3jkpEh7U7MOtZ7yzSOISG9S2TqseAaIUC4f8aEloI7PY3Dy4aMDzJcO23IEvl62mKx+WhesOnmnGg8IOIbLIfJx109rmNMaF4QevM6pCJXoo4+X8Moj8zZJornoIOMnsJjelny/Gpj0md6mqw5XgDm3pEXsR8JcHYlS8Hgez1g8g1SxyTCInaLOGbqhZ0dMK7HIo8s+wOGEJILAhO5TlAdH92CzevKf/BwPx4xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 07:27:20 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::e01a:d41e:80b4:7cef]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::e01a:d41e:80b4:7cef%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:27:20 +0000
Message-ID: <b57f35f9-53ae-5a99-d8b7-f1915c1cd1d0@nvidia.com>
Date:   Wed, 5 Jul 2023 00:27:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [linus:master] [gup] a425ac5365:
 WARNING:at_mm/gup.c:#__get_user_pages
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <202307041023.bcdbbfc0-oliver.sang@intel.com>
 <CAHk-=wi3Nb4t-JH6BGE5TOynik=-0kXyBGi3bLKTA85rvqHngQ@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAHk-=wi3Nb4t-JH6BGE5TOynik=-0kXyBGi3bLKTA85rvqHngQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: a463c0a5-3cdc-494e-242a-08db7d294472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9iHMPXAmZVc/w5TjvHKSBIXq8IImm+Dd5Q+PwcVjSZ3xqHszSEbLkUKmY9YZPHGClR1d1XVFgv4Ae64hPGxY5QUU/qrGOSC8b7Yo57gEWccmxyMfN699vpQkdFSJ0wrF9VCqBjaRqg8fxJw3Hj3NzLWxemxwg9hLYoy1IMek1b+Dw3yNkedSobv7LtAoeE/B9Bm2uc+cpmcB96rCwJSVgla4VlguWNLGK9DsXJGsZuAAvmQhoud6QRYtjWF703wOeUslifhwNnupvKQLPI5MG34aojRDyMNT6ZqtBy7vMT88vqofWRE1EQEzrUU/gASJVxd2PJtm4/ka+hDnq8+CYFZSwOJZHRtLOqLUo+ztbnZXWfMluKH3oTnkcTBUIByPKpoh8rjteMv8Zf9ydBmIFEpidMH9Ebe7+lA7lehk5bRFlt2g8XvYA2RE3mgU3xab8h2Ls0I5FRVbd7oSfCxaleWVWrrC+ch36CM2j8AavEdoOjQ28CxPfUfwNtCqj/mKlu7zT9xMx9jvH6la5pxoyinGxuHTbgyl2UO4pRJP9xHOgKIf9sMLAzw4No6cc5HMmkcpZBqzg/eSKmHlHLLL20qdBfqQJ3iLkjIckS5VwyUXRgYMOL7R7MGXqZyUxb/CVxwwsYUOkUxAnS0+7tw9QivCXgDgb2KI8ZcL/UwRCZeGrldZbYSXJ/cNVb1yKLuZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199021)(38100700002)(66476007)(66556008)(4326008)(66946007)(2616005)(186003)(86362001)(31696002)(6486002)(6512007)(36756003)(966005)(6506007)(26005)(53546011)(110136005)(478600001)(8936002)(8676002)(5660300002)(31686004)(2906002)(41300700001)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU42dmYvclJpS2pzRjFsTldvcXN0bi9XdUtNQkFNTDdkNHd5VGR5MHdHTGli?=
 =?utf-8?B?eUdKeVRMYXpFZE5hMUZKT0RWNXpwdi9SdWFQZ0pTbWgvZ1hUemlUbUVzRjYz?=
 =?utf-8?B?UW94dmI3YTFMMVlDb3VkMXpaSDJpQTZBWkUyYUZVd2QvMEY4VVhRZCs3Q3J6?=
 =?utf-8?B?TW42eXNVM2dmUktraTVReEVhbGNDdUpPbCsrYnVtU0gxaUJuODdYWHlKRjVi?=
 =?utf-8?B?NzIzL0QvSmdEakQ3S0VEd1YxcVNja3U0NWRvc0M3NlVhMXFRNEhPVFI1SlZQ?=
 =?utf-8?B?K0dVaE8xdHpqSFNKN3QwbjA0WHBQV0lnV09xQlBJOEZ2d2hVbkRqZ1BvZFd2?=
 =?utf-8?B?OHRSWjNSdW8rNWtUSkhwNU5rUktnMWVDaU9Ea0dVS2x1UHFhK0kwbmhadjcr?=
 =?utf-8?B?MUttbXlYek5vQUVCeGJqYkJjeWFnMU82NTBjTTRnQ2NYYTRaaVdOOHdwOGMw?=
 =?utf-8?B?VkM5TnMrRHlFcXZpOVBhRnYyZXBSNjJXbFM2b1RxK1RiWUFuMU1nU004UDFI?=
 =?utf-8?B?R3dTak11YWZlQXpGb1pDRXZJRUdFc0hKN2taNHhQWlI4VWlXRFcrNk5YYXhZ?=
 =?utf-8?B?eTZHbm4vb011aGN5WWdqbnhjcnR1SHRBYU9PK1JEZkllVWxsYituY1BqVXNW?=
 =?utf-8?B?a1cvMjVlY1BRb0xWVjZ4OW45WHFoSktqYUE4Rms5TFFPSC8wU1VaQzlsZGdi?=
 =?utf-8?B?QlZMaHNEeW52UGdTTmdhWEtURERpYXhGVHRPazFYNHFPb2tVT2NPQ2NZMmVS?=
 =?utf-8?B?VVVQVDBGTjlUWXRYTmdubmRMMkNUS1NyQUdUN0JMRnZXVWIxU29uTzI2WmVY?=
 =?utf-8?B?dk04Snh5L0xETFFpcGtTQWl5eFlsR25KZzczRWIvMWppWUwxSjlid29HNTF0?=
 =?utf-8?B?K2xTR2hGeDhkZUx2SWRhbllBakFtWWU1V29FcThhSzF1ZndGWCtQaUxiM0xs?=
 =?utf-8?B?b08rdVdCYW9WdFhQaWEvZmRJcUd2SUs1QjNQZ1dPckdzVTZRQWFsRkZ5c1kr?=
 =?utf-8?B?bGt0enR3RUx0YTJBN0JpcXNRUXNwVHppNGZQcTM3RzMxTHlCeE1KbTUwSjRv?=
 =?utf-8?B?UUhTc0crSDdmY003YkdDeFY0c3NJNy84RjVuTTg0cmZMS3EwZXRTK0NYcnRU?=
 =?utf-8?B?c0hKaUdNN0dVT0YwMWhUOG56dmQ4MVpCSmliMWZzNzBEWkRnMnBna3ZEU0M3?=
 =?utf-8?B?c0poWHBlTW5GTWdDV2gxYU1aZWwycHB5UXBMblh5dS9XY01jN01sa2pXVVVl?=
 =?utf-8?B?T3pFRGRKd0NHd0JQMWtDK3IzWDFQRE9Lb1BmMVc0TzBvbk9Qa3RGaGtQNGp2?=
 =?utf-8?B?dDlmQnJZVWZkeG5zWGhuQWQ2KzBQbzZCR2FUOXlnMFBpejdKelg3WnpQQWhG?=
 =?utf-8?B?QVhoVDBpckEzaEtTeDZOME45OS9tbVZ3OEkzekJvWmZpSVBlVDRKdlFFZnJW?=
 =?utf-8?B?Z1NnR1hCalhmRHpXWUxLcW1qZlZGTnk2akxEZTdCVDdZZ1FaSy9aNVhBUnp5?=
 =?utf-8?B?RUdKakFzQUNxODl1QUFVMzhrUWk4aGJ2Q3lNUzZhL0tjRTY0TElHc3lmL2x4?=
 =?utf-8?B?a3Zjc1R3Njhmd3NINjVpdDlhWm00OXVOQlVMQVJMUXlhcXpUK3UySWNjUXEw?=
 =?utf-8?B?ZGpGSTRoNUIyb3ZuSGFmc29HNWJuaDJSdGNTcllyVCt3a1ZmYmVJN1dnVXNi?=
 =?utf-8?B?VURsRmF6a2NhTlhyN0FZcGdvaEdMQmpNekFicEh1R29wTGpPOEtjdVJha3pJ?=
 =?utf-8?B?eExRaEM5ZlgrZmw4NU5DbjVsUEhFMkpzWlUxems0ckV4Qm00YWtyaFFUUS9Q?=
 =?utf-8?B?cmR4OER6c2EvUFRxdDBFQXIwMWsyUnYrL3FlWXNjT2pIK1BLQ3JmYnZaY0NC?=
 =?utf-8?B?elh0UUtwUWlLNkhzczhxNUlDMmF1eTdVcHNWRmVibkF2MmdEbHJpWEVUWmdB?=
 =?utf-8?B?QnloZFBhYXRDKy9mMnZFaXlrWmY5UENYeStUZUluY0VBWmVmbFdVNU5TMkZJ?=
 =?utf-8?B?encvTG9CeHEyQzhYRlh0Y2NlNlVIMXNUSGxMcTl3WXhhbkMyS3pWM0p3T1VI?=
 =?utf-8?B?bzlBaGlLb0JCZE15Ukp1MXFhK21JZlpuMCt2TGNSN3pqcldJV2xHUUZCM2dK?=
 =?utf-8?Q?igKeNS8Ff+tMqePFpjLlKxeNO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a463c0a5-3cdc-494e-242a-08db7d294472
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:27:20.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H56/EeY4ZoVAYvvXnbnW5KhqZyTn7woQG33DRydh8+WnNGztzz4jwzV5vvj50fkhmw0wvxO4qbWnLSdCB4cJtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/23 07:12, Linus Torvalds wrote:
...
> And I *do* want the backtrace from the warning (in this case, it shows
> that it's the "process_vm_readv/writev()" path, which actually might
> be worth adding stack expansion to, the same way __access_remote_vm()
> does).
 
This is good timing, because I was looking for an email to reply to, to
report that I've isolated a somewhat more valid user space behavior that
is triggering this, via __access_remote_vm().

It happens on my main workstation when there is a problem with any app
that uses Chromium's crashpad [1] to report problems. crashpad is a
rather sophisticated app that does extensive forensics, including a
bunch of pread64() system calls of /proc/pid/mem. Fortunately, the unit
test suite included with [1] also reproduces the problem very reliably.

So it boils down to this: crashpad is reading from a valid starting
address, inside the vma for the ld-linux-x86-64.so.2 file, but it reads
a full 4KB page's worth, which takes it past the end of that vma. 

And although the expand_stack() logic is there as part of the
__access_remote_vm() path, that logic ignores the size of the read! So
it slips past without trying to expand the stack. 

Note that while next vma is indeed the stack, it is 919 GB away--a very
large gap.

The crashpad app is arguably a little bit buggy. It is reading a bit
more than it should, and landing in between vmas for the tail end of the
read. However, the app seems to handle it OK.

/proc/pid/maps:
7f19d671a000-7f19d671c000 /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7fffc2c28000-7fffc2c4a000 [stack] (919 GB above previous vma)

"start" address in __get_user_pages(): 0x7f19d671c000

dump_vma() if the WARN_ON_ONCE() fires:
vma ffff8881143e0e60 start 00007fffc2c28000 end 00007fffc2c4a000 mm ffff888106adbd40
prot 8000000000000025 anon_vma ffff88810b0735f0 vm_ops 0000000000000000
pgoff 7ffffffdd file 0000000000000000 private_data 0000000000000000
flags: 0x100173(read|write|mayread|maywrite|mayexec|growsdown|account)

Analysis of the ranges, which overlap:
0x7f19d671a000 start of /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
0x7f19d671b8a0 pread64 start (read size: 4096)
0x7f19d671c000 end of   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
0x7f19d671c8a0 pread64 end

WARNING: CPU: 11 PID: 8490 at mm/gup.c:1180 __get_user_pages+0x53e/0x670
...
Call Trace:
 <TASK>
 ? __warn+0xc5/0x1f0
 ? __get_user_pages+0x53e/0x670
 ? report_bug+0xcd/0x160
 ? handle_bug+0x3d/0x80
 ? exc_invalid_op+0x16/0x50
 ? asm_exc_invalid_op+0x16/0x20
 ? __get_user_pages+0x53e/0x670
 get_user_pages_remote+0x17f/0x490
 __access_remote_vm+0x106/0x2c0
 mem_rw+0x134/0x1e0
 vfs_read+0xdf/0x2d0
 ? __pfx_rcu_lock_release+0x10/0x10
 ? __fget_files+0x128/0x140
 __x64_sys_pread64+0x6b/0xc0
 do_syscall_64+0x41/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

[1] https://chromium.googlesource.com/crashpad/crashpad.git

thanks,
-- 
John Hubbard
NVIDIA

