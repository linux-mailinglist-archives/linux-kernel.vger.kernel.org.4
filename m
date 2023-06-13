Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A7F72EF38
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbjFMW1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjFMW1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421BB19B1;
        Tue, 13 Jun 2023 15:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E9963B97;
        Tue, 13 Jun 2023 22:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C097C433CC;
        Tue, 13 Jun 2023 22:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695235;
        bh=MztiocY7xb0wufc97j90oPRRGblxlJnfLyoOMTxkpi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rin7MP/vuKCniAD1i7y8DOFjFTz+H89oqhqLhRO2TA824O5/qKvbrC+9A5qpoxBgv
         xMwu1GUgyfzJiWPkwsU4UZPFd7wksileHfV3el7RfGiiw9vG7Jw6ZIOQrAxapaG6us
         ce3gD2szqLbl9j1CtD1SiP+M1up7Rv+nyGZBsbFPvQerCUNMVS9Ao81QiYbVGmn7cG
         g54Aey9DwuGlhMfXBkMH8XmrYeLZiQGfZzTbf7fI+NLd+inxW3f5LhHEY276vAhbLL
         qbaPLs1FvNXtklZUhwQO23LbLbI/yIpkGzmBTN6hirZ78DWnruSaauRRnj0bEd/hQJ
         oRIVNwOJujv2g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Richard Acayan <mailingradian@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/8] Flush RSC votes properly on more RPMh platforms
Date:   Tue, 13 Jun 2023 15:30:13 -0700
Message-Id: <168669542895.1315701.12621649822300844348.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
References: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
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

On Wed, 31 May 2023 15:22:34 +0200, Konrad Dybcio wrote:
> As pointed out in [1], the Linux implementation of RSC basically requires
> (even if not explicitly) that we point it to a power domain which
> represents the power state of the CPUs. In an effort to fulfill that
> requirement, make it required in bindings and hook it up on all platforms
> where I was able to do. This means all RPMh platforms, except
> 
> - SC7180
> - SC7280
> - SA8775
> 
> [...]

Applied, thanks!

[2/8] arm64: dts: qcom: sm6350: Add PSCI idle states
      commit: ade89bc08c8e7f52ee8a70d0c6ea55c2defdf1d3
[3/8] arm64: dts: qcom: qdu1000: Flush RSC sleep & wake votes
      commit: ab033e7846f91953244d0626b28ce66412b813b3
[4/8] arm64: dts: qcom: sc8180x: Flush RSC sleep & wake votes
      commit: 442d55d099ed72d96aee996e56f802b5cf885f39
[5/8] arm64: dts: qcom: sdm670: Flush RSC sleep & wake votes
      commit: 7b04cbd81b0e60c5151a310e7b730dc4a951a211
[6/8] arm64: dts: qcom: sdm845: Flush RSC sleep & wake votes
      commit: 91e83140b5dd5598fbcfada3ee1f8b2b410c3731
[7/8] arm64: dts: qcom: sm6350: Flush RSC sleep & wake votes
      commit: 255c53df8ec3ea9f00765eb3dac02ccb705704dd
[8/8] arm64: dts: qcom: sm8550: Flush RSC sleep & wake votes
      commit: 4b2c7ac8e469ab7f92e50c34ad4012a77e79d078

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
