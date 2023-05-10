Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42ED6FDC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbjEJLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjEJLBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:01:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3CF4207;
        Wed, 10 May 2023 04:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLpYN3MS+Mu2reEvM4FDXqDrO9YxsW3gXDygJ4OhCRpv/tqgr8KONXz280wHlQeb3SZjxO9ahX9X9P6b7d6QwmEO3pkPYdKU2pu650RJ9pHoEE7I7K4qwsg/+eBAS00Vfc0+rZFqeKetguqj/fVWPCVAHkYFIntUhgpXLqD9twAG+1xD3iXUmEGhax4OB5Yg/2s2tTIOHGX5Rwec/MSp54WHoNwiX35f3AdoP2KYaEjALvxO24scpbgeCUEjEfJhkiotpgs2XPF0rWml9PvtW/GaCvsPHBaTih0dQ1yUALJXAU2KU1QFiO6dlY3PEr48CWVp7CVjUNjrctA7daIS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw7tPuDZD9dOrwvmymwaoL/j7H1fbhVMhy23sdnJXzI=;
 b=HTOz4hntjCPpkmwMjA/OxbrdzboQkKCQ4yIfKbPbLsNNwABrkxCGmhXOVr0WC1MTjfUitCDlAnVHQYMvA95ZOgO6gJFsU0uvo6Qhq0vyM5rdyg4JfBCg7QzZXYjRkHJu20BLqja/8nH6+1Kc+poin1C/3IZ9FRFgeLY0EarD2dDNXaNcM7Se0puA5hsT/PrXMA6cu9nliOxtfHvJt0uUSDQT2yh0A8kBAKmB5Ynx9buYsI33EhHW4OmvNU6POqjBRN6Fw1G/BzfkwHO0MN16CfE2FxJ5uRQuhdHtsbBuvb3q1t1ULFsSe+qwyurzOHJeiNF21FOz48s61gX3xK9Ytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw7tPuDZD9dOrwvmymwaoL/j7H1fbhVMhy23sdnJXzI=;
 b=zyd/8GwWGsVVG8UFtDUHKcRFHMxIjaOyXr56AareSbvpYaGnGZ9hC4qpD4VqPGhJYMnP7UaHI3MQS70SQYdlHZetEDtnv8xj8eZKA21yx1SlzKCm/nuKQzm4CRzeA9IdbQcOStTzxvqsc472vCC0f6MVHioNYw6A0tXveh0z2FI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4765.namprd12.prod.outlook.com (2603:10b6:805:e4::24)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 11:00:49 +0000
