Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5028C5B6C98
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiIMLv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiIMLvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:51:54 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2461C5C9F0;
        Tue, 13 Sep 2022 04:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0jxK1fc8PP6x0tuHGSgWPcZhrVxMzsDnaLusTO3RBZHOouffpLGxT0Vo+0NSQFppKjN8XNgVCWHJzniiACRyfPHoAtXE+AxlKPJJQK9fBNm0FrtkU59OHx6Btg8A4CWHU8UnkS9yx+8TMLB9hDRYRlYgjaVcr76fIMRi+FtvwmL6zC+Gx3cCssFmbz0CKQNsyDIPuatDHibUey8L6YLESpZwYUKnag0QN4xsrN+9fNqZSLz6DqnY9Bui2lJK1Ykl0zVdeVQjWHWuImasag0PAVmupI+7vIvXMXUdEC2rig0kGrpAa2b4AMYuFE1GBoMTIgbhrT+lH+mh0XQR171nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PLvGqU3gEdjFyXken2n9tU+ZZnzU4jm//XhXhbKfhs=;
 b=aLYpbEYCWdCopWsdVbCJFCXM4YXpwY9huUM+XRfr8GLxgTdFfzOZzFYFQ/eZmoLzYkvloxV1IMf6vfp6bey72qKF/U+F1cK3wYJGNsUpTpl95qK36AJSF9JgX7HcFSpasD8DhfTlHhVRkjgh1H6Zk3iKg5xMicY+BBS2loggX8Mtoz0L6vQSlArJ1iR2wIsmD0TveCnddV36eZw0hbxlt25+Ji7RdedViTY0U9EUP07l/X7QuTaPr+4aACWvnxEVif3y5RorPYk4/LUOwNgw1ltT9DGHrD1JdQa+MucjfT0JrRrF0N5UJf1CDdG15c6w2ds9V1yGNFvdxXw99E7X8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PLvGqU3gEdjFyXken2n9tU+ZZnzU4jm//XhXhbKfhs=;
 b=30BWq2XySQ9vwPpFoE9W/9VWNjfoe0e+uXrN+6aBdZPUi3G+H17WQwF8aWBfF2tPvoYZlLgdTphITmECfn2JLoDZst6XyKfVT3Pq1oYwbKmx0a364sGmEBXdVBagVOk4UaCjMvG7ezd9hN7lbA9SG88gsbUBBMJFjvBJAoc1M7F/kEmKJroS8YGXgvcX+VMblZowJmJk8in2x1gSoCPeQiDedkPny7nQyaX++jEhLWBVBkUWjCDI3nOU3KcTBmLJmdUdVo7igvPbVCvHYQHpcI1BGdY1pWim9b350qp6AA+WH8uuIZHE9dwpRL/TXQ0X3Ubrmc1c0Wq6JwAJA/wBnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM9PR04MB8908.eurprd04.prod.outlook.com (2603:10a6:20b:40b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 11:51:50 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::c98c:ae67:148d:bdbb]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::c98c:ae67:148d:bdbb%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 11:51:50 +0000
Message-ID: <336cb80f-8f58-92ba-aa92-1bb57a75f0fb@suse.com>
Date:   Tue, 13 Sep 2022 13:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2] dt-bindings: mfd: Rename mediatek,mt8195-scpsys.yaml
To:     Lee Jones <lee@kernel.org>, matthias.bgg@kernel.org
Cc:     robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mandyjh.liu@mediatek.com, linux-arm-kernel@lists.infradead.org
References: <20220830091110.27857-1-matthias.bgg@kernel.org>
 <YxnGBN4QEb1yMrGw@google.com>
