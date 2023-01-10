Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014B66645F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbjAJQZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjAJQZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:25:13 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ACBBC0D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BNOPKPiAhBdPB7REVZn5hKZ7/HEEbXuBzRu/23PAM1s=; b=AREzrG3zSe5gKpTgpgOlHQiaIT
        b71HNnvVMIicxAMSWznaXhuuOxONEJZLQjzFuQbtZinknyN+16I+mwZJOfMdePWQyo9ZMN4lW8Gia
        +4eDVXNWR1vAuIhWXT5DKm4dKplWvuxzB0DEBFG/czaVmLDDG2zYtd0Q7mqJNpT+0qwUcdOCAnHxV
        /2TJ/DfwHTKnsNbrBNE6LdPuwApJbAkyCTfF2FCIV0EaYoqnZWXup1mzaTRCBjTHe/yzGjfEKc8xN
        N8YueqU3ZcGMr8Q9VKMkaQFy/S99sRTm3F7Nqc3Q2NUGIlRczmEbzCdASyBNuAj+GdlMGWW+5n4vi
        XWQpSpNA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36040)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pFHQu-0004AK-KQ; Tue, 10 Jan 2023 16:25:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pFHQq-0000RN-H2; Tue, 10 Jan 2023 16:25:00 +0000
Date:   Tue, 10 Jan 2023 16:25:00 +0000
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
Message-ID: <Y72RXJqcGQ3G0gXu@shell.armlinux.org.uk>
References: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
 <5333ed0e-010c-178a-beb2-e8a4338f2d43@marcan.st>
 <Y7SWgC7m4tYSU1UJ@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7SWgC7m4tYSU1UJ@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 08:56:32PM +0000, Russell King (Oracle) wrote:
> Really not interested in your politics. Not interested in fixing this
> problem.
> 
> I'll use these patches to fix the problem in my tree. I don't care about
> mainline.

Having thought this over, this was an unfair over-reaction for which
I'd like to apologise. It was proving to be a very stressful couple
of days.

> > Uhh. The series itself looks fine as far as fixing the problems, but I
> > fail to see how this is any better than my attempt as far as backporting
> > or commit atomicity goes. Patch #4 fixes the newer gpio leak bug *and*
> > half fixes the race condition bug,

There are two choices for patch for:

1. add gpiod_put().
2. make use of the gpiod_put() already present in the release function.

Either way, patch 5 depends on patch 4, and there's no way around that.
This does not mean that they can't be back ported though - patch 4
can be backported to the appropriate point, and further backported
merely by dropping one hunk - and thus it becomes a preparatory patch
for patch 5, and even more so, separates the conversion from
device_register() to device_initialize()+device_add() from the actual
fix itself (which in patch 5 merely moves device_add() and rearranges
the cleanup.)

However, where our patches differ is that my series fixes one problem
in one patch, rather than trying to address multiple problems in one
patch. As has been pointed out, this is a documented requirement in
the submitting-patches.rst document, which has been there for a very
long time. You had been pointed to this document already over this
point.

Therefore, I believe my series to be a technically better approach
which addresses several more issues while conforming to the "Solve
only one problem per patch." requirement which can be trivially
backported - and I truely believe that even patch 4 complies with
the requirement in submitting-patches.rst. I certainly do not
believe patch 4 is a kind of "partial" fix for the race condition,
since it in no way changes the presence of the race.

I hope that we can continue to work to get the Apple M1 supported more
fully in the future.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
