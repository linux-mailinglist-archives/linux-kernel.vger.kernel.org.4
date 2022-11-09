Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C1B622F86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiKIP7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKIP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:58:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71635582
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:58:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5DE5521F48;
        Wed,  9 Nov 2022 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668009537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lcwukyKxB2ApIFV/OjV9f4nAQum8W3NPOnEd2m70kyY=;
        b=qWO/+W4JM7iXdNzy72fSdDcc8MgPUELZM8R99Ar2c3Xhgvv09XVad7qUB9kEyWY+aYzhQT
        eHuu3oQVoxvRN60kDQYGrfA3OLh8H0f9UCr0/xS761g+hgIH8seCkI/owUKjQAvlrIV83t
        +zpCSO7XMTauQd3va9xYu/0xm5qzlz4=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 095AB2C141;
        Wed,  9 Nov 2022 15:58:56 +0000 (UTC)
Date:   Wed, 9 Nov 2022 16:58:56 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 19/40] printk: console_device: use srcu console
 list iterator
Message-ID: <Y2vOQLRdDRhbyaTe@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-20-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-20-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 15:22:17, John Ogness wrote:
> Use srcu console list iteration for console list traversal.

I wonder if it would make sense to describe why this is acceptable.
But I am not sure how to explain this a reasonable way. I am afraid
that it might cause more confusion.

I would write something like:

<proposal>
It is acceptable because the consoles might come and go at any time.
Strict synchronizing with console registration code would not bring
any advantage over RCU.
</proposal>

> Document why the console_lock is still necessary. Note that this
> is a preparatory change for when console_lock no longer provides
> synchronization for the console list.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

As I said, I do not have strong opinion if the extra explanation
would help. So, with or without it:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
