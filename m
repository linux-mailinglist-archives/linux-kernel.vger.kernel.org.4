Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F7272B897
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjFLHZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFLHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C965210FE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686554280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTHQGrWcRnFhQdvS1hgwBK1IpR28Ymon3LGQetfTV6Y=;
        b=P+YLcFkW76uWLw9AtotidNmXSdushTUL23qZXvYaRAJNKInINVVqbYPOaFGd/Uip0rjuCc
        uO04NRuzWYr6HPYcYX7Xs0hNNPlcJcd5PXXZ19Ns9cs726artTwOReu+aQnklf/ua6K9kB
        O0MsMWHS3NlajE9O2qIgGeqZbHkHTcU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Mh-XVFmvOJ2VgaOEh-HG-w-1; Mon, 12 Jun 2023 02:36:09 -0400
X-MC-Unique: Mh-XVFmvOJ2VgaOEh-HG-w-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-55b0d97f849so3257920eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 23:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686551768; x=1689143768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTHQGrWcRnFhQdvS1hgwBK1IpR28Ymon3LGQetfTV6Y=;
        b=A7TTkCFsuHdhXBwaVIN+IqhaUaApBrmlafX0oRbxKLIwPoZ6+506l2MMjXgMkfnYZ1
         kI5O5Kq0eRs5DN7zrl2Eh92JiEsX1Gojoc8LZFMdK6RKUipQ1fxDJgk8pCJIhif+ziiR
         otug0s5fUkBIZj0ufTsPmTd51i+yKvSUEqVO8ojJalnLdtipRq+X8xRsMSJ0YTW/UXDl
         ZAVjvC+75QnHUxe8bJSLCXxV3tQEVihuH3IjPhSU+rtBZvEfd7qNpJ52TlWw515HrshO
         qoUP8k+DaH+oJVRfvPqC9pZGKfO+pc0uCo3+FDPPh8cGdvUXjQ8lQwxrnVlOf9X8rAfB
         L/iQ==
X-Gm-Message-State: AC+VfDzvOUl8eE2FTZbldagdP91g2uGXFE1oAzFScGaxv7TVDn4UwRMm
        v4IEhAt0R6wgulpat1jS6o1ClTyrOVhicMFIztaEzfSQsq8F5qaTIT3NM9ybRqEWVE/YXfnaf+6
        QNZvPYck4d8J2H1TWyGr+WkZwJWGR32xXDos=
X-Received: by 2002:a05:6808:1382:b0:398:4465:ed25 with SMTP id c2-20020a056808138200b003984465ed25mr4273425oiw.37.1686551768226;
        Sun, 11 Jun 2023 23:36:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ514fxUnvj5xJgeC6Dqw0J5bSPjU8AAxPUFvs5aFURHDuoAv9plFWumrs9qyp9vdcJa24m7Mg==
X-Received: by 2002:a05:6808:1382:b0:398:4465:ed25 with SMTP id c2-20020a056808138200b003984465ed25mr4273408oiw.37.1686551767923;
        Sun, 11 Jun 2023 23:36:07 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mi12-20020a17090b4b4c00b0024df6bbf5d8sm6738898pjb.30.2023.06.11.23.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 23:36:07 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:36:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
Message-ID: <20230612063602.qk2mgh55leqqefpc@zlang-mailbox>
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area>
 <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area>
 <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 08:14:25PM -0700, Linus Torvalds wrote:
> On Sun, Jun 11, 2023 at 7:22 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > I guess the regression fix needs a regression fix....
> 
> Yup.
> 
> From the description of the problem, it sounds like this happens on
> real hardware, no vhost anywhere?
> 
> Or maybe Darrick (who doesn't see the issue) is running on raw
> hardware, and you and Zorro are running in a virtual environment?

I tested virtual environment and raw hardware both.

We have a testing machines pool which contains lots of different machines,
include real machines, kvm, and other kind of vm, include different
rches (aarch64, s390x, ppc64le and x86_64), and different kind of
storage (virt, hard RAID, generic scsi disk, pmem, etc...). They all hang
on fstests generic/051.

I remembered Darrick said he did test with ~160 VMs (need confirmation
from him).

So this issue might not be related with VMs or real machine. Hmm... maybe
related with some kernel config? If Darrick would like to provide his .config
file, I can make a diff with mine to check the difference.

Thanks,
Zorro

> 
> It sounds like zap_other_threads() and coredump_task_exit() do not
> agree about the core_state->nr_threads counting, which is part of what
> changed there.
> 
> [ Goes off to look ]
> 
> Hmm. Both seem to be using the same test for
> 
>     (t->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER
> 
> which I don't love - I don't think io_uring threads should participate
> in core dumping either, so I think the test could just be
> 
>     (t->flags & PF_IO_WORKER)
> 
> but that shouldn't be the issue here.
> 
> But according to
> 
>   https://lore.kernel.org/all/20230611124836.whfktwaumnefm5z5@zlang-mailbox/
> 
> it's clearly hanging in wait_for_completion_state() in
> coredump_wait(), so it really looks like some confusion about that
> core_waiters (aka core_state->nr_threads) count.
> 
> Oh. Humm. Mike changed that initial rough patch of mine, and I had
> moved the "if you don't participate in c ore dumps" test up also past
> the "do_coredump()" logic.
> 
> And I think it's horribly *wrong* for a thread that doesn't get
> counted for core-dumping to go into do_coredump(), because then it
> will set the "core_state" to possibly be the core-state of the vhost
> thread that isn't even counted.
> 
> So *maybe* this attached patch might fix it? I haven't thought very
> deeply about this, but vhost workers most definitely shouldn't call
> do_coredump(), since they are then not counted.
> 
> (And again, I think we should just check that PF_IO_WORKER bit, not
> use this more complex test, but that's a separate and bigger change).
> 
>               Linus


