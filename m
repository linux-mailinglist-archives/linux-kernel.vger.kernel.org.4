Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48416F812F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjEELDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjEELDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:03:37 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34BA1A1C1;
        Fri,  5 May 2023 04:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683284617;
  x=1714820617;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dzf6y3uGmT4GaB5RYRPA4eBfeB2ZhkdOFKP2wBZ891I=;
  b=k7g3M6LX1I8t8lPJzzubznZ5t+t21VvvEfyWgKUc16IFfkMkT+8LhTg3
   N4Yzl5iwoAso5h/gtlVIodOxg9Z59Ej6c/SidbhwHn1czERhK6alVOtIv
   XDszbQJHcNvR/9fsAHa11UxcBAJPJYZW4advz3ACXc8PkPUzNzaKuGykv
   gyifQKJSq0tyuZWMA6tZudmgoTjXbS4b9AY4sqhsYxi5eOFg2SmyUSjws
   apfApvi5U48t8UnSa2gHVnuVM+iksnzAfj/kbFIHA+y9uoueCVmPu1UsN
   qG/vkpLrVhIyWb9MUpULnFuertLoK04ojmiqxcWpnyKK8JVOQAtY+2h6D
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STRm2ZWpfzvd9YcvlU5KMlihiSCfSVLY8eWFEoIf1fjWaJwokYW7lLXZafdcwr9PzssBYtKUDXshjqDC3Z3CnMFH7xvf+gRrgJsBeOv8BEciTb+0BX9+FAGt78eUXvzrMbqILv+FeLXM9Sirq+zE2oCytyUIgZesdnn3lSMM6zcJQ90AsI1gPPG86etxopbyXorycjKtJR/+g3yDRsGJWCprznS6sP1TZ7dhd8ITv0pB3oVm26oH8IGhV9BcKChTFAJ0F8RicLDncIqacZVzZ9pEcZjtSoO0c8a3AJQdj9u+cpqlDSJgGL5PShZCafNwFmGxBAt98Z4rCfBtdjKsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzf6y3uGmT4GaB5RYRPA4eBfeB2ZhkdOFKP2wBZ891I=;
 b=TDuZDqSJ9GubrqJIGZMJzPYs+kUNV8OvedFhWSCovfsDoVxVs+LKf+ubbkP+zsvjmI3Jw79qeysRUVMEJBhYTmT1teRth6cv8WrKHCnRGMVHuFbS/ELrXEfmtuLVa20q3fvaTHzMNc1X/oLkycmTSjKYefq11cb1VNDskWVHwQ081ZS4epSDTjfzf2fmoC75oRT3RpuSZderhoM0dWV9GeDdDW/7RYRK0uE8T0mswi62sEJR1W3S4fV5Q1lb9dmxhhc4+Rivapgy8o2dsgezlRhgm+2N1tkgj/BjbMITNcllm8xCY/EIuJ9hnt5KE2sO2lT5aRRQlmU8wo0PByCu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzf6y3uGmT4GaB5RYRPA4eBfeB2ZhkdOFKP2wBZ891I=;
 b=WnfhdLj6FekZGMUPk4ObJPLQwiuYaYVND2NYZLKIpJ4te3SSl7ZdSayzPI1ta8Fx2hr1fly1+boOKv34PrJH2h7jQxazsYJmzps09E/4q9pX4eowotIERwZPk/xhknIjVx5JmW5ger+E+LdFGwPRltWZtHhxP5TUVGL+8+Rx48E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <56979ac8-f27a-801a-dca3-3e1ff63bb005@axis.com>
