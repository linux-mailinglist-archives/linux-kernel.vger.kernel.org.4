Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96E689333
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjBCJMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjBCJMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:12:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B6B646B3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:12:14 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675415531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLQZunvNHlA7gv5JbIZlKojq/QfprG+f/aBfwaCUPlk=;
        b=OJ5/WBeePKP4NY4A/9yaUP1G21VbisD+9BuPEZMyPzdfaM/dMZWW5bKKRidQ+HBc9qpC4p
        Q9jHE5SCnBSXest1urqr66gY6Xbaq4pojgJoU55yvI0mK0cKU3m1L9hXsAeXpPcu5faQkk
        jrDqVdmMNW04b9jPo82wJOc7/h9gAVnaOE1XYHA1+vrbe4jeJXJ4clmyjGsWQhEewvuH6u
        PtFxTaQrnZ8uK4jtVJD7QBs6u85davO7P9/hpzimFCZn8po/8M13+6t7lzKoR2M0UHtCC8
        3rz3YDr5So9+5eseitDVUdYNHoPnW72PWb2ARSrn6BLP/zQgcT6rzzX7LxCQ7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675415531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLQZunvNHlA7gv5JbIZlKojq/QfprG+f/aBfwaCUPlk=;
        b=WUdmCvWfR0LAvXRDnSYID3kzTMUQuGGjHFr8BSXNqaSD67Bk8oWJn/2rv3Eh1hCeCrnkNT
        9eRA0/msXGeaUwDg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris Down <chris@chrisdown.name>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kernel/printk/index.c: fix memory leak with using
 debugfs_lookup()
In-Reply-To: <20230202151411.2308576-1-gregkh@linuxfoundation.org>
References: <20230202151411.2308576-1-gregkh@linuxfoundation.org>
Date:   Fri, 03 Feb 2023 10:17:10 +0106
Message-ID: <87cz6r5d1t.fsf@jogness.linutronix.de>
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

On 2023-02-02, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
