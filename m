Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E480A74B9CD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 01:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGGXKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 19:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGGXKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 19:10:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D9E1FEC;
        Fri,  7 Jul 2023 16:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E8F861ABC;
        Fri,  7 Jul 2023 23:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D18C433C8;
        Fri,  7 Jul 2023 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688771451;
        bh=epNAr2DDyGPShAjRJk+xhNsNY5DucIhhIQhO0oT11n4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YOzvootFxD46KcjzgYrtI2oxMbaSldAb75HMTQdUCLpDzul5OTrFWcH1CGmcfMwBZ
         pbZeyIc4tkoY4udUKoiIop3n+IDcu23uzomggPH8iypEASs8GGNDc49LwAQcqpkKM8
         JtUUXhU7QsMuvPokTSfZC3iegHb/9l2EAAml232xt1rZuqHg6E1LppiKm3ZrWivA3m
         6hIHpF1F9sux+gOVX8BlTagqYkOUPl4ZLwoKiy583hM6eu4M+VsVt9Cp49f9D4Z1m2
         oVXmTvzq6qG7C6ui8Iih9aWdTpmemfvTrrq6iJBx/vGJsQp1ts+F2ZpeIaGxrD2GSj
         YOviVzQzXjLFg==
Date:   Fri, 7 Jul 2023 16:10:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, tj@kernel.org, stephen@networkplumber.org,
        Dave Jones <davej@codemonkey.org.uk>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] netconsole: Append kernel version to message
Message-ID: <20230707161050.61ec46a8@kernel.org>
In-Reply-To: <20230707132911.2033870-1-leitao@debian.org>
References: <20230707132911.2033870-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jul 2023 06:29:11 -0700 Breno Leitao wrote:
> Create a new netconsole runtime option that prepends the kernel version in
> the netconsole message. This is useful to map kernel messages to kernel
> version in a simple way, i.e., without checking somewhere which kernel
> version the host that sent the message is using.
> 
> If this option is selected, then the "<release>," is prepended before the
> netconsole message. This is an example of a netconsole output, with
> release feature enabled:
> 
> 	6.4.0-01762-ga1ba2ffe946e;12,426,112883998,-;this is a test
> 
> Calvin Owens send a RFC about this problem in 2016[1], but his
> approach was a bit more intrusive, changing the printk subsystem. This
> approach is lighter, and just append the information in the last mile,
> just before netconsole push the message to netpoll.
> 
> [1] Link: https://lore.kernel.org/all/51047c0f6e86abcb9ee13f60653b6946f8fcfc99.1463172791.git.calvinowens@fb.com/
> 
> Cc: Dave Jones <davej@codemonkey.org.uk>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Looks good! net-next is closed for the duration of the merge window 
so you'll need to repost next week, and please put [PATCH net-next v3]
as the subject prefix while at it.

> @@ -332,6 +350,11 @@ static ssize_t enabled_store(struct config_item *item,
>  	}
>  
>  	if (enabled) {	/* true */
> +		if (nt->release && !nt->extended) {
> +			pr_err("release feature requires extended log message\n");
> +			goto out_unlock;
> +		}

This is the only bit that gave me pause - when parsing the command line
you ignore release if extended is not set (with an error/warning).
Does it make sense to be consistent and do the same thing here? 
Or enabling at runtime is fundamentally different?
