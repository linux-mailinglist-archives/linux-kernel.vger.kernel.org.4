Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A0962C4F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiKPQnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiKPQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:42:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFEF5B84C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668616613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42qda8YCXAvT0VvMkHOL+t/vCh+HyZAHRup7avtOxrg=;
        b=IYzXSO0+W4lQfkkW5OtwL0HYarbr8EZdrC7CKGz8RtruVdNMG/621b8+PH2SBXd+bw8+LL
        /kTrEujWgnwrCHpAiMKDHUcAow4Qb+VyK6JbNJd/N1cUjBbPkOa1wedBVrE7A078MOZXTQ
        GuBv5tp1NUkCl6vuQgavpgcPsvAEQFc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-BaNppO6rMUmIiKLevGLkuQ-1; Wed, 16 Nov 2022 11:36:52 -0500
X-MC-Unique: BaNppO6rMUmIiKLevGLkuQ-1
Received: by mail-qk1-f199.google.com with SMTP id q14-20020a05620a0d8e00b006ef0350dae1so17757064qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42qda8YCXAvT0VvMkHOL+t/vCh+HyZAHRup7avtOxrg=;
        b=BHd6r5aOTsNoFUJA7alnySvWg8f1mJI7/CvXmro6EcBVexoC4F9LrEon5cwnzUuAwt
         uLq45apt03IeDyfniM6wpLN5rLoTQTGKU1y0CbUhxxK1wLMEVc2K8/lXxdN0eJ3SrOrq
         R6lO03kNAz1viJ/wAydvoy5Cjc4iYHOmdIxOxYo2uPa7Q01net8pdXI41ET3cbs2lLEc
         atBhtufVJVOLus/sK47PEEs+ZvQ1cOW5O6TknF5qdss8FikCX5DiJmDMOQixtoe859qD
         ETDDkD5nr/1YFlCf+ZsQ5Kj8mr+BE+XC6Ugr22EaC8fI/upwk23D4VMkHCsTGElEvO9M
         3oLg==
X-Gm-Message-State: ANoB5pkA0IgdYqsc43ETCELcRZDM/G9d/AIm2UqJwh7z3lMn0i+anu/b
        UTxEdF9DnYbsI85sJUKIvOPxzTdTa7ojcAnEFTwdekYq/xqDxvdhIN2JtBt4g5NHxu/o04feNJg
        5WjBsbzPyd6MCCwqF8on4o+A+
X-Received: by 2002:a05:620a:3ca:b0:6fb:9af3:8bb9 with SMTP id r10-20020a05620a03ca00b006fb9af38bb9mr8762408qkm.201.1668616610534;
        Wed, 16 Nov 2022 08:36:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7nkCxNpJGvJEJ3C6VRSsHqc3q6CslwVk4ldaBAzO3xHhUcYPs8eicSpJXUP6xNjMRHkMGZbw==
X-Received: by 2002:a05:620a:3ca:b0:6fb:9af3:8bb9 with SMTP id r10-20020a05620a03ca00b006fb9af38bb9mr8762385qkm.201.1668616610302;
        Wed, 16 Nov 2022 08:36:50 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id x200-20020a3763d1000000b006fa8299b4d5sm10152480qkb.100.2022.11.16.08.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 08:36:49 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:36:48 -0500
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
Subject: Re: [RFC PATCH v2 03/47] hugetlb: remove redundant pte_mkhuge in
 migration path
Message-ID: <Y3URoC51lDcy0fYu@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-4-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-4-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:19PM +0000, James Houghton wrote:
> arch_make_huge_pte, which is called immediately following pte_mkhuge,
> already makes the necessary changes to the PTE that pte_mkhuge would
> have. The generic implementation of arch_make_huge_pte simply calls
> pte_mkhuge.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

