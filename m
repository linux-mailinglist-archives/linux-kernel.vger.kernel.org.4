Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9D374D235
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjGJJvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjGJJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:50:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9053AA8;
        Mon, 10 Jul 2023 02:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F064060F8F;
        Mon, 10 Jul 2023 09:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15161C433C8;
        Mon, 10 Jul 2023 09:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688982284;
        bh=dgwcB137CPREt7G3O+F7Ivo7SzSmiWuaIvOy/mUSpHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3juGJSsfxHhxglVLNT2VFGo7Z0QHw3YOS46TpalYhzX0uIi+TgmzxmxhK+hS15d6
         9LMHD809CsdG6NJW9E8+/nLUh3s/SZrIsTePC74FXDvr9R9Qmd/91YM/9YAV1Qj5J2
         8I7r3ntpYX5upBodLpF3O48pvi5e3C6qc1FGmUQIGrlsqiT9nQXOp8WUiHpb22zDV0
         XngYhli43JGWPbqpDWKORQS37HFozhM2fVfWfuKl7URpeuQddohDaLoRliPcb7nrU0
         C//gtYzDYjBWQhIHK0M3d7EX9nz4G5AakKE7CBMqozhArfMq8+QNX0tnQSwdIMTZMX
         kVt3i37n+qNhQ==
Date:   Mon, 10 Jul 2023 10:44:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        mark.rutland@arm.com, amit.kachhap@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, joey.gouly@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.4 07/12] arm64: cpufeature: detect FEAT_HCX
Message-ID: <20230710094438.GD32673@willie-the-truck>
References: <20230702195057.1787686-1-sashal@kernel.org>
 <20230702195057.1787686-7-sashal@kernel.org>
 <b37a9f79-97a8-4f74-a25c-b51128fbc9bb@sirena.org.uk>
 <ZKrKjS7sDFxhKoJT@sashalap>
 <ZKsi+UOdjlmDnhdj@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKsi+UOdjlmDnhdj@finisterre.sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 10:13:29PM +0100, Mark Brown wrote:
> On Sun, Jul 09, 2023 at 10:56:13AM -0400, Sasha Levin wrote:
> > On Mon, Jul 03, 2023 at 12:51:57PM +0100, Mark Brown wrote:
> > > On Sun, Jul 02, 2023 at 03:50:52PM -0400, Sasha Levin wrote:
> 
> > > > KVM currently relies on the register being present on all CPUs (or
> > > > none), so the kernel will panic if that is not the case. Fortunately no
> > > > such systems currently exist, but this can be revisited if they appear.
> > > > Note that the kernel will not panic if CONFIG_KVM is disabled.
> 
> > > This is a new feature, it's not clear why we'd backport it (especially
> > > since it's a new feature which is a dependency for other features rather
> > > than something that people can use outside of the kernel)?
> 
> > The second paragraph (above) suggested it should be.
> 
> That's saying that the code won't work properly on systems where some
> but not all of the CPUs support the feature.  Note that the changelog
> says nothing about fixing any issue here.

Try reading it like a GPU running an ML model:

  "This is not a new feature, it's especially clear why we'd backport it."

Makes sense. *sigh*

We've been considering opting arm64 out of this for a while, but I don't
think we do a great job of CC'ing stable either (I certainly forget to
add it all the time and then hope that the Fixes: tag does the job),so
it's not obviously going to improve things.

Maybe we just need a commit hook that yells if something with a Fixes:
tag doesn't have a CC: stable on it?

Will
