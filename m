Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3630273BD4F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjFWRAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjFWRAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:00:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA7A91;
        Fri, 23 Jun 2023 10:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34DE061A8A;
        Fri, 23 Jun 2023 17:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033ECC433C9;
        Fri, 23 Jun 2023 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687539641;
        bh=8NvdvMOZhkf3ZWHCAYhr6IS/S3CpGzOG5wCKstBXM/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h6/0i8b5U6xV3rDgMIBxRMocLpmNGFZY618h9D1Yg3zKzltu1gljLOo2TTiI43Cvp
         N8emwr4aIVkqWlvGoDzPntH7XpThaon1gAVIyfSyQYW+hQnAzM2vBCTiuF+u/vBo7R
         /wZFoJixy4+SS9Ns7Whew+fmlegNGLtSprWupskJDm9BDDW71ijdzXhCUJ/cOh0BuN
         pAxFt8CgIOBjSdeUegTBRdu6N2sA/iF4ahxUmwJ6BR8s7SQAAgTXBWJxYx2Lr/4j7D
         8qpPHfWStK1yOUwrtYFucxtWK+BNf3L4N4UydRvXKXSFbiQoQg8TOnI8t637yOZcAu
         Wwf40LbpxIDDg==
Date:   Fri, 23 Jun 2023 10:00:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/15] ceph: Use sendmsg(MSG_SPLICE_PAGES)
 rather than sendpage
Message-ID: <20230623100040.4ebbeeb2@kernel.org>
In-Reply-To: <20230623114425.2150536-4-dhowells@redhat.com>
References: <20230623114425.2150536-1-dhowells@redhat.com>
        <20230623114425.2150536-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 12:44:13 +0100 David Howells wrote:
> @@ -494,9 +466,12 @@ static int write_partial_message_data(struct ceph_connection *con)
>  
>  		page = ceph_msg_data_next(cursor, &page_offset, &length);
>  		if (length == cursor->total_resid)
> -			more = MSG_MORE;
> -		ret = ceph_tcp_sendpage(con->sock, page, page_offset, length,
> -					more);
> +			msghdr.msg_flags |= MSG_MORE;

Should the condition also be flipped here, like you did below?
(can be a follow up if so)

> @@ -534,9 +512,11 @@ static int write_partial_skip(struct ceph_connection *con)
>  		size_t size = min(con->v1.out_skip, (int)PAGE_SIZE);
>  
>  		if (size == con->v1.out_skip)
> -			more = MSG_MORE;
> -		ret = ceph_tcp_sendpage(con->sock, ceph_zero_page, 0, size,
> -					more);
> +			msghdr.msg_flags &= ~MSG_MORE;
> +		bvec_set_page(&bvec, ZERO_PAGE(0), size, 0);
> +		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
