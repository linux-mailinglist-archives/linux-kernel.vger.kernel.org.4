Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89572617AB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiKCKTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiKCKTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:19:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2480C65FE;
        Thu,  3 Nov 2022 03:19:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D1491FB;
        Thu,  3 Nov 2022 03:19:22 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A6B43F5A1;
        Thu,  3 Nov 2022 03:19:14 -0700 (PDT)
Date:   Thu, 3 Nov 2022 10:19:11 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, cristian.marussi@arm.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        quic_avajid@quicinc.com, Souvik.Chakravarty@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC 1/2] dt-bindings: firmware: arm,scmi: Add support for
 memlat vendor protocol
Message-ID: <20221103101911.2qr3cla5mm4ctoe3@bogus>
References: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
 <1667451512-9655-2-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667451512-9655-2-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:28:31AM +0530, Sibi Sankar wrote:
> Add bindings support for the SCMI QTI memlat (memory latency) vendor
> protocol. The memlat vendor protocol enables the frequency scaling of
> various buses (L3/LLCC/DDR) based on the memory latency governor
> running on the CPUSS Control Processor.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml     | 164 +++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 1c0388da6721..efc8a5a8bffe 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -189,6 +189,47 @@ properties:
>        reg:
>          const: 0x18
>  
> +  protocol@80:
> +    type: object
> +    properties:
> +      reg:
> +        const: 0x80
> +
> +      qcom,bus-type:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        items:
> +          minItems: 1
> +        description:
> +          Identifier of the bus type to be scaled by the memlat protocol.
> +

Why is this part of the provider of the service ?

> +      cpu-map:
> +        type: object
> +        description:
> +          The list of all cpu cluster configurations to be tracked by the memlat protocol
> +
> +        patternProperties:
> +          '^cluster[0-9]':
> +            type: object
> +            description:
> +              Each cluster node describes the frequency domain associated with the
> +              CPUFREQ HW engine and bandwidth requirements of the buses to be scaled.
> +
> +            properties:
> +              operating-points-v2: true
> +
> +              qcom,freq-domain:
> +                $ref: /schemas/types.yaml#/definitions/phandle-array
> +                description:
> +                  Reference to the frequency domain of the CPUFREQ HW engine
> +                items:
> +                  - items:
> +                      - description: phandle to CPUFREQ HW engine
> +                      - description: frequency domain associated with the cluster
> +
> +            required:
> +              - qcom,freq-domain
> +              - operating-points-v2
> +

I would avoid all these here as part of provider node. It should be part
of the consumer to have all these details and do what it needs to do with
any such information.

-- 
Regards,
Sudeep
