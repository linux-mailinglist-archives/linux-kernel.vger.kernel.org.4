Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6D665D0AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjADKaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjADKaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:30:13 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174433894
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qqH/Me3GhLyp/wEo5gWkk1CCi9uaf7ZM+4ekDHBfv/o=; b=MzSwVCMy6Sq7bl8rj3fXSOX+wo
        CwdlM35qa0ksQvSjj6nd+QzXei7uCaw/SNr/gvTxC+3EaH0dHXoA8DqTsGNAEdPTh0r+voNedE5rt
        4R16DXgUj2sLwSqPjfJef3JTByMVybwdUvViL5Ppxp0C3rUrgW9SMkoeQFxVfeYLh0b673Q+aodWe
        cOPhnEG7byynZn9fSJELCi1OyhB4wq8PXYxfHiQCKCOs9kv+sgFXPslo3hEM/3LtJXaDSLzf4Jtvw
        AFYlolxEqjqAj4KNJ3uh+RwlIKHyVnXxrIWxVileSzrmTH4mlUvhnNBaITd17Qntda6otI79i8O1z
        j4VPAg1g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35964)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pD123-0006Jo-NA; Wed, 04 Jan 2023 10:30:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pD11z-0002yH-Ev; Wed, 04 Jan 2023 10:29:59 +0000
Date:   Wed, 4 Jan 2023 10:29:59 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Hector Martin <marcan@marcan.st>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v3 0/5] Fix a whole host of nvmem registration/cleanup
 issues
Message-ID: <Y7VVJxpLtouhEO6u@shell.armlinux.org.uk>
References: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
 <7f6b2a9a-1ffc-424f-2287-5934cf653bde@linaro.org>
 <c5b1949f-f39e-8783-19be-cb27c96aea33@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b1949f-f39e-8783-19be-cb27c96aea33@marcan.st>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 10:15:14AM +0900, Hector Martin wrote:
> On 04/01/2023 06.15, Srinivas Kandagatla wrote:
> > Hi Russell,
> > 
> > 
> > On 03/01/2023 16:58, Russell King (Oracle) wrote:
> >> Hi,
> >>
> >> This series fixes a whole host of nvmem registration/error cleanup
> >> issues that have been identified by both Hector and myself. It is a
> >> substantial rework of my original patch fixing the first problem.
> >>
> >> The first most obvious problem is the race between nvmem registration
> >> and use, which leads to sporadic failures of drivers to probe at boot
> >> time.
> >>
> >> While fixing this, it has been noticed that a recent fix to check the
> >> return value of dev_set_name() introduced a new bug where wp_gpio was
> >> not being put in that newly introduced error path.
> >>
> >> Then there's a fix for a previous fix which itself purports to fix
> >> another bug, but results in the allocated ID being leaked. Fix for a
> >> fix for a fix is not good!
> >>
> >> Then there's an error in the docbook documentation for wp_gpio (it's
> >> listed as wp-gpio instead) but as nothing seems to set wp_gpio, we
> >> might as well get rid of it - which also solves the issue that we
> >> call gpiod_put() on this whether we own it or not.
> >>
> >> Lastly, there's a fix for yet another spurious white-space in this
> >> code, one of what seems to be a long history of past white-space
> >> fixes.
> >>
> >> These patches have been individually build-tested in the order of
> >> posting, but not run-time tested except for the entire series.
> > 
> > 
> > thanks for fixing these issues, I have applied these after fixing the 
> > subject on all the patches, as it ended up with email ids in subject.
> 
> Right. I see none of the issues you two lectured me about actually
> mattered, it was all for show, and this isn't getting backported anyway.
> 
> Good job you two. The day I finally rage quit the kernel after enough of
> this nonsense and make a big dossier of just how fucked up the kernel
> maintainer community's attitude is, I will be sure to use this as an
> example.
> 
> That day is not today though. But I certainly won't be upstreaming any
> more patches to nvmem.

You've really little clue, have you.

I really don't see that you'll *ever* get apple hardware properly
functional in mainline. Good luck maintaining a fork of the kernel
for ever into the future.

I've had enough of you.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
