Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A71762FFCC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiKRWLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiKRWKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:10:48 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EFC31ED1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:10:44 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id k4so4420556qkj.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tx1YmCzTaRx+0xpO+uSdB0tU1cOLA9kXrIQzKxsMbJ0=;
        b=hoVcNNDUK6njBp4aMtQrFOAwR6lb1nlvu/LdBk3VskuJYd6N/j30BRm5GZL5bJ2BsA
         3RXezV1e7Z1mJWlpYRnhetUD2kfGI9L2A/jYBXEffyi7Qyrd0kL492Evpv5mCaZHtavW
         ElPmgeiRSXdY/II8BTs4JJRd+Uq1KxcF7Sa0oFwD6bP1uvstf2vUL0vQxv1BwrUkDnUE
         xV82ujHEGKF7xTzKCC4FV3QPfw+UeEC9kzfWP/e/YAiuAdHC5/aGVEDEmc25NZu69ba+
         qzIwyrM1A1jo70raCE/wizASFwSlqvrTcPGPLhsRGmmO2mlo5/NhfWtu7/ES2BQeA5bm
         Du5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tx1YmCzTaRx+0xpO+uSdB0tU1cOLA9kXrIQzKxsMbJ0=;
        b=jzMSq/MxKoyj7bI6k6ZGq6YCa9WMIcoLqwxvcPbZIthxNiYOxQHSAp4OMSSCovuNaW
         Dr4OBTbJlForMi1Oe66PCrSYcslLoqnV9xhHOCqtKp8Q2RnospwOOdZwLqZIBlsbOQDB
         MToCfStWT8I0R+5x8hzmwY63BLEhAByMJVWPWFvj4K+CKsqtthuQcroZ/Nc23XIiRE1C
         EoNS5v9UHNUkQjgfuRnQCafEtMLrE2QBmM/xmykOC0nYiubRbfWmht6QOUUazwW/CNor
         bb8bYsHHsNQ9N9QmbPZj/QlfQx5WCt/B7DKN5TPJdxoXF1On9bIpYaQ2vdsuLoAIK9Dh
         Krsw==
X-Gm-Message-State: ANoB5pmScqikog2lJRairfdtUYBz6FYD/BEHGAdbm5VbLHLXsK2i1L7d
        i8JmPLZJoSEJmUH82OmC2BwB+A==
X-Google-Smtp-Source: AA0mqf7vTzLh66N+Zng3zmemOVzMEr8GlGtgse3xrMxH3Y3+NNj00nk2uTgiP5TEu1u3wxoRqdVgkQ==
X-Received: by 2002:a05:620a:990:b0:6fb:c6b6:e7a8 with SMTP id x16-20020a05620a099000b006fbc6b6e7a8mr6627389qkx.215.1668809443095;
        Fri, 18 Nov 2022 14:10:43 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z11-20020ac8100b000000b003a50ef44a77sm2629849qti.28.2022.11.18.14.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 14:10:42 -0800 (PST)
Date:   Fri, 18 Nov 2022 14:10:32 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
In-Reply-To: <20221118140346.b9026301b4ba03e43e15aeca@linux-foundation.org>
Message-ID: <a4a1cda4-547b-8274-8645-fa6ff274e42@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <CAHk-=whmq5gHrKmD3j=7nB=n9OmmLb5j1qmoQPHw1=VSQ-V=hg@mail.gmail.com> <93fa81ae-d848-58c2-9f70-27446bf9baa8@google.com>
 <20221118140346.b9026301b4ba03e43e15aeca@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022, Andrew Morton wrote:
> On Fri, 18 Nov 2022 12:51:09 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:
> 
> > But the first series has not yet graduated from mm-unstable,
> > so if Andrew and/or Kirill also prefer to have them combined into one
> > bit_spin_lock-less series, that I can do.  (And the end result should be
> > identical, so would not complicate Johannes's lock_page_memcg() excision.)
> 
> I'd prefer that approach.

I think you're saying that you prefer the other approach, to keep the
two series separate (second immediately after the first, or not, doesn't
matter), rather than combined into one bit_spin_lock-less series.
Please clarify! Thanks,

Hugh

> It's -rc5 and the earlier "mm,huge,rmap:
> unify and speed up compound mapcounts" series has had some testing. 
> I'd prefer not to toss it all out and start again.
