Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95D564CC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbiLNO14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbiLNO1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:27:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2190A20361
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671028007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eooKpcnT0zqUtx7o1Z+gXVL8gr4qa58YSOigvkF0Wx4=;
        b=hKXOryV2UeG0rcz71GEFA69/7C9iDSMcZeNgH4p4u5mO10WKOicszcc9h6l/7rhXb51iIW
        YtLc0uaeAcp9KobG24675uQUVRSXH/akkTz4y4QBbvJf+2Ov1UM+6nPz8rF5498xtdDSXL
        ZLemX/uztAgZe516ORSNFW5wA5Zf9bY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-ogrsOEzCNO-AVijeMehh4Q-1; Wed, 14 Dec 2022 09:26:45 -0500
X-MC-Unique: ogrsOEzCNO-AVijeMehh4Q-1
Received: by mail-qk1-f200.google.com with SMTP id bl21-20020a05620a1a9500b006fa35db066aso3165178qkb.19
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eooKpcnT0zqUtx7o1Z+gXVL8gr4qa58YSOigvkF0Wx4=;
        b=yTKQ4oF25O43Ecd8gtqbyYnJ5u58MtVuwPBYmean2OdVlYPZ3iO+gmIH5e6BLY/mgU
         Y4FPhYAGgST9/fncGiDGYvryL2VPcBjHzJlIsmEUGVrObEAKfG+8AFd3MTOuXpSqwu7v
         H7LHnxZf9jF1z3f3kBMM79rmlZUy739TFRToTPWfhPe+EuXY2qk7jHUNY+aOQ9KtUa6F
         8U9V8UAMYXKby1IqSAuA58DFRNoL6njQ6Yhcny1aXNgZ+FNKlR+ZZkJZ3IH9HGvEw4WH
         NZNWFttzRjg3w2T5nanqYBJl+Wb5eRYGjD0VbhzQSgxVy9h2APQWwyNmzDPo9mizcN76
         EWmw==
X-Gm-Message-State: ANoB5pmn0bmnmaxi8u3uISI2PVKjaR1aQB25DCeBvzzrNyLCvGY7lcnP
        1S6BV/yIb8QBmIRyHvBMwP8ljOH5CTEtGX7/qm8nBj6wONRc1ScyY4G0c50Ev87pmZikMsKIPU2
        tlmbH/fJUTQCWiAmNqx/xp66R
X-Received: by 2002:ac8:70c:0:b0:3a8:55c:a893 with SMTP id g12-20020ac8070c000000b003a8055ca893mr30246121qth.0.1671028005170;
        Wed, 14 Dec 2022 06:26:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7HtzN9hkRDnpf0x0IYTdENk7AWzeJ7UjVmRKdjEY7WEjGc354jNbZbpmDeDy4zW9BmPJFSbg==
X-Received: by 2002:ac8:70c:0:b0:3a8:55c:a893 with SMTP id g12-20020ac8070c000000b003a8055ca893mr30246094qth.0.1671028004869;
        Wed, 14 Dec 2022 06:26:44 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id r10-20020ac85e8a000000b00342f8d4d0basm1738313qtx.43.2022.12.14.06.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 06:26:44 -0800 (PST)
Date:   Wed, 14 Dec 2022 09:26:42 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/uffd: Always wr-protect pte in pte|pmd_mkuffd_wp()
Message-ID: <Y5ndIlgWMp8RuTdI@x1n>
References: <20221208194628.766316-1-peterx@redhat.com>
 <e679d3fe-be8e-d7c0-798a-df32587553ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e679d3fe-be8e-d7c0-798a-df32587553ed@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:59:35AM +0100, David Hildenbrand wrote:
> On 08.12.22 20:46, Peter Xu wrote:
> > This patch is a cleanup to always wr-protect pte/pmd in mkuffd_wp paths.
> > 
> > The reasons I still think this patch is worthwhile, are:
> > 
> >    (1) It is a cleanup already; diffstat tells.
> > 
> >    (2) It just feels natural after I thought about this, if the pte is uffd
> >        protected, let's remove the write bit no matter what it was.
> > 
> >    (2) Since x86 is the only arch that supports uffd-wp, it also redefines
> >        pte|pmd_mkuffd_wp() in that it should always contain removals of
> >        write bits.  It means any future arch that want to implement uffd-wp
> >        should naturally follow this rule too.  It's good to make it a
> >        default, even if with vm_page_prot changes on VM_UFFD_WP.
> > 
> >    (3) It covers more than vm_page_prot.  So no chance of any potential
> >        future "accident" (like pte_mkdirty() sparc64 or loongarch, even
> >        though it just got its pte_mkdirty fixed <1 month ago).  It'll be
> >        fairly clear when reading the code too that we don't worry anything
> >        before a pte_mkuffd_wp() on uncertainty of the write bit.
> 
> Don't necessarily agree with (3). If you'd have a broken pte_mkdirty() and
> do the pte_mkdirty() after pte_mkuffd_wp() it would still be broken. Because
> sparc64 and loongarch are simply broken.

That's why I mentioned on the order of operations matters.

> 
> > 
> > We may call pte_wrprotect() one more time in some paths (e.g. thp split),
> > but that should be fully local bitop instruction so the overhead should be
> > negligible.
> > 
> > Although this patch should logically also fix all the known issues on
> > uffd-wp too recently on either page migration or numa balancing, but this
> > is not the plan for that fix.  So no fixes, and stable doesn't need this.
> 
> I don't see how this would fix do_numa_page(), where we only do a
> pte_modify().

Yes, this patch won't, because it's a pure cleanup.  Otherwise we need
another line of wr-protect in numa recover path.

I can remove that sentence in v2 commit log.

-- 
Peter Xu

