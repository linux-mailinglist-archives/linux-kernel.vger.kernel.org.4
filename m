Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE90C65EE60
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjAEOI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjAEOIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:08:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B29E19295;
        Thu,  5 Jan 2023 06:08:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E39E618DB;
        Thu,  5 Jan 2023 14:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF708C433EF;
        Thu,  5 Jan 2023 14:08:10 +0000 (UTC)
Date:   Thu, 5 Jan 2023 09:08:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yunhui Cui <cuiyunhui@bytedance.com>
Cc:     mhiramat@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, duanxiongchun@bytedance.com,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sock: add tracepoint for send recv length
Message-ID: <20230105090807.51213cea@gandalf.local.home>
In-Reply-To: <20230105100014.1935-1-cuiyunhui@bytedance.com>
References: <20230105100014.1935-1-cuiyunhui@bytedance.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Jan 2023 18:00:14 +0800
Yunhui Cui <cuiyunhui@bytedance.com> wrote:

> @@ -715,6 +716,10 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
>  				     inet_sendmsg, sock, msg,
>  				     msg_data_left(msg));
>  	BUG_ON(ret == -EIOCBQUEUED);
> +
> +	trace_sock_sendmsg_length(sock->sk, sock->sk->sk_family,
> +				  sock->sk->sk_protocol,
> +				  ret > 0 ? ret : 0, ret > 0 ? 0 : ret, 0);

The length and error seem confusing. Basically, length is ret > 0 and error
is ret < 0, right?

That means we don't need both. We could simply have:

> +	TP_ARGS(sk, family, protocol, length, error, flags),

	TP_ARGS(sk, family, protocol, ret, flags)

> +
> +	TP_STRUCT__entry(
> +		__field(void *, sk)
> +		__field(__u16, family)
> +		__field(__u16, protocol)
> +		__field(int, length)
> +		__field(int, error)
> +		__field(int, flags)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->sk = sk;
> +		__entry->family = sk->sk_family;
> +		__entry->protocol = sk->sk_protocol;
> +		__entry->length = length;

		__entry->length = ret > 0 ? ret : 0;

> +		__entry->error = error;

		__entry->error = ret < 0 ? ret : 0;

> +		__entry->flags = flags;
> +	),
> +

>  	return ret;
>  }
>  
> @@ -992,9 +997,17 @@ INDIRECT_CALLABLE_DECLARE(int inet6_recvmsg(struct socket *, struct msghdr *,
>  static inline int sock_recvmsg_nosec(struct socket *sock, struct msghdr *msg,
>  				     int flags)
>  {
> -	return INDIRECT_CALL_INET(sock->ops->recvmsg, inet6_recvmsg,
> +	int ret = INDIRECT_CALL_INET(sock->ops->recvmsg, inet6_recvmsg,
>  				  inet_recvmsg, sock, msg, msg_data_left(msg),
>  				  flags);
> +
> +	trace_sock_recvmsg_length(sock->sk, sock->sk->sk_family,
> +				  sock->sk->sk_protocol,
> +				  (ret > 0 && !(flags & MSG_PEEK)) ?
> +				  ret : 0,
> +				  (ret > 0 && !(flags & MSG_PEEK)) ? 0 : ret,

Since both length and error are zero when flags has MSG_PEEK set:

	trace_sock_recvmsg_length(sock->sk, sock->sk->sk_family,
				  sock->sk->sk_protocol,
				  !(flags & MSG_PEEK) ? ret : 0,

-- Steve

> +				  flags);
> +	return ret;
>  }
>  
>  /**
> @@ -1044,6 +1057,7 @@ static ssize_t sock_sendpage(struct file *file, struct page *page,
>  {
>  	struct socket *sock;
>  	int flags;
> +	int ret;
>  
>  	sock = file->private_data;
>  
> @@ -1051,7 +1065,12 @@ static ssize_t sock_sendpage(struct file *file, struct page *page,
>  	/* more is a combination of MSG_MORE and MSG_SENDPAGE_NOTLAST */
>  	flags |= more;
>  
> -	return kernel_sendpage(sock, page, offset, size, flags);
> +	ret = kernel_sendpage(sock, page, offset, size, flags);
> +
> +	trace_sock_sendmsg_length(sock->sk, sock->sk->sk_family,
> +				  sock->sk->sk_protocol,
> +				  ret > 0 ? ret : 0, ret > 0 ? 0 : ret, 0);
> +	return ret;
>  }
>  
>  static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
