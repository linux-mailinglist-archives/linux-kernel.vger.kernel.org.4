Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993546639D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjAJHUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjAJHT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:19:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149A1A066;
        Mon,  9 Jan 2023 23:19:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75941B81126;
        Tue, 10 Jan 2023 07:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC8EC433F0;
        Tue, 10 Jan 2023 07:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673335195;
        bh=Vq616gbwymfsGxKmfDRsySN7+m4LEuQS7EzTcz4ZHkI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a/VEo/lCYP+p45d8/rYEc0sbVo2alyJDKrnmcKhyH1AeAYvPU3ycxgcVgKX1RunPO
         4t9UxdujD0tZzGUYvZTOzwyf1plZh3R5GV25JMhetGZXVvU24CyahRcMay3YnNt0m7
         yEfkGP2hlcyGEAYUAeIUSG6B/5rMzwuiBuDRkmiK3Qxpjx/nBghqpBMtjXdqH3dQUo
         T/NyFEnB1rn1LmRxSeQDZf3EMLc1P0mOddpWipv1iR2BQJcvyMqTr3TYz/iC5kVdRT
         lfbYNKasrzi58el/IUVluM1ATnZFtVbNHa5j6S6Tz22sK/IlCP8dPpkqKSchAYGX8i
         g9kTLqUCDhdaA==
Message-ID: <b5e0bd90-ff29-d301-30ca-2f12028109ce@kernel.org>
Date:   Mon, 9 Jan 2023 23:19:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] bit_spinlock: Include <asm/processor.h>
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Dan Carpenter <error27@gmail.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <8b81101d59a31f4927016c17e49be96754a23380.1673204461.git.christophe.jaillet@wanadoo.fr>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <8b81101d59a31f4927016c17e49be96754a23380.1673204461.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/8/23 11:04, Christophe JAILLET wrote:
> In an attempt to simplify some includes in <include/dcache.h>, it
> appeared, when compiling fs/ecryptfs/dentry.c, that <linux/bit_spinlock.h>
> was relying on other includes to get the definition of cpu_relax().
> (see [1])
>
> It broke on arc.

It its just ARC that broke, maybe we can do something there ?

> Include <asm/processor.h> in <linux/bit_spinlock.h> to fix the issue.
> This will help remove some un-needed includes from <include/dcache.h>.
>
> [1]: https://lore.kernel.org/all/202301082130.LXMj5qkD-lkp@intel.com/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not sure who to send this to.
> get_maintainer.pl is of no help, and the file is untouched from a too long
> time.
>
> Greg? Dan? Any pointer?
> ---
>   include/linux/bit_spinlock.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
> index bbc4730a6505..d0fd2a7afca2 100644
> --- a/include/linux/bit_spinlock.h
> +++ b/include/linux/bit_spinlock.h
> @@ -2,6 +2,7 @@
>   #ifndef __LINUX_BIT_SPINLOCK_H
>   #define __LINUX_BIT_SPINLOCK_H
>   
> +#include <asm/processor.h>
>   #include <linux/kernel.h>
>   #include <linux/preempt.h>
>   #include <linux/atomic.h>

