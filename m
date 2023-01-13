Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78FC66A19B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjAMSMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjAMSLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:11:22 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C9F857D8;
        Fri, 13 Jan 2023 10:04:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJfrDvYMWFqex52NumWE/EDd1Fsxtcxmxiy75PIxA0HmItCe7CDRLi75jxwVgyXlCZgeG+r8+pGf3TmzBkevzG2ypOvyDu1BpKd0ORFeWJPIjgQMG0g6Rqh+JKr6PYPvomL7W+5+aXAGWq2wOnRhFZaLy4FC3evBMrKdhGD20O0iITOq+Si3kvZHgDv+4Rcavn2QN5KX9Guxpd4qYrCWM523ZiFkh4TdjOytQItv6/0EpHqJQvOqLzhEZTZbuiUbTmMkxdV7PfkZX6YpshuFeCXoLHUs5FVIrkkMSEVRj38swl7ZjvA1oFAYdci9U2BpZPhwX3dwS9OH3z0Tpvccgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFcZDFEeKtMD8aP1IAx3TNYzM5xB/12M04De5nVoWEo=;
 b=hlRxj4s+mrE/Px24vg22asQSSzcC34tbt5Ku+qFNTpjRT7IdR1dNG5KDoDToVHUXnM2WLDMPEf2XvBhhQxO/1+H+mCVahnRXNHXcIYrG4aO4yTQ2hOh4+gSwRgj3eFZ2QhSunXWhujextXvfx9LDfWYFvx8z4NDPuah4bs3H+7SmVOrwpTOtXxI//xt0YbjgPCl9+RRMy9ju3aEKW6CV2B6QY0Q9hiMXc8NqzQeKKoozSANbsgOcAgK1CB5KNy4oWkf8Lz8oC76wDVs5BiJVkHQPsSegtcz2ZZZeVc5vEe8vw6vUztvpPSRIydBEJu3bhBHLNt4JVb5Z7TWCSxbGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFcZDFEeKtMD8aP1IAx3TNYzM5xB/12M04De5nVoWEo=;
 b=Z+uWxrBIotkU3RYKHd/VLDBXf8k1bdXZ9JyETR6rOiMiOALzJ8FDwNnGd5Cs3PWZdfyaF+UMSmeP6UeNUOwxWlmiiDmgxEUouu3LqMJ6nvuaf5liBOziiO9Cn5YzEAFrMAGGV/qIjZBOCNBKPezY/dQkzcOXtWy3jNsgxcfMm1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 18:04:06 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a%3]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 18:04:06 +0000
