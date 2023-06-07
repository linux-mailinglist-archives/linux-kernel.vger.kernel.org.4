Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC5F726713
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjFGRU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjFGRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8E1E62
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 113C763B0E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17FDC433EF;
        Wed,  7 Jun 2023 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686158424;
        bh=adqvDA+1TjaAGnTMKfAosw2t+UHx0gdR3o+C9+WLfas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QrgEDUrpuvtjtYYXyNXRk1dM2+tU5LatKXwXs/1xrXOOFssrCslRRsYtUyt3hdrkn
         Dh+x3YRI3wjtLLcilrzbAlRVvaLYnG0rcVd/Zq5rTIqTJb/bk6b2AdJhN2Jwvr5VQy
         Y+psu3Ozz53QvE8pkOaoGyFJra9fJeporG6xTn4ngLRRqX0uGjaWkRdg3rbA0NO/bn
         Ou7iQI5PFw3OR4mfe5YqMygaocJk4FR2iqfVb4093jkA93CKs5hB+FL+jEI4h/LAmU
         z/1SnG7PASoJh0YamOmuhju0WO98sy0xlKkuv/wDL7v5AV7XKcTVyZ4CA0JS3GEw1z
         tKCVsbaX9/Elg==
Date:   Wed, 7 Jun 2023 10:20:22 -0700
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
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/14] tls/sw: Convert tls_sw_sendpage() to
 use MSG_SPLICE_PAGES
Message-ID: <20230607102022.42498d4d@kernel.org>
In-Reply-To: <20230607140559.2263470-13-dhowells@redhat.com>
References: <20230607140559.2263470-1-dhowells@redhat.com>
        <20230607140559.2263470-13-dhowells@redhat.com>
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

On Wed,  7 Jun 2023 15:05:57 +0100 David Howells wrote:
> Convert tls_sw_sendpage() and tls_sw_sendpage_locked() to use sendmsg()
> with MSG_SPLICE_PAGES rather than directly splicing in the pages itself.
> 
> [!] Note that tls_sw_sendpage_locked() appears to have the wrong locking
>     upstream.  I think the caller will only hold the socket lock, but it
>     should hold tls_ctx->tx_lock too.
> 
> This allows ->sendpage() to be replaced by something that can handle
> multiple multipage folios in a single transaction.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
