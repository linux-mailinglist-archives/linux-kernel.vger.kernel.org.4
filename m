Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCC2716459
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjE3OiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjE3OiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:38:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8D99D;
        Tue, 30 May 2023 07:38:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B68D31FDBD;
        Tue, 30 May 2023 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685457483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEWDz7JwGiqY+ip6MkjEhTCueHSdAyErkZJwkzbYyE4=;
        b=H9+gDrhDk7P6aYZALA8W3gBxOfmADodBMBnKpnh9CR1bOZrBKtUPxNNU0Fxz9HL7TjURP9
        0QlCDBA6daGwBCzSQ8b8m1IXqGxF0MwzIX889H27PzrH4M5Gqse83WRsSFSCTrF2ec44jL
        t8a6iKbactbBCYzF384qgrhrrBTKxKs=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A9252C142;
        Tue, 30 May 2023 14:38:03 +0000 (UTC)
Date:   Tue, 30 May 2023 16:38:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 02/10] watchdog/hardlockup: HAVE_NMI_WATCHDOG must
 implement watchdog_hardlockup_probe()
Message-ID: <ZHYKSnLBU82fM1O2@alley>
References: <20230527014153.2793931-1-dianders@chromium.org>
 <20230526184139.2.Ic6ebbf307ca0efe91f08ce2c1eb4a037ba6b0700@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526184139.2.Ic6ebbf307ca0efe91f08ce2c1eb4a037ba6b0700@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-05-26 18:41:32, Douglas Anderson wrote:
> Right now there is one arch (sparc64) that selects HAVE_NMI_WATCHDOG
> without selecting HAVE_HARDLOCKUP_DETECTOR_ARCH. Because of that one
> architecture, we have some special case code in the watchdog core to
> handle the fact that watchdog_hardlockup_probe() isn't implemented.
> 
> Let's implement watchdog_hardlockup_probe() for sparc64 and get rid of
> the special case.
> 
> As a side effect of doing this, code inspection tells us that we could
> fix a minor bug where the system won't properly realize that NMI
> watchdogs are disabled. Specifically, on powerpc if
> CONFIG_PPC_WATCHDOG is turned off the arch might still select
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH which selects
> CONFIG_HAVE_NMI_WATCHDOG. Since CONFIG_PPC_WATCHDOG was off then
> nothing will override the "weak" watchdog_hardlockup_probe() and we'll
> fallback to looking at CONFIG_HAVE_NMI_WATCHDOG.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

> ---
> Though this does fix a minor bug, I didn't mark this as "Fixes"
> because it's super minor. One could also argue that this wasn't a bug
> at all but simply was never an implemented feature. The code that
> added some amount of dynamicness here was commit a994a3147e4c
> ("watchdog/hardlockup/perf: Implement init time detection of perf")
> which, as per the title, was only intending to make "perf"
> dynamic. The old NMI watchdog presumably has never been handled
> dynamically.

I agree that it is a minor bug and Fixes tag is not needed.

Another motivation is that all the dependencies are quite
complicated. IMHO, it is not worth spending time on
reviewing potential backports.

That said, I am afraid that the artificial intelligence will nominate
this patch for stable backports even without the Fixes tag.
You know, there are the words "fix" and "bug" in the commit message ;-)

Best Regards,
Petr
