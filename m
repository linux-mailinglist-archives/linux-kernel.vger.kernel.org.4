Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1829B61E2DB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiKFPEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKFPEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:04:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883042DED
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667746992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bcF/g3FxS3vq7HBJy0REl0nrtkod0xAAfETE5zlqifI=;
        b=FJCl8xXzublitwiF6efe4nzk+IaVeYFn5ImJxiWRQS1UmVZ0IQUk1/TobRQoIjvvSsZv6g
        wWxOZQ7dMuVaFmCVxjDBaGCvX2vF1y/TSs3REiW+8F+q+NTzZWGxyhHyXiJ1KQMKgFUtAi
        TQVmON6aTm9jM+k/021abF6f8HYzNJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-386-y9_Wo--zPpiBQJMdw2Wb8Q-1; Sun, 06 Nov 2022 10:03:11 -0500
X-MC-Unique: y9_Wo--zPpiBQJMdw2Wb8Q-1
Received: by mail-wm1-f69.google.com with SMTP id bg21-20020a05600c3c9500b003c2acbff422so5567924wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 07:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcF/g3FxS3vq7HBJy0REl0nrtkod0xAAfETE5zlqifI=;
        b=kXWyTd+VRZZfaEQu9h4RxQzgaGFEzTHHLxr78Iv7/+rh2flPjJ/wOOZxCBhYr+MOqV
         qY+v2jAenSyj8Vo9VVl0gv3KYeO91sBley2dtNfZnPvVFMIfFo7L/kiIOvw3ff6JWX6a
         f9BOoUYNzZ924W1LEBMqd4/+rWiXKHCHzzq/EJLfGhgJYAD4ut/4bPjLu+nugWyUSh+h
         EroHT3/MdmRDcH9ESO/TzXpASpE8+3st24yaqTDxfzRBEjjYOBvYyq25E3hoM/P1Ghm6
         gPDJr3ujw2c/qaP4A4bFor1M84x4XBpdyFG1INu73+FbNOdPUMvCOeZKjQ1cTy2wGfXe
         N22g==
X-Gm-Message-State: ACrzQf0lbgPa9dzMtb9ZhRMxwYr2uH71cMwVlyKZy5UmepUjQX+kvVFl
        XZ/KpAnxdfbdUSDRljweXh/XXB2lhAC6pm84i4czVAngnu/g+SyE4zWm2nyc2oF9l4ZPEu1ggFs
        ZkeO3/N8HzFkvQBgeDXCIG44=
X-Received: by 2002:a05:600c:1e26:b0:3cf:a26c:40fd with SMTP id ay38-20020a05600c1e2600b003cfa26c40fdmr4425829wmb.178.1667746989135;
        Sun, 06 Nov 2022 07:03:09 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6NP1vK4TMXUboRquP6+tSCh+AHzV6sI7bY14Puj2TBtcfA0pN9gttJH+/Bjw9GwN8u/+dMhg==
X-Received: by 2002:a05:600c:1e26:b0:3cf:a26c:40fd with SMTP id ay38-20020a05600c1e2600b003cfa26c40fdmr4425807wmb.178.1667746988895;
        Sun, 06 Nov 2022 07:03:08 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b003cfa3a12660sm9045872wms.1.2022.11.06.07.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 07:03:08 -0800 (PST)
Date:   Sun, 6 Nov 2022 15:03:07 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 18/30] module: Use kstrtobool() instead of strtobool()
Message-ID: <20221106150307.ti4xd6ehh4ce2e25@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <bb37ff26b0c748d0ca883d8f301190cd1177aad2.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb37ff26b0c748d0ca883d8f301190cd1177aad2.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-11-01 22:14 +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is part of a serie that axes all usages of strtobool().
> Each patch can be applied independently from the other ones.
> 
> The last patch of the serie removes the definition of strtobool().
> 
> You may not be in copy of the cover letter. So, if needed, it is available
> at [1].
> 
> [1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
> ---
>  kernel/module/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index ff2dfd1f548d..79e17522e196 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -17,6 +17,7 @@
>  #include <linux/fs.h>
>  #include <linux/kernel.h>
>  #include <linux/kernel_read_file.h>
> +#include <linux/kstrtox.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/elf.h>
> @@ -2649,7 +2650,7 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
>  	int ret;
>  
>  	if (strcmp(param, "async_probe") == 0) {
> -		if (strtobool(val, &mod->async_probe_requested))
> +		if (kstrtobool(val, &mod->async_probe_requested))
>  			mod->async_probe_requested = true;
>  		return 0;
>  	}
> -- 
> 2.34.1
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin

