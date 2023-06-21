Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1D737818
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjFUAKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjFUAKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:10:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7191738
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:10:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so2267460b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687306241; x=1689898241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sDoj5PizcTKiqq5oaVy5xtW8w+Dir/LUc1s8hK7cyjI=;
        b=MxRfzc1vGvZjmUSK3wSSYsPaxK/+eKVXg9yUx04aYXW4w1zjS5gJiN9BRJBjGbZJ1o
         0jqovS3pviU2TkQAAUg0AvYmKyqWrE5FHICUk8VwCXpD93/jxE1QR1EcGRPgXHtOZXfI
         1klvD0X02q/kN/H0f6kUoM6rx8UcoZSI2fhhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687306241; x=1689898241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDoj5PizcTKiqq5oaVy5xtW8w+Dir/LUc1s8hK7cyjI=;
        b=Cm7HJnBWlunWNfHgB6UdQwi9hSHxnNuGdRg8kAnA32CSx1CC79ddVMloW6XXjsFC5s
         5jNRjhzsE0liUK9AiKT6/APPgcmYKkMLK08aWLse2ZF0FH1rqEISUHONLd/85Z4AxzvB
         xWaeBiB7GYoPEg7lbq8jHBToPYW095yTToNL5OuZD8JmaKhQIXaOAQtldjWN/Uqe8nzq
         ZRY5445Flpl0ocUKWhmiMQxSWBkvlStIVOkhoCwKV1pCkvUIZwSiyf/HDEiJ0fXH6Dv+
         8k4prCZTT2rMj/rnULg+d1n4nRlwfogwzHp/8RlGuM87/VY17Yp/EdVFgXLHOqinFlKJ
         DkZQ==
X-Gm-Message-State: AC+VfDxD1+TQ3di53V9HQtcRXJ9oDvCG7IZSiu65VIlOCJ5feEA1UJB/
        lJWSgKwkPU3ehVrLrDN6pRyXJQ==
X-Google-Smtp-Source: ACHHUZ7M1TXH01T8EJ1f7D/M/gWLBY5GZ2T6Wi2foAXBCD0fUUGWx06I4CB55Jn+ZXYErmZ+fgb2sw==
X-Received: by 2002:a05:6a00:24cb:b0:668:74e9:8f06 with SMTP id d11-20020a056a0024cb00b0066874e98f06mr5912743pfv.1.1687306241046;
        Tue, 20 Jun 2023 17:10:41 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id t2-20020a62ea02000000b0064d27a28451sm1789600pfh.100.2023.06.20.17.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 17:10:40 -0700 (PDT)
Date:   Wed, 21 Jun 2023 09:10:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH v2 04/16] mm: Change do_vmi_align_munmap() side tree index
Message-ID: <20230621001036.GB2934656@google.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-5-Liam.Howlett@oracle.com>
 <20230620122619.GA2934656@google.com>
 <20230620130412.lxri53iekoq6lpfb@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620130412.lxri53iekoq6lpfb@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/20 09:04), Liam R. Howlett wrote:
> > On (23/06/12 16:39), Liam R. Howlett wrote:
> > [..]
> > > @@ -2450,17 +2452,17 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > >  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
> > >  	/* Make sure no VMAs are about to be lost. */
> > >  	{
> > > -		MA_STATE(test, &mt_detach, start, end - 1);
> > > +		MA_STATE(test, &mt_detach, 0, 0);
> > >  		struct vm_area_struct *vma_mas, *vma_test;
> > >  		int test_count = 0;
> > >  
> > >  		vma_iter_set(vmi, start);
> > >  		rcu_read_lock();
> > > -		vma_test = mas_find(&test, end - 1);
> > > +		vma_test = mas_find(&test, count - 1);
> > >  		for_each_vma_range(*vmi, vma_mas, end) {
> > >  			BUG_ON(vma_mas != vma_test);
> > >  			test_count++;
> > > -			vma_test = mas_next(&test, end - 1);
> > > +			vma_test = mas_next(&test, count - 1);
> > >  		}
> > >  		rcu_read_unlock();
> > >  		BUG_ON(count != test_count);
> > 
> > Something isn't quite working, I'm hitting BUG_ON(vma_mas != vma_test)
> 
> Is this with next by any chance?

Oh yes, linux-next
