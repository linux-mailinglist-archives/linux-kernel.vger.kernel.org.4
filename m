Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037B76DFEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDLTel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDLTej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D843268B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681328032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uw6xQG4wZGC1xgdfimz/iSV63q+d6nwv6pZhBDNF+ac=;
        b=d33KyVmfQovmIMMHHD//OGN6apZCzks4EGC+1jUa9HmALDD/MmEO4EwCMplt/SZHfct1PE
        IXasl1LyQRExHl22c9tw5bKUufBvigdxp50ixHHk9S8shZikRqBsOWvpVk4RHg30Rz/RaC
        HTYsqw+fT3Goi0WW2CrPTIiDzIcmrnQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-bccN9_WdMkqg1M8KDmUcCw-1; Wed, 12 Apr 2023 15:33:51 -0400
X-MC-Unique: bccN9_WdMkqg1M8KDmUcCw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e699015faeso3812481cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328030; x=1683920030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw6xQG4wZGC1xgdfimz/iSV63q+d6nwv6pZhBDNF+ac=;
        b=WP9atkspqzTfBTyF/W70KMqIoz+7GYX7dKLlcivo06QVoNE2fD/lqWmEQV27fnfvCs
         CmtvVSRYYb3KgcJpmn2/OVZO69Vrr0xDBYRFFAXWGBXxetqDdIclwt39Rl1YjtWkYFQ9
         MbJeNXDCVKWsdMJ7K/jw6hq0G1RkV4LQPlRRmBk3p1KecsH1srDbSHk5gvBqYEgG+IMo
         AE9nefsVMxpxlxIKmJci/blhdXu3MF2kaIXsVHwcVJndD6DZbNNriWQFk4I0cvRwuqei
         73XJyrKgLhkIWe2dk17IT1YwlC/wtcgvCH37IXY24nQ85Q/W2kpbjZjQSx3ifuuzGRyj
         zZnQ==
X-Gm-Message-State: AAQBX9dq67mlAFwkBsq/A9pq2dTIM9gSxYf1qLeGFWHJzcXa0nQtx+/I
        PGTehum0HQaW3cODtaUjyb7jbXh3HZ/psfkUbVGMwLWN6nT87vS/xoP5Ovij0BnwwdRbG/at4/U
        ZI6t6vwcwZpNlswENxlDDXHe1xeU9qABj
X-Received: by 2002:a05:622a:1821:b0:3e6:8da4:427 with SMTP id t33-20020a05622a182100b003e68da40427mr4249480qtc.6.1681328030105;
        Wed, 12 Apr 2023 12:33:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350YrCdMl0uPyf75zLMUcydJmenbK3Ym9Oek/Fm1okyU88m4dfxSLMEpFGfaz6ToLYNMshOQn/Q==
X-Received: by 2002:a05:622a:1821:b0:3e6:8da4:427 with SMTP id t33-20020a05622a182100b003e68da40427mr4249461qtc.6.1681328029844;
        Wed, 12 Apr 2023 12:33:49 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id q10-20020a05620a2a4a00b0074accdc10ecsm240192qkp.47.2023.04.12.12.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:33:49 -0700 (PDT)
Date:   Wed, 12 Apr 2023 15:33:48 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Subject: Re: [PATCH v2 14/31] selftests/mm: uffd_[un]register()
Message-ID: <ZDcHnEgCsoDBhFYM@x1n>
References: <20230412163922.327282-1-peterx@redhat.com>
 <20230412164247.328293-1-peterx@redhat.com>
 <CAJHvVchBhRf3pP4fCwsrr2s3S5jQP8z4sct5-_0n=tRd4XB9jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVchBhRf3pP4fCwsrr2s3S5jQP8z4sct5-_0n=tRd4XB9jQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:20:35AM -0700, Axel Rasmussen wrote:
> > -       uffdio_register.range.start = (unsigned long)addr;
> > -       uffdio_register.range.len = len;
> > -       uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> > -       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
> > +       if (uffd_register(uffd, addr, len, true, false, false)) {
> 
> For what it's worth, I agree with Mike that the booleans here are hard
> to read. It's not clear what "true, false, false" means without going
> to look at the header file, whereas "uffd_register(uffd, addr, len,
> MINOR)" would be immediately clear.
> 
> One solution I've seen outside the kernel is to comment the bools, like:
> 
> uffd_register(..., /*minor=*/true, /*wp=*/false, /*minor=*/false);
> 
> But, then I feel we lose most of the benefit we wanted from switching
> to bools anyway (code length). :)
> 
> I do agree the macro names are unwieldy, and lots of tests already use
> booleans so we'd have to convert from bool -> flag. If it were me, I
> would resolve that by:
> 
> - Define much shorter aliases for these macros in uffd-common.h
> - Consider refactoring callers to not use bools either.
> 
> Then again, I also agree with Mike that it's not a deal breaker, if
> you like this way much more than that alternative we can leave it.

No strong feeling here either.  I kept it just to avoid code churns and
rebases.

I'll see whether I'll need a repost, if so I can go back to use modes.

Thanks,

-- 
Peter Xu

