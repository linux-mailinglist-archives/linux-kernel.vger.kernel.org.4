Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2956A8BD2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCBWan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCBWal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:30:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3590F2ED68
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677796194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9w76+2ohgxcjVlWYSrlHU/d/MGudebB9BiN7dPivKls=;
        b=fIUvex2ntyDrtWz7Ifa4Vby3vjD6zkWW0aooyPfPbD2ESb4sS7Bd8xv7qJUyvB3a3SSgCc
        1nE0Q0IT0v41czqcxCv8hayuISSHcdA0C7QLmuSD22yKGGq3wXV5UYlgwURr1lYHkUo28m
        sfJgufuUpMTfJA1hgggE/bN/+WEqi/E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-xKKHzQJwPT25OHoN7D4Wkw-1; Thu, 02 Mar 2023 17:29:53 -0500
X-MC-Unique: xKKHzQJwPT25OHoN7D4Wkw-1
Received: by mail-qk1-f199.google.com with SMTP id dw26-20020a05620a601a00b0074300c772c0so290363qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677796192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9w76+2ohgxcjVlWYSrlHU/d/MGudebB9BiN7dPivKls=;
        b=1tTMYswz7knNG5FOQH66tyq3USxnqhq84qFlmjSve7WYMcJ3xzS8A2flfRQyDkD8nk
         RAkoVGvFozMY0kMuNo4vlPt9qWQKESlyrMVvdBg/n5yKFvZzc97VpyBxo3EXtebKuO/I
         nd735RzRCa0bdXEAu2EtyKEjNsMarNYh5x1B/h4wwAJWLNmNoAVgth7rKjatMkPIZZxD
         BEZ6GXXpCOMbB4VEwXRwndLmymUxabTAyLVvut8Hok67FpdBQvYXDN8iTw6FOKieO5EV
         9AhCrEjDRzgOkrTJP7WNKlto0ENOWdDfeG4gvCkVtN0U3aOl/E0ahg64KyziLxCLpHzO
         tfUQ==
X-Gm-Message-State: AO0yUKVLQO29gjiUZfa3hES7a7wN7PdHfx+L1i+Sjx8bBWkSAEY8u1aI
        JpuBXB+6TA5brpspuooc4uccn1UBVIDj6KWd0CNqrN9F8GnyDkbEvvzmWvksanv1MDEuDi4ZSA7
        mRfPZNBEVYCwLKrJLjjSSihjg
X-Received: by 2002:a05:622a:50:b0:3b8:6c6e:4949 with SMTP id y16-20020a05622a005000b003b86c6e4949mr22447653qtw.4.1677796192649;
        Thu, 02 Mar 2023 14:29:52 -0800 (PST)
X-Google-Smtp-Source: AK7set82JD60GzhD58kEO72bV4lzWME0qLzyyGi8Rfdb2ZNW87So39tqYtVmurZbDa/2ofdw7DDfsA==
X-Received: by 2002:a05:622a:50:b0:3b8:6c6e:4949 with SMTP id y16-20020a05622a005000b003b86c6e4949mr22447633qtw.4.1677796192416;
        Thu, 02 Mar 2023 14:29:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id b3-20020ac85bc3000000b003bfb820f17csm575151qtb.63.2023.03.02.14.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:29:51 -0800 (PST)
Date:   Thu, 2 Mar 2023 17:29:50 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH v1] mm/userfaultfd: propagate uffd-wp bit when
 PTE-mapping the huge zeropage
Message-ID: <ZAEjXqNH+U8p9fOG@x1n>
References: <20230302175423.589164-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230302175423.589164-1-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 06:54:23PM +0100, David Hildenbrand wrote:
> Currently, we'd lose the userfaultfd-wp marker when PTE-mapping a huge
> zeropage, resulting in the next write faults in the PMD range
> not triggering uffd-wp events.
> 
> Various actions (partial MADV_DONTNEED, partial mremap, partial munmap,
> partial mprotect) could trigger this. However, most importantly,
> un-protecting a single sub-page from the userfaultfd-wp handler when
> processing a uffd-wp event will PTE-map the shared huge zeropage and
> lose the uffd-wp bit for the remainder of the PMD.
> 
> Let's properly propagate the uffd-wp bit to the PMDs.

Ouch.. I thought this was reported once, probably it fell through the
cracks.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

