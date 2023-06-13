Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A56E72DAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbjFMHau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbjFMHae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:30:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A21AA;
        Tue, 13 Jun 2023 00:30:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-653bed78635so3609088b3a.0;
        Tue, 13 Jun 2023 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686641433; x=1689233433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8COXtLnoxqKO/UVgznx3PizNzdhIHH08suKe+/FukvM=;
        b=Phfgf+Kn6vOdmI0WQXgPL5TtrrjKKKA+V9Y32ZJ9j+4W2u8xGU/1JAq7TVxUGQily7
         kMpJQM1oS/dC59GoXwQxci4r5V/7ksEF/ITO5uUKJDi99YjjGmIUvua0AYRDeik6P1JS
         VahAR4+A2xU4eMWFLfAtW8SXCPWGwckY89dGjY2i4LI9FGz1MeEJm4xe8eG3T9OS2uOI
         G5mLEZLQ/6RamJYenR+VYMJ3m/I0r3kF4TYRI9gMkx8mbKufgkMkkXaEqNUnKycwt4yb
         Y+kuIDrNeqqdbqEHBBvbbJsMjHV7BCMb3qeoUhZ6FJQyCak6E9RUxly2yDdBdMvFGNNS
         WrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686641433; x=1689233433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8COXtLnoxqKO/UVgznx3PizNzdhIHH08suKe+/FukvM=;
        b=SXZGSx7FFJZnxwCfxoi0K1MsGCSgGEoF2TqjtoXYUOAabPCKtm65B3uZHbR10fkBC7
         GriKsHaAHTgmQwgc2vehxtcyotPFIsGfrvWEFGxiQX/M9PajO7uGBYuc+g6YgJy2ZDW9
         NBqOfbVR23ozWSY/D1zLUDspW2osqlt3CD7V2o5AKJi3QV/6xbYu9MlTZi5CD6G/sJDL
         NJL5O1qHV1EQOKP0QsY/xi9dl0EZiFRU+nrkBtfYg/iJaFBP7GFIKR/FFQ7JCNTQBDkZ
         pHI6KzDsBM8dqf6WmMI9kh2AeU4RlZFYXxXsvBeWK97pRfBOf5SMYCIh7ueSGwJULMRp
         grgw==
X-Gm-Message-State: AC+VfDyicTQ+WkhRXr+Vq+Zv5nymAxQeFnk8W1ANWbKVk8yKbpyyf44V
        SrLJvuCxdg60oS3fiYC6JL8=
X-Google-Smtp-Source: ACHHUZ6IxFfVA1hn0Evy8F7GvBORebD0/1ULQgfZ7QrbFoAX5Uw4TRrYnpbz0z50lk8Ns8W2kmE5Qw==
X-Received: by 2002:a17:90a:9b89:b0:25c:186b:8f76 with SMTP id g9-20020a17090a9b8900b0025c186b8f76mr1284228pjp.4.1686641432702;
        Tue, 13 Jun 2023 00:30:32 -0700 (PDT)
Received: from sumitra.com ([117.199.173.64])
        by smtp.gmail.com with ESMTPSA id be7-20020a170902aa0700b001b1920cffd5sm9407400plb.267.2023.06.13.00.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:30:32 -0700 (PDT)
Date:   Tue, 13 Jun 2023 00:30:20 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] lib/test_bpf: Replace kmap() with kmap_local_page()
Message-ID: <20230613073020.GA359792@sumitra.com>
References: <20230612103341.GA354790@sumitra.com>
 <3744835.kQq0lBPeGt@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3744835.kQq0lBPeGt@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 01:49:56PM +0200, Fabio M. De Francesco wrote:
> On lunedì 12 giugno 2023 12:33:41 CEST Sumitra Sharma wrote:
> > kmap() has been deprecated in favor of the kmap_local_page()
> > due to high cost, restricted mapping space, the overhead of
> > a global lock for synchronization, and making the process
> > sleep in the absence of free slots.
> > 
> > kmap_local_page() is faster than kmap() and offers thread-local
> > and CPU-local mappings, take pagefaults in a local kmap region
> > and preserves preemption by saving the mappings of outgoing
> > tasks and restoring those of the incoming one during a context
> > switch.
> > 
> > The mapping is kept thread local in the function
> > “generate_test_data” in test_bpf.c
> > 
> > Therefore, replace kmap() with kmap_local_page() and use
> > memcpy_to_page() to avoid open coding kmap_local_page()
> > + memcpy() + kunmap_local().
> > 
> > Remove the unused variable “ptr”.
> 
> Sumitra,
> 
> Please Cc your mentors while in the internship.
> It's not mandatory but it would expedite comments and reviews :-)
> 

Hi Fabio,

I will take care of it.

> > 
> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > ---
> >  lib/test_bpf.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> > index ade9ac672adb..3bb94727d83b 100644
> > --- a/lib/test_bpf.c
> > +++ b/lib/test_bpf.c
> > @@ -14381,25 +14381,17 @@ static void *generate_test_data(struct bpf_test
> > *test, int sub) * single fragment to the skb, filled with
> >  		 * test->frag_data.
> >  		 */
> > -		void *ptr;
> > -
> >  		page = alloc_page(GFP_KERNEL);
> > 
> >  		if (!page)
> >  			goto err_kfree_skb;
> > 
> > -		ptr = kmap(page);
> > -		if (!ptr)
> > -			goto err_free_page;
> > -		memcpy(ptr, test->frag_data, MAX_DATA);
> > -		kunmap(page);
> > +		memcpy_to_page(page, 0, test->frag_data, MAX_DATA);
> 
> Why are you temporary mapping a page allocated with the GFP_KERNEL flag? 
> It cannot come from ZONE_HIGHMEM. 
>

Fabio, I somewhere _wrongly_ read that "GFP_KERNEL may allocate pages from
highmem". However, with further readings and checking the GFP_KERNEL
definition in gfp_types.h

#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)

I have got that with the GFP_KERNEL flag, pages can never come 
from ZONE_HIGHMEM.

Apologise.

Thanks & regards
Sumitra

> Fabio
> 
> >  		skb_add_rx_frag(skb, 0, page, 0, MAX_DATA, MAX_DATA);
> >  	}
> > 
> >  	return skb;
> > 
> > -err_free_page:
> > -	__free_page(page);
> >  err_kfree_skb:
> >  	kfree_skb(skb);
> >  	return NULL;
> > --
> > 2.25.1
> 
> 
> 
