Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BF370A5A5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 07:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjETFVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 01:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjETFVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 01:21:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF101B7;
        Fri, 19 May 2023 22:21:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f42769a0c1so40338225e9.2;
        Fri, 19 May 2023 22:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684560109; x=1687152109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YCeLgnfdNNLRbQJ3YR4Z/VQhSO2Fn36PmEIuzpNl+A=;
        b=qJMAA70oc2XzjFfK6LPciZZQX2UKttbs+TQxY35L4pb79WT5OF3+MZZGqHT4YHfuAM
         yQ9VXsEnIgwnlo2mLlA+UcY8p7lXlWs3dDK1rjLegS/JB9UMW4dKKr44A+h2KTvBFh2P
         i3lJ24kUMGsp0l97Sq/Q7+hPMOx/TH+8c1plxCa03LEupDJd9GB7Ff8Mgk9a930xkeWR
         yhmy9LwdvUrNh9FAyBb+2qNOo2FTi8zAZJZY4MZSjxDkFlJfnhrY6dT2ctcRQPcEvFbC
         uFlZ8p8+TmykOoeWdT9qmQ/HDEdELlbSRVLyxIb12w9GN0LFjpEaqHCie1vuGi3OhpSl
         ontg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684560109; x=1687152109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YCeLgnfdNNLRbQJ3YR4Z/VQhSO2Fn36PmEIuzpNl+A=;
        b=ELtLzmR/PhKTcfYIsVLpj72/NyYAvTh+jg0Wznc19s+YevRZfM5+jhvfbyBgeDiNpw
         N0Rpaa9McFsURfF3llaIMpx9qOYqY7ovtmVHs0KdJVpFQqHhlm/P0Wru2jFCm5BQFzzH
         hfR99o/0zg8ekRMoCqsjJuGDdL6yfoJdH+UvECPUdc1wDl8uxc1lk95AHgwtV3+0Eg+V
         FjbSUzt1vtfW9a9vM3xR5xnFIDKPSdzDopNxAYP/hBtlvga0oAf2lUGajod53JD6dya5
         R1mEM0DALKSnRW0//7lGQfuNQe8Lqmx+6dsT3zsmFYkel5ZNSyazC6P9FYqGsFMVZM+z
         k2OA==
X-Gm-Message-State: AC+VfDxuYiontxVIIL64FzRm89nFpG9xGFvNdC6Ylg1aL6cnn4P0r0ak
        GSKynHTmXZmNE+M8tFbhmdc=
X-Google-Smtp-Source: ACHHUZ4Eoa9xWVslykQCIhtD+WNpYCFuNO5kU1HN6r6LAMURYRyh8pv+wrNmJ053DffGSdTv1WNVTA==
X-Received: by 2002:a1c:7314:0:b0:3f4:2bce:eef8 with SMTP id d20-20020a1c7314000000b003f42bceeef8mr2763578wmb.16.1684560108575;
        Fri, 19 May 2023 22:21:48 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id l13-20020a7bc44d000000b003f42328b5d9sm1062855wmi.39.2023.05.19.22.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 22:21:47 -0700 (PDT)
Date:   Sat, 20 May 2023 06:19:37 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] [suggestion] mm/gup: avoid IS_ERR_OR_NULL
Message-ID: <1ca47b8a-292c-47ab-aa6f-ca24fdfc0d3c@lucifer.local>
References: <20230519093953.10972-1-arnd@kernel.org>
 <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
 <ZGf1hV7iEQyqAim5@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGf1hV7iEQyqAim5@ziepe.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 07:17:41PM -0300, Jason Gunthorpe wrote:
> On Fri, May 19, 2023 at 03:51:51PM +0100, Lorenzo Stoakes wrote:
> > Given you are sharply criticising the code I authored here, is it too much
> > to ask for you to cc- me, the author on commentaries like this? Thanks.
> >
> > On Fri, May 19, 2023 at 11:39:13AM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > While looking at an unused-variable warning, I noticed a new interface coming
> > > in that requires the use of IS_ERR_OR_NULL(), which tends to indicate bad
> > > interface design and is usually surprising to users.
> >
> > I am not sure I understand your reasoning, why does it 'tend to indicate
> > bad interface design'? You say that as if it is an obvious truth. Not
> > obvious to me at all.
> >
> > There are 3 possible outcomes from the function - an error, the function
> > failing to pin a page, or it succeeding in doing so. For some of the
> > callers that results in an error, for others it is not an error.
>
> No, there really isn't.
>
> Either it pins the page or it doesn't. Returning "NULL" to mean a
> specific kind of failure was encountered is crazy.. Especially if we
> don't document what that specific failure even was.
>

It's not a specific kind of failure, it's literally "I didn't pin any
pages" which a caller may or may not choose to interpret as a failure.

> IIRC if you look really closely the only time get_user_pages()
> actually returns 0 is if the input argument validation fails, which I
> think is a bug that should be fixed.

That can be a reason for gup returning 0 but also if it you look at the
main loop in __get_user_pages_locked(), if it can't find the VMA it will
bail early, OR if the VMA flags are not as expected it'll bail early.

>
> get_user_pages() never returns 0, so get_user_page_vma_remote() never
> returns NULL. Until we get there collapsing the 0 to EIO is perfectly
> fine.

Well no, as shown above actually there is a distinct third state,
i.e. couldn't pin, which if you see there is at least one case where the
caller differentiates between an error and not being able to pin -
uprobe_write_opcode() - which treats failure to pin as a non-error state.

Also if we decided at some point to return -EIO as an error suddenly we
would be treating an error state as not an error state in the proposed code
which sounds like a foot gun.

>
> Jason