Message-ID: <e675a037-3c07-a8bb-19d4-781ab881c920@amd.com>
Date:   Fri, 13 Jan 2023 10:04:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Thunderbird/109.0
Subject: Re: [PATCH] dt-bindings: sram: Tightly Coupled Memory (TCM) bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20230113073045.4008853-1-tanmay.shah@amd.com>
 <df4fdecb-6ca7-d96b-bcad-02cefb52ce4e@linaro.org>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <df4fdecb-6ca7-d96b-bcad-02cefb52ce4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c5416c-cd31-4f24-54b9-08daf5908f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+OLF9fefesDTiMx+guigSyl7Dyvk+oHrQaLVfEjXdXfukKmuJ/qmJsI0NPUG9Pv4OZZAxzVLz4tVLzuBvRavFS6aCxz6hKGeIF1TJ0gwaPYy4reHmAcHfOovx7wmFM12b/9Zumhr/IR0/bgqp3+pt79uKfqpK/hKBSxoKJm6wt2/gJHxX9oahMl1ZKBeGA5jAaFjSf5Te7B8NWf+/Uj0salZ3+GBeGlB0ANA75N1dKNqxUXxiPwJ0d1/GyNLVS+g1KYUjSzDocWThuaKt2L6JxjlbCWCAsO5M7Aw2iGlOlQ4vBue/l/jDlb9vQoXahZBQRsnx/hiVUamyYXbUnVSeDvobHOG1dugzLGBoYUWV2CGpIiLtO+bVD7x3L+2brUxrlocwXkn1YqHbPHs7oU6C08n8LY/V3YfRU8YVERz0ub/IVbg2uVYcgYadL4T3Clsx3ODWo0frP7j+iKTNqzQcOeX6p9p+uOQME1Fy4WwfBdjCf4q6H8wbrGsj5gr7KgvHKP1y70sdkLWykjDMUrtxIc4VXLH5etvr+Wr5kzFJ3exr+2d16omHA0OHLsYGL0EfsGxfs3FAzDGwfUFFwEwn0LD9iNXViePd6bkWERWsL5jhoy5qqaKW3Pdu74LV7iSKdUZr73uI5dOtbEJ1WnKTLE+y4oTSvFyS+AvMkSS8l/ByBs881WQyHYJwYIU3edfeCVFvkUKbXrpyaJhmwGNHRR+eBmrE8xv+fwcnBz9eRDpPht8m144W2HsjNo7T1ZyEF0yeA8WpTimfO7j69vkpPUeyP99otAhMZfdEtkzh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199015)(31686004)(5660300002)(8936002)(41300700001)(4326008)(316002)(2906002)(66946007)(66556008)(110136005)(66476007)(8676002)(966005)(6486002)(478600001)(38100700002)(186003)(53546011)(6512007)(6506007)(36756003)(31696002)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVRUcGh1Tmwyc0QwUVM1YlV6N3ZtdmZNSjVUMjVxQzQ1MmpRbVFCWlpTc1E1?=
 =?utf-8?B?MC9ob09MNUZnREFqdHF5cU4rTjlPNFByWEc4RmtjMld1bytNUjhqUHljVTB0?=
 =?utf-8?B?aWVuSjlKVUV3UGZnbnRoa094cGcwLysxTHZ6d0dxYnBUV1pHYnBncnhKRWcy?=
 =?utf-8?B?QnJzV1dHODZ2V3NNNm8xcUhOaGUxbjh3UlVFRU4zY2dnU1A4U3ZmMmV1LzVr?=
 =?utf-8?B?dk9jb28xRFppWmN3ejEyL241NTI5SjhjM3JKQjBCbElwWExPUURPMDJDWlJD?=
 =?utf-8?B?UUVWWlFVUW41MXJSVVhucklOSWUwaDk0R2xIYWxSeE9vRjlBTGRsOEYrRi91?=
 =?utf-8?B?YXNhT0FITlZQazRMdWg2MlYzcndmeFBlb0pZL0VRUENBdWlweTl0RXo2enU5?=
 =?utf-8?B?RjczdFlHNzBtaVcxbFAreDY4ZS90M3lUS2VtNHVhQ3J2UWF3NS81YmdsL0JD?=
 =?utf-8?B?bzlKZUxLRnZLTllWMGYwUDJ1VFBWZW10VDAvQUMvQ3JPRlVKdUlzdHZYajJ2?=
 =?utf-8?B?SUhwaHducjB6dWNNN29rNlBwNlViMHdubUNmR1BNRStuUkQydk5mU1hRY1VI?=
 =?utf-8?B?QlZxd1ZDTExVQ2Y5c05FcHhrRlpnbDlGNzFhT0M4enMxQVJDNHZsUDU5WklI?=
 =?utf-8?B?ZXBOVUVHQmRwTGFNUVFjUlFDcldiZEFBUjE2N3NsVGZzdzFyeWFDbmZ4Ykd6?=
 =?utf-8?B?bk92a2JiUk15cWgydTZtV25vQjE5Rm9acXJJck9Hc0oxSHIvZHI1WFRtRW9Q?=
 =?utf-8?B?OXpFNDFwM3E4bzhtTHdUbDVoY0tUN3hNblZCMDFSeWxaWjNqczE0OWMzQmpy?=
 =?utf-8?B?K2RxSlRpcFlvS21rOVJ2N1JWSm9qQjJFK3NIMUhoN3RtN1d2YnJKM0x2ekNQ?=
 =?utf-8?B?RWw0ZC9NZmxuTTlQV2hlWC91a245K00yd1Zra2hxc3dVRDBqRjZ2YmpaM2lp?=
 =?utf-8?B?VUxSMUhnRFNIZnJHT3BQMzB5YUZxT2JEMmFYak1ObFpWa05ORUJFYktQbXdV?=
 =?utf-8?B?cFFVc1NXcGVKdGthY214M1YyVWZZWmxSN1dBTXQyL0F2ZE5Uamc2aEZFT1hD?=
 =?utf-8?B?ZnN1S1NDTlYrem1abDZzTVovcFlnVjhYczBQSnJDb2FRNGFtNUt5QWV1cFJF?=
 =?utf-8?B?REtOeHp0b0hvMG56L05xZUtoRXNJejMxeUFVdjlMMXRTYlNqZExVRVVYVUo2?=
 =?utf-8?B?R1RpcU5TWERKbFpDd1g3VGRZYVo5ZFZZbm4wNXRCSGhCZmFPUVlOUFNYdmtY?=
 =?utf-8?B?ckl6NXZOb1MvVmZocTVYZ2JwZXFzbjNxVEJIeFlwcXpwMGw4dnE0RWQ4c0w1?=
 =?utf-8?B?NktidnI4ZWJQL1hVRW8xa2ZxT212bTMyekx3WmYvVURZUTB4dkdJYTRCcDhn?=
 =?utf-8?B?dGVPNWZpUmtWVGh1Zmo5bkp3MlVWZzJNUjhVNjRRUnE1bkhNVFAxanNLTFpW?=
 =?utf-8?B?MWlicytUeFZVRFFidGlXSGYwMjRBMlhZN0QvYkJmSnpLV1NWdGMvWDd0OEZI?=
 =?utf-8?B?Um9TTCs0RFFKWHRXREtsSDVQMFRkbEFhZDRReHBITzV6OVZsVVNhTVJsdEtj?=
 =?utf-8?B?ZkpyYThlVHFhQ1FxeFhrcXQ1QXpWenlZeG1QN2x3RmFjT0diOTNIQzdXMnNp?=
 =?utf-8?B?VWZQVmd5RGlEZTdkSkx2VG5tNkt5a1FZVnFRcDJYZlZWbk5KWXZkSDhIcWc3?=
 =?utf-8?B?b1FYd0ZoTm1TdlVWSmtWeGhHa1pRUnVsTURNUFNibmg5c2pQd3FRRmpjTnpv?=
 =?utf-8?B?ZWJpdTJ1S25YeXQ5ZGpNRmxONmI4bjcwWDUwYTR2RlkyM01LNlZDSHpKdmpt?=
 =?utf-8?B?MlNNa1pLZXMrN1FBWllUa0tpYWhWTlpBVXlBUVUybFhvWjJ1UXhYYjNzV2R1?=
 =?utf-8?B?VTJPWGUrbmMvMlJDSnhZcUc3Ym81dTJVc2VpMytTZmFJZm1hVDlzaUpwL2ZH?=
 =?utf-8?B?eEgzMmJTaHZLdy9YT0ptTHhXVWVQWDRYQ28zL0NmdTFWcXBud0JvVllVWmd0?=
 =?utf-8?B?M3NRL00yditYN210M2pvc0YyUE9OSTFzK0ozWlMzbk1iSFl0MHV5RmsweUdh?=
 =?utf-8?B?V2hoTkhEdkNwUUZwa3RLb2thaXgvc05iU2U2SXYxRy8vVnpRWHlycHlCMGJz?=
 =?utf-8?B?aGhnWlpJVldMUmVNYWJ3aG56Uncrcld2aXhtNFFSR1M1a0d0OGxHVHFwdFVv?=
 =?utf-8?Q?m08GQFqTiaGI+cIlh9fK0Oi+goOr2K/yWmQTdJBCyefv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c5416c-cd31-4f24-54b9-08daf5908f96
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 18:04:06.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVT4jWTP63cHuhSolkXJ+rxwARXbjJ7cyYzYSp0bH9k1b0zxZt/jG/0iiUhJkf/s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof Thanks for your reviews.

