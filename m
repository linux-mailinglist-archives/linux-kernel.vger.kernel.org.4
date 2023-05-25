Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01877104EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbjEYE5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEYEzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:55:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6502119A9;
        Wed, 24 May 2023 21:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63414642CF;
        Thu, 25 May 2023 04:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D842C433D2;
        Thu, 25 May 2023 04:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990316;
        bh=L6+h+9RDj4m+F/s1pLSzHonLLuW4an7ZQlZx1Wt57RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgjAsN/SWRp93k8YKH4h76hPZ+srHCrL/3UhSdfF9kBKJCg2x1pQ1/11MRnRKRsK8
         D09r0fQGeq29DDT618XTY1Grb8ggvX7K24EZCfSYdnBbjkH5hEZgaMoXKLiMte7mt3
         e1V9EAXg6NeDXDe9jP7hKO9odZ6lYiWzljsMoAYYKodlxeiMCfHCxqsOW73uWckRN9
         hVxWtBBgPEQdUWYPz9ggO/cSOpKJsrUcejli/KndmlKfZwc96sDtNhadNbuuYoTZR0
         Yhmht+Nm35D+HU//XUtEIVfb08v+cMgzhOiNPHOkbeDf7Ke7lRteqPE+582r3UtJ8W
         AwE6yqAj4VNDg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
        linux-clk@vger.kernel.org, Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: Re: (subset) [PATCH V2 0/4] Add Video Clock Controller driver for SM8550
Date:   Wed, 24 May 2023 21:54:34 -0700
Message-Id: <168499048180.3998961.13400067851752606700.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524145203.13153-1-quic_jkona@quicinc.com>
References: <20230524145203.13153-1-quic_jkona@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 20:21:59 +0530, Jagadeesh Kona wrote:
> Add bindings, driver and DT node for video clock controller on SM8550.
> Also, add support to configure PLL_TEST_CTL_U2 register for ole pll.
> 
> Depends on [1] for SM8450 videocc YAML file
> [1] https://patchwork.kernel.org/project/linux-clk/list/?series=750683
> 
> Jagadeesh Kona (4):
>   clk: qcom: clk-alpha-pll: Add support to configure PLL_TEST_CTL_U2
>   dt-bindings: clock: qcom: Add SM8550 video clock controller
>   clk: qcom: videocc-sm8550: Add video clock controller driver for
>     SM8550
>   arm64: dts: qcom: sm8550: Add video clock controller
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: sm8550: Add video clock controller
      commit: 22ff170d4551756e3e4ef57253c43e8c3fffefed

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
