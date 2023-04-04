Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A376D6E07
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjDDU3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDDU3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DFC44A2;
        Tue,  4 Apr 2023 13:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B07B63994;
        Tue,  4 Apr 2023 20:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7958BC433EF;
        Tue,  4 Apr 2023 20:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680640140;
        bh=Sv6V+OxkQJxB4LzsfgBHOh7ys5w8CWYWUwrmCPb2FKw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PHtWnA/YlKNvUe+WqyIfftkHHTNeCDUOWaGhQ83Vf56wPknoDCYDwF54tEsKanBQT
         n7zlx/37O2kKw5fmfeJgqnViCBiTbgeXIDTW5WsOre3Q/rOtFopJtWOUyp922JuQZZ
         Hug/8o8ltAlYeYUmoFTyfVZq0Bnixok6Br6MUd8ZuCbsSnUeh8eFNVmhlDJdrccGQ6
         v9m3YR/38Kgj08DIB9PYJE8qFQLqApyJUu5lUujA6bJspIPfiOg2fKJY+L8slnAg8c
         OctBUWAsO1FOAZUExVHKm0aTEGrJsPKZKozWuQqE7mwzEq2hBPhaqorX+BV6Nb5gmS
         9PFrIt/xFMQCg==
Message-ID: <fb7fb63c-69e3-5c99-0858-3e88071a282e@kernel.org>
Date:   Tue, 4 Apr 2023 23:28:54 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/7] dt-bindings: interconnect: qcom,msm8998-bwmon:
 Resolve MSM8998 support
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
 <20230304-topic-ddr_bwmon-v3-1-77a050c2fbda@linaro.org>
 <20230404193533.5dnjjr4ilhhqd4t5@ripper>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230404193533.5dnjjr4ilhhqd4t5@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.04.23 22:35, Bjorn Andersson wrote:
> On Wed, Mar 15, 2023 at 03:11:19PM +0100, Konrad Dybcio wrote:
>> BWMONv4 has two sets of registers: one for handling the monitor itself
>> and one called "global" which hosts some sort of a headswitch and an
>> interrupt control register. We did not handle that one before, as on
>> SoCs starting with SDM845 they have been merged into a single contiguous
>> range.
>>
>> To make the qcom,msm8998-bwmon less confusing and in preparation for
>> actual MSM8998 support, describe the global register space and introduce
>> new "qcom,sdm845-cpu-bwmon" compatible while keeping the
>> "qcom,sdm845-bwmon" as a fallback for SoCs with this merged register space
>> scheme.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Georgi, can you please pick this patch through your tree?

Yes, sure!

BR,
Georgi

> Regards,
> Bjorn
> 
>> ---
>>   .../bindings/interconnect/qcom,msm8998-bwmon.yaml  | 41 ++++++++++++++++++----
>>   1 file changed, 34 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> index 12a0d3ecbabb..5d17bdcfdf70 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> @@ -22,14 +22,14 @@ description: |
>>   properties:
>>     compatible:
>>       oneOf:
>> +      - const: qcom,msm8998-bwmon       # BWMON v4
>>         - items:
>>             - enum:
>>                 - qcom,sc7280-cpu-bwmon
>>                 - qcom,sc8280xp-cpu-bwmon
>> -              - qcom,sdm845-bwmon
>> +              - qcom,sdm845-cpu-bwmon
>>                 - qcom,sm8550-cpu-bwmon
>> -          - const: qcom,msm8998-bwmon
>> -      - const: qcom,msm8998-bwmon       # BWMON v4
>> +          - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
>>         - items:
>>             - enum:
>>                 - qcom,sc8280xp-llcc-bwmon
>> @@ -49,9 +49,13 @@ properties:
>>       type: object
>>   
>>     reg:
>> -    # BWMON v4 (currently described) and BWMON v5 use one register address
>> -    # space.  BWMON v2 uses two register spaces - not yet described.
>> -    maxItems: 1
>> +    # BWMON v5 uses one register address space, v1-v4 use one or two.
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +    minItems: 1
>> +    maxItems: 2
>>   
>>   required:
>>     - compatible
>> @@ -63,13 +67,36 @@ required:
>>   
>>   additionalProperties: false
>>   
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          const: qcom,msm8998-bwmon
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 2
>> +
>> +        reg-names:
>> +          items:
>> +            - const: monitor
>> +            - const: global
>> +
>> +    else:
>> +      properties:
>> +        reg:
>> +          maxItems: 1
>> +
>> +        reg-names:
>> +          maxItems: 1
>> +
>>   examples:
>>     - |
>>       #include <dt-bindings/interconnect/qcom,sdm845.h>
>>       #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   
>>       pmu@1436400 {
>> -        compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
>> +        compatible = "qcom,sdm845-cpu-bwmon", "qcom,sdm845-bwmon";
>>           reg = <0x01436400 0x600>;
>>           interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
>>           interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;
>>
>> -- 
>> 2.39.2
>>

