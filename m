Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78016298D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKOM1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKOM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:27:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB740247
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:27:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 521551F8BB;
        Tue, 15 Nov 2022 12:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668515220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o1GPphquw5VzfuGry5gzn0ZGXLKC+qRxtGb2SeLfGOY=;
        b=ZN4/m77PRVAF67ayyAoMT1+TfvptHhOYs8LeSzEYinv9muvna+10t1nkIWeDPghps4bQF4
        Qsg7V1ClaDycKzOoi6ebx5YvnQ9xHHb3JyER4JnADXJd7nllOmDPpciA7nWC/AriNtGS0u
        aEi3IkQlX9eTLKWsHaElemsrHpZrsgs=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 047992C142;
        Tue, 15 Nov 2022 12:26:59 +0000 (UTC)
Date:   Tue, 15 Nov 2022 13:26:59 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 11/39] console: introduce wrappers to
 read/write console flags
Message-ID: <Y3OFk2n7BquPUkOf@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114162932.141883-12-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-14 17:35:04, John Ogness wrote:
> After switching to SRCU for console list iteration, some readers
> will begin readings console->flags as a data race. Locklessly
> reading console->flags provides a consistent value because there
> is at most one CPU modifying console->flags and that CPU is
> using only read-modify-write operations.
> 
> Introduce a wrapper for SRCU iterators to read console flags.
> Introduce a matching wrapper to write to flags of registered
> consoles. Writing to flags of registered consoles is synchronized
> by the console_list_lock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