Date:   Fri, 5 May 2023 13:03:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] regulator: Add bindings for TPS6287x
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@axis.com>
References: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
 <20230502-tps6287x-driver-v2-1-fb5419d46c49@axis.com>
 <dfd3498c-62ab-92d3-22d6-21729dc619fa@linaro.org>
 <c42a721c-13a4-16a1-efe6-002c76f5c69b@axis.com>
 <1f62d6dd-1ab8-a8e8-c881-da03ad9bfbd9@linaro.org>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <1f62d6dd-1ab8-a8e8-c881-da03ad9bfbd9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::11) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|PA4PR02MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 681d86e7-0ed8-4e35-bf0e-08db4d585d41
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkJOSI3lFfIIJEvu+SERQ+iEI3XoQkYUdaHuxxuU8Z8qFkQRomWZVkuhvdzBsd7sFu8FkikBa74/iIuLpz6bXiGGNuP4MJN1xt2iwthotJf081FDzwijDDHiv/J+T6QrdKhErF0tRpykEQ0kg3LbExFQcBd8tlBa6SvGVQ5G7dugLceFp9X/Iou5CvFyOrSqGY66Q40Dv9JUjq7W5Y3gYDY6EoGCycHscDZZ6CLUMXn1nzHbXPBfs4TnOa/dnjnYtvCmoUAFtws4HLDX8nV+FOgoxKOr8yyyh8G1cdbHxeH0htQPB23ORna9OuhgDNmKBUjSOqC9MLohfqPMKQUvs5obPeX/g6UkRn/yHtsMDF80Zx7Lp9yl4sutwGVfK8d632/MXgaXJLXfxeWpvSdu6Js2oQZIaman3/FsIN18IA+Wu9VyLVTL1WMVRIS7TR4Tsa0NU/QGUXIwnlkERVMngKW8lPu3RtfGXVMbDCL7qKXtDhKL/0V3NuJnzdPvmt+u8RhrKIIWgS4HW4bRuiIa2Ii3IpxapexMSkmzkrLWSQCzRwhgFrDK4WU40+/yOgAsXUDowpCVZjbafaaiBpwXASBsHx3+2dvkhC32NpOjofqpmFdt7lYgAuSV0Hiqw1oMFZj9QZGXNjbqer449wZoJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(31686004)(66899021)(966005)(66556008)(66946007)(4326008)(66476007)(6486002)(316002)(110136005)(36756003)(31696002)(478600001)(66574015)(83380400001)(53546011)(107886003)(2616005)(6506007)(6512007)(26005)(8936002)(5660300002)(8676002)(41300700001)(2906002)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZrZC9EMHdQMzd1N2FuSFNJSmc4SEFZSW54cFRjOGFNd3RTK1hhSWlObVBG?=
 =?utf-8?B?SndOamJiTXBKa0krTVVWS2JmeHROYmRGenpHSnZNbkZDeUxKVU1XOEZZMlBt?=
 =?utf-8?B?OGRJeUN5c294bVQ5eGExZm5tMTM3QWhUUFIvQ0VVODNBUGQ0QTBqWGwrWWE4?=
 =?utf-8?B?M294bGY2MExWb1dyZmhuOGF2Y1dTN09DZ0hCWGZrTktZV1p2K2VGNE92RzlZ?=
 =?utf-8?B?WTVEY0RoQk9SYkYza2VseStzWnBBbEx6TDRWV2tHTHMwWWFEWndhNHNvTHdR?=
 =?utf-8?B?azI3V0lKZElDVURtekcvT1VXVCt2SHRsRlU0ZGJUM1JuS1RCNjIwdUZBM0RC?=
 =?utf-8?B?S2xNWGRKWlhLZVZrcnZTMStNbDc4bXcwK1E2OVRiU2NyTnZnRjR2WHM3d0I4?=
 =?utf-8?B?cGNuSS94aFI2VWQvTFkvM0d3TmVCcndnczlubDNKZGxWREZOZXdLc1lodUdV?=
 =?utf-8?B?R29LN0FRNXRmRlRKSFUxb1VRRWIvT0ROK2VON014c2RBcTN5S21uOHZES3Fi?=
 =?utf-8?B?U252aURNUW1sNzVEbGlvRnlqSVRFWVF6M1ZyOGRZL21DOEhhUlk2dUJmZXl0?=
 =?utf-8?B?c0h1bUNwWmpRaVhDZEk1aXRUL015ZHpqMzZKMTRnTGtQZis2Y0tMcHJmdFc3?=
 =?utf-8?B?V0dMcWl3SWNveHNqZ1FDWExFVjN4S2JOdkxheEZocTFWQmx6eVlCcjVIQ2tv?=
 =?utf-8?B?RFJyRkFIN09LL01ZWXBVQkdIT0Q4RFdvZXFGaHJ0MVJTUkxJaXRIOHd6ZGMy?=
 =?utf-8?B?eTFaTGJ5dmliU0VMTWZGN1hhZElJV3ZXR2I0c3grMFNFbG03bHo5SmRxSzNG?=
 =?utf-8?B?RWZ4blZwUEVXTDhtM1RmZ3hoc21YZmJOSDF0VkZsVXkxQzluK045NUhpQlMx?=
 =?utf-8?B?VEtMQm9LY1JZN2pHK2x0RUZOdVp2Sy9sQXNUMEhLcWF5MGZzeW9MQlRrY1JM?=
 =?utf-8?B?YnFYVW9RZ2xpK21DaldrWndoUnAxalZlK3dxWjdMeENualNPdi9Sb25nQUV6?=
 =?utf-8?B?NUVoYTBFQlFpSEZCOHZOY1VNMXVuY2hNYkJOWTFCMjRDeFArMFJZOEpyOVkv?=
 =?utf-8?B?NUdtTnhtSzRGQXpYLzZrTkhXRm5IdTNLOEYzMVpUdGdEUHROcm5kbE9PMUZQ?=
 =?utf-8?B?L3VUWkRmbFNOQnc2MzhwMFc4QlZiTDlxWFZLOUduYWMxemp5dWoxaXF3aGow?=
 =?utf-8?B?QXVTTURSZDlaa2VnVFhsbkJXTGtSMnZZOTJ6bXJBTW03aytIa0Mvb0czRWFz?=
 =?utf-8?B?VENEdE9TS0Z2alllY1NaZUlXSTNiMFU2aVZnWS9hMjdZNEVFYXcrVjh3RUx5?=
 =?utf-8?B?N3E0dWJ0T3hGTldwck5pVnNtS3c3Q2p0ZTVDa2Q0VVpXK3Z4ZUQrT2VOMTkw?=
 =?utf-8?B?bm1LTWtsR0llVk1FWU1vVC90bXcyMkJPeVZjZ25KS3VydlBEcXFFRFA2UDlu?=
 =?utf-8?B?czdGL0R3Y05icXpVcU5JNHhQNVp0ZGJxV2p4dEhDUnlxOUdIQVNjSTh2SlRm?=
 =?utf-8?B?QTFwZDEvQzc3RUpYM0dmS0tGV25BWHdHem4veTdFWHVDT0R1MFhVNlJTR0R1?=
 =?utf-8?B?azZpT3dJSjVUekFhbEFHQ1RFSUJobzhITmtqckI0SGFJMjBBdER2b2IxSGpN?=
 =?utf-8?B?dm0vOE9DUXlsZEVvRzJodFBlZWNFQVBYZGkxMkFxRWtZN1B6S1NveTZldEgx?=
 =?utf-8?B?S0lRRjk2Z01aSDBBd1k1VklJQzZickp0U2FWSzR6QTVnUXpyWHRLRTI4OXBj?=
 =?utf-8?B?VThRYjhaK2hpUmVhZkdlbUF0WUZtRHhITlRva2ZET09wSUtkdFFuZmZoYnFu?=
 =?utf-8?B?T21Tc0xmZ1diOHFzM2lYRHowZ3BMbWppOGV4NnFET0JvajdtVW95QVczbTcy?=
 =?utf-8?B?U01zZDNpVGg1am1vNGVXcW02VzVoZnJCemRLSjF0dHQwUThEN3ZML3c0ekMx?=
 =?utf-8?B?WkxUSjB2ZnNlSjd4ckV2YmdBU1ZsRElaME1wbTdkbzU1NUhUYXZNYm5zWkY0?=
 =?utf-8?B?SW9BaStTOExoL0Q3MGo1MVpWMWdUSWltUWI4b2RXa2xZY3BUSXJlaFhYSzB3?=
 =?utf-8?B?NkRoVDFoN1NkeXA0TlFxc1FVN1AySENETERHcFY0Uk1ld1BTVmN0MDlzcThK?=
 =?utf-8?Q?5AXwbyS7kEGsSCqjpnE2PAgps?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 681d86e7-0ed8-4e35-bf0e-08db4d585d41
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 11:03:32.1253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xmb8nkrV+dceVL6fBStSuNNdPkQhJg5pX6dxrn8ZygpppedL17/JSDjC3iRiM2ev9CCAu8eSefWDbS1BIutp0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6909
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/23 17:11, Krzysztof Kozlowski wrote:
> On 04/05/2023 17:08, Mårten Lindahl wrote:
>> Hi Krzysztof!
>>
>> On 5/4/23 11:34, Krzysztof Kozlowski wrote:
>>> On 04/05/2023 10:30, Mårten Lindahl wrote:
>>>> Add bindings for the TPS62870/TPS62871/TPS62872/TPS62873 voltage
>>>> regulators.
>>>>
>>> Use subject prefixes matching the subsystem (which you can get for
>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>>> your patch is touching).
>>>
>>> Just a hint - I in general ignore all the emails without dt-bindings prefix.
>> Ok, I'll prefix it "dt-bindings: regulator:"
> You got command to run, so run it.  This semi-automated response is made
> longer for the purpose to help you, not to be quickly scrolled and
> ignored. When you run it you will see the order is opposite, regulator
> followed by dt-bindings.
>
> You can apply such habit for other subsystems where maintainers also
> expect certain prefixes.

