Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF4F69F3CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjBVL46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjBVL4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:56:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFD3737F04;
        Wed, 22 Feb 2023 03:56:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A964139F;
        Wed, 22 Feb 2023 03:57:31 -0800 (PST)
Received: from [10.57.90.101] (unknown [10.57.90.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EC8A3F881;
        Wed, 22 Feb 2023 03:56:45 -0800 (PST)
Message-ID: <1efa0aa9-95d3-9d50-d7d3-52d19b02275c@arm.com>
Date:   Wed, 22 Feb 2023 11:56:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 1/9] dt-bindings: arm: Add support for DSB element
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Tao Zhang <taozha@qti.qualcomm.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
 <1674114105-16651-2-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1674114105-16651-2-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 07:41, Tao Zhang wrote:
> Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
> Bit) element for TPDA. Specifies the DSB element size supported
> by each monitor connected to the aggregator on each port. Should
> be specified in pairs (port, dsb element size).
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
> ---
>   .../bindings/arm/qcom,coresight-tpda.yaml          | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> index 2ec9b5b..298db7f 100644
> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> @@ -58,6 +58,26 @@ properties:
>       minItems: 1
>       maxItems: 2
>   
> +  qcom,dsb-element-size:
> +    description: |
> +      Specifies the DSB(Discrete Single Bit) element size supported by
> +      each monitor connected to the aggregator on each port. Should be
> +      specified in pairs <port, dsb element size>.
> +
> +      Note: The maximum value of the port number depends on how many
> +      input ports the current TPDA has. DSB element size currently only
> +      supports 32-bit and 64-bit.
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      items:
> +        - description: |
> +            "port" indicates TPDA input port number
> +          minimum: 0
> +        - description: |
> +            "dsb element size" indicates dsb element size
> +          minimum: 0
> +          maximum: 64
> +
>     clocks:
>       maxItems: 1
>   
> @@ -100,6 +120,8 @@ examples:
>          compatible = "qcom,coresight-tpda", "arm,primecell";
>          reg = <0x6004000 0x1000>;
>   
> +       qcom,dsb-element-size = <0 32>;
> +

If we go down this route,

nit: please could you provide a bit more complex example, e.g. with 2 
entries ?

Suzuki

>          clocks = <&aoss_qmp>;
>          clock-names = "apb_pclk";
>   

