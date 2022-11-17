Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B05062E1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbiKQQ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiKQQ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B82BBE33;
        Thu, 17 Nov 2022 08:25:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D78D3CE1E7F;
        Thu, 17 Nov 2022 16:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA29C433C1;
        Thu, 17 Nov 2022 16:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702308;
        bh=Z0xBqZcccm8SbVQrnC5CSdtczjQ3AfNDFzFjDM6WrAc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZqKl3wWu7HA5rheHtNtCjwIkojZDp/bll/jjsfgjdxy6sMKWqMauxH3cOkjmoIAEA
         J3t10xflavu1kM/j1mq7Ff8FaoFOLz+TzXDRD1qTmWfvT+HMEDD/ij8GpSznUXEuKR
         5CAprSniDajdEiztK25t9dOkn6KFkBuuIHYsWQk40xTRnhBZK2RHyBTHoY+oragxER
         IjNaUEewT4SZkl0FlWR+iCR3Sq8Lxravlzx9jrTWeb46ysi4fkl9hPUjNY5E5gsgg4
         eM6iuk9VKnL7+wt+HqUDoULRHVDm2ecgJleLrjjgGUyveMvPEosCJqiGDFjXXn2zDo
         kg4E0vQjnNQMQ==
Message-ID: <59715ef2-3335-7f8e-54f1-c4315ceba232@kernel.org>
Date:   Thu, 17 Nov 2022 18:25:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/10] interconnect: osm-l3: SC8280XP L3 and DDR
 scaling
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20221111032515.3460-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.22 5:25, Bjorn Andersson wrote:
> The SC8280XP currently shows depressing results in memory benchmarks.
> Fix this by introducing support for the platform in the OSM (and EPSS)
> L3 driver and support for the platform in the bwmon binding.
> 
> Then add the necessary nodes and values throughout the sc8280xp and
> sa8540p dtsi files to make the various devices on these platforms scale
> both L3, memory bus and DDR.

Good stuff! Thanks Bjorn!

I plan to merge everything except the dts patches, that should go
through the qcom tree.

BR,
Georgi


> Bjorn Andersson (10):
>    interconnect: qcom: osm-l3: Use platform-independent node ids
>    interconnect: qcom: osm-l3: Squash common descriptors
>    interconnect: qcom: osm-l3: Add per-core EPSS L3 support
>    interconnect: qcom: osm-l3: Simplify osm_l3_set()
>    dt-bindings: interconnect: Add sm8350, sc8280xp and generic OSM L3
>      compatibles
>    arm64: dts: qcom: Align with generic osm-l3/epss-l3
>    arm64: dts: qcom: sc8280xp: Add epss_l3 node
>    arm64: dts: qcom: sc8280xp: Set up L3 scaling
>    dt-bindings: interconnect: qcom,msm8998-bwmon: Add sc8280xp bwmon
>      instances
>    arm64: dts: qcom: sc8280xp: Add bwmon instances
> 
>   .../interconnect/qcom,msm8998-bwmon.yaml      |   5 +
>   .../bindings/interconnect/qcom,osm-l3.yaml    |  24 ++-
>   arch/arm64/boot/dts/qcom/sa8540p.dtsi         |  39 +++++
>   arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
>   arch/arm64/boot/dts/qcom/sc7280.dtsi          |   2 +-
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 152 ++++++++++++++++++
>   arch/arm64/boot/dts/qcom/sdm845.dtsi          |   2 +-
>   arch/arm64/boot/dts/qcom/sm8150.dtsi          |   2 +-
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |   2 +-
>   drivers/interconnect/qcom/osm-l3.c            | 126 ++++-----------
>   10 files changed, 252 insertions(+), 104 deletions(-)
> 

