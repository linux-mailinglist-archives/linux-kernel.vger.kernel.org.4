Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287CE7022F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 06:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjEOEgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 00:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjEOEgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 00:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C620A4;
        Sun, 14 May 2023 21:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E1761EBF;
        Mon, 15 May 2023 04:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A827FC433EF;
        Mon, 15 May 2023 04:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684125399;
        bh=VSxf9kcpdp8MyJdcARTA7jhwBElDPmGHNYs6kyAwslQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucUC1+fePqs53Bx1ZZ+3hwzmlJ14XvK7bhdhrMeKDozVoqY9a5eVr0A9xqSItiurj
         enl+otgemZY0PX+g0hJExBjaQMPWGqL6qjJjCGTv64b/tPnRGa+ZWVfNN8crZEljV6
         rvAMF0qf+VfEqQODqa8QDsrWDNP1sIn4grMrE+4krTEoIpTPQSK2SX3GmH7IhbjGjy
         SKZ9uIkdj/IiugK2Lwng2qqhg8fGNkG8SM1euzbJt+ewf8ZP6ayYjtxUyAFlE1LVRz
         CyPmT+jwMM8LJ7tthidzaGSgIzDMSaN11b5ae+H8b8/e+ijc2ELU8blddRNfWT7rcN
         5Ocgv0pS0Vo+Q==
Date:   Mon, 15 May 2023 10:06:31 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes
Message-ID: <20230515043631.GD5143@thinkpad>
References: <20230512150425.3171122-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230512150425.3171122-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 08:04:25AM -0700, Bjorn Andersson wrote:
> The rpmh driver will cache sleep and wake votes until the cluster
> power-domain is about to enter idle, to avoid unnecessary writes. So
> associate the apps_rsc with the cluster pd, so that it can be notified
> about this event.
> 
> Without this, only AMC votes are being commited.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

It still didn't fix the BCM vote issue I'm seeing on the CRD but that might be
due to RPMh resources not entering sleep mode to apply the sleep vote flushed
with the help of this patch.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 8fa9fbfe5d00..5c68f2182c2f 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3982,6 +3982,7 @@ apps_rsc: rsc@18200000 {
>  			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
>  					  <WAKE_TCS    3>, <CONTROL_TCS 1>;
>  			label = "apps_rsc";
> +			power-domains = <&CLUSTER_PD>;
>  
>  			apps_bcm_voter: bcm-voter {
>  				compatible = "qcom,bcm-voter";
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
