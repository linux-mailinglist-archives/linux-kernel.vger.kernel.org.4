Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC15716549
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjE3O4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjE3O4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:56:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53EFB0;
        Tue, 30 May 2023 07:56:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7A06F1FD85;
        Tue, 30 May 2023 14:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685458587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4zjZSXWgs35Ue3qF1WuzqRP54/h45jHQgSPnhYcIU8k=;
        b=X7CGi3j7OdaOafJPBf4V7/HfYwoFC4WhmdvEtMPU/E5sBlErtslZ0vRFR0mCB3gXTWC5M/
        pWYwuEZXPzhVsflGNNkoJ7gkdwRBeN017rNvllAhCW2x9iPDS+i86UBflSU835J+caFnAC
        vDypk4j2dnH67+rCEnPiE4IRyvA9VDI=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 261FD2C141;
        Tue, 30 May 2023 14:56:27 +0000 (UTC)
Date:   Tue, 30 May 2023 16:56:26 +0200
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
Subject: Re: [PATCH 06/10] watchdog/buddy: Cleanup how
 watchdog_buddy_check_hardlockup() is called
Message-ID: <ZHYOmkZBxd4TiTv-@alley>
References: <20230527014153.2793931-1-dianders@chromium.org>
 <20230526184139.6.I006c7d958a1ea5c4e1e4dc44a25596d9bb5fd3ba@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526184139.6.I006c7d958a1ea5c4e1e4dc44a25596d9bb5fd3ba@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-05-26 18:41:36, Douglas Anderson wrote:
> In the patch ("watchdog/hardlockup: detect hard lockups using
> secondary (buddy) CPUs"), we added a call from the common watchdog.c
> file into the buddy. That call could be done more cleanly.
> Specifically:
> 1. If we move the call into watchdog_hardlockup_kick() then it keeps
>    watchdog_timer_fn() simpler.
> 2. We don't need to pass an "unsigned long" to the buddy for the timer
>    count. In the patch ("watchdog/hardlockup: add a "cpu" param to
>    watchdog_hardlockup_check()") the count was changed to "atomic_t"
>    which is backed by an int, so we should match types.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>


The change looks fine:

Reviewed-by: Petr Mladek <pmladek@suse.com>

That said, I would prefer to squash it into the patch ("watchdog/hardlockup:
detect hard lockups using secondary (buddy) CPUs"). It would remove
some back and forth churn in the git history. But it is up to Andrew.

Best Regards,
Petr
