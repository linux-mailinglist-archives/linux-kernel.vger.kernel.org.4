Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8612F6BC4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCPDmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCPDmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:42:11 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F55A21283;
        Wed, 15 Mar 2023 20:42:09 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 7AB924185A;
        Thu, 16 Mar 2023 08:42:04 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1678938125; bh=6pk9hpmwNtX7vhwcoUeW8HT+8FwknLXWnSaWBaSxHrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VpQfQapYE72hY+So+UsW8WYWV4ouG5KWe7FiU5zeyqIPYnOxiXioRsY5wvGogQ/Yj
         PND/RuQ8WPIPxnhfzj9IzFz9Em3XBJC+8Ol/BL4mpXoCcgU6abBx4oOhkknsC0CMWS
         jj/hbgBt5NrsyKTDc02GBBjxssLqnrnhRVmRLgFE5P7eyIcDOmK3LsrlHVxYfHD3VJ
         j8f7e6hHpknZD5d5Ka5zNBsETPA4l/GZGyT7137iowBYeTnJpkNeowpIlbcWhj5ZO1
         I2qEU2lwIKIMeTp22CaGeLzXJI6+kSN04GgJLnPQ/3BbdBZXbdgBnOY4uN0059IQZR
         pDog1EeCwPU8w==
MIME-Version: 1.0
Date:   Thu, 16 Mar 2023 08:42:03 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: sc7180: Don't enable lpass
 clocks by default
In-Reply-To: <ZBJivckYK+JrGdG2@google.com>
References: <20230315154311.37299-1-nikita@trvn.ru>
 <20230315154311.37299-2-nikita@trvn.ru> <ZBJivckYK+JrGdG2@google.com>
Message-ID: <67077784fcf9aa928be9a6503e3d1e83@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Kaehlcke писал(а) 16.03.2023 05:28:
> On Wed, Mar 15, 2023 at 08:43:08PM +0500, Nikita Travkin wrote:
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
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index 53f0076f20f6..f0de177981f9 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -3623,6 +3623,8 @@ lpasscc: clock-controller@62d00000 {
>>  			power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
>>  			#clock-cells = <1>;
>>  			#power-domain-cells = <1>;
>> +
>> +			status = "reserved"; /* Controlled by ADSP */
> 
> Why not "disabled"? I see "reserved" is used in a couple of other
> instances, but it doesn't appear in Documentation/devicetree/bindings/,
> so it doesn't seem to have a well defined meaning that distinguishes it
> from "disabled".

Hi, the standard properties like this one are defined in the
Devicetree specification, notably chapter 2.3.4 "status" says:

  "reserved" Indicates that the device is operational, but should
  not be used. Typically this is used for devices that are controlled
  by another software component, such as platform firmware.

On the contrary,

  "disabled" Indicates that the device is not presently operational (...)

Since the hardware is operational but is controlled by "foreign"
firmware, I believe "reserved" state is more correct here.

Thanks for looking at the patch!
Nikita

> 
>>  		};
>>
>>  		lpass_cpu: lpass@62d87000 {
>> @@ -3671,6 +3673,8 @@ lpass_hm: clock-controller@63000000 {
>>
>>  			#clock-cells = <1>;
>>  			#power-domain-cells = <1>;
>> +
>> +			status = "reserved"; /* Controlled by ADSP */
>>  		};
>>  	};
>>
>> --
>> 2.39.2
>>
