Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FDD711398
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjEYSVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjEYSVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:21:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D79E;
        Thu, 25 May 2023 11:21:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d3fdcadb8so23026b3a.3;
        Thu, 25 May 2023 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685038860; x=1687630860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvwRmaCuUT3330k/5Y6KgHdQe3q6XGkjEssdCY/1fho=;
        b=ZkQT7SQh8bk+LAOiBpWIINcHhUXpf8YgmwQt0z6vMpO95UpYTJp+4tq8gbKj+odw59
         z/cmcPj0NPMqQGOpD3RUkswsRAwIxylTpUBL12Q9rDR0iErBrPaT6rQz4xX/Zy89reBJ
         KgCcLG7zsl/njsuXYJiX7OffRk2PcKGhKRD0wa3PIdrlu28CiSackBZ64EaTsGEgmP7m
         3UL1NnRLi+ARKV+OsScK/cmBh/ontL3TZGLHWJmAnSuc2cXZEoV6WHKpO861nyggmhmu
         2jIiytV25/UJOdgeV9OX+bOyqztb60+DGo1v9KSEFjxgTx0ZpdHg1UqNnqvK9N/fft0t
         HQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038860; x=1687630860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvwRmaCuUT3330k/5Y6KgHdQe3q6XGkjEssdCY/1fho=;
        b=jCZsNgrk1aLArfwyYk8rLj3NZRhv19RlSzlfbbs6AQqLoyQmvBjsmJ7EcOioHiX16k
         LSYdr8Nu32TfW94JDha4Tcy4OFmVNXVq4p5UBqqp2Acm+XQGogNeoVZUc2CjkTOb6EQd
         lBk7jbBcF//zeJrH9M0Ah/6GzuaB85WlYHNeXyIAq4msEYtx8rTxNdA7CV8S0JGGA23D
         fC0V2N06049bcLPYZ0iYyyrQ5IpMe+cnAwPuoYkWQe+L4DkPkGxUrniVFWrinUz5WOMo
         1cffafGShUaijX0OI6rs4L8HA6yTExWijOi9EyZb5fQ8BujgEw3zNVxx++4JccX/SwZo
         ZTeQ==
X-Gm-Message-State: AC+VfDyBv0TL1BaTuLt9VH/QRFAHTh+9bnNIgcodT7YpVFGqmvqQ4Amv
        jAJxZy5n9VBtWWu547hy3MI=
X-Google-Smtp-Source: ACHHUZ7asozrcrWCeM/vti+qdDg/IjePbm3CK2F16WGGsWsv3frl3eulhVpfoBDsYLs3uq+CT3Ro/Q==
X-Received: by 2002:a05:6a20:938f:b0:105:6d0e:c037 with SMTP id x15-20020a056a20938f00b001056d0ec037mr23897924pzh.38.1685038860126;
        Thu, 25 May 2023 11:21:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y9-20020aa78049000000b00642ea56f06dsm1470990pfm.26.2023.05.25.11.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 11:20:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 25 May 2023 11:20:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ucd9000.c: Drop error checking for debugfs_create_dir
Message-ID: <efe65d37-0e15-4685-b071-5ddf2b07c6ef@roeck-us.net>
References: <20230525161313.15745-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525161313.15745-1-osmtendev@gmail.com>
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

On Thu, May 25, 2023 at 09:13:13PM +0500, Osama Muhammad wrote:
> This patch fixes the error checking in ucd9000.c.

Sure, but you should also explain what is wrong with the code
(i.e., that debugfs_create_dir() does not return NULL but an ERR_PTR
after an error).

> The DebugFS kernel API is developed in
> a way that the caller can safely ignore the errors that
> occur during the creation of DebugFS nodes.
> 

If you plan t send more patches, please watch out for the subject line
to match subject lines used in a subsystem. Here it should start with
something like

hwmon: (pmbus/ucd9000) ...

Thanks,
Guenter

> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---
>  drivers/hwmon/pmbus/ucd9000.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
> index 3daaf2237832..73559afa8ba7 100644
> --- a/drivers/hwmon/pmbus/ucd9000.c
> +++ b/drivers/hwmon/pmbus/ucd9000.c
> @@ -512,8 +512,6 @@ static int ucd9000_init_debugfs(struct i2c_client *client,
>  		return -ENOENT;
>  
>  	data->debugfs = debugfs_create_dir(client->name, debugfs);
> -	if (!data->debugfs)
> -		return -ENOENT;
>  
>  	/*
>  	 * Of the chips this driver supports, only the UCD9090, UCD90160,
> -- 
> 2.34.1
> 