Please find my comments below.

On 1/12/23 11:52 PM, Krzysztof Kozlowski wrote:
> On 13/01/2023 08:30, Tanmay Shah wrote:
>> This patch introduces bindings for TCM memory address space on AMD-xilinx
>> platforms. As of now TCM addresses are hardcoded in xilinx remoteproc
>> driver. This bindings will help in defining TCM in device-tree and
>> make it's access platform agnostic and data-driven from the driver.
>>
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>   .../devicetree/bindings/sram/xlnx,tcm.yaml    | 137 ++++++++++++++++++
>>   1 file changed, 137 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml b/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
>> new file mode 100644
>> index 000000000000..02d17026fb1f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
>> @@ -0,0 +1,137 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sram/xlnx,tcm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Tightly Coupled Memory (TCM)
>> +
>> +maintainers:
>> +  - Tanmay Shah <tanmay.shah@amd.com>
>> +
>> +description: |
>> +  Tightly Coupled Memory(TCM) is available on AMD-Xilinx paltforms for ARM
>> +  cortex remote processors to use. It is low-latency memory that provide
>> +  predictable instruction execution and predictable data load/store timing.
>> +  TCM can be configured in lockstep mode or split mode. In split mode
>> +  configuration each RPU core has its own set of ATCM and BTCM memories and in
>> +  lockstep mode redundant processor's TCM become available to lockstep
>> +  processor. So In lockstep mode ATCM and BTCM size is increased.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "sram-[0-9a-f]+$"
> Drop node name requirement.
> Why do you need sram node at all?


