Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F27735C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjFSQlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjFSQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:41:03 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFBFFA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:41:03 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3fde82c8ca7so25527991cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687192862; x=1689784862;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcV19aRCquvCQdRFuACW3XW/4/XQ46XTCmzcnj1+5kE=;
        b=QGEI9H8MCmtVcf8VSUAwJPRiCKL9aS3yCq3ltJqJz2LQ9Zp1dwEVzyamh1ME5fzMpc
         WmFhdVtC68JdF8KqozhMLXhC5yYx5AvQSJRCadMn/tBX9RQo4cZbwb42RY0Y/TwSz5B1
         gdj/GN++JQv9ifPPKq7RnypplBIZAPi6T3c1hcttr3aTViTw35/X+Y61BfrLVf/AVAA8
         qZJzzT0c0jWHuea2C0q98Lp6NXg9/3TCbqvsZHr9QwgzjHjOenNDxFvK2WTsBDjbHxRw
         eY9jtA5SxRRiwVgP0IfRoVngaaqbZdQanQi0Q6LEN3aUYXRkrHds2dLwS5hkMM4z63Ns
         uQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687192862; x=1689784862;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mcV19aRCquvCQdRFuACW3XW/4/XQ46XTCmzcnj1+5kE=;
        b=j+yJDb6r56lwp6T4+vQ6J8KLgMsxLRrO6LVaX6Wv44uqRaqXNwx5020EGH+cYVkQFt
         89KYh2nZupX+0SBPdFjJyt0A9MJuuQW9l8HEjlKCvr4Ug2uJiPlt+6g0D0a0PZiSlbm/
         drcYc4AenbYJTHIlS19Npgrjs5/zXdA4Y0QlU4GI4a3QZC29e3zmWJVUDDNpFBegt+ej
         xDzA5+RK5PYcdnas80AoN291z7TE7sS6Q+d6epYMapuQ13gQ0qO20H6mSEto6fdRdY9U
         28wXRSO/zmecyazSjt+MYeCgS9cFaTur54so5XpZBtjmmpjBWkH6GkMO4pKMaG40zP84
         trLA==
X-Gm-Message-State: AC+VfDxvxwPj09VT6senIhy/Fm1wTycEtbMUBr1Q2L5IpS8wka/wKP+C
        YC5jV3qWQIKQPI2jbcGd+Q==
X-Google-Smtp-Source: ACHHUZ4mXi2yn6+G8lN33A77Se7WDpZn/bDqisFwDZPDhH9CwrLCxxQQVoujDd96nGPvlwdEdAo7tQ==
X-Received: by 2002:a05:622a:54f:b0:3ff:21f1:949 with SMTP id m15-20020a05622a054f00b003ff21f10949mr1778733qtx.9.1687192861829;
        Mon, 19 Jun 2023 09:41:01 -0700 (PDT)
Received: from serve.minyard.net ([47.184.157.108])
        by smtp.gmail.com with ESMTPSA id z17-20020ac87cb1000000b003f86c08b3e7sm68644qtv.21.2023.06.19.09.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:41:01 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:3c66:2774:dcfe:891a])
        by serve.minyard.net (Postfix) with ESMTPSA id 4C3DA1800E8;
        Mon, 19 Jun 2023 16:41:00 +0000 (UTC)
Date:   Mon, 19 Jun 2023 11:40:59 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     kamlakantp@marvell.com, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ssif: Add check for kstrdup
Message-ID: <ZJCFG3o4JL/OL9WU@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230619092802.35384-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619092802.35384-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 05:28:02PM +0800, Jiasheng Jiang wrote:
> Add check for the return value of kstrdup() and return the error
> if it fails in order to avoid NULL pointer dereference.

Thanks, this is in my next tree.

-corey

> 
> Fixes: c4436c9149c5 ("ipmi_ssif: avoid registering duplicate ssif interface")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 3b921c78ba08..3b87a2726e99 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1600,6 +1600,11 @@ static int ssif_add_infos(struct i2c_client *client)
>  	info->addr_src = SI_ACPI;
>  	info->client = client;
>  	info->adapter_name = kstrdup(client->adapter->name, GFP_KERNEL);
> +	if (!info->adapter_name) {
> +		kfree(info);
> +		return -ENOMEM;
> +	}
> +
>  	info->binfo.addr = client->addr;
>  	list_add_tail(&info->link, &ssif_infos);
>  	return 0;
> -- 
> 2.25.1
> 
