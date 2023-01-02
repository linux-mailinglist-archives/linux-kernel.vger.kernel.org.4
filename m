Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3215565B3F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjABPPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjABPPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:15:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA028FD7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:15:05 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D0EEA5C233;
        Mon,  2 Jan 2023 15:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672672503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ZUOX0uilQeorOdPfHLNuOXnALPkIi8LpTX4sricaCM=;
        b=oahuLjWQdjbUtm90Z2vpIfDoewYBKvdTEoUr7Ib35V26MbqtkWc9uOheaqNI3CmzCYk1BP
        jV6n6/JNmEhFH8JTzRK8+ycReZ9qkeKjC9nEaDvPt5a40jDNHnDSmSQv+TEpenkz4MK1FR
        s6ZcTx8KAlAMfg1A9mBaIUwnndR86m0=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8AA4A2C141;
        Mon,  2 Jan 2023 15:15:03 +0000 (UTC)
Date:   Mon, 2 Jan 2023 16:15:03 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 4/6] printk: introduce struct console_buffers
Message-ID: <Y7LyHpHlLc3J+zXk@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221202704.857925-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-12-21 21:33:02, John Ogness wrote:
> Introduce a new struct console_buffers to contain all the buffers
> needed to read and format a printk message for console output.
> Putting the buffers inside a struct reduces the number of buffer
> pointers that need to be tracked. Also, it allows usage of the
> sizeof() macro for the buffer sizes, rather than expecting certain
> sized buffers being passed in.
> 
> Note that since the output buffer for normal consoles is now
> CONSOLE_EXT_LOG_MAX instead of CONSOLE_LOG_MAX, multi-line
> messages that may have been previously truncated will now be
> printed in full. This should be considered a feature and not a bug
> since the CONSOLE_LOG_MAX restriction was about limiting static
> buffer usage rather than limiting printed text.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks for renaming the buffers. I believe that it will make
the code easier to follow in the long term.

Best Regards,
Petr
