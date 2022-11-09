Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03924622EAA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiKIPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiKIPFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:05:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53919186E8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:05:06 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0E5DA229A1;
        Wed,  9 Nov 2022 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668006305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=krocaAMDDtdy6F5qydB2s4VN3uyIXVFWbhEHxDiWMks=;
        b=S+p3CMwVhelWzXHJYg2fhhYLkN0+Ub4hViBMnv+TSb7CM+SA6Ise9E6i0C5lOBtP9Fjk4J
        uVJuNY8PuD2aVAFGjZEGC5FAIHQBM+rTSRNJH7/3SCQZB4ETRxCLFP0KOfgCUvMu59fGQH
        friXNSBGNWcl22ZS9GLUDB9cXsCZXtU=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E7B522C141;
        Wed,  9 Nov 2022 15:05:04 +0000 (UTC)
Date:   Wed, 9 Nov 2022 16:05:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH printk v3 11/40] um: kmsg_dumper: use srcu console list
 iterator
Message-ID: <Y2vBoPZUNGPalQLq@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-12-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 15:22:09, John Ogness wrote:
> Rather than using the console_lock to guarantee safe console list
> traversal, use srcu console list iteration.

It might be obvious. But I would add:

"It allows to dump the messages even when console_lock() is blocked
during panic()."

It will help to understand this is a clear win.

> Signed-off-by: John Ogness <john.ogness@linutronix.de>

After merging with 9th patch for using the racy console_is_enabled(con):

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
