Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6D362F08E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241760AbiKRJIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbiKRJIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:08:31 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B11EDF88
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:08:29 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id mi9so2945788qvb.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4jgJCL3sHoSHtEVZaxlQfRVEHYZ212AYWgGq2TLVydQ=;
        b=a2wpWHTporknCd1s9pPc2LAMPddZOemCMFlzk3MqZj9hClmoNsmS0E8aopvfJ0Pk5O
         lfFrfDf1DQNA98cj2IqdkeThsGiioaNhdEU8x9FlasQAeG9gv77XVBLgXLtm22tb6ds8
         DElvqyoQ5RP2FEbXrxwuJJf5NAcRyBkmwlXZ/Wz3FSGRHEyGEfhZN2hofXa99LgGJOo8
         4kCB1BEjbjw2S5SOXetEdh2El/+g2g+xZEF1ZOVe2+LobsueOYobBJxZZboKv7bYMSWt
         Mr7iNpsDvn+j7ut/QE9PIa52pe8cXOGgIivGMEoYPa7h7RNB0ogvBM8QS2+Gg27TTadd
         69Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jgJCL3sHoSHtEVZaxlQfRVEHYZ212AYWgGq2TLVydQ=;
        b=BIjUVK4578uoEtcxIBs2JLX6CHFjhoMM+HkEguWlZ9USqpmJnKxwq0dUfoykfX8Nm4
         mLpiJy1jRn/VkbuAtF8DkhxNw6DiIlI9baFvQ/bQRfOhIIN8On4jz1O4nG/3FmYqwkHC
         +E1q3brdo4etMoNg3mmM3YnyqEwJvx2zRmMMS8UmnSPjqxDlc9E3Go0JlT1sdXOz91tq
         Ik+JurhmYg5WnRFTch5EKZRNEgMrTfS3Cd9sgjyWlITP9YnwfWcolwDjrRawt94QjVgB
         tTXztecx9tti517oykOK3dp/GKzk044EbjEAZ8NlfBYrPDZtUn78pT10g7x26EdvYux3
         6a3Q==
X-Gm-Message-State: ANoB5plMvWcSSLCkxmCy3EIQJSHenI+IEAGRbShYBoxeWhrx/WooE4rv
        GvapEV4b79u5uexIfRgkt/IFJA==
X-Google-Smtp-Source: AA0mqf4Vu51irMi7KMNB0pp/d3qI6KcnZMKnFehDL6rPbRalZElCeD38eKKA345/qu0r12lKOEloXA==
X-Received: by 2002:a0c:bf0b:0:b0:4b1:a359:c204 with SMTP id m11-20020a0cbf0b000000b004b1a359c204mr5893127qvi.64.1668762508583;
        Fri, 18 Nov 2022 01:08:28 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x22-20020a05622a001600b003a57f822157sm1765388qtw.90.2022.11.18.01.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:08:28 -0800 (PST)
Date:   Fri, 18 Nov 2022 01:08:13 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
In-Reply-To: <5f52de70-975-e94f-f141-543765736181@google.com>
Message-ID: <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
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

Linus was underwhelmed by the earlier compound mapcounts series:
this series builds on top of it (as in next-20221117) to follow
up on his suggestions - except rmap.c still using lock_page_memcg(),
since I hesitate to steal the pleasure of deletion from Johannes.

1/3 mm,thp,rmap: subpages_mapcount of PTE-mapped subpages
2/3 mm,thp,rmap: subpages_mapcount COMPOUND_MAPPED if PMD-mapped
3/3 mm,thp,rmap: clean up the end of __split_huge_pmd_locked()

 Documentation/mm/transhuge.rst |  10 +-
 include/linux/mm.h             |  65 +++++++----
 include/linux/rmap.h           |  12 +-
 mm/debug.c                     |   2 +-
 mm/huge_memory.c               |  15 +--
 mm/rmap.c                      | 213 ++++++++++-------------------------
 6 files changed, 119 insertions(+), 198 deletions(-)

Hugh
