Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88926117EE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJ1Qr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ1QrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:47:24 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E490B86FAA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vf6WNjRrnNoJD4F4zYNGY5IkKPLfI5Fyrgdl2dIKPkg=; b=OiJXxZFjIgvS2nP1y/trRByLMx
        V1XmqNfeE7TNpwiT+CMIBDPjRcvnUJ7vufyCZDwry5onEe2Ie6tkB+QiylpEVrZ5QLx6dXiygSZVL
        NdOxGlXWXXejqRo9/QPu65ZLCTOtVWk7wlVJTssUXAeQkSwg+u6uBEmMLNTmLjZ1WQfWzK+xgUixA
        Yp1mG+7ovLt6Jyq27wfG/37idoKwp35zTsdSKoWGE/p+WSAVAIbQWL6EAbpXu070RDl4fyrRWZ7g0
        ncF+I5f1d6AbYcO3zxfazO4WFirlmfgdqnEawT/ex+0cNXARrQogSfHp0l6sMMmoVQQ3tD6c5V8v5
        ysaWThAg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35010)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ooSVr-00006C-E5; Fri, 28 Oct 2022 17:47:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ooSVp-0002ia-75; Fri, 28 Oct 2022 17:47:17 +0100
Date:   Fri, 28 Oct 2022 17:47:17 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 0/5] ARM: findbit assembly updates
Message-ID: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series updates the arm32 assembly versions of the findbit
operations:

- Document ARMv5 code that calculates the bit offset
- Provide an updated ARMv7 implementation using the rbit instruction
- Switch to use macros instead of duplicating mostly identical code
- Switch to using word loads rather than byte loads
- Add unwinder information for backtracing

I've had it sitting around in-use for some time, and no issues have
arisen. Tested also outside the kernel tree in userspace and results
are the same with the previous implementation.

Testing with the find_bit benchmark module shows that these operations
coded in assembly are faster than the generic versions (previously
posted), so I believe they're worth keeping.

 arch/arm/include/asm/assembler.h |   6 +
 arch/arm/lib/findbit.S           | 230 +++++++++++++++------------------------
 2 files changed, 94 insertions(+), 142 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
