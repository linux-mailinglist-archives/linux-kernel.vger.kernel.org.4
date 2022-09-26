Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671D75EA6C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiIZNDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiIZNDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C0D6D575;
        Mon, 26 Sep 2022 04:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 734EC60B3E;
        Mon, 26 Sep 2022 11:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D99C433C1;
        Mon, 26 Sep 2022 11:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664192070;
        bh=82aV2qPqY36TnHAg7AkDtAtRTa2uq3BR98lyZXCd7IU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThwsgDAcAz6Q90uRwxjGIFNqd8lFoGjUokSe9GNMnw8pALNPfbdtoME9tMsLaFR8/
         5wPOC5ukpYr8Qe74PnXuA2J4FJC4inrxNKmriM4vW2IAc+9T6xaUHaH0VXIg5Q4B9B
         N+kDF3ANbInAsqsaD4Nhj/f+9NG/NrC1hQpNq//7uGgzH7UTBsGpimnhP8LGg8JqqF
         M+NFcyj18h+8ByrpgQ78atj6tAQTYWigRH/WrD6sHYkra2GV39GzSTx7GD9HO0pzJH
         H15FAJkmUQL2mUW7Z5nT4ayxkqyp5AUJRRhr4/96UYjrZu5IrJZR8LVLZMhsWuIW4Q
         fJJDxG2I+wyag==
Date:   Mon, 26 Sep 2022 17:04:22 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] cpufreq: qcom-hw: Move clocks to CPU node
Message-ID: <20220926113422.GA101994@thinkpad>
References: <cover.1657695140.git.viresh.kumar@linaro.org>
 <20220715160933.GD12197@workstation>
 <20220718015742.uwskqo55qd67jx2w@vireshk-i7>
 <20220801023756.76jswkbwivuntqof@vireshk-i7>
 <20220830032456.z4olnogsyg32vhiz@builder.lan>
 <20220830054042.akj7pf366inelvpo@vireshk-i7>
 <20220830062050.GA7066@workstation>
 <20220920102803.rqj44xrz2szj3tqi@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220920102803.rqj44xrz2szj3tqi@vireshk-i7>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 03:58:03PM +0530, Viresh Kumar wrote:
> On 30-08-22, 11:50, Manivannan Sadhasivam wrote:
> > On Tue, Aug 30, 2022 at 11:10:42AM +0530, Viresh Kumar wrote:
> > > On 29-08-22, 22:24, Bjorn Andersson wrote:
> > > > Conceptually, it sounds like a good idea to express the clock feeding
> > > > the CPU clusters, which is controlled by the OSM/EPSS.  But do you
> > > > expect the OPP framework to actually do something with the clock, or
> > > > just to ensure that the relationship is properly described?
> > > 
> > > No, the OPP core will never try to set the clock rate in your case,
> > > though it will do clk_get().
> > > 
> > 
> > Okay. Then I think it is a fair argument to make qcom-cpufreq-hw as the
> > clock provider for CPUs.
> > 
> > I will send the RFC soon.
> 
> Ping.
> 

Didn't get time so far. Will get to this once I'm back from vacation.

Thanks,
Mani

> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
