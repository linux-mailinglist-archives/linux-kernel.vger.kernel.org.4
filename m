Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531F0631A85
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiKUHnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKUHme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:42:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5AAEE36;
        Sun, 20 Nov 2022 23:42:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E20E1B80D3D;
        Mon, 21 Nov 2022 07:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8558CC433C1;
        Mon, 21 Nov 2022 07:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669016550;
        bh=7Nr3LycK+PUc2Y37doTR1Bd1604oKJOd1ZbjHaPkaEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q03FyXtg2rY3kOOHKmkf2NV8jo2Qi4JEsvbp6LDovcMGHM9AXUNr63TePdYRU9kzE
         x1mdsyYNHjPgNg6cFYDt0emKcrGSuzqAjDvDACAc3corciQ0ICYo8/r524Ub5dhAoI
         7pLmKGhQN8enh+vHc9SliN2oWkFGfhHKAz7aWQuHPb3xi/rpSbA3cPX35iP/+FZXQB
         EHfBdipnzusGsvQ0fJyQjMTurpjCA3qmy7v/6hnGls2liBSq7hLunhEBITP21Nh3Jt
         aFRO+kWG0kH6edmh0A/vXfFJVGjnfSnXt6ZWzsP7czgzQeRNQCPRT7bJ0mDGzYomc9
         mkNOZOPwytAeQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ox1RI-00066o-HP; Mon, 21 Nov 2022 08:42:00 +0100
Date:   Mon, 21 Nov 2022 08:42:00 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <Y3sryFh84eK/sWKF@hovoldconsulting.com>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073817.7ollj7jeixrx5og5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121073817.7ollj7jeixrx5og5@vireshk-i7>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 01:08:17PM +0530, Viresh Kumar wrote:
> On 21-11-22, 08:22, Johan Hovold wrote:
> > On Mon, Nov 21, 2022 at 12:27:48PM +0530, Viresh Kumar wrote:
> > > This removes the special code added by the commit 2083da24eb56 ("OPP:
> > > Allow multiple clocks for a device"), to make it work for Qcom SoC.
> > > 
> > > In qcom-cpufreq-hw driver, we want to skip clk configuration that
> > > happens via dev_pm_opp_set_opp(), but still want the OPP core to parse
> > > the "opp-hz" property so we can use the freq based OPP helpers.
> > > 
> > > The DT for Qcom SoCs is fixed now and contain a valid clk entry, and we
> > > no longer need the special handling of the same in the OPP core.
> > 
> > Didn't this affect also sc8280xp?
> 
> I assumed Mani fixed all affected Qcom SoCs :(

I think he may have been waiting for his suggested solution to be
accepted before updating all the affected dtsi:s.
 
> > Perhaps you can hold off with applying
> > this one for a bit until the needed devicetree changes are in linux-next
> > for all the affected platforms.
> 
> Sure.

Thanks.

> > (It looks like Mani's series only updated sm8450 and I guess Bjorn
> > hasn't picked up that one up yet either.)
> 
> I applied that series today to my cpufreq/arm/linux-next, since it had
> cpufreq updates too and these patches are rebased on top of them.

Ok, I was expected the devicetree update to through Bjorn's tree as I
imagine there may be conflicts otherwise.

What was the intention here, Mani?

Johan
