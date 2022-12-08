Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDCC6479E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiLHXXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiLHXW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:22:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C0BAFCE8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670541694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=51O91TLkkJJ21KRVHsmrnMk6B51PYKI4zdoCffZRY7g=;
        b=fSZSiZhBfe8fcKwTklvpdsbA0Q6T8wBOymn0XlDoJpWBGlm5SMjx2k/yfOJTgN+8YDdyw5
        vUFa4MmstjL/HJCWwxe+eMiVoL/zkMb8tqDhzjfNa6k8lIzMIIIB4MTeLk8gYwUTt4np9e
        tUotRzGtEOjfkQrkeinZd7Py9MpZgPU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-271-JzcqUAoEPGaE5LpkTIvzIQ-1; Thu, 08 Dec 2022 18:21:33 -0500
X-MC-Unique: JzcqUAoEPGaE5LpkTIvzIQ-1
Received: by mail-qk1-f197.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so3171589qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 15:21:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51O91TLkkJJ21KRVHsmrnMk6B51PYKI4zdoCffZRY7g=;
        b=E17bCabW6aYLpV/t/c638kOyYENSfuoFau1wlgXuyIEusmEiFowdFNW9gON2qlLHZT
         tcDfhHeZBVlhXulMs3n7qastXNyy6lLuutsufcG57C1ANbPo8m9WZVcjI64/HAut3wo2
         aROLG92CaDtbrH20+rpSeZcTyEYoesfqK2g4012gJzY8xZ2h2k5tXcRRR8RWM/zA4rjJ
         3hqLujarIgJ7peJSXuBiLnXBNGZHriw5PRS3DV1yHPtotfK16b2ErGc0SVqIh+JBnHpB
         VYtM5urRK9dH2rhgSsiM9z6hletM4A17K7PEZ4+QNo0cQ8Rh7iiwcIFkWnNcxpG5bDBQ
         DSXw==
X-Gm-Message-State: ANoB5plGJeIarf4/iilAlhne+MMA7PhjHEYQY8XlLWSehsPJm8w5dQ9t
        ruTkoOqtZsT0zAu4FR91XBvvn61Wt/axZTZHAtxxlqraWT4h7iwZ5F2i/V1BSCOoxIJY+/Q/+na
        VT1rFfqg5X0/19FxyXvWl7JdI
X-Received: by 2002:ac8:4555:0:b0:39c:da20:629 with SMTP id z21-20020ac84555000000b0039cda200629mr4970012qtn.51.1670541693207;
        Thu, 08 Dec 2022 15:21:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YCklwluC/E/5Tr2zw5EsWHnn9xrEsxcOA3WE1hMLpgpELCb/uTGzbNslaTjkZYjTAb2JHTw==
X-Received: by 2002:ac8:4555:0:b0:39c:da20:629 with SMTP id z21-20020ac84555000000b0039cda200629mr4969999qtn.51.1670541692984;
        Thu, 08 Dec 2022 15:21:32 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id o13-20020ac85a4d000000b003a68fe872a5sm7290208qta.96.2022.12.08.15.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 15:21:32 -0800 (PST)
Date:   Thu, 8 Dec 2022 18:21:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 09/10] mm/hugetlb: Introduce hugetlb_walk()
Message-ID: <Y5JxeqW9+4Ef8Yay@x1n>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203156.651077-1-peterx@redhat.com>
 <3b5579e8-8e51-a2e2-4c93-6709f8833723@nvidia.com>
 <Y5JQvElUNz6yGsrT@x1n>
 <a3e05607-f165-04d1-29e0-f25bbaa1667e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3e05607-f165-04d1-29e0-f25bbaa1667e@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 01:50:17PM -0800, John Hubbard wrote:
> However, of course I won't insist here, as there are clearly preferences
> in both directions. And the code is still small in either form in this
> case so really a non-issue.

Thanks, John.

-- 
Peter Xu

