Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0280F632909
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiKUQJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiKUQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:09:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8CBCEB8B;
        Mon, 21 Nov 2022 08:09:26 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 34E261F899;
        Mon, 21 Nov 2022 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669046965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IpvY7HmeSZqqsYSrW2HTvY/yDZgDDPGYw0H4l9bmBk0=;
        b=aZ2RB9Em01NnaniZqFFQvHgiRuAREy3Fd7QAPriQJglGYZsLdQUER8B7BPvQg0B/SPVzvo
        VU2mz1GHvs6BBHTea+ETmRPmP8Metgs+lhN8fRghQsPVbjpMWynhvYri16+PBqXuFxyezX
        aWd6dKixOABM4Yrr7DLfPgIUQHKAL4E=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0E1D32C146;
        Mon, 21 Nov 2022 16:09:25 +0000 (UTC)
Date:   Mon, 21 Nov 2022 17:09:21 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: process: use explicit levels for printk
 continuations
Message-ID: <Y3uisbm9NEqF7EOM@alley>
References: <20221121050946.3540-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121050946.3540-1-linux@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-21 06:09:46, Thomas Weiﬂschuh wrote:
> Many of the printk messages emitted during suspend and resume are
> emitted in fragments using pr_cont()/KERN_CONT.
> 
> As during suspend and resume a lot of operations are happing in the
> kernel the chances are high that the fragments are interspersed with
> unrelated messages.
> 
> In this case if no explicit level is specified for the fragments the
> standard level is applied, which by default is KERN_WARNING.
> 
> If the user is only observing KERN_WARNING and *not* KERN_INFO messages
> they will see incomplete message fragments.
> 
> By specifing the correct printk level also with the continuations this
> mismatch can be avoided.
> Also it reduces the amount of false-positive KERN_WARNING messages.

Yup, it is a known printk() limitation and this is the most reliable
solution.

> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  kernel/power/process.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index ddd9988327fe..0a828edc6d30 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -101,7 +101,7 @@ static int try_to_freeze_tasks(bool user_only)
>  			read_unlock(&tasklist_lock);
>  		}
>  	} else {
> -		pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,
> +		pr_info(KERN_CONT "(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,

It looks a bit ugly. Feel free to provide separate patch introducing
pr_<level>_cont() wrappers. Then you could use pr_info_cont() here.

We already have pr_<level>_once() and pr_<level>_ratelimited().
So pr_<level>_cont() would fit the existing pattern.


>  			elapsed_msecs % 1000);
>  	}
>  

Best Regards,
Petr
