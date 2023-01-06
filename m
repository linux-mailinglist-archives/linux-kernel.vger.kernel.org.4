Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA0365FF5D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjAFLLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjAFLLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:11:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE86C2A5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:11:12 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 615B824A78;
        Fri,  6 Jan 2023 11:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673003471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eul2FPd2zLCNMUGfxO9nD9ZKEURRkihsAs1254cmjkY=;
        b=mKmDPD9bXvP3lLFudhIWnZixzxwIadXE0XiAYvL0sL7/wrP5RGao1f8mM3QyTdNWLsRe8/
        LTecTDChPXq6T8tSgbmswqpBA5LZz3l6385KR4NqR8hKw2JStO+a10kN9wI99wvvWwnWxP
        3SB/9mXaCpmdpsMDhYb0yj3mwag6tpU=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 17DC52C143;
        Fri,  6 Jan 2023 11:11:11 +0000 (UTC)
Date:   Fri, 6 Jan 2023 12:11:08 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 8/8] printk: adjust string limit macros
Message-ID: <Y7gBzFWREFIyhMBX@alley>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
 <20230105103735.880956-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105103735.880956-9-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-05 11:43:35, John Ogness wrote:
> The various internal size limit macros have names and/or values that
> do not fit well to their current usage.
> 
> Rename the macros so that their purpose is clear and, if needed,
> provide a more appropriate value. In general, the new macros and
> values will lead to less memory usage. The new macros are...
> 
> PRINTK_MESSAGE_MAX:
> 
> This is the maximum size for a formatted message on a console,
> devkmsg, or syslog. It does not matter which format the message has
> (normal or extended). It replaces the use of CONSOLE_EXT_LOG_MAX for
> console and devkmsg. It replaces the use of CONSOLE_LOG_MAX for
> syslog.
> 
> Historically, normal messages have been allowed to print up to 1kB,
> whereas extended messages have been allowed to print up to 8kB.
> However, the difference in lengths of these message types is not
> significant and in multi-line records, normal messages are probably
> larger. Also, because 1kB is only slightly above the allowed record
> size, multi-line normal messages could be easily truncated during
> formatting.
> 
> This new macro should be significantly larger than the allowed
> record size to allow sufficient space for extended or multi-line
> prefix text. A value of 2kB should be plenty of space. For normal
> messages this represents a doubling of the historically allowed
> amount. For extended messages it reduces the excessive 8kB size,
> thus reducing memory usage needed for message formatting.
> 
> PRINTK_PREFIX_MAX:
> 
> This is the maximum size allowed for a record prefix (used by
> console and syslog). It replaces PREFIX_MAX. The value is left
> unchanged.
> 
> PRINTKRB_RECORD_MAX:
> 
> This is the maximum size allowed to be reserved for a record in the
> ringbuffer. It is used by all readers and writers with the printk
> ringbuffer. It replaces LOG_LINE_MAX.
> 
> Previously this was set to "1kB - PREFIX_MAX", which makes some
> sense if 1kB is the limit for normal message output and prefixes are
> enabled. However, with the allowance of larger output and the
> existence of multi-line records, the value is rather bizarre.
> 
> Round the value up to 1kB.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

I like this.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
