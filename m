Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B03B61F0FB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiKGKpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiKGKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:45:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB3A17E30
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:45:48 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667817946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TcLW5IgIdbM85txSnIl2VExgJJLEHq6R4dBSMPV+g+Q=;
        b=kKOU+16U1GU1vsqUJt/Aqd4MMyYGS15oY8MVcx1bxrZSHIiY7olMsg91Z7Bdk30JjOmpeK
        ozGAV19MElKEotmsm1h2fkMdwguGlpOkYEHeLTWuvAv/uviISdzdzEZpHWHrMLy7UG/awG
        fvqIUJmUu0KCHRv2o+L2bqfegn3xbfA+SkFi8euVKEWOPYKxJZbqpL57pBB5tWg7+XfRIV
        +1urfG+ZIZFEQcOyGm4QY7dElePncPYwWC8rRnqYHgRQhchgYHzm7zkU+QpZlaX08DDks0
        GDg2EMFCxBkfsRdwgSYZMuKUj/m+d1Vb42QmRX4qLxBfyGgYkhxcnwa8yudXFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667817946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TcLW5IgIdbM85txSnIl2VExgJJLEHq6R4dBSMPV+g+Q=;
        b=cDbQZKybIB2E4nfJ4K9mJIqeqc3vNSxSQFxaBFkSF8wamt8DyqSr0Mehrvgop/qbuyBv+s
        OSduEHI3xIm2ZHAA==
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [for-linus][PATCH 4/5] timers: Add timer_shutdown_sync() and
 timer_shutdown() to be called before freeing timers
In-Reply-To: <20221106233434.425162916@goodmis.org>
References: <20221106233037.815236769@goodmis.org>
 <20221106233434.425162916@goodmis.org>
Date:   Mon, 07 Nov 2022 11:45:46 +0100
Message-ID: <87sfivvy91.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06 2022 at 18:30, Steven Rostedt wrote:
>
> Link: https://lore.kernel.org/all/87pmlrkgi3.ffs@tglx/
> Link: https://lkml.kernel.org/r/20221106212702.363575800@goodmis.org
> Link: https://lore.kernel.org/all/20221105060024.598488967@goodmis.org/
>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

And please follow the guidelines of the tip tree for changelogs and tags.

I'll just grab it from the list and let my scripts run over it.

Thanks,

        tglx
