Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19120611B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJ1Tq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJ1Tqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:46:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E9346619
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f7UPO9GglDNa6WGQuH0EZ+JACzYc8vMJ42PwWrpInB8=; b=Xs66s8BcaErNF5KJA7QVqJlVle
        0w9H2YhZR7p9mVEuBucPzDlLrVI2aRUr8eZNE6yTDR6iJ5Qg3CJBc1ch0s+jCXF44JQphqp8yP81K
        d8sBUdVeR4RR6tSM/UUUJl8ZtgcUZ0YESU8oMxIgcUu4WMEsvHBqor4l6N0LlzGhUbWi0aKytZsjD
        pDKC8xDvX6vRs9VtYMcBMrnv7cNY0mWTTPY14tDC76cSNDAdiUioMSnxMjy1GTAT5FZHJYLZ1UWbA
        m/PdfKL7MF98FMjWydP0oSbJc7Knjmi5k+g4FSvTxdAgeUKdrCs/Ybvphfnv0S9oIfRirsTN6noSd
        T4r1j3Bg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35018)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ooVJZ-0000LY-O4; Fri, 28 Oct 2022 20:46:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ooVJY-0002q9-VX; Fri, 28 Oct 2022 20:46:48 +0100
Date:   Fri, 28 Oct 2022 20:46:48 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] ARM: findbit: document ARMv5 bit offset calculation
Message-ID: <Y1wxqPccRE+biAfw@shell.armlinux.org.uk>
References: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
 <E1ooSWP-000FDy-5t@rmk-PC.armlinux.org.uk>
 <CAHk-=wi63Sw3vNJ86gzg1Tdr=_xGwGyj+mH-eT0UgaAfGAHX+A@mail.gmail.com>
 <Y1wVTkIZjoMVfxOK@shell.armlinux.org.uk>
 <CAHk-=wh75aOWvaEhYsAcCJSRzhy8MO_SdvDzB6zmvVs+FeAr6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh75aOWvaEhYsAcCJSRzhy8MO_SdvDzB6zmvVs+FeAr6w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 12:01:00PM -0700, Linus Torvalds wrote:
> Hmm. Interestingly, your _find_first_zero_bit_le() (which
> find_next_bit ends up using except for the first byte) ends up doing
> an optimization that is technically not valid.
> 
> In particular, the *generic* code does
> 
>                         sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(val)), sz);
> 
> for the final result.
> 
> In contrast, the arm code doesn't do the "min()" at all, and if there
> are bits after the bitmap (in a partial byte), it will just return
> those bits.

You've missed how the min() is coded. Specifically, that's handled by:

  cc:   e1510000        cmp     r1, r0
  d0:   31a00001        movcc   r0, r1

which clamps the returned index to the size of the array (held in r1).
So everything is in fact fine - and I think your analysis is incorrect.

Please could you take another look and evaluate whether you think the
arm assembly is incorrect.

I kind'a stopped reading here on the assumption that the remainder of
your email was based on this misinterpretation of the code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
