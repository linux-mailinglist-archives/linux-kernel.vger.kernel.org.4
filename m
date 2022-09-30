Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ADA5F0B76
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiI3MOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiI3MOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:14:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0101617B51F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:14:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2C7A61F8C5;
        Fri, 30 Sep 2022 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664540057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53wUTdjuzRYqaWE4NEtL2DGnKhrRcYzk1qX7TFvf/mQ=;
        b=d15neyrs0xsLFLyU9viRYmfbGtr2CP+9U4UhzQzbLDLXAqgsMAtbs07n6jhTtpOT28qVlG
        jfxVd9isX6A4JbnzJWJ9+Kp6DY1IWesda3pmzMYD/nJrnU4B4jp5w0XjHlGCOHUTm81G2w
        5FXcUy2pdvlakYC5qmXUYuuI/7KrV7I=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B0F172C161;
        Fri, 30 Sep 2022 12:14:16 +0000 (UTC)
Date:   Fri, 30 Sep 2022 14:14:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] printf: Emit "SUCCESS" if NULL is passed for %pe
Message-ID: <YzbdmJvcPiYAIalt@alley>
References: <20220930111050.1296018-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930111050.1296018-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-09-30 13:10:50, Uwe Kleine-König wrote:
> For code that emits a string representing a usual return value it's
> convenient to have a 0 result in a string representation of success
> instead of "00000000".

Does it really always mean success, please?

IMHO, if a function returns a pointer then typically only a valid
pointer means success. Error code means some reasonable explanation
of the failure. And NULL should never happen.

For example:

struct bla *find_bla(int key)
{
	struct bla *b;

	/* Try to get bla using the given key */
	...

	if (succeded)
		return b;

	/* Did not find bla for the given key */
	return -EINVAL;

}

It might be used:

int process_bla()
{
	struct bla *b;

	b = get_bla();
	if (IS_ERR(b))
		return PTR_ERR(b);

	/* do something with b */
	...
}

If get_bla() returns NULL then it means a super fault. It means
that get_bla() failed and did not know why.

IMHO, this patch might do more harm than good.

Best Regards,
Petr
