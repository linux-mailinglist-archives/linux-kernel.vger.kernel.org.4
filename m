Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54335681FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjA3Xqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjA3Xq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:46:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED0C2B610;
        Mon, 30 Jan 2023 15:46:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7FFBB80E7B;
        Mon, 30 Jan 2023 23:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505BFC433EF;
        Mon, 30 Jan 2023 23:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675122374;
        bh=MrzmYuplehy47+jA2Yiiur0CaZV7d/G6CEmH37GtHDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OrmuO+15ACCEqvKhMq4ypFVtWcTzkeqlxW32fLL9B7Fvp6SCbDTyqxKFj7xXxtf6a
         H9vg9lfkrxs2x4jjoJPuiE7cNBgamiHVjV5X2t592jqUh2Rli6rhiKWalJJRfGTs2o
         IU2j69U7ehtsM9qTTO3rx6NOHAXkTAnLxw/Dhk5FjpAscYtAaUaqgeL1t4OQGIdBS3
         WNZpVBLg6vueIZxv5p5XW+O1HO8LT7vMADDo8FJDiINE/PZiBrZMb3n+NT4nF1Pg34
         q+E3z7h957jwtQBustKW5EckwWgkjhTlhlGDd+qww7ICxQ3m+T3wp2MVVGE3FIsQIo
         GwqHw4Gyx/y2g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski@linaro.org
Cc:     neil.armstrong@linaro.org, dmitry.baryshkov@linaro.org,
        sean@poorly.run, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, robdclark@gmail.com,
        freedreno@lists.freedesktop.org, marijn.suijten@somainline.org,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dianders@chromium.org, quic_rajeevny@quicinc.com,
        loic.poulain@linaro.org, quic_abhinavk@quicinc.com,
        swboyd@chromium.org
Subject: Re: (subset) [PATCH 1/8] drm/msm/dsi: Allow 2 CTRLs on v2.5.0
Date:   Mon, 30 Jan 2023 17:46:10 -0600
Message-Id: <167512236602.4092892.13590634993322919413.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
References: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 22:00:53 +0100, Konrad Dybcio wrote:
> v2.5.0 support was originally added for SC7280, but this hw is also
> present on SM8350, which has one more DSI host. Bump up the dsi count
> and fill in the register of the secondary host to allow it to probe.
> 
> This should not have any adverse effects on SC7280, as the secondary
> CTRL will only be touched if it's defined, anyway.
> 
> [...]

Applied, thanks!

[2/8] arm64: dts: qcom: sm8350: Add missing #address/size-cells to DSIn
      commit: 6636818ecf0f1d448360835017473cf94a0ee967
[3/8] arm64: dts: qcom: sm8350: Fix DSI1 interrupt
      commit: 1eed7995d9da0489e5a46c13bd888ffa987ead98
[4/8] arm64: dts: qcom: sm8350: Feed DSI1 PHY clocks to DISPCC
      commit: 0af6a4012b3815ebca7b8080a286edc01e4a89e1
[5/8] arm64: dts: qcom: sm8350: Fix DSI PHY compatibles
      commit: 45cd807de14388010a279765486c13f8ac540dfa
[6/8] arm64: dts: qcom: sm8350: Fix DSI PLL size
      commit: e3e654ced376060d64ede8e2dfde0b1bac0f9086
[7/8] arm64: dts: qcom: sm8350: Add mdss_ prefix to DSIn out labels
      commit: 2a07efb8c08619888428cc8fd47643c438111f29
[8/8] arm64: dts: qcom: sm8350: Hook up DSI1 to MDP
      commit: b904227a4b693fbb9d5eabc9d7100dc01d9eb973

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
