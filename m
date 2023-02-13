Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A71F694F62
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjBMSbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBMSbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:31:41 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9937134
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=JEB0EJq2leh0gUBfjQUrqieo+tocTy4r9EskxVl3TJk=; b=v/WrSIiHkt8HFZK/Uitv7d0L8c
        A6MxJ600yRPTT+PIZ9BuPayUCfNgdDd/U+IiIgpvdt+01AL7uPEBptf2d2INzyZpqNuGgIEMKxj+G
        qPkLwMbZ2YaEm7M8PDdKntzcz1yFlgsJCytgn9yIt3rPe8ss+7uCi5ZckspOr+vsVSTqLzPzafazk
        GQXuqXXWH7OmZ0iaM0eJ38jaFAzOavQhQpE8QhOSXHLnqm6kCcdsq5U77J4tsybXhKy4ZdAZLKKMB
        OcITCkUeay+VX4s87/ro/POcBwftDDii0HGaRejY8+wB4xNEmBkKoeMIIByQWqk677MSf/FJ0G62r
        GyWsqVypjqaCw4qy6W+UZAfGlum6fMHk1EEUP90pRKm4HrgNWuinAYnJMXJ6pUr07tZl0xzh9Uo66
        4TIor1+8H++ssQ7Ff2MN4NQrfzoFx7KXF5gBuDVnc1kQQf58ISViI4uttcKJaKy/Tikfv3Wx9momB
        XYBxvxJuHl601yvXKIHpu/F2MadZOVjf5ndgF1s0YCD+IuBzmXamxb9u6jw1DHmMCpvTwhudjvQ9t
        zH+0j5ZLfostuOMwCjekz1KT0qVWq9c8/2k9QOXKc1ykV+OOvVhVoWVBK7w4L+ZDp5yXcMRCgdVlY
        tSAIIH+623oEbW2y/qIeh8uC7e0N2ambwTxvVvmds=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 0/5] Take 3 at async RPCs and no longer looping forever on signals
Date:   Mon, 13 Feb 2023 19:26:54 +0100
Message-ID: <4256068.OCvV93pMlr@silver>
In-Reply-To: <20230211075023.137253-1-asmadeus@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, February 11, 2023 8:50:18 AM CET Dominique Martinet wrote:
> I've been working on async RPCs for a while and never had time to debug
> the last issues this had, but by limiting the async clunks to failures
> the impact is drastically smaller and I've not been able to reproduce
> any more bug so far.
> 
> This will require some more testing and I'm tempted to say this is not
> worth rushing this into the merge window next week-ish; the new problem
> Jens reported with task_work isn't really new and I'd rather get this
> right than rush new bugs in given the sour experience I've had with this
> patch series... Hopefully it'll get in this time.
> With that in mind I plan to take the patches in to my -next branch after
> the merge window, so this has time to get reviewed first.
> 
> I'd like to measure impact on performance as well, but really spent way
> more time on this than I already have, so that'll have to wait a bit.

I have not observed performance degradation, nor any (new) errors. So for
this entire series:

Tested-by: Christian Schoenebeck <linux_oss@crudebyte.com>



