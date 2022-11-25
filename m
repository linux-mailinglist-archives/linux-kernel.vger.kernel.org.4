Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B43639091
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 21:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiKYUSq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Nov 2022 15:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKYUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 15:18:45 -0500
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9354B3C;
        Fri, 25 Nov 2022 12:18:44 -0800 (PST)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 16469120E10;
        Fri, 25 Nov 2022 20:18:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id E4F2C20024;
        Fri, 25 Nov 2022 20:18:39 +0000 (UTC)
Message-ID: <1fb146231e1810b4c9923f384afa166e07e7f253.camel@perches.com>
Subject: Re: [PATCH v2 1/3] printk: introduce new macros pr_<level>_cont()
From:   Joe Perches <joe@perches.com>
To:     Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 25 Nov 2022 12:18:39 -0800
In-Reply-To: <20221125190948.2062-2-linux@weissschuh.net>
References: <20221125190948.2062-1-linux@weissschuh.net>
         <20221125190948.2062-2-linux@weissschuh.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E4F2C20024
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: e45qpp4yydk1s8hnejt63rpfar1zcp7c
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18Dumif6Rntq0hk+ClDBLKwDMFpMrrz2Qs=
X-HE-Tag: 1669407519-309942
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-11-25 at 20:09 +0100, Thomas Weiﬂschuh wrote:
> These macros emit continuation messages with explicit levels.
> In case the continuation is logged separately from the original message
> it will retain its level instead of falling back to KERN_DEFAULT.
> 
> This remedies the issue that logs filtered by level contain stray
> continuation messages without context.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  include/linux/printk.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 8c81806c2e99..8f564c38f121 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -537,6 +537,8 @@ struct pi_entry {
>   * This macro expands to a printk with KERN_CONT loglevel. It should only be
>   * used when continuing a log message with no newline ('\n') enclosed. Otherwise
>   * it defaults back to KERN_DEFAULT loglevel.
> + *
> + * Use the dedicated pr_<level>_cont() macros instead.
>   */
>  #define pr_cont(fmt, ...) \
>  	printk(KERN_CONT fmt, ##__VA_ARGS__)
> @@ -701,6 +703,27 @@ do {									\
>  	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>  #endif
>  
> +/*
> + * Print a continuation message with level. In case the continuation is split
> + * from the main message it preserves the level.
> + */
> +
> +#define pr_emerg_cont(fmt, ...)					\
> +	printk(KERN_EMERG KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)

Aren't this rather backwards?
KERN_CONT KERN_<LEVEL> seems to make more sense to me.

> +#define pr_alert_cont(fmt, ...)					\
> +	printk(KERN_ALERT KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> +#define pr_crit_cont(fmt, ...)					\
> +	printk(KERN_CRIT KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> +#define pr_err_cont(fmt, ...)					\
> +	printk(KERN_ERR KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> +#define pr_warn_cont(fmt, ...)					\
> +	printk(KERN_WARN KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> +#define pr_notice_cont(fmt, ...)					\
> +	printk(KERN_NOTICE KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> +#define pr_info_cont(fmt, ...)					\
> +	printk(KERN_INFO KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> +/* no pr_debug_ratelimited, it doesn't make sense with CONFIG_DYNAMIC_DEBUG. */
> +
>  extern const struct file_operations kmsg_fops;
>  
>  enum {