I will remove sram- node. However, it device-tree I was planning to put

all TCM nodes under single node for example:

tcm {

     tcm-lockstep {

     };

     tcm-core@0 {

     };

};

The top-most tcm node I assumed sram node. So I kept sram@xxxx

>> +
>> +patternProperties:
>> +  "^tcm-[a-z]+@[0-9a-f]+$":
>> +    type: object
>> +    description: |
>> +      During the split mode, each RPU core has its own set of ATCM and BTCM memory
>> +
>> +      During the lock-step operation, the TCMs that are associated with the
>> +      redundant processor become available to the lock-step processor.
>> +      For example if each individual processor has 64KB ATCM, then in lockstep mode
>> +      The size of ATCM become 128KB. Same for BTCM. tcm-lockstep node represents
>> +      TCM address space in lockstep mode. tcm-core@x node specfies each core's
>> +      TCM address space in split mode.
>> +
>> +    properties:
>> +      compatible:
>> +        oneOf:
> This is not oneOf.
>
>> +          - items:
> and you do not have more than one item.
>
>> +              - enum:
>> +                  - xlnx,tcm-lockstep
>> +                  - xlnx,tcm-split
> compatible describes hardware, not configuration. What you encode here
> does not fit compatible.


I see. So, only xlnx,tcm is enough.


>
>> +
>> +      "#address-cells":
> Use consistent quotes, either " or '


Ack.


>
>> +        const: 1
>> +
>> +      "#size-cells":
>> +        const: 1
>> +
>> +      reg:
>> +        items:
>> +          - description: |
>> +              ATCM Memory address space. An ATCM typically holds interrupt or
>> +              exception code that must be accessed at high speed, without any
>> +              potential delay resulting from a cache miss.
>> +              RPU on AMD-Xilinx platform can also fetch data from ATCM
>> +          - description: |
>> +              BTCM Memory address space. A BTCM typically holds a block of data
>> +              for intensive processing, such as audio or video processing. RPU on
>> +              AMD-Xilinx Platforms can also fetch Code (Instructions) from BTCM
>> +
>> +      reg-names:
>> +        items:
>> +          - const: atcm
>> +          - const: btcm
>> +
>> +      ranges: true
>> +
>> +      power-domains:
>> +        maxItems: 8
>> +        items:
>> +          - description: list of ATCM Power domains
>> +          - description: list of BTCM Power domains
>> +        additionalItems: true
> And what are the rest?
As both items are list, we should be able to include more than one 
power-domain I believe.


