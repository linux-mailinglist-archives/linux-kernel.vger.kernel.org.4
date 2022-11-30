Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474F763CD91
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiK3CzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiK3CzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:55:11 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0817A53EE5;
        Tue, 29 Nov 2022 18:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/TlYMBJd4MB9KL9oBu7u3E2N9P56sJbn9gejZwavq3c8d6bLYxiMpCl139pFu9SoT1iuJVq0cN+1U678NgQw83iECn6irHxB+Ir0YN39grCrOaQDlujPRUEh8TnQ3G6UeuP456ljd/crIN5UAPKEt00z+0xgaLeZA8KskMeEy9Yi14OEgQeAnDIFA0152jY3/+yPjvhhxEM1G2XqqY7QKzJLAWQ4xzHf1JseKkW8bRoiPDSYN8vnygRWnHpHOE1kKAEGiC0jWIleT3tn1TAGxUuSJeTCfWhQoBo17gJr7r7H0qKj3mIfRwIj0DxuuGeqSIajZsWeYAcE5Q8BbtbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+/fzu+1gydYwWfTmWU9luchy8b3kOptSpCoNb0V6sk=;
 b=IA+FtZuwT/ynIAJ8Ut11OnJ9FOK4ggDaeHi3H8/bzh/DXVlu389XaMC6MKBQ3uj+GmX1T5LofFQdSWvwGnMK1L3RvQIeU9qDyrj9Cv+I5L50fJJa8bQQE0W7QujMCxt9W5QdkaAIeiBZ+OTZz9aF1PHzO8QxFMfRMqfk9teP0Py8gD5hgRSv5cie7jHEKSMZWscVAW24LkpaCsyP1mDNRkzzTzRY4k5RiG6nOKFRldW3J4bJywcVXh+wV2cfZ7a6TyG+cRpdIrM4LKwnoLsZPfAHfzg2xHlz81ib9u1RQw9+UxOR6Pl/aUy6DNkl0hWv+mqawovDtp4KyiudtwWQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+/fzu+1gydYwWfTmWU9luchy8b3kOptSpCoNb0V6sk=;
 b=qRx2rWoF0i9QXja+LjJZkDLUbQgR90NVwBEsWTFPm4dvVd1HN9XDbhBjWDjuXJkNHFeUQlYuR8eXI1gh2tUgywfkJIh7U0wIBTRQjfoAP2/Tqn55opR10TRR6tgpdMN1Npp5IseIzFEETwuEKdg+u5rFlqgVKPEjdb5E/XRuhLPS0BiU5tBcjNbuR3AsBzr9QFCi+D/+Q60et/RBX0HFFaYantkd1rwauHCIYtjPqp3zYEislAwggNdLiI4Pt3Z12bNrlVkh4syozRRDHbGfI2jzB7HA9uAKslUkdlvrwZMg9sQbXB3wlGl1O4QjjF8ptDCdbJmFiXou5SUge+ZFoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 02:55:08 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::2349:ec6b:2442:8c52]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::2349:ec6b:2442:8c52%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 02:55:08 +0000
