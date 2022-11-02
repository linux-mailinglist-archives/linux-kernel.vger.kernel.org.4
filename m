Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF57615B74
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKBE3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKBE3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4588D1CB2B;
        Tue,  1 Nov 2022 21:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD07D617CA;
        Wed,  2 Nov 2022 04:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288DFC433C1;
        Wed,  2 Nov 2022 04:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667363376;
        bh=tqM141vbhosXvV/8UyxXtBjnIH+s3FCRossPcauz/7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pn+v3Z4A9W7TqYZIs0FP2/XFtVZ7YmVzX4tQbhHvwQAdoXE6cpGOXgXLTiUG7jY4y
         lnT9DlWJ+YFJ25hUPD5bQP5UaABPB5t9QLtTYIVz0VIh6l3nIo398LK26hgIFKlDME
         3b5itqloVimHa96tk5ZjZg1twGlpndGNoHSh0SYXEd4Eoe8E32nw11ShHLktZsW3K7
         v6l3UT2Sopla81OWocr/h0ld39Yn7Vhgx1YzBzjlCbbY6PFunezkKnZkK/3FDth0Sx
         03YixugMVNa5IvK3YsWr7VxjtDZrOVFWrPB0W7e+XKh3gixAc99iluiJLMZA8sHfOY
         OkMQ/bnElcSiw==
Date:   Tue, 1 Nov 2022 23:29:33 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, patches@lists.linux.dev,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] clk: qcom: gdsc: Remove direct runtime PM calls
Message-ID: <20221102042933.mdlfknp45ajyrrpn@builder.lan>
References: <20221101233421.997149-1-swboyd@chromium.org>
 <20221102024927.n5mjyzyqyapveapa@builder.lan>
 <CAE-0n50uVf-xapfX5A_c7XU7gV58HrKBOf5DCUPCcahPrgkU0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50uVf-xapfX5A_c7XU7gV58HrKBOf5DCUPCcahPrgkU0Q@mail.gmail.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 08:29:20PM -0700, Stephen Boyd wrote:
> Quoting Bjorn Andersson (2022-11-01 19:49:27)
> > On Tue, Nov 01, 2022 at 04:34:21PM -0700, Stephen Boyd wrote:
> > > We shouldn't be calling runtime PM APIs from within the genpd
> > > enable/disable path for a couple reasons.
> > [..][
> > > Upon closer inspection, calling runtime PM APIs like this in the GDSC
> > > driver doesn't make sense. It was intended to make sure the GDSC for the
> > > clock controller providing other GDSCs was enabled, specifically the
> > > MMCX GDSC for the display clk controller on SM8250 (sm8250-dispcc), so
> > > that GDSC register accesses succeeded. That will already happen because
> > > we make the 'dev->pm_domain' a parent domain of each GDSC we register in
> > > gdsc_register() via pm_genpd_add_subdomain(). When any of these GDSCs
> > > are accessed, we'll enable the parent domain (in this specific case
> > > MMCX).
> > >
> >
> > It's correct that adding the GDSCs as subdomains for the device's
> > parent-domain will ensure that enabling a GDSC will propagate up and
> > turn on the (typically) rpmhpd resource.
> >
> > But the purpose for the explicit calls was to ensure that the clock
> > controller itself is accessible. It's been a while since I looked at
> > this, but iirc letting MMCX to turn off would cause the register access
> > during dispcc probing to fail - similar to how
> > clk_pm_runtime_get()/put() ensures the clock registers are accessible.
> 
> The dispcc and videocc on sm8250 don't use pm_clk APIs. They do use
> pm_runtime APIs during probe (i.e. pm_runtime_resume_and_get()). That
> will enable the MMCX domain and keep it on.

There's a corresponding pm_runtime_put() at the end of
disp_cc_sm8250_probe(), so this vote should be released.

While registering clocks, the framework will clk_pm_runtime_get()/put()
while accessing registers. The argument that was given when introducing
the calls in the probe was the same, covering the direct regmap
accesses...

And I guess it avoids flipping the genpd on/off for each resource being
accessed.

> Then when the GDSCs are
> registered it will create genpds for each GDSC and make them subdomains
> of the 'dev->pm_domain' genpd for MMCX. If the GDSCs are enabled at
> probe time they will increment the count on MMCX to put the count into
> sync between MMCX and the GDSC provided.
> 

This does not fit my argument; if the purpose is for pm_runtime to
provide access to the registers (and the subdomain ensuring that the
GDSC is powered), we should have a pm_runtime_put() after each operation
(analog to clk_pm_runtime_put()).

> The clk framework also has runtime PM calls throughout the code to make
> sure the device is runtime resumed when it is accessed. Maybe the
> problem is if probe defers and enough runtime puts are called to runtime
> suspend the device thus disabling MMCX?

Iirc the problem at hand was really that without any other votes for
MMCX, the register accesses during probe, gdsc and reset registration
would access registers without power.

> Can MMCX really ever be disabled
> or does disabling it act as a one way disable where you can never enable
> it again?
> 

I've not seen any indications of that.

Only the side effect that if you set_performance_state() MMCX lower than
required during continuous splash the whole SoC get hosed.

> Or maybe this is the problem where not all constraints are determined
> yet but we're letting runtime PM put calls from the dispcc device shut
> down the entire multimedia subsystem while other devices that are within
> the same domain haven't probed and been able to sync their state but
> they're actively accessing the bus (i.e. continuous splash screen). I
> could see this problem being avoided by the pm_runtime_get() call in
> gdsc registration keeping MMCX on forever because there isn't a matching
> put anywhere.
> 

This implementation predates 41fff779d794 ("clk: qcom: gdsc: Bump parent
usage count when GDSC is found enabled"), so no this was not introduced
to hide the issue of
yet-to-be-probed-devices-not-voting-for-their-resources.

This problem has been avoided by tying rpmhpd to sync_state and
requiring that people boot their systems with pd_ignore_unused.

> >
> > Perhaps I misunderstood something in the process, or lost track of the
> > actual issues?
> 
> I dunno. It clearly is a problem to call runtime PM in the noirq phase
> of system suspend though.

We definitely need to ensure that this whole setup plays by the rules!

Regards,
Bjorn
