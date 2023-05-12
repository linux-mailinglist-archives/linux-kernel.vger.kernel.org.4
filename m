Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40C9700389
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbjELJWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbjELJWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:22:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA87DDA6;
        Fri, 12 May 2023 02:22:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5CC365440;
        Fri, 12 May 2023 09:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E743FC433EF;
        Fri, 12 May 2023 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683883322;
        bh=R04Are6haFhQwucOhj2F4qhuwwMNUbEeyjwYPt/f22M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=shRIZB9hp7oiDFvvFrhaDsw6O4deS791uNEke8YVMdPgxCCG6xXZUAChxhB82JK93
         8yOdKwvT50V103s1samccfrt0zVl0Jx4vaJS+hyoGvSOf3F34yOPQRAlRrDiZHTHoA
         Th6Q7xMOYDOLDgTOeZcz6NA1NLyA4uFP+x6x4HzsCxowh63GMRogBg9zx/eo0OaZSQ
         byqe1ERrbksuMII2dy662LCvCrUUFQjeqeSsDEpBO9rEFSU6ymjOyoMtLvqY8r9spU
         Cy8OGlthwwI9UOa3Xjuk3XhuJNw0YtkrNAR0mHVa6z6IxASDqEoxYdby3smB1yIqtN
         ZZc/eNTYnkNxw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pxOyq-0002uv-HM; Fri, 12 May 2023 11:22:29 +0200
Date:   Fri, 12 May 2023 11:22:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2 4/8] phy: qcom-qmp-combo: Introduce orientation
 variable
Message-ID: <ZF4FVBcnWlvKF_DP@hovoldconsulting.com>
References: <20230510031930.1996020-1-quic_bjorande@quicinc.com>
 <20230510031930.1996020-5-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510031930.1996020-5-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 08:19:26PM -0700, Bjorn Andersson wrote:
> In multiple places throughout the driver code has been written in
> prepration for handling of orientation switching.
> 
> Introduce a typec_orientation in qmp_combo and fill out the various
> "placeholders" with the associated logic. By initializing the
> orientation to "normal" this change has no functional impact, but
> reduces the size of the upcoming introduction of dynamic orientation
> switching.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Abel Vesa <abel.vesa@linaro.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on HDK8450
> Tested-by: Johan Hovold <johan+linaro@kernel.org>	# X13s
> ---
> 
> Changes since v1:
> - X-mas in qmp_combo_configure_dp_mode()
> 
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 54 +++++++++++++----------
>  1 file changed, 30 insertions(+), 24 deletions(-)
 
>  static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
>  {
> +	bool reverse = qmp->orientation == TYPEC_ORIENTATION_REVERSE;

Nit: I still think parentheses around the right-hand side would improve
readability.

> +	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
>  	u32 val;
> -	bool reverse = false;

> @@ -2235,7 +2236,7 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
>  {
>  	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
>  	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
> -	bool reverse = false;
> +	bool reverse = qmp->orientation == TYPEC_ORIENTATION_REVERSE;

Same here and below.

And maintaining reverse xmas style throughout the driver would be nice
for consistency too.

>  	u32 status;
>  	int ret;

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
