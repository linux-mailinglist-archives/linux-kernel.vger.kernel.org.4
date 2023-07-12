Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B017504FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGLKlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGLKla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:41:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270A51BCB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:41:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8b2886364so44950755ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158460; x=1691750460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TY2IIjSdcQMjQDDo3NQ71MCDsTeLijaeYYOPQ2zLf6w=;
        b=vCxDwFOmIhQflnCYq44ljdF6MKjUjZ6+CnmKw6fPoDF9XZw298M0F92PIrfOL/ALm/
         6oEMbZojofnMnrpH/zatGqrQxDXliOE9tvGoRXWETmnDmQ0VT4du0/1MBfjO2W0L5U2U
         xxaP+pK6NrqmOBP325RFWqVJpx8ERxTWugGgg5a7PNqnDbFJ0IkLyzWXFT2AYWVzgHv8
         8M+nTdZ3tyNoqfSsvOLF1IGS5JqGbzjEVGSwhds3sFh1Uo/9V5mSu/4+lLvBTjuLKHRF
         /T+RhKXbzWWoBQmbCrGJr2YNWEQc/uvLB+T6tqDOPtTaqH+eqREYomcnSHqKKhieY98P
         swVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158460; x=1691750460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TY2IIjSdcQMjQDDo3NQ71MCDsTeLijaeYYOPQ2zLf6w=;
        b=OCHRlp6cJk1uBTNUu8p8EWEofVTkefkZ2mMw+BPjjp88BftWCvvoz3fWDgFOnyiSx+
         XlmFlGkTv+fNPXC4M3R3PtKh99/FDfyL4/tafUG6Hnu/CwqwH1r47Ykqy8qygfCrlCd7
         Ww8DxpjvNvjS1Q/BVDNpffT8sttFQoj0c5F741SYYtaSbMJzJAb9t972MQ/83za1ZrN6
         NxOxlSqBPriPveJUttO8fkZhr9CiFm6/Z9FauuRK9Pk72gg0YuIADv0zVJjBQuGL+k53
         YPgLodoVoj42UExD76i8SxLCgdjLZ+85em943EF8EOn+gjGAHt8WJpB6AFVDJq3Z/nls
         C76A==
X-Gm-Message-State: ABy/qLZi3bT7NSASNOauV1RrE+LV2FhD+9frwjWuWZgHeYl7X5ypm31B
        VSHRAogPgn2zEVHB2/ib695/
X-Google-Smtp-Source: APBJJlGpsk4298IHzDRiGKybvKunOGtnoVa3TJRzFOHhKncevfgX6CMFIS9/1BJAcrUHgTBcXmO9BA==
X-Received: by 2002:a17:902:d4c3:b0:1b8:1c9e:4453 with SMTP id o3-20020a170902d4c300b001b81c9e4453mr17330818plg.4.1689158459946;
        Wed, 12 Jul 2023 03:40:59 -0700 (PDT)
Received: from thinkpad ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d30500b001b80de83b10sm3590898plc.301.2023.07.12.03.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:40:59 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:10:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 00/14] UFS: Add OPP and interconnect support
Message-ID: <20230712104044.GA102214@thinkpad>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:01:55PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series adds OPP (Operating Points) support to UFSHCD driver and
> interconnect support to Qcom UFS driver.
> 

Missed to cc SCSI folks. Will be resending this series. Sorry for the noise.

- Mani

> Motivation behind adding OPP support is to scale both clocks as well as
> regulators/performance state dynamically. Currently, UFSHCD just scales
> clock frequency during runtime with the help of "freq-table-hz" property
> defined in devicetree. With the addition of OPP tables in devicetree (as
> done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
> both clocks and performance state of power domain which helps in power
> saving.
> 
> For the addition of OPP support to UFSHCD, there are changes required to
> the OPP framework and devfreq drivers which are also added in this series.
> 
> Finally, interconnect support is added to Qcom UFS driver for scaling the
> interconnect path dynamically. This is required to avoid boot crash in
> recent SoCs and also to save power during runtime. More information is
> available in patch 13/13.
> 
> Credits
> =======
> 
> This series is a continuation of previous work by Krzysztof Kozlowski [1]
> and Brian Masney [2]. Ideally, this could've split into two series (OPP
> and interconnect) but since there will be a dependency in the devicetree,
> I decided to keep them in a single series.
> 
> Testing
> =======
> 
> This series is tested on 96Boards RB3 (SDM845 SoC) and RB5 (SM8250 SoC)
> development boards.
> 
> Merging Strategy
> ================
> 
> An immutable branch might be required between OPP and SCSI trees because of
> the API dependency (devfreq too). And I leave it up to the maintainers to
> decide.
> 
> Thanks,
> Mani
> 
> [1] https://lore.kernel.org/all/20220513061347.46480-1-krzysztof.kozlowski@linaro.org/
> [2] https://lore.kernel.org/all/20221117104957.254648-1-bmasney@redhat.com/
> 
> Krzysztof Kozlowski (2):
>   dt-bindings: ufs: common: add OPP table
>   arm64: dts: qcom: sdm845: Add OPP table support to UFSHC
> 
> Manivannan Sadhasivam (12):
>   dt-bindings: opp: Increase maxItems for opp-hz property
>   arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
>   arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"
>   arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
>   OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
>   OPP: Introduce dev_pm_opp_get_freq_indexed() API
>   PM / devfreq: Switch to dev_pm_opp_find_freq_{ceil/floor}_indexed()
>     APIs
>   scsi: ufs: core: Add OPP support for scaling clocks and regulators
>   scsi: ufs: host: Add support for parsing OPP
>   arm64: dts: qcom: sdm845: Add interconnect paths to UFSHC
>   arm64: dts: qcom: sm8250: Add interconnect paths to UFSHC
>   scsi: ufs: qcom: Add support for scaling interconnects
> 
>  .../devicetree/bindings/opp/opp-v2-base.yaml  |   2 +-
>  .../devicetree/bindings/ufs/ufs-common.yaml   |  34 ++++-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  47 ++++--
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          |  43 ++++--
>  drivers/devfreq/devfreq.c                     |  14 +-
>  drivers/opp/core.c                            |  76 ++++++++++
>  drivers/ufs/core/ufshcd.c                     | 142 ++++++++++++++----
>  drivers/ufs/host/ufs-qcom.c                   | 131 +++++++++++++++-
>  drivers/ufs/host/ufs-qcom.h                   |   3 +
>  drivers/ufs/host/ufshcd-pltfrm.c              | 116 ++++++++++++++
>  include/linux/pm_opp.h                        |  26 ++++
>  include/ufs/ufshcd.h                          |   4 +
>  12 files changed, 574 insertions(+), 64 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