Hi! Sorry, I did run the command and followed the latest commit I could 
see (1ba7dfb905b3) as the result is mixed with prefixes.

But I will of course do as you request: "regulator: dt-bindings: ".

>
>
>>>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
>>>> ---
>>>>    .../devicetree/bindings/regulator/ti,tps62870.yaml | 62 ++++++++++++++++++++++
>>>>    1 file changed, 62 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
>>>> new file mode 100644
>>>> index 000000000000..32f259f16314
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
>>>> @@ -0,0 +1,62 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/regulator/ti,tps62870.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: TI TPS62870/TPS62871/TPS62872/TPS62873 voltage regulator
>>>> +
>>>> +maintainers:
>>>> +  - Mårten Lindahl <marten.lindahl@axis.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - ti,tps62870
>>>> +      - ti,tps62871
>>>> +      - ti,tps62872
>>>> +      - ti,tps62873
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  regulators:
>>>> +    type: object
>>>> +
>>>> +    properties:
>>>> +      "vout":
>>> Drop quotes.
>>>
>>> Why do you need entire "regulators" node for one regulator? Why do you
>>> need child at first place. Drop it entirely.
>> I will remove the regulators node. I think the vout node is needed to
>> get the of_get_regulator_init_data.
> Hmmm, how other simple regulators deal with it? Like all the fixed ones
> and few other one-regulator-devices?

Ok, I added of_get_regulator_init_data to the driver probe and then it 
works fine. I'll drop the child node.

Thanks!

Kind regards

Mårten

>
>
> Best regards,
> Krzysztof
>
