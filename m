Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F4968FB3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBHXen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjBHXem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:34:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F901717E;
        Wed,  8 Feb 2023 15:34:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10F34B81FD1;
        Wed,  8 Feb 2023 23:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C29C433EF;
        Wed,  8 Feb 2023 23:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675899278;
        bh=6wbKxsXIaulmRW2LVZMnUfOpxaCc+tRBrnAiKoZtbI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XL6qQBQN+n1vtNRJRhiyZp43Z+JXniwNvGtoCVPZQKQkXgmorxWZcemsj6azqQ6Xt
         X/SaiwhdcA1TNiX0XSVKo7oNCJjwJEk+azMgp7xiSyL+iyOrD6Acc+43MO6rXEmn3C
         HICbyLh6UwyAnczhOtWjxJyjrxuu3f0JAaEY3PVV0st5Tof4fCy+Cp8uJBfjPaE/G+
         XRxmx5fecrMraRV4OJ8VnSMmb8ODo6rZsg8Y28Dr32M1ftMNA7qoQzA6T1SurCiA+1
         P0w7X0Y2KANKHuY4JynuVwONCbfSmhKwrp/rv1sljn2xYnSR28skx+0gIK6j4a8k8U
         uaXsLaT8FdpNw==
Date:   Wed, 8 Feb 2023 15:36:50 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: ipq5332: enable the download mode
 support
Message-ID: <20230208233650.fcgsfyz6aegjsing@ripper>
References: <20230130170155.27266-1-quic_kathirav@quicinc.com>
 <20230130170155.27266-3-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130170155.27266-3-quic_kathirav@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:31:54PM +0530, Kathiravan T wrote:
> Enable the support for download mode to collect the RAM dumps if
> system crashes, to perform the post mortem analysis.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 7f0ba2ec339c..6a1d0cc927ef 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -70,6 +70,7 @@
>  	firmware {
>  		scm {
>  			compatible = "qcom,scm-ipq5332", "qcom,scm";
> +			qcom,dload-mode = <&tcsr 0x0>;
>  		};
>  	};
>  
> @@ -142,6 +143,11 @@
>  				 <0>;
>  		};
>  
> +		tcsr: syscon@193d100 {
> +			compatible = "qcom,tcsr-ipq5332", "syscon";
> +			reg = <0x0193d100 0x4>;

Please map the entire TCSR_REGS here, and use qcom,dload-mode to encode
the offset within this.

Thanks,
Bjorn

> +		};
> +
>  		sdhc: mmc@7804000 {
>  			compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
>  			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
> -- 
> 2.17.1
> 
