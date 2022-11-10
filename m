Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5B9624CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiKJV25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiKJV2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:28:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113159D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668115674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D15edAydLnVTLab35CTaj6y/l/B1rXYhW6svf54p2rE=;
        b=e3srHlVJD4WATsBO42i/PTF78ZnGOuvEzBJKIqtTk40B13nqWBM+OPDu5MUTBF3PRgFWOO
        BJBRNH0BDh8kFFkKcu2BNeNdSAdDnWov74EafLqb75xe/qUIf8zYCBRHqAZ4iyz0y2ZpLe
        QMTQKmcOWzZb/8XbdulDd9BgYJdljQQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-Ok3OKilTN2eynda0tkOhUw-1; Thu, 10 Nov 2022 16:27:53 -0500
X-MC-Unique: Ok3OKilTN2eynda0tkOhUw-1
Received: by mail-qt1-f199.google.com with SMTP id s14-20020a05622a1a8e00b00397eacd9c1aso2353419qtc.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D15edAydLnVTLab35CTaj6y/l/B1rXYhW6svf54p2rE=;
        b=7g/KDNjSpgK/qXhyhzYdPfDIQRxXsisVtmskKufUzTUY6ac9Dx25aSmmRXL7HqZzRX
         qb+/Wx1bqi+UeaNv9DFR1pg04eMNUlfFgPHfkqqb/46FZLRBrC633jcltMpDmqp8zbZA
         Upz4y1/BK0sy2GJCBpHehzBAi+YAoISoI5uFYnSqgtIAgvJuvJbYwxOV08UUeHsgXLgh
         XQikS4NjRWu4qcv8kGL2AqcqzO880PjMbV4ZfkqKPPrsZe3u6kYtKm8KDqcHyksjYycj
         ABFTNSr8Ye6v4AZv2Ma44G9RZEWMO0m2OucGzT/A/I+WhENoLOhYnlscrPRKTAgzIaqC
         zezA==
X-Gm-Message-State: ACrzQf3LA5r34Sm9H0P4//WPGcCIuBOmQgyo7vB2iXTSQXuFekCBhHeB
        t5Ddlf13J2VDFNuRbM+mvVB4E/6XdnfiwH6f6O6R9HjzwHdl5TrQ5AyLwONQCQ6QViW+hZyXtxC
        dvR4iN6Ptg+m4kRRHmv72VJIS
X-Received: by 2002:ac8:53ce:0:b0:3a5:122:fb79 with SMTP id c14-20020ac853ce000000b003a50122fb79mr1948886qtq.452.1668115672719;
        Thu, 10 Nov 2022 13:27:52 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4YgTRj2nHC6NVvXZhdEJ/UnFY/bgoDMZtxAZubI5MaeEgeSKEQau4bSHlu5U0LdokZQ5DbKg==
X-Received: by 2002:ac8:53ce:0:b0:3a5:122:fb79 with SMTP id c14-20020ac853ce000000b003a50122fb79mr1948872qtq.452.1668115672499;
        Thu, 10 Nov 2022 13:27:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id t19-20020ac865d3000000b003a527d29a41sm186487qto.75.2022.11.10.13.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:27:51 -0800 (PST)
Date:   Thu, 10 Nov 2022 16:27:50 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 2/2] mm: remove zap_page_range and change callers to
 use zap_vma_range
Message-ID: <Y21s1uzkey6u4nyK@x1n>
References: <20221108011910.350887-1-mike.kravetz@oracle.com>
 <20221108011910.350887-3-mike.kravetz@oracle.com>
 <7140E1D7-B1B9-4462-ADDA-E313A7A90A68@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7140E1D7-B1B9-4462-ADDA-E313A7A90A68@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nadav,

On Thu, Nov 10, 2022 at 01:09:43PM -0800, Nadav Amit wrote:
> But, are the callers really able to guarantee that the ranges are all in a
> single VMA? I am not familiar with the users, but how for instance
> tcp_zerocopy_receive() can guarantee that no one did some mprotect() of some
> sorts that caused the original VMA to be split?

Let me try to answer this one for Mike..  We have two callers in tcp
zerocopy code for this function:

tcp_zerocopy_vm_insert_batch_error[2095] zap_page_range(vma, *address, maybe_zap_len);
tcp_zerocopy_receive[2237]     zap_page_range(vma, address, total_bytes_to_map);

Both of them take the mmap lock for read, so firstly mprotect is not
possible.

The 1st call has:

	mmap_read_lock(current->mm);

	vma = vma_lookup(current->mm, address);
	if (!vma || vma->vm_ops != &tcp_vm_ops) {
		mmap_read_unlock(current->mm);
		return -EINVAL;
	}
	vma_len = min_t(unsigned long, zc->length, vma->vm_end - address);
	avail_len = min_t(u32, vma_len, inq);
	total_bytes_to_map = avail_len & ~(PAGE_SIZE - 1);
	if (total_bytes_to_map) {
		if (!(zc->flags & TCP_RECEIVE_ZEROCOPY_FLAG_TLB_CLEAN_HINT))
			zap_page_range(vma, address, total_bytes_to_map);

Here total_bytes_to_map comes from avail_len <--- vma_len, which is a min()
of the rest vma range.  So total_bytes_to_map will never go beyond the vma.

The 2nd call uses maybe_zap_len as len, we need to look two layers of the
callers, but ultimately it's something smaller than total_bytes_to_map we
discussed.  Hopefully it proves 100% safety on tcp zerocopy.

-- 
Peter Xu

