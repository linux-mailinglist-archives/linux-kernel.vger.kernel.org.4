Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255E6A3FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjB0Kot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjB0Kon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:44:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82465B455;
        Mon, 27 Feb 2023 02:44:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 511B5C14;
        Mon, 27 Feb 2023 02:45:24 -0800 (PST)
Received: from [10.57.91.127] (unknown [10.57.91.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B4E83F881;
        Mon, 27 Feb 2023 02:44:38 -0800 (PST)
Message-ID: <3c3c55a8-8979-76f9-3b61-31c50ceefd33@arm.com>
Date:   Mon, 27 Feb 2023 10:44:28 +0000
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
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        Tao Zhang <taozha@qti.qualcomm.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
 <1674114105-16651-2-git-send-email-quic_taozha@quicinc.com>
 <c55483da-8fa7-67d3-041d-930607768a2a@arm.com>
 <7195d3dd-8c39-00c5-5037-5d6d01698cf5@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <7195d3dd-8c39-00c5-5037-5d6d01698cf5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 03:07, Tao Zhang wrote:
> Hi Suzuki,
> 
> 在 2/22/2023 2:11 AM, Suzuki K Poulose 写道:
>> On 19/01/2023 07:41, Tao Zhang wrote:
>>> Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
>>> Bit) element for TPDA. Specifies the DSB element size supported
>>> by each monitor connected to the aggregator on each port. Should
>>> be specified in pairs (port, dsb element size).
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
>>> ---
>>>   .../bindings/arm/qcom,coresight-tpda.yaml          | 22 
>>> ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml 
>>> b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>>> index 2ec9b5b..298db7f 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>>> @@ -58,6 +58,26 @@ properties:
>>>       minItems: 1
>>>       maxItems: 2
>>>   +  qcom,dsb-element-size:
>>> +    description: |
>>> +      Specifies the DSB(Discrete Single Bit) element size supported by
>>> +      each monitor connected to the aggregator on each port. Should be
>>> +      specified in pairs <port, dsb element size>.
>>
>> Isn't this a property of the TPDM connected to the port ? i.e. the DSB 
>> size ? Thus shouldn't this be part of the TPDM device (and the TPDA 
>> will be able to find it from the TPDM device) ?
>>
> Since  the port number is about the input port of TPDA, this property 
> needs to be configured in the TPDA-related settings.

That is because, you chose to describe the property of TPDM in TPDA ?
Instead if you do it as follows :

  tpdm {
        qcom,tpdm-dsb-elemenet-size = <32>
        out_ports {

	port {
              remote-endpoint=<&tpda_port_number>;
	}
  }

  tpda {
        in_ports {
            port {
                  remote-endpoint=<&tpdm0_port0>;
            }
        }
  }


The TPDA driver can figure out the "port" that a given TPDM is connected
to and thus find out the DSB size. For the tpda driver, pdata->conns
could hold the reference to the TPDM device and thus fetch the DSB size.
(Note: James is working on a patch to add input port connections to the
platform data).

Suzuki

