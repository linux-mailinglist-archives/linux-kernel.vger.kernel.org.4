Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F6B658743
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 23:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiL1WRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 17:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiL1WRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 17:17:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E3013D16
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 14:17:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CCD061640
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 22:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB142C433EF;
        Wed, 28 Dec 2022 22:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672265823;
        bh=TIUBssIqTL0wXOJJ79ujlgOXLd564sfw9ogVxe9yqhE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uJHEgKDZT6Vvn8sswHYsfVvULQSaTlrCcGRC7Wd+0Ov3vn7PIGC5+LjgUuJTZu1m+
         UhtG0l6Q/qSYwueLsAtvIZdUPEEYNfZWed51W9Rqp+b5Vtb9kuG6sB8jPkBCAsDQo6
         Q7NrsMvuR3FfT1yoQecwdmN5j8PBrSW1NJRctXaM=
Date:   Wed, 28 Dec 2022 14:17:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kuleshovmail@gmail.com>, <aneesh.kumar@linux.ibm.com>,
        <clameter@sgi.com>
Subject: Re: [PATCH 1/4] mm/mlock: return EINVAL for illegal user memory
 range in mlock
Message-Id: <20221228141701.c64add46c4b09aa17f605baf@linux-foundation.org>
In-Reply-To: <20221205034108.3365182-2-mawupeng1@huawei.com>
References: <20221205034108.3365182-1-mawupeng1@huawei.com>
        <20221205034108.3365182-2-mawupeng1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 11:41:05 +0800 Wupeng Ma <mawupeng1@huawei.com> wrote:

> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
> The return value of mlock is zero. But nothing will be locked since the
> len in do_mlock overflows to zero due to the following code in mlock:
> 
>   len = PAGE_ALIGN(len + (offset_in_page(start)));
> 
> The same problem happens in munlock.
> 
> Since TASK_SIZE is the maximum user space address. The start or len of
> mlock shouldn't be bigger than this. Function access_ok can be used to
> check this issue, so return -EINVAL if bigger.

What happens if userspace uses a value somewhat smaller than ULONG_MAX?

	mlock(addr, ULONG_MAX - 1000000);

?

Because if the above works successfully and if it no longer works
successfully with this patchset then that could be a
backward-compatibility problem.

