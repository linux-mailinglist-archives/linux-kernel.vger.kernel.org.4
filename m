Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DBF6390C7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 21:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiKYUmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 15:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKYUmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 15:42:10 -0500
X-Greylist: delayed 5516 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Nov 2022 12:42:09 PST
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B417640470;
        Fri, 25 Nov 2022 12:42:09 -0800 (PST)
Date:   Fri, 25 Nov 2022 21:41:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669408927;
        bh=xOpKZV4KGwVSKzHLFLhNwRNb9SsL9WyN7q5smyNEhc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyUFxGm82aNHvTIOKlAqj9WavGvQ2+8kUgTfMf+9VSFYTmfhzbvZ40R/b5OTFQ/8x
         Cg19gu/hGT2AfMH8Hm4YIpy+4scnBrcuMggrK6QdWsZr6DWDPApccj0xTlZnK8i5OR
         3JePZzVhF7xW4kk0gXQxA0bIGNCJa900RaIanCgM=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 3/3] power: process: use explicit levels for printk
 continuations
Message-ID: <ad4e4785-c6f8-4ae1-a281-ff9dc5720db2@t-8ch.de>
References: <20221125190948.2062-1-linux@weissschuh.net>
 <20221125190948.2062-4-linux@weissschuh.net>
 <f4631f7bf0e1fe7b018ea24cb89aede7829581d2.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4631f7bf0e1fe7b018ea24cb89aede7829581d2.camel@perches.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-25 11:53-0800, Joe Perches wrote:
> On Fri, 2022-11-25 at 20:09 +0100, Thomas Weißschuh wrote:
>> Many of the printk messages emitted during suspend and resume are
>> emitted in fragments using pr_cont()/KERN_CONT.
>> 
>> As during suspend and resume a lot of operations are happing in the
>> kernel the chances are high that the fragments are interspersed with
>> unrelated messages.
>> 
>> In this case if no explicit level is specified for the fragments the
>> standard level is applied, which by default is KERN_WARNING.
>> 
>> If the user is only observing KERN_WARNING and *not* KERN_INFO messages
>> they will see incomplete message fragments.
>> 
>> By specifing the correct printk level also with the continuations this
>> mismatch can be avoided.
>> Also it reduces the amount of false-positive KERN_WARNING messages.
>> 
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>>  kernel/power/process.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>> 
>> diff --git a/kernel/power/process.c b/kernel/power/process.c
> []
>> @@ -82,7 +82,7 @@ static int try_to_freeze_tasks(bool user_only)
>>  	elapsed_msecs = ktime_to_ms(elapsed);
>>  
>>  	if (todo) {
>> -		pr_cont("\n");
>> +		pr_info_cont("\n");
> 
> I think this isn't needed because of the immediately following pr_err.

The pr_cont() itself or the conversion to pr_info_cont() is not needed?

Personally I would prefer to keep the patch as is.

If only the conversion is not needed for consistency with the rest of the file.
If the pr_cont() in general is not needed it should be changed in a dedicated
patch (by somebody who knows this code better).

>>  		pr_err("Freezing of tasks %s after %d.%03d seconds "
>>  		       "(%d tasks refusing to freeze, wq_busy=%d):\n",
>>  		       wakeup ? "aborted" : "failed",
> 
