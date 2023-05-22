Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE370CDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjEVWaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjEVWaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:30:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390E5109;
        Mon, 22 May 2023 15:30:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-52caed90d17so4665277a12.0;
        Mon, 22 May 2023 15:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684794607; x=1687386607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0BADrMgNcqHGvZTXAFhgG6p0QoADWfiDby7KN9sF5g=;
        b=O0UWeL3wu6o5g5vDi3RXmw+3yYGM3Kg0rknQV9z9mHgrkDZI5nhOhn90kqFa4HM9X+
         TpE+0CXWNhNc7MPDFXXaunuyhU0mJVUVVnFOsTLEtqr4ySen8TZrthJgOxBruZExz4L2
         hmj1tTOHCVNXCTyQr9R47Ol4YfZwqkMuISDp5a10rcalYpEArAihBf/o/skPQdhzLvTA
         UrwFjRYctIcLTMYdvQCOnzhYIv4ONH+aYD96Cpje/21UydboAPkBFyclQYgbwfsuetL6
         63+uuNgkD1zY22Wy2kUCCk7CiOT9ngqpz7sPE94eFGHv4KprxS2EhZgacK2mtyJ2cs2l
         BBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794607; x=1687386607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0BADrMgNcqHGvZTXAFhgG6p0QoADWfiDby7KN9sF5g=;
        b=TYhumdIt9YDdDqlMRA6HUODVaGm9OVozzYJlfO469f91sgOr+6YG4tsOxC6wGKCuCu
         q5DdDlMFjW3vGOv2YPYmeJkvsBtLpiBd+GUDQ9FcxckJBnyyUx9S6Zut9zxnTlbJR3W2
         eVZPRpM/AUvIlYoMSFBH7pBObN0OvuFQiU0jsZd9o7OXTUN19gHF5fLsQ8CWIo2+GEen
         rZ2efQyEffZvWSonY6E4SE6stccpwCR40L5UETcvB4F2hPbDigMNR+UYW83N3UGCy863
         0zlacegrFwPXdG5wXLh735Rd/eZPYQlwo25oa9K2wu7qpLqj3ZjP/jzWa8Ijup9va13M
         jt9A==
X-Gm-Message-State: AC+VfDwewBeO75878AiB21i6TT+pWqavFqQWO1ITrMeveM1I2+iwYqyb
        /XgVB8Ie2GVvYVcIbSlHpXQ=
X-Google-Smtp-Source: ACHHUZ6gdI+c8iqtPZufgDopEpdoUnu/Ac9M4z335puf/ipJaw+/sO0zu1KRRWPDUKZ3knOcS11eCw==
X-Received: by 2002:a17:90b:1d03:b0:246:5968:43f0 with SMTP id on3-20020a17090b1d0300b00246596843f0mr11554054pjb.10.1684794607605;
        Mon, 22 May 2023 15:30:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090a9b0600b0024b79a69361sm6223734pjp.32.2023.05.22.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:30:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 May 2023 15:30:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Su Hui <suhui@nfschina.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>, eajames@us.ibm.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        cbostic@linux.vnet.ibm.com, linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH] drivers/fsi/scom: Return -EFAULT if copy fails
Message-ID: <de9a7ffe-bedd-4181-886d-c9a3006b7be8@roeck-us.net>
References: <20230519013710.34954-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519013710.34954-1-suhui@nfschina.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 09:37:10AM +0800, Su Hui wrote:
> The copy_to/from_user() functions return the number of bytes remaining
> to be copied, but we want to return -EFAULT to the user.
> 
Why ? EFAULT means that a bad address was provided, and it is not
immediately obvious why that would be the case.

Guenter

> Fixes: 680ca6dcf5c2 ("drivers/fsi: Add SCOM FSI client device driver")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/fsi/fsi-scom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> index bcb756dc9866..caaf7738eb98 100644
> --- a/drivers/fsi/fsi-scom.c
> +++ b/drivers/fsi/fsi-scom.c
> @@ -335,7 +335,7 @@ static ssize_t scom_read(struct file *filep, char __user *buf, size_t len,
>  	if (rc)
>  		dev_dbg(dev, "copy to user failed:%d\n", rc);
>  
> -	return rc ? rc : len;
> +	return rc ? -EFAULT : len;
>  }
>  
>  static ssize_t scom_write(struct file *filep, const char __user *buf,
> -- 
> 2.30.2
> 
