Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F2E66285E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjAIOXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjAIOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:23:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3804713F2B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:23:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CA40B383A9;
        Mon,  9 Jan 2023 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673274219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=skQuqxcc4cMluAbQQawa8WrbYBm9bOi8GVo5XKsdGaY=;
        b=SpzNdoBa52nxI9nvql0+B3NwUwW1RCKTWGXi1IHmvtdolKWtF+GajJi3MC59tpIwSZc+UW
        gvuffz/nfC2gMYyHkFGDwtIEdt6awvliexeaSSb937JDJN2y3YIOWTH9uUFCq4rhz2kil6
        u7okS3odp2YoG4iaPrnpkXjtH0X65/M=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AA0C92C141;
        Mon,  9 Jan 2023 14:23:39 +0000 (UTC)
Date:   Mon, 9 Jan 2023 15:23:39 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 7/8] printk: use printk_buffers for devkmsg
Message-ID: <Y7wja2TrMrT4qGyU@alley>
References: <20230109100800.1085541-1-john.ogness@linutronix.de>
 <20230109100800.1085541-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109100800.1085541-8-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-01-09 11:13:59, John Ogness wrote:
> Replace the buffers in struct devkmsg_user with a struct
> printk_buffers. This reduces the number of buffers to keep track of.
> 
> As a side-effect, @text_buf was 8kB large, even though it only
> needed to be the max size of a ringbuffer record. By switching to
> struct printk_buffers, ~7kB less memory is allocated when opening
> /dev/kmsg.
> 
> And since struct printk_buffers will be used now, reduce duplicate
> code by calling printk_get_next_message() to handle the record
> reading and formatting.
> 
> Note that since /dev/kmsg never suppresses records based on
> loglevel, printk_get_next_message() is extended with an extra
> bool argument to specify if suppression is allowed.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
