Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAAC63CA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiK2Vhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbiK2Vhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3885C75D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669757813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BWaTZSPo+HO/zYxVJ/xWxSiqucUXiQzkU4LC8VS3r40=;
        b=AhqjkXpWM5wZNluLo3oyVZmcnx5NU6j1o9aMdoKPoDnk3mxvSCeFp4sugQISPyboaa0Sza
        0crsh4QVVpVFXU8YVhxlFlpbCybUoDy0PYV/nwlH5oXsKXZkdHWbxkDjEZgIotQSH/Ie8v
        ospr1uwxecGkhGjhLIwaIZCqWkpoeFU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-389-wwRcTt0pNqWtQ--GZHmdQg-1; Tue, 29 Nov 2022 16:36:52 -0500
X-MC-Unique: wwRcTt0pNqWtQ--GZHmdQg-1
Received: by mail-qk1-f200.google.com with SMTP id az31-20020a05620a171f00b006fa2cc1b0bfso33040578qkb.23
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWaTZSPo+HO/zYxVJ/xWxSiqucUXiQzkU4LC8VS3r40=;
        b=b75a6u2MNxSXCB5NESK7NJgEnEYtIircX3+M+xSdvfa315bG+invFcj8d62TFve2V3
         uiImdPy6Bumw9G1RWDz3DWc1EsPJW45fdyrSzyQJUJq9q5Ft486/2hGqqGGGI2MSBAuP
         g4MmwBrZ5p6uZv7K9X9CG/RKRuANjSYNFnEc5JUZpaUo76kKqypCMsbA0PFRAggRRQCf
         VNsxO8+UNxHMMJivk3rEz42OSvekHDfcs0CLolozRJRyn7TUQoa8PfzbrddA6zXWiSPJ
         udMbVM4aBv+VWKEnBMvMs/m4YNHnxdP0gn5FdghSJqD2h9x8/RLgkvv7n68l6aveeK7F
         s7dA==
X-Gm-Message-State: ANoB5pkD78H8h9TbUZIHfj+sWpzJHC+Ld2xYLTzVRZ+vwBrQ1ts1GxoS
        IOB1N242KU5xUMvPe0boPbt17xNEW5MwatXDwfnY8q/a/erAiLlhwhayiCOv547mOwoufhH/0Zi
        CsA/qPJVp2RJSzDrsBWNwE74E
X-Received: by 2002:a05:622a:6022:b0:398:5f25:649 with SMTP id he34-20020a05622a602200b003985f250649mr55357235qtb.673.1669757811540;
        Tue, 29 Nov 2022 13:36:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4O3P88Az221sAQckplDC94c73NQebw1mJ1mivlR3sPQM+UXsSc1nokCTAlyNeJ14Caezk6DA==
X-Received: by 2002:a05:622a:6022:b0:398:5f25:649 with SMTP id he34-20020a05622a602200b003985f250649mr55357219qtb.673.1669757811297;
        Tue, 29 Nov 2022 13:36:51 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id dt31-20020a05620a479f00b006fbf88667bcsm11300718qkb.77.2022.11.29.13.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 13:36:50 -0800 (PST)
Date:   Tue, 29 Nov 2022 16:36:49 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 00/10] mm/hugetlb: Make huge_pte_offset() thread-safe for
 pmd unshare
Message-ID: <Y4Z7caUUaS+nV+bk@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129125117.6d31c7cf4c83510be0c8cf10@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221129125117.6d31c7cf4c83510be0c8cf10@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 12:51:17PM -0800, Andrew Morton wrote:
> On Tue, 29 Nov 2022 14:35:16 -0500 Peter Xu <peterx@redhat.com> wrote:
> 
> > [   17.975943] Oops: 0000 [#1] PREEMPT SMP NOPTI
> 
> Do we know which kernel versions are affected here?

Since lockless walk of huge_pte_offset() existed since the initial git
commit, it should be the time when we introduced pmd sharing for hugetlb,
which means any kernel after commit 39dde65c9940 ("[PATCH] shared page
table for hugetlb page", 2006-12-07) should be prone to the issue at least
for x86 (as pmd sharing was proposed initially only for x86).

-- 
Peter Xu

