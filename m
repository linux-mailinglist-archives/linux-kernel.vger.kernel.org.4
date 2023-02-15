Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7546A697F65
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjBOPTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBOPTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:19:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60EA32508
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:19:38 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676474376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZn2T3Mh15ji0APk7TFY8AXkHfboPGAs5j3z+R7eAjQ=;
        b=LFwCHuPJUtDVtQ8Ijy7pPv5lu5JX8MkfiC+5tUwf6/vW18wxHY0SDCe782P9HJrzclQEBh
        4XsYpplgrZg8N9h3jULUWuoGQvMHQVmShgegdFZkAjxodAidROVEoc3QewPS5+XuGBvwHs
        lEbto8TTAgDOhrfHW/Ccu58LbGM6PHQQ3HJ7lpLssslqesacJRqrs8DuZDdnT5W956eiuA
        ufZ4NMlzEkJmbyGDAEqp26NXYZYmkSxDinRIYlzESgJR8N+1o1lf/ksxvP+cIcp/5TRM6w
        KeQCbpSuuKqg0HzyCmiBOkPzr4miwoMqcLF2lrhzT8bl91ENTxYAqpzpm+cR8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676474376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZn2T3Mh15ji0APk7TFY8AXkHfboPGAs5j3z+R7eAjQ=;
        b=5emvGziCI/39AtPZAFYqZLPansDtOJnekrJblbKf8DjOx2A62uJTjsBbsxYAtfNbzzMObH
        3NwSqwBrm1CjyJAg==
To:     Petr Mladek <pmladek@suse.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Michael Thalmeier <michael.thalmeier@hale.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tty: ttynull: implement console write
In-Reply-To: <Y+ztReOGJwAbpv52@alley>
References: <20230214115921.399608-1-michael.thalmeier@hale.at>
 <Y+zEAA1hp+3guGxT@axis.com> <Y+ztReOGJwAbpv52@alley>
Date:   Wed, 15 Feb 2023 16:24:23 +0106
Message-ID: <87y1oz7y9s.fsf@jogness.linutronix.de>
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

On 2023-02-15, Petr Mladek <pmladek@suse.com> wrote:
> That said, the current code is error-prone. The check for non-NULL
> con->write is too far from the caller.

con->write is supposed to be immutable after registration, so having the
check "far from the caller" is not a real danger.

console_emit_next_record() is the toplevel function responsible for
printing on a particular console so I think it is appropriate that the
check is made when determining if this function should be called. I also
think console_is_usable() is the proper place for the NULL check to
reside since that is the function that determines if printing is
allowed.

> I would prefer to make it more safe. For example, I would prevent
> registration of consoles without con->write callback in the first
> place. It would require, to implement the empty write() callback
> for ttynull console as done by this patch.

I would prefer that we do not start encouraging dummy implementations.
If you insist on con->write having _some_ value other than NULL, then we
could define some macro with a special value (CONSOLE_NO_WRITE). But
then we have to check that value. IMHO, allowing NULL is not an issue.

John Ogness
