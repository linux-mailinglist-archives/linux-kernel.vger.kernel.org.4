Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA1662CEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKPXan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiKPXak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:30:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9CC68697
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:30:39 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668641435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDaFkdlN2tr+Rr4sOx7rnuAZtKYB2+xwBw4RZnHYHdQ=;
        b=I4fneGuUDEiOoNVAyslD23Xl5KFKYbb2dwcSjLXWVQcL3F5/xbpOcLmddw7okzRQjYJG62
        f45C2kSAp5SFnbWpxA/QlJ7dC37DuR2WeMBAbUMA9U49WSjWaf1YAFCLJkzVJvBEuPiWmf
        DoF450ItHYdX/GlDHRmCHbaX8T+gTTaTu2OqnKp9PVprQmD45qA8v6pBSA8BjNtrSfcb6O
        SJacOWFHFC8r+8EWGqQ/MMJc4TgAnbJP0sxQLXgZ1Nj0kuda6hsnueewtVo4IAhQ6Rkyfz
        CVKX6UQ9Fjd6Y0paR+QkZoAyGH/HjDxAWfAmNBPYqUXu+kbeBgUC3flJtZavyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668641435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDaFkdlN2tr+Rr4sOx7rnuAZtKYB2+xwBw4RZnHYHdQ=;
        b=c3IgSOcHcXFRwxAaRQ0jxKXBTdV5ZEtxUZumEw6sDBekzeyE0eKLJ5e6Zjh6VUxwSL/XiF
        yA8TYxsADWTFtPAg==
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 18/46] entry, lto: Mark raw_irqentry_exit_cond_resched()
 as __visible
In-Reply-To: <20221114114344.18650-19-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-19-jirislaby@kernel.org>
Date:   Thu, 17 Nov 2022 00:30:34 +0100
Message-ID: <87a64qo4th.ffs@tglx>
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

On Mon, Nov 14 2022 at 12:43, Jiri Slaby wrote:
> Symbols referenced from assembler (either directly or e.f. from

from assembler? I'm not aware that the assembler references anything.

Also what does e.f. mean? Did you want to write e.g.?

> DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
> they could end up in a different object file than the assembler. This

than the assembler? Are we shipping the assembler in an object file?

> can lead to linker errors without this patch.

git grep -i 'this patch' Documentation/process/

> So mark raw_irqentry_exit_cond_resched() as __visible.

And all that tells me what? I know what you want to say, but it's not
there.

  Symbols in different compilation units which are referenced from
  assembly code either directly or indirectly, e.g. from
  DEFINE_STATIC_KEY(), must be marked visible for GCC based LTO builds.

  Add the missing __visible annotation to raw_irqentry_exit_cond_resched().

See?

There is no 'global' because it's obvious that a symbol in a different
compilation unit must be global to be resolvable. It's also obvious that
code in different compilation units ends up in different object files.

So stating that it's a 'must' to have such symbols marked visible is
good enough for an argument because that tells the reader that this is a
mandatory requirement for an GCC based LTO build.

No?

Thanks,

        tglx

