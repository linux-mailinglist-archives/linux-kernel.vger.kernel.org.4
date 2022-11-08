Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300F062103F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiKHMUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiKHMUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:20:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ECA13EBE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:20:04 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0721D22496;
        Tue,  8 Nov 2022 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667910003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1ez2b6nAQxv47XY59j1FdNBLhiUKsk/XyDIZANCyJ8=;
        b=d4559rvDxPe5Htwb6TY0SZPRJzbDJuF5S010XBtRDy6EcdS2Ql7YhZo3cygnXWixx9hV63
        OCkn2gKJtdQd2kn5L1Hvw3P4AehroWYfwfY6jtj1ZFUgdNwF8kllf8LFjaeIkVSpTf3dNX
        S5fHX+FTg2wWTt+jd7o0scnSnSt/nvw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DD5C82C142;
        Tue,  8 Nov 2022 12:20:02 +0000 (UTC)
Date:   Tue, 8 Nov 2022 13:20:02 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 05/40] printk: fix setting first seq for
 consoles
Message-ID: <Y2pJcoCD2mN5SUfH@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 15:22:03, John Ogness wrote:
> It used to be that all consoles were synchronized with respect to
> which message they were printing. After commit a699449bb13b ("printk:
> refactor and rework printing logic"), all consoles have their own
> @seq for tracking which message they are on. That commit also changed
> how the initial sequence number was chosen. Instead of choosing the
> next non-printed message, it chose the sequence number of the next
> message that will be added to the ringbuffer.
> 
> That change created a possibility that a non-boot console taking over
> for a boot console might skip messages if the boot console was behind
> and did not have a chance to catch up before being unregistered.
> 
> Since it is not possible to know which boot console a console is
> taking over, use the lowest @seq of all the enabled boot consoles. If
> no boot consoles are available/enabled, begin with the next message
> that will be added to the ringbuffer.
> 
> Also, since boot consoles are meant to be used at boot time, handle
> them the same as CON_PRINTBUFFER to ensure that no initial messages
> are skipped.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
