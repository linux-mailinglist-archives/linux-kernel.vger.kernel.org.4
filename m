Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB3D6E7ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjDSPph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjDSPp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:45:27 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099183D8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 08:45:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a6c5acf6ccso807855ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681919126; x=1684511126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEHsp/PftxgGG+dOP5PjPgVgG9Shed1+WVF9tmfiETc=;
        b=MEEeva94mw7AnI55MJd2s50/iifa8KK0DOcT/kHUGEx5vJl4onpifoQvkNx9kcCpZs
         +9yj9/SiEPMuSwd5n5uwi0H/eouzwXGOSBvyXcF/dm6LGND3QSiaGZ5Ydn+qsL/KcCgV
         Sz+Hte6bF8SFmopgONlnZi8seybfhFaScauYdA68z4i84zwhs52COrp+bnB47wvM2izl
         1mFW0NNJeWG7IOyLwQm/4HqSLg3WZAlvEjcaOvjaPcL80RHPHGQyn5BjqOjykm1vGIl3
         /PGlF+gqaGgy3P7Osvu9mZLrWHQskMczhGKVdBlrcljnAVlvONw9PUjJFTmVd9HAVuuy
         7vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681919126; x=1684511126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEHsp/PftxgGG+dOP5PjPgVgG9Shed1+WVF9tmfiETc=;
        b=R94Wzy1PP0ZhNZhqObSJ6QOZwkdZfzLuFdgAb6LvvkNP/OzPkBzhXBoWIaEu4FYUnX
         gIbi4UOX8eN4lmqCEwA7T9PA5ZVgIAfUTtUYxXBESJMKwiwUoYgVDIwJNyeJs1dT6nFP
         MV2rngsLFjeUjhoSS/Ju8VhyZlMDDAPtRt193IVCDBPlWxgWNDgL6mN/fPWz8s2VAB2W
         3UOngkFUtCdZ/z94IhC1HKCXg+3D6fBPMmzlMUZGLLqe3hRyXQQSAf1vPRU0V16CUdoF
         OkMOOH3NAyGDA9osqfFbgad7kTjmu8F4pf5941Kh9KGM0aIqjX5tVKnlthFQOfNpYPK/
         Ujlg==
X-Gm-Message-State: AAQBX9felyLA66kUkr+ppowcy1/SxBSrQhRGWc6kAr9m8epOlAa09aS2
        5nSZbNneivLKn1qVGoXWsG8=
X-Google-Smtp-Source: AKy350bPk5Q6bvI/a8dfRVY/DTW+0ynmOmQEkJ9Xoa73JX6dUetswKs7g/NJ52uSxIj7oUSML1zm/w==
X-Received: by 2002:a17:902:a98b:b0:1a1:c7b2:e7c7 with SMTP id bh11-20020a170902a98b00b001a1c7b2e7c7mr5789994plb.49.1681919125688;
        Wed, 19 Apr 2023 08:45:25 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902eb4b00b001a19196af48sm676102pli.64.2023.04.19.08.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:45:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 19 Apr 2023 05:45:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] workqueue: Automatically mark CPU-hogging work items
 CPU_INTENSIVE
Message-ID: <ZEAMkyXxq_vbQpxe@slm.duckdns.org>
References: <20230418205159.724789-1-tj@kernel.org>
 <20230419014552.1410-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419014552.1410-1-hdanton@sina.com>
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

Hello,

On Wed, Apr 19, 2023 at 09:45:52AM +0800, Hillf Danton wrote:
...
> Need to wake up another worker in case the current one with
> WORKER_CPU_INTENSIVE set is going to sleep with works left behind.

Please see below.

> > +
> > +		pool->nr_running--;
> >  	}
> >  
> > -	pool->nr_running--;
> >  	if (need_more_worker(pool))
> >  		wake_up_worker(pool);

That's what this block is for.

Thanks.

-- 
tejun
