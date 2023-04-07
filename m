Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0FE6DB1CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDGRis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjDGRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:38:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FC3BB92;
        Fri,  7 Apr 2023 10:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F41B612B8;
        Fri,  7 Apr 2023 17:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB52C4339C;
        Fri,  7 Apr 2023 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889113;
        bh=1G/0q1PmMTKTGGQ7jW9JhNzxGtHF75wxfJBUD8OFHxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KylqOCQ+CFTC7v/OPqOXddLMRlIGLuh5IhbD7wxI9lfoeCB8upsBiq/6BmIVBe7Ww
         k3YNQS1fHtsVz6ECBKVAKXOVBnDakxx+7cSsQwuO5c13TJao9SBFjoRgN1UJvoU7bR
         edEcuOEUUcmPI3QBbITLU/vo7AYv4n3APLGBwOXFczYOEcH2uJ67dcXmUy+YYYYiyF
         yQ4k8mfccY1F+bUpcF5KHL2JedS3Wam2PBUNePc6rMvLlRL5GwCUkAbv1prTzLCL4/
         iT6yjv8fUrTm/GIOHwfNBFZ5dlj7jTHkJ+tCRHGUy1fCrhOAg/8A2BGrYCyUwX3ZML
         oBVE5lZnt+kHw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v6 0/9] Fix DSI host idx detection on HW revision clash
Date:   Fri,  7 Apr 2023 10:41:10 -0700
Message-Id: <168088927578.2561591.16211627310049586642.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307-topic-dsi_qcm-v6-0-70e13b1214fa@linaro.org>
References: <20230307-topic-dsi_qcm-v6-0-70e13b1214fa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Mar 2023 14:42:46 +0100, Konrad Dybcio wrote:
> v5 -> v6:
> - Squash both fixes that concerned the deprecated QCM2290 compatible to
>   avoid warnings
> 
> v5: https://lore.kernel.org/r/20230307-topic-dsi_qcm-v5-0-9d4235b77f4f@linaro.org
> 
> v4 -> v5:
> - Drop superfluous items: level in [8/10]
> - Remove the header define for the qcm2290 config in [6/10] instead of
>   [7/10]
> - Pick up tags
> 
> [...]

Applied, thanks!

[9/9] arm64: dts: qcom: sm6115: Use the correct DSI compatible
      commit: 1e6e0c1c971e5e02047a05c015510cc203530dc2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
