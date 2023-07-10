Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318B974D89E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjGJOJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGJOJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39D9124;
        Mon, 10 Jul 2023 07:09:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F75A6101C;
        Mon, 10 Jul 2023 14:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B7C433C8;
        Mon, 10 Jul 2023 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688998149;
        bh=C36xu6wBoW/W96lEbYEUdJv0CyRZvg+7c1KBlH/u/0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9P5OsfbUDbGVOc7sjYlOe7Gtfvq995tNMGjLfG6oRrIymAoTfWsS5x1elsisuiGr
         KRgBStHqtaN1N4Ssmuyxpwrda9Qcl5yTYtvzSDcOKdjGzhp6l+vk0pRwCBDPTiym5S
         y9K14tl0bT9+hF/kEWYwQc/8KeQ9/A9zfXo5R3Gk=
Date:   Mon, 10 Jul 2023 16:09:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        mark.rutland@arm.com, amit.kachhap@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, joey.gouly@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.4 07/12] arm64: cpufeature: detect FEAT_HCX
Message-ID: <2023071004-engaged-garter-171c@gregkh>
References: <20230702195057.1787686-1-sashal@kernel.org>
 <20230702195057.1787686-7-sashal@kernel.org>
 <b37a9f79-97a8-4f74-a25c-b51128fbc9bb@sirena.org.uk>
 <ZKrKjS7sDFxhKoJT@sashalap>
 <ZKsi+UOdjlmDnhdj@finisterre.sirena.org.uk>
 <20230710094438.GD32673@willie-the-truck>
 <2023071024-unpaved-washed-4d7d@gregkh>
 <0404e7ef-8b1f-483c-a167-56140b29f0cc@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0404e7ef-8b1f-483c-a167-56140b29f0cc@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:47:12PM +0100, Mark Brown wrote:
> On Mon, Jul 10, 2023 at 03:31:42PM +0200, Greg KH wrote:
> > On Mon, Jul 10, 2023 at 10:44:38AM +0100, Will Deacon wrote:
> 
> > > Maybe we just need a commit hook that yells if something with a Fixes:
> > > tag doesn't have a CC: stable on it?
> 
> > I could start doing that, it's going to be really noisy...
> 
> It would need to exclude commits that are only in -next since that's a
> common legitimate use case for Fixes which shouldn't have a Cc to
> stable, and there's going to be a bunch of false positives from people
> who are overly enthusiastic in their use of fixes tags.

My scripts today already know where the original Fix tag came from, it's
not hard to detect.  So this should not be an issue, we don't even
consider any commit with "Fixes:" in it for a kernel that has not
already been released.

thanks,

greg k-h
