Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574F75FDD28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJMP20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiJMP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:28:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532F31ED7;
        Thu, 13 Oct 2022 08:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8+N6LQsZih5Tw+JA1jy/CUMcXD3ur4o9snLH9Z3eCRBXqQNCZS4SLry6WPTcfkAcNbw6iI6oQR9p0Byo4YyzweDmiV4BonHNg0/4w32YBIk5ku4mUAX+6luQ0geiL8OPVsaddHtD5d4OaycPdPsoQpui2X1d/iWKeZgaeMExB5IeuZ2VVeqHK/hbZx2XxWvWeG1ecCFilTuy04L5X7Qqs0osGGkkDu0WLUL9dw+cETgnPrk55NAYxTJgngcnd1BqcKK0F7I1alSHHLOvF+Pofim8uQXM2EUoFjKgiOrjU0BqBFjmaFRI8RHdavLIboyDDSL1nYe2ZKplw1lIbDZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXVyNTgJ7mk4dWF40PobZAnLV6phuqJxuH2imQxYSSs=;
 b=gp9B9zKot0UknQKuIYuBe/gzwbCv0Z39IvGqd859GIY1NDMgtkM3TxsfkiStWZZ2cQUy7rUuZETz7KY0x25NBACB71ydETta2n7tesbePnbcMuvxde4cEwpoZ8Kz81b00Ut0M/cejvw4eIsMK8eawlLM2lWQ26QHfEL5TCQyDgzeR/GaXiLgQwaCCJrUbkoZOFsKDXkbX7/jHRV/Sean1X0QSG6tRqUBxg2QEe6wuJFjlTZyH45CWjfkd8gUYtEoLdipIDIzo0PNIEoakv6QtSc4HTRF02JsPZBQWBlAmoRiRgCEdbGXNZTG/7+Y5Mltu67Ez6uYVAt8qUqm/ayJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXVyNTgJ7mk4dWF40PobZAnLV6phuqJxuH2imQxYSSs=;
 b=U7AfohZZH9zcazahz1p5bbgKNOahjt6UMNfdw/IJ4Ro++3pyryN1Mr8lgxgsQ6uMGh73PUVq9dQQlPFAzZUHUIe0Pfn3rUxxm5/PJEypPT35Yfn02UOicUr5kUBXCbJIZC/tCkrM1PMeGoMyvYb6S4nGeKXr//VipQgEVrurrd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 15:28:19 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::d395:58e5:effb:1b75]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::d395:58e5:effb:1b75%5]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 15:28:19 +0000
