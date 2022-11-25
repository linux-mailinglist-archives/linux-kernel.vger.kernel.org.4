Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A5963908C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 21:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiKYURQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Nov 2022 15:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYURO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 15:17:14 -0500
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8454B1C;
        Fri, 25 Nov 2022 12:17:12 -0800 (PST)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id A9A43140D5C;
        Fri, 25 Nov 2022 20:17:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id B5D5220026;
        Fri, 25 Nov 2022 20:16:38 +0000 (UTC)
Message-ID: <39f687f7c71b162eb8caefbec939fa2ad74fcdfc.camel@perches.com>
Subject: Re: [PATCH v2 2/3] checkpatch: handle new pr_<level>_cont macros
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
Date:   Fri, 25 Nov 2022 12:17:05 -0800
In-Reply-To: <20221125190948.2062-3-linux@weissschuh.net>
References: <20221125190948.2062-1-linux@weissschuh.net>
         <20221125190948.2062-3-linux@weissschuh.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: jfghn9hynfghytwr1ikjsr8zhdjio9c7
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B5D5220026
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Iblfm+D6CDYgMLfGST2SFn8mRmzUFMYw=
X-HE-Tag: 1669407398-853785
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-11-25 at 20:09 +0100, Thomas Weißschuh wrote:
> These new macros from include/linux/printk.h replace the usage of plain
> pr_cont().
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1e5e66ae5a52..fb1747639c9c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -590,7 +590,7 @@ our $zero_initializer = qr{(?:(?:0[xX])?0+$Int_type?|NULL|false)\b};
>  
>  our $logFunctions = qr{(?x:
>  	printk(?:_ratelimited|_once|_deferred_once|_deferred|)|
> -	(?:[a-z0-9]+_){1,2}(?:printk|emerg|alert|crit|err|warning|warn|notice|info|debug|dbg|vdbg|devel|cont|WARN)(?:_ratelimited|_once|)|
> +	(?:[a-z0-9]+_){1,2}(?:printk|emerg|alert|crit|err|warning|warn|notice|info|debug|dbg|vdbg|devel|cont|WARN)(?:_ratelimited|_once|_cont|)|

OK

>  	TP_printk|
>  	WARN(?:_RATELIMIT|_ONCE|)|
>  	panic|
> @@ -6374,11 +6374,17 @@ sub process {
>  		}
>  
>  # check for logging continuations
> -		if ($line =~ /\bprintk\s*\(\s*KERN_CONT\b|\bpr_cont\s*\(/) {
> +		if ($line =~ /\bprintk\s*\(\s*KERN_CONT\b|\bpr_([a-z]+_)?cont\s*\(/) {
>  			WARN("LOGGING_CONTINUATION",
>  			     "Avoid logging continuation uses where feasible\n" . $herecurr);
>  		}

OK

> +# check for logging continuations without explicit level
> +		if ($line =~ /\bpr_cont\s*\(/) {
> +			WARN("LOGGING_CONTINUATION_WITHOUT_LEVEL",
> +			     "Avoid logging continuation without level\n" . $herecurr);
> +		}
> +

Not so sure about this one.

I think relatively few situations are going to require interleaving avoidance.

>  # check for unnecessary use of %h[xudi] and %hh[xudi] in logging functions
>  		if (defined $stat &&
>  		    $line =~ /\b$logFunctions\s*\(/ &&

