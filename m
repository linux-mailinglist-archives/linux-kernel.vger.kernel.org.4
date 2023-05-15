Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593A6703FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245457AbjEOVkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245027AbjEOVkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336855B80
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684186769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mvQ6YPEhi1yH4GPYfF4puSk1qA1jVN6Q6/XNFDL2370=;
        b=XF7A7Q5mqdxG9lu1Lf9srDXvijn/nSHppY7M0P5cNbvopfQVQR+wV+Ye4A/P9OWVh30dJb
        8w+cviEE9mtSYoNLM27AobVCt/uew3SPwxxa5DicVNBaDLr0l5q5uZnFtFukSBXXlbbnOm
        2mmGHdW1RiaeN+0NkVzyB/EVw/e3fBQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-4Di73UE0OsWR2qdVwN66Rw-1; Mon, 15 May 2023 17:39:27 -0400
X-MC-Unique: 4Di73UE0OsWR2qdVwN66Rw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-61a3c7657aeso20850856d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684186767; x=1686778767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvQ6YPEhi1yH4GPYfF4puSk1qA1jVN6Q6/XNFDL2370=;
        b=QmCziWmD7vBUXQLcJ+jyday3xx4XiT2K7lxQogJJmviZGjLnrT3kvsgayLzaBnTymh
         ArhfUcUMQxPZWY/A4R9Zo+Qfyvp/hVdjZqYoeYYI3ZgP98dxBDLxX6UIEnX84Y513BXG
         whj71aUGZ1EZAZllq3yc9+dUkQ+58ov6aj1JVa93o8wuqLSo0k6KiRR3jHALoLLOVcKY
         CeLKK4kPE4W7FR4gdTd0P6fXkr/QKjZXlX58dYQWXEq3IXZE621AopmpcFQR41zcpBTG
         x0qjAlAdpuJRsA1dMvDDEbna4p36h+caMeHR0BqHz6564N+mHRDci5fpmQvoGd6oXRW/
         5fKw==
X-Gm-Message-State: AC+VfDyiAzA4r7AvesdFvGKYW2EhnhVslHD1DGsCWA5KHoENNjADVIRD
        6FVwU42n5j4SaOVkJ0dt6CfRA5dPl1KsNQQ3FW8WNGciv/gQLfZpf65OpRfiS9QDL+xS18RGHmo
        aK7Ek59xtlRaPv9MiTkrIUGGv
X-Received: by 2002:a05:622a:1884:b0:3f5:1def:67f9 with SMTP id v4-20020a05622a188400b003f51def67f9mr11458015qtc.6.1684186767412;
        Mon, 15 May 2023 14:39:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48FEMVXKuw185MTT22FSVI1h5i6ov5pP1X/kYyREZeMiFa9PALYQ3Fr2SpztFYSBEKnIj2aw==
X-Received: by 2002:a05:622a:1884:b0:3f5:1def:67f9 with SMTP id v4-20020a05622a188400b003f51def67f9mr11457997qtc.6.1684186767161;
        Mon, 15 May 2023 14:39:27 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id x25-20020a05620a14b900b0075941df3365sm102177qkj.52.2023.05.15.14.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 14:39:26 -0700 (PDT)
Date:   Mon, 15 May 2023 17:39:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <ZGKmjUL5etmvIouh@x1n>
References: <20230515193232.67552-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515193232.67552-1-lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 08:32:32PM +0100, Lorenzo Stoakes wrote:
> As well as fixing the repro described in [1] this also continues to pass
> uffd unit tests.

Side note on testing, not directly relevant to the patch itself..

I'm wondering whether do we have tests somewhere to just test vma
operations on split and merge, then verify it using smap or whatever.

The uffd unit test in this case is probably not gonna trigger anything
because we always mostly register with a whole vma over the testing ranges,
so not immediately helpful.

The trick here is we have quite a few ops that will call vma merge/split in
different ways, but logically we can still category them into: (1) add/del
vmas, or (2) modify vma flags, so at least for case (2) we can have a
framework to cover all the cases (mbind, mprotect, uffd reg/unreg, mlock,
etc.), the difference will be the flags we'll be looking at for different
cases, however how vmas merge/split should be somehow in the same pattern.

-- 
Peter Xu