Message-ID: <95c4dbcc-899d-ca14-22f1-befa66d84a77@nvidia.com>
Date:   Tue, 29 Nov 2022 18:55:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 4/7] dt-bindings: timestamp: Add Tegra234 support
To:     Rob Herring <robh@kernel.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        timestamp@lists.linux.dev
References: <20221103174523.29592-1-dipenp@nvidia.com>
 <20221103174523.29592-5-dipenp@nvidia.com>
 <20221107200600.GA1489762-robh@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20221107200600.GA1489762-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:a03:338::25) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d199b61-b028-4d29-7a8b-08dad27e4a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXGOqX1Y5Rx1PmvABUpTor1l9blxd9ry0LVnBzy5JKb4KmZbrFJ8XLLaxUcDVPAA+LvwTZTjtgmBIM+t+yHGMfPslwoyQXYn9DOvjTLlhghj2HgpwZLgsFyg5fOq5B41aP8XiOXukrzs7yqNv3+q05JtBvxrsWbAzuQdODYmIdWiI+sx742zGggpf3wKSjRobk3rCU3BoMgdWoepcKh7lArWBmzptzu0714YcY3pHNUqUvHOPyoWvd53uL7/dX6PZ8lZ3ejlHg5+u7T3G2imoEUxVhGTs5OetqKhunW0xU8LyHgVfhTMrVx9djUOz95CYo6wnDIVpit3kof2Q3NVvWLYcpGyWUzZ4TCBz5K9eKDuhOeXQg1ukrnOtP8pFCp/WjPT/nk/V5jayLnUbOcLQW8RjiGL9GzRFPcqMMq2rskISI40RrH2sRzUtkHqR4iocoT2gSkahrhOrTgqrMZx7rLFLD1xQed/cZ7l4c5fgvTa5dGqOhVnfZWincH+bIC4xOMG3c3ghJB5/BkJ7XSoBf63AIv96T6JKMzpoWOe7y7A84KkXwxuEm18Glw/byEseJO6qVns0g7da3MmktXhme/H9GM0W/68Kk+0rTcVrYhEdLejubl0ZFd5rqHX82XikOj+L2b2Dm2FxKveXQLflTPJ/oPwxkDMdlfR786k7pAvIIAeSTBshvZ/RM2H2X/0z7mRUTdW1v1HWox63iIOOjdApyf/qy0CiWTbtF9zMzPad7gGbjCcEOyv/uSjxqoOPNnNYg7uGyDTMg4mAN0zTNxW+PVb0sqb7ik64naWYoXfAaYYU0zuKEujldg+ewrAFwnhgW7rse6Z3vraSwHXJheoFhz5gWtyzchLPJhHp4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(66556008)(66946007)(8676002)(8936002)(66476007)(478600001)(41300700001)(5660300002)(36756003)(31696002)(86362001)(6666004)(6506007)(53546011)(83380400001)(26005)(6512007)(2616005)(186003)(38100700002)(6916009)(966005)(6486002)(4326008)(316002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmlpN0JMNG14dnR4Y2xoMWpKQzR5NTBQMDVqOXpTN1FvZHcvME1pUWF4VUVx?=
 =?utf-8?B?b3ZwV04vNEhNbjdoRXNUVExHK0pyenREZVl3TDloSjdJQU84K1VsdmhWVkF0?=
 =?utf-8?B?cTZZckY5L2RsZjh4V3pBN2NXTUJ4UnFDYWRYVTNnbThuWktBd0RBTTJadDBs?=
 =?utf-8?B?ZEZFNlBDYlNvNXQ4WXdJS1dRb2d5R0pqNWRKbEo3dm55OHRHS21pTkZaSGRs?=
 =?utf-8?B?amlVdDBLT3lQWmNhZjBIM094dmRmbCtwMjUvL3F1M1J1T3V6UTRQWWpBbFo2?=
 =?utf-8?B?MFpZTU5CQVZaTXp6MWNMYW81dnhjNjZVSWkzb2tRMEZPTjdhNkZKY2ZyODJ6?=
 =?utf-8?B?TndKQTVBdWZjRGR2dnBOTVo5K0ZyTjErcUQrbEl5NVlNaVFJRDdSMmEvNXVa?=
 =?utf-8?B?VGttc2NtRXdjLzZ0RXRubGhTWUpGS2w1aU9qWkMzUmlmYXJjU2s5NlFFNmZv?=
 =?utf-8?B?QTZWWkFOd0MwYVVQNlZzN2dUN3dVSG9McjMxVEdxcjV2ZWFuSGpwTXlqcHlN?=
 =?utf-8?B?V0ZRbWJQVjNoTGlqelZ1QlNkZzlxMnkxRTNRV2E1SGcxSEhvWTdsbjIxZ1hy?=
 =?utf-8?B?bmpGd0tTWDBuWmRvTS91WkJRQWhJOWwyWFh2dWhJQ3J2M2swNm5zNUhSbmNZ?=
 =?utf-8?B?Z29MbG1jMVJwMUovNXBiamFkWTVDV0djaTBnZjF1VkhEOWJDdi8vTE1iQlRU?=
 =?utf-8?B?RjRJbWx2cTM1ak55K3YzS1N4eFRtRUJqdzVLY1VKSDlSRW11UnJRRHZqN1RD?=
 =?utf-8?B?Mk1zUTJ5R0J5NWZJbHpONEtNUXlLL1pKS2tpUVEwb0FMdERzLzQ2M0tCNjRG?=
 =?utf-8?B?a2EwMTJDeHIwNVZKL0VwV3MvTFFJUzZiMHZ1N0hUU0VuNlZGQ2l5UjFRNVg2?=
 =?utf-8?B?VjVkSUtyclhuMm5ZblRQZnM0M1BoSzhoeEplemN2ZXBzcTkzT2lvOEhmTlBr?=
 =?utf-8?B?aGF2TkorMmlheml5Q3pMM1dVaDdraUQyODB4a0JRd0VtYmVIS3ozaHVoWFdT?=
 =?utf-8?B?ZDIvYWlmdURvVCttOS82eHE2OTdQRzIvL20xWnNCdnl6OG94TURNMkRwdlZV?=
 =?utf-8?B?UWxEYURKelpYOXU2L2s5aS9iNGlJcSttN09OMjhUZ0srRWkydzl4QnNFNFdI?=
 =?utf-8?B?dnVmcDd4bHRhaFM4Y0Q2Z0NveXZHdFJmSi9PcXN2ZzNZNGxmOEZMbjlPV2Ny?=
 =?utf-8?B?WnJOdHBoVVB4VFQ0SmZ3NTBnR2ZCK1haS2E5VjEzRGRZK3R5ZWw1QUNHTWhk?=
 =?utf-8?B?UVJDWGhUcUNaSmRzTEUrRWkvbkVQZTFGL1hrNlIvTlFsVE9wWnVJU3ZWU1lu?=
 =?utf-8?B?cTdVSGZNZm9tSG9aTzNYSWFZK09xZWZRWklSTFozc2xDOEorenM3V3RYcDJS?=
 =?utf-8?B?RWFNUUVna1FhUnBxb0xQUkdXWWdPS2tpNy9mMkk2M3lCVnNHMjlrUXBCbTE2?=
 =?utf-8?B?T0l0aFh2Q1JzVDVRMy9JNHBIWkU5eWd1Nll1OFMzZUtFdXZMWlpMcnNwaldC?=
 =?utf-8?B?c1E2WE5CUFN2Rzh6OXE4SHN6TG1iVUtBeUovWCtGdVFlRHVzODVwOGptUHcv?=
 =?utf-8?B?U3VvYXJEa25HQytLWlhEQUxXWGxJUHRkVVVKcEVHZEJNcmg4OU5TUUtMczNy?=
 =?utf-8?B?cWdMNnR3NjlXMHZhZVJ1SlJ1MGhjd2IvOFowckVPRmZXTlo0cUwrRC9Qb1hB?=
 =?utf-8?B?dlJlUWZQUDhrbzBKRFk4SlNHMThFOU84QlE0Q2YwTlV3c1VsU1o1RDZHWEE1?=
 =?utf-8?B?RGJMUmYxUUJxczVCcWpOK0gvbyt1ckJzOGNLbHFlMzAwRG5iSEFTR0tTckQz?=
 =?utf-8?B?Rml5ZmlJZ25vTEZubmg3S3grRFVTSExCVXk2WDdkSmEzbnR1UXpjS3Z3dEpR?=
 =?utf-8?B?WldEZ29LdlZxc3F0anFZK0FRaFZuZDBzaVg5MklTZjZWRTZoYW4wYmFzbmZi?=
 =?utf-8?B?TmdsVHE0SldIMW9WalVKN1QrdEhvZFlWV1NweGE1ODU3STdiRnlLZXRmVCta?=
 =?utf-8?B?b1MwcVhzSk1iTElVK2xxNnJYZExiNmk1c3MxQmE5d3VkcW9NeEVHWkE2aFZh?=
 =?utf-8?B?RXkvZ0FzT3h6Vmt5RHhhdU5SRE51clNWU2hNMWREbTlKZitKVVlSMm9zeVl4?=
 =?utf-8?Q?7x4L8LAfXYWHRXp8VWiycWyQJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d199b61-b028-4d29-7a8b-08dad27e4a5c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 02:55:08.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+1ceVHqUQ0ehSkuMSKwoRfMZcuXbG4rGLFH35vuSfqdTpUIvrIs58n+PVmL6F40ssLBs4urbUx70os98yhxag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 12:06 PM, Rob Herring wrote:
> On Thu, Nov 03, 2022 at 10:45:20AM -0700, Dipen Patel wrote:
>> Added timestamp provider support for the Tegra234 in devicetree
>> bindings.
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> ---
>>  .../timestamp/nvidia,tegra194-hte.yaml        | 44 +++++++++++++++++--
>>  1 file changed, 40 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> index c31e207d1652..158dbe58c49f 100644
>> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> @@ -4,7 +4,7 @@
>>  $id: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  
>> -title: Tegra194 on chip generic hardware timestamping engine (HTE)
>> +title: Tegra on chip generic hardware timestamping engine (HTE) provider
>>  
>>  maintainers:
>>    - Dipen Patel <dipenp@nvidia.com>
>> @@ -23,6 +23,8 @@ properties:
>>      enum:
>>        - nvidia,tegra194-gte-aon
>>        - nvidia,tegra194-gte-lic
>> +      - nvidia,tegra234-gte-aon
>> +      - nvidia,tegra234-gte-lic
> 
> How is the h/w in this chip different from the existing one? I'm 
> assuming it must be because you don't have a fallback compatible.
t234-gte-lic has different slices and signal lines it can support. t234-gte-aon
has again different slices and more gpio lines it can support and has
different GTE-GPIO mapping than t194-gte-aon.
> 
>>  
>>    reg:
>>      maxItems: 1
>> @@ -43,9 +45,8 @@ properties:
>>      description:
>>        HTE lines are arranged in 32 bit slice where each bit represents different
>>        line/signal that it can enable/configure for the timestamp. It is u32
>> -      property and depends on the HTE instance in the chip. The value 3 is for
>> -      GPIO GTE and 11 for IRQ GTE.
>> -    enum: [3, 11]
>> +      property and the value depends on the HTE instance in the chip.
> 
> If this statement was true, then this property makes sense...
> 
>> +    enum: [3, 11, 17]
>>  
>>    '#timestamp-cells':
>>      description:
>> @@ -55,6 +56,41 @@ properties:
>>        mentioned in the nvidia GPIO device tree binding document.
>>      const: 1
>>  
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nvidia,tegra194-gte-aon
>> +              - nvidia,tegra234-gte-aon
>> +    then:
>> +      properties:
>> +        nvidia,slices:
>> +          const: 3
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nvidia,tegra194-gte-lic
>> +    then:
>> +      properties:
>> +        nvidia,slices:
>> +          const: 11
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nvidia,tegra234-gte-lic
>> +    then:
>> +      properties:
>> +        nvidia,slices:
>> +          const: 17
> 
> However, if there is only one possible value for each compatible, then 
> being per instance can't really be true. I guess 'aon' or 'lic' define 
> the instance? That's not normal practice. Are there other differences?
aon and lic are gte hardware instances but meant for different signals i.e.
lic is for interrupt lines while aon is for always on domain GPIO lines.
> 
> It seems like 'nvidia,slices' should be implied from the compatible 
> string.
thats true, assuming we have all those specified compatible strings from this patch.
> 
> Rob

