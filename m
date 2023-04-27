Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCAB6F032C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbjD0JO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjD0JO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:14:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EAFE1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:14:25 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 873FB1EC063F;
        Thu, 27 Apr 2023 11:14:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682586864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y09E9QS6Yr8kDAw0d1I7IaminPcVQRdJTamLt2npN78=;
        b=QNati0ej1iopUcgcVXDtlcdyEVRbI0gTlwWFE6QXo76lhE7WpnBf1y2iykB9IavTXGNazf
        adpr+7yLCSQ4l6oKewYCstqY1kW63xKh5fZf+6ukY/kY+R8YQiFhNGSBGDb3e/YySbOEiu
        zMoc+5DBszx0o7QyblzKXOws9UfiYQ4=
Date:   Thu, 27 Apr 2023 11:14:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     jpoimboe@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: An objtool warning from mainline
Message-ID: <20230427091421.GAZEo87ezQPLwLKiPF@fat_crate.local>
References: <02bd36cf-b2b8-4634-a70b-1476420188c8@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02bd36cf-b2b8-4634-a70b-1476420188c8@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 04:50:49PM -0700, Paul E. McKenney wrote:
> vmlinux.o: warning: objtool: exc_nmi+0x2b3: call to __const_udelay() leaves .noinstr.text section

What does

./scripts/faddr2line vmlinux.o exc_nmi+0x2b3

say?

I guess it should point to io_check_error()'s udelay().

If so, it is noinline:

81423c37415f ("x86/timer: Don't inline __const_udelay()")

> I see this with gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04) and also with
> gcc version 8.5.0 20210514 (Red Hat 8.5.0-18) (GCC).

I can't trigger it here with

gcc-11 (Debian 11.2.0-19) 11.2.0

Which is weird because the asm looks like it should warn.

Does it go away if you remove the noinline before __const_udelay()?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
