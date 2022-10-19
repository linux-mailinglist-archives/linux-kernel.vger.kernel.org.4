Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F176049ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiJSOxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiJSOxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:53:03 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02782875
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5mYsxjFeGKpcm5KRoXtnujxHXSvElTxW7YBXE+XahDo=; b=GYpzJ4IZIEfobfw2od09Tue2PV
        4elW8HRHpOe79w1JijJ0TPTMFxGt3XDEFxytqo1o4IEXBn0Jl6GG1UAN5ndNpIdibD+jcICdO8hi1
        itO01Z3AXa1DzUKuW6CQUdmH0SvB+9jnoZL3lqzkbXW3+VJGaXLkPzaEw0o7KN8qJdm2NzTHuBhfS
        BYnmWChb87rwU/Hn2dZilJdNHidtz4w9EcQudXpnm+nxGNe+/QS4TVsuFq9LRSfdlzyzO5mY/ExNK
        wcmVKKRtjnBBWonp0yslD/t5D6O0ynqDxw0n05xcJkhUpvATyFzFnczZmeY/95wkr6ilgN9jh8VqL
        13yPXzsg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34806)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1olAJL-0005qQ-Aa; Wed, 19 Oct 2022 15:44:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1olAJH-0002Ea-5V; Wed, 19 Oct 2022 15:44:43 +0100
Date:   Wed, 19 Oct 2022 15:44:43 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/2] ARM: mm: convert empty_zero_page to array for
 consistency
Message-ID: <Y1ANW9ZRRPDJxlmc@shell.armlinux.org.uk>
References: <20221018222503.90118-1-giulio.benetti@benettiengineering.com>
 <20221018222503.90118-2-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018222503.90118-2-giulio.benetti@benettiengineering.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:25:03AM +0200, Giulio Benetti wrote:
> ARM architecture is the only one to have empty_zero_page to be a
> struct page pointer, while in all other implementations empty_zero_page is
> a data pointer or directly an array(the zero page itself). So let's convert
> empty_zero_page to an array for consistency and to avoid an early
> allocation+dcache flush. Being the array in .bss it will be cleared earlier
> in a more linear way(and a bit faster) way.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

I'm completely against this approach. It introduces inefficiencies in
paths we don't need, and also means that the zero page is at a fixed
location relative to the kernel, neither of which I like in the
slightest.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
