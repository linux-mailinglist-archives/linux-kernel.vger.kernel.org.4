Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FDF6F8112
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjEEKyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEEKyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:54:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3B34F4;
        Fri,  5 May 2023 03:54:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A18C51FB;
        Fri,  5 May 2023 03:54:52 -0700 (PDT)
Received: from [10.57.21.147] (unknown [10.57.21.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6EF23F64C;
        Fri,  5 May 2023 03:54:04 -0700 (PDT)
Message-ID: <958ae925-dee2-3273-0cd6-b5edc891ba70@arm.com>
Date:   Fri, 5 May 2023 11:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: Add Coresight Dummy Trace
To:     Hao Zhang <quic_hazha@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
References: <20230505092422.32217-1-quic_hazha@quicinc.com>
 <20230505092422.32217-3-quic_hazha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230505092422.32217-3-quic_hazha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 10:24, Hao Zhang wrote:
> Add new coresight-dummy.yaml file describing the bindings required
> to define coresight dummy trace in the device trees.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>   .../bindings/arm/arm,coresight-dummy.yaml     | 102 ++++++++++++++++++
>   1 file changed, 102 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
> new file mode 100644
> index 000000000000..126518863eea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/arm,coresight-dummy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Coresight Dummy component
> +
> +description: |
> +  Coresight Dummy Trace Module is for the specific devices that kernel
> +  don't have permission to access or configure, e.g., CoreSight TPDMs
> +  on Qualcomm platforms. So there need driver to register dummy devices
> +  as Coresight devices. It may also be used to define components that
> +  may not have any programming interfaces (e.g, static links), so that
> +  paths can be established in the driver. Provide Coresight API for
> +  dummy device operations, such as enabling and disabling dummy devices.
> +  Build the Coresight path for dummy sink or dummy source for debugging. > +
> +  The primary use case of the coresight dummy is to build path in kernel
> +  side for dummy sink and dummy source.
> +
> +maintainers:
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Tao Zhang <quic_taozha@quicinc.com>
> +  - Hao Zhang <quic_hazha@quicinc.com>
> +  - Yuanfang Zhang <quic_yuanfang@quicinc.com>

Given this is a generic "CoreSight" component, I would prefer to have 
the CoreSight subsystem maintainers listed here (too). I don't mind
the entries above, but would like to make sure that the subsystem
people are aware of the changes happening here. Please use:

Mike Leach <mike.leach@linaro.org>
Suzuki K Poulose <suzuki.poulose@arm.com>
Leo Yan <leo.yan@linaro.org>

With the above:

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - arm,coresight-dummy-sink
> +          - arm,coresight-dummy-source
> +
> +  out-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port:
> +        description: Output connection from the source to Coresight
> +          Trace bus.
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +  in-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port:
> +        description: Input connection from the Coresight Trace bus to
> +          dummy sink, such as Embedded USB debugger(EUD).
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +
> +if:
> +  # If the compatible contains the below value
> +  properties:
> +    compatible:
> +      contains:
> +        const: arm,coresight-dummy-sink
> +
> +then:
> +  required:
> +    - in-ports
> +
> +else:
> +  required:
> +    - out-ports
> +
> +additionalProperties: false
> +
> +examples:
> +  # Minimum dummy sink definition. Dummy sink connect to coresight replicator.
> +  - |
> +    sink {
> +      compatible = "arm,coresight-dummy-sink";
> +
> +      in-ports {
> +        port {
> +          eud_in_replicator_swao: endpoint {
> +            remote-endpoint = <&replicator_swao_out_eud>;
> +          };
> +        };
> +      };
> +    };
> +
> +  # Minimum dummy source definition. Dummy source connect to coresight funnel.
> +  - |
> +    source {
> +      compatible = "arm,coresight-dummy-source";
> +
> +      out-ports {
> +        port {
> +          dummy_riscv_out_funnel_swao: endpoint {
> +            remote-endpoint = <&funnel_swao_in_dummy_riscv>;
> +          };
> +        };
> +      };
> +    };
> +
> +...

