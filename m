Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C8D71104C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbjEYQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240972AbjEYQD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:03:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94791B0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoTlYnpyXpkXzCbvDIBvHH2Vf+xBjx6e6BXaEXMkFP1RkLOgSOoUzC/0f8DC/VKWq6pVw9uBuDWv2CPEirOJYK8BtGSa+XJwqWtR0j7vVMMAkTcrpDPaPH7EPSEieQjQ9VKajyUN1IW3af9Ja9z6iZSrpbHadM8KKeSSwkBBIb4cjC/+GS5AZX1L4SbS7bXYn+Wx3JW1XRKAgdWTVKDMs0CnuHq+XIhHDraf91YTEqg5Dv9Q7epzsNpMp3UmC5VjuoT16NCxLOl5vEW69vtBJrMOVqP5gcQpQwBfGfZ4rCGB7NcdnIulekm1jNPW73T0j1bpFJR72BuIl/I/HQ5w0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcQgJpv6f+Vk/qUyzK0Lh0YicQwV9BHaSKWp7F3XmZQ=;
 b=l4XyLGnEZ+n/wValAmqYn+6rLgPqAvw+UcucdH9sZGGp/vCrG3wKtDfbZt9fuiSQY1sLewxfnR0r/QtEyM2c4ex+A1h9zKTfiHN/xo4g/5V3jkMc/ZjgEGFQnik2Lv5i/5H9Z9uT+xWbdlSnesOmngr9bBy7THqZxSYabuXhqzJjX7/Bq+PagHK6JKkU9y6cj550oh1onrgVgjZtK14qgwSKY6mp90KxLKj2NMylnLafm6m+UKAQxkbMRXVd4ko2se1x0yAxlPPdqzdS5GyTB3k6SZc6F0BZOI0W7luqnhUBcW0h3VDNTEV+sp/0jqrn8ySdlcmRVXML7bFbUj/5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcQgJpv6f+Vk/qUyzK0Lh0YicQwV9BHaSKWp7F3XmZQ=;
 b=DjMupGoygEBIIUkVIbNSDZXuAtckCMXzm9S+Sg3qGS9WKxPpBt7dYmtxsxQwRoG6BQvP9C8EeOxDgcYWfkl12Du/DhOp1J6Qi1CPg3Q06aVV0BPkdkGCjNkke2sz25t25h162xmGRJyW2R52O/Kh5i98Ai0vMJqWbHJ0xTM07ZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 16:03:18 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8018:78f7:1b08:7a54]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8018:78f7:1b08:7a54%2]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 16:03:17 +0000
Message-ID: <0c29756d-76ff-1fd5-09bb-0b13a5fddffd@amd.com>
Date:   Thu, 25 May 2023 17:03:11 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v1] arm: clocksource: Check if timer is enabled for timer
 irq
To:     Marc Zyngier <maz@kernel.org>
Cc:     stefano.stabellini@xilinx.com, sstabellini@kernel.org,
        julien@xen.org, bertrand.marquis@arm.com, mark.rutland@arm.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220811093620.16680-1-ayankuma@amd.com>
 <87pmh7un2o.wl-maz@kernel.org>
