Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2B2624C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiKJVJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKJVJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:09:47 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B124A1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:09:46 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y203so3138289pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8V1f8WH4dS9mFM23UsEnxE17zMYsQjxoes7ZkH73p5o=;
        b=Z7HxSIBaw3nRfpZXX1oRZw35iem5t419Zt44bjqY/I8GyM4VVauYgUvZfwT110/YJw
         63dnJj0giqkJdC9BFzKSctPalULNi0zfM4cJ15OZASuTEtM6oly/l1E6jF5wA+Aqkv4B
         IEifLv3vug9FQ0RLR36Dsg1E4eAMFMIIuzrzlHFe9KUnElmaLENnRxE2xu6mAMDjNixR
         SlynomLnrivhBCqfOzfFvq/9RtIdBvok6G39ehVBhHBuIXBVi7TPlLBlk7RNtcu34jAV
         7dLUCbx+eJMKkUS8nhgXSbuwIKVkiunKECoH6dR+SlKLMdN/uArx08lta3hjs+EID7F6
         ZbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8V1f8WH4dS9mFM23UsEnxE17zMYsQjxoes7ZkH73p5o=;
        b=5ohrmHObgmYZZ+m6H0l6SW+EAFVN7jfQiV4xMhyICmKbJf4v64BRFc4LoEvijuaB7/
         1F9xDt6j69o5dYugrSNlauduHk7oXU6DuWrNXii1irRs+jBJKDLI+ct8SnsMeNHhRxRH
         ULOm8JosA+ZCyUv46e8fol1Qp1o9IEpizxJ753sURbckBV2zCIiySHPjUcquTdMP6Q5t
         PGBMcvfiicyfYUf1mJf9CLqfKHOaniULTk4lYnJnqxpyu/0YrO0zBRZmymgkdyRwV1/5
         6mExRLi8TuxRmVnJBcNm0Jchz+fP+qizBK102rTkeX/3ECoJJsFmkQN3eH0a3u4BRGRa
         CD6g==
X-Gm-Message-State: ANoB5plTqqIyk6hexNpF4LtKfeQKA96P2YpzB4iBZ/Jxu+mXwqiRfJdb
        FZXOTiiIiXYlwB8qYCIEwTc=
X-Google-Smtp-Source: AA0mqf4Bri8I2T54EcfKFNLY7VtGKR62aHFeyc8DIxVdI58xoU2I5SetLJjMAqEzjbAAYmGypG2fZA==
X-Received: by 2002:a63:d111:0:b0:473:ef9c:e1e5 with SMTP id k17-20020a63d111000000b00473ef9ce1e5mr726817pgg.241.1668114585852;
        Thu, 10 Nov 2022 13:09:45 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id ij15-20020a170902ab4f00b001869f2120absm95826plb.294.2022.11.10.13.09.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Nov 2022 13:09:45 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v8 2/2] mm: remove zap_page_range and change callers to
 use zap_vma_range
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20221108011910.350887-3-mike.kravetz@oracle.com>
Date:   Thu, 10 Nov 2022 13:09:43 -0800
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7140E1D7-B1B9-4462-ADDA-E313A7A90A68@gmail.com>
References: <20221108011910.350887-1-mike.kravetz@oracle.com>
 <20221108011910.350887-3-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 7, 2022, at 5:19 PM, Mike Kravetz <mike.kravetz@oracle.com> wrote:

> zap_page_range was originally designed to unmap pages within an address
> range that could span multiple vmas.  However, today all callers of
> zap_page_range pass a range entirely within a single vma.  In addition,
> the mmu notification call within zap_page range is not correct as it
> should be vma specific.
> 
> Instead of fixing zap_page_range, change all callers to use zap_vma_range
> as it is designed for ranges within a single vma.

I understand the argument about mmu notifiers being broken (which is of
course fixable).

But, are the callers really able to guarantee that the ranges are all in a
single VMA? I am not familiar with the users, but how for instance
tcp_zerocopy_receive() can guarantee that no one did some mprotect() of some
sorts that caused the original VMA to be split?

