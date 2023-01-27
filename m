Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5367EF0C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjA0UBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjA0UA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:00:29 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE875795
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:58:49 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1442977d77dso7918268fac.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGtGk71zGBq3lMRp+2nfXAsNyIB3Tg451dHzgKe0ygE=;
        b=rTRZgCEMqxDZZQtwYBIxe7lMvanr0HPHINPBJy8mn24Gt2Vwi0hKR19YjCcCwHKhR+
         qCU75K0sN7Pselifv3VWsdAinNXtC4RuieESziPMvtfOd3G4GXSuJ9TNTi3oIYgbQwK6
         SuzG/Nm5344HbwGnc+IIA3hiVC8MQwY3Ciuf+iHOmtvUljDIkFqEkGEA1B51Pj6emsFO
         KtEFE6ivAI2UBCdkmhyJB40bYnk7DmY//9OnAIdRK9xE8nN4X05AZcf/o4JqclOoqbVz
         zda8KmpKo7+GOhd2S21wHZcyAZUo/Pak9x1LPxRsl6D1ZVO+W3+LtQTYKtYWa8bXDI5x
         Ib2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGtGk71zGBq3lMRp+2nfXAsNyIB3Tg451dHzgKe0ygE=;
        b=X7NhZ5mbZwhOUPqt0pdv+vaoXFIgDS4XYVYxcNA9AhEx/eYpDWawLfPFQhJDaDuTdM
         Mo5VHwTDuQoW69W9zcwD+Z4hOszl0GbvIotmwEuePWGSlkr6UZPPtKlGYXqkzrMP0rrr
         Y7Gn5f6mTRulFKM8grApQzSGm76Fsyclzc+AcxeqLQ4+XR2lo4RO37GDX/35k+uYabsJ
         705LZ9LuzJxY7BzV8V5Z3i6xmaLLV2BEQ3fQheiDwStSE9NVEHrMq2aSIR2A9/UiuwRn
         6S0ttzAEO15vO6d7/BCxPyuvU0FdS/yQOoLcstMh5KGcPvTVYn0cArTFvtuliQWNwH/X
         GI0A==
X-Gm-Message-State: AFqh2kp6/rL2mT+enwtKGMJbinPUryzC/rCFJ1/7XPw2l7Bqyb4YlwPA
        qLLoCEOjBaY7Uvz1pU3nTTvEhzG3ApAMQBst
X-Google-Smtp-Source: AK7set9mH6lkfiOCeI5h7s8FdfEmtzefaanv+gMBh4QOE+JctEJatgpymLRSdS/YrdbWNxuNwgwWqg==
X-Received: by 2002:a05:622a:1181:b0:3b8:2e36:9d24 with SMTP id m1-20020a05622a118100b003b82e369d24mr2655604qtk.50.1674848789969;
        Fri, 27 Jan 2023 11:46:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:c833])
        by smtp.gmail.com with ESMTPSA id y8-20020ac87048000000b003b5bc7a4512sm3290836qtm.26.2023.01.27.11.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:46:29 -0800 (PST)
Date:   Fri, 27 Jan 2023 14:46:28 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-api@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v8 2/3] cachestat: implement cachestat syscall
Message-ID: <Y9QqFJUFo1RAbIqP@cmpxchg.org>
References: <20230126175356.1582123-1-nphamcs@gmail.com>
 <20230126175356.1582123-3-nphamcs@gmail.com>
 <54c8ecbd-1d6e-40f1-af30-7efd04c63a7e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54c8ecbd-1d6e-40f1-af30-7efd04c63a7e@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 04:46:38PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 26, 2023, at 18:53, Nhat Pham wrote:
> >
> > SYNOPSIS
> >     #include <sys/mman.h>
> >
> >     struct cachestat {
> >         __u64 nr_cache;
> >         __u64 nr_dirty;
> >         __u64 nr_writeback;
> >         __u64 nr_evicted;
> >         __u64 nr_recently_evicted;
> >     };
> >
> >     int cachestat(unsigned int fd, off_t off, size_t len,
> >           unsigned int cstat_version, struct cachestat *cstat,
> >           unsigned int flags);
> 
> Is this "off_t off" argument intentionally limited to the old
> 32-bit type on 32-bit architectures? Unfortunately I fear 
> there are no good options to pass an offset here:
> 
> - if you make it a 32-bit type, this breaks calling it from
>   normal userspace that defines off_t as a 64-bit type
> 
> - if you change it to a 64-bit loff_t, there are three
>   separate calling conventions for 64-bit, 32-bit with
>   aligned register pairs and other 32-bit, plus you
>   exceed the usual limit of six system call arguments

That's a good point, thanks for raising it, Arnd.

> A separate problem may be the cstat_version argument, usually
> we don't use interface versions but instead use a new
> system call number if something changes in an incompatible
> way.

I suppose from a userspace POV, a version argument vs calling a
separate syscall doesn't make much of a difference. So going with
loff_t and dropping cstat_version seems like a sensible way forward.

As an added bonus, versioning the syscall itself means the signature
can change in v2. This allows dropping the unused flags arg for now.

That would leave it at:

  int cachestat(unsigned int, loff_t, size_t len, struct cachestat *cstat);

and should we ever require extensions - new fields, flags - they would
come through a new cachestat2().

Would anybody have objections to that?
