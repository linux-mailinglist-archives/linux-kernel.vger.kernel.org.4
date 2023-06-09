Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D954F7293A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbjFIItI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbjFIIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:48:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5710B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:48:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so1854432e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686300526; x=1688892526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSGqb02gzoaEjtKR6JU66NNivYp/3SwH4FmhCExXxIE=;
        b=rJc//ty17aedU5JQdky1ceN1yEvT+ypVHFV8MnwcfbRyjg4Hi5lmq4mt93HSVJwwYA
         6OULR2YfWn1tkeiRjxX4t7FwXmfOdGi2vlqvfEqBcIj4OmI1v1Niwial/LIsLOAj8NFp
         5blY6UoGvEPP5QzLaKqb8Y7/lULPmDIjI2eaKMB/T6AGRq6/Tjic5qHp4ateXgEZq22Z
         GzwrxV7DIPYML7f4B50SXd1SNswEg4GOcdRJ4Vp+ieaEHcKxCm/7zwBNX9V8KsgWcLxo
         eyfizkHCl99g5U81fg4IGjyUCQpSiNIxchJb6eXRoGXZgfqmWkH+9bMqNjz9xjRWCoYH
         UoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686300526; x=1688892526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSGqb02gzoaEjtKR6JU66NNivYp/3SwH4FmhCExXxIE=;
        b=ao4w42QDuPToMN9GAx03rO+RHfXqYi4sMvlg07vKBDXq34QrfPMdHwTmee9I/xJjlb
         pCKZUpNjvnpbElpFRm4YuRddtjZO1+h6VsBwzoR9S5OcO70BecC7vM2f6UJ5rt77VimS
         8yCg3cS0oZU7bYUHvtKVqPE/ReA9ltZTIP19z+OdpqolIhwHXa7CDE1hw2mSoJVkOV92
         +2Yosbsce3mrjyj8aPNQy+eAc4kH/j3p11KFNO/GjTTBAIuuWJuHT2BAVK2gt3a2GNOu
         Ic6e86yrk1amMGdRDR5ekFmjcrT4W4QeGC3Y/7Vgs201LkLdnd3kJadmY2PVatNEbJmZ
         7qHg==
X-Gm-Message-State: AC+VfDwalLxWpy2B0zJZ/UEVBGWApuiPR44sABmX5/v0eE1oMrBq3EZ5
        GuXTR+vRuFM9X9s1QFMZeqA=
X-Google-Smtp-Source: ACHHUZ45QRL6crB+3utek4atjv3kIidZdpGzBDG6SbAMc8bVK42uK/blVBB64NKZxVvw26ozHHbuDA==
X-Received: by 2002:a05:6512:205:b0:4f2:74d3:8996 with SMTP id a5-20020a056512020500b004f274d38996mr390574lfo.8.1686300525546;
        Fri, 09 Jun 2023 01:48:45 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id f16-20020a1c6a10000000b003f60fb2addbsm1922377wmc.44.2023.06.09.01.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:48:44 -0700 (PDT)
Date:   Fri, 9 Jun 2023 09:48:44 +0100
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
Message-ID: <3fc87d60-4e81-4f49-95f0-0503ad5cdf35@lucifer.local>
References: <20230609061309.42453-1-luhongfei@vivo.com>
 <832d7c69-ffd5-4764-8ffe-3a02bef0efb0@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <832d7c69-ffd5-4764-8ffe-3a02bef0efb0@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 08:09:45AM +0100, Lorenzo Stoakes wrote:
> On Fri, Jun 09, 2023 at 02:13:09PM +0800, Lu Hongfei wrote:
> > It would be better to replace the traditional ternary conditional
> > operator with min() in zero_iter
> >
> > Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> > ---
> >  mm/vmalloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 29077d61ff81..42df032e6c27
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3571,7 +3571,7 @@ static size_t zero_iter(struct iov_iter *iter, size_t count)
> >  	while (remains > 0) {
> >  		size_t num, copied;
> >
> > -		num = remains < PAGE_SIZE ? remains : PAGE_SIZE;
> > +		num = min(remains, PAGE_SIZE);

OK, as per the pedantic test bot, you'll need to change this to:-

num = min_t(size_t, remains, PAGE_SIZE);

> >  		copied = copy_page_to_iter_nofault(ZERO_PAGE(0), 0, num, iter);
> >  		remains -= copied;
> >
> > --
> > 2.39.0
> >
>
> Looks good to me, thanks,
>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

Please spin up a v2 with this change and then you can take my Reviewed-by tag :)

Cheers, Lorenzo
