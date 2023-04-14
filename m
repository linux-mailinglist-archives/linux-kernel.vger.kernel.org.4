Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D9D6E1AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 05:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjDNDdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 23:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjDNDdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31504ED8;
        Thu, 13 Apr 2023 20:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73344643A8;
        Fri, 14 Apr 2023 03:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9449BC433D2;
        Fri, 14 Apr 2023 03:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681443211;
        bh=zQ1T5RTb+RrMY2JnDGYIFwYF15LUKVpBvczjEj5kFYg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MUhPXB/w7hkEalJgISFC9D1IcD/w818lEiYisFqIesDygBD5AsJ+OmHyQMvWGVynb
         LqdGHaLEEvBiX7jwbH8N5Lx9lehI72Czr6SW4pm7T/J4vCq6r9oHVnPsGbwSzYr6cM
         36Dga9p+tArC+01KxM+gd0gJ6dwEqbGuocyz2hbWtgijMtaE8uYstpZDi76le4+Mwz
         ecnxbTIeXkNTzch7NAjPQ3pH2MkDWPtWtHmJOrr0AamYF3C1yEcPX+IUFKi2y5x1ly
         KrMM5gxtuN7kQ8jijpvu4gMWEUPitNnNv+GMKcOW1muuu9FL4q3+Ye/+3koqy4O+yt
         0pObnh8bHOsPg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     swboyd@chromium.org, konrad.dybcio@somainline.org,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, broonie@kernel.org,
        quic_visr@quicinc.com, agross@kernel.org, sboyd@kernel.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/3] Add resets for ADSP based audio clock controller driver
Date:   Thu, 13 Apr 2023 20:37:06 -0700
Message-Id: <168144342195.2459486.11052723951925664521.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407092255.119690-1-quic_mohs@quicinc.com>
References: <20230407092255.119690-1-quic_mohs@quicinc.com>
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

On Fri, 7 Apr 2023 14:52:52 +0530, Mohammad Rafi Shaik wrote:
> Add resets and remove qdsp6ss clock controller for audioreach based platforms.
> 
> Changes since v10:
>     -- drop #define macro for max_register.
>     -- Add max_register value for top_cc register.
> Changes since v9:
>     -- Drop "clk: qcom: lpassaudiocc-sc7280: Modify qcom_cc_probe" patch.
>     -- Update Fixes tag in Add the required gdsc's in lpass_cc_sc7280_desc patch.
>     -- Add the max_register value in Skip qdsp6ss clock registration patch.
> Changes since v8:
>     -- Add the required gdsc's in lpass_cc_sc7280_desc structure.
>     -- Modify qcom_cc_probe to qcom_cc_probe_by_index.
>     -- Update the commit message for v8,4/5 patch, which is not required for new logic.
>     -- Drop "Add binding headers for lpasscc" patch.
>     -- Drop "Skip lpass_aon_cc_pll config" patch.
> Changes since v7:
>     -- Modiy AHB clock probing method in "Merge lpasscc into lpass_aon patch".
>     -- Fix Typo errors in "Merge lpasscc into lpass_aon patch".
>     -- Update commit message in "Merge lpasscc into lpass_aon patch"
> Changes since v6:
>     -- Update commit message in "Merge lpasscc into lpass_aon patch" patch.
>     -- Drop "Skip lpasscorecc registration" patch.
>     -- Add comment in the code in "Skip lpass_aon_cc_pll config" patch.
> Changes since v5:
>     -- Fix compilation issue.
> Changes since v4:
>     -- Update Fixes tag in Merge lpasscc into lpass_aon patch.
>     -- Revert removal of clk_regmap structure in Merge lpasscc into lpass_aon patch.
> Changes since v3:
>     -- Remove duplicate clock resets patch.
>     -- Add binding headers for q6 clocks.
>     -- Create new patch for merging lpasscc q6 clocks into lpass_aon.
>     -- Create new patches for handling conflicts of ADSP and bypass solution.
> Changes since v2:
>     -- Revert removing qdsp6ss clock control.
>     -- Add Conditional check for qdsp6ss clock registration.
> Changes since v1:
>     -- Update commit message.
>     -- Remove qdsp6ss clock control.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: qcom,sc7280-lpasscc: Add qcom,adsp-pil-mode property
      commit: 5c3a7dcce10028c5839864ed475ae7930b03c1e8
[2/3] clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration
      commit: 4fc1c2d9a2b7a394f3b873aae5e03bffd8b5cd31
[3/3] clk: qcom: lpassaudiocc-sc7280: Add required gdsc power domain clks in lpass_cc_sc7280_desc
      commit: aad09fc7c4a522892eb64a79627b17a3869936cb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
