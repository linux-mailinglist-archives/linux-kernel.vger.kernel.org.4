Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBB87426F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjF2NHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjF2NHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:07:40 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A52AE5B;
        Thu, 29 Jun 2023 06:07:39 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5700b37da3fso6354837b3.1;
        Thu, 29 Jun 2023 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688044058; x=1690636058;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPSxkQ87Wj6qniPEz0gaxOYEsfrmKpTYI5B1z/x1Q/E=;
        b=pRt8FyE0SHlF09fUC9ODK2Vr6aEhF/P0G//O4CcWe7G7LojqTyZWFjBO8X2Wb7AT6U
         j6+aPz0s/M2bojNmAvy8Ed66XhCejVbSZOuaCDdD0s3EoHDiJn4nxrvLDsfbJxVrASTj
         S5uDe0AfRfELn/YR4YTXSQl4CUqrOqxG+TI7TX1pDelAgUfaP81Di8JZPpY9+Ug6RTkG
         sK1uinoNp4bVLPBPzsxvSSAIxFA4gxMtWBUSuFbRz4OxgenaoL3PbjUvKyGwXN4XQn36
         ZhplCx2/KcBmUOSikviEw10MhIZnb9E1B6YMTWuK62lWwsx4ZyA3gEo6cNhLmzfhGhnT
         cqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688044058; x=1690636058;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wPSxkQ87Wj6qniPEz0gaxOYEsfrmKpTYI5B1z/x1Q/E=;
        b=ZbxTXZGoNMpHoC/tcuQ1TjWhh9QWC/bMFV9mr5abFQ7SuuunVwq+AbUBdpUIIdfy/t
         V/i5gPml8zs4DLPhMXeajLtPMyTfJDSST3Uzf3mypJZGcu+iv65kTHg1n8neH+BbEp2P
         7nUCcnfAlph2fj0lugKAgPfnN4WJKoHRUKNfsAn5pT2KT3AvN+oYSquXRkVwXzKEW7C7
         vAHPhxiA6EYK2SJY4y0sJEjiaSxMm0NNfB+HU8ZLT9xChKo3heRwL4qvG+yJI26WgFNi
         8hwLmN9ZBqVWb+OpQDPwROFTNLVc5/9LjQ/Bg9K52ZxwmVBesH71u2Nj4d5YQ3sIhZMo
         NIwQ==
X-Gm-Message-State: AC+VfDycchZF+qbKvHFQGlfRkcVas7St+pzgkuX8JdtptLkFUU0eHBeR
        qOXE+tjRYemTNZHCh+AeXBL+ezlIyg==
X-Google-Smtp-Source: ACHHUZ54T815K5oIlgXBu7Fku65efK/HxXSIeluhK4sRy7j7+hmNGzHsx7+ZAukAbz641fT7BgoaVw==
X-Received: by 2002:a0d:ea52:0:b0:56d:34:893c with SMTP id t79-20020a0dea52000000b0056d0034893cmr28070174ywe.4.1688044058502;
        Thu, 29 Jun 2023 06:07:38 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id d186-20020a8168c3000000b00577139f85dfsm637868ywc.22.2023.06.29.06.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:07:37 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:91d3:5aa:3c41:6715])
        by serve.minyard.net (Postfix) with ESMTPSA id 06203180044;
        Thu, 29 Jun 2023 13:07:36 +0000 (UTC)
Date:   Thu, 29 Jun 2023 08:07:34 -0500
From:   Corey Minyard <minyard@acm.org>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Yi Yang <yiyang13@huawei.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH] ipmi_si: fix a memleak in try_smi_init()
Message-ID: <ZJ2CFthVKdr0U29K@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230629123328.2402075-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629123328.2402075-1-gongruiqi@huaweicloud.com>
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

On Thu, Jun 29, 2023 at 08:33:28PM +0800, GONG, Ruiqi wrote:
> From: Yi Yang <yiyang13@huawei.com>
> 
> Kmemleak reported the following leak info in try_smi_init():
> 
> unreferenced object 0xffff00018ecf9400 (size 1024):
>   comm "modprobe", pid 2707763, jiffies 4300851415 (age 773.308s)
>   backtrace:
>     [<000000004ca5b312>] __kmalloc+0x4b8/0x7b0
>     [<00000000953b1072>] try_smi_init+0x148/0x5dc [ipmi_si]
>     [<000000006460d325>] 0xffff800081b10148
>     [<0000000039206ea5>] do_one_initcall+0x64/0x2a4
>     [<00000000601399ce>] do_init_module+0x50/0x300
>     [<000000003c12ba3c>] load_module+0x7a8/0x9e0
>     [<00000000c246fffe>] __se_sys_init_module+0x104/0x180
>     [<00000000eea99093>] __arm64_sys_init_module+0x24/0x30
>     [<0000000021b1ef87>] el0_svc_common.constprop.0+0x94/0x250
>     [<0000000070f4f8b7>] do_el0_svc+0x48/0xe0
>     [<000000005a05337f>] el0_svc+0x24/0x3c
>     [<000000005eb248d6>] el0_sync_handler+0x160/0x164
>     [<0000000030a59039>] el0_sync+0x160/0x180
> 
> The problem was that when an error occurred before handlers registration
> and after allocating `new_smi->si_sm`, the variable wouldn't be freed in
> the error handling afterwards since `shutdown_smi()` hadn't been
> registered yet. Fix it by adding a `kfree()` in the error handling path
> in `try_smi_init()`.

Thanks, I have included this.  And thanks for handling the stable thing,
too.

-corey

> 
> Cc: stable@vger.kernel.org # 4.19+
> Fixes: 7960f18a5647 ("ipmi_si: Convert over to a shutdown handler")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> Co-developed-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index abddd7e43a9a..5cd031f3fc97 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2082,6 +2082,11 @@ static int try_smi_init(struct smi_info *new_smi)
>  		new_smi->io.io_cleanup = NULL;
>  	}
>  
> +	if (rv && new_smi->si_sm) {
> +		kfree(new_smi->si_sm);
> +		new_smi->si_sm = NULL;
> +	}
> +
>  	return rv;
>  }
>  
> -- 
> 2.25.1
> 
