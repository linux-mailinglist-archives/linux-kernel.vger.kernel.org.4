Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A895A691AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjBJJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjBJJEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:04:06 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA98A71645;
        Fri, 10 Feb 2023 01:02:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVAfPBpgErrIRaAhCMs5lEuCpYEvQqXvi3cKjdr1lrxkOe7px+sJtM91uXHfLfOYls+M4JQnC7CwMYErtLQvNTavv0gD47MjcVUhlaUdXHfODeFYCTZFtR/+a63BYuRLE8uwCGgN8CqWP4KkRhAnvDhIBnYF7p1bi30iypN5eBmk0YI5Pmq3X2q6FZc/ZR8kVfinrJBZHYyjKNRe5XD+t7dszjza+dcuWMFcFn8PJ3YYqFeDwDxk7FRj/OOLADuHdhn8tymctLwES6OKGkNHVd1r9ICsaR46A9wvrpV7/7J1gSsuELyqR5va86YdeWvdJSZRgn3JDzCRPLjc9dY42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJn1CWzYccF3XHvLeIpT2l+hRL7lFOwOFFprP+/SLVI=;
 b=THWgHwmxnxQvGKwN9IVbIwbvP53hrALjGNKAeIehHm0Kl1TMEuFnDYF+YyYgOHSm470OUcxUpy4HEI1txocUNqwjvvSOSzM2/j9r5xJHdVqwt8jxasjleAiShr+T38gJWm/VGeTHyL39Y/LxyhY3lmEEkc6MgGIQUVfpXwbnD1DhRn9I/JFqqQ2YVn2rPZpahJq5VUgKYMSpRrioioBhRGcmZLhwC5M24qx3vSHz4c6uKmXfOyhVwEqOaIudlpD47YUss54QI/PxVgtwjkhyJe6H2M7NNspn9Xs5FxbzeBfZz5QFhmAAtcvkJd7Q4vKGOeBKAF3LWnWAoHL8dFh4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJn1CWzYccF3XHvLeIpT2l+hRL7lFOwOFFprP+/SLVI=;
 b=tIkfw8/SS7uDDH4wYoQ4MuXSAbducVzK3VukuGXziq6kCr0WQDdSHOZjiYm9FkMjMvClfeW2dlB55MPmSQXmPQg1OgqKQGZgtOPUHrEFsrtm9+g47CNa+9o5K/8A1qSFiebgD6FMi4TR6q38CSl3a9Gn9TJgB3/r2lssujY5Zk3mSWJ+GucvEltA35C+g9c8aF5JjHJhFRkS6OnM2nRAmZJ10Hg86liNr2DLJ4Qg1HVg0iB4KnI4pERePSUOk2wFZqWFL6F9YVLwPm+GDG1flkOiB3M736jFtrdfUKbLgqqfun3Ve5WBBCw8B8btPrMyrxLUFCcpOGm03faNIm4k6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 09:02:23 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::c035:85e0:77c4:e934]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::c035:85e0:77c4:e934%7]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 09:02:23 +0000
