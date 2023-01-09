Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F164E662827
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbjAIOMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjAIOMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:12:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D214BD111
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:12:44 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 665EB3EBF6;
        Mon,  9 Jan 2023 14:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673273563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+yozOgNTt9eCwnTHnsCOLaR7QkUN+VaDLEjV1bjk4IE=;
        b=UhANe2aAaTQOvENX8gBGQwv8p1pGCMBf/Dtx+ZItfP7CzK8+NDts2zZUsAUCkGKpDQo9Ha
        nme2ZxInNghp9YayRSwHpzS2z9sVn/S8JumEthckPD+2dPfr900itQ0RdC4pCyNPnxiYpk
        fqA8IOTjc8AMwjsAiebF8XDs8eRQbxg=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 351DA2C141;
        Mon,  9 Jan 2023 14:12:43 +0000 (UTC)
Date:   Mon, 9 Jan 2023 15:12:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 6/8] printk: introduce
 console_prepend_dropped() for dropped messages
Message-ID: <Y7wg2AkVs09rrB0v@alley>
References: <20230109100800.1085541-1-john.ogness@linutronix.de>
 <20230109100800.1085541-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109100800.1085541-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-01-09 11:13:58, John Ogness wrote:
> Currently "dropped messages" are separately printed immediately
> before printing the printk message. Since normal consoles are
> now using an output buffer that is much larger than previously,
> the "dropped message" could be prepended to the printk message
> and then output everything in a single write() call.
> 
> Introduce a helper function console_prepend_dropped() to prepend
> an existing message with a "dropped message". This simplifies
> the code by allowing all message formatting to be handled
> together and then only requires a single write() call to output
> the full message. And since this helper does not require any
> locking, it can be used in the future for other console printing
> contexts as well.
> 
> Note that console_prepend_dropped() is defined as a NOP for
> !CONFIG_PRINTK. Although the function will never be called for
> !CONFIG_PRINTK, compiling the function can lead to warnings of
> "always true" conditionals due to the size macro values used
> in !CONFIG_PRINTK.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
