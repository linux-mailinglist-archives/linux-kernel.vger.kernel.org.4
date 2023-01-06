Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B27365FA93
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 05:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjAFEHs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Jan 2023 23:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAFEHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 23:07:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50141625F1;
        Thu,  5 Jan 2023 20:07:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4FDEB81BF2;
        Fri,  6 Jan 2023 04:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783E7C433D2;
        Fri,  6 Jan 2023 04:07:40 +0000 (UTC)
Date:   Thu, 5 Jan 2023 23:07:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Cc:     mhiramat@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, duanxiongchun@bytedance.com,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] sock: add tracepoint for send recv
 length
Message-ID: <20230105230737.426abfdd@gandalf.local.home>
In-Reply-To: <CAEEQ3wmnUpuZxLbrMwPCk+pnbC27fo4bi-nN-848o6QGO6Xt+Q@mail.gmail.com>
References: <20230105100014.1935-1-cuiyunhui@bytedance.com>
        <20230105090807.51213cea@gandalf.local.home>
        <CAEEQ3wmnUpuZxLbrMwPCk+pnbC27fo4bi-nN-848o6QGO6Xt+Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2023 11:24:18 +0800
运辉崔 <cuiyunhui@bytedance.com> wrote:

> Regardless of whether the MSG_PEEK flag is set or not, it is possible
> to return -errno,
> but based on your suggestion, I plan to modify it like this:
> 
> trace_sock_recvmsg_length(sock->sk, sock->sk->sk_family,
>                           sock->sk->sk_protocol,
>                           !(flags & MSG_PEEK) ? ret : (ret < 0 ? ret : 0),
> 
> what do you think?

Sure.

But note, from your original patch:

> +	trace_sock_recvmsg_length(sock->sk, sock->sk->sk_family,
> +				  sock->sk->sk_protocol,
> +				  (ret > 0 && !(flags & MSG_PEEK)) ?
> +				  ret : 0,
> +				  (ret > 0 && !(flags & MSG_PEEK)) ? 0 : ret,
> +				  flags);

If flags MSG_PEEK is set, you return ret in error regardless, so error
would be ret even if it was positive.

So I'm guessing that this change actually fixed a bug. ;-)

-- Steve