Message-ID: <f967b1b3-25c7-9c81-192e-82ff9f25113e@nvidia.com>
Date:   Fri, 10 Feb 2023 14:32:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] arm64: tegra: Audio codec support on Jetson AGX Orin
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        oder_chiou@realtek.com, broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <1675953417-8686-1-git-send-email-spujar@nvidia.com>
 <1675953417-8686-3-git-send-email-spujar@nvidia.com>
 <9570b0fb-1fe2-00fe-e224-229752f26a9a@linaro.org>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <9570b0fb-1fe2-00fe-e224-229752f26a9a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::6) To BYAPR12MB3205.namprd12.prod.outlook.com
 (2603:10b6:a03:134::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3205:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b0cb69-b911-4739-b6dd-08db0b4585c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjsoWHsUhDy2M/gQUtIHVs1LxCd+EAcdvJ0BaPRYa6Ti5oKXfL3Qica4/MY1o8J3nkOu+kNgPOE4zb3TH8qnZQ9QqM+bbMhYQMQjmcaIk8qeKBcuCGTR6TBCCMjYN+ELtZDKSBz/4usz2qlWYHrQ9yl0e5JL9zuKK/ESumIhv3cAIiFwyCy2T9ZVvo1Eqk24QrtLy8RwIWYjwbVGkceFSJU8JBqL8PJ67e4V2/CUkiG+Jv3Yy9YBUPnIj+LV/MQo2xYj0a/xgrXz6f6+//fjd2IIWVJHpW1l3s9DCPP1t+Ycujjjmcb/R6ZAmW1SvOmqMNj3Up48mJVfzUbRku9XjbVURzJDMpoowylOhd1k9BRtAjVKbemeNT6ejtGlZ2XDdwkp5eG6mZAxQHgcmrIyKcK2y2v/mQJeEfO63g8rWaDz3584tCkKRqocB4ADtHLN1le/5fJqLM/Dv5D6U3xh03gen9WxVLD4WsgXbONf6uOUXHkMSsU7xw8uIYIJRzYyL3A+2HZGZ+/b/XGMRf1RcOyAt1uhrljhZ5dAwxIYXKbFem61V3bpyNmHzG1Kt/PtQiwh7oYDAbUucBRSKggZcu/uCOOEZFjb/NRM4tXyWCh1pVXRcgw77bVGxzXZYH3+YVVF7xv6KQ8rX1DxDSXtStHTHrKEQwTwkYDFdSRilBBj/+SizZkqYnu330eHkm0ZBbQBHLhvPoyUyNpS65YbJLgb5IzQGIW7K+mcFhZlAtg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199018)(26005)(2616005)(86362001)(478600001)(6486002)(31696002)(8936002)(53546011)(6666004)(186003)(6512007)(6506007)(31686004)(66476007)(8676002)(4326008)(38100700002)(66946007)(41300700001)(66556008)(83380400001)(2906002)(316002)(5660300002)(36756003)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEdwa1hocFJDSDVwbStvQWlLOXcxNTJYNTdzeXM5aytVRFFoRXN0c2RLVGxn?=
 =?utf-8?B?MTRQSGQwZklyYnpTWFdjNTUray9BNytkZFhxMWMyOHlISFcxQzVsL1RQTzNJ?=
 =?utf-8?B?dURoVEh6Uk5WTm9zRW5MWXZQYTZ2RUFidTVKQVVuTWgwdXFwUGJvWTVwQmtJ?=
 =?utf-8?B?SXdmQjRCTmt0dnp1aGhWajlMWkVXY25OV0JEVU11UlhUVVJ6MXdNSHZnd0tU?=
 =?utf-8?B?VEsyVlF4YnpQb3FwMTlMVytqSWh2MDRDbWZmVERjclNIbVp2aS96ZTE4eUFE?=
 =?utf-8?B?bEVMNENnNU56M1J1TUg2eDRDVHdwZC9lakRpVkUrcjBtZnpZN3RYZ09xcjRV?=
 =?utf-8?B?VWtwcTU1MUk0S1M5M1dQcldkd1RjSmE0dTI0dExGTXVDR2dINlVtQVYvUnJW?=
 =?utf-8?B?Nll3Tm9RVTFsNjJQeERUR3JvOFY5dUgrelZjOVZLZzJpOCtzUGJaQVF1NjdI?=
 =?utf-8?B?dDZ3YUhiNHJUNWlFUnhNMkdNd2ZVd3FYZFArRHcyWVJXL3ZXckJGazdsNGIv?=
 =?utf-8?B?M1BMckREZi9UbWJudVVzSnc1cS92aFBHM0QwSHlNUVlrUzVmbDZKSW9SazJq?=
 =?utf-8?B?UGxDdDVEbUV1bWVTaWhja0hRNklKU2JZcmJXemo1bkNPS1NIbFNqVnVLL0Vq?=
 =?utf-8?B?dlNTR29rdm9rejlyeCtEbC9nYXJwRXQzcmtXaUtNcDJud216MTljOGpiSWFw?=
 =?utf-8?B?emRrZUN0R2dzb3ZkOEJSZk12QVVVUU9mZkw0ZXhMMk85L0VMNllQV0pYOEdT?=
 =?utf-8?B?SmxPMndLNFFabFFmYXE3LzJ3SldSbGh3WEt2U0hiWEpJVEdyT2tVMkhjUjJt?=
 =?utf-8?B?UE42MTBJdnFkenBPaUJsMzJHcWc5cHBNZytxNkdEREYyYlVNbmZJMklycGtv?=
 =?utf-8?B?Tmg5TUJrRER0ZEZHOC9qUGRISXNuK0MvczFsaXdSM0NveXBudXhtUHYvYWZr?=
 =?utf-8?B?QTVKQUp4RDRaQnRXT2d5UFlVbUlhQm9oMHhHcU9hcUpJVmRDbEIwemxCT01X?=
 =?utf-8?B?dmtKWXhYVjk4YkVIVEFrd2pucEFZbkt2b3l2bTBaaW5KMHVOaVB3RytlcjV0?=
 =?utf-8?B?cTIrdW1iY3F2RFlKdmVPREU5MXFvYkIvNUdPT2xnU3AwbTVZRjdQcytCRFRk?=
 =?utf-8?B?K0FBM1Q5ZklIdVNxSDZVMVd2UkJCRjZybUJjemJmNEJ3R0tmZEtzSzVlYUYz?=
 =?utf-8?B?Sm9sVmx6czdLendjaHA0NnAxSURiZzBBTHRVUDM1SDBUWFQySWxKdVZBT0li?=
 =?utf-8?B?MEJSNHlIN05sME9hKzdTWE1HV0phRkxhQXZHNUNTbXU3bnhZR2YvdzNXeHQz?=
 =?utf-8?B?T3FSS3BpakFHaVFpdzBvazZtVHBUTzRNNUJ4dnFyZ2FGQ2IyM0d0elltWXVK?=
 =?utf-8?B?Tlh6MXZ2RW1CN00zb3FCRHlJNW1RcDlyN3BIWUdsZ3VJblpuYnM3TkhkWWph?=
 =?utf-8?B?NnVYb0xCNENVZVFmaXpNeGlhalBWdU1NQUR1Y3k3R0ljOUhtZ2YwSjR1Tnli?=
 =?utf-8?B?TUFkRXoxOVlBSVJrN2ZuMC84ZHppMFhjdjU1b3BFMjE2S0pTczRHY20yUHZi?=
 =?utf-8?B?bTR1ejZJcWRVR0N6NjM4aFBpeW5TeGdteXdLYVNwdHE1ZndSYm5tdk56TEJ5?=
 =?utf-8?B?a05CRnFHa3QyNHM3VDgvc2dQanFjbzN2dmwvWXpyckp3QWIvdC9LN1dUNnRi?=
 =?utf-8?B?eXJBSndlb2V1aVFjQnNRMHhnRG5Vc0JaTjBpUEFtQ3hURVd2TWRvdEZOa3M0?=
 =?utf-8?B?VzFudzlyaHM0TU8xMUk5dFBmUlhDZ05yZmk0dytwMnlZcnptc0pJcGNCMkdS?=
 =?utf-8?B?ZFlUSG0yYmdiUUFoUUZsVzdQbkJJUWlndk82blA0K0YyS3h5V0pSNE02MjAz?=
 =?utf-8?B?S1F4bTYyS1dqUXhsakJsWks4dXVmMUlMbHJNc1BKQ0lTWktTZjlKTVFEZTAr?=
 =?utf-8?B?TG9xdnB5eEY3U3U0ZWNJQkdVYkJ6NlFzV0xRRVJ5bVFsOHBTbEt4TVZGaGpF?=
 =?utf-8?B?VFBYcHFOSDRmM2VROSs5b3BNTGYzQlk0UWNhaXpFbGs2V1FXdU8wQ1ZJOVI1?=
 =?utf-8?B?VktOUW9weW1wbEpFcGd2S3IwN3ZyTmhDTDBaZy8xaXczUFkrVUQ2U0ZoQUo3?=
 =?utf-8?Q?FpnP5v4m8YGaOQH1BN7SZBCVU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b0cb69-b911-4739-b6dd-08db0b4585c1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 09:02:23.0583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ei7W7n+H7EbuzNV7tN2uORH4PO63R3Qol7OLEoEhvPhcWC6/z27xlZL1tJnF5iKxg59hrgH6GuDMZUYy+J1vhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10-02-2023 14:15, Krzysztof Kozlowski wrote:
> On 09/02/2023 15:36, Sameer Pujar wrote:
>> Jetson AGX Orin has onboard RT5640 audio codec. This patch adds the
>> codec device node and the bindings to I2S1 interface.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  | 47 +++++++++++++++++++++-
>>   1 file changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>> index 8a97478..5881fbf 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>> @@ -3,6 +3,7 @@
>>
>>   #include <dt-bindings/input/linux-event-codes.h>
>>   #include <dt-bindings/input/gpio-keys.h>
>> +#include <dt-bindings/sound/rt5640.h>
>>
>>   #include "tegra234-p3701-0000.dtsi"
>>   #include "tegra234-p3737-0000.dtsi"
>> @@ -49,7 +50,7 @@
>>
>>                                                        i2s1_dap: endpoint {
>>                                                                dai-format = "i2s";
>> -                                                             /* placeholder for external codec */
>> +                                                             remote-endpoint = <&rt5640_ep>;
>>                                                        };
>>                                                };
>>                                        };
>> @@ -2017,6 +2018,32 @@
>>                        status = "okay";
>>                };
>>
>> +             i2c@31e0000 {
>> +                     status = "okay";
>> +

>> +                     audio-codec@1c {
>> +                             status = "okay";
> Are you sure you need this?
I can drop this in v2 as it would be the default state and it is not 
disabled anywhere else. Thanks.

