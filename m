Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7EA65DD91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbjADUUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjADUTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:19:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944091007
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:19:50 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id t17so85259825eju.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 12:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMrG6pRQj9uU5WMMg9G8Q1EjqJGq3/N3iguYlYryFrE=;
        b=e7T2gBAKfdwNbpyDXBmkOeoumL2U6dbSJ39bKxtSSLGSLytSVIzFnPEF0+al0fdR3e
         qvQaKXgdAhWcqMvJD6EErX5yz7SU/4RIm7n/JZC4W2Popxp3qeq3vRb/RZrIicSQCCkH
         nlRypaNY7j20z/gk308NzQ31W2uYPE00/R2sPgXMJdkh9eCCrN+TOgHsOfr2wmhgWCEF
         S7aYW3IbwIpZ61XNJtMX+U3d0Sj1NWq00THxqit56B+M+O5OKZ7a8krdy2YK5pR851gr
         W8zJZ14LqpWH3P1M2cQvIyXu/llspAjBXgb9hDqm5IDvubyf2K6rdc820lRmRG1iE628
         +hRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMrG6pRQj9uU5WMMg9G8Q1EjqJGq3/N3iguYlYryFrE=;
        b=mDU2f0RPLNLSIpTm10YY9Tze9RcQWHllks5yYoYaRt4JXHPg5e8X+H4mtrkXoFNRN+
         exH53pkNkwS/rNsIH2OpaA/CfeoPPlselQGhbDjVTjHkqMzFpIwAvMPbpLLXUiFidT0S
         D0PQAvw4yatyO5jTd7iLEW6+0Q+tOb7UvnjMJpi2gFTi3xwK97FfDh/VhXkIMco+swUT
         nV2loQl87rpInRJnr1CWt5/PFMSvR1kyUrx6vWtQOmq+4oBbLRdfRQJCGcMAMCPKmH1V
         cNMppQuMDZ/3O4+aXwcAp7S3N1MaZVbiSmhmpNGs9jZhcynw7Bzc08BhGNA3R3xVDDrX
         GarQ==
X-Gm-Message-State: AFqh2kqPCtka9rJmd745nsSteDPLGc8rhgrFBNnayGoTN7kOIPcYSEPC
        SWndBnfe6NS8z5vN7WiNR4cBnmRzAik=
X-Google-Smtp-Source: AMrXdXtxxXZY7wbUg7v2HwpvkSaqpv40NgTJxOtKcygs7BvBCtpX4kw1rjRsud7ncBPfXbuyC6XA+w==
X-Received: by 2002:a17:907:6746:b0:840:758a:9155 with SMTP id qm6-20020a170907674600b00840758a9155mr23141959ejc.12.1672863589099;
        Wed, 04 Jan 2023 12:19:49 -0800 (PST)
Received: from gmail.com ([31.46.243.128])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm15620070eji.130.2023.01.04.12.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 12:19:48 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Jan 2023 21:19:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] locking/qspinlock: Optimize pending state waiting for
 unlock
Message-ID: <Y7XfYPnQhLTcNZSh@gmail.com>
References: <20221224120545.262989-1-guoren@kernel.org>
 <08ce1ab6-4678-74ce-43cc-2d3f04d1525d@redhat.com>
 <CAJF2gTS52jBm7_3c=9i1uPjmV90=42xs4dOs6woA4NnHf4RHgQ@mail.gmail.com>
 <b01060ba-6069-d33e-5151-22a7d9577f13@redhat.com>
 <e30f671d-8e74-d5b9-cdba-472d7297f257@redhat.com>
 <CAJF2gTTkLY+mUoG0oqw0mmJH0hK5bXYvrmYcLL1-zwNbzOb9TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTkLY+mUoG0oqw0mmJH0hK5bXYvrmYcLL1-zwNbzOb9TQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Guo Ren <guoren@kernel.org> wrote:

> > >> The situation is the SMT scenarios in the same core. Not an entering
> > >> low-power state situation. Of course, the granularity between cores is
> > >> "cacheline", but the granularity between SMT hw threads of the same
> > >> core could be "byte" which internal LSU handles. For example, when a
> > >> hw-thread yields the resources of the core to other hw-threads, this
> > >> patch could help the hw-thread stay in the sleep state and prevent it
> > >> from being woken up by other hw-threads xchg_tail.
> > >>
> > >> Finally, from the software semantic view, does the patch make it more
> > >> accurate? (We don't care about the tail here.)
> > >
> > > Thanks for the clarification.
> > >
> > > I am not arguing for the simplification part. I just want to clarify
> > > my limited understanding of how the CPU hardware are actually dealing
> > > with these conditions.
> > >
> > > With that, I am fine with this patch. It would be nice if you can
> > > elaborate a bit more in your commit log.
> > >
> > > Acked-by: Waiman Long <longman@redhat.com>
> > >
> > BTW, have you actually observe any performance improvement with this patch?
> Not yet. I'm researching how the hardware could satisfy qspinlock
> better. Here are three points I concluded:
>  1. Atomic forward progress guarantee: Prevent unnecessary LL/SC
> retry, which may cause expensive bus transactions when crossing the
> NUMA nodes.
>  2. Sub-word atomic primitive: Enable freedom from interference
> between locked, pending, and tail.
>  3. Load-cond primitive: Prevent processor from wasting loop
> operations for detection.

As to this patch, please send a -v2 version of this patch that has this 
discussion & explanation included in the changelog, as requested by Waiman.

Thanks,

	Ingo