So first item I am trying to create list of ATCM power domains.

In split mode, first item is ATCM power-domain and second item is BTCM 
power domain.

However, In lockstep mode, second core's TCM physically relocates and 
two ATCM combines and

makes single region of ATCM. However, their power-domains remains same.

So, In lockstep mode, first two banks are ATCM and so, first two items 
are ATCM power-domains.

I am not sure best way to represent this. But, first itmes is list.

So, I am assuming list of all ATCM power-domains possible.


>
>> +
>> +    required:
>> +      - compatible
>> +      - '#address-cells'
>> +      - '#size-cells'
>> +      - reg
>> +      - ranges
>> +      - power-domains
>> +    unevaluatedProperties: false
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/power/xlnx-zynqmp-power.h>
>> +
>> +    amba {
> Drop.


ACK


>> +        sram@ffe00000 {
> This does not match your bindings.


Ok. This was node-name. I will remove it from example.


>
>> +            tcm-lockstep@ffe00000 {
>> +                compatible = "xlnx,tcm-lockstep";
>> +
>> +                #address-cells = <1>;
>> +                #size-cells = <1>;
>> +
>> +                reg = <0xffe00000 0x20000>, <0xffe20000 0x20000>;
>> +                reg-names = "atcm", "btcm";
>> +                ranges = <0x0 0xffe00000 0x20000>, <0x20000 0xffe20000 0x20000>;
>> +                power-domains = <&zynqmp_firmware PD_R5_0_ATCM>,
>> +                                <&zynqmp_firmware PD_R5_1_ATCM>,
> This is BTCM domain according to your binding. Your binding here is
> probably wrong and does not match real DTS.


As explained above, the first Item is list of all ATCM power-domains.

So, I kept both ATCM power-domains for lockstep mode.

We don't have dts nodes for TCM yet. We are using hard-coded address in 
xlnx_r5_remoteproc.c driver.

As the bindings are new, I was hoping to introduce dts nodes once 
bindings are designed right.



>
>> +                                <&zynqmp_firmware PD_R5_0_BTCM>,
>> +                                <&zynqmp_firmware PD_R5_1_BTCM>;
>> +            };
>> +
>> +            tcm-core@0 {
>> +                compatible = "xlnx,tcm-split";
>> +
>> +                #address-cells = <1>;
>> +                #size-cells = <1>;
>> +
>> +                reg = <0xffe00000 0x10000>, <0xffe20000 0x10000>;
>> +                reg-names = "atcm", "btcm";
>> +                ranges = <0x0 0xffe00000 0x10000>, <0x20000 0xffe20000 0x10000>;
>> +                power-domains = <&zynqmp_firmware PD_R5_0_ATCM>,
>> +                                <&zynqmp_firmware PD_R5_0_BTCM>;
>> +            };
>> +
>> +            tcm-core@1 {
>> +                compatible = "xlnx,tcm-split";
>> +
>> +                #address-cells = <1>;
>> +                #size-cells = <1>;
>> +
>> +                reg = <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
>> +                reg-names = "atcm", "btcm";
>> +                ranges = <0x0 0xffe90000 0x10000>, <0x20000 0xffeb0000 0x10000>;
>> +                power-domains = <&zynqmp_firmware PD_R5_1_ATCM>,
>> +                                <&zynqmp_firmware PD_R5_1_BTCM>;
>> +            };
>> +        };
>> +    };
>> +...
>>
>> base-commit: 6b31ffe9c8b9947d6d3552d6e10752fd96d0f80f
> Best regards,
> Krzysztof
>
