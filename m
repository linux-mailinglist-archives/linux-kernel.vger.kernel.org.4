Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD88C73AF9D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjFWEy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjFWEyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:54:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC5E10F4;
        Thu, 22 Jun 2023 21:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7iA5+dZVc+zTq77rViQ13gxJvSzTEA7dvV7pLfcRIfzjfpbDTqJrgPYs0KeS0hz2u9i/BeLWhDVg4VdAyoJoVuhg/mQejfcFtXEavy/fJmZKMDmajUxYjh+kPyg2kUj2QcF7/IjEvWQ3w0DdvuigX7hJsuU9uVfENCCFVB+aMHa37RT0jca7nNJ+QrXB0lJubxVh+FShvc7AqukIFqAqpKk7WHhwHcqOjEkETmmXZuXXYzMVskG8879KzFpCESPmvN2Z3/lUNweP9Eb3BHZwktSjbpRefVoUj4Ldo7/88GB7dsNM1NvHs2ltZoWwIlrmWBUL/CL5n9/sBnkvb1Dug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKSDUN6LiK3r3pUWpIAB6WvwdXCdpv1omPA19L7U/QQ=;
 b=gnFm6q3c6hJOUccXs9r2qyKLE9tqmwmwGN6SPP8PvFVCK0VOXgZZ6EHlPx43ZsO02QhI1SNgaFNWonZ1FDh9eGz8xncokSEqTxbQnKFCieH5xLrRlmEplLVkdlEgjAy2zMPCdkpR3nA87BdQf44BfXhFiGb2yZf8DhL7IY6Um0BbxEXNwcDF4ahpihGjsuRLmbQF2Ma3g5ZG7eyEDdNytiJwZrkp7u+t7/KrUxLwzcsNHSDA2mDGY+S6nM06zTRHIGdIltzyKg1QtYm7ACgtUFSjY7Q8kKKS2wbZZklRwuVqCQsnf1AVS6B907eDYfahC/MQCi3yKocKqZIEhEa1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKSDUN6LiK3r3pUWpIAB6WvwdXCdpv1omPA19L7U/QQ=;
 b=tRT5EZybGhU3L1iVwOciXcz7N6w7uKXUltkS8fIG7upErKDWppQzaX/B7J9u4COvfO+rn/9zxIJhr/IWS3bqddCJiUruH1/yWtsuLdpgtfSgH86yxYOKrXkJRg1Fs072nlrAle15ztqElpO/KKO3NtWJwHZNl3KNFQbKiKrFXedcPo7NaVdCVPbIRGe2ua5xd4D4x46dKsRu+kCzaVCarCoc6hayo+Zkisjl1jFGi0Y9uLpITx2C1Wnaq6y/Di6Wu2eNRB+C+m62IEPQe5qP0JjxWuEMpKD3OQUVA9BajcIRr868F02hX8yxTHHwgkZlSXbrzPb0vQlSDEX44OnoEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 04:54:49 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::bda0:2d44:96c3:c3fd]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::bda0:2d44:96c3:c3fd%4]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 04:54:49 +0000
