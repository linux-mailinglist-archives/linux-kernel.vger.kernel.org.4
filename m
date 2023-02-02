Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73CE687D19
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjBBMUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBBMUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:20:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B42712EB;
        Thu,  2 Feb 2023 04:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 900AA61ACE;
        Thu,  2 Feb 2023 12:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94DCC433EF;
        Thu,  2 Feb 2023 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675340413;
        bh=Iu4SRBv/XGBIyCipvjboRwtueCLMzab7wCfd98i5Txw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LfydaXq5cTREFVyWdPGhp365lC24c+1mbbJdDa6tHNvIdiydx/tnFOjOXhxmdRdM4
         348TA97WB/KW8+RcgskKxVf4g63JOinuhzrY/nRwpIPOkmdSRYlsbom8f1PSjdH5Xu
         UTlKALBcubrbaAlD5dAUVmTCowTupZHlTaeeNPlgHJKkmHQQsNqKUndaQXQx5Fr2To
         YeGNjz3j1b6kgQ+4Xsrwa+B/+Tvslsjn4PGvNO3Z8Dwibckk56CIKrGJNpS6rAPyES
         abOjDid9ozHxrZpcsL1KWaJPGWzC7FvVcnwc1QauXfSQfD6HCqZPVyAYkmuR1vWKfj
         EoA3vXrmlI4pQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pNYZw-0001Ve-ST; Thu, 02 Feb 2023 13:20:36 +0100
Date:   Thu, 2 Feb 2023 13:20:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] interconnect: fix racy provider registration
Message-ID: <Y9uqlG9uBSquCDGm@hovoldconsulting.com>
References: <20230201101559.15529-1-johan+linaro@kernel.org>
 <57dbcbc6-b497-53db-5a45-abce0e4dcf37@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57dbcbc6-b497-53db-5a45-abce0e4dcf37@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 12:13:33PM +0100, Krzysztof Kozlowski wrote:
> On 01/02/2023 11:15, Johan Hovold wrote:
> > The current interconnect provider interface is inherently racy as
> > providers are expected to be registered before being fully initialised.
> > 
> > This can specifically cause racing DT lookups to fail as I recently
> > noticed when the Qualcomm cpufreq driver failed to probe:
> > 
> > 	of_icc_xlate_onecell: invalid index 0
> >         cpu cpu0: error -EINVAL: error finding src node
> >         cpu cpu0: dev_pm_opp_of_find_icc_paths: Unable to get path0: -22
> >         qcom-cpufreq-hw: probe of 18591000.cpufreq failed with error -22
> > 
> > This only happens very rarely, but the bug is easily reproduced by
> > increasing the race window by adding an msleep() after registering
> > osm-l3 interconnect provider.
> > 
> > Note that the Qualcomm cpufreq driver is especially susceptible to this
> > race as the interconnect path is looked up from the CPU nodes so that
> > driver core does not guarantee the probe order even when device links
> > are enabled (which they not always are).
> > 
> > This series adds a new interconnect provider registration API which is
> > used to fix up the interconnect drivers before removing the old racy
> > API.
> > 
> 
> So is there a dependency or not? Can you make it clear that I shouldn't
> take memory controller bits?

As the fixes depend on the new API it is best if these could all go
through Georgi's tree.

Johan
