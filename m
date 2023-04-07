Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79606DA839
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 06:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjDGESu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 00:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjDGESn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 00:18:43 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E86E82;
        Thu,  6 Apr 2023 21:18:35 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 5B25241352;
        Fri,  7 Apr 2023 09:18:30 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1680841112; bh=e6KYdthnog///fCvA7GhcHBk9WCpwTdwqv+2kcPLjxk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yW3YOfWnOtfjhaAwLtivKyWClbXHbyZyGaX07DGfG6pZzLT5Dy4bHdFUy9P1rPqNR
         MQhFdmKmYupa8LnI1OXeSwKbjzwyR+tG7N4Mf+b+yVAuTMGyW9oT2dnZeOs3wZ4psg
         zgFjeJXNyZVZFgnlUDKvJotEVUjL9uFtWddGhVGZ1Th++EjC8XiLouyeqlZD3jUUcg
         DbZ9NGX3q+vraWp2L+hY8l6FgMJ3qFnMS0ify4qjvqbT0PtIWce3IRhqPBD69Y5vH5
         175Zq/6fJDZZwyIKqH/58IFvdswL+oAaqx8BK/zRYOB0UWPRTonZZ+gE2y+pW5aYRQ
         b+PaWjAEwaMsg==
MIME-Version: 1.0
Date:   Fri, 07 Apr 2023 09:18:30 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, quic_srivasam@quicinc.com,
        judyhsiao@chromium.org, mka@chromium.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 1/4] arm64: dts: qcom: sc7180: Don't enable lpass
 clocks by default
In-Reply-To: <7bec0262-8a20-9b6a-599f-5ba759e6bd6b@linaro.org>
References: <20230406150633.83351-1-nikita@trvn.ru>
 <20230406150633.83351-2-nikita@trvn.ru>
 <7bec0262-8a20-9b6a-599f-5ba759e6bd6b@linaro.org>
Message-ID: <15c96acc4d502795b08c9b264efa7082@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 07.04.2023 00:31:
> On 6.04.2023 17:06, Nikita Travkin wrote:
>> lpass clocks are usually blocked from HLOS by the firmware and
>> instead are managed by the ADSP. Mark them as reserved and explicitly
>> enable in the CrOS boards that have special, cooperative firmware.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
>>  arch/arm64/boot/dts/qcom/sc7180.dtsi         | 4 ++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> index 423630c4d02c..26def6e12723 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> @@ -785,6 +785,14 @@ alc5682: codec@1a {
>>  	};
>>  };
>>
>> +&lpasscc {
>> +	status = "okay";
>> +};
>> +
>> +&lpass_hm {
>> +	status = "okay";
>> +};
>> +
>>  &lpass_cpu {
>>  	status = "okay";
>>
> _hm should come after _cpu alphabetically
> 

Oops, will fix, thanks!

> w/ that
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index 3c799b564b64..6f40301faa1c 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -3621,6 +3621,8 @@ lpasscc: clock-controller@62d00000 {
>>  			power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
>>  			#clock-cells = <1>;
>>  			#power-domain-cells = <1>;
>> +
>> +			status = "reserved"; /* Controlled by ADSP */
>>  		};
>>
>>  		lpass_cpu: lpass@62d87000 {
>> @@ -3669,6 +3671,8 @@ lpass_hm: clock-controller@63000000 {
>>
>>  			#clock-cells = <1>;
>>  			#power-domain-cells = <1>;
>> +
>> +			status = "reserved"; /* Controlled by ADSP */
>>  		};
>>  	};
>>
