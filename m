Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B787266A2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjFGQ6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjFGQ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0D910D7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64AC163918
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DE5C433EF;
        Wed,  7 Jun 2023 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686157122;
        bh=exiwNMtro5HZ3RTiNqye9ih4jHEqnpnzeZJ2eAQPXh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H1vZGGGrAefzYt3YUbVr2VTjdG3ZuzagxJr9pFbQvwg3+wG+vM9fhrQwLYiySKC8J
         bPEJw2Ig/z8qobZwKfHHz8w+67d/aPU84K9tm9SyyMkFvc8x0nwoOJm4OObzCoNUbm
         UtBcvVtwj0LxVFadTBDx6BxNhN55TzSH5jUVM4esHYUPeBWW0q0VBn2OXJJQXdmUuW
         ULNc2zCWHq81EKoBdF6k7DEovs8RvE+CuZd8JMVLjvjUvNCz+6lNvER+J8gELA60H7
         Hs86QMzwg/6UWxAZguASPAHCUeqTtKXErsuqeXOI+l4X2ZD3Uy7SNsheG1fel1ZlL+
         oV2Qp40oZMvDg==
Date:   Wed, 7 Jun 2023 09:58:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/14] tls/device: Use splice_eof() to flush
Message-ID: <20230607095841.6e0edf7e@kernel.org>
In-Reply-To: <20230607140559.2263470-7-dhowells@redhat.com>
References: <20230607140559.2263470-1-dhowells@redhat.com>
        <20230607140559.2263470-7-dhowells@redhat.com>
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

On Wed,  7 Jun 2023 15:05:51 +0100 David Howells wrote:
> Allow splice to end a TLS record after prematurely ending a splice/sendfile
> due to getting an EOF condition (->splice_read() returned 0) after splice
> had called TLS with a sendmsg() with MSG_MORE set when the user didn't set
> MSG_MORE.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
