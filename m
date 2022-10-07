Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E0B5F7DFB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJGT3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJGT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:29:50 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297EF12AA2;
        Fri,  7 Oct 2022 12:29:46 -0700 (PDT)
Received: from [192.168.1.101] (95.49.30.201.neoplus.adsl.tpnet.pl [95.49.30.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 734172006C;
        Fri,  7 Oct 2022 21:29:42 +0200 (CEST)
Message-ID: <18771e86-4633-fcf5-0ae1-ecaae515eb2b@somainline.org>
Date:   Fri, 7 Oct 2022 21:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix ufs_card_phy ref clock
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221005143305.388-1-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221005143305.388-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.10.2022 16:33, Johan Hovold wrote:
> The GCC_UFS_REF_CLKREF_CLK must be enabled or the second UFS controller
> fails to enumerate on sa8295p-adp.
> 
> Note that the vendor kernel enables both GCC_UFS_REF_CLKREF_CLK and
> GCC_UFS_1_CARD_CLKREF_CLK and it is possible that the former should be
> modelled as a parent of the latter. The clock driver also has a
> GCC_UFS_CARD_CLKREF_CLK clock which the firmware appears to enable on
> the ADP.
My guess would be that XBL/whatever other bootloader enables all of them as
it scans for bootable devices and only gates one afterwards..


Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
> 
> The usual lack of documentation for Qualcomm SoCs makes this a highly
> annoying guessing game, but as the second controller works on the ADP
> without either card reference clock enabled, only enable
> GCC_UFS_REF_CLKREF_CLK for now.
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> The related issue for the first controller is being fixed here:
> 
> 	https://lore.kernel.org/lkml/20220830180120.2082734-1-bmasney@redhat.com/T/#u
> 
> Johan
> 
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index cf7ef37c11ec..917f1feac6ac 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -960,7 +960,7 @@ ufs_card_phy: phy@1da7000 {
>  			ranges;
>  			clock-names = "ref",
>  				      "ref_aux";
> -			clocks = <&gcc GCC_UFS_1_CARD_CLKREF_CLK>,
> +			clocks = <&gcc GCC_UFS_REF_CLKREF_CLK>,
>  				 <&gcc GCC_UFS_CARD_PHY_AUX_CLK>;
>  
>  			resets = <&ufs_card_hc 0>;
