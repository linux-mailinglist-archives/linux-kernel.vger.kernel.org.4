Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2188560DCF4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiJZIUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJZIUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:20:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B24A3A89
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:20:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A84411FD70;
        Wed, 26 Oct 2022 08:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666772437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o80/HDsMN4P0eLx/yQrZsujT04sHLYgtwjRxm0A3BOQ=;
        b=cqucEDl8yQEnz1jleO1R3+7tsYzGKz3yD8JxqwuJijfTpcQp16Do0qPpDwIXG8RByg2vzj
        /P3UF9xTGpYiNhPr9OHHPqng1WOb21tAueeEkwvy8M0HrAgEoF7Xe6D8LcddC0LcYOoquf
        fuwfIxcrShM7BwAygFOTnwy1aZH6poc=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6ECAC2C141;
        Wed, 26 Oct 2022 08:20:37 +0000 (UTC)
Date:   Wed, 26 Oct 2022 10:20:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 31/38] printk: register_console: use srcu
 console list iterator
Message-ID: <Y1jt1Xd23FIj1kbF@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-32-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-32-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:53, John Ogness wrote:
> Use srcu console list iteration for console list traversal. Now
> the traversal at the beginning of register_console() is safe.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

That said, I think that we could omit this patch. It does not harm.
It prevents a crash when iterating the list but it is only small part
of the races here.

For example, it sets "realcon_enabled" but the list might change before the
value is used. Also the later hlist_empty(&console_list) and
!console_first->device checks are not secure against each other.

The real solution is the introduction of console_list_lock in 33th
patch. That patch removes the rcu read lock. From this POV, this patch
is just unnecessary churn.

Best Regards,
Petr
