Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7C960CF14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiJYOdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiJYOdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:33:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20FA1057E8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53523618DB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49DEC433D6;
        Tue, 25 Oct 2022 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666708392;
        bh=ZsTzR3IKBFJlkqWG1LSbBERYv00AuE0K58qJL2Ls1Tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoRmzqr4t1izdYZhHOGDi6L1oWaYjkz7Bbv5jxSnCYam55wTHOdmrfl81Fgzhm7Om
         FblkZ8XtzQW6XwVVMGs8kOxTkcUrJ3tjjvZtjuGN3Yoslzi5ceHbgxtDgIrq1PvN7q
         tFULBAXAEmVS5BTcmMQGzOMwaUy+GTe7WbyEB5IcJvcyrnkSGwSLIhyjIPEnCS4piY
         VwAtU/qP8VyuRFFuPrpyml1RfppkQgx4JVqpuh83lI+ftTygE1pBY6a3OW5h1gvWu3
         gmh4FTv0ksTkDoeiNd8AKNSfzvoext5u3HnvkJ4K+ri/SGkGIumh1Ol5Hg/M1ZqoEy
         ZemJW2/L1z7qQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1onKz6-0002tT-U3; Tue, 25 Oct 2022 16:32:53 +0200
Date:   Tue, 25 Oct 2022 16:32:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: demote suspend-mode warning to debug level
Message-ID: <Y1fzlItO+cwVybZm@hovoldconsulting.com>
References: <20221024143417.11463-1-johan+linaro@kernel.org>
 <20221025115355.26zrhmaudigumivn@bogus>
 <Y1fc4FQ8WKnFb5my@hovoldconsulting.com>
 <20221025132655.4kddpdod5czw3vts@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025132655.4kddpdod5czw3vts@bogus>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 02:26:55PM +0100, Sudeep Holla wrote:
> On Tue, Oct 25, 2022 at 02:56:00PM +0200, Johan Hovold wrote:
> > On Tue, Oct 25, 2022 at 12:53:55PM +0100, Sudeep Holla wrote:
> > > On Mon, Oct 24, 2022 at 04:34:17PM +0200, Johan Hovold wrote:
> > > > On some Qualcomm platform, like SC8280XP, the attempt to set PC mode
> > > > during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
> > > > ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
> > > > is now logged at warning level:
> > > >
> > > > 	psci: failed to set PC mode: -3
> > > >
> > > > As there is nothing users can do about the firmware behaving this way,
> > > > demote the warning to debug level.
> > > >
> > >
> > > As mentioned in the other thread I prefer to keep this as error as we
> > > shouldn't mask this error and enable more/newer platforms to ignore it
> > > when they can go and fix it. So I don't agree with this.
> >
> > But now every owner of an X13s laptop will see this not very informative
> > error at every boot and wonder what it means. Has something gone broken?
> > Should they be worried? Can something be done about it?
> >
> 
> I understand that but I have expressed why I am concerned on generalising
> it. As long as we inform the concerned owners running Linux(which is quite
> small at the moment), keeping it will help to get these fixed on platforms
> that are running Linux today for validation and get it fixed if their
> platform firmware suffers from the same.

Trying to inform every user that a warning during boot is actually
benign and nothing to worry about generally seems backwards to me and is
not something that is likely to scale.

> > Remember that this is firmware used by Windows machines so by the time
> > we see this in Linux it's probably way too late to fix in firmware
> > anyway.
> >
> 
> I am well aware of that fact, but I am targeting platforms that are using
> Linux for validation today.
> 
> Honestly, I am not sure if we need to target for zero errors or warnings
> on the platforms instead of repeatedly annoy them with warnings until it
> is fixed. Otherwise I see it won't be fixed ever.

I understand the sentiment, but will having this warning there actually
lead to any firmware changes? Or will it just lead to having developers
and users debug and report issues which cannot be fixed?

And surely there must be better ways to check firmware for compliance
than scanning Linux boot logs for warnings?

Johan
