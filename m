Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A654B7104DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbjEYE46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbjEYEzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0671319A1;
        Wed, 24 May 2023 21:52:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7227642C9;
        Thu, 25 May 2023 04:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22215C4339E;
        Thu, 25 May 2023 04:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990314;
        bh=NSC4pjehFfVtJ5DaxczyPgrt4u9H9EZeSmaCU9zLt+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVDjIbMBQrkX5Vk5HDOTMaiB17eA5nUyNZ879jhWoiysIyWz6OjYILefxcPvEELoM
         o/AoJkWg/PQh9bTbCuwLhbubOrwQtp/dhhsqkMf3476h2sOD7NbjbzXPbEysnQhZ5e
         Wag4OlM7/OI1VTW0kfOIHQd76XhN5Nv+xYiUYy+IsydmV7MkEOKBQaOVozx2bG2pJQ
         ibDs9b7P1XnFB/+QPlEnKXxsDPyIXbiNHs4nTmOFsE4ZZsDz9C8OJUFK718ZUy/ocQ
         CJSPRKGZCbU8L72/i6uwLTzozW7yDpNEbC+sFpT+ScUhA5UIRU1CCk5FXW86PWKpdx
         /GjdV1CseTycg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, Nikita Travkin <nikita@trvn.ru>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_srivasam@quicinc.com,
        judyhsiao@chromium.org, dianders@chromium.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, cros-qcom-dts-watchers@chromium.org,
        konrad.dybcio@linaro.org, mka@chromium.org
Subject: Re: [PATCH v6 RESEND 0/4] Add Acer Aspire 1
Date:   Wed, 24 May 2023 21:54:32 -0700
Message-Id: <168499048185.3998961.7514406873063517250.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515093744.289045-1-nikita@trvn.ru>
References: <20230515093744.289045-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 14:37:40 +0500, Nikita Travkin wrote:
> This series introduces Acer Aspire 1 - A WoA laptop with sc7180.
> 
> The dts adds mostly complite support for the hardware and the device,
> with minor patches on top, can be used as a normal laptop daily.
> 
> Notable features absent from this patch:
> - Sound
>    While the dedicated sound components are defined, since the
>    ADSP must be used, sound requires additions of that remoteproc
>    as well some extra "glue" to connect the i2s outputs to it.
>    I was able to hack together some sound based on sm8250 stuff
>    but it needs more work.
> - Embedded Controller
>    The laptop has a dedicated EC that controls, notably,
>    battery/charger and notifies the device about the USB-C DisplayPort
>    HPD events. As per this patch, there is no battery status
>    indication and external display support. Also, due to the EC
>    defaults, the fn key is disabled. I have an experimental driver that
>    implements all of that, which needs more work and will be submitted
>    at a later date.
> - PSCI OSI Mode
>    Firmware on this laptop does not support the PC mode, as is usual
>    for Qualcomm. This change would require adding OSI related
>    power-domains to the SoC dtsi and is omitted in expectation that
>    this can be handled when (if?) CrOS team handles their tf-a, like
>    they did with sc7280.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sc7180: Don't enable lpass clocks by default
      commit: 43926a3cb19180b4fc6cd0d72bbefc7e93592f91
[2/4] arm64: dts: qcom: sc7180: Drop redundant disable in mdp
      commit: 39238382c4991d7d9442de4aa6636b19355be1e9
[3/4] dt-bindings: arm: qcom: Add Acer Aspire 1
      commit: aaffd364118bbc5b20c0a92f82780ea22e1c3f07
[4/4] arm64: dts: qcom: Add Acer Aspire 1
      commit: 4a9f8f8f2adaa05abfdec7c588c8dab3281048f0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
