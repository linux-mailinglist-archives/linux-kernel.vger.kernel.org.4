Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5537639279
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKZAC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKZAC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:02:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB5F2E9D9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 16:02:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD74EB82AFF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 00:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E24C433D6;
        Sat, 26 Nov 2022 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669420943;
        bh=B7UA8OkfPUbNBuBgsROjEIHZpFIoqAXKgCitThTapyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S4c9l8xoctrzkrmAEIjXGCnNjk+yM7nlDPMPKz7KgKQMFy/TyRn2SHcfl3TjS0qKS
         ABMPXy2mqU2YT6cb3yDBG4W/R10a9pZCxZlrzQEEqWD31HV/ZJvBZFqxbt9eFaB7bR
         GaExCwShlOTpQV5i3OFrGAcZp9eo6j0pnOpqBiVk=
Date:   Fri, 25 Nov 2022 16:02:22 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "'Joe Perches'" <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/1] Slightly relax the type checking done by min() and
 max().
Message-Id: <20221125160222.9d69bb5d54a0304e0f476f67@linux-foundation.org>
In-Reply-To: <03db8d2f34fa4bffada8b34ee87b090a@AcuMS.aculab.com>
References: <cfc6c0f0fd4c4724890be8a8397c2cbe@AcuMS.aculab.com>
        <Y4DdQIMiFGk7YYcJ@smile.fi.intel.com>
        <7e594ad64e444d448c747688b8f28249@AcuMS.aculab.com>
        <Y4DmFfj6G6+niZ+t@smile.fi.intel.com>
        <0b38ced96519407e95962aef2771bbc6@AcuMS.aculab.com>
        <Y4D/0dqOODs4ZHQM@smile.fi.intel.com>
        <03db8d2f34fa4bffada8b34ee87b090a@AcuMS.aculab.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 19:47:14 +0000 David Laight <David.Laight@ACULAB.COM> wrote:

> > Blindly relaxing the rules is not an option in my opinion.
> 
> The point is I'm not really relaxing the rules.
> If anything I'm actually tightening them by allowing min() to
> be used in more cases - so letting the buggy min_t() casts be
> removed at some point in the future.

That sounds very virtuous.

It would be helpful to see a few "convert min_t to min" patches
to see this proposal in action.
