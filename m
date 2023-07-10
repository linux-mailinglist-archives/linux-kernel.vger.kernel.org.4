Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D8374CDAA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjGJGxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGJGxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:53:10 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Jul 2023 23:53:09 PDT
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D23B8;
        Sun,  9 Jul 2023 23:53:08 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 0BBDC400F4;
        Mon, 10 Jul 2023 11:34:05 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1688970846; bh=DND5rpm/wmgsLveMaPobuACP8Vr/HQmeyKyeNsCd8+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VatCx4zNsH8XVhtDNxxMbWubQSaBJWHv2qOvFQJfQjjrrc3MiDS/75JNYt2c/uQhW
         FUYY5uJ5wlFRyEE7nF1sA/j7HnSqWPm5MMOVYXydradsjlibExvSNRV/SI20ifKLH/
         DQJteOgLnHvSyWw6LLYJ9oIvKwRNlkFHdz0aRv+FIuIFsBq7/Q/TS7Upn2Uaqz2+Bq
         zkD7Lu/LMJOT33H6ev6pRbawd3rV+/nQKyCQVlV2Kimam72MCdEbuTm+EzFWJzE36r
         LKio3U6j2EfMhcnWp/eCEG1bsoUZKATUp0nQUFr5OHtNG6FfOqZcllcfOrsrtbe333
         KpyTN0MGCxVQA==
MIME-Version: 1.0
Date:   Mon, 10 Jul 2023 11:34:04 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     David Wronek <davidwronek@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: pm6150: Add resin and rtc nodes
In-Reply-To: <20230706124339.134272-6-davidwronek@gmail.com>
References: <20230706124339.134272-1-davidwronek@gmail.com>
 <20230706124339.134272-6-davidwronek@gmail.com>
Message-ID: <c4fa68f151b043bc60848f621b9aea66@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Wronek писал(а) 06.07.2023 17:40:
> Add support for the RTC which is the same as on other PMICs and add the
> resin child node to the PM6150 PON device and disable it by default.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>

Actually... (+CC CROS watchers) Doug, this would enable a somewhat
dubious RTC for trogdor devices. On qcom firmware the rtc is
forever write-protected but you run TF-A so maybe it's more
cooperative and you can add "allow-set-time" prop for trogdor, in
case qtiseclib doesn't mess with it? Or, alternatively, disable this
rtc for trogdor completely so it doesn't cause trouble?

In any case, on the WoA firmware and with userspace offset handling,
this works beautifully, so:

Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180, Aspire 1

Thanks!
> ---
>  arch/arm64/boot/dts/qcom/pm6150.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
> index 2e6afa296141..43c50f890e8b 100644
> --- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
> @@ -53,6 +53,14 @@ pm6150_pwrkey: pwrkey {
>  				bias-pull-up;
>  				linux,code = <KEY_POWER>;
>  			};
> +
> +			pm6150_resin: resin {
> +				compatible = "qcom,pm8941-resin";
> +				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				status = "disabled";
> +			};
>  		};
>  
>  		pm6150_temp: temp-alarm@2400 {
> @@ -88,6 +96,13 @@ pm6150_adc_tm: adc-tm@3500 {
>  			status = "disabled";
>  		};
>  
> +		rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
>  		pm6150_gpios: gpio@c000 {
>  			compatible = "qcom,pm6150-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
