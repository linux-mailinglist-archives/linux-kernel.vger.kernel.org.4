Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A68E73D366
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 21:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjFYTod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 15:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFYToa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 15:44:30 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B303197
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 12:44:25 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0ACB71FA76;
        Sun, 25 Jun 2023 21:44:22 +0200 (CEST)
Date:   Sun, 25 Jun 2023 21:44:21 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
Subject: Re: [PATCH 02/15] dt-bindings: clock: qcom,dispcc-sm6125: Remove
 unused GCC_DISP_AHB_CLK
Message-ID: <e4uxrknyfpxds73gnzql34a4ksph2b5plpxqkcddgyrcflxtgp@5dkvmdptvqbx>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-2-1d5a638cebf2@somainline.org>
 <1d782241-f0ef-848b-9b42-a8a6234bbfae@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d782241-f0ef-848b-9b42-a8a6234bbfae@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-24 11:08:30, Krzysztof Kozlowski wrote:
> On 24/06/2023 02:41, Marijn Suijten wrote:
> > The downsteam driver for dispcc only ever gets and puts this clock
> > without ever using it in the clocktree; this unnecessary workaround was
> > never ported to mainline, hence the driver doesn't consume this clock
> > and shouldn't be required by the bindings.
> > 
> > Fixes: 8397c9c0c26b ("dt-bindings: clock: add QCOM SM6125 display clock bindings")
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> 
> In perfect would we would like to know whether hardware needs this clock
> enabled/controlled, not whether some driver needs it. I understand
> though that with lack of proper docs we rely on drivers, so:

It might only use this to figure out if those clocks have already probed
or are available.  The logic goes as follows:

	clk = devm_clk_get(&pdev->dev, "cfg_ahb_clk");
	if (IS_ERR(clk)) {
		if (PTR_ERR(clk) != -EPROBE_DEFER)
			dev_err(&pdev->dev, "Unable to get ahb clock handle\n");
		return PTR_ERR(clk);
	}
	devm_clk_put(&pdev->dev, clk);

Nothing else uses/parents cfg_ahb_clk.  Maybe with clk_ignore_unused or
similar, it gets turned on but never off again?

Indeed, a lack of documentation and comment from the manufacturer makes
it impossible to know, and ignoring it (as the driver already does)
works just fine.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks!

- Marijn

> 
> Best regards,
> Krzysztof
> 