From:   Ayan Kumar Halder <ayankuma@amd.com>
In-Reply-To: <87pmh7un2o.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2621:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f98c6ef-095c-41e2-8425-08db5d398dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0iAPGPYEVsRryYdkN5+RwiE6/P37JYLwSv5fn39fpTlmw7f4dCYn+5O0zWfyNzuCYxgcg7pxb1AIPgd3usbnZo7rn2my/VD6141vySOo1o7GuZjitrjfJch8S+pnnckWBdWspmshoz673bbwqDbZpKMBKXmfLw4K2+GVpRsOq265TdjC9NTvbvLSSoJGLFKl6WW3R1CEi7KU59SKI4qO7VUbcD4ervQzvbcn1clXAysC6AwLuMxEZY0Vj9VZOy2SeLY7EjQ/h5qzCIMkNqq/ksNvqwUu/x2xc+VRIdL5p38+1SCePBnPjMtfBhqvSe2dbbhMCuWVy9Djhmf1XRh9Vv12w0cAI3pHOEBc7/G47PRd9fhi0q97UK0Bz2/Vwz1VoRFZc9Z8XW/GwSst3zjxNdXXcRGBOmdkgMD8UFxwlELiIhK7t7F4zWqjdB+SIMIZJX5854YTJziEy4FDQA79TIZAUi4FQjLJ6akeqDTUhbicn5kGCB4g7Noo4Qt14CsEvaw8lREeTcVJp3l2ZlMB3pP2m002kbKjbaLShHqmY2mrCe5WWjCTyw4jQkBcPgmH0ALB3U4T6eSOWmBCEhjm6/tU6+OGa+C2//Cjj2Vrb4kDaSmKNYWKlROADo/LHYDBDIQlWJSKVYZcGPBmSy1Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2621.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(31686004)(38100700002)(966005)(478600001)(66476007)(66556008)(66946007)(4326008)(6916009)(6666004)(41300700001)(6486002)(83380400001)(316002)(31696002)(2616005)(7416002)(8676002)(5660300002)(8936002)(36756003)(186003)(26005)(2906002)(6506007)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckJoa2RFbDZEdlAva0RHM3pDZTJ1WWRzNkJYMzJqNDR4c0EwazFEeGZ0TG4y?=
 =?utf-8?B?Qkl5TnkzaC9JMVBSaVExQ3Q3MFp4bGtaWVlBYWJheFRocnI1WDBtdzVSMGY1?=
 =?utf-8?B?UitVVnRONTBJblN5Q1Z2OUNXVXQ0QXVnZUJBaWRSd1pQYTk4ZHAzS1dkU0dz?=
 =?utf-8?B?MkRPcW5OSDY0bGkxdXNBQXBFU0VhcGF5ejFYRnFMNWlTRGFGY0hEWEJPV3ky?=
 =?utf-8?B?NzV3d2xOVllWVTlyMDQzRGJlTG1ud242ZzVQNTZldmtQQ2sybU9TQVJMSFV0?=
 =?utf-8?B?MWNPR1VpT01EN2pVWXoyTDdPLzlJSElIeTFBaEFkL2hBODY4QWl3WTNNRFdQ?=
 =?utf-8?B?ZXNkZE9KWWJ2VExQRTE0T2lqWmpUb3RsVkExdTcvQ08rSkM0YkhaSUY1UUgw?=
 =?utf-8?B?dllaSmg5dFRqenE4dmd0dndKTWNtOTRkWndCMzNtSjk4V1liTWxNTjU1WGxC?=
 =?utf-8?B?OVRiRWZsUVZ3b1dsd3ViT20rWjU3SEwwajJLTFVKZ0ZnSm1KQXRiTStnOS9R?=
 =?utf-8?B?N1pCNG10TldYQmtzV3N1VThNRjd5ejFvWUNQb0hWbEtFSzkwL3oxYUtPRm5u?=
 =?utf-8?B?ZzZZOEdJcXYxQWVFTy9mZ251S0RoWUIzdnRwODh0QzdLNVgzUmpMMFhxOVhQ?=
 =?utf-8?B?eldUWTBodDhEU2UwZUt3eHlKRDFNbVVPQmkzRzZ4WnNPM1JnT0c0QS9uZVlw?=
 =?utf-8?B?ekNUZDArUzByNmFReExQVDBMU3VVYi82VFcyb2JjbGlIUEp1QndSVXFvZE9K?=
 =?utf-8?B?bm9oSHJiZFdpL2FyU2I4eElIKzQ3ckhzdGRQTVFkUzNIV1EydkxNekkzQk0v?=
 =?utf-8?B?VXl2QVJMcmE5ZDdUTWszVnVXcm9Rc0JoUCtTUzlsb2JLTEZxTDdWOUN0TlpH?=
 =?utf-8?B?Y0VtSXFtSlQrUE1EWnZIODlXTmJxR0M4NWdMMkxxMUhuNVZtTFc3ZGdjOFBm?=
 =?utf-8?B?Ui9vMzhwMk82UGYvdFJaR1hpSWlDeU9FTHVabXlIKzBRK0xKQkJsNllGMkQ1?=
 =?utf-8?B?RkxoTjNqZDl5R0IxcEZaZjJCT1JrdGEzdGpTREsxUnFVQVRWZiszUXZkTzhv?=
 =?utf-8?B?Qzh5RUxSL2xjc1ZYVVJmbVV4SDlBWVRHUk16c3oyUmc3YUZubk9RM0g5QzBj?=
 =?utf-8?B?c2I3WkdodDRhSWJxUW9nMmFGeFNSQm85ZDl3T2dBczhaZUZ0d0Y0MzZQY2RQ?=
 =?utf-8?B?VVRWZys3azJnSFhNR1B6aFRpNlY0bWtlaU1QTUxQOGp6YVI4b2ExVU50ZHN4?=
 =?utf-8?B?N3ZDdk1TRWY4bXFBb0M3WHIyK2pzVmtjQU5ING9xTmp2eVVvV0Nxa080Wmdt?=
 =?utf-8?B?YXdWNVk4TG5CZGFUUGcwWjZLMU1lVXduTjU5WEQ5NXZWalFNZFVaUEVFczhu?=
 =?utf-8?B?cGg4eDZBWTNjZk8vMEhQR2V4cEhMRjB4anpMeDFoSFplcDdKRlB2SWhrcnhF?=
 =?utf-8?B?T2tvSXRUc0tUbXJHRXh6dC9mZUFKY0lQUjhGLzJySnRRZXpDYjdUa2tOWWdz?=
 =?utf-8?B?UTVQbnFKalVYODkwNU5ZQTArdHlJRWdIZkdOSFJmckttZmtOd0hzQVBEZmNZ?=
 =?utf-8?B?V0dZSjRKaldYZ2cyQjlZMkVOWVRiM2VtdW85Nm0xTDlrYndvKzdQRE9heDlr?=
 =?utf-8?B?VjVtbVJHeVdXbm1VeXczY0psYklzL21tNXQ2SDBZTnNmeWhDNkpiMi9GL1VV?=
 =?utf-8?B?K2Y2NmJpRzhBTCtURlBkd3hQYlkrSWpTejJHaHhXZmZjYTM3Nk9ZOTl4bFZK?=
 =?utf-8?B?OVdNYW9LenVrVGNiMFQzbHA5V2lONUVSc2JRN2xvTkdsZW52RytPOUJpWWhX?=
 =?utf-8?B?dGRaS2Vmei9EK1g4WU1CM3ptbm84TUFqZFQ5a2NDVXVXZVlvN01uWVJNNE5y?=
 =?utf-8?B?eVBtL29SenJSTnBKRHIzdlNiVWM5azczT1VCUFcwM2ZPaENKVGs0R3MrbnpQ?=
 =?utf-8?B?MzRibUtqZDNJZ3BHbGlmUzZTcWNGYjJxVHdOL25IVE5naTZyZnl3ZStzVXZN?=
 =?utf-8?B?aDg2ZU5tNTdzVmIrOWhVU1RLZmtzRUIveUdOZC9pbnhudEVlblUwQ0ErOXVV?=
 =?utf-8?B?bmx4eGhaa0NkaXRFS0xNeE1YTE5xRmpveVA4V1hCYkxoR2hNcmhtYVoxYndx?=
 =?utf-8?Q?A2Mo1n1Eq4ZRWVYBgNuqj487Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f98c6ef-095c-41e2-8425-08db5d398dc7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 16:03:17.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HolSMf4k+OyGRQ2LE0OrZP+gX+J2LiF0r3XfFNfloIQNNNwl6e9FhPEVXEzmSx9aHUiNz1RO1PVj3qSUq6JNSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Apologies, this got lost in my mailbox.

