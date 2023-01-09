Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE90066343F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjAIWqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbjAIWqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:46:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D2B1BE91;
        Mon,  9 Jan 2023 14:46:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB91AB81085;
        Mon,  9 Jan 2023 22:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520AAC433EF;
        Mon,  9 Jan 2023 22:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673304368;
        bh=Smpr3DrhasTIUOdQUCkLW1n6OMxtHjQcAGkhZhSSagU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NrWnulaBpJswTJNHy51afCrsavlOnbtuYkpyeTJoDlBMYqgN/PeSkGKExpci/qM4d
         WbVIfcvQBMqAan8/zukuIIu+2yZRT6exWCBTwZTobsdkdh/s1Hh1WFo5VfhgHYzcQG
         3eOWgRys64FEGm9Cl9Ky5N+bwLQTBYBZ7fNjiufo=
Date:   Mon, 9 Jan 2023 14:46:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bit_spinlock: Include <asm/processor.h>
Message-Id: <20230109144607.02edd319f9b5e25ee774f9a5@linux-foundation.org>
In-Reply-To: <8b81101d59a31f4927016c17e49be96754a23380.1673204461.git.christophe.jaillet@wanadoo.fr>
References: <8b81101d59a31f4927016c17e49be96754a23380.1673204461.git.christophe.jaillet@wanadoo.fr>
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

On Sun,  8 Jan 2023 20:04:44 +0100 Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> In an attempt to simplify some includes in <include/dcache.h>, it
> appeared, when compiling fs/ecryptfs/dentry.c, that <linux/bit_spinlock.h>
> was relying on other includes to get the definition of cpu_relax().
> (see [1])
> 
> It broke on arc.
> 
> Include <asm/processor.h> in <linux/bit_spinlock.h> to fix the issue.
> This will help remove some un-needed includes from <include/dcache.h>.
> 
> [1]: https://lore.kernel.org/all/202301082130.LXMj5qkD-lkp@intel.com/
> 
> ...
>
> --- a/include/linux/bit_spinlock.h
> +++ b/include/linux/bit_spinlock.h
> @@ -2,6 +2,7 @@
>  #ifndef __LINUX_BIT_SPINLOCK_H
>  #define __LINUX_BIT_SPINLOCK_H
>  
> +#include <asm/processor.h>
>  #include <linux/kernel.h>
>  #include <linux/preempt.h>
>  #include <linux/atomic.h>

linux/processor.h would be preferable, rather than diving straight into asm/?
