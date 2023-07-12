Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89114750CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjGLPjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjGLPjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:39:52 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F291BB;
        Wed, 12 Jul 2023 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689176391;
  x=1720712391;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=6YY5K6Pv6QqKIIYQnBoSV5Kj79iqnwblWu7VX/RxeuA=;
  b=lg+bEeOl87Tju5BnH1hQxTURXL31LjrUMXE95iZD95QrBob+doYrKwK/
   mY5rnWKU/tn4Qn3bkJo9qvZFovQHCGiQenJAFQd3V4xDN4AGFL+ix4Wni
   Z4j1ILH+sRM9H0u4vZas1cizi+yNKMTq099MNj0frDJc8NkRSFM/9Oq0B
   RM0TvKYbTk7sAIC7QCaH//MiiS34kgWF+WTj3qO4yxK1lCs9yfWGNQYFY
   IRZfadoP0eO5oljD5rKKzqA2CjJpzOJW7+mp4FVNLsd++Qdk3puh10tBD
   ZT5jBsMb97Gb1LIpauYNcl612yvRpYeQG1qVHFGeHeOEK/sFG9IjnRuSD
   w==;
References: <cover.1686926857.git.waqarh@axis.com>
 <d2d8f34c09a2ba0504eaba4f451412de41db2f37.1686926857.git.waqarh@axis.com>
 <20230617143508.28309834@jic23-huawei> <pndo7lb1mes.fsf@axis.com>
 <20230625120604.3ecc54bf@jic23-huawei>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH 2/2] iio: Add driver for Murata IRS-D200
Date:   Wed, 12 Jul 2023 17:33:09 +0200
In-Reply-To: <20230625120604.3ecc54bf@jic23-huawei>
Message-ID: <pndcz0xkuka.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 12:06 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

[...]

>> >> +		dev_err(data->dev, "Could not write hp filter frequency (%d)\n",
>> >> +			ret);
>> >> +		return ret;  
>> >
>> > drop this return ret out of the if block here.
>> >
>> > In general being able to ignore possibility of ret > 0 simplifies handling.  
>> 
>> I try to be consistent and it also "helps" the next person potentially
>> adding code after the `if`-statement and forgetting about adding
>> `return`. We can drop the `return here, but then we should do the same
>> in other places with a check just before the last `return` (like
>> `irsd200_write_timer()`, `irsd200_read_nr_count()`,
>> `irsd200_write_nr_count()` and many more), right?
>
> I don't feel particulartly strongly about this, but there are scripts
> that get used to scan for this pattern to simplify the code.
>
> Sure on the other cases. I don't tend to try and label all cases of things
> pointed out, just pick on one and rely on the patch author to generalise.

I started to remove the returns but then realized that it got a little
messy. For example, in some cases we can't drop the return (side effects
after the return etc.). 

Since you didn't have any strong opinions on this, I kept them in v2.
Hope that's fine!
