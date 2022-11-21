Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EE6632A28
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiKUQ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKUQ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:59:43 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7E2C8454
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:59:41 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id n16-20020a170902d2d000b00189082beeb4so6221598plc.16
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1E4/GFb9ka3QG/dqe1GLOVhL1X2renMDEhnGD/6nC4=;
        b=icI3QdnVXbEM9Zb9gKG4OS8A102V11jOmTdeKnZkJFoahQg4uNVCTchDDCo2oKkBsD
         SNLhbWrGSgPB1+eK5ksS7hZeeGnEKC+c+5Xgy6232GUS/DlRfEXQYJ8+Zwf7cyEPCsBs
         KvUZ1zJCSL9G+UpqjOdi2JF5vLC2iuoCyhVOBqzekSGezGiRa+yGSG9BbNZK7pjizDg2
         zxhAp2Bo4znrkfnREeAaONnXRoOe6Pi05x5MJD7Sb262M533o2UBrURGmT8Gx8SCpEqa
         25XAivGsGrnR1gLaYZglogvdS7b5HyNFHIZ6c4+ZPW42m/ArG3ZSE/kfOFu4Hkh/tIZO
         rKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1E4/GFb9ka3QG/dqe1GLOVhL1X2renMDEhnGD/6nC4=;
        b=N+QbJ+K39c9gCP/aUxmUbyk8DuP0KXT9TdaMo2m/RZkqGKpANxzZYy8v4aMB6F2t8s
         ibyJNCspH3+eZVuMZcrvEJXS7Z78BDe1sZwacIbBvYw9vVoo6UNQ6T13oTMVOV/bJEgM
         coyxMMkn/0+fwDNacWrbA8lVbr1VCSJbcnNYjhSUX+R/d9+dLITbCS30SOt4VicPoAA4
         s6CMPl6fQ0XKcgAqZXyYgNRcpvW0aP5Bupr35gaaUEMC9yN+bXa/boGOM37FENs5RtAC
         ftYYqoegY0hsiwFb3sIqdGJKLn1ytdRkoHLiAtzWwL/E0ffyHHLH5OtFvycwqzif/G0O
         r3qw==
X-Gm-Message-State: ANoB5pmGuHczBaLAiBCUT1vHwJ3xm6yntJaeH+rFIy+q4fKS2Nyql0V7
        OmvepCrephJBqvMLjLZ0ZbUwNAeXrqvPDw==
X-Google-Smtp-Source: AA0mqf69hXs2A4b62Pa/iZ4hqssDJMLyatcRLiTK7Fys42pJ6eLymex3hwCZxzSrnHEGLu8Qk/UdeD2ae0FI8g==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:330e:b0:56c:d93a:ac5f with SMTP
 id cq14-20020a056a00330e00b0056cd93aac5fmr3712874pfb.48.1669049980947; Mon,
 21 Nov 2022 08:59:40 -0800 (PST)
Date:   Mon, 21 Nov 2022 16:59:38 +0000
In-Reply-To: <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
Mime-Version: 1.0
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
Message-ID: <20221121165938.oid3pemsfkaeq3ws@google.com>
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
From:   Shakeel Butt <shakeelb@google.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:08:13AM -0800, Hugh Dickins wrote:
> Linus was underwhelmed by the earlier compound mapcounts series:
> this series builds on top of it (as in next-20221117) to follow
> up on his suggestions - except rmap.c still using lock_page_memcg(),
> since I hesitate to steal the pleasure of deletion from Johannes.
> 

Is there a plan to remove lock_page_memcg() altogether which I missed? I
am planning to make lock_page_memcg() a nop for cgroup-v2 (as it shows
up in the perf profile on exit path) but if we are removing it then I
should just wait.
