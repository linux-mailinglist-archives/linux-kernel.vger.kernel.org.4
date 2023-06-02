Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49916720C30
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbjFBXGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjFBXGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAB11B9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685747158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5USYmygKDAknHQBixzUNP1oGMXwkEWqz0+1Nrqkoh28=;
        b=fcxfMIdviI1E2XOu7LsueCpPfQBiBwj8UHJl2gm5fZsj/GBi+BBLxHhHuVeuh339BPma0L
        NSCeilkuQNnKPUac3fn+6gW/AbF9J9N2l3Jj8UPTvjfJJMY6WFgNPpisAu0owCd7ZARLp6
        O971LtKECPybK5EyguRBkJCdP1NxsOE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-dhlwNUPgM0yPgTXrHbzW1w-1; Fri, 02 Jun 2023 19:05:57 -0400
X-MC-Unique: dhlwNUPgM0yPgTXrHbzW1w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-626380298d3so5604586d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 16:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685747155; x=1688339155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5USYmygKDAknHQBixzUNP1oGMXwkEWqz0+1Nrqkoh28=;
        b=bWR9fyhGA3eo0jL8W5tKkUAvr/n/C1ZaTQps5Kgv5qqH/M3yl68tABnB/v8BcVe1nd
         mtynegSUUq2vGadnRdSwqxQgLvFFsKb5snk1WaomsEOPkP5icaypQWJCwVu8tu+/YmKp
         m2M6zjklyLIDSy/iBIs/Gh8ekLK3kHGBbWmg03cBdZyEx4oXugoF+PmRpGiskPnmMjLs
         RY3VCJnoINx7Z6AgrmNSEZEVYBqHBOwj6YC+iym5xohsGNcS5aQ9aj3OTL/QXYos4hTj
         /2Snz9PNmKq/NzTnh9Bp6X5KhsCzZ8tX4ONHcq3lVwFT8GK5PCujxMwrOfk8sF7gZazA
         1f2Q==
X-Gm-Message-State: AC+VfDzva3nAktN5UaK2TDKXY+lvWeLZtY7aFgT2NZssc/tlCcRbxadL
        REd1q/cdBIPANKLuJkdyvdsf3Cjp0askkHUKUO+nwOxe5pd+D23PVVLueY98MwyNgyOlWADObfY
        eIdE2dnwusWxmkqQ+YG3DMGLQUJAIRGqoVQXEHY2jn3n9w5t3MQlcV936VrNopq4ZeMx88yT5PQ
        mekx30Xg==
X-Received: by 2002:a05:6214:765:b0:5ed:c96e:ca4a with SMTP id f5-20020a056214076500b005edc96eca4amr11522579qvz.1.1685747155520;
        Fri, 02 Jun 2023 16:05:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zBW8bDFsUjk7fA/CJgsE85iK/WMcreCCS3pLaQNDDC02CEbjppQ5TrD6awKIlrqx7BlUi9w==
X-Received: by 2002:a05:6214:765:b0:5ed:c96e:ca4a with SMTP id f5-20020a056214076500b005edc96eca4amr11522545qvz.1.1685747155195;
        Fri, 02 Jun 2023 16:05:55 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id px13-20020a056214050d00b0062607ea6d01sm1400792qvb.50.2023.06.02.16.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 16:05:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, peterx@redhat.com,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 0/4] mm: Fix pmd_trans_unstable() call sites on retry
Date:   Fri,  2 Jun 2023 19:05:48 -0400
Message-Id: <20230602230552.350731-1-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hit pmd_trans_unstable() under mmap read lock, it means we raced with
something else.  Per the comment above the helper, we can definitely treat
it as some pmd (none?) but the 100% correct way is always retry, and I
don't think it should race again in most cases.

Not taking care of that retry can mean different things on different
paths.

For example, for smaps it means inaccurate accountings when we skip those
raced regions, but it's fine anyway because the accounting is not for 100%
accurate.

I think it's broken for pagemap OTOH, because we have the pagemap buffer
linear to the VA we're scanning, it means if we skip some region the follow
up scans can fill in the wrong slots, I think.  It means the pagemap
results returned to userapp will be wrong when very unlucky.

This reminded me that I should have a look at all call sites of
pmd_trans_unstable(), some of them are alright but I do see many of them
may still be better to give another shot when hit.

This series tries to resolve all call sites for it on that retry attempt.

I really don't know whether I missed something, even if not, whether it
matters a lot to anyone.  Still, _if_ I'm correct may worth consider
fixing.  Happy to be prove wrong.  Then Muhammad should know how to code
his.

The patchset is only smoke tested, nothing wrong I see.

Please have a look, thanks.

Peter Xu (4):
  mm/mprotect: Retry on pmd_trans_unstable()
  mm/migrate: Unify and retry an unstable pmd when hit
  mm: Warn for unstable pmd in move_page_tables()
  mm: Make most walk page paths with pmd_trans_unstable() to retry

 fs/proc/task_mmu.c  | 17 +++++++++++++----
 mm/madvise.c        |  8 ++++++--
 mm/memcontrol.c     |  8 ++++++--
 mm/memory-failure.c |  4 +++-
 mm/mempolicy.c      |  4 +++-
 mm/migrate_device.c |  9 ++++-----
 mm/mprotect.c       | 20 +++++++++++---------
 mm/mremap.c         |  4 ++--
 8 files changed, 48 insertions(+), 26 deletions(-)

-- 
2.40.1

