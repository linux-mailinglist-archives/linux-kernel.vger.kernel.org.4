Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39073A343
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjFVOk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjFVOkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:40:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839511FDD;
        Thu, 22 Jun 2023 07:40:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4992C67373; Thu, 22 Jun 2023 16:40:42 +0200 (CEST)
Date:   Thu, 22 Jun 2023 16:40:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 14/24] init: clear root_wait on all invalid root=
 strings
Message-ID: <20230622144042.GA21415@lst.de>
References: <20230523074535.249802-1-hch@lst.de> <20230523074535.249802-15-hch@lst.de> <8c1992bc-110a-4dad-8643-766c14bf6fd4@roeck-us.net> <20230622035149.GA4667@lst.de> <2205ef1e-9bb6-fb1e-9ca3-367c1afe12ac@roeck-us.net> <20230622060001.GA8351@lst.de> <8e6c8365-5c2b-2bad-bf3c-df2d65cc8afa@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e6c8365-5c2b-2bad-bf3c-df2d65cc8afa@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 06:54:41AM -0700, Guenter Roeck wrote:
> On 6/21/23 23:00, Christoph Hellwig wrote:
>> Hi Guenter,
>>
>> can you try this patch?
>>
>> diff --git a/block/early-lookup.c b/block/early-lookup.c
>> index a5be3c68ed079c..66e4514d671179 100644
>> --- a/block/early-lookup.c
>> +++ b/block/early-lookup.c
>> @@ -174,7 +174,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
>>   	while (p > s && isdigit(p[-1]))
>>   		p--;
>>   	if (p == s || !*p || *p == '0')
>> -		return -EINVAL;
>> +		return -ENODEV;
>>     	/* try disk name without <part number> */
>>   	part = simple_strtoul(p, NULL, 10);
>
> Not completely. Tests with root=/dev/sda still fail.
>
> "name" passed to devt_from_devname() is "sda".
>
>        for (p = s; *p; p++) {
>                 if (*p == '/')
>                         *p = '!';
>         }
>
> advances 'p' to the end of the string.
>
>         while (p > s && isdigit(p[-1]))
> 		p--;
>
> moves it back to point to the first digit (if there is one).
>
>         if (p == s || !*p || *p == '0')
> 		return -EINVAL;
>
> then fails because *p is 0. In other words, the function only accepts
> drive names with digits at the end (and the first digit must not be '0').
>
> I don't recall how I hit the other condition earlier. I have various
> "/dev/mmcblkX" in my tests, where X can be any number including 0.
> Maybe those fail randomly as well.
>
> Overall I am not sure though what an "invalid" devicename is supposed
> to be in this context. I have "sda", "sr0", "vda", "mtdblkX",
> "nvme0n1", "mmcblkX", and "hda". Why would any of those not be eligible
> for "rootwait" ?
>
> In practice, everything not ending with a digit, or ending with
> '0', fails the first test. Everything ending with a digit > 0
> fails the second test. But "humptydump3p4" passes all those tests.


Yeah.  I guess I should give up on the idea of error out in this
particular parser.  The idea sounded good, but I guess it doesn't
work.  So we'll probably want his fix:


diff --git a/block/early-lookup.c b/block/early-lookup.c
index a5be3c68ed079c..9e2d5a19de1b3b 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -174,7 +174,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 	while (p > s && isdigit(p[-1]))
 		p--;
 	if (p == s || !*p || *p == '0')
-		return -EINVAL;
+		return -ENODEV;
 
 	/* try disk name without <part number> */
 	part = simple_strtoul(p, NULL, 10);
@@ -185,7 +185,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 
 	/* try disk name without p<part number> */
 	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
-		return -EINVAL;
+		return -ENODEV;
 	p[-1] = '\0';
 	*devt = blk_lookup_devt(s, part);
 	if (*devt)