Message-ID: <13dd0380-9195-7a24-fac0-e5978393b1ae@amd.com>
Date:   Thu, 13 Oct 2022 08:28:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH v10 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221011212501.2661003-1-tanmay.shah@amd.com>
 <20221011212501.2661003-2-tanmay.shah@amd.com>
 <fa60ba81-6cc7-7f78-55cc-9ca0053336b8@linaro.org>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <fa60ba81-6cc7-7f78-55cc-9ca0053336b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::17) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|BN9PR12MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa7190b-7b7a-4bc8-5c1d-08daad2f8e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIeUT9riEE5isUmcIXVzp4xrD/+ak+pzlazjM5kYHVOcAcB6FImW1Rj1JFOhT+R5CS1UhLYVYL6ao6yfO8CGDSFwsH82422g5NB6CS4dmRoceB5+RbTSjX/f/1A487QWR6omYaQ07BYbzkh4esZeXF8M5Yjb5cGsRngSKc3zXavxCTkfmobH3Mthwm9qs80oo9m3jsyPVqXGXHD0HX4sYn8xJIt+flXB3Jqmo9ooczZd1oYciwWLsaFR3T6b+q44aCHXIi/pnYdZHxXaki36xwF7cxtjUp7vjyISH7xFvshpAK41IAi5epD1BdVYNYAgucPw5Y9A66defV1HIqa8nBXldqXZiq1tcph5AeoFTFMqMTWoSgg6nHz/rH+wnNpHzjpqjxLIHLDOhn8oSmk1iDC5hT7sXSJplNzP0dJ9lEi+48EcEuIOZYdKqDfvOPQurXhc8Weus+iG6H5F/kpr4PA0+fvKEbEJ0ytii3Y6WjqyX895JKaqrDZUqYwlKjDrSIqxO5y29a+MkmOdjmcdG8ScKHnoigtSl6vUHlgl6UZ8VF11xOAdU+bqqnvR67fyokVH+bPjSo1ML2L6huUw/BjQ9SnShfchgilk3Zj5aQ/tzxe/jgInVvVZBK6RK9jd3C++/xbxaQHp9lO8OSQ7U/vIg52fCA8f8MvbjbHeLgo6VGvM0q96JsOiCQ0BcbeObZ5LYAza1jzvRynWpN+RAhI4LA7DayzgMJ+qoY9KT1sIi9MNQhmGxBtUxcOlsbzniUxtIGmnhTqv4EVC/kc9170U4oQ5X1EcbAmnK72ahXdiyp6Dmbg2VlE8R0g2lGTD+MZOa6ffBhnHUmWsHxTGBo/KfeaPL2qalZTEh2MbikFHyqTtsGHj/QFsQn3W+bJ9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199015)(26005)(53546011)(36756003)(31696002)(6636002)(38100700002)(110136005)(41300700001)(6506007)(4326008)(8676002)(66476007)(66946007)(66556008)(2906002)(2616005)(5660300002)(186003)(6512007)(8936002)(316002)(31686004)(478600001)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmN0MGpTZVZDUFQxUjl3QjFrQlVBRFBkdFJmNWFTRXh3amhQcWN6Rm5qaGM5?=
 =?utf-8?B?R0dEM05MQThCV0dGajFUbUE2Ykt3bGRvcVdwaTVlNE1LVlI1WExKVGR1NTEw?=
 =?utf-8?B?Wm9CQURpY0FJTHE0UytwL1hwdUhySjRXV2FQaU5Nc01xMjM5QUVEQUY4bnY0?=
 =?utf-8?B?YkErcTh3TVFMdU9ZSmlLbU1pOURUdlhQYnZxM21iTVFUSUF2TVNOa2lVSUJJ?=
 =?utf-8?B?Ni9GOURYTnFxNVViMHlUQ1lLRldoT1VGMnd6cEJXTThHbEJtaWl2ZWFTQmt4?=
 =?utf-8?B?NDhJeDVUbHFDaWYvSDZ3QnNOTnV6U21WMXRMcWI5RlYvdmRzbW51VGVZVXQ4?=
 =?utf-8?B?T2lGQkxNczdidjh2TGdIWjFFSUFLNzY4Qlk4UDJUVTZvYmlrS2dxL0YzNmti?=
 =?utf-8?B?MEdwNjFqOEZobGliRXBmQk03MXAxNTBaY0prdVM3SzlNLzlCUHlYcGRsNERS?=
 =?utf-8?B?MW9LZlFkRUpBM0hjNXhJaWtyQi92UVVWckpYRG4rVjRHVFMzbzRhbUhMVURt?=
 =?utf-8?B?T0FsSFRVTkFMcjVvQ3J3dHFjc2ZybWNtT3ozRkE5NzFwYzZ6eXJPNHVSaU9W?=
 =?utf-8?B?aHFpYVBPRk5sUTZFK0pudE9TeGJWQWZHQTFZVEwvQkkvamowVFU0RU12QkJ6?=
 =?utf-8?B?OWJXU2F6R1A5T2xEamhEN1d3dUVwZFRJWm9TQzJXVFRTRmx1d3RvSXg4dHhO?=
 =?utf-8?B?MU1ZU1E4YTdoQXpVNkpnSlhia05sR3RMYVgra1p3OW9ZWmN5YnZsMjRKNXBF?=
 =?utf-8?B?VDdQWFhEMXVNTGMrNE12TE9BRC90bjYra2VPb2JqRU9ibERqVTBBWko2TGY1?=
 =?utf-8?B?QXBRNE1uL1RNM3ppYjQzbU9ZajUzREtxL0xhczR5T2NleUFNQkx3cTM2QUpY?=
 =?utf-8?B?Q2JZUzBCKzFkbTN4VFRuSFYrbEZyVU5pRENINStOazFoUEQ5dWNLYlJNZC8z?=
 =?utf-8?B?ZnJSem50VUhEZ3hQaTRaTFJ3cElrUEVPY0E0a3RnaUhPZ2dKcTNGRlFyRVhu?=
 =?utf-8?B?N2x2ME1qaGJmbE9lakhJUlBaWlRWb1hxenBqemxjRnZYdmdpR0UwYkc1dmhT?=
 =?utf-8?B?OGl3Tlg5QVB1RlhtK0x1YnlmUk4xM0hyOUxxN25WOUJPMjI4VGRYdzlOMm1T?=
 =?utf-8?B?Q1RmZlR0Nks4aFh5ZVB1UmdmZVZzNm8vbHl6T3hMTERxaTJsTjdwUEdOSTl3?=
 =?utf-8?B?OWVSc25OeFdYN1JUbnBiaDJKdHRXSkQyQmtxUmJOYndtMlR6L0VyTldXNkZp?=
 =?utf-8?B?QkIzcy9JTzM3a25UMmY0Y1c5SkV1aXJvb2hsUFR3RUNWZ3FpQTI0WXFMWjd6?=
 =?utf-8?B?UUtoYVNMclNtOWJuK0YybkE4RVpvcElvWkJGNWdzTi9QRnViQ1luQ2MrWHUr?=
 =?utf-8?B?NVRoVDdrYTNTc2ZYanR2SVhlSjBqZzd1d1dTY1M5akQ1OWwzQ09oZXgrWUtY?=
 =?utf-8?B?Vi9raHB5S2dMVTRwWEczeUk2b3JVYXNYR05LMzZyeWVoRG50V2puRUtBMHU1?=
 =?utf-8?B?WHBQd0ZndmdnWlRnMVVMSktnMVZMRTBmbER3eUphekJEYXp2OElJb0ZORWw4?=
 =?utf-8?B?bUdtQnFlUENZd01CcjQrNXRENm9hU1RIcFlBVjNtdkFkK2k3WnE4ZElHbWZW?=
 =?utf-8?B?Z2xIbXVOWWswenAwbUFuQUpTZkpsV3VvRXVCMnp2Mis1RDNjZ3FhdlVBaXFS?=
 =?utf-8?B?R3hBVzgvL25mNDdXdU1jbTJ0cVRtbzFwTEhSZlpCUzEyRzRoV1gzellOb3pk?=
 =?utf-8?B?ZUE2b1VNVWZSV0IzL3Z6REh2TFp6V0lneUZPc0phaVNHRVZwOWJrQmRxYTc2?=
 =?utf-8?B?bEppY29BVWxjZTNzNk5nV2pCU3BpaGh4OFNqUGFPZmtHMlcrRTh4Risvdk9W?=
 =?utf-8?B?bVBXNGJqMUtKQmRKWUp4d25EZ0JIWlI1NVgxamlMb0dZRldVNzNzVFJQYUE3?=
 =?utf-8?B?VjhpYUJzY2VqTFM2NXg5MUNCYTF3bUsza3FIWU1QWEF1ZFRocUhsMlVjUDlk?=
 =?utf-8?B?cnRzMUl3QmthcU9ZODVIV3pYNHlCOXFqZmU0L3FMdTBHMlBMTmQxdUtZQ3h1?=
 =?utf-8?B?Q080WG9hWHJRalhlRmRldnM2MHhpaTRkWjI2SG5aQW5sY3pNQ0FEQjQ2dlhj?=
 =?utf-8?Q?NxssptDIGXONejtJjtrkveG/a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa7190b-7b7a-4bc8-5c1d-08daad2f8e5a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 15:28:19.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sewxs9W8isEfwfZWOgCAX6Ake7HNvnU6AGG/b0amdeAXUrsjDDTol1eiXQBLMh8A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/12/22 8:29 AM, Krzysztof Kozlowski wrote:
