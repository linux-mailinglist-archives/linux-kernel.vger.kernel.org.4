Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CB3674676
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjASW4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjASWzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:55:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3AD3583
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674167855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZN3P+lDl/QW4icxsHaUXJ25aBOnci+luQtEGJla9HbE=;
        b=WJly/5ckXUaRVjbBP7nBClVY2Md1JqSYCGW33QywTvd75rVKjEXktjlpdAtBHJx443ZZNs
        M5QE+REp66iB0/slUGAE2QuNubzwMeyAoE7aFnwNSVSyZx9grjGuBfUpKFT83Btm9FNo2Z
        fNRMzU1h+UmPGY3FMp9tktCYTIwpXFk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-356-k4truwBrOySfi3bSuqRSTQ-1; Thu, 19 Jan 2023 17:37:34 -0500
X-MC-Unique: k4truwBrOySfi3bSuqRSTQ-1
Received: by mail-qk1-f198.google.com with SMTP id s7-20020a05620a0bc700b006e08208eb31so2246765qki.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:37:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZN3P+lDl/QW4icxsHaUXJ25aBOnci+luQtEGJla9HbE=;
        b=dciLJbbi/pGNx729m9+iI5zkxB7YJ+oNPproTI3WcraWxTesZzN5lOibqawqh1tapj
         U4DtPfY1cSLka4lek0BN7s7KKwEhPEP2Aso9BafzduFV+LcezfqCndyN9DhxQSLre/cZ
         6O6Xr3bgEaOFa1GsPna7Q6T9pY6NhyOWsK64MMgq6UXuOzD7Z1ooj0aJujKReXF7R/O4
         jUepor4G6oetT62YtLzwd6/5QNZidJCN+3ojITEEQv+irXbe44eBUfH+jWShNytsJzIQ
         SNebzEgIMkW6Wg6ugEzinnu6X97f0Irip0oWcg4maT5TJdVNyLBxohOfAqt8oJwdlu6l
         TQng==
X-Gm-Message-State: AFqh2kpqnegjYS0aKXTca8rS391bBflIJ+NfagzOMRKXPqoCVlNO0fls
        Qc6Qvzdkfo0DYvVEoRpLIiELzh1IOOWXIZzyeUxBNkPEmPgIXVdwplGykpqbcrXSw7piR2Gdpm2
        e9yqZ1c/Xkbf0E1Y5202RGdUN
X-Received: by 2002:ac8:4d04:0:b0:3b6:97f0:42dc with SMTP id w4-20020ac84d04000000b003b697f042dcmr585953qtv.23.1674167853600;
        Thu, 19 Jan 2023 14:37:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu+/2jo+Azl/+1gPjqKJU9Xm0YS9BYC0PKgOEkjikX0LmrVhXIBFj2KlXO3aEu6bpO/BGGpwg==
X-Received: by 2002:ac8:4d04:0:b0:3b6:97f0:42dc with SMTP id w4-20020ac84d04000000b003b697f042dcmr585916qtv.23.1674167853376;
        Thu, 19 Jan 2023 14:37:33 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id w25-20020ac86b19000000b003b63c08a888sm4734754qts.4.2023.01.19.14.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 14:37:32 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:37:31 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 35/46] hugetlb: add MADV_COLLAPSE for hugetlb
Message-ID: <Y8nGK2N5E15cenr1@x1n>
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-36-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105101844.1893104-36-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 10:18:33AM +0000, James Houghton wrote:
> +	/*
> +	 * Grab the VMA lock and mapping sem for writing. This will prevent
> +	 * concurrent high-granularity page table walks, so that we can safely
> +	 * collapse and free page tables.
> +	 *
> +	 * This is the same locking that huge_pmd_unshare requires.
> +	 */
> +	hugetlb_vma_lock_write(vma);
> +	i_mmap_lock_write(vma->vm_file->f_mapping);

One thing I just noticed - do we need the mmap write lock here?  I don't
quickly see what stops another thread from having the mmap read and walking
upon the pgtables being collapsed.

Thanks,

-- 
Peter Xu