Received: from SN6PR12MB4765.namprd12.prod.outlook.com
 ([fe80::edcd:752d:df60:d4ae]) by SN6PR12MB4765.namprd12.prod.outlook.com
 ([fe80::edcd:752d:df60:d4ae%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 11:00:49 +0000
Message-ID: <882f0cb5-7a5f-fe56-fdd9-f6074c1e359a@amd.com>
Date:   Wed, 10 May 2023 13:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] dt-bindings: usb: Add binding for Microchip usb5744
 hub controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        ilias.apalodimas@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <dd31f987316fb2739644628b5840a6d447b5a587.1683293125.git.michal.simek@amd.com>
 <32aa46df-9ed5-7d2a-868f-a36414f54534@linaro.org>
 <1868d9ae-1376-d91d-a789-9e510bde96a7@amd.com>
 <27232a95-6ef8-1a98-4f5d-7d0ea29c20c4@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <27232a95-6ef8-1a98-4f5d-7d0ea29c20c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To SN6PR12MB4765.namprd12.prod.outlook.com
 (2603:10b6:805:e4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4765:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2322f4-a89a-45fe-4577-08db5145d061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOiLVTzD23C2yEoTr6iPerJ2n1TURpFvUfHfn0+fz+ZnC9Rgbw0ANg7uTF6QtqaAo01/2CNq1sf109NnWD5LkR9DrdZaMTW7Z6riYAoVyXnOAHHdUOvrDsWHOCC6WhL+vEbggZRqiQRtx2P1exNu2o8UHXONPpLv6T1JXG76FzV1DWSIphRBM2VQjN7TnL5BPEhZskwwKiKDTTtDbp3276lOd7QMTx6sB5S0DVkiM1/ZdtJAP+w4be2zq+/ehlz/ZqtJ7BzxZ+8wP7yH4Z+++vpzT/wgC+WF2Gk6lKlrQU0ag6vAaVZkivTLuswyZ57A8OXlylvA4Ss9Z5x0kn/Ft71vp0j4aBBgKSzX32+nnYWSYsi4VLrFCrDB0bKts3AgLcWAbcmbyQyUV00G2A2SfpXc78QcOzzenPWxNzdLlwwWT5P0aGfekmP4JK+aYZT8Ti/Opob5TXWzsuuRkDM8C26OHDDbU/N+U8qctw6YnsRs16XMd0lzwFau4RHYAjc2rB0vTTe2q+f+pPcOf2VwjXKfGQ7AbpDikd8LDgF3MutyNdRrFlag98/M6atBQGmjNgIX/+wDf56FbpICjWOzgo3Jg4OslVJyA/XQyEeyxTsEbOMOqwrry1Xf7J9FtVA4Lf2XwmKSaDOr0iFTbXVpyQfEALU/hsT9T85FtBmIYU7Ar3zOeO8iKYtM/a64SoLQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(966005)(53546011)(6506007)(6512007)(26005)(66476007)(83380400001)(2616005)(2906002)(7416002)(8936002)(186003)(44832011)(5660300002)(8676002)(36756003)(478600001)(6486002)(31696002)(316002)(6666004)(54906003)(41300700001)(66556008)(66946007)(86362001)(4326008)(38100700002)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1BTSW42UDNVTEkzYTNhU2tzNEFrd3RsUGJCTFQzemptcElMUDcwMCtIQU50?=
 =?utf-8?B?RVI0S2hUVHFXb25GaVRhV0JFRGpsSklZTElKLy9LTmNBdXZDSldnRkMrWVRJ?=
 =?utf-8?B?M1JoblBYNkNjcTB6VWhmbEdSL0tuUHlkeFFrenFmakE5QVlBV0Z0R1VIUXdG?=
 =?utf-8?B?Mm11dWN1QzRGSnhITVk3SFJPTFBXQnlUdDNPWk5KSXMrazRIU0VrWHk1dE16?=
 =?utf-8?B?ZnFpMlFDOEQ0eTEzSmppNGdZaXhXUHpxRXNvQy9JTFhMQWUvMmNrNHUvZEl0?=
 =?utf-8?B?WWt5UnNucitydS9PeWhJaktmY3BLUXFVSDNpRERZK2hXSmc5TGIxS0FJNU9z?=
 =?utf-8?B?d1ZYaDRZYjI5dkNYVTBzK3NYMTRkNUJJNTFxcVBKQ3ZOb1NTd3FiemZtaG1F?=
 =?utf-8?B?RnhiOU9IL29HbGY0a3VMQ2xRWFNINndqYnZtdUlMdEo2bVI1VnV0N0JNejdV?=
 =?utf-8?B?a1BRR1cyWk5uOFNhNlI4ZjBDQUU0RjNEbVRpV05BVlRic0hMTU5na1ZvZzJT?=
 =?utf-8?B?N3RVTGJMNWRtZ0VoNDF2Mk5BcTN3anMvQklSTFYwb1NVQ0p1aFBaclhHeVRX?=
 =?utf-8?B?MUpKdysxTUh2TngwRjk0bSs5WGpHSWN6MStQRU5wd3F5MEc4WnRGZEdlMVJr?=
 =?utf-8?B?VVFmT2VDalAyYXg2ZFdtVzVYSU5qdExHQkFiVnhRMzRvRWlWQmgrdnpaNmRi?=
 =?utf-8?B?b250ZG83TS9YNlNyRGhJRjByUXg1YVhWbXc2TVR5MzF4cDB4dHkvVVhHcVVr?=
 =?utf-8?B?WmtITFpWWWY3T0J3OXpXS1JxRUJDRUhGL1VIc25ZUGhnWlQ1MTNmdEZ5ZVRP?=
 =?utf-8?B?VTlwUlpYUHM2RGlybmlzZmcxangybjdHTmVKNjQxNjFFUEd1Smx2YU5scUtX?=
 =?utf-8?B?UUVhWi9qYW1tNlgySm1TUHkxYjdGbVc2TlNoNkgwNm1YeWkxSVFydXluekt2?=
 =?utf-8?B?dE5qeFUxT1NmS0daZk13aXgrMWs2T010MFhVdTlMWDNXeUwxVHR3NUNlMFFj?=
 =?utf-8?B?L2t5Vm1NUnNlL2dFRDBiZHB1UHZleGFUTzdXSFM0LzZZcU9ZM2dQNEVhK2ph?=
 =?utf-8?B?bWJyOUpyQ013WkJlaUkvUWVmQWNTckVxTFh1MWxqeHgzeHg1Q0I5aEZMZmQr?=
 =?utf-8?B?UVFWTDlodWpuWlAva1VHaEdrUjEwd2hLQ1pxZE0wMnFvbVhMbjVPSzNEUUdv?=
 =?utf-8?B?WnBiOW93R25JbXdyMzBmNnYreVozTEF3RWgxdUlRREh1UE0zT3ZvbVdmUkdZ?=
 =?utf-8?B?K1R1dTA4MW1UQzdLQ3ZYSVM3d2R6TSsyWksyMEp5N3h6T0pjMzFDdDYySGp3?=
 =?utf-8?B?TDBuVzJvN1pYZWMxZFdKdG5MejZSVHdxWmJjcDdaSUZ5V241RXp4ZzBJaWcz?=
 =?utf-8?B?SHJZd3E0d2xxY0w2L0lUMmNwK3puR2FhQ0YrUk53a3dkdjhBdG4xR1lTa3Nk?=
 =?utf-8?B?ZFA3cEozRVF2N2ZUWEFkSTlXOGFyL2R3V3RsTVo2VHluTm9VNmhqSTdLdG5x?=
 =?utf-8?B?a2FCRDdSVDJMQUpIT0ViNFA5L3VRblk1OFI0MzV5UitBeHptejN5VXJDYUlu?=
 =?utf-8?B?T0FsZGVrblR2QUJ2VFpTemVxVGt1L2NYUDRHRVFKZ1o1dmtkWkp1bkVCbjdJ?=
 =?utf-8?B?RzJLWE43ZWhKT0F2czJlUWRWR3Z6UmZzVXdKSWh5Y3Bmb3Z3TzVzWUd6cS9G?=
 =?utf-8?B?cmxSUGtnVVp1WUJBVEVFK3BUWnVkQzZtU0dOZWFtbWRGZ2dFQ1lFSjI0WU84?=
 =?utf-8?B?WUxTTHhyZ3lCVXZHVzAxaFgyZmZUa05PbmR6cmhUSFN6MHZaRDJ1ZEFRdHVl?=
 =?utf-8?B?UEdpUmJZQnN3WkxVTDBIN05MZGxJWXhrRWh6c0p2amlqY1pDMnJFekV1Ritr?=
 =?utf-8?B?MTA1VldVYXFKVjlBWHN3SFhlcmVta1IyZ2k3WGNIU1ppcjZ2dTJhQ1ZCN2Z2?=
 =?utf-8?B?U1ZJaGN4Y2FmUXN2Q2VqUFhZZWpGRWpWUDVQbXdQOHkwSTl3WlVkRWhzbjg2?=
 =?utf-8?B?STN1TTd3NEJYdEdSektQYXdWMkJEcjJ1RFp5N0YwR3pURkVJQ2JvM2Q4bTNq?=
 =?utf-8?B?dTJjVXA1NDFOOXdzR1E3NjdCOFdPc3Y2OUMrdE5QSGVyeGlCdWNhMmxsRzBK?=
 =?utf-8?Q?w7jiC/knV3aXjRYPvUoI25e3q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2322f4-a89a-45fe-4577-08db5145d061
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:00:49.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fM+ZahkgA/WDhIPpkXOueZH04CYiwQk4WAhQcoUquUtZ08C3MGGn0unjnLRPLI1x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/23 18:04, Krzysztof Kozlowski wrote:
> On 09/05/2023 16:19, Michal Simek wrote:
>>
>>
>> On 5/7/23 10:07, Krzysztof Kozlowski wrote:
>>> On 05/05/2023 15:25, Michal Simek wrote:
>>>> The Microchip usb5744 is a SS/HS USB 3.0 hub controller with 4 ports.
>>>> The binding describes USB related aspects of the USB5744 hub, it as
>>>> well cover the option of connecting the controller as an i2c slave.
>>>> When i2c interface is connected hub needs to be initialized first.
>>>> Hub itself has fixed i2c address 0x2D but hardcoding address is not good
>>>> idea because address can be shifted by i2c address translator in the
>>>> middle.
>>>>
>>>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - fix i2c-bus property
>>>> - swap usb2.0/3.0 compatible strings
>>>> - fix indentation in example (4 spaces)
>>>> - add new i2c node with microchip,usb5744 compatible property
>>>>
>>>> It looks like that usb8041 has also an optional i2c interface which is not
>>>> covered. But it is mentioned at commit 40e58a8a7ca6 ("dt-bindings: usb:
>>>> Add binding for TI USB8041 hub controller").
>>>>
>>>> i2c-bus name property was suggested by Rob at
>>>> https://lore.kernel.org/all/CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com/
>>>> and
>>>> https://lore.kernel.org/all/CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com/
>>>>
>>>> the question is if adding address like this is acceptable.
>>>> But it must be specified.
>>>>
>>>> Driver will follow based on final dt-binding.
>>>>
>>>> $ref: usb-device.yaml# should be also added but have no idea how to wire it
>>>> up to be applied only on usb node not i2c one.
>>>>
>>>> ---
>>>>    .../bindings/usb/microchip,usb5744.yaml       | 110 ++++++++++++++++++
>>>>    1 file changed, 110 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>>> new file mode 100644
>>>> index 000000000000..7e0a3472ea95
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>>> @@ -0,0 +1,110 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/usb/microchip,usb5744.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Microchip USB5744 4-port Hub Controller
>>>> +
>>>> +description:
>>>> +  Microchip's USB5744 SmartHubTM IC is a 4 port, SuperSpeed (SS)/Hi-Speed (HS),
>>>> +  low power, low pin count configurable and fully compliant with the USB 3.1
>>>> +  Gen 1 specification. The USB5744 also supports Full Speed (FS) and Low Speed
>>>> +  (LS) USB signaling, offering complete coverage of all defined USB operating
>>>> +  speeds. The new SuperSpeed hubs operate in parallel with the USB 2.0
>>>> +  controller, so 5 Gbps SuperSpeed data transfers are not affected by slower
>>>> +  USB 2.0 traffic.
>>>> +
>>>> +maintainers:
>>>> +  - Piyush Mehta <piyush.mehta@amd.com>
>>>> +  - Michal Simek <michal.simek@amd.com>
>>>> +
>>>> +select:
>>>> +  properties:
>>>> +    compatible:
>>>> +      contains:
>>>> +        const: microchip,usb5744
>>>> +  required:
>>>> +    - compatible
>>>
>>> I don't understand why do you need this select. It basically disables
>>> schema matching for other ones.
>>
>> I didn't find a way how to have usbXXX,XXXX compatible strings and
>> microchip,usb5744 compatible in the same file. I am definitely lacking knowledge
>> how to write it properly that's why any advise is welcome.
> 
> Hm, if you just have both of them like you have now, what happens?


make 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/microchip,usb5744.yaml 
dt_binding_check
   DTEX    Documentation/devicetree/bindings/usb/microchip,usb5744.example.dts
   LINT    Documentation/devicetree/bindings
   CHKDT   Documentation/devicetree/bindings/processed-schema.json
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   DTC_CHK Documentation/devicetree/bindings/usb/microchip,usb5744.example.dtb
/home/monstr/data/disk/linux/Documentation/devicetree/bindings/usb/microchip,usb5744.example.dtb: 
hub@1: 'i2c-bus', 'peer-hub', 'reset-gpios' do not match any of the regexes: 
'pinctrl-[0-9]+'
	From schema: 
/home/monstr/data/disk/linux/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
/home/monstr/data/disk/linux/Documentation/devicetree/bindings/usb/microchip,usb5744.example.dtb: 
hub@2: 'i2c-bus', 'peer-hub', 'reset-gpios' do not match any of the regexes: 
'pinctrl-[0-9]+'
	From schema: 
/home/monstr/data/disk/linux/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml

And this is even without usb-device.yaml wired.

Thanks,
Michal


