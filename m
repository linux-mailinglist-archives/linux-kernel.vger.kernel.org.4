Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2219C5EF9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbiI2QF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiI2QFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:05:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43274A5720
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D36A061A09
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5941C433D6;
        Thu, 29 Sep 2022 16:05:19 +0000 (UTC)
Date:   Thu, 29 Sep 2022 12:06:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] test_printf: Refactor fwnode_pointer() to make
 it more readable
Message-ID: <20220929120632.2bc01e9f@gandalf.local.home>
In-Reply-To: <20220824170542.18263-1-andriy.shevchenko@linux.intel.com>
References: <20220824170542.18263-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 20:05:42 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Converting fwnode_pointer() to use better swnode API allows to
> make code more readable.
> 
> While at it, rename full_name to full_name_third to show exact
> relation in the hierarchy.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/test_printf.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index fe13de1bed5f..6f7f179dd8f4 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -704,31 +704,29 @@ flags(void)
>  
>  static void __init fwnode_pointer(void)
>  {
> -	const struct software_node softnodes[] = {
> -		{ .name = "first", },
> -		{ .name = "second", .parent = &softnodes[0], },
> -		{ .name = "third", .parent = &softnodes[1], },
> -		{ NULL /* Guardian */ }
> -	};
> -	const char * const full_name = "first/second/third";
> +	const struct software_node first = { .name = "first" };
> +	const struct software_node second = { .name = "second", .parent = &first };
> +	const struct software_node third = { .name = "third", .parent = &second };

I personally do not find the above more readable, but honestly, I'm not
attached to this code at all.

> +	const struct software_node *group[] = { &first, &second, &third, NULL };

Could this just be:

	const struct software_node *group[] = {
		&softnodes[0], &softnodes[1], &softnodes[2], NULL };


>  	const char * const full_name_second = "first/second";
> +	const char * const full_name_third = "first/second/third";
>  	const char * const second_name = "second";
>  	const char * const third_name = "third";
>  	int rval;
>  
> -	rval = software_node_register_nodes(softnodes);
> +	rval = software_node_register_node_group(group);
>  	if (rval) {
>  		pr_warn("cannot register softnodes; rval %d\n", rval);
>  		return;
>  	}
>  
> -	test(full_name_second, "%pfw", software_node_fwnode(&softnodes[1]));
> -	test(full_name, "%pfw", software_node_fwnode(&softnodes[2]));
> -	test(full_name, "%pfwf", software_node_fwnode(&softnodes[2]));
> -	test(second_name, "%pfwP", software_node_fwnode(&softnodes[1]));
> -	test(third_name, "%pfwP", software_node_fwnode(&softnodes[2]));
> +	test(full_name_second, "%pfw", software_node_fwnode(&second));
> +	test(full_name_third, "%pfw", software_node_fwnode(&third));
> +	test(full_name_third, "%pfwf", software_node_fwnode(&third));
> +	test(second_name, "%pfwP", software_node_fwnode(&second));
> +	test(third_name, "%pfwP", software_node_fwnode(&third));

Then the above doesn't need to change.

But again, I'm not maintaining this code, so I'm not attached. Just adding
my $0.02 to this (as I'm triaging my inbox and found this email).

-- Steve


>  
> -	software_node_unregister_nodes(softnodes);
> +	software_node_unregister_node_group(group);
>  }
>  
>  static void __init fourcc_pointer(void)

