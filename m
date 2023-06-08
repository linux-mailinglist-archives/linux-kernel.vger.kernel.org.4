Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A590E727FB1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjFHMOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjFHMOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:14:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A3184;
        Thu,  8 Jun 2023 05:14:04 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63A0E6606EF9;
        Thu,  8 Jun 2023 13:14:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686226443;
        bh=ngSvI4aezt9aOvaiq1z7uwbLyB+T//8r6HBFM3EABh4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jlqNziZ+Uk43sIsUE1CUWBbr3v3utLbiMF3K3RbR7RmyJ8nyiOqEBq04/GHeHunSE
         2W26TlABa+BsTAbVdqgrh/xcNwCt8h736g3QW66HehbzgRsXiJNz40up/ydF/KY9be
         gFtxJfwN4NjDiNF6s+C32j/DN1BQp+V6lmFeNhUvNg8KMo9QfAL+r/unueg+OzEgXq
         u3Pm33hxCmn3ZHinMoPeNraM4j7c62kGUDrTyBnMMwKQNgO/ViHTZtcEUaosi7D7p4
         X5FSxOUAJ+TibDRnyyF8K4QFbMDS7ADwQF8l6xiTNeBaLVsa4iBIEDJwTl+0P3Z0vo
         gBkwts/PPdgcw==
Message-ID: <b61c7d8c-85e7-2248-d386-ffec8c275aa4@collabora.com>
Date:   Thu, 8 Jun 2023 14:13:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: mt8186: Wire up GPU
 voltage/frequency scaling
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230607090653.2468317-1-wenst@chromium.org>
 <20230607090653.2468317-5-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230607090653.2468317-5-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/23 11:06, Chen-Yu Tsai ha scritto:
> Add the GPU's OPP table. This is from the downstream ChromeOS kernel,
> adapted to the new upstream opp-supported-hw binning format. Also add
> dynamic-power-coefficient for the GPU.
> 
> Also add label for mfg1 power domain. This is to be used at the board
> level to add a regulator supply for the power domain.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 140 ++++++++++++++++++++++-
>   1 file changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index c58d7eb87b1d..a34489e27cd4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -695,6 +695,142 @@ clk32k: oscillator-32k {
>   		clock-output-names = "clk32k";
>   	};
>   
> +	gpu_opp_table: opp-table-gpu {
> +		compatible = "operating-points-v2";
> +
> +		opp-299000000 {
> +			opp-hz = /bits/ 64 <299000000>;
> +			opp-microvolt = <612500>;
> +			opp-supported-hw = <0x38>;

For all of the OPPs that are supposed to be supported by all speed-bins, you don't
need to restrict them to all "known" bins.

Please change opp-supported-hw from <0x38> to <0xff>, which literally means
just "applies to all revisions".

> +		};


..snip...

> +
> +		opp-900000000-3 {

What about calling those like "opp-900000000-bin3"?
Makes it clear that it's tied to what MediaTek calls a speedbin "3" (as we're
interpreting the values in the nvmem driver to make them compatible with the
opp-supported-hw's expectations).

Cheers,
Angelo
