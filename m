Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E749A63241A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiKUNmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiKUNm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:42:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7468AD44A;
        Mon, 21 Nov 2022 05:42:24 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 60FFA1F85D;
        Mon, 21 Nov 2022 13:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669038143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qA95gqtnEWLAc5KcUnMA1+AqDQceor8a48I1xrlWxRc=;
        b=nRIq5223HNCGsq8acn1PHL2RS+Wo/YQ6dMGManoY/hSzPww1tvGNwS8k8FUPlvAPY2vPT0
        89Tjv8TfPf7NWRl5rVQgcYCUXcQlGs/ILevFq6y1D1PRerriym2OxqsQkxvdHM2HOOLgr8
        Mw99JXZJ2SlTspdGjuE7/AU6aNdFvTY=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 40E352C143;
        Mon, 21 Nov 2022 13:42:22 +0000 (UTC)
Date:   Mon, 21 Nov 2022 14:42:22 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the printk tree
Message-ID: <Y3uAPvCxSYzUTzFc@alley>
References: <20221121110041.1d2c635b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121110041.1d2c635b@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-21 11:00:41, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the printk tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: "lockdep_assert_console_list_lock_held" [drivers/video/fbdev/xen-fbfront.ko] undefined!
> ERROR: modpost: "lockdep_assert_console_list_lock_held" [drivers/tty/serial/8250/8250.ko] undefined!
> ERROR: modpost: "lockdep_assert_console_list_lock_held" [drivers/tty/serial/samsung_tty.ko] undefined!
> ERROR: modpost: "lockdep_assert_console_list_lock_held" [drivers/tty/serial/kgdboc.ko] undefined!
> ERROR: modpost: "lockdep_assert_console_list_lock_held" [drivers/net/netconsole.ko] undefined!
> 
> Presumably caused by commits
> 
>   c26c1533e3bd ("printk: introduce console_list_lock")
>   a71ba89dc3ed ("console: introduce wrappers to read/write console flags")
>   d3ca62bf29bb ("console: introduce console_is_registered()")

John has fixed this by adding EXPORT_SYMBOL() for this function.

> I have used the printk tree from next-20221118 for today.

It is now fixed in "for-next" branch in printk/linux.git.

Thanks a lot for the report!

Best Regards,
Petr