> On 11/10/2022 17:24, Tanmay Shah wrote:
>> Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
>> Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
>> (cluster).
>>
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>
>> Changes in v10:
>>    - rename example node to remoteproc
>>
>> Changes in v9:
>>    - remove power-domains property description
>>    - fix nitpicks in description of other properties
>>
>> Changes in v8:
>>    - Add 'items:' for sram property
>>
>> Changes in v7:
>>    - Add minItems in sram property
>>
>> Changes in v6:
>>    - Add maxItems to sram and memory-region property
>>
>> Changes in v5:
>> - Add constraints of the possible values of xlnx,cluster-mode property
>> - fix description of power-domains property for r5 core
>> - Remove reg, address-cells and size-cells properties as it is not required
>> - Fix description of mboxes property
>> - Add description of each memory-region and remove old .txt binding link
>>    reference in the description
>>
>> Changes in v4:
>>    - Add memory-region, mboxes and mbox-names properties in example
>>
>> Changes in v3:
>>    - None
>>
>>   .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 135 ++++++++++++++++++
>>   include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>>   2 files changed, 141 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>> new file mode 100644
>> index 000000000000..8079b60b950e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> The convention is to have filename matching the compatible, so:
> xlnx,zynqmp-r5fss.yaml
>
Thanks for reviews. Sure I will rename file in next revision.

>> @@ -0,0 +1,135 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx R5F processor subsystem
>> +
>> +maintainers:
>> +  - Ben Levinsky <ben.levinsky@amd.com>
>> +  - Tanmay Shah <tanmay.shah@amd.com>
>> +
>> +description: |
>> +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
>> +  real-time processing based on the Cortex-R5F processor core from ARM.
>> +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
>> +  floating-point unit that implements the Arm VFPv3 instruction set.
>> +
>> +properties:
>> +  compatible:
>> +    const: xlnx,zynqmp-r5fss
>> +
>
>
> Best regards,
> Krzysztof
>
