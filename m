Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946557088F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjERUE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjERUEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA891BE3;
        Thu, 18 May 2023 13:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33006651ED;
        Thu, 18 May 2023 20:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7651DC433EF;
        Thu, 18 May 2023 20:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684440243;
        bh=5Cwrl8qfQUwlL/4Y2HNNh/JLjDgfYvj5/BvX1qUp3vQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lULwo02jjg6Q+XQ49XAielxqIkf12ZkVPnxekxZMQFxIyjeWy/ubinuxBGiywlo5U
         wbDqXneLApdcxGsO2+lyyDU3pHrOBAm7FShubdOG4Ji+IGIiaNspz//sw5pK/SvVAm
         8W2pOKfmSZrm1nh1jeHm7cnlL/lCX8G5FFCfPN9qCYkTFHvbUIRao/mww8SbBUxneP
         7lvJAesnzvHVNe3C77/zCYBpEYT5TKDbB/+sFNdMOptFRQYQG4+1g+9sL375ynbnKZ
         dOecIBFwjSCX7aAOTyU3lPV5F+zcf0sNnsdKAp6md8hxrhk7MsrfBWWMZxOf3IVamF
         HPhYB1W1QswWg==
Date:   Thu, 18 May 2023 21:03:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     broonie@kernel.org, support.opensource@diasemi.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH] ASoC: dt-bindings: dialog,da7219: convert to dtschema
Message-ID: <ZGaErqQ8lgtAofYB@spud>
References: <20230518091449.17984-1-David.Rau.opensource@dm.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518091449.17984-1-David.Rau.opensource@dm.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 09:14:49 +0000, David Rau wrote:
> - Convert Dialog DA7219 bindings to DT schema format.
> - Add Jack insertion detection polarity selection.
> - Remove unused `dlg,ldo-lvl` parameter.
> 
> Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
> ---
>  .../devicetree/bindings/sound/da7219.txt      | 112 --------
>  .../bindings/sound/dialog,da7219.yaml         | 240 ++++++++++++++++++
>  2 files changed, 240 insertions(+), 112 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/da7219.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/dialog,da7219.yaml
> 

(partially sending this to make sure that I can actually send these
things during Rob & Krzysztof's absence)

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1783077


da7219@1a: interrupts: [[165, 8], [165, 0]] is too long
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtb
