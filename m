Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238976D8F5F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbjDFG1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjDFG1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:27:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2099.outbound.protection.outlook.com [40.107.20.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE9AA5CA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2ifxgZDZbwsywJjwo/k3m8Ml4fzx+JkAelOjPfCwvxAQEWvuSCKfCS1SDeAsH5FVOVsaEbtPXILCyq6uznjCp48eLFKIGUeSw6Hsc3TbIei5y5COvfLPMvE/Em0VwOVLvC8cI521nq5WypKcMaxH7vaCNQkh+LCizHgUui7pKcRm9+nxsjROUfmkIXO5+Iiy9Dhk4we91TBJWjYVT/9RhsHnMtIOpOXCOYmj4/Op6mH7EfWcVYYnN8Vt2nwKBqKMZJeaaxWMf70bD15jRPvjchOJmHCmaPN+TPjmf8po7+c9flkOvAlwx9CEaqi7quHXxqejTIZk2O1H/oUBfMs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mCFsc1POSZFfhHy/0iFbaCXE3Jqk9xABbzorxWwGHY=;
 b=nBum7cvjhv/QT/AoMZPW4kNNgNaUzx2Boeaq6MHv1r3hlXVHT0LsZIldeGterKnfoIpbLcrLm32kuapaBQE18LO+U/vyedn8t4A9Yj8VxfaKTlpiLDtBSREpvs+xPIEo2vTBMFVKqEYV3g9j7OuIf6thjp8BG0EXPVE5noJ3poyOYyXaYO2170SFag1prlASGJOP+8RokPOb3QNz3o0ZcN/XiyOov94+IbaSSRvRp1fvGjHPtlVXyLiShOByqpEb19EAn9BRG+ZaKdV1SZ3Z7X+UArqwDCUnXBWXvy3yzpBC/jkR55a5s4DZKPTKbhi9RgqaK5/sV2PyshcIUTR43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mCFsc1POSZFfhHy/0iFbaCXE3Jqk9xABbzorxWwGHY=;
 b=DxAOC16cMQiaxAXh5g9THDvT2A4TIDrTGVof7w1QDDVUGcOsCOGZP1mCXZG35GhP2xFXUwkCMKPZ0/Kcbu1SM/4q9T1rkVcVncfi11ojysEwAfnEG2p87UaXDcVThsoC6iFQv9+23ejf3vyf+61eUFzKdSlWr4exHu8SPrq34wIfoVsC3/ybbB3VMuyKs76nvrfp29J6Lr5XDynwjQJOijwjYhfoC6vJra0U1rn6MC4V5lB7njoVUeFE/bnogxLcLgyoKsjwl3EgSsLFieAJIty7Wcj3eGP+RWP4lqRf92HLmpCgPTF/jfceo6az3nCRb6usbmnbmcOjt3Y08LdtLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM6PR07MB4535.eurprd07.prod.outlook.com (2603:10a6:20b:17::17)
 by AS8PR07MB7446.eurprd07.prod.outlook.com (2603:10a6:20b:2a0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 06:26:55 +0000
Received: from AM6PR07MB4535.eurprd07.prod.outlook.com
 ([fe80::5eff:1178:303f:7ba9]) by AM6PR07MB4535.eurprd07.prod.outlook.com
 ([fe80::5eff:1178:303f:7ba9%4]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 06:26:55 +0000
Message-ID: <59f7ceb1-446b-1d3d-0bc8-1f0ee94b1e18@nokia.com>
Date:   Thu, 6 Apr 2023 08:26:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        hpa@zytor.com
From:   Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Subject: [PATCH v4 RESEND] x86/rtc: Remove __init for runtime functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::49) To AM6PR07MB4535.eurprd07.prod.outlook.com
 (2603:10a6:20b:17::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR07MB4535:EE_|AS8PR07MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc1505d-9aa1-4791-eaac-08db3667ea79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ir5W/TIl55mErdrQAMK7FJjuXXCsDL2sFaW3rK7B/Ifd1xqa93NxsiRGheSrYrsr31HNiTvc8IiKrW8dga4Ytll4muTaWsCZxL+7DE41FPHlE2NscQk4Ljqk+M09TjYzCYae/5ClHH68CR+tMX7pND3GML/khW9eWYUEVyjsKTd9uNKDmf9sXmJ7jAbo3OM2AO8+N7HGSTdUFPUO7vduqtKnW5Xu2a7Dx6UEeQJpvkVPK6WJOBpDarUTvkKe5jEVg49Ej3kpgFjLPJXS+b0yFW0+O7fRnD55DPEHM17cAURv4Uxsr8/TMWV5JuiJm4qvIpMfb+P/13wjEbF9vfLd9OuCpwtUNSrVM2OF1ts90/PQI9i5mMooRdPtxKa1OPjEN3x1kYvLN2SmGlddlwD4OLlZy7PiQNrfTfiJY6kHbXw1tmjUK6cY/TgfhVykHWpDLvmg6BDVEpa0d6xS3s1HtydV7NBsJgVbkIcgjxZn97Y0p1wRsj4z4b5Fs9+ojg5FtSmbs0evea3npE5aY0K4iaLnSUY+F84xXYwiBwfo9V7ExAY83JBl2gFvKz1B7fXi70t6Um2MfYnf7L7JzY7JyCnWL+C+/PNndVbUhkTauGJ12ohQAZpJjR9NzDdaZ1GPTw1HRMWur09d7Ovn9Sik+P+SNGxvRVxr+qyXlg1lSk/S5utFKth+j3x+T/GD/Jt1c98NUnUW5eNUztfca9LWpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4535.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(8676002)(66946007)(66556008)(66476007)(478600001)(110136005)(316002)(8936002)(5660300002)(41300700001)(82960400001)(38100700002)(186003)(55236004)(83380400001)(2616005)(6666004)(6486002)(6512007)(6506007)(26005)(86362001)(31696002)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0dGSXFObVBsT04rNG8xUkRhYThKZkpuWTQ4RmpJYlZEa2xNUm9xSDdrbFFv?=
 =?utf-8?B?SlptNHpWT1BJSi9vR2lHUW11K0lucExLUFg2d0gxYk1CTnUweGNXckpoZ3p4?=
 =?utf-8?B?cS9TVjhNdGs1aEhBOGRUZzl0UU1FaE1SSDk2VTJOOUc4bGNuWjJuc09vUktR?=
 =?utf-8?B?UUY3VXdod21WSVdteGhVa0JjQlA0MjhvSC9HdTRMc085aWQySGVMd21mZXVQ?=
 =?utf-8?B?dGNJNHk1dXA0MGd6RjVIZG1meG9TaXRkSExtd1pWZ09jQ0JSUy9hTnNqamZT?=
 =?utf-8?B?NkpaeWpPZ3E2djBiVytQTFRqb3pIcEt4SUhUdjNYUmhYZi9wWGovSnI2UjFX?=
 =?utf-8?B?cHVmTGdjU3FoT0FNTXNIT0hVTjhJc09SRi9CWUJKUUR1SzVFMzdYMVB5RVlN?=
 =?utf-8?B?aGh0YTd0Yk8rK1Y1ZGZEcElTSDhUUkc3RjVaSUJhb0Q4WW9iVWZtVXpXU0tF?=
 =?utf-8?B?b3Nzd0FVTHIya3VlRXdVSlJWRDAzUjhiNHZTNXEvT2pKSit1NTNUT3RISUpa?=
 =?utf-8?B?eUZleXVob1FhSE5DempmTWRvYVEwaUo1UlN3R3U4SzVkVU9sSWl4K21UaU80?=
 =?utf-8?B?VFF5OEd6Z0Noa0FTNFl2RUFyYStBTWhWcFhKbllIODlDZ0tJMFptcDhVSDR6?=
 =?utf-8?B?NlNTZnpMeEJKODMxbDlqOHd4ZXczTEpGTDNvd1lPY0IwdW5pL0ltMEhjUWxX?=
 =?utf-8?B?UFdBVXlTbE9WSVpQK2pteFUxak9sTTNHQ0x3eFlnOW4xR2FWYzhXYWduV2Uw?=
 =?utf-8?B?Y2oxWGZLcmUrY2w0d1RmcFVqWnM3MFVZMUx3SDZOc1dsUVRITGlVOVVHWWlj?=
 =?utf-8?B?VWcwVlZjTzhZYzRYbnNYME1XUkZqR3RlVld6RkFFVmtLNnlMMFhkVllvTUhM?=
 =?utf-8?B?VVNkQmFwZWVlSnIydlkwWkxzbTJUMEcxQlBTMXRWZ3dMamY3dCt4OWVqK3Bv?=
 =?utf-8?B?UjlIODU2WHBDRm12Qk5vUXVlYVZDNDZsQW1ERk05anYxSVhmTk5IR2g1dmpK?=
 =?utf-8?B?UlNOeDVRYUFia0Q0SEM4eTYreDFnYjNFSFF4RHR4UW1xWEZmeUZaYjFBMXM1?=
 =?utf-8?B?R28rNldHWklRZS9CVFBBOU1TVkF2NUo5MWNnaCtBc3V1aFU2UzJ2b1N3REhI?=
 =?utf-8?B?eXB6dDJOb3JMZWtobFlZcXRFeW13K2M2eGpzUkx5RE9WaGFsYXRlQ3ZVUlhp?=
 =?utf-8?B?T0QyZDlvcWNjbjFWaGJBanZwWFBvZGZtWGEyeEUyN1ZNR1RZZXFiWHNlbUYx?=
 =?utf-8?B?em92S055SHI0aGxkVmNpWm5KanJtQ0dyNlRGbTg0MWI4bCtzOFpRdFc0Skw0?=
 =?utf-8?B?eEdZYy9oZE5zYzcrdU9zM25LTlFQOThpbE9tUWtxRzFzd241MksxME1mZ1Zl?=
 =?utf-8?B?TGhOcTR1WVhzS0JrZmZsRUJuUmVHUXROZkZUZndZWkJybThta1VGdGRxNjls?=
 =?utf-8?B?c3k3ZXZNUWlNRlBSaUlQcWVBMTNyT0xaa2VwRU5KTC9xL2RtNUsyRHd0WDVX?=
 =?utf-8?B?aVB0WENDcy9HckVKLys0ZXZTeW5YcnQ3cHRlUHkrcWRuM2RsK3B5aTRsVzVX?=
 =?utf-8?B?ZS9xVHZzMEZaM3ptS3ZrVGZWNmJUMXZtZWhEUzNjeVRRay80ZzhqSjNqUDhp?=
 =?utf-8?B?enlYZ05UTzl6UmhlZHQyT2phWU5qcDVGYitMdkk3dFJ3WDVUd2QxY3l1SGps?=
 =?utf-8?B?QWZRQSt1aW9EWU91dlZMeTd2WlJWOCtxZHhGZ1k4TkhyTTE0MEtCclF1UGJC?=
 =?utf-8?B?dk13aDl0RnVFcUZ5MVJxK1pFNktLQWhrZVl6UVlPTzNacCt0RUlKSVVFT3hI?=
 =?utf-8?B?VjYyQXAvUmdPT0U1ZDlkeVZqV3FIWWRxVjhjR3lVSEx4TGp2U21wcWttSVRV?=
 =?utf-8?B?MSsxY203VmcyaGgzRU0yUG1kVDRtM0dmTUxzOC9JYVh0ZkJ6QlMydnArNjJ2?=
 =?utf-8?B?czFDc1BhcFJhSlBHWCt1N0ZLaGMzYVlmL0dmZGwzQnhOSGZwRUlsenFWUTZ5?=
 =?utf-8?B?WC9Delg2R2o2Z0tKNFBJamN1U3RXajdZeFJzYjdpb2xqbCtnaGF2SzhBS0xB?=
 =?utf-8?B?a2FjQTNUVzVpNG1OVVI2RzdIMWpoYTc1YzdvaWxxQ0l3VjBtREEzNGxmN21M?=
 =?utf-8?B?SXdPMWRYam5WME84RmN4bEdVM2tFU2RTMnZ4eEhCQ1d6eWpmaThzbSs3UG5x?=
 =?utf-8?Q?vHrsFnMXwBuc0s1zM5VM6Pc=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc1505d-9aa1-4791-eaac-08db3667ea79
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB4535.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:26:54.9900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6WHlSTJPC8ZNVaO4GP2EA5rtKSaKUY9/Ib0+DKk0rbuxXx4H0jxe0b6ewxWYbOlMk1yFWrfM1FinGBw5agzlftr1xKeRFIuO431pQC91cNYOHQno9OzoA/hePixSGM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7446
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_rtc_noop, get_rtc_noop are used runtime, therefore need init removed.
Crash was observed on x86 platform where cmos rtc is unused and disabled
via device tree. Function was triggered from ntp: sync_hw_clock, although
CONFIG_RTC_SYSTOHC=n, however sync_cmos_clock doesn't honour that.

  Workqueue: events_power_efficient sync_hw_clock
  RIP: 0010:set_rtc_noop
  Call Trace:
   update_persistent_clock64
   sync_hw_clock

Fix by dropping __init and making set/get_rtc_noop available runtime.

Fixes: c311ed6183f4 ("x86/init: Allow DT configured systems to disable RTC at boot time")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
---
v4: Update commit subject and message, resend to proper addresses
v3: Update commit message based on Andy's comments (further trim to backtrace, proper tag)
v2: Update commit message based on Andy's comments

 arch/x86/kernel/x86_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ef80d361b463..10622cf2b30f 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -33,8 +33,8 @@ static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
-static __init int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-static __init void get_rtc_noop(struct timespec64 *now) { }
+static int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
+static void get_rtc_noop(struct timespec64 *now) { }
 
 static __initconst const struct of_device_id of_cmos_match[] = {
 	{ .compatible = "motorola,mc146818" },
-- 
2.30.2
