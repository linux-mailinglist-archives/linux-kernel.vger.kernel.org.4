Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327C3748896
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjGEP4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjGEP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3C12A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F0056160D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 15:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55A8C433C8;
        Wed,  5 Jul 2023 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688572602;
        bh=JzLAQUPDOXJPxLfN84dScm6T9CeT0pD+A8KgrxBtYWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BZqL5P9bNRDmIWANHdbs0Y80b9MbKC+yrTFdMVebedm/pm20PL9CZ0LwKXIm4fgBE
         Y69ejPy7KVgr1RLJxDYhOZDldjmykVJcgcjjAqfr2VLew7UMacivRBrCUXBAVuRJ37
         6By6OmYAMPL0fZne9bH2lz1javnh60vvV/zDfBmxU8M3PEKW1FR4veo3J2b+3fHeRl
         NmBL4LnqbYUrXt1LOnj4GMoRJnqS+xI1b7aR2jkaIBN5SVJVRK95YxV5p9kzkojR4v
         gvRMvfZLO/9i7txdy04s7yMreyCPgpD+rsZny60Kmci6MUZLFAUjL3VWWbHDJH2fco
         iGxb/KzQB8JEg==
Date:   Wed, 5 Jul 2023 08:56:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, tj@kernel.or,
        Dave Jones <davej@codemonkey.org.uk>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <20230705085640.46ad5c2e@kernel.org>
In-Reply-To: <ZKQ/C7z2RMG5a4XN@gmail.com>
References: <20230703154155.3460313-1-leitao@debian.org>
        <20230703124427.228f7a9e@kernel.org>
        <ZKQ/C7z2RMG5a4XN@gmail.com>
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

On Tue, 4 Jul 2023 08:47:23 -0700 Breno Leitao wrote:
> This is the code that does it. How does it sound?

More or less :)

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 4f4f79532c6c..d26bd3b785c4 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -36,6 +36,7 @@
>  #include <linux/inet.h>
>  #include <linux/configfs.h>
>  #include <linux/etherdevice.h>
> +#include <linux/utsname.h>
>  
>  MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
>  MODULE_DESCRIPTION("Console driver for network interfaces");
> @@ -772,8 +773,10 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
>  	const char *header, *body;
>  	int offset = 0;
>  	int header_len, body_len;
> +	int uname_len = 0;

I'd calculate the uname_len here if the option was set.

> -	if (msg_len <= MAX_PRINT_CHUNK) {
> +	if (msg_len <= MAX_PRINT_CHUNK &&
> +	    !IS_ENABLED(CONFIG_NETCONSOLE_UNAME)) {

And then try to fold the path with uname into this. So that we don't
have to separate exit points for the "message is short enough".

>  		netpoll_send_udp(&nt->np, msg, msg_len);
>  		return;
>  	}
> @@ -788,14 +791,31 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
>  	body_len = msg_len - header_len - 1;
>  	body++;
>  
> +	if (IS_ENABLED(CONFIG_NETCONSOLE_UNAME)) {
> +		/* Add uname at the beginning of buffer */
> +		char *uname = init_utsname()->release;

nit: const

> +		/* uname_len contains the length of uname + ',' */
> +		uname_len = strlen(uname) + 1;
> +
> +		if (uname_len + msg_len < MAX_PRINT_CHUNK) {
> +			/* No fragmentation needed */
> +			scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", uname, msg);
> +			netpoll_send_udp(&nt->np, buf, uname_len + msg_len);
> +			return;
> +		}
> +
> +		/* The data will be fragment, prepending uname */
> +		scnprintf(buf, MAX_PRINT_CHUNK, "%s,", uname);
> +	}
> +
>  	/*
>  	 * Transfer multiple chunks with the following extra header.
>  	 * "ncfrag=<byte-offset>/<total-bytes>"
>  	 */
> -	memcpy(buf, header, header_len);
> +	memcpy(buf + uname_len, header, header_len);

And once done prepping I'd add uname_len to header_len

>  	while (offset < body_len) {
> -		int this_header = header_len;
> +		int this_header = header_len + uname_len;

Last but not least, I do agree with Stephen that this can be
configurable with sysfs at runtime, no need to make it a Kconfig.
