Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9057774FD18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjGLCgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGLCgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:36:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6DC171F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 19:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D10EC61682
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31D1C433C8;
        Wed, 12 Jul 2023 02:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689129373;
        bh=VYr7MuBjRdIhnSEWu/wTQUTN1+a4AfWfJ0ZfmkkFI08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sjsuANP96xKKQMLvqafjbftM4PlZqLC15IbHO1zlGlRmW8ed/QEKj5cYI/1Yu14PL
         XqcJeZf/NuQ09kqrnjBmI9q8cmHv3Z6TQNmXdJ2eTLW2IqcuS7d7rqcjL6C68XgKFN
         u91sQZKvXYfvIVWTGtAf29oW5BOsLKyud52WBAwwJ3+4qQ57uoosbmnZHf+1vPDBMN
         NRq/W0Usk9+oczI8uOj6oQmQwmEJdwxlE9+vy6wTOWkQ1CrhMOJ9zERtbZ4SMiaO0S
         nVhC2GgHoqTbBPaKu1Aca3JDIPn1/jNNXsTCgKqIlmTd92CSOIIR9szT4vERNY44Tn
         73preDOI8+uug==
Date:   Tue, 11 Jul 2023 19:36:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Ahern <dsahern@kernel.org>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for
 tcp_listen_queue_drop
Message-ID: <20230711193612.22c9bc04@kernel.org>
In-Reply-To: <20230711043453.64095-1-ivan@cloudflare.com>
References: <20230711043453.64095-1-ivan@cloudflare.com>
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

On Mon, 10 Jul 2023 21:34:52 -0700 Ivan Babrou wrote:
> There's already a way to count the overall numbers of queue overflows:
> 
>     $ sudo netstat -s | grep 'listen queue'
>     4 times the listen queue of a socket overflowed
> 
> However, it's too coarse for monitoring and alerting when a user wants to
> track errors per socket and route alerts to people responsible for those
> sockets directly. For UDP there's udp_fail_queue_rcv_skb, which fills
> a similar need for UDP sockets. This patch adds a TCP equivalent.

Makes me want to revert your recent UDP tracepoint to be honest :(
We can play whack a mole like this. You said that kfree_skb fires
too often, why is that? Maybe it's an issue of someone using
kfree_skb() when they should be using consume_skb() ?
