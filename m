Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962B364BAF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiLMR2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiLMR2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:28:48 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FA321273;
        Tue, 13 Dec 2022 09:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+gHcL0GavN66hEyQQto3Gxp/s7JccGCmVE4ksMartuc=; b=svtedpfrmgRz4xaWewVFJm/yqD
        yqeYYjNiqllJeWMYVvO+hGpYRaoRLiwtrOCkBuiaN5D4ma8GagYKR/y3usItIh61p4SRs5FuOTCmv
        K8B84LSgkFMmRSUZ2fPjpdcZv3X6Hn/skU4RME/va+fXJ1nHlrdxCbWA302/9209llsZdYYnH2hCG
        31l2qENg7yJ/X4MPoWpN3r7S8mCGzzA4pIL9d9i9N0BUqOKUya3gsoEpFW3ZgFJea5M4wIMJas0Ck
        18jb1tkQO3d2LE8fn0MTcre9vD/rvQuVYxGY4my9+yKPCVkbhkqLLIRKFkFGGBf7cX9HKwGkyp5Ug
        Xc51TFIA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35694)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1p5956-0007O7-04; Tue, 13 Dec 2022 17:28:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1p5951-0006c0-Lf; Tue, 13 Dec 2022 17:28:35 +0000
Date:   Tue, 13 Dec 2022 17:28:35 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Seija K." <doremylover123@gmail.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH] arch: change variable types to match those of what is
 assigned to them
Message-ID: <Y5i2Q+wcl3S2JFg4@shell.armlinux.org.uk>
References: <CAA42iKzgsHDC5b+nUyiH8TV0od8LjGp4G-WRyamB=NYtoDtMMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA42iKzgsHDC5b+nUyiH8TV0od8LjGp4G-WRyamB=NYtoDtMMw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 12:03:51PM -0500, Seija K. wrote:
> There are many places where "int len = strlen(foo);" is written, just
> for len to be passed as a parameter of size_t. This causes truncation
> and then expansion back from int to size_t. Not to mention this is
> poor logic and needless truncations can add extra unneeded
> instructions.
> This patch aims to fix the worst offenders.

I didn't bother looking too closely as the patch has been severely
mangled. I think you need to reconsider how you send patches and
find a way to test before you send emails to mailing lists.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
