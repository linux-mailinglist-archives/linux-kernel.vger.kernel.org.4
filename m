Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1365FF0F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjAFKj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjAFKjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:39:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E026C2BA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 02:39:19 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E0AA467ADD;
        Fri,  6 Jan 2023 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673001557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EiBJZJ4ggV3NunPfr8un94/jX3mnXz8E8OwTOUdl1co=;
        b=UapCDczZ4p9PUNoPEVHM8ZK6qOHQAajPCnxrXsUcrGHIpBabOODFh6zf6aGaVcHgLKIJe/
        lM/jgXTfm23FwNHfKgmyIU9kutpBu09NdDnETKRSyao82pAFTc7AJncnbrPJ3DGj0RQrsj
        Gphpi8ywC9ed3D0MPZNMXPk06o61ARw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9EC902C143;
        Fri,  6 Jan 2023 10:39:17 +0000 (UTC)
Date:   Fri, 6 Jan 2023 11:39:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 7/8 v2] printk: use printk_buffers for devkmsg
Message-ID: <Y7f6U8+Kk3VoF5Dk@alley>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
 <20230105103735.880956-8-john.ogness@linutronix.de>
 <87fscpch67.fsf@jogness.linutronix.de>
 <87cz7tch2n.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz7tch2n.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-05 13:22:16, John Ogness wrote:
> Replace the buffers in struct devkmsg_user with a struct
> printk_buffers. This reduces the number of buffers to track.
> 
> As a side-effect, @text_buf was 8kB large, even though it only
> needed to be the max size of a ringbuffer record. By switching to
> struct printk_buffers, ~7kB less memory is allocated when opening
> /dev/kmsg.
> 
> And since struct printk_buffers will be used now, reduce duplicate
> code by calling printk_get_next_message() to handle the record
> reading and formatting.

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 40 ++++++++++++++++------------------------
>  1 file changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 4fb7d29fb05d..32996b0c5d03 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -695,16 +695,14 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
>  	return len;
>  }
>  
> +static bool printk_get_next_message(struct printk_message *pmsg, u64 seq, bool is_extended);
> +
>  /* /dev/kmsg - userspace message inject/listen interface */
>  struct devkmsg_user {
>  	atomic64_t seq;
>  	struct ratelimit_state rs;
>  	struct mutex lock;
> -	char buf[CONSOLE_EXT_LOG_MAX];
> -
> -	struct printk_info info;
> -	char text_buf[CONSOLE_EXT_LOG_MAX];
> -	struct printk_record record;
> +	struct printk_buffers pbufs;
>  };
>  
>  static __printf(3, 4) __cold
> @@ -786,8 +784,10 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>  			    size_t count, loff_t *ppos)
>  {
>  	struct devkmsg_user *user = file->private_data;
> -	struct printk_record *r = &user->record;
> -	size_t len;
> +	char *outbuf = &user->pbufs.outbuf[0];
> +	struct printk_message pmsg = {
> +		.pbufs = &user->pbufs,
> +	};
>  	ssize_t ret;
>  
>  	if (!user)
> @@ -797,7 +797,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>  	if (ret)
>  		return ret;
>  
> -	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
> +	while (!printk_get_next_message(&pmsg, atomic64_read(&user->seq), true)) {

A problem is that printk_get_next_message() does not format the
message when it shoud get supressed on the console.

I would solve it be adding a parameter to printk_get_next_message() that
will tell whether to suppress or not, e.g. @can_suppress.

>  		if (file->f_flags & O_NONBLOCK) {
>  			ret = -EAGAIN;
>  			goto out;
> @@ -814,36 +814,31 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>  		 * This pairs with __wake_up_klogd:A.
>  		 */
>  		ret = wait_event_interruptible(log_wait,
> -				prb_read_valid(prb,
> -					atomic64_read(&user->seq), r)); /* LMM(devkmsg_read:A) */
> +					       prb_read_valid(prb, atomic64_read(&user->seq),
> +							      NULL)); /* LMM(devkmsg_read:A) */

The above change from "if" to "while" could be avoided if we use
printk_get_next_message() here as well. It looks slightly more
strightfoward to me. Or do I miss something, please?


>  		if (ret)
>  			goto out;
>  	}
>  

Otherwise, I like this change. It simplifies the code.

Best Regards,
Petr
