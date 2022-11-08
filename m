Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151AC621114
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiKHMlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiKHMlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:41:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB3750F2C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:41:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B6128224A0;
        Tue,  8 Nov 2022 12:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667911265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c3dZM4uCLlwzncmOgKppFTjizqzC3KOzooj1gFTH490=;
        b=OHWhrJS4mb795unDDeporWwSHoWUPrjMOCIy07QYr/0hrnUV/nHxV/IYLNsd32ea+izcGH
        HxwR3L2w97NZlULzWu73QcSmSX4oJZyTj/2cqiEMQv3/E+E8SQfoXpwACBXb/K19kauNLf
        XkoijjZ27KhF4I4ed+q7TSRmDIfDNe8=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 508A72C142;
        Tue,  8 Nov 2022 12:41:05 +0000 (UTC)
Date:   Tue, 8 Nov 2022 13:41:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH printk v3 06/40] um: kmsg_dump: only dump when no output
 console available
Message-ID: <Y2pOYBkNPY3wd6vn@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 15:22:04, John Ogness wrote:
> The initial intention of the UML kmsg_dumper is to dump the kernel
> buffers to stdout if there is no console available to perform the
> regular crash output.
> 
> However, if ttynull was registered as a console, no crash output was
> seen. Commit e23fe90dec28 ("um: kmsg_dumper: always dump when not tty
> console") tried to fix this by performing the kmsg_dump unless the
> stdio console was behind /dev/console or enabled. But this allowed
> kmsg dumping to occur even if other non-stdio consoles will output
> the crash output. Also, a console being the driver behind
> /dev/console has nothing to do with a crash scenario.
> 
> Restore the initial intention by dumping the kernel buffers to stdout
> only if a non-ttynull console is registered and enabled. Also add
> detailed comments so that it is clear why these rules are applied.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The change makes sense to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
