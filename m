Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB0A69745D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjBOCeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjBOCel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:34:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D424E30E93;
        Tue, 14 Feb 2023 18:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62A2AB81EC2;
        Wed, 15 Feb 2023 02:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8577C433D2;
        Wed, 15 Feb 2023 02:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676428478;
        bh=nS4FEIZ70Fqh0a7Kg7Qs8IIchUr/qi4qC2vzbs5RozY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RDfSC9pgTWZ4/TaD4H6sRAMS3MY9hMlFASa8EVhiX43JMrPgmWBhUfSSQCobiN/DN
         qH7pSdOwQxDpfYXwqmHY+4DpzRiNdaeA5eMnNba9iIZircPsGojE1TBvMw/Xridgjw
         zecA2of1t3QC0x7kb3kmGU8DxJNl5LeMZFmYQSRkpx4QM5oteOHSy4tlaIlB95ggji
         g2AW8JkEBSmbgOissWrL0NYgkJ9e24AzRwOnaag8Ue1fFwMMXpHiFORqv7ECARqOuS
         4igbNBs2Qi//72BFnqhaBgoCiBcIKIXm9DezPoYsUpbYFD4q8RZpjen8z4yiOefmzW
         4Y2XLZg0ypbZA==
Message-ID: <d36c3b7cf315a766a9bf1a4425fea607.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230214051414.10740-1-quic_poovendh@quicinc.com>
References: <20230214051414.10740-1-quic_poovendh@quicinc.com>
Subject: Re: [PATCH V4 0/5] Enable crashdump collection support for IPQ9574
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, arnd@arndb.de, broonie@kernel.org,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, jassisinghbrar@gmail.com,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel.ziswiler@toradex.com,
        mturquette@baylibre.com, nfraprado@collabora.com,
        quic_gurus@quicinc.com, robh+dt@kernel.org, robimarko@gmail.com,
        shawnguo@kernel.org, will@kernel.org
Date:   Tue, 14 Feb 2023 18:34:35 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Poovendhan Selvaraj (2023-02-13 21:14:09)
>=20
> Poovendhan Selvaraj (5):
>   dt-bindings: scm: Add compatible for IPQ9574
>   dt-bindings: mfd: Add the tcsr compatible for IPQ9574
>   arm64: dts: qcom: ipq9574: Enable the download mode support
>   arm64: dts: qcom: ipq9574: Add SMEM support
>   firmware: scm: Modify only the DLOAD bit in TCSR register for download
>     mode
>=20
>  .../bindings/firmware/qcom,scm.yaml           |  1 +
>  .../devicetree/bindings/mfd/qcom,tcsr.yaml    |  1 +
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 26 ++++++++++++++++++-
>  drivers/firmware/qcom_scm.c                   | 15 +++++++----
>  4 files changed, 37 insertions(+), 6 deletions(-)

I don't see any clk driver changes. Please stop Ccing linux-clk and clk
maintainers on this series.