Content-Language: en-US
From:   Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <YxnGBN4QEb1yMrGw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0004.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::17) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5366:EE_|AM9PR04MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fcf582-b185-443e-4e88-08da957e57ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mktjcQUstlE/IHeWaS4FGrU9VPnraj9sbsGCHNWZeDo1KDgIkh3Sny94c8TWVw6Dk1+jRbjpOXc84bgyM2iBhJOczfvV3w/1og1px/sQPLMkGFAC8mjdPQah0xXRLWg7qFhkVQS9Asn6+VsukGNzvidWncW7zSW2rQIsfLbvmAMYvzDa+w7vRflOs1ewLtuNw3Xo0YBy5justHJsj8/q0SZV0wXHKqB7CFp8ZU1HhH4u8oCiUTMxdAwuwUSPyRIZDFSzYdhnftwje5CB4dJRITaI7yI4O6Md5CH8glHpebcSJOIjxnhcos6aPEJbuJ2ZkWz4hLQs91ThFJ8zjroATNbtxtf1WfXGECFwJE77rsk8Up9eqjFIoIKy4fraW+6nAQpblppSKPFx40qlvSTlP1zamgqYcNbn28NggoDSPzScqSWfFbraF/Ywq+4GohZQrnebv0J8ax/XdsyNvGp269rF4QMSEHkPwERESJiKnqZCRorjsB1B+eSw/R92LJ6m7H08DI90Yrc5TnVP9xlW1Bi3Hr6ia6j6AeFHQ8oqYRvN4Ch1pLsjKjnWwZKRV3nDUZ/r/+JYtvpWN6AAWSQc6vtDmF1fy/y7H0RIWT/eDZsqMV4+10ZmMzigfj2GbO+ScjKMwLtQc4HCGPdLI2lRiBXO9EiqCHSUDVPYtSiC2y3BYpGrLS4yhDeokGln8A1a4Bpe75oK8IZBn38vJxthIHOs31fIGm0CB0u1i6zGNQB6ba+sLkBTDrKUyF/po4yCc/HxM6YVz0xC8PxPr4wU81GMm7OvGAb1RmW0mHt1Tx1cGEnqZNS4jo3+h16Zrf+A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199015)(86362001)(41300700001)(5660300002)(6666004)(6486002)(966005)(31686004)(36756003)(7416002)(8936002)(478600001)(66556008)(8676002)(66476007)(4326008)(316002)(38100700002)(2616005)(6506007)(66946007)(2906002)(83380400001)(6512007)(186003)(31696002)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGhSZ3p4TzEyc3ZYM2VvMGc0WmFCNDJZSENuZHdVNDZlbnlncHhURVVHY1Rr?=
 =?utf-8?B?L3pHMDNZTGw5N1FwaGlZejdHd1RsZVM2SVhJK0k5QU5WeTVOZktEaytpSytx?=
 =?utf-8?B?b3FTL3V0dFlPeWVYbEhtMGdQMit4aTNQWWhmQUxZaFlCODc2WHprbXRobkxH?=
 =?utf-8?B?V1FvMjN3U21Sa05ORHpOdTA5VVlXVGZaNHdNNU55ZnZKcFVCQTczK3crSFEw?=
 =?utf-8?B?bG5Scm5uUG9ONnZBNFpxMHhNS0ZjYWpJL2hIYkt1R1NpQnFvM0ZoT09BVjFF?=
 =?utf-8?B?TEFYa0FsdnZZQi9VWjE5Skh2V1FPMDhPRkI3NDVDei9WcEdoUTk2NmZLRTNr?=
 =?utf-8?B?ZjJQRUlFNEttOHRqN04zMHlJNDF0MC9ZU1pMbGVSeVd5bmRtYkFZU0JWemVC?=
 =?utf-8?B?QmRhSFVMNU1uMmxabUJ4T1JoUVlsdjQwMEhOekE4WGpTYXRwZ3pJMlgyMnND?=
 =?utf-8?B?OE10WGxBN2NiNmRqRGNkcTRCNWFZVTVDd1VkY2FSUE0wbkpJZkdObnNkdjg3?=
 =?utf-8?B?UmowcURINHpaNEx4dG80cjRlajNvQ3ZjYzBnQWNwS25IRjAwRFR0TE5VZ0Fy?=
 =?utf-8?B?T2lmTFpyd0VkRHNhTHpmdnQ3UCtSRWREc3dhcWtpY2FJVkMxTFVYT0RUaUQ3?=
 =?utf-8?B?QWV6T25NVlo4VmZjUXpGbU93MCs4QjRSVjhoM0V3VERqRStSQXcxN2lmeEtw?=
 =?utf-8?B?dEJGa3NMZlY0aFAvQWVUNkFvaTZLRUZBK0IwR3REZGUvekV4YTRWSWlueWZt?=
 =?utf-8?B?RXI0S00xK2hlSDdhcGNoK2FETXdYY3laWGFtQ2l1NCtRN2hZR2UwQzlVcW1a?=
 =?utf-8?B?S2FKSE1jbHdSdnhhdlRqUVQ0MkhSYjVzR08wUWYySk4wNGIwZnpwSWd6Uys3?=
 =?utf-8?B?em1PUDl0QitMZElFbS9sOGRad01nQnhobHI4clgyNEhxaUtnMGd2Z2Z2RWZY?=
 =?utf-8?B?bzhXVElBOWs1c1NzbFowVTFXMlZEajBKbjgrSGFzeldaWGlFWFUrZUhZVXRV?=
 =?utf-8?B?OE9Jem0vc29sL1IwMC9DQ080dlpBZ1NTc2hlL1hJZHIxT2tDMFdSb3NrMnJZ?=
 =?utf-8?B?MWhmd2NEU0c3WUQ4OFlzbGtjZWc5dTQ2bGp6RTV0UlVtSGxPUWsyeGwrVWtN?=
 =?utf-8?B?dDVRWldhU3o1OHB1MVRuWk44dm9hWkwzUVRaMHZNSEFMN1BXMkJub0thWDRo?=
 =?utf-8?B?aGdzdTZTWEQ0Umd0REJvNjQzN0l2OWxRRzNsNlhkbnNQc2I1anhpWXJOaUNw?=
 =?utf-8?B?VzVNR0cvMTVDNGljTllTakFCUUQrZW55amt0OG5ITHZxOWREcEtKanRjaUFx?=
 =?utf-8?B?QUNiS3JNL1llVzA1WDlUd080blJWYys2Q2llclZjV0o3Vm5qSStxQitjZUVj?=
 =?utf-8?B?N1pTejhSV1lKdUlsTHNIeTMycThHeVlVdHNmOGwweDFFbHN1MGw5cFZCcm55?=
 =?utf-8?B?MU9rRnMvcWw2MEpGK0JOQ2MvS29iRG15bnZvYXNGUE9tTG9LeEVpc1lSakZm?=
 =?utf-8?B?RVlnV3REL1gwdHJHcmlxK2Z4bEQ5TWJVV0VZdzRENU9DMEkxV3ZjblRHSkt5?=
 =?utf-8?B?d2ZZRzVVTzlUbUs3T1hjekYzUnFyaUo4dXExUmwrU2dpZld4SEVBMnZiUDJK?=
 =?utf-8?B?dWJ6bktvbkNiSXo4ZG1yVFV4ZWV3eC9xTUY0bFZuM00rYk1oU1NJMmhRN1Jj?=
 =?utf-8?B?b2lHU1c3MjFPSmMvVU0xR2JWVm4rTHNLSGFFZGdLZSt4Vm5BRzBrY2pFc1Nq?=
 =?utf-8?B?cVpLczhCZVRKbVljZzFFUk5hVkgyNktocFFGMFB0WjFNQXJwRnhpSG1EK1hy?=
 =?utf-8?B?bm9ZSG5iNXIwVExOVG14N1ZZVGpFMjJldGdvenJPRm9NN3Avb1dHbWNJYzM5?=
 =?utf-8?B?V2tOdmdKSmFoajZtdk1pWlB0WnE1UzRHTjZOMmxla29HVHVDcXpKdWRaL3M4?=
 =?utf-8?B?a0xMZk9oYkc0TzdTQnhmSDdSLzhUZDMwbG9jN3dnbWNKemFLTE5tLzdORVZj?=
 =?utf-8?B?S0VjNktXZm12SFFVL2RIL2w2YTRGN2RhaEN2Y1NiQU1UTERuYTBvb1dQWkJG?=
 =?utf-8?B?bCtQMk11WEliWVhtOTBrRDl4WUdiTDUzS1JBYU1ZclhDL0VEWjkwcUlmMFpK?=
 =?utf-8?Q?MHXz7Y7qD+zsieO5hdz+q96QG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fcf582-b185-443e-4e88-08da957e57ca
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 11:51:50.2796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNABLcf9XIkEEko3g8K2ysxsr7o5MJtEDukhmXfnpFJdAR7TTi7d47btWl2qb3oMLXTNMXFIzjZna7yHliDHTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8908
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2022 12:37, Lee Jones wrote:
> On Tue, 30 Aug 2022, matthias.bgg@kernel.org wrote:
> 
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> The file describes the scpsys node for all SoCs and not only the mt8195.
>> Rename it to reflect this fact.
> 
> Actually, this is fairly typical.  Same with actual drivers.
> 
> Both tend to adopt the name of the module first supported.
> 

Well I think that's unfortunate as it can create confusion for people searching 
for the binding as well as people adding a new compatible as they might think 
each SoC should have a independent yaml file. For that I reason I think it makes 
sense to fix the naming.

Regards,
Matthias

>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> ---
>>
>> Changes in v2:
>> - Fix id
>>
>>   .../mfd/{mediatek,mt8195-scpsys.yaml => mediatek,scpsys.yaml}   | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>   rename Documentation/devicetree/bindings/mfd/{mediatek,mt8195-scpsys.yaml => mediatek,scpsys.yaml} (96%)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
>> similarity index 96%
>> rename from Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
>> rename to Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
>> index 3737207d8504..1a5901ca90f5 100644
>> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
>> @@ -1,7 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>   %YAML 1.2
>>   ---
>> -$id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
>> +$id: http://devicetree.org/schemas/mfd/mediatek,scpsys.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>>   title: MediaTek System Control Processor System
> 
