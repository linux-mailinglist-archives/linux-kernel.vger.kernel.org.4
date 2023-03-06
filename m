Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A65F6ABAA8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjCFKEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCFKEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:04:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527412844;
        Mon,  6 Mar 2023 02:04:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BA6560D36;
        Mon,  6 Mar 2023 10:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77831C433EF;
        Mon,  6 Mar 2023 10:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678097039;
        bh=NqMbYyvssKAx59ycEdKMFhaWpef5XSN1pFTGQ0DPAQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KDfIzHRqSbIPRxQ5kEQXWQNFgsmQ/3ugZts1z8YigEBSh4faCn+rLeqBU6w2tFriP
         BNIu+8YydqPo4riorBbgxOS7CtqVCqLa6wD9kBbSsh10BujzmsaKnO9x5rtfEEB5ZP
         CrjBgY61IiuUQIyOL7tTJ8wwjay4MuazLBK/8lIjUw1v5rTby3vl6CMMhl9CV315FM
         ugCoVWCZAf3kgg1y9ZrCdpSVrR/yFzmlRd4GGXoezELkFnR8jeZcGIeQBDMoxgdlTo
         hc4aTM3O+wUqG2rTJguyh0O/y219zleqkiBzP4gP+USDs8yUueXwlNh2AzJzEVyu+M
         yG3K63UQfyD7Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pZ7hv-0007OS-4q; Mon, 06 Mar 2023 11:04:39 +0100
Date:   Mon, 6 Mar 2023 11:04:39 +0100
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
Message-ID: <ZAW6t7LKCBubfnx/@hovoldconsulting.com>
References: <20230306075651.2449-1-johan+linaro@kernel.org>
 <20230306075651.2449-14-johan+linaro@kernel.org>
 <ZAWsUrlrOfmmNBy3@linaro.org>
 <ZAWzqtWt5yBlYpQU@hovoldconsulting.com>
 <ZAW01RH/gLwlueoT@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAW01RH/gLwlueoT@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 11:39:33AM +0200, Abel Vesa wrote:
> On 23-03-06 10:34:34, Johan Hovold wrote:
> > On Mon, Mar 06, 2023 at 11:03:14AM +0200, Abel Vesa wrote:
> > > On 23-03-06 08:56:41, Johan Hovold wrote:
> > > > The current interconnect provider registration interface is inherently
> > > > racy as nodes are not added until the after adding the provider. This
> > > > can specifically cause racing DT lookups to fail.
> > > > 
> > > > Switch to using the new API where the provider is not registered until
> > > > after it has been fully initialised.
> > > > 
> > > > Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
> > > > Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > > ---
> > > 
> > > Any changes since v1 or is it just a resend? 
> > 
> > Please see the cover letter:
> > 
> > 	https://lore.kernel.org/lkml/20230306075651.2449-1-johan+linaro@kernel.org/
> > 
> > Only the first patch of the series was updated in v2.
> 
> Right, my bad. Though I wasn't CC'ed on that as well.

Yeah, sorry about that. I copied the CC list from v1 and forgot to make
sure that all reviewers were copied on the cover letter.

Johan
