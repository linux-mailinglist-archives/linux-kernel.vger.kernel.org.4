Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD56701565
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 10:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbjEMIwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbjEMIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 04:52:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC6A7A9B
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 01:52:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f450815d02so29073195e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683967952; x=1686559952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8MeuaNjeaikYWlAFObQpd6SYPmjzbm3/sLwf1GEc+RY=;
        b=EcwUA8+Kphpwzn8PUk5mCLhFQOMkbgxjEIX/Bl8n57tE0R/QM14Zw+xrYpZCerwEVP
         CoVAV/JwzR9JlpQGig6NTFpr77dMbKeCKtvRid2RQGPhRHAMVyTFDVx7LKfGXfX5OZJf
         QhpG1meDLvDWBPXqIfP7Usoa2+RbTbo9Nd1UkJaGWr8u1uw1glcYB5kFO0ILLne3aCix
         XaSDSAfkN4jEHza0NVX/fYvzSBWom+IhUqQWiYaLfQQXft6ikECTWksxgquukbYMWPrM
         Dr6JW0vKoSnY7srpbZWFJp31gIUYC8RIRovurChq8+jHHK6sCLyy+qUXfUVhwFlhYt9y
         zmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683967952; x=1686559952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MeuaNjeaikYWlAFObQpd6SYPmjzbm3/sLwf1GEc+RY=;
        b=dMC3sQvowZUXhIFkaFPLX9TwPQoig8Ep6UaBhUgw2zv8edvr8JJDsPXlKAHjLbqmsV
         1bynpMPdMJrFEjYlH0g3naRkuBOqoois84q5fydX6CE4wyfw5J5UvgzGcZPQ6yvL1zIm
         o8//3O95+6/qAGuPg4U7Y6i5rC1Wr61y+FHKtjDPQJevIVi5CpcJhcp2KXfgEGI6c8VH
         AR7wU9G5j8WbTWPR0tnFTD+sg5sn2VqcoRSmltowGiAYuPqOSZYi5+sNzrtsXCZUgCdb
         CvZs1hcuzUXtsLPRDJAQL7tbNVgLWJLKNPx1cFpb+7eYjPeVa0rXjZh5DIQEjPNiT7BV
         32LQ==
X-Gm-Message-State: AC+VfDwbSnWFRmR93w2FxEWyLyLplQt8Y98Q2v8WOf65/IRZS2Kw4WP6
        wmJcbOyl8nRew9nMj6HyoJy+4Q1cT1K8f4c9CxY=
X-Google-Smtp-Source: ACHHUZ5nIY5bzmS3VzpDQW13VzRISq3r7LlIRkeNBmN3BdlkLkX0EdEXbVOV5pkX50j0kxNzBWaLNw==
X-Received: by 2002:a1c:cc0a:0:b0:3f4:1ce0:a609 with SMTP id h10-20020a1ccc0a000000b003f41ce0a609mr16031095wmb.3.1683967952310;
        Sat, 13 May 2023 01:52:32 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c1c0f00b003f1738d0d13sm19249411wms.1.2023.05.13.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 01:52:30 -0700 (PDT)
Date:   Fri, 12 May 2023 17:01:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: next: WARNING: CPU: 0 PID: 1200 at mm/page_alloc.c:4744
 __alloc_pages+0x2e8/0x3a0
Message-ID: <1059342c-f45a-4065-b088-f7a61833096e@kili.mountain>
References: <CA+G9fYvVcMLqif7f3yayN_WZduZrf_86xc2ruVDDR7yphLC=wQ@mail.gmail.com>
 <6c7a89ba-1253-41e0-82d0-74a67a2e414e@kili.mountain>
 <DC7CFF65-F4A2-4481-AA5C-0FA986BE48B7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC7CFF65-F4A2-4481-AA5C-0FA986BE48B7@oracle.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 01:56:30PM +0000, Chuck Lever III wrote:
> 
> 
> > On May 12, 2023, at 6:32 AM, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > 
> > I'm pretty sure Chuck Lever did this intentionally, but he's not on the
> > CC list.  Let's add him.
> > 
> > regards,
> > dan carpenter
> > 
> > On Fri, May 12, 2023 at 06:15:04PM +0530, Naresh Kamboju wrote:
> >> Following kernel warning has been noticed on qemu-arm64 while running kunit
> >> tests while booting Linux 6.4.0-rc1-next-20230512 and It was started from
> >> 6.3.0-rc7-next-20230420.
> >> 
> >> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >> 
> >> This is always reproducible on qemu-arm64, qemu-arm, qemu-x86 and qemu-i386.
> >> Is this expected warning as a part of kunit tests ?
> 
> Dan's correct, this Kunit test is supposed to check the
> behavior of the API when a too-large privsize is specified.
> 
> I'm not sure how to make this work without the superfluous
> warning. Would adding GFP_NOWARN to the allocation help?

That would silence the splat, yes.

regards,
dan carpenter

