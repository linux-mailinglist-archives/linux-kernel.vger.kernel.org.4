Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EC47460EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGCQql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:46:40 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F23E41;
        Mon,  3 Jul 2023 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=hGh0RjSMKjqK2Wktq8A3Dwgw/Zxp8Whsd7BqywESmC8=; b=qtKB0VE7XS/zPSFAFKc+aThafR
        LCQB1gwLxwZEa/ooBzb8rCnkiW1tM9mPEEeOLJkzdv9W87fOp6flmOmoy3/9pjSNdzzhYNyyNausq
        pVBILaIj/KPN8JD21o365Av1uppESQ171x5jOgt4L1Cou6adKhr8WQswXFXZ5K8u/cuc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qGMgz-000Unb-El; Mon, 03 Jul 2023 18:46:25 +0200
Date:   Mon, 3 Jul 2023 18:46:25 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     leitao@debian.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, tj@kernel.or,
        Dave Jones <davej@codemonkey.org.uk>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <4b2746ad-1835-43e6-a2fc-7063735daa46@lunn.ch>
References: <20230703154155.3460313-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703154155.3460313-1-leitao@debian.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Cc: Dave Jones <davej@codemonkey.org.uk>

Signed-off-by should come last.

> +#ifdef CONFIG_NETCONSOLE_UNAME
> +static void send_ext_msg_udp_uname(struct netconsole_target *nt,
> +				   const char *msg, unsigned int len)
> +{
> +	unsigned int newlen;
> +	char *newmsg;
> +	char *uname;
> +
> +	uname = init_utsname()->release;
> +
> +	newmsg = kasprintf(GFP_KERNEL, "%s;%s", uname, msg);
> +	if (!newmsg)
> +		/* In case of ENOMEM, just ignore this entry */
> +		return;

Hi Breno

Why not just send the message without uname appended. You probably
want to see the OOM messages...

Also, what context are we in here? Should that be GFP_ATOMIC, which
net/core/netpoll.c is using to allocate the skbs?

> +static inline void send_msg_udp(struct netconsole_target *nt,
> +				const char *msg, unsigned int len)
> +{
> +#ifdef CONFIG_NETCONSOLE_UNAME
> +	send_ext_msg_udp_uname(nt, msg, len);
> +#else
> +	send_ext_msg_udp(nt, msg, len);
> +#endif

Please use

if (IS_ENABLED(CONFIG_NETCONSOLE_UNAME)) {} else {}

so the code is compiled and then thrown away. That nakes build testing
more efficient.

     Andrew
