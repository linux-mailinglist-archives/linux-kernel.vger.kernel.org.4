Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107CF6043AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiJSLqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiJSLqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:46:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE5319C079;
        Wed, 19 Oct 2022 04:26:03 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666178034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9//IKOu9ewVBs2/Obw0rBK1SP6wrE+NMqEzAlqdIk0E=;
        b=ScLWj7YaNe++ZhkWz9LgyX3UVuU4Q/2sddgtgCmihQNZ/YgpzOFtGX0J2NUbD9dZfc3ASX
        cvXj/zuFtu/uOcgye1B4Nn2O1myXjAdCYMVIIFaPOuUFHBsZbn8IB9OYvbIhWmYfUT5i6t
        MZVjgOZ/jNkY+O9C+pPkjhompmbA8OZpIf3ZBkrYjKzonqlNt4avwXz5/QT1xlwI+v2v/9
        d1yRaqR8z9K10tQtafPGswC36YxpKmTMyWFxHPYNuC14+GynN0bUa2NwhuN9G0CeI9gcNo
        J7HIFHvGvbZ3c4tYkAgZ6Ns29naxA5A0S0IOZxBt9FsXYQeVx3M5hd2ul12pjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666178034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9//IKOu9ewVBs2/Obw0rBK1SP6wrE+NMqEzAlqdIk0E=;
        b=Cgq+LsU88Xix1l7OMljpqQ5LmkwRCzO+lLXgpUKGeAWSLPags9fFQQMJeFUuPxauNuMPQZ
        H3QXSAmADgVZ0/AQ==
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        pmladek@suse.com, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
In-Reply-To: <20221018215721.GA1716567@paulmck-ThinkPad-P17-Gen-1>
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <87k04x4e0r.fsf@jogness.linutronix.de>
 <20221018152418.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <87ilkh0y52.fsf@jogness.linutronix.de>
 <20221018185936.GX5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018215721.GA1716567@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 19 Oct 2022 13:19:53 +0206
Message-ID: <87pmeoawwe.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-18, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> And the v6.1-rc1 stack is now at srcunmisafe.2022.10.18b.

Thanks!

I guess the kernel test robot will catch this, but if you checkout
commit 79c95dc428ad ("arch/x86: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
Kconfig option") and build for x86_64, you will get:

x86_64-linux-gnu-ld: kernel/rcu/srcutree.o: in function `srcu_gp_start_if_needed':
srcutree.c:(.text+0x133a): undefined reference to `__srcu_read_lock_nmisafe'
x86_64-linux-gnu-ld: srcutree.c:(.text+0x1490): undefined reference to `__srcu_read_unlock_nmisafe'
x86_64-linux-gnu-ld: kernel/rcu/srcutree.o: in function `srcu_barrier':
srcutree.c:(.text+0x1b03): undefined reference to `__srcu_read_lock_nmisafe'
x86_64-linux-gnu-ld: srcutree.c:(.text+0x1b38): undefined reference to `__srcu_read_unlock_nmisafe'

Note that this error is fixed with a later commit:

commit c2d158a284ab ("srcu: Debug NMI safety even on archs that don't
require it").

This does not affect what I am working on, so feel free to take care of
it whenever it fits your schedule.

John Ogness
