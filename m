Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D355360CB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiJYMMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiJYMMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:12:36 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDCE2FC2C;
        Tue, 25 Oct 2022 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1GLLDI99fTLFVk7UHyLsLRMZqShPEgCumFtxPIsX+Wc=; b=O+DlVwkKqDxVFj9SutyvUOq/vH
        RwP08FVS4SER5XjmDApbsgbkufJNZrT8qqpbm9cW4Mf8yyi5wCnC56IViXb6e+3mVR9hiQvWc0XNR
        FsBbea57NNHwF+IeGrxEjbL+RgMxK18Vft6iQCSEWWLfA1ixt+FxxOO+cm09foJ+mSWn2+kAbutzG
        wsk5LXvRagU8cDBOYCphomgBn8O0Jp2PZqbZAZergWemCaHHB/tVV3QiT+tNmSP+bG0PIY9AbAPpU
        FrwxaMq9vE6BkP20I3syeqytDAexB22Z21ClAjFTK32iHA4zGxQhvdZnTgTg6S9qTOqRuU2uiJDiH
        YYhPGxvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34946)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1onIn5-0004Sr-7S; Tue, 25 Oct 2022 13:12:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1onImw-00086k-St; Tue, 25 Oct 2022 13:12:10 +0100
Date:   Tue, 25 Oct 2022 13:12:10 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 04/11] ARM: sa1100: make cpufreq driver build standalone
Message-ID: <Y1fSmg5ljuPH37Xy@shell.armlinux.org.uk>
References: <20221021155000.4108406-1-arnd@kernel.org>
 <20221021155000.4108406-5-arnd@kernel.org>
 <Y1eeEQr/E59uIE3j@shell.armlinux.org.uk>
 <e21edff1-1f01-40d1-96a4-5b77a16dccb4@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e21edff1-1f01-40d1-96a4-5b77a16dccb4@app.fastmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:14:19PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 25, 2022, at 10:28, Russell King (Oracle) wrote:
> > On Fri, Oct 21, 2022 at 05:49:34PM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> Commit 59a2e613d07f ("cpufreq: sa11x0: move cpufreq driver
> >> to drivers/cpufreq") added an unnecessary reference to
> >> mach/generic.h. Just remove it again after moving the code
> >> into the corresponding driver.
> >
> > So how does arch/arm/mach-sa1100/clock.c get the MPLL rate with this
> > change?
> 
> You are right, that's broken. It works for the defconfigs that
> enable the cpufreq driver,

Umm. How? I think your testing must be seriously flawed!

You add sa11x0_getspeed() to the sa1110 cpufreq driver as a static
function, which means it won't be visible to clock.c - and clock.c
is always built, and always references sa11x0_getspeed()... so you
should be getting an unconditional build failure at link time and
a compiler warning that sa11x0_getspeed() is not declared.

Are you not seeing that?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
