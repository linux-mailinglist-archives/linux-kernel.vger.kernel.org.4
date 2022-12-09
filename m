Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7163D648899
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLISpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLISpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:45:45 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184DDA56D1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ULuEUQZqBWYd6esr1h4MJOw0tF20vmGw9ViKBcGzSIc=; b=AXjym830w4YGpbMUvNVy3yF6ls
        WSkBOp4Ote4KomL5RrpGrzElxtkWZAwoZwvl8W0aakZVsAfvQQGdlwRwgKT6xUqdcvUlPKLMy36MD
        VQWKvLirNR9+QcVJkIUZoKDXuOx98NXS7TQ7MNGzeWY4QzomgHipb2B20BhuUJqf5sN8xJPFNZ0IW
        1G8gU+cJyugj2AyZfnD5jo1W+7aiJNolQhiGe8ji715bPKi+kPsrsfSsuWk6+0CZsEf+qhgmS5nOo
        OLlwaLqIBq2C1l/aYPYc4hBci0nmatZWta746FFNbi5gt5PTcakWxyiwScN1RBq3MgKHqOZ8WoGTI
        r8DYV5gQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35644)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1p3iNM-0003MY-8i; Fri, 09 Dec 2022 18:45:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1p3iNK-0002ru-Um; Fri, 09 Dec 2022 18:45:34 +0000
Date:   Fri, 9 Dec 2022 18:45:34 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [RFC 1/1] ARM: Drop !ARCH_MULTIPLATFORM dependency from Cortex
 A8/9 erratas
Message-ID: <Y5OCTseqVQ+AcMqm@shell.armlinux.org.uk>
References: <20221209182000.549179-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209182000.549179-1-sebastian.reichel@collabora.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 07:20:00PM +0100, Sebastian Reichel wrote:
> All the erratas for more recent CPUs (Cortex A15/A12/A17) do not
> require !ARCH_MULTIPLATFORM, since there is runtime detection of
> effected CPUs in arch/arm/mm/proc-v7.S.
> 
> Errata config options for the older Cortex A8/A9 CPUs have the
> !ARCH_MULTIPLATFORM dependency, but the CPUs are also runtime
> detected. Since there is runtime detection, it should be fine
> to enable the erratas for a multi platform kernel.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> For me the most likely explanation that this has not yet happened is
> me missing an important detail, so I sent it as RFC. If you point it
> out I will try to document the reason.

IIRC, the reason these are marked with !ARCH_MULTIPLATFORM is for when
the kernel is running in the non-secure world - the accessed registers
may prevent platforms booting. However, it was a long time ago and I
don't remember clearly now.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
