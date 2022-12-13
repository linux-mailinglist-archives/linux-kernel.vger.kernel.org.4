Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08C064BB4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbiLMRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiLMRp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:45:29 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA743205F5;
        Tue, 13 Dec 2022 09:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z0omR0ISWAA4du1XKL80E5Cf5YbDXbqPmELEAXHKvQo=; b=oEeJCQRTr3YsEUk4WlvGuWYrWO
        MmgYaL2cPSShnoGVDBLrFUmnaAJapVRvgMNLCrsoAysmkulQQV4JNQduZVticVd/l67BlfPCFan9k
        f1+BrhK5ZSCAnpthmveiFJ98zTsYarYTTx0k/YplqYLnItSSIKOaEDd8YVlNZYwaj3svQY+v4oWSD
        U7NRAB78y4u6BCMR4ymIphcrEeh8QShAKSOyxoCfl7Ossfcyr0FzXNe4kjTXAep8YvaEV1g7MJaDg
        riGz3On3drqZLxqx99C5PN6peFFhyj0WB08lrEgaWCAZC0CoH6w4f/xDLKcHvhVD8/Y4g4pEAnYPT
        669iiaiA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35696)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1p59LJ-0007QC-0d; Tue, 13 Dec 2022 17:45:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1p59LH-0006d0-Vw; Tue, 13 Dec 2022 17:45:23 +0000
Date:   Tue, 13 Dec 2022 17:45:23 +0000
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
Message-ID: <Y5i6M/9XEr0zvenj@shell.armlinux.org.uk>
References: <CAA42iKx2f2LsAQ9C5rxnCTPhOB6n+L35Winc5WK1K2EySAjvXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA42iKx2f2LsAQ9C5rxnCTPhOB6n+L35Winc5WK1K2EySAjvXA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 12:35:35PM -0500, Seija K. wrote:
> There are many places where "int len = strlen(foo);" is written, just
> for len to be passed as a parameter of size_t. This causes truncation
> and then expansion back from int to size_t. Not to mention this is
> poor logic and needless truncations can add extra unneeded
> instructions.
> 
> This patch aims to fix the worst offenders.

I suggested to test _not_ on the mailing lists, because it adds
unnecessary noise - and remember that your email needlessly gets
sent to thousands of recipients.

Yet again, the patch is mangled, but is better than the last one.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
