Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FD87296A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241766AbjFIKQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242004AbjFIKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:15:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A4D49F9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:07:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b203360d93so17320221fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 03:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686305234; x=1688897234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsXlyZxQYx0ra+Pn6hnVbja5cmTXlxt076zWMBWb7Bg=;
        b=G8k8tP1defmJv6D0Ppt6lXhRm2WLO5Y6XIYQjgDlD9s8jq4XOOd9+W4DDvzAqXzJMH
         sR86W0eERAjU+F1zYFVVyHJPTuvnvGJcXFgHMmC+IC9XoHOcLf8uiBYM4c1oy6GDLGBA
         5G6WLctxMP2gQja2xn0gr7og+/QMemap3kmcrEcOPR0Xdle4TCtP+WLUNbfyAIVMbjxJ
         xSgfNsCxedAw5vrNbYlcmWoGafcrit//kqQnYnbJomqL+C8zSrvpgDg8W/lHRIzKpVHy
         VD2TfznkgEeddSxfult2qtxd7A1EZGv8cgYfmdoNDRCpFR3RxwCAIaw4/h9oI/fOus0o
         vX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686305234; x=1688897234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsXlyZxQYx0ra+Pn6hnVbja5cmTXlxt076zWMBWb7Bg=;
        b=CV35uMxGtLTt0EADFAwYv/26z1ESR1ZCmwgd8eKIt5E0Wub/x7enucMS72TZkBC4TV
         yfUMJ+Q/17pSw5mj4w9m25lvaNiM/mjS62gHUHgSgXUUyLQiU1RxebXwcbPTVmidU6zs
         7vzWBQHMk6jVjvD3p3GhHwrx1uAAho0QzdYpHELgqfQy3pMwpz8bzUhDHuL/OTzOhqxa
         BZFvNzLkDwHarHVZ/AK/oxjgND5U9IUu2/n02xzOKy+toDRo+5yoNDhYHc6nx/FdvOcI
         XP0Fm/3rZqvK0PHZWDqbmiDGCebaS1rOi7NTdvFWcU+MWAJaQUtkM+gRaq0QG7ZIcLTz
         TzoA==
X-Gm-Message-State: AC+VfDwtfYmTK5axhxqEp8BVsztGbvBMEAJW2rQ1YLQWqcSJWARCrHYL
        HWhGbncKod4fcJoFqkXSgEY=
X-Google-Smtp-Source: ACHHUZ49mbAXgGnaMDByCCCngrCB+EBS57uYdTSfOC2GVbS+t7KmqU4drp6GD6yHmjlqIZp4F21hvw==
X-Received: by 2002:a2e:3314:0:b0:2af:2231:94ba with SMTP id d20-20020a2e3314000000b002af223194bamr856221ljc.3.1686305234077;
        Fri, 09 Jun 2023 03:07:14 -0700 (PDT)
Received: from pc636 (host-90-233-211-151.mobileonline.telia.com. [90.233.211.151])
        by smtp.gmail.com with ESMTPSA id z4-20020a2e9b84000000b002a929484fa0sm320230lji.68.2023.06.09.03.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 03:07:13 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 9 Jun 2023 12:07:09 +0200
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "open list:VMALLOC" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] mm/vmalloc: Replace the ternary conditional operator
 with min()
Message-ID: <ZIL5zehSOQTTXMBn@pc636>
References: <20230609092602.26412-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609092602.26412-1-luhongfei@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It would be better to replace the traditional ternary conditional
> operator with min() in zero_iter
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 29077d61ff81..6125ed506895
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3571,7 +3571,7 @@ static size_t zero_iter(struct iov_iter *iter, size_t count)
>  	while (remains > 0) {
>  		size_t num, copied;
>  
> -		num = remains < PAGE_SIZE ? remains : PAGE_SIZE;
> +		num = min_t(size_t, remains, PAGE_SIZE);
>  		copied = copy_page_to_iter_nofault(ZERO_PAGE(0), 0, num, iter);
>  		remains -= copied;
>  
> -- 
> 2.39.0
> 
I saw a complain from the robot. Indeed the min_t() variant is better:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