On 11/08/2022 10:49, Marc Zyngier wrote:
> On Thu, 11 Aug 2022 10:36:20 +0100,
> Ayan Kumar Halder <ayankuma@amd.com> wrote:
>> Refer ARM DDI 0487G.b, CNTP_CTL_EL0,
>> ISTATUS, bit [2] - When the value of the ENABLE bit is 1, ISTATUS
>> indicates whether the timer condition is met.
>>
>> Thus, one need to check ENABLE bit along with ISTATUS, to confirm
>> whether the timer condition is met. Further as the doc says,
>> "When the value of the ENABLE bit is 0, the ISTATUS field is UNKNOWN."
>>
>> Signed-off-by: Ayan Kumar Halder <ayankuma@amd.com>
>> ---
>>
>> Please refer to https://lore.kernel.org/all/6cfcd4fa-3afd-1c70-6a70-9df557ee1811@xen.org/T/
>> for the previous discussion on this issue on xen-devel mailing list.
>>
>>   drivers/clocksource/arm_arch_timer.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 9ab8221ee3c6..96921772814c 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -647,7 +647,7 @@ static __always_inline irqreturn_t timer_handler(const int access,
>>   	unsigned long ctrl;
>>   
>>   	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, evt);
>> -	if (ctrl & ARCH_TIMER_CTRL_IT_STAT) {
>> +	if ((ctrl & ARCH_TIMER_CTRL_IT_STAT) && (ctrl & ARCH_TIMER_CTRL_ENABLE)) {
>>   		ctrl |= ARCH_TIMER_CTRL_IT_MASK;
>>   		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, evt);
>>   		evt->event_handler(evt);
> And how can the timer be disabled if we're in the interrupt handler?

I am not very sure about this.

Is it possible for a pending interrupt to arrive just after the timer 
has been disabled ?

- Ayan

>
> 	M.
>
