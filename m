Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675B563D87F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiK3OvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiK3OvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:51:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDC15F847;
        Wed, 30 Nov 2022 06:51:10 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2A46F21AFE;
        Wed, 30 Nov 2022 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669819869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rX/Pr9wWFFNUCxE3ZZA40hfNPZyjpFt1Jbcp+gMMlm8=;
        b=uJRbZ6ZlLTmMdVQmyMP/qwCjhxRHygVMkVs3U6/zHA4hx11XeXPM+L5JCEnHP8hDifMV0N
        4H66co2gtWBny+sC1FgFYR70zz+9g0dlMHpbWevNEd6uJ1W62uOsVwAO+4uRoH+qxOw4py
        +VG18LWnaJIuL4euieB/wVuMgeelLvM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B1DFC2C14F;
        Wed, 30 Nov 2022 14:51:08 +0000 (UTC)
Date:   Wed, 30 Nov 2022 15:51:08 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Perches <joe@perches.com>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 2/3] checkpatch: handle new pr_<level>_cont macros
Message-ID: <Y4dt3IMYKYnufHg5@alley>
References: <20221125190948.2062-1-linux@weissschuh.net>
 <20221125190948.2062-3-linux@weissschuh.net>
 <39f687f7c71b162eb8caefbec939fa2ad74fcdfc.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39f687f7c71b162eb8caefbec939fa2ad74fcdfc.camel@perches.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-11-25 12:17:05, Joe Perches wrote:
> On Fri, 2022-11-25 at 20:09 +0100, Thomas Weißschuh wrote:
> > These new macros from include/linux/printk.h replace the usage of plain
> > pr_cont().
> []
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -590,7 +590,7 @@ our $zero_initializer = qr{(?:(?:0[xX])?0+$Int_type?|NULL|false)\b};
> > +# check for logging continuations without explicit level
> > +		if ($line =~ /\bpr_cont\s*\(/) {
> > +			WARN("LOGGING_CONTINUATION_WITHOUT_LEVEL",
> > +			     "Avoid logging continuation without level\n" . $herecurr);
> > +		}
> > +
> 
> Not so sure about this one.
> 
> I think relatively few situations are going to require interleaving avoidance.

Well, the problem is generic and any pr_cont() is affected except for
NMI context on single CPU system.

I though about a generic solution. We could store the last used printk
log level per-process and per-CPU context. But it does not solve
the situation when an unrelated printk() is printed by a nested
function.

It is exactly the case with try_to_freeze_tasks() in the 3rd patch.
Simplified code:

int freeze_processes(void)
{
	pr_info("Freezing user space processes ... ");
	try_to_freeze_tasks(true);
	pr_info_cont("done.");
}

, where

static int try_to_freeze_tasks(bool user_only)
{
[...]
	if (todo) {
		pr_err("Freezing of tasks %s after %d.%03d seconds "
[...]
}


I would personally add this check into checkpatch.pl. It might help
to make people aware about that pr_cont() is just the best effort.

Best Regards,
Petr
