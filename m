Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F376062CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJTOSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJTOSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:18:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A3E16A4E1;
        Thu, 20 Oct 2022 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AzH2a4QXGz+eTNIZ5k3/P8jk/sAl3fN5pfERFMiCaGI=; b=jrdaHGMwT8rIg0f5wDQi0KOC+J
        iQjLh+Ip24wmMVh8GSFzWcelTLoD74kUuoZDjUWuicbHm3GIo8OwU5H9zACRf675jBrD85/5tRA+/
        FBh0RIiF/4V+e45hHBKpixufUXdsVCfbNBY1uZGTabjE5na/CMoRTZwg3fb9WonaeSaNVSz23BppC
        v2Qlo7mw2yyHnG552uESl/zWzco2W0a+CLOGERPmVhem6U4y2V1p7OZTmD+i2MBq5AnHPkQ7Bgvzo
        fQbfYIrl0KuvOfRnD1bVZtTAMzRG7LTLmw8FGczXbcvoNopQPfjWdSNN3vfsOA1JROhVH1WEN2I0f
        8HnjU3aA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olWJ8-0053JC-Nj; Thu, 20 Oct 2022 14:14:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E644930045D;
        Thu, 20 Oct 2022 16:13:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B99432C08F539; Thu, 20 Oct 2022 16:13:56 +0200 (CEST)
Date:   Thu, 20 Oct 2022 16:13:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
Message-ID: <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net>
References: <20220815071332.627393-1-yuzhao@google.com>
 <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net>
 <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
 <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:40:40AM -0700, Linus Torvalds wrote:

> Because as you say, the function is already called "read_atomic", and
> it should damn well *act* that way then.

So I've been sitting on these here patches (and never having time to
repost them), which is how I noticed in the first place:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/mm.pae


