Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110AF699DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 21:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBPU0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 15:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBPU0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:26:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181EC193CC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 12:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676579160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/f2sde7e2NbfVJMkzsXEGNhRKAl7jMnwuVhILrrwE6M=;
        b=RiQnmN4rIGbvzVaAZ+z6/a8sryA3hdyPxTS5/qczuWDhrCA7OjWkgfp1/YORhrA9iuZPGG
        xD/8eDQx7VIrrKnKM8Gjzu8S2bBnQPmbrCyg3REf3UYEvaG04bNW/SvW1hoWvR5dSmeoa9
        mgJJslDvRDd22lhPNfJI2K+sQnMv3nc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-352-40Th9VllPAqkVUTVrKgJ0A-1; Thu, 16 Feb 2023 15:25:59 -0500
X-MC-Unique: 40Th9VllPAqkVUTVrKgJ0A-1
Received: by mail-qt1-f197.google.com with SMTP id i5-20020ac813c5000000b003b86b748aadso1880739qtj.14
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 12:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676579157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f2sde7e2NbfVJMkzsXEGNhRKAl7jMnwuVhILrrwE6M=;
        b=L801xbrfPLY1hLMbogWdbvrA0bDbQPcEfJAMFi1WVal7LZOPGHlQZ2mwUMj+rhFuHP
         BFLJEnZxRn2tjNEJoSFtaHeLo79M+y7i3j7T0Dt55uO6zOeKcfYpDGjxXNtndvJqcP4s
         juCWfJuN4rwVjFNG0Non52rlu73V2kc1ZP2Sm9v47RrI8xcOwT8LpDX1QXq1rvtul3TH
         8on6zcmxPfkJHeolc6tWIAvhHTyPGzr7w7bZ4sF7E+AjEA/Jb8W44rcwBRdPN2RhOSzc
         PzEGoyjzgeUebU7RicL5oQrBYKQ5lmM1oTwm3K6epmBOUBG94ngup7lyXTv5PuXID3zn
         k0ag==
X-Gm-Message-State: AO0yUKWnE5IRCODkzYPIR7+9erjY6ItcV4cS9UaooB1kNQRDlRzi6FEE
        qpdunTmn7SoBnqSzXvr8HV53btEuRNa3UWkywqmW8WZuyUs60ue1Whh9goF8b6c65FjGPuBp04f
        5FcFEwOTGfASnLhMfMY9P3F27ipL5Sg==
X-Received: by 2002:a05:622a:189c:b0:3b8:6c6e:4949 with SMTP id v28-20020a05622a189c00b003b86c6e4949mr14184178qtc.4.1676579156978;
        Thu, 16 Feb 2023 12:25:56 -0800 (PST)
X-Google-Smtp-Source: AK7set/9iC2D0k12dZjywCLKl31VYn68EhJCgPGLPONh7hnbsC2y5XMpkJH3Y9N57ARJycACxCplRg==
X-Received: by 2002:a05:622a:189c:b0:3b8:6c6e:4949 with SMTP id v28-20020a05622a189c00b003b86c6e4949mr14184152qtc.4.1676579156722;
        Thu, 16 Feb 2023 12:25:56 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id s18-20020ac87592000000b003b868cdc689sm1889205qtq.5.2023.02.16.12.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 12:25:55 -0800 (PST)
Date:   Thu, 16 Feb 2023 15:25:54 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm/userfaultfd: Support WP on multiple VMAs
Message-ID: <Y+6RUjv/K6RkwKQ7@x1n>
References: <20230216091656.2045471-1-usama.anjum@collabora.com>
 <f4b6cd03-28d7-b041-6dd4-46ac0812fc9b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4b6cd03-28d7-b041-6dd4-46ac0812fc9b@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:37:36AM +0100, David Hildenbrand wrote:
> On 16.02.23 10:16, Muhammad Usama Anjum wrote:
> > mwriteprotect_range() errors out if [start, end) doesn't fall in one
> > VMA. We are facing a use case where multiple VMAs are present in one
> > range of interest. For example, the following pseudocode reproduces the
> > error which we are trying to fix:
> > - Allocate memory of size 16 pages with PROT_NONE with mmap
> > - Register userfaultfd
> > - Change protection of the first half (1 to 8 pages) of memory to
> >    PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
> > - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
> >    out.
> 
> I think, in QEMU, with partial madvise()/mmap(MAP_FIXED) while handling
> memory remapping during reboot to discard pages with memory errors, it would
> be possible that we get multiple VMAs and could not enable uffd-wp for
> background snapshots anymore. So this change makes sense to me.

Any pointer for this one?

> 
> Especially, because userfaultfd_register() seems to already properly handle
> multi-VMA ranges correctly. It traverses the VMA list twice ... but also
> holds the mmap lock in write mode.
> 
> > 
> > This is a simple use case where user may or may not know if the memory
> > area has been divided into multiple VMAs.
> > 
> > We need an implementation which doesn't disrupt the already present
> > users. So keeping things simple, stop going over all the VMAs if any one
> > of the VMA hasn't been registered in WP mode. While at it, remove the
> > un-needed error check as well.
> > 
> > Reported-by: Paul Gofman <pgofman@codeweavers.com>
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> 
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

