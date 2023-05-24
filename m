Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1B470F371
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjEXJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEXJuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:50:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3733A1;
        Wed, 24 May 2023 02:50:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2af28a07be9so9852591fa.2;
        Wed, 24 May 2023 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684921816; x=1687513816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bIFS61j7iDPSL85BcFHlWNxY6AjWNgDQmUG8g1ETRCk=;
        b=erPEwsZP3SMwCMrsS/EXircokdB5BtnQdxFnUmKYDYxLt6lJa7p/JIUni1uEzHPenh
         mg4H4avg9/ZtIhi4jj3T+p+zg4fk6VvGlAlKYkDHPKL2uQFJvv3aONqDF0Dm3cAwMIfL
         gOHNKlzfqUd12Ypidot26YVTfqu2ebvxzpSRpcBI+BoWMQ9t6nmw2M6Pm9N+ILcrf98J
         bygtUEqMSZ005BBb5opzPqq9qL6xMtorByvFRZOZrEfICCsVlOyqDZfjVp2n66oeIsN8
         MXcIsQ4eSCKtoD+OMMedMguyxF47QN+qltyxxfjKoWsnlFVKsLvDehn7NhO3LnqYBKMa
         zA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684921816; x=1687513816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIFS61j7iDPSL85BcFHlWNxY6AjWNgDQmUG8g1ETRCk=;
        b=GSwO0asqjXicQgzpzyr2ZjyVysE393gABreBpHoJyveSgR2if95VG80D1d8WRSVvrs
         XQX8/o78T0f1juRDjtdO336LVMPpPbUlnenFCmccO5xdJy+Q6TZnyGZm83oOs2eUqmIO
         21igaFbdiuZDiL9yGAU0Jq0YGNCa+e9U9DGyWKMHTaI9zSstWcufK2FY5HgfmP081xq1
         UABFUzyf9JMS1Y6zMEGo+pdIIfBmRMlFLIe/Mh4FewH9EhwyZNm30CfiouhF9sdy/JCv
         +zWyIgKe//hbqKLePT0cehUKU6UtnmTxox9lyHYTg1+7OCCvvjQnqCFE0x5rDiSAewMR
         /QVw==
X-Gm-Message-State: AC+VfDzJrxGncaQWiVKgiLFhQ0kMwthPJ+ephS9cPG6yv8U2pnCmI08K
        IBMpWOVHwMAUEeA2Su8M2WE=
X-Google-Smtp-Source: ACHHUZ4EM5PUh0Z6UbF6nimxtZU9JpqNcBDMDxV2BFsVhit4pH91VVFq7DCBYIckGfm0xuta2qhLBg==
X-Received: by 2002:ac2:4ac2:0:b0:4f3:b1ae:311e with SMTP id m2-20020ac24ac2000000b004f3b1ae311emr4371885lfp.53.1684921815706;
        Wed, 24 May 2023 02:50:15 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id s6-20020a19ad46000000b004eff530efe7sm228459lfd.93.2023.05.24.02.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:50:15 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 24 May 2023 11:50:12 +0200
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/9] Mitigate a vmap lock contention
Message-ID: <ZG3d1FUXiCk3QL3D@pc636>
References: <20230522110849.2921-1-urezki@gmail.com>
 <ZGyqiaRnMJPFhxR6@debian-BULLSEYE-live-builder-AMD64>
 <ZGzX3vRMlGHIcYCe@pc636>
 <ZG0AE9mjHkRZIGmr@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG0AE9mjHkRZIGmr@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 03:04:28AM +0900, Hyeonggon Yoo wrote:
> On Tue, May 23, 2023 at 05:12:30PM +0200, Uladzislau Rezki wrote:
> > > > 2. Motivation.
> > > > 
> > > > - The vmap code is not scalled to number of CPUs and this should be fixed;
> > > > - XFS folk has complained several times that vmalloc might be contented on
> > > >   their workloads:
> > > > 
> > > > <snip>
> > > > commit 8dc9384b7d75012856b02ff44c37566a55fc2abf
> > > > Author: Dave Chinner <dchinner@redhat.com>
> > > > Date:   Tue Jan 4 17:22:18 2022 -0800
> > > > 
> > > >     xfs: reduce kvmalloc overhead for CIL shadow buffers
> > > >     
> > > >     Oh, let me count the ways that the kvmalloc API sucks dog eggs.
> > > >     
> > > >     The problem is when we are logging lots of large objects, we hit
> > > >     kvmalloc really damn hard with costly order allocations, and
> > > >     behaviour utterly sucks:
> > > 
> > > based on the commit I guess xfs should use vmalloc/kvmalloc is because
> > > it allocates large buffers, how large could it be?
> > > 
> > They use kvmalloc(). When the page allocator is not able to serve a
> > request they fallback to vmalloc. At least what i see, the sizes are:
> > 
> > from 73728 up to 1048576, i.e. 18 pages up to 256 pages.
> > 
> > > > 3. Test
> > > > 
> > > > On my: AMD Ryzen Threadripper 3970X 32-Core Processor, i have below figures:
> > > > 
> > > >     1-page     1-page-this-patch
> > > > 1  0.576131   vs   0.555889
> > > > 2   2.68376   vs    1.07895
> > > > 3   4.26502   vs    1.01739
> > > > 4   6.04306   vs    1.28924
> > > > 5   8.04786   vs    1.57616
> > > > 6   9.38844   vs    1.78142
> > > 
> > > <snip>
> > > 
> > > > 29    20.06   vs    3.59869
> > > > 30  20.4353   vs     3.6991
> > > > 31  20.9082   vs    3.73028
> > > > 32  21.0865   vs    3.82904
> > > > 
> > > > 1..32 - is a number of jobs. The results are in usec and is a vmallco()/vfree()
> > > > pair throughput.
> > > 
> > > I would be more interested in real numbers than synthetic benchmarks,
> > > Maybe XFS folks could help performing profiling similar to commit 8dc9384b7d750
> > > with and without this patchset?
> > > 
> > I added Dave Chinner <david@fromorbit.com> to this thread.
> 
> Oh, I missed that, and it would be better to [+Cc linux-xfs]
> 
> > But. The contention exists.
> 
> I think "theoretically can be contended" doesn't necessarily mean it's actually
> contended in the real world.
> 
> Also I find it difficult to imagine vmalloc being highly contended because it was
> historically considered slow and thus discouraged when performance is important.
> 
> IOW vmalloc would not be contended when allocation size is small because we have
> kmalloc/buddy API, and therefore I wonder which workloads are allocating very large
> buffers and at the same time allocating very frequently, thus performance-sensitive.
> 
> I am not against this series, but wondering which workloads would benefit ;)
> 
> > Apart of that per-cpu-KVA allocator can go away if we make it generic instead.
> 
> Not sure I understand your point, can you elaborate please?
> 
> And I would like to ask some side questions:
> 
> 1. Is vm_[un]map_ram() API still worth with this patchset?
> 
It is up to community to decide. As i see XFS needs it also. Maybe in
the future it can be removed(who knows). If the vmalloc code itself can
deliver such performance as vm_map* APIs.

>
> 2. How does this patchset deals with 32-bit machines where
>    vmalloc address space is limited?
> 
It can deal without any problems. Though i am not sure it is needed for
32-bit systems. The reason is, the vmalloc code was a bit slow when it
comes to lookup time, it used to be O(n). After that it was improved to
O(logn).

vm_map_ram() and friends interface was added because of vmalloc drawbacks.
I am not sure that there are 32-bit systems with 10/20/30... CPUs on board.
In that case it is worth care about contention.

--
Uladzislau Rezki
