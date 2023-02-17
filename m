Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F4369AADB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjBQL4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjBQL43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:56:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E8D642DF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676634939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=00rjiVwOoEBMI8OSm4Q4oRCMoRX6iO5Vz3CEqn9CVGs=;
        b=VsPrIu52mjqSzy1CWO1KvA62+6F6MA1zLDgoYucx3FusOmPtSHARDT9762AqqJqvjVwKgs
        tvzzLyw5ZfPAB43mFcAzmBvP/zCxXnul3tAWiH94T0lbX0+DzZTgDP+tt5M+6so5Wnyzvm
        X6SrAlaHdxjTnJ1d1onXKBI9jutJEXE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-AyeZuoB7OVqwRC3PGDdtiw-1; Fri, 17 Feb 2023 06:55:34 -0500
X-MC-Unique: AyeZuoB7OVqwRC3PGDdtiw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C971101A521;
        Fri, 17 Feb 2023 11:55:33 +0000 (UTC)
Received: from localhost (unknown [10.22.16.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B430AC15BA0;
        Fri, 17 Feb 2023 11:55:32 +0000 (UTC)
Date:   Fri, 17 Feb 2023 08:55:31 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Thalmeier <michael.thalmeier@hale.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5.10-rt] printk: ignore consoles without write() callback
Message-ID: <Y+9rM7lRDwFrBPDX@uudg.org>
References: <87zg9d99mp.fsf@jogness.linutronix.de>
 <Y+5ftWNKMv9WJTXT@linutronix.de>
 <87bkls65pf.fsf@jogness.linutronix.de>
 <878rgw65lb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rgw65lb.fsf@jogness.linutronix.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 09:53:44AM +0106, John Ogness wrote:
> The ttynull driver does not provide an implementation for the write()
> callback. This leads to a NULL pointer dereference in the related
> printing kthread, which assumes it can call that callback.
> 
> Do not create kthreads for consoles that do not implement the write()
> callback. Also, for pr_flush(), ignore consoles that do not implement
> write() or write_atomic(), since there is no way those consoles can
> flush their output.
> 
> Link: https://lore.kernel.org/lkml/1831554214.546921.1676479103702.JavaMail.zimbra@hale.at
> Reported-by: Michael Thalmeier <michael.thalmeier@hale.at>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thank you! I will apply that to the next 5.10-rt build.

Luis

> ---
>  kernel/printk/printk.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d2205872304d..64747c72fbea 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2267,6 +2267,10 @@ static int printk_kthread_func(void *data)
>  /* Must be called within console_lock(). */
>  static void start_printk_kthread(struct console *con)
>  {
> +	/* No need to start a printing thread if the console cannot print. */
> +	if (!con->write)
> +		return;
> +
>  	con->thread = kthread_run(printk_kthread_func, con,
>  				  "pr/%s%d", con->name, con->index);
>  	if (IS_ERR(con->thread)) {
> @@ -3566,6 +3570,8 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
>  		for_each_console(con) {
>  			if (!(con->flags & CON_ENABLED))
>  				continue;
> +			if (!con->write && !con->write_atomic)
> +				continue;
>  			printk_seq = atomic64_read(&con->printk_seq);
>  			if (printk_seq < seq)
>  				diff += seq - printk_seq;
> -- 
> 2.30.2
> 
---end quoted text---

