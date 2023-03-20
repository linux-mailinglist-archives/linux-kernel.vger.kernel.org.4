Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41936C09C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 05:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCTEpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 00:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCTEpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 00:45:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259334C26;
        Sun, 19 Mar 2023 21:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/mElAGHjj2uA/O3/BRQB7ukEAfP+174KUlJXgO7dATGgmOscAsuLKD3BTI5HPK18hs7IiYzRAYJTsGOhDbZIBPXM/OJou26jkodAdb9qGwiW1zes4T1hkdWeBryNN3d6zWkFb/bOQZgiAme5YmhlDUXlRIj90skf4M1w/D9E/dSCXq7GmMVZk33t1dt8Z/fFKm5Y1RETL1L0BxOI+fEoi9Cy7AoM5ubMgTFeGx3ehSEqaWRWITVxg7160dtUYvapk0uB71ukW/gybjACkjNy2kNRMluLe2Ktw67FgJtaR8iaVFJM9dESfQLWxPwno/V6mV0bYx0hHY2fNzLvkGV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyYkbw1PjAEWQYBdfl0KRWkbmVvfsHw8I+yaCKrZpV4=;
 b=oVpfDODRYnQRG69zqGY+WRLl8r5QqJ6XBNPuqxDdlTkz4LljnfpH0YGOpA6LxhkF4rnROyq+wSVX9FeTCCQNMGVYjn0rNk5fucbivhzYMhK8IL6U2XYUk9bcs9j6kDuIfD3CkNIK0XDh5of3eaLDR90a1SxxzSH53JH1EvnjuTNUDE2RBU5Axlz3M3dyp6kQo7L4m29m0OoPDpaD6s6yvuUjdIcIfjK5DPTSRA/qYFqb7sYdsFCiC4xTk0MANSqR0KEtxkxf8dQeFK8XBwY6gzlqim2fEk3ISdawOGaVMVJNhVOJZL22p8e97E9KbJshNgWXIVpSUwhJTXn3/NQGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyYkbw1PjAEWQYBdfl0KRWkbmVvfsHw8I+yaCKrZpV4=;
 b=uwgj+cQIANfhYSb7K92BNAhCvHo7gYVmZGdzou4yueyAoi2uOklBxMSNTITmOcQOX6D3Nk7tVpDVl9xT4Neqd1iAKd2akrQjfdJ1ODiJzMBYEMJgWhql8elQqGtiNU2vw5Gs9tNAEOa9H0WVZsosv7qziJI1vm0ITYQfJoy9qfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 04:45:01 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%6]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 04:45:01 +0000
