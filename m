Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6282060E23F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiJZNgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiJZNga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:36:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072A15FDD8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8302B82247
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E93BC433D6;
        Wed, 26 Oct 2022 13:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666791384;
        bh=268dyf9pA9pqhHEN/I5mygwM/5Z2FSEBiLT8yOe9VS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBFwanhXZE58bOQdoei4BJa9TIjTaY8dei+H0cEySfgnTwIOEDpo7ekWB+F+p/H0M
         rZckrpZblABsddPsy1a4b1J5TtdVuPDC07qj/wd2AUDANc8FDPQ+jmJl0rqoELtWR8
         fBGF5CZ9IhdLMJka+arvMLRz1e1QpEnd7qvTl7XFRulZvkQQs+Ngmc+C99qLkwnmKl
         O5f22YEGfBwA0KCQWr8BXwtMQcldDeJa0WLCSsRij8H3vH05rfNXsNeyUgV99xNAIj
         vDTp+PclwBABA2xMhkK9vTHYv/oxaxGPyYM9lu8VgeatZn5gJb0fmgXjfzp4ym2Mpy
         4UcO2sOg1N9Zw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ongZj-0001dC-Se; Wed, 26 Oct 2022 15:36:07 +0200
Date:   Wed, 26 Oct 2022 15:36:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: demote suspend-mode warning to debug level
Message-ID: <Y1k3x12Z6nXoSD5l@hovoldconsulting.com>
References: <20221024143417.11463-1-johan+linaro@kernel.org>
 <20221025115355.26zrhmaudigumivn@bogus>
 <Y1fc4FQ8WKnFb5my@hovoldconsulting.com>
 <20221025132655.4kddpdod5czw3vts@bogus>
 <Y1fzlItO+cwVybZm@hovoldconsulting.com>
 <Y1k1Hp+0I1k1mioW@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1k1Hp+0I1k1mioW@FVFF77S0Q05N>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 02:24:58PM +0100, Mark Rutland wrote:
> On Tue, Oct 25, 2022 at 04:32:52PM +0200, Johan Hovold wrote:

> > Trying to inform every user that a warning during boot is actually
> > benign and nothing to worry about generally seems backwards to me and is
> > not something that is likely to scale.
> 
> It's not *entirely* beningn; we still have to bodge around this not being to
> spec, and there are things that won't work (e.g. if we kexec to a kernel that
> expects the FW to actually follow the spec it claims to).
> 
> I agree with Sudeep that we should log something here, but I do appreciate that
> argumetn that for 90% of users this is not interesting.
> 
> I would suggest we make this:
> 
> 	pr_info(FW_BUG "failed to set PC mode: %d\n", ...);
> 
> ... so that it's always logged for those who care, but as it's INFO rather than
> WARNING, it'll easily be filtered out of logs (e.g. for users booting with
> "quiet"). Adding FW_BUG will also make this clear we're complaining about a FW
> bug rather than this being a kernel-internal error.

Sounds good. I'll respin.

Johan
