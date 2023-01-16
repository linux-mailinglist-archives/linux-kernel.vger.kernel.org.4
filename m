Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B3166C2C0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjAPOx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjAPOw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:52:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4FE2C647;
        Mon, 16 Jan 2023 06:38:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 275FB60FE4;
        Mon, 16 Jan 2023 14:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86903C433F1;
        Mon, 16 Jan 2023 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673879936;
        bh=S0lxFhz3/HCKeFTEbToGTA6s9C91oi/QqW+NeQF8iLQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=CEvs26fdK1Rz1HRJWuVRwpW+ZoMBYuye0nfUTlhjf5jYvt9+0KP3THS6hZek9CGOU
         E7GBYlbO7ve+f1K8y406rAwltU0Jer2x4XM4TjohfddZqHNfhaD3vuke158YSThR8d
         dzBKk1o9vkBcqx26z5VYIs+AD+tG/NG/0tPCpUtFsL+Ff4X8xi8RF2h293tmYeVtbH
         ueob6XSZaxFUL1euGBb8zUcxucMA1edkgUJUBSot0XTmeti//pQZVjUvDad4cYXFes
         lMy+qgE1NyGdlUIzbEZeEKML6JVV3fBvKr+nGOC5ab0U8ebnnU3YDyj9BTrXd+eH6L
         90o7rPXORgyhQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-15b9c93848dso20756140fac.1;
        Mon, 16 Jan 2023 06:38:56 -0800 (PST)
X-Gm-Message-State: AFqh2koCrUcKGFCyYr/vQTRAQPBGDxLsyJngbckVk1r9/zwHWa/yRi7e
        gyHgBAuxN1Ry1Zl/BZBQoXO1eUJt/z66tJA14nA=
X-Google-Smtp-Source: AMrXdXshFKMYmxHDIY25JHBzDqV8FxemdNdxQ4CKlgmJxw6IrPjcPvrB24X7CSzxCcEQCuEpEMrhP7RHK3qaEnLuATY=
X-Received: by 2002:a05:6871:22c9:b0:15e:d7c0:8016 with SMTP id
 se9-20020a05687122c900b0015ed7c08016mr1270481oab.189.1673879935425; Mon, 16
 Jan 2023 06:38:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6802:195:b0:49c:ff2e:6ecb with HTTP; Mon, 16 Jan 2023
 06:38:54 -0800 (PST)
In-Reply-To: <TYCP286MB23233D324DE28E57E376228ECAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <20230115103209.146002-1-set_pte_at@outlook.com> <TYCP286MB23233D324DE28E57E376228ECAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 16 Jan 2023 23:38:54 +0900
X-Gmail-Original-Message-ID: <CAKYAXd93UvZP0DVrvqFMY7nF0KmU+HMXDcOW2ESDm2ikoq8ubA@mail.gmail.com>
Message-ID: <CAKYAXd93UvZP0DVrvqFMY7nF0KmU+HMXDcOW2ESDm2ikoq8ubA@mail.gmail.com>
Subject: Re: [PATCH 5/6] ksmbd: improve exception handling and avoid redundant
 sanity check in loop
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        hyc.lee@gmail.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-01-15 19:32 GMT+09:00, Dawei Li <set_pte_at@outlook.com>:
> 1. Sanity check on validity of hook is supposed to be static,
>    move it from looping.
>
> 2. If exception occurs after kvmalloc(), kvfree() is supposed
>    to reclaim memory to avoid mem leak.
>
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  fs/ksmbd/connection.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
> index 36d1da273edd..b302de5db990 100644
> --- a/fs/ksmbd/connection.c
> +++ b/fs/ksmbd/connection.c
> @@ -287,6 +287,12 @@ int ksmbd_conn_handler_loop(void *p)
>  	mutex_init(&conn->srv_mutex);
>  	__module_get(THIS_MODULE);
>
> +	if (unlikely(!default_conn_ops.process_fn)) {
> +		pr_err("No connection request callback\n");
> +		module_put(THIS_MODULE);
> +		return -EINVAL;
> +	}
Do you really need this check... ?
> +
>  	if (t->ops->prepare && t->ops->prepare(t))
>  		goto out;
>
> @@ -324,8 +330,10 @@ int ksmbd_conn_handler_loop(void *p)
>  			break;
>
>  		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
> -		if (!ksmbd_smb_request(conn))
> +		if (!ksmbd_smb_request(conn)) {
> +			pr_err("Invalid smb request\n");
>  			break;
> +		}
>
>  		/*
>  		 * We already read 4 bytes to find out PDU size, now
> @@ -343,22 +351,18 @@ int ksmbd_conn_handler_loop(void *p)
>  			continue;
>  		}
>
> -		if (!default_conn_ops.process_fn) {
> -			pr_err("No connection request callback\n");
> -			break;
> -		}
> -
>  		if (default_conn_ops.process_fn(conn)) {
>  			pr_err("Cannot handle request\n");
>  			break;
>  		}
>  	}
>
> +	kvfree(conn->request_buf);
> +	conn->request_buf = NULL;
->request_buf is freed in ksmbd_conn_free(). ->request_buf should not
be freed here as the processing of the request may not be complete
here.

>  out:
> -	/* Wait till all reference dropped to the Server object*/
> +	/* Wait till all reference dropped to the Server object */
>  	wait_event(conn->r_count_q, atomic_read(&conn->r_count) == 0);
>
> -
>  	if (IS_ENABLED(CONFIG_UNICODE))
>  		utf8_unload(conn->um);
>  	unload_nls(conn->local_nls);
> --
> 2.25.1
>
>
