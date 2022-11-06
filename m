Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70A461E03B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 05:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiKFEAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 00:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFEAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 00:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FE1E0DB;
        Sat,  5 Nov 2022 21:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A80F60BCA;
        Sun,  6 Nov 2022 04:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A7DC433C1;
        Sun,  6 Nov 2022 04:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667707214;
        bh=E1AzEct0O10uZX3FImOAaMkHS+fAyEb2/HkDnc+nDfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWXKgA5gSv2SVbSf5ZqCSYaiUUavKroPRw5IB+4REqTY2Z9mVE3HGzaSOHhRfAPIY
         /nzCaKFRUL3I9FA4NwHFsVUcsQ9mCsDuMUbzy8G63/NbaPtEgJ6TNpCcyPcAcHz1ho
         NBuEOAdMauWdwLlZ8jJSeqvqwCgciHK3nyJrWTvH7uDvnQXncauu7dmgDf5WlFy+zc
         l6wjfVygZBoWlBYeHTkJz+31PtOKS/JM4NB5Rqn/CxuE0vnguRzlzWZL5/TSDYO8pX
         i54StkLlddbTKqAc6jqB4ZbEE8b8Frq7he7OxXbaDGA4//ZPqUwh42qn0Uv7QpkAcr
         FkzMkRZ40kbWA==
Date:   Sat, 5 Nov 2022 23:00:11 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add initial device tree for SM6375
Message-ID: <20221106040011.rbqginfdwvkmasy3@builder.lan>
References: <20221022194218.210941-1-konrad.dybcio@somainline.org>
 <20221022194218.210941-3-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022194218.210941-3-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 09:42:16PM +0200, Konrad Dybcio wrote:
[..]
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +			clock-output-names = "xo_board";

The only reason that you would need this is if you have code somewhere
relying on clock lookup based on global naming. Can you please fix that
up and drop clock-output-names?

A -clk suffix would be nice on the node as well (xo-board-clk).

> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +	};
[..]
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		hyp_mem: memory@80000000 {

I believe "memory" is still reserved, so please rename these nodes.

> +			reg = <0 0x80000000 0 0x600000>;
> +			no-map;
> +		};
> +
[..]
> +	smem: smem {
> +		compatible = "qcom,smem";

Please move the compatible and hwlocks to the &smem_mem node directly.

> +		memory-region = <&smem_mem>;
> +		hwlocks = <&tcsr_mutex 3>;
> +	};

Regards,
Bjorn
