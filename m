Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF40F724B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbjFFSeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjFFSd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:33:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C01BCC;
        Tue,  6 Jun 2023 11:33:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3063433fa66so5616780f8f.3;
        Tue, 06 Jun 2023 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686076404; x=1688668404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8svzrQGUEtETEf2Gc4kOvl6Kj1C686jV3zJl9I41Yfg=;
        b=psq7lUwSkBsj+yf4R0xiNE9E7Hj9VK328d/Zic7hPh315XwjsbK9b3Oc1d5rAGSde0
         ppVJzOXmbVEi2HtzCooQfBWismtvmFIrwATUkh8fUagKL9pqQ5z28HI7b8JFY6/nQOZY
         RPtjpQUpv12BQfzc3YWu5q4/L/Ifs4jIk4VX0/GO/tIjfqY0rIRe5ZAe0JtaAsOHEF7X
         2x0Nine0BWYKULFo/+CrxUHliyCduz1kjYBLoVcoV4ny2Y3PRW1sDYs7UfMZQyIupz0q
         YxC0vfealeD+BahHSnJLuIewyXcfZpOuzZEogfwq7MDvI2EERS1D7m+uqJXoDGMk2P3Y
         f8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686076404; x=1688668404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8svzrQGUEtETEf2Gc4kOvl6Kj1C686jV3zJl9I41Yfg=;
        b=fCBuvubPmOxKGMtNNUcbnmKM7qTchsffjPiL3eozc+Q8VyAF4wm025TMJqnYkbJC6q
         jWT5TMd9l/k0yXK6hoyCYYHl5lxHM0aP8CZ+c3RbImD05a/eRNjtRWz2goADYzIWv6Pc
         Wm5U+eXExS7DsKqLIRSJmuaTi3dL81Or+dDMpoJxJNNhpLwh67Hzrj120ZT2kGfhg36e
         aRbMWqEmsuGgQwzRAruClHBFNa2DCszDOGJnpR7PbvwIkPJ9AKa12YP1k2VRHog6MdL3
         4nQVsIjnMS8Dc7qzvn9l7dJg73RETsvx8gU+NfnEceAK5F/lkmf6zeiAA5KwqlmEEwkr
         I+cA==
X-Gm-Message-State: AC+VfDz8Mqr4nVALbUgmRFkTYC68kf1HOugfKPZnfRckrJI7dDHycZcH
        62AVI6YdEfRKnR/Iu8dJxTE=
X-Google-Smtp-Source: ACHHUZ70oQJTONoOv+e8Ejv3f+oGhgElZo6FQh85YIeQDwsC1c9rks4LPF1YcUNvS1fnA0HtiBH2ZQ==
X-Received: by 2002:adf:f212:0:b0:30d:5cce:3bb5 with SMTP id p18-20020adff212000000b0030d5cce3bb5mr2461590wro.60.1686076403503;
        Tue, 06 Jun 2023 11:33:23 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c248400b003f604793989sm18503641wms.18.2023.06.06.11.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 11:33:22 -0700 (PDT)
Date:   Tue, 6 Jun 2023 19:33:22 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jeff Xu <jeffxu@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/mprotect: Fix do_mprotect_pkey() limit check
Message-ID: <acd340ca-e7e7-4cfa-adc3-8d1f6fcd76b6@lucifer.local>
References: <20230606182912.586576-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606182912.586576-1-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 02:29:12PM -0400, Liam R. Howlett wrote:
> The return of do_mprotect_pkey() can still be incorrectly returned as
> success if there is a gap that spans to or beyond the end address passed
> in.  Update the check to ensure that the end address has indeed been
> seen.
>
> Link: https://lore.kernel.org/all/CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com/
> Fixes: 82f951340f25 ("mm/mprotect: fix do_mprotect_pkey() return on error")
> Reported-by: Jeff Xu <jeffxu@chromium.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mprotect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 92d3d3ca390a..c59e7561698c 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -867,7 +867,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  	}
>  	tlb_finish_mmu(&tlb);
>
> -	if (!error && vma_iter_end(&vmi) < end)
> +	if (!error && tmp < end)
>  		error = -ENOMEM;
>
>  out:
> --
> 2.39.2
>

As discussed via irc, was able to confirm locally this fixes the reported
issue, so have a quick:-

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
