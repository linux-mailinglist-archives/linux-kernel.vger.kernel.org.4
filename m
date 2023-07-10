Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4FF74D7A6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjGJNcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjGJNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:32:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426FD118;
        Mon, 10 Jul 2023 06:31:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B86B6100A;
        Mon, 10 Jul 2023 13:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDCEC433C7;
        Mon, 10 Jul 2023 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688995905;
        bh=Zae0sXZ1apKn8b44P9R9P2lKldy08yGANk4vIqeZlU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TpEBMDbsZ4zuGsGTLnbNkZkxD78Qop9PdG2mTF/3in+XYZINwiy8E3DnGYBxT56uW
         FlwZUAutSZxHaHaF1bH1+/kdeO+zm2oH7pdw7iGFgDsJiznuRIATXGV6PNA3e+kEFC
         TpC/CsbKeigp0h5giJ5GNEoojyvUdk+mpZPQE7jU=
Date:   Mon, 10 Jul 2023 15:31:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        mark.rutland@arm.com, amit.kachhap@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, joey.gouly@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.4 07/12] arm64: cpufeature: detect FEAT_HCX
Message-ID: <2023071024-unpaved-washed-4d7d@gregkh>
References: <20230702195057.1787686-1-sashal@kernel.org>
 <20230702195057.1787686-7-sashal@kernel.org>
 <b37a9f79-97a8-4f74-a25c-b51128fbc9bb@sirena.org.uk>
 <ZKrKjS7sDFxhKoJT@sashalap>
 <ZKsi+UOdjlmDnhdj@finisterre.sirena.org.uk>
 <20230710094438.GD32673@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710094438.GD32673@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 10:44:38AM +0100, Will Deacon wrote:
> On Sun, Jul 09, 2023 at 10:13:29PM +0100, Mark Brown wrote:
> > On Sun, Jul 09, 2023 at 10:56:13AM -0400, Sasha Levin wrote:
> > > On Mon, Jul 03, 2023 at 12:51:57PM +0100, Mark Brown wrote:
> > > > On Sun, Jul 02, 2023 at 03:50:52PM -0400, Sasha Levin wrote:
> > 
> > > > > KVM currently relies on the register being present on all CPUs (or
> > > > > none), so the kernel will panic if that is not the case. Fortunately no
> > > > > such systems currently exist, but this can be revisited if they appear.
> > > > > Note that the kernel will not panic if CONFIG_KVM is disabled.
> > 
> > > > This is a new feature, it's not clear why we'd backport it (especially
> > > > since it's a new feature which is a dependency for other features rather
> > > > than something that people can use outside of the kernel)?
> > 
> > > The second paragraph (above) suggested it should be.
> > 
> > That's saying that the code won't work properly on systems where some
> > but not all of the CPUs support the feature.  Note that the changelog
> > says nothing about fixing any issue here.
> 
> Try reading it like a GPU running an ML model:
> 
>   "This is not a new feature, it's especially clear why we'd backport it."
> 
> Makes sense. *sigh*
> 
> We've been considering opting arm64 out of this for a while, but I don't
> think we do a great job of CC'ing stable either (I certainly forget to
> add it all the time and then hope that the Fixes: tag does the job),so
> it's not obviously going to improve things.
> 
> Maybe we just need a commit hook that yells if something with a Fixes:
> tag doesn't have a CC: stable on it?

I could start doing that, it's going to be really noisy...

greg k-h
