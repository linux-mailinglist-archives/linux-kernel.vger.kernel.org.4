Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1216BF6A0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCQXsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQXsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:48:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BD5B7D8C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:48:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g18so4286786wmk.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679096900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGZ/mr6EHYv8LD66gdjsMBJnOYoWeKXNL/XChhAzOgI=;
        b=BLGuVkFj8L74wSWvgjbfFO1XE4RUU4mGZxiaCC3fX09Xh+ySzuBnX101ONeQeNJCAx
         qQdvdWoXlauZjmUgNW5YN5J60dNSsetRC93L9dxL4xf5hNAi6sNi2BjjFXD0ZBhIbRvF
         8dMK7T11COsnwNEg0uJX0+otzx/9+k8MIeEg4/HHo2TS4RTBjLpdmZ9e1U54ELLibplz
         43XfWmVA2pHmFKOhkoEt8n343iAt0v9osLBtNLz+JOzXroLPEE2Pkx82Ds1RTQZ7eW2Y
         EpCCbwU+UYCpkEEZfbdJn2Cq8xWgdP718rnrNQrUfFxOMw4fyeW+Cm2qrQx/ixkCaMAq
         4lJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679096900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGZ/mr6EHYv8LD66gdjsMBJnOYoWeKXNL/XChhAzOgI=;
        b=gX7pagfNuIMGvFfwsxChQOYsTk3lwtIc5a9nO3Czk6/2/SJhEqeicjmJsn2Q1ubo1+
         zk3lHknQKddWEPGGS7CWmSROmN1erfCL9pbjsO6IHHaEl3wK0hxkXEsmQbVNy61jhEDa
         hCegVqfHKN78jrPsNPF+sooO4R7bSmh4VC6tpez1PKHxE+FsvtlnGE98Pe9sFTIm6oBR
         9dydPbR3w1iy7QjX2yivscL3qMIZSYB5bI8t62Av6RzKAu8Dbrpr2qAhmStln2IooN/f
         R4rKiAFxo/a9VJB6674/WSrvFczpn4D7jaxoThFQ9q6u0CmkeFF0RU9ooDwYDJSuHujj
         KCqg==
X-Gm-Message-State: AO0yUKUAReGID/hRihU63HKcuuhO9HH19XksyaTP12sTW94RUecUdpBq
        r1R5uHpy7LdCHmiYJDaTjdCbmMVrL5k=
X-Google-Smtp-Source: AK7set8JXyByIOhAoDkwpihCiGd4xGld/iiQx1XbkkZH56aBn8iu3ZqZ3F9POrbDUdy4eivRQiBgEQ==
X-Received: by 2002:a1c:6a0e:0:b0:3ed:6087:19fe with SMTP id f14-20020a1c6a0e000000b003ed608719femr6473925wmc.21.1679096899691;
        Fri, 17 Mar 2023 16:48:19 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003e21f959453sm3204847wmc.32.2023.03.17.16.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 16:48:18 -0700 (PDT)
Date:   Fri, 17 Mar 2023 23:48:17 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 0/2] Refactor do_fault_around()
Message-ID: <98fc8545-6bd3-4c06-9b12-d781a19982ac@lucifer.local>
References: <cover.1679089214.git.lstoakes@gmail.com>
 <20230317163936.06d9c7d032a5c2296075caa1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317163936.06d9c7d032a5c2296075caa1@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 04:39:36PM -0700, Andrew Morton wrote:
> On Fri, 17 Mar 2023 21:58:24 +0000 Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>
> > Refactor do_fault_around() to avoid bitwise tricks and arather difficult to
> > follow logic.  Additionally, prefer fault_around_pages to
> > fault_around_bytes as the operations are performed at a base page
> > granularity.
> >
> > I have run this code against a small program I wrote which generates
> > significant input data and compares output with the original function to
> > ensure that it behaves the same as the old code across varying vmf, vma and
> > fault_around_pages inputs.
>
> Well, what changes were you looking for in that testing?

That there was no functional change between this refactoring and the existing
logic.

> do_fault_around() could become a no-op and most tests wouldn't notice.
> What we'd be looking for to test these changes is performance
> differences.
>
> Perhaps one could add a tracepoint to do_fault_around()'s call to
> ->map_pages, check that the before-and-after traces are identical.
>
>
> Or, if you're old school and lazy,
>
> 	if (!strcmp(current->comm, "name-of-my-test-program"))
> 		printk("name-of-my-test-program: %lu %lu\n",
> 			start_pgoff, end_pgoff)
>
> then grep-n-diff the dmesg output.

I am both old school and lazy, however I went so far as to literally copy/paste
the existing code and my speculative change to a userland program, generate a
whole host of random sensible input data and compare output data with this and
the original logic en masse.

This function is actually quite nice for testability as the input and output
variables are limited in scope, vmf->address, vmf->pgoff, vmf->vma->vm_start/end
+ vmf->vma->vm_pgoff and output start_pgoff, end_pgoff.

I could attach said program but it's some quite iffy C++ code that might horrify
small children and adults alike...

I am more than happy to do performance testing to see if there is any impact if
you require?
