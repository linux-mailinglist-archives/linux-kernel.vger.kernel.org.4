Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55035644865
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiLFPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiLFPup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:50:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBD8286F3;
        Tue,  6 Dec 2022 07:50:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 46BB1CE1AA0;
        Tue,  6 Dec 2022 15:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F47C433D6;
        Tue,  6 Dec 2022 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670341838;
        bh=Lj2AgPuSS1nLJarVgLSzu/xvELPShrddWyR+LudDQ3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NR/Mc933id1B25zOxnmFozbzAfD623Dfw8D74azK8Uu4kJV75MOXKMPXmqbKJsWcb
         VidUV10SaaSVWgqlegrsAkZJyaufh6UsYUZbbvWXqEsgus5bTlOA+enAloEhzISM8c
         i6TIQyehb7lwgF3enwFmzy8mbourV6JQTwMlfhdKiML17DlZe3YuS3906i+B5i8pMx
         YPIyW1ToSaBgZnfui+Ua05/PWysTXZWzgYid8cHXJFXlRtMVRine3DUmDHtU+rGOKZ
         2JsX4sSGYRhYTQLOY6mO2HpuJm5vnaDY4LzHSt2rS3hqLMtUBnWoInhz30slVtwD0x
         cSJLaNnQAG/aA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p2aDW-0005zC-EG; Tue, 06 Dec 2022 16:50:46 +0100
Date:   Tue, 6 Dec 2022 16:50:46 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_shazhuss@quicinc.com,
        psodagud@quicinc.com, ahalaney@redhat.com, echanude@redhat.com
Subject: Re: [PATCH v3] arm64: dts: qcom: sa8540p-ride: enable PCIe support
Message-ID: <Y49k1k8ayI9/rK+R@hovoldconsulting.com>
References: <20221202120918.2252647-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202120918.2252647-1-bmasney@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 07:09:18AM -0500, Brian Masney wrote:
> Add the vreg_l11a, pcie3a, pcie3a_phy, and tlmm nodes that are necessary
> in order to get PCIe working on the QDrive3.

> @@ -158,6 +186,31 @@ &remoteproc_nsp1 {
>  	status = "okay";
>  };
>  
> +&tlmm {
> +	pcie3a_default: pcie3a-default-state {
> +		perst-pins {
> +			pins = "gpio151";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		clkreq-pins {
> +			pins = "gpio150";
> +			function = "pcie3a_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		wake-pins {
> +			pins = "gpio56";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +};
> +

The pin configuration nodes typically go last after a

	/* PINCTRL */

delimiter as this section tends to become rather long.

>  &ufs_mem_hc {
>  	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;

Johan
