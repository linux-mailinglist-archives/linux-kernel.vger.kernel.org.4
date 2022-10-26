Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAB860DD15
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiJZIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiJZIdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:33:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7295FDE2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:33:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 24A7022061;
        Wed, 26 Oct 2022 08:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666773195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zVU2aHnaAH7d6c5G2vGY5kQYIwa1i3dY4wuvkxw6czE=;
        b=mase5czrxqPAgDCctSqhxEbUugxDoJdBH6V2rAd4XUJwE3L9xkKEQERBABORfOB2A7epqL
        8G/ZmhiVwTVSOIfvkVYsxvU48e01mE7vfDJRJAK6dN+ZsI3NnI78fIuW5c+Te6QnL0rtQl
        XxQ7h/aMu5SM5EG8hMBmihazaYuOLKs=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EF9442C141;
        Wed, 26 Oct 2022 08:33:14 +0000 (UTC)
Date:   Wed, 26 Oct 2022 10:33:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 32/38] printk: __pr_flush: use srcu console
 list iterator
Message-ID: <Y1jwypTSckkoDTcd@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-33-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-33-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:54, John Ogness wrote:
> Use srcu console list iteration for console list traversal.
>
> Document why the console_lock is still necessary.

When thinking about it. It might be worth explaining why the srcu
traversal is added even when console_lock is still needed.
It would make the life of code archaeologists easier.

I mean to add a note that it will keep the traversal safe
even after console_drivers list manipulation will not longer be
serialized using console_lock(). Or something like this.

It would be nice to add this to all other patches the introduced
srcu and kept console_lock.

> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Anyway, the change looks good. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
