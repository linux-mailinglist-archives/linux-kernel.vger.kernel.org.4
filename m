Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2478870E01C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbjEWPOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbjEWPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:13:58 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC21A4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:13:41 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4eed764a10cso8178423e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684854753; x=1687446753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pq6A8hjAXuW6QduZxpJjlroh6Zzvo1r22L0X16yWMNU=;
        b=qrvITLE41FYdRADXj5t2RiPbwfhl/E/Fpj1Ve/+vGVELXDWQW+xXkesUiRGFoBZK7K
         WHj9XXEwJZ0htvvv7F7gsWmh4Tz8UVtsmGFZp0WtftmwKstEcKmUOKRlPj1cGh39F3PO
         Zd5cKfsGqWhokLLC7LF3+CvVEjKRUQw43hrk72/wkrzC0GGupeWd+aHRr1ZtnM+a8xmJ
         SeIOVHy10BPycFAtu4P46FItP2nyQAsGHHtAjKEVuIz1oCXtpj+bwct+90ARazmvl4sm
         FL4PSaZ2V8UEiI3wkc2HL44zLIs+VYeVjgN9SE0YGtWmKCk6AonEauR7t2phSowt3pXV
         iZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684854753; x=1687446753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq6A8hjAXuW6QduZxpJjlroh6Zzvo1r22L0X16yWMNU=;
        b=Ghc8yBYA35t5re2somWB4ikEDSj2NtywGU++2gt/iiVDWFqM4CSWWITmFLmXbdc46s
         ArI8cjY9FlbnzrD4jPGSoXNpSC2gFp8G6M1FG5rvn5mNavsrjKDOzyMC3XnB/DMZzZSq
         SwshomBfUF4Vb3eUvU+V4lwMUxy36ksDNRc4qce2XCQzJtDooBOEd9JvdA7QRnLotuEN
         w4qJpnQFr23Jq5xF18nF+z8tvgvZZIjQgeFtSKsawAvkBjlZ8OZFware4KCVw+uSzq/t
         nuo2I8OzZdsKKrPl5CGBTFGC71JQdU9Sg8mnkuVM8l8zXRgN1CtwMltsBvhxAfOgUdmb
         6dcQ==
X-Gm-Message-State: AC+VfDxI0jBknab5buVtlBAL7j+AHorj4/pGfIJL6Vxcz4BFb189QS+d
        Ts15MXtMbottE1KFthFmhkc=
X-Google-Smtp-Source: ACHHUZ66zIV8ytIKAe460yHt/3Wcypv69k5r3Y0Fc5gQE5tdr5oMlGTwVtmBN98sNrb43tfMilDzAQ==
X-Received: by 2002:a19:f519:0:b0:4f3:af46:1941 with SMTP id j25-20020a19f519000000b004f3af461941mr3963289lfb.34.1684854753092;
        Tue, 23 May 2023 08:12:33 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id c18-20020a197612000000b004f3b520e0adsm1370711lff.107.2023.05.23.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:12:32 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 23 May 2023 17:12:30 +0200
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 0/9] Mitigate a vmap lock contention
Message-ID: <ZGzX3vRMlGHIcYCe@pc636>
References: <20230522110849.2921-1-urezki@gmail.com>
 <ZGyqiaRnMJPFhxR6@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGyqiaRnMJPFhxR6@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 08:59:05PM +0900, Hyeonggon Yoo wrote:
> On Mon, May 22, 2023 at 01:08:40PM +0200, Uladzislau Rezki (Sony) wrote:
> > Hello, folk.
> > 
> > 1. This is a followup of the vmap topic that was highlighted at the LSFMMBPF-2023
> > conference. This small serial attempts to mitigate the contention across the
> > vmap/vmalloc code. The problem is described here:
> > 
> 
> Hello Uladzislau, thank you for the work!
> 
> > wget ftp://vps418301.ovh.net/incoming/Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf
> 
> I ran the exactly same command but couldn't download the file, did I
> miss something?
> 
wget ftp://vps418301.ovh.net/incoming/Mitigate_a_vmalloc_lock_contention_in_SMP_env_v2.pdf

Sorry, i renamed the file name :)

> $ wget ftp://vps418301.ovh.net/incoming/Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf
> [...]
> ==> PASV ... done.    ==> RETR Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf ... 
> No such file `Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf'.
> 
> > The material is tagged as a v2 version. It contains extra slides about testing
> > the throughput, steps and comparison with a current approach.
> > 
> > 2. Motivation.
> > 
> > - The vmap code is not scalled to number of CPUs and this should be fixed;
> > - XFS folk has complained several times that vmalloc might be contented on
> >   their workloads:
> > 
> > <snip>
> > commit 8dc9384b7d75012856b02ff44c37566a55fc2abf
> > Author: Dave Chinner <dchinner@redhat.com>
> > Date:   Tue Jan 4 17:22:18 2022 -0800
> > 
> >     xfs: reduce kvmalloc overhead for CIL shadow buffers
> >     
> >     Oh, let me count the ways that the kvmalloc API sucks dog eggs.
> >     
> >     The problem is when we are logging lots of large objects, we hit
> >     kvmalloc really damn hard with costly order allocations, and
> >     behaviour utterly sucks:
> 
> based on the commit I guess xfs should use vmalloc/kvmalloc is because
> it allocates large buffers, how large could it be?
> 
They use kvmalloc(). When the page allocator is not able to serve a
request they fallback to vmalloc. At least what i see, the sizes are:

from 73728 up to 1048576, i.e. 18 pages up to 256 pages.

> > 3. Test
> > 
> > On my: AMD Ryzen Threadripper 3970X 32-Core Processor, i have below figures:
> > 
> >     1-page     1-page-this-patch
> > 1  0.576131   vs   0.555889
> > 2   2.68376   vs    1.07895
> > 3   4.26502   vs    1.01739
> > 4   6.04306   vs    1.28924
> > 5   8.04786   vs    1.57616
> > 6   9.38844   vs    1.78142
> 
> <snip>
> 
> > 29    20.06   vs    3.59869
> > 30  20.4353   vs     3.6991
> > 31  20.9082   vs    3.73028
> > 32  21.0865   vs    3.82904
> > 
> > 1..32 - is a number of jobs. The results are in usec and is a vmallco()/vfree()
> > pair throughput.
> 
> I would be more interested in real numbers than synthetic benchmarks,
> Maybe XFS folks could help performing profiling similar to commit 8dc9384b7d750
> with and without this patchset?
> 
I added Dave Chinner <david@fromorbit.com> to this thread. But. The
contention exists. Apart of that per-cpu-KVA allocator can go away
if we make it generic instead.

> By the way looking at the commit, teaching __p?d_alloc() about gfp
> context (that I'm _slowly_ working on...) could be nice for allowing
> non-GFP_KERNEL kvmalloc allocations, as Matthew mentioned. [1]
> 
> Thanks!
> 
> [1] https://lore.kernel.org/linux-mm/Y%2FOHC33YLedMXTlD@casper.infradead.org
> 

Thanks!

--
Uladzisdlau Rezki
