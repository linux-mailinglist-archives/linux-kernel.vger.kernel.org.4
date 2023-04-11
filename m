Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F8A6DE726
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDKWVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDKWVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:21:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5EA3C2F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:21:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D03C260C8C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C70C433D2;
        Tue, 11 Apr 2023 22:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681251680;
        bh=sMbNE9Dg4D8/7gjAwa4mYtt+c67BjODaruWg+Qrl6Bg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rl45bOsDI2Ei4ofLlQa6y6H6/v8eq/7oYXtrJ+U2lrPVslNXNpNY8a1EA5xWlazWF
         6cHIkOI49/N6WroVn8tM6Y3jmZ9i43R9tjbpZzLj0z0AYc8FX1rIdZksbh1Tq0xj43
         Ux4Gx/znqziak5NZLuoHRRQht4QXYEEvi2Lsl3wY=
Date:   Tue, 11 Apr 2023 15:21:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out COUNT_ARGS() and
 CONCATENATE()
Message-Id: <20230411152119.c9bb83a8566e37f6d8dbc590@linux-foundation.org>
In-Reply-To: <20230411102454.85898-1-andriy.shevchenko@linux.intel.com>
References: <20230411102454.85898-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 13:24:54 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> kernel.h is being used as a dump for all kinds of stuff for a long time.
> The COUNT_ARGS() and CONCATENATE() macros may be used in some places
> without need of the full kernel.h dependency train with it.
> 
> Here is the attempt on cleaning it up by splitting out these macros().
> 
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -13,6 +13,7 @@
>  
>  #include <linux/stdarg.h>
>  #include <linux/align.h>
> +#include <linux/args.h>

A more energetic patch would have included args.h into each file which
calls COUNT_ARGS() and CONCATENATE(), and not included args.h into
kernel.h.  And that appears to be very easy - only bpf uses these things?

In fact these macros are so weird and ugly I'd be inclined to move them
into some bpf header so we don't have to see them again.  No
args.h, which might avoid encouraging others to use them.

