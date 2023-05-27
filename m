Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683C7713216
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjE0DMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjE0DMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFBEE1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B94AB60E9C
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 03:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E27C433EF;
        Sat, 27 May 2023 03:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685157124;
        bh=LJQ/LuDu59EMiwcWT0lcrMyGH/81VTyAMGBUL/u1fKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t3dIWnQNEST7MNFSz4icE8NVqDhbPpHnw8eb4RXLNyS9UTdk7URq350RkrKZt+tXp
         woikm0rkQ0G1YHfk/zPYUNd68o5tAoJttofuqbjod8mcLvwxmoH0wUUmlg/jFe2bR9
         0ltAzLHQRdpEZf1DYtdB1RUp/xsvLwj/SGx2+GWt3EN33Tz0X5zluYdcinHH4MI8M9
         FN47eZfNVpSSLZW3hdESDHnGb7SIoU7Hstiyb2JHk+ohE6m0g5lgTlpVItUEwOIpex
         kYXmc2AdjUVacPlwo4POLe0UPLlg/T2hngINzf0e65/lP3ec+0gH7QMJdFyEPI/xEv
         Lf5AYVSqtOc0w==
Date:   Fri, 26 May 2023 20:12:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tom Herbert <tom@herbertland.com>,
        Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH net-next 3/4] kcm: Support MSG_SPLICE_PAGES
Message-ID: <20230526201202.1cd35fe9@kernel.org>
In-Reply-To: <20230524144923.3623536-4-dhowells@redhat.com>
References: <20230524144923.3623536-1-dhowells@redhat.com>
        <20230524144923.3623536-4-dhowells@redhat.com>
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

On Wed, 24 May 2023 15:49:22 +0100 David Howells wrote:
> +			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
> +						   sk->sk_allocation);
> +			if (err < 0) {
> +				if (err == -EMSGSIZE)
> +					goto wait_for_memory;
> +				goto out_error;
> +			}
>  

should there be a:

		copy = err;
or:
		copy -= msg_data_left(msg);

or some such here? Can we safely assume that skb_splice_from_iter() will
copy all or nothing? 

> -		err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
> -					       pfrag->page,
> -					       pfrag->offset,
> -					       copy);
> -		if (err)
> -			goto out_error;
> +			skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
