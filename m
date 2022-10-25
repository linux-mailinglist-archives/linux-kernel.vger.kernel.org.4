Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1FE60D386
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiJYS0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiJYS0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:26:41 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE226EAC94
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=upBc2hvAhnFz0aypqupjVKjhXLPHHpQCKVw6zRR9ZEc=; b=yc8ZsK5Cl5C6Ud+WSnbva6aGuy
        9VeR8Z4+E9ExtPkFz2JcRTqTxC5YQ0Q02MFkfPpo22uS6pcygB2+Oy7sYThoXlxWS4i2eEXHRul/v
        SW996uGp+eE1H/MDt3eEQXMQ8pLJH2Ih0+vV+11OwtPQWtPTfPnW4ZwyoK5pKOBodI1RjXclX9aq4
        XPaUATK+xAg8YhBTKgkPcZHUqocUc3VqpCUpklar1Vz9yEfAH7EIkt2Ls3gYWRTpCBaM0Z0qyxXxc
        +t4XD+lQK33vHHbR2lZINZaoJc4THf1oF9ihglojwQUvATYDcw/Qk3Gng+wo0sX6HUMXkKtGmz8XU
        pomsxMew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34952)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1onOdB-0004np-BL; Tue, 25 Oct 2022 19:26:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1onOd2-0008Iw-HX; Tue, 25 Oct 2022 19:26:20 +0100
Date:   Tue, 25 Oct 2022 19:26:20 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/2] bitmap: add sanity check function for find_bit()
Message-ID: <Y1gqTM19oLeN59Kl@shell.armlinux.org.uk>
References: <20221020032024.1804535-1-yury.norov@gmail.com>
 <20221020032024.1804535-2-yury.norov@gmail.com>
 <CAHk-=whij5pwOkG5HhMRzrvc4BTzhgj9h=wHo=tMVGasKE+p1w@mail.gmail.com>
 <Y1gY18JGz4zKw+gW@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1gY18JGz4zKw+gW@yury-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:11:51AM -0700, Yury Norov wrote:
> ARMv6 may or may not support unaligned access depending on SCTLR.U
> bit. This is what Russell was concerned about in the other email.
> As far as I understand, linux enables that feature.

However, we still support ARMv5 and ARMv4, both of which _trap_ every
unaligned access, which will make a findbit call with an unaligned
pointer using word loads painfully expensive. This is the main reason
we haven't used word loads in the findbit ops.

As mentioned, I have patches that do change that (and convert the
thing to use assembly macros to make updates much easier.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
