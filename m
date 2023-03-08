Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759266B0CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjCHPcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjCHPcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:32:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B458D08DA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678289473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eftDudG4vr7BCElathmFsHuVcD7xDHQqJ2O3beq4KM0=;
        b=dcJtYnhZ8AoJmFJaHf6GPYYctlaJfBTrTMfqM32icUfavWGUw7BMj0p/nCj1if0Qu5LVaT
        JvHS0Gtl4seKl6oHooDw14jON+qL+BIRXCyzFEPiSnGM1dul6Q2isPB3X9H90JlXvpfvW7
        lUkG5JNwNMXMhhfySrvqe6+tvrlrOeE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574--usu4CGdPZqnM-7KLX8QjA-1; Wed, 08 Mar 2023 10:31:12 -0500
X-MC-Unique: -usu4CGdPZqnM-7KLX8QjA-1
Received: by mail-qk1-f199.google.com with SMTP id dm13-20020a05620a1d4d00b00742a22c4239so9591117qkb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678289472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eftDudG4vr7BCElathmFsHuVcD7xDHQqJ2O3beq4KM0=;
        b=VWuH+hSrye/jxSJJbg3U1bhya3gDfejGCPTD0/utyTEp5RzPA/EhtODgLNuZjkec8y
         kWp3FcfNLFhlVLqC6WuWcekNGsIqs0SdBoaivv/N64q5XEBHc6fP5p5oRP0qbFRXSfpK
         8DL5byoACvrqGS1NB69Y8Ccfe1t+l5n6AuZcK2rC6cPINNTvaxFztHuxShWjLQtL8gwf
         khQLOCF9ktMySF2+hB+7hFIBLYzuZTISvNykLTSat42GPF6QtzDLVBAhVVWDEuwj2jbH
         L8rN2+8UmXg7pnNu7C4XPtm2l7ketkrulRk+uRQjGqIP7I5y6Ef9xHdFetHa3zIKrpio
         AqAg==
X-Gm-Message-State: AO0yUKWEEJKgK/YrD+RW/ijFduTe/dh0l6Mb0RBYU94LUBzsIEmeXqxS
        Rv1b02fUqmW9/NMFoIBjfMME7Sxe7jS5UboKkBtu2s4rJCIbaNb8d/so91Me8Erq5BpDnFKI0Lp
        K5tmTFsQDQyJTSxGf9SztbIQ/
X-Received: by 2002:a05:622a:8:b0:3bd:d8f:2da9 with SMTP id x8-20020a05622a000800b003bd0d8f2da9mr35990187qtw.2.1678289472263;
        Wed, 08 Mar 2023 07:31:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+hoTSuPiZP5GgpsCQn+QdWQJtKgt92kywG67pTawKqLEZWT+sEEEfsWjkysVAL3s0aiQhuEQ==
X-Received: by 2002:a05:622a:8:b0:3bd:d8f:2da9 with SMTP id x8-20020a05622a000800b003bd0d8f2da9mr35990147qtw.2.1678289471932;
        Wed, 08 Mar 2023 07:31:11 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id i10-20020ac871ca000000b003bfb950f670sm11702664qtp.41.2023.03.08.07.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:31:10 -0800 (PST)
Date:   Wed, 8 Mar 2023 10:31:09 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Message-ID: <ZAiqPU0RX3JfDFRP@x1n>
References: <20230306213925.617814-1-peterx@redhat.com>
 <20230306213925.617814-2-peterx@redhat.com>
 <94be7b9f-c33e-c6dc-4132-6cb78f7c0624@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94be7b9f-c33e-c6dc-4132-6cb78f7c0624@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:11:07PM +0100, David Hildenbrand wrote:
> On 06.03.23 22:39, Peter Xu wrote:
> 
> Note that I wodnered for a second if we'd call it "UFFD_FEATURE_WP_MISSING"
> instead (similar to the definition of MISSING uffd that triggers when we
> have nothing mapped).

I'll be fine with either WP_UNPOPULATED or WP_ZEROPAGE, but hope to avoid
MISSING as that's definitely a keyword in uffd which can be confusing.

> 
> Just a thought.
> 
> [...]
> 
> > With WP_UNPOPUATED, application like QEMU can avoid pre-read faults all the
> > memory before wr-protect during taking a live snapshot.  Quotting from
> > Muhammad's test result here [3] based on a simple program [4]:
> > 
> >    (1) With huge page disabled
> >    echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
> >    ./uffd_wp_perf
> >    Test DEFAULT: 4
> >    Test PRE-READ: 1111453 (pre-fault 1101011)
> >    Test MADVISE: 278276 (pre-fault 266378)
> >    Test WP-UNPOPULATE: 11712
> > 
> >    (2) With Huge page enabled
> >    echo always > /sys/kernel/mm/transparent_hugepage/enabled
> >    ./uffd_wp_perf
> >    Test DEFAULT: 4
> >    Test PRE-READ: 22521 (pre-fault 22348)
> >    Test MADVISE: 4909 (pre-fault 4743)
> >    Test WP-UNPOPULATE: 14448
> > 
> > There'll be a great perf boost for no-thp case, while for thp enabled with
> > extreme case of all-thp-zero WP_UNPOPULATED can be slower than MADVISE, but
> > that's low possibility in reality, also the overhead was not reduced but
> > postponed until a follow up write on any huge zero thp, so potentitially it
> 
> s/potentitially/potentially/
> 
> > is faster by making the follow up writes slower.
> 
> What I realized, interrestingly not only the writes, but also the reads. In

Curious why reading a zeropage would be a problem?

> case of background snapshots we'll be reading all VM memory I think ... but
> we could optimize in QEMU by consulting the pagemap if there is anything
> mapped at all, and not read zeros in that case [an optimization brought up
> several times already].
> 
> I am not sure yet if we want to change the QEMU implementation. But anyhow,
> that's a different discussion.

The rest comments all look good here, I'll fix and resend, thanks.

-- 
Peter Xu

