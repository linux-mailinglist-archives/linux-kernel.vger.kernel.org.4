Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F5C713258
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjE0D5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjE0D47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:56:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC173A3;
        Fri, 26 May 2023 20:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8120F64FF3;
        Sat, 27 May 2023 03:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D7EC433D2;
        Sat, 27 May 2023 03:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685159815;
        bh=gYYuQfw+qiqjwRtGrHsitvZtkzNXkhUWtUh+q9gcwxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2DBWNKSxIxZy9UI2Acbi4FkUe5d2UWgCfNAG/gs1FYF/9109I/FYCwG9PS2kE1Ez
         Y589NqoGj9y6oPBacA5S2UMRxWfiCZrzUA6GC51cfrdj4TNK+f+6B4QZmJW4tneypF
         1gd+DZBLjbvzyy3GAwiCKym9TEI626lkn0k8PSPsWZYVevjuwIk0IK041PViSSMm3P
         jWaTGy+6ALHNjNqsfC9sjs4rKS+w3+bCKMcR8yi6c9g/+pfp83sx1sHSeQ3MCZx+Cx
         iH/JZFcLm8tciAcB/zFuENmflZm11gkVNgM4Hv4t54HXwS4Kb0L4XaptZGxeJAMAYu
         X/8WG0Ghp8bxw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Imran Shaik <quic_imrashai@quicinc.com>
Subject: Re: (subset) [PATCH V2 0/3] Add graphics clock controller support for SM8550
Date:   Fri, 26 May 2023 21:00:37 -0700
Message-Id: <168516003598.405989.523653148468388499.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524181800.28717-1-quic_jkona@quicinc.com>
References: <20230524181800.28717-1-quic_jkona@quicinc.com>
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

On Wed, 24 May 2023 23:47:57 +0530, Jagadeesh Kona wrote:
> Add bindings, driver and devicetree node for graphics clock controller on SM8550.
> 
> Depends on [1] and [2] for PLL_TEST_CTL_U2 programming and SM8450 GPUCC YAML file
> [1] https://patchwork.kernel.org/project/linux-clk/list/?series=750700
> [2] https://patchwork.kernel.org/project/linux-clk/list/?series=748562
> 
> Jagadeesh Kona (3):
>   dt-bindings: clock: qcom: Add SM8550 graphics clock controller
>   clk: qcom: gpucc-sm8550: Add support for graphics clock controller
>   arm64: dts: qcom: sm8550: Add graphics clock controller
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sm8550: Add graphics clock controller
      commit: 9f7579423d2d619064dc84cfa8068e3c83b09e3f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
