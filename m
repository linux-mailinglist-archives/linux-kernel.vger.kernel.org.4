Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE3262981D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbiKOMFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiKOMFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:05:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F932A40A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:04:09 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 47F841F8B4;
        Tue, 15 Nov 2022 12:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668513848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+mTdx5tg8Vlb5kyyqIvIDOY2WmPbB58ejrxB5NVI5nU=;
        b=OwOe6haAqMyswC05P6lNgDn5ghV3Sj2mqcfDD54l+/94vbCrSOX6YgbrrBDy+i9h7H6bTQ
        6oxGri8m6pjnbd3zVqrefCdkOB7E8BHRzvoAqu5Vn9fHAMrHhN9o/LSPF6nPq5pf4xgyiZ
        4iUaJeOp3t/ftXWLtGfccvyv9C7CKeM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 279DD2C143;
        Tue, 15 Nov 2022 12:04:08 +0000 (UTC)
Date:   Tue, 15 Nov 2022 13:04:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 05/39] printk: fix setting first seq for
 consoles
Message-ID: <Y3OAN4D0aURJIB70@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114162932.141883-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-14 17:34:58, John Ogness wrote:
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
