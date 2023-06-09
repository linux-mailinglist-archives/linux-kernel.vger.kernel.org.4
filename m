Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0E1729095
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjFIHJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238171AbjFIHJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:09:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690D32718
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:09:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f736e0c9b1so14575535e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686294588; x=1688886588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsUQxZYRm+804TG3N1NYOiAFj4oUnWWH+PPkf8kpyCs=;
        b=VIBeOPX778pkEi8zOAzk6+hv5PLrC1ZtogIuZjhoXxFpnbjU/hp0aFNWSXmeX4nClC
         6YR2GP9F/VLX+TgF5MF7f9Y6WS5hOsc7zJV6hM00rBm/qc05Bcd5svzc735aEF1S4nVw
         iVg4oTBUDBHuUUHHFUu1iKRQUBBsVzNSiHwh/Wh+jUJT38hojkoII0YWq1Qo2qeRQMUz
         PZ9hwiD8McSoGcj+yg6ctHsCEfKvI5HfUGsPx9OSF1ZC2au9qod2u3gXOCE6cXgPOxxL
         t4Ye29lkx/eOQBSQvCM+FHSlLDsA+A8OfFiq8UODA2D1VsSCkaJKAji+YMLtQD+crUNR
         B+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686294588; x=1688886588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsUQxZYRm+804TG3N1NYOiAFj4oUnWWH+PPkf8kpyCs=;
        b=U5sl/jxspAHG6JUtX6XkxbRiqIfZx4iLZSvfggMG55dLvKQd2ZSVATe5kAQ0qshiyw
         kDcpmNWZ4gH3uxhI+mSllH+ixuS2/w0t9rg1sL11Hul+m4+cfGfJChRMq0IZXgrkLLhO
         Oz/oGVLbpCIChUyvx3DTL31N9Jb/hdMXxpY8HGmy21v88hrGhT4CmYCn/FEUnwBOzl9r
         tFkGZlqf/MFWKoPVHXJbDmY7RxHdZ+GHM30yJ8pRYn+1DEWYunPXW+9dQwmqnWyNw9sg
         Ffhq6SQugPw/yAHA9x8snneZ5taKUttIsld0FIK7rwf1ixMfmCXt2G3Kvs/fxQmPpwSP
         UOEg==
X-Gm-Message-State: AC+VfDxHbNojrGHUZtBUqpJWcDzrgKFKZN/ryaql8Ek8s9/lqkpPctqJ
        EsxW5VvWZf/+bAvBPQJKop4=
X-Google-Smtp-Source: ACHHUZ4KDnBu20Tppnxd5dpmGGJ8FvdL0jIqd/GV6xV8fA48gDuCgqM1fS5Dbc+TFZxhgm7cQTL+Qw==
X-Received: by 2002:adf:f48f:0:b0:30a:9014:838d with SMTP id l15-20020adff48f000000b0030a9014838dmr462883wro.11.1686294587518;
        Fri, 09 Jun 2023 00:09:47 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id q2-20020adffec2000000b0030632833e74sm3600386wrs.11.2023.06.09.00.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:09:46 -0700 (PDT)
Date:   Fri, 9 Jun 2023 08:09:45 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "open list:VMALLOC" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] mm/vmalloc: Replace the ternary conditional operator
 with min()
Message-ID: <832d7c69-ffd5-4764-8ffe-3a02bef0efb0@lucifer.local>
References: <20230609061309.42453-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609061309.42453-1-luhongfei@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 02:13:09PM +0800, Lu Hongfei wrote:
> It would be better to replace the traditional ternary conditional
> operator with min() in zero_iter
>
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 29077d61ff81..42df032e6c27
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3571,7 +3571,7 @@ static size_t zero_iter(struct iov_iter *iter, size_t count)
>  	while (remains > 0) {
>  		size_t num, copied;
>
> -		num = remains < PAGE_SIZE ? remains : PAGE_SIZE;
> +		num = min(remains, PAGE_SIZE);
>  		copied = copy_page_to_iter_nofault(ZERO_PAGE(0), 0, num, iter);
>  		remains -= copied;
>
> --
> 2.39.0
>

Looks good to me, thanks,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