Message-ID: <e08e33d5-4f6d-91aa-f335-9404d16a983c@amd.com>
Date:   Mon, 20 Mar 2023 10:14:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: NMI reason 2d when running perf
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Kim Phillips <kim.phillips@amd.com>
References: <25fccb43-8338-a690-0009-384dc0640169@kernel.dk>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <25fccb43-8338-a690-0009-384dc0640169@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::22) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH0PR12MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: b608c783-2738-413d-3140-08db28fddda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZD7jvZapX6juuRVUoXps81i+wOnEU70qO77+EZzT6DuZ1WzzrM96e9UzeUcN87fYNngemJNlXypsNi+LICNIFlSykogJkQEmEi1SffEULY2b6Oi6hb1fgqDwDbszsd75gkq8fyIwZdwrtYmeu+VaBR8fl/iQRihtTYr25v6BW0bWQ6wK8XXasagDgDxIGpchtFeW32pt/t+nkTNaaBtkoa4zhL/+/9NXQDW8LGbrS1tr9nyND+xi+y/gzsAgOoM3hQ2Vo59v/kC2i0GQ6xK6MvpBM1ak7E6KbexDKAI+LSmkGVqiKognQWG2qXLRRQzHcJKb1bzDZnxp8t6GKnQCiqxCaXuTNI+8ZQdh6UZmoNTEuuBOG766tJQPi2x7x7uLpyASJfdryVzuLILaGLC3c2FY47FpGqks/9W+p1FJwwOLzQITIdWvuN0csDgJ/YikybV4nDHdzYo70vqZWwpIeVQO6jS3S3367PiTexy9ex7xQ4l9rqzim87XBVZKmt3H8DZjzflS/Ok00TN2I6j//fWTPNwIbPUF0hD+yohlbTHULHJUcpyCK2rY1oacy42psrZNh/oipWR2z4lLlaDHt1HleMV2MH2yDQ1J5RwzyEWQBPPmpr2hDFajaTaA9u2jQScX4B6Dzl3nCMdjfGXd0HLGNShoPLB+EigbkEPeBfjJO4mXB+oI7CAMQgaOCLkem8yggvHUR1KLX7YwBo8u/VLTNf6GtHJZIU0lkyQhMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199018)(31686004)(6666004)(53546011)(6506007)(6512007)(110136005)(54906003)(26005)(316002)(36756003)(41300700001)(2616005)(966005)(6486002)(186003)(83380400001)(478600001)(86362001)(31696002)(8676002)(4326008)(66476007)(66556008)(66946007)(5660300002)(38100700002)(2906002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0JEUFdGNlZVMTN3MnZNUzlnOFJOb0VGOGpNV040cmlzTUZ5eWFMNGEydDNp?=
 =?utf-8?B?TitwbUpiWksxVmJMVEs2bVpjckN5ZDVyaVBaL1lBelF2ZTduNmljN2lEaFhm?=
 =?utf-8?B?alpGVWV6OWYzVmo4NHU0SVZ2NXpQdDR3MGFDemkycjhUNXVzTW5saGhIOHdI?=
 =?utf-8?B?Y2xtamZCQVQzcmVJSVl0YVJDVE9hWW9wVThhQlQzMVpSdlZlekI0NklXbjZI?=
 =?utf-8?B?MFdlVWFZQ3hWUStVcjJpKy9rc0xGTlZ2RHB5RUdtUE9DaUdOR0xRUWpEbDZG?=
 =?utf-8?B?c25tanFlSWgrNG4zcWJrNmtWaTd0Mng5c3hSSjF3aStYQWI2cm8zQWxqZGZZ?=
 =?utf-8?B?UVZjRWYrNnpKUDBLeDdiRjNFREI1UnJ5Y1RrWlhXOEM1YUsvd1kvRHhMMDdk?=
 =?utf-8?B?Ni9KbDk1bUhjZS8yVWVXaDBzTXFrc3E1dEhpMldaTUFFRElJZ0lRMTBtdVJP?=
 =?utf-8?B?NGMwbjZTanR0Q2FrMm83RlAyQ0tjWFVDZHVNQjBLa0plNThYWjNxT2VsNzJj?=
 =?utf-8?B?N3dPWGhlZitHSFVXSzBldEEwUlQ0V1F4VTZzMDdyY055eEo4QmI2R0tjM01M?=
 =?utf-8?B?dWRrNnBPZzlhZVVwOWIzaHVWQzNaYkZoNkdXQmNiYU5JTDdFT3hGT0JLRTFH?=
 =?utf-8?B?bkQweXFNV3JhOTZJSjhzcWxnYXUwaGJnQkFsSFRYSERrbXpkQU45M2I5ZXE4?=
 =?utf-8?B?SDVEZzF4WE9HSFJLcWlBMjJUUHBaakl3M1JvcHhWRUI4bklxaDhVL3p0eFpJ?=
 =?utf-8?B?cHMxeUtFTm42d2J6VnVhMCtHQlhoL04wYm5QZUlUbUlZSWJWNWNTQUFDS2tK?=
 =?utf-8?B?Tko5SEpPUWM3T1d5L0xHd2dzNUNmTTBad09pUDd5aTgzbnlDY2VreHMrcGlw?=
 =?utf-8?B?cys5RGhXcjM1c3VMVTNFMkZta0J0SWljRWJkVGxiRkNPK21zU1ZnajRtaFZt?=
 =?utf-8?B?T0x0Wnp5NlVRbkJnaW5QYmxmWFJiQVdjNVNPU29lUEV1RzloMjlDYUJBTTEv?=
 =?utf-8?B?SE9xdWhzVHVMWVlkVzc0SG1xV3V1UWFaSzE0VEp3RWpaUUJqeWZjNk1EaXFG?=
 =?utf-8?B?RTZHVmFjMmw5T1pUMzd6dEc3UXJMSWM4RWhlL2VONjAwWHJoZGNidDhHNyti?=
 =?utf-8?B?ci9qV0dBMXdWZzY5QjdRSm5HTkVRbkhNT0htbnRTeDhNclhiN05DOGxHd0FW?=
 =?utf-8?B?Y1hZUzdiNTcxOXNIWEk5TGNKT1M3R25WWEI1ME40bHJ5VWpTQmVPbFhDaE1q?=
 =?utf-8?B?WW1YUlRmL1N5eEtWYXh2QXEwWUJ4ak1INjQ5Y0xkRE9mQjYvTDh4WlhhWHNS?=
 =?utf-8?B?SGxqRnhkM3JwSTB5aVE1ZGhwL1pvMGwrVzZuRXppZ1FjbGhaelpYNWNlUFFH?=
 =?utf-8?B?Y0ZrM3A3WUZ1WE1oU3FiWDJyNExkeDkyUnBGTDVQREtoODN4UnFhTXRrVzVq?=
 =?utf-8?B?WU9zWUF3d2VDMk9vYVBXNnp1aktvdWJmM0ROcUZ2N0pZeG00WWMxUFJPL2lx?=
 =?utf-8?B?TW9yMkliWHM2a3B2ZUlmZ05nWEp4a0FCVUE5NWJKcUE2WTVTTWZ6NWJIVUgv?=
 =?utf-8?B?bS8zWFA4dHA2aTBqcEpEcDUwUnAxSVBxT1ZsNDgyZjRtd2c5WFdsMWJ3aW1I?=
 =?utf-8?B?YytIY3VjeFBIMllOMmEwYVhucWRyNzMzaXA1S3JZTkE4L1hSWTU4WmNsV0tX?=
 =?utf-8?B?MjdmcEluQXpkUWtXclQrUEIzNm9UTmJ5clBmelcrbENwbFh1UVJYdDJnY2RZ?=
 =?utf-8?B?c1VTNHhyQTJnR2hOaVFodFYrME5LdnRZZ1F6bGhwRzNPdDcxQmF3S2xYU2Na?=
 =?utf-8?B?UHdFTDIrUHdFVFVPUFdibFRJNmtORXR2VmptYk0wc0RuQi9wdDRqNWhrS0JQ?=
 =?utf-8?B?Njg1ZDhsNnZVTVVWZ1g2SmN1OW5uQU9RTkFqQ05QSzQ5N09QNlJLN0oxUHpR?=
 =?utf-8?B?QXl0dXN1MmgzeVZUZExSNzBHMW5JTDNqVTUwYkNNcmQxV1o3dkpNL25ON1Vx?=
 =?utf-8?B?Nk9CdCtnOUc2Ny9xbzZLRmk1SUxEelV6SkM2SmZOMmNaMjdvNlVvaEtuMDVv?=
 =?utf-8?B?ZFgxZjd2R1NIS3Njdmlvc29VY1JKNFdyblk2UDM0NC81VCsrVWdSWnpJUGV5?=
 =?utf-8?Q?J78QqgDoAUyxwqbqN5BdAjCPU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b608c783-2738-413d-3140-08db28fddda2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 04:45:01.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFX/iBHt1tuTGcJZy5zSNn4x9w4XChsxjg5nuog88Jik2oejKm2KOuyV9lk4SvMV9fkRBcVzi+3/GeeOOodUUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5387
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-Mar-23 7:55 PM, Jens Axboe wrote:
> Hi,
> 
> When running perf on my Dell R7525 on a running process, I get a ton of:
> 
> [  504.234782] Dazed and confused, but trying to continue
> [  504.267843] Uhhuh. NMI received for unknown reason 2d on CPU 48.
> [  504.267846] Dazed and confused, but trying to continue
> [  504.335975] Uhhuh. NMI received for unknown reason 2d on CPU 48.
> [  504.335977] Dazed and confused, but trying to continue
> [  504.368031] Uhhuh. NMI received for unknown reason 2d on CPU 48.
> [  504.368033] Dazed and confused, but trying to continue
> [  504.371037] Uhhuh. NMI received for unknown reason 2d on CPU 48.
> [  504.371038] Dazed and confused, but trying to continue
> [  504.439165] Uhhuh. NMI received for unknown reason 2d on CPU 48.
> [  504.439167] Dazed and confused, but trying to continue
> 
> spew in dmesg. The box has 2x7763 CPUS.

Are you using IBS directly or indirectly (perf record, if run as root
without explicit -e event, internally invokes IBS)? fwiw, Zen2 had
similar hw issue where IBS can raise NMI without sample valid bit set
while exiting from CC6 state[1]. But as per my knowledge, it's already
fixed in Zen3.

[1]: https://lore.kernel.org/all/YFDSSxftYw9tCGC6@krava/

> This seems to be a recent
> regression, been using this box for a while and haven't seen this
> before. The test being traced is pinned to CPU 48. The box is currently
> running:
> 
> commit 6015b1aca1a233379625385feb01dd014aca60b5 (origin/master, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Mar 14 19:32:38 2023 -0700
> 
>     sched_getaffinity: don't assume 'cpumask_size()' is fully initialized
> 
> with the pending block/io_uring branches merged in for testing.
> 

