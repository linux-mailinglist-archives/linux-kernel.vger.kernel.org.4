Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2836B22F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCIL2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCIL1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:27:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1013E9814
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:26:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3B86920042;
        Thu,  9 Mar 2023 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678361187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1JyAd3b05tzFLupYz6YAu1igKV4UZRoyxnsO7wPUvRo=;
        b=fl+t7ds86l4W4IrXmm7wX8HBqQofRJ6coWsVs6X9QULqy0qTojEr9ZiEpgeGJBnP2srvYT
        y8/YkJkRL/c8PVEkcLL3fpfY8IunDKj07U9yvvyWgt1jg7UjkYXblom04btAQADNV9vv4o
        xKAPkosPanOlhxSHCps2Zqg7pG8lOmg=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 391312C141;
        Thu,  9 Mar 2023 11:26:23 +0000 (UTC)
Date:   Thu, 9 Mar 2023 12:26:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v1 01/18] kdb: do not assume write() callback
 available
Message-ID: <ZAnCXxui+QiNNRb6@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-2-john.ogness@linutronix.de>
 <20230309105240.GA83039@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309105240.GA83039@aspen.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-09 10:52:40, Daniel Thompson wrote:
> On Thu, Mar 02, 2023 at 09:02:01PM +0106, John Ogness wrote:
> > It is allowed for consoles to provide no write() callback. For
> > example ttynull does this.
> >
> > Check if a write() callback is available before using it.
> >
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Any thoughts on best way to land the series. All via one tree or can
> we pick and mix?

I would prefer to take everything via the printk tree because
most changes are there. Otherwise, we might end up with non-necessary
cross-tree merge conflicts. Also I would know when all pieces are
there.

That said, this seems to be the only change in
kernel/debug/kdb/kdb_io.c and it is relatively independent.
So, it should not be a big problem to take it separately.

Best Regards,
Petr