Message-ID: <f22b4fc0-56a8-a919-3949-34a7fcff802c@nvidia.com>
Date:   Fri, 23 Jun 2023 10:24:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/8] ASoC: rt5640: Fix sleep in atomic context
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, thierry.reding@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        jonathanh@nvidia.com, mkumard@nvidia.com, sheetal@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Oder Chiou <oder_chiou@realtek.com>
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
 <1687433656-7892-5-git-send-email-spujar@nvidia.com>
 <f7414eb4-71f8-486b-81d3-6f467521c013@sirena.org.uk>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <f7414eb4-71f8-486b-81d3-6f467521c013@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::18) To BYAPR12MB3205.namprd12.prod.outlook.com
 (2603:10b6:a03:134::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3205:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: a3046231-727a-4bb7-edbd-08db73a5f943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffoebxQChcLjdGaKKE/kNiIetUmkwvH9SKOuaizThnekAng1GD0nMQzzLHauQhqa0NisjOdqvsdYTqU1FyDnzZLQSOMmm9GKOpQYO/KFE+m5nfV9UNSrVI5+IVCS3mWMtvofvQ5LXa9MJSfI9ITWk+aBt/VK+6hOMjtUtsy51F0d53XHie7Fj4feODwlhbVScOVtMa9jcjQYDG0JSG1059+99HaiiplMILLafIcwLhKQcbCCgKLlIluuFDsNWrZ1Sj+EYqoy5WeJ2EqB8ZrjZvDvuWCDGNcpoL0C4wsKTzXDgRvF7eX28gfqMlk7OKfI83GkvvCidAOrwCA3AfxyysPES66V37+6DSKtrlWEEVrgpqhc1pPPaa88NmiyoZULXXRsnqchEnTBn647pFgnRkpYWVsfcvLT1PohFyEW6Q0PAdi+vv0eaKsxWvkkZ41svyebAylIWDUG13N98q+WqBkuQHUQowTIKlhzc3Lv/prKx9wNV6TG/1e/OIb06AOGq7QzoqYEVQR90t+QBl9W6xYAcMxw8j1fslUwP6z/4siHjPFqA+2GtwyM2o4Iiakaj7e9ePUp+34Rj+xv2+r7vUIQltzoM2Pyxg5leozP0tgZnsAbPuRdMe6vePDsHTPudnfgek75Wi1Y5g+tTbAoPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(38100700002)(83380400001)(53546011)(6506007)(6512007)(26005)(186003)(2616005)(7416002)(4744005)(2906002)(5660300002)(8676002)(41300700001)(8936002)(36756003)(6666004)(6486002)(4326008)(478600001)(6916009)(66476007)(66556008)(66946007)(316002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFJwUWszL2Z0QnlxckcrMjk5ZkhMcEJmN0U0ZzhDekRUeGNNN3h1bXRpRnVU?=
 =?utf-8?B?SHRpekFPVG9IRzE0UnlKdUFmUHIvM3lzRTZ1b1psNEdBd1UwUzFHM3RMNGt5?=
 =?utf-8?B?TnZsL0pJcGpBdVhrQUtEei8yOUlmRmwrRllxS0ZMdzNtQVo4U1Qvc3VkanJL?=
 =?utf-8?B?eXhEMDdzdnlxekVDMjVvTWdYYUU2SndNd2JQOE9Ibi9MSlYyQzR0QXh4ZlRH?=
 =?utf-8?B?ZjREU0pyankwUENPK3VFdXliTHVWd1d5MEJKZmd2NHptOS9OeS9tYVVvVDFQ?=
 =?utf-8?B?N3ViR1U5S1lTd3IwNGpHZ2pCaERHcjhSNzRKblBiU0EybXZPZEJJaTU3MmhH?=
 =?utf-8?B?QmwvU2x6bXB0aUJ0eEx2SDJQOGJsNjNMdmQ1T3FhdTU0WmEzeDZTM2d1UnU5?=
 =?utf-8?B?dmJzdUlTbklON3FIRitZVHBDRStGRHlsMlBMQ0lGYURYSlBKS2FlbWR5Mm9l?=
 =?utf-8?B?bnBDTXYreHRoOHhsVmtZRkkwVGdTOERlbGFvTWs3OXJTdkZaUnh5Mlc3VGhY?=
 =?utf-8?B?eHdaRW1kcE9UTkIwdkt5NW5oa2RxSjFoL2RKdWp4Mk1ZTG1GcVdOSWtseHk3?=
 =?utf-8?B?SEpqTWYwaEt6NVlETzlkcnN3NmRKdERiOU56M3c0dUV5MmxaalBOU3VEZGto?=
 =?utf-8?B?eS96bWlKVkt1NUM5VitrWmpQWlVEclo5T3NjbGNxbzlkbitIdWJ4c2hPSFpy?=
 =?utf-8?B?S05UMjB0NHhhTjZhT3pYakpWWFAxV2VqcjBWMVBFcDhIaEx5Q1YxMXJZWlVZ?=
 =?utf-8?B?Mk44S1pTTXdjWFZhNlc5QmFCQTRadzY4aGYvU0RITXdyT1duRW5ZVGlIS2Nu?=
 =?utf-8?B?MExxNE1QVVl0UnFQRnFZWkF4SjhOd3ZnU1p1YmI0ZzJXT0Z4eW1PNEhjOXlM?=
 =?utf-8?B?RkRjM29tdUhDZmVRbEl2ZHE2aHdFaUx6RUEwQVV0NFpPU1hUTlhjWmZjYTNw?=
 =?utf-8?B?eWxWYkJxYlFGb0ZJQnI2UnBPWVN5aGNST0VmVExLSHdlNnJibzREWG4yTzJz?=
 =?utf-8?B?WXI4ellVelNxMWRMK05zbGZkODRkOW02eG9sMXZIRFFhM1FSMCt3Zml1eWtJ?=
 =?utf-8?B?SWxvMzlWeTdRVmdxZnk0bmdXNWw4L0VxZEw4Ry9NeXA4bi9xQlNvZFY3YU5i?=
 =?utf-8?B?VS9ubUhqcmNDQmEwTGlHOEJaeHg4TXZ6LzFWbndlNHBZZ2Y4MWVIWXl5MUlp?=
 =?utf-8?B?L3lSKzRRbGxWenk1QWJ5TlNkNThGSEhrV292czdKNCtBZ1NRM2pUaFdNeFhl?=
 =?utf-8?B?bjJYUEZUVzFOZXZNd3hIU1htVGdZM1RyQkZmMzQ4MUhyb0U1RlBuN0pRYVp5?=
 =?utf-8?B?Y1JVOG5qdWlZellOV1gwelBoWEdXSHlkYTc3ZDBNcWRCVnJ2Vm9QWmNYbmZF?=
 =?utf-8?B?ZDVFNXFTYzc5aEFnNnFmbktWc2tXQ0pWSlhkakZKb3ZObGhFWTJnbG0xOUx5?=
 =?utf-8?B?dkxCSVIwbkl5cndKVSttbXo0VFMzWS9WNnJXM1VlQlpVSU1uR2ZBdzRITFM0?=
 =?utf-8?B?YUhHSFdVTmtHdlliek9lejBPbGNzcEh1SUFJY1gya2h3R1c5ZVVsVWpCVzQw?=
 =?utf-8?B?V1BKSGsvQUtjYnlES1VVbWthK3N1ZWNGeW9JQUlibTgzOXZUUy90WGZGWjlV?=
 =?utf-8?B?dU02VytaUi8yV0NCb0UrcFYvcTVwd250UFR2T3FiU2dLNEdFK2dpSXNRWlNE?=
 =?utf-8?B?TXM0MUE1OHovWVlkOUp5Q2RDUTlpTFU1MWtZL1VoT01OblF2ckJicGxlTzgz?=
 =?utf-8?B?eG5Za2RwL1I2MWhGUjY3QXZyT3BMZWVHdXlLN3hlYWlIczFBTmU2bUxjWjc0?=
 =?utf-8?B?cFlNYVR6dmJ1ZjN2RjRRcWxhTTlRVWdITmpDOGxjZVZUZUQ4bC9yL2QzV1d2?=
 =?utf-8?B?cEZqUHJqZEVaZXNGc0hEcGdMbzJ0bXYvWXB4bk9iNldFZElLM2ZzNEhXclRB?=
 =?utf-8?B?Y2U1b1ZoYWY0OGJrK3dJNTNvTlhXTUFCQVhDRDhTY3gxanZwMmtFY0w4aGkz?=
 =?utf-8?B?N1JGKzJUMmltbUxKNFgrRWZRcTJCemVRR2RGb2xyRWE3NTd6c0VMWHAweTZ3?=
 =?utf-8?B?Z09yQmNlcytKWHNPcGtWOHBZd2VRRytrZWo4NURIOE50bEZmV0oxay9vMzF3?=
 =?utf-8?Q?ZVkQqQFtNCom61cNwmYj7+6af?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3046231-727a-4bb7-edbd-08db73a5f943
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 04:54:49.5190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8E5k6cn2sLdRNtPGwiEuEZx56oFck5yziVUB5ZbdEMEOMfrobqYoERx11bSb/4XLB6+jrjffguhJBXJXKcw6OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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



On 22-06-2023 17:42, Mark Brown wrote:
> On Thu, Jun 22, 2023 at 05:04:12PM +0530, Sameer Pujar wrote:
>
>> The IRQ handler rt5640_irq() runs in interrupt context and can sleep
>> during cancel_delayed_work_sync().
>> Fix this by running IRQ handler, rt5640_irq(), in thread context.
>> Hence replace request_irq() calls with devm_request_threaded_irq().
>> -		ret = request_irq(rt5640->jd_gpio_irq, rt5640_jd_gpio_irq,
>> -				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> -				  "rt5640-jd-gpio", rt5640);
>> +		ret = devm_request_threaded_irq(component->dev,
>> +				rt5640->jd_gpio_irq,
>> +				NULL, rt5640_jd_gpio_irq,
>> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> +				"rt5640-jd-gpio", rt5640);
> This is rt5640_jd_gpio_irq() which just does a queue_delayed_work() not
> a cancel.  Why is it being changed?

Will drop this part in v2. Thanks.

