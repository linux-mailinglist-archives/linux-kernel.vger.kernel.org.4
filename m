Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944515EB8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiI0DZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiI0DX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:23:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E7F5C37A;
        Mon, 26 Sep 2022 20:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A31F061585;
        Tue, 27 Sep 2022 03:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD677C43143;
        Tue, 27 Sep 2022 03:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664248995;
        bh=MbHislodbHWamvfQ72iARjTJC113lxMjN7t13HcDaCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aApuCfnscjtUP2X01tAoaY7Z3EPOKYw0faY5GFVVDcrcGFIvI16MkQ5aeGM/Vgbyd
         hMFfghzbzr3Fy4LCq1KZ0LKJHqpS5Lbgd5lY88Qk2VytxWM8wLvFKS8KYEz/6WBqkO
         QvNp5/cFvdXETXUdw99tay5DRtwic5CxvEWKtIYZf0oc4Rq0HpEf+TkP60us85GGoy
         6FqXrvRGCgnyibz1s8ms4H4CSex1zCn9F+WiW+LkfU3mfo8VWCi7vKiutlK5b46WpM
         mA1Busa6JAsdLJ6A9ZQKhBt5cbliFdzpJdinP561ei7T4OamZ7eHAj3PSs+mozDi6/
         F3lgtF/WAoewA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     loic.poulain@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, Bjorn Andersson <andersson@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        sboyd@kernel.org, yassine.oudjana@gmail.com
Cc:     y.oudjana@protonmail.com, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org,
        angelogioacchino.delregno@somainline.org,
        jami.kettunen@somainline.org, linux-clk@vger.kernel.org,
        martin.botka@somainline.org, dmitry.baryshkov@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 0/6] clk: qcom: msm8996-cpu: Cleanup and migrate to parent_data
Date:   Mon, 26 Sep 2022 22:23:04 -0500
Message-Id: <166424897968.1766486.11324579765862390238.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220621160621.24415-1-y.oudjana@protonmail.com>
References: <20220621160621.24415-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 20:06:15 +0400, Yassine Oudjana wrote:
> This series includes some cleanup of the MSM8996 CPU clock driver, as well as
> migration from parent_names to parent_data for all of its clocks. The DT schema
> is also fixed in this series to show the actual clocks consumed by the clock
> controller and pass checks.
> 
> Yassine Oudjana (6):
>   clk: qcom: msm8996-cpu: Rename DIV_2_INDEX to SMUX_INDEX
>   clk: qcom: msm8996-cpu: Statically define PLL dividers
>   clk: qcom: msm8996-cpu: Unify cluster order
>   clk: qcom: msm8996-cpu: Convert secondary muxes to clk_regmap_mux
>   dt-bindings: clock: qcom,msm8996-apcc: Fix clocks
>   clk: qcom: msm8996-cpu: Use parent_data for all clocks
> 
> [...]

Applied, thanks!

[1/6] clk: qcom: msm8996-cpu: Rename DIV_2_INDEX to SMUX_INDEX
      commit: 1ba0a3bbd5ed5a1bb8d0165912d9904b812af74b
[2/6] clk: qcom: msm8996-cpu: Statically define PLL dividers
      commit: de37e0214c28330cf0dbf4fe51db1d9d38c13c93
[3/6] clk: qcom: msm8996-cpu: Unify cluster order
      commit: 382139bfd68fe6cc9dc94ffe3b9d783b85be3b1c
[4/6] clk: qcom: msm8996-cpu: Convert secondary muxes to clk_regmap_mux
      commit: 9a9f5f9a5a0ca3f463eb28ba5920a6fd18dc9956
[5/6] dt-bindings: clock: qcom,msm8996-apcc: Fix clocks
      commit: b4feed4a3d0a6b8cef4a574a9df707c556928ec2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
