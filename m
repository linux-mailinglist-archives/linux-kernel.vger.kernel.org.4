Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B99A70EA75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbjEXAuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjEXAuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:50:00 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33C4126;
        Tue, 23 May 2023 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=O4zO94iFTrLjEiMrq1dnb+x3JXQnGuk03+XEMWVY2So=; b=wYbhQOg5kZ7jk5zD083qFdm86E
        mhGO4DMm6pld8ANOD5zePR/6jmBHk9Wx+H89xqedEjfv2R88n8qQ06mvbH0lzhKzAWAEwzh7jzYEl
        bWMpoqMuScq2+pwbJw0xw2Y11uCSqKaJWVykww06h7OezfE2nHJ2AoRLzCKLM8L35s6s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q1cgw-00DjwO-8o; Wed, 24 May 2023 02:49:26 +0200
Date:   Wed, 24 May 2023 02:49:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2kenny@gmail.com
Subject: Re: [PATCH] Remove hardcoded static string length
Message-ID: <01936d68-85d3-4d20-9beb-27ff9f62d826@lunn.ch>
References: <20230523223944.691076-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523223944.691076-1-Kenny.Ho@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 06:39:44PM -0400, Kenny Ho wrote:
> UTS_RELEASE length can exceed the hardcoded length.  This is causing
> compile error when WERROR is turned on.
> 
> Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
> ---
>  net/rxrpc/local_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/rxrpc/local_event.c b/net/rxrpc/local_event.c
> index 19e929c7c38b..61d53ee10784 100644
> --- a/net/rxrpc/local_event.c
> +++ b/net/rxrpc/local_event.c
> @@ -16,7 +16,7 @@
>  #include <generated/utsrelease.h>
>  #include "ar-internal.h"
>  
> -static const char rxrpc_version_string[65] = "linux-" UTS_RELEASE " AF_RXRPC";
> +static const char rxrpc_version_string[] = "linux-" UTS_RELEASE " AF_RXRPC";

This is not an area of the network stack i know about, so please
excuse what might be a dumb question.

How is the protocol defined here? Is there an RFC or some other sort
of standard?

A message is being built and sent over a socket. The size of that
message was fixed, at 65 + sizeof(whdr). Now the message is variable
length. Does the protocol specification actually allow this?

	Andrew
