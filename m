Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1203766C46D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjAPPy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAPPyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:54:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DEB22A0C;
        Mon, 16 Jan 2023 07:54:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D92C433878;
        Mon, 16 Jan 2023 15:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673884475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+vuORpOHQ+AS7Wy51WLoSsM0R/N2cByB/Ocy0ai6rAo=;
        b=SiUj34q1jbNV1pskKZDPTBEDEXasyWymprZY8Gy8/EI4uORx0GAZRdz843ns7uHlK07LQx
        lAiFWYVRoQkbt2va+VX1PEOYN/kTYGdByba+zxf4FXVQakIlkCTUf1aufyvZ56xJAr+sZ2
        6JOLZ9hblGsM6U7MtgrjWeKTQih/BoQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A30592C1A5;
        Mon, 16 Jan 2023 15:54:35 +0000 (UTC)
Date:   Mon, 16 Jan 2023 16:54:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the printk tree
Message-ID: <Y8VzOA9B5kuF3lQH@alley>
References: <20230116102301.66ccb248@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116102301.66ccb248@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-01-16 10:23:01, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the printk tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: "console_srcu_read_lock_is_held" [drivers/tty/serial/kgdboc.ko] undefined!
> 
> Caused by commit
> 
>   75ffddf01347 ("tty: serial: kgdboc: fix mutex locking order for configure_kgdboc()")

Great catch! Thanks a lot for the report.

It gets fixed by:

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -123,6 +123,7 @@ bool console_srcu_read_lock_is_held(void)
 {
 	return srcu_read_lock_held(&console_srcu);
 }
+EXPORT_SYMBOL(console_srcu_read_lock_is_held);
 #endif
 
 enum devkmsg_log_bits {


I have added this fix by ammending the problematic commit so that we
do not break bisection, see
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=rework/console-list-lock&id=3ef5abd9b5c738bc6fa9a65e40331ef2cb03ad9c

Best Regards,
Petr
