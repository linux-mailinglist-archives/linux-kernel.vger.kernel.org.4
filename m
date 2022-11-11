Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727B8625AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiKKNHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiKKNGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:06:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2200587B36
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 05:06:11 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C4D55224D9;
        Fri, 11 Nov 2022 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668171969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KX5oLwpnZH2N9Qi5YM1DSC3MXjaNuoVumjBNBVvNwRc=;
        b=UGB1Wlq0dnMelgFdER/PiHh5/23OafowkgkHgnJtgQ0kMMecAPURYJ59NuSkXsK+QGF1+h
        aCyig7HGRGu26uJSunLlA815p/nPDavANvAFi8EfyumePGehNlT42drk3v1amTvzZi730b
        tMN/632ZTyVGH7L23VGUIcO8nN3iuI8=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 78C3A2C145;
        Fri, 11 Nov 2022 13:06:09 +0000 (UTC)
Date:   Fri, 11 Nov 2022 14:06:09 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 39/40] printk: relieve console_lock of list
 synchronization duties
Message-ID: <Y25IwcYWp1mYhB7j@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-40-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-40-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 15:22:37, John Ogness wrote:
> The console_list_lock provides synchronization for console list and
> console->flags updates. All call sites that were using the console_lock
> for this synchronization have either switched to use the
> console_list_lock or the SRCU list iterator.
> 
> Remove console_lock usage for console list updates and console->flags
> updates.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

All the accesses to console->flags and all the console_list walks
looks safe, so:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
