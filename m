Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A1D6AB9EE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCFJeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCFJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:33:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF46AB44F;
        Mon,  6 Mar 2023 01:33:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BBF360C24;
        Mon,  6 Mar 2023 09:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7037C433EF;
        Mon,  6 Mar 2023 09:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678095234;
        bh=rSbVlDvA0jl2+1DdaAOATpB+OkCH45l4wsx5jB/wzTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAi/3R+QQgtVZ8tI+kiUfYNfcLV+HA9q6LUDYpqvhhMtP8mbasNUF0eKSDF8AmiUy
         DOKGbmAoESXz7sYqeVmrbpa6o/fP3ziYt29zZFt4xXPJp/bD+Sbi1emB64/U48nGKp
         i1BDPW6iZHlIpnHry6dVwpp9VjCr3ixaezuIs+pmf5fSCgsB/7aci5dKRoO2rKxwVN
         AxsbTCfPDmNeCACZpQ/xmsm6A7Wx7f8OoV5DIPtqrmXOEhdlSe9E9p7wHlh/J2lv6d
         yUr9laRp93UNN3PGd/cLp40htMU55q20PUw/pjAs6clh0Xc/pVY90pC+iElgCVGxNs
         cjC8SyuqRN/tA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pZ7Eo-0003jw-Bk; Mon, 06 Mar 2023 10:34:34 +0100
Date:   Mon, 6 Mar 2023 10:34:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/23] interconnect: qcom: sm8550: fix registration
 race
Message-ID: <ZAWzqtWt5yBlYpQU@hovoldconsulting.com>
References: <20230306075651.2449-1-johan+linaro@kernel.org>
 <20230306075651.2449-14-johan+linaro@kernel.org>
 <ZAWsUrlrOfmmNBy3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAWsUrlrOfmmNBy3@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 11:03:14AM +0200, Abel Vesa wrote:
> On 23-03-06 08:56:41, Johan Hovold wrote:
> > The current interconnect provider registration interface is inherently
> > racy as nodes are not added until the after adding the provider. This
> > can specifically cause racing DT lookups to fail.
> > 
> > Switch to using the new API where the provider is not registered until
> > after it has been fully initialised.
> > 
> > Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
> > Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> 
> Any changes since v1 or is it just a resend? 

Please see the cover letter:

	https://lore.kernel.org/lkml/20230306075651.2449-1-johan+linaro@kernel.org/

Only the first patch of the series was updated in v2.

Johan
