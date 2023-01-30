Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C237B681731
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbjA3REt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3REp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:04:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49AFCA3A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675098239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dxwuKRERvITDZ4Jk1vAFyT84zZFQVN0zqx77dghYL/A=;
        b=FwIIlO+TjEx6YUM6OTeOjqHk73O0BpdVIvPZrDsaocyCQiu9f/S3Pp6LcMLG7l8m827AiI
        jyRUP2AvoBehFsE2+RBCmISpyOeLCPwyxQmYJKN5r/ZUGXEG/bz96MTjPcyXrFTfX2/qsx
        +ZGIEVEVgFtfg4LVJhDQ2rEsbIyjrOI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-493-x22cwgvFPp-OsxW22aiFZw-1; Mon, 30 Jan 2023 12:03:58 -0500
X-MC-Unique: x22cwgvFPp-OsxW22aiFZw-1
Received: by mail-qk1-f197.google.com with SMTP id q21-20020a05620a0d9500b0070572ccdbf9so7432718qkl.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxwuKRERvITDZ4Jk1vAFyT84zZFQVN0zqx77dghYL/A=;
        b=RLi/yLsHg4EDkPYRtTpW3C0aF1nnHtYE1WkKV2q+YzLgmuwc+JMquyczgP9yMOjUHl
         xKR9tFCCs49O7ScaX0Gp+uigrtcZSV7+URLK6R7O26K/mmUf3iv80ENkrlkb2KxCzqYK
         PdMZfWHdznIIDsucUEkhkqYVjwYqbvrxgi5h4/AHqgz+O3IaJZ/NqdFBmwHErRI+cpGC
         oledYHviE3Z/AF/3XgykFFgJj6Z4X+MTSalaFEMIDTT5WnNcppWYqllQRvj7EvaV/xma
         56KscgiZQ7oBVee/f2cozJt1IVlS6SEPnIpOvZwsWYDRnrV3bAW6L46eO7JI6JI57CXK
         s6uQ==
X-Gm-Message-State: AFqh2kqQ7MlPXjk8tUPwBN29DOgU1U7ytyxWBXPU23gIhzH1g52jsVkZ
        FDqENss6SbmeRIfRk7JSQEy+kc6nqvz3nqg2oB3fC68vv97dHFQHO0ou6jT0UPFQCQmkNq9VIG3
        m2XkWbFj936CuVlwoX4RSEVak
X-Received: by 2002:ac8:6b81:0:b0:3a8:1677:bc39 with SMTP id z1-20020ac86b81000000b003a81677bc39mr69297175qts.52.1675098236975;
        Mon, 30 Jan 2023 09:03:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuZyGvdfQAfbKzWXHEtQvVZ+VSKGCnJwr6ctCYR7OKAfTC5kzKfMj4q0599OaRW2vV5eMiPhw==
X-Received: by 2002:ac8:6b81:0:b0:3a8:1677:bc39 with SMTP id z1-20020ac86b81000000b003a81677bc39mr69297151qts.52.1675098236671;
        Mon, 30 Jan 2023 09:03:56 -0800 (PST)
Received: from debian (2a01cb058918ce009322c8fdd95cb32b.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:9322:c8fd:d95c:b32b])
        by smtp.gmail.com with ESMTPSA id x15-20020ac8018f000000b003b9a573aec6sm92722qtf.70.2023.01.30.09.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:03:56 -0800 (PST)
Date:   Mon, 30 Jan 2023 18:03:52 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     jchapman@katalix.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] l2tp: Avoid possible recursive deadlock in
 l2tp_tunnel_register()
Message-ID: <Y9f4eAhcJXhh0+c2@debian>
References: <20230130154438.1373750-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130154438.1373750-1-syoshida@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:44:38AM +0900, Shigeru Yoshida wrote:
> This patch fixes the issue by returning error when a pppol2tp socket
> itself is passed.

Fixes: 0b2c59720e65 ("l2tp: close all race conditions in l2tp_tunnel_register()")

> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/l2tp/l2tp_ppp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index db2e584c625e..88d1a339500b 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -702,11 +702,14 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
>  			struct l2tp_tunnel_cfg tcfg = {
>  				.encap = L2TP_ENCAPTYPE_UDP,
>  			};
> +			int dummy = 0;

There's no need to initialise dummy here. This is just confusing.
We could even do without any extra variable and reuse error in
sockfd_lookup().

>  			/* Prevent l2tp_tunnel_register() from trying to set up
> -			 * a kernel socket.
> +			 * a kernel socket.  Also, prevent l2tp_tunnel_register()
> +			 * from trying to use pppol2tp socket itself.
>  			 */
> -			if (info.fd < 0) {
> +			if (info.fd < 0 ||
> +			    sock == sockfd_lookup(info.fd, &dummy)) {
>  				error = -EBADF;
>  				goto end;
>  			}

That should work, but the real problem is calling l2tp_tunnel_register()
under lock_sock(). We should instead get/create the tunnel before
locking the pppol2tp socket.

