Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F556AD0B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCFVkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCFVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:40:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0E3B221
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678138769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WDt24Uf5+E3IsPxqM3v9POMr36n8o93nXZKrGMIf14c=;
        b=cjZ9Ihbp9UEvEMit6RUb5ee+SOjwjPScUfC4Mfah6blrSLwUgxFJPzJxxkQ0uzSHhETTOc
        kBMRpXkbJztFcv2Gldv6sn2oKhtVWJftfzSbHe6oVlmSvAQfF6KwqXhOMXfVLocWr+75uT
        wy8Hpv6nL0QBCwb/39MlttfzkgqC+m8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-RvdrTPUANqqWtjMVeukfng-1; Mon, 06 Mar 2023 16:39:28 -0500
X-MC-Unique: RvdrTPUANqqWtjMVeukfng-1
Received: by mail-qk1-f197.google.com with SMTP id c13-20020a05620a0ced00b007422bf7c4aeso6308319qkj.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 13:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678138767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDt24Uf5+E3IsPxqM3v9POMr36n8o93nXZKrGMIf14c=;
        b=mmCf0BZXnigaL0Z2OeXd8iKyQaPM1Ppt/UDd/p2IGGBGBXL7BlsgfY/CPpxDInut7x
         0crab/AVJdvpU040pxWKJ9mpAD9Jl2x25u0S2al4dzJyYCnY/6We+Y/KoDkeEGN7H9zj
         czg8FAJ+R6AZHG599wlnJ4UIebffgqy/sIVJCVftIbDL/kJHFdrud4PYuPFaa3NqmAXy
         Amo2aG70ZXERcIV55Hk3I+O2I8dRzn6o7T/mv/ubZloWDLbnsLZhJj092fz0Iu59XyRr
         uazStHRzcW0i5oZBBFqxBpHtbPgTBWYXP837B9SW40G9QcUpMMvXAN6CX0LxE6s59mlM
         eKXg==
X-Gm-Message-State: AO0yUKV4atlQNYrWikcJsbFiS9ErRZOfEbuRH47OYlkBNd2SMzEfObD6
        zeR0vXp6ghH3C52SVHT65CPg0oKRtaiykj5WDpTXTosSElG/zqOi7bwuHTBu+MLUnbXDUzbTxGh
        xNpgkMrHzCAdzShCHpRyV6lil
X-Received: by 2002:a05:622a:148:b0:3bf:c382:7abd with SMTP id v8-20020a05622a014800b003bfc3827abdmr24256410qtw.6.1678138767603;
        Mon, 06 Mar 2023 13:39:27 -0800 (PST)
X-Google-Smtp-Source: AK7set9gvk7iwq0Oz79/PSPE5Dcre7oN76C1jvcTeDr8aO4o+8NyEmIHiqxcqTZUl5H1N2fanOy3xA==
X-Received: by 2002:a05:622a:148:b0:3bf:c382:7abd with SMTP id v8-20020a05622a014800b003bfc3827abdmr24256380qtw.6.1678138767340;
        Mon, 06 Mar 2023 13:39:27 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id e20-20020a05622a111400b003bfa66b7484sm8522884qty.35.2023.03.06.13.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 13:39:26 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 0/2] mm/uffd: Add feature bit UFFD_FEATURE_WP_UNPOPULATED
Date:   Mon,  6 Mar 2023 16:39:23 -0500
Message-Id: <20230306213925.617814-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v3 of the patch(set).  Old versions:

v1: https://lore.kernel.org/r/20230215210257.224243-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20230227230044.1596744-1-peterx@redhat.com

Comparing to v2, this fixes a bug that Muhammad reported on reading none
pte failure after wr-protected with WP_UNPOPULATED.  I also split the test
into a separate one.

The new feature bit will make anonymous memory acts the same like file
memory on userfaultfd-wp in that it'll also wr-protect none ptes.

It can be useful in two cases:

(1) Uffd-wp app that needs to wr-protect none ptes like QEMU snapshot, so
    pre-fault can be replaced by enabling this flag and speed up protections

(2) It helps to implement async uffd-wp mode that Muhammad is working on [1]

It's debateable whether this is the most ideal solution because with the
new feature bit set, wr-protect none pte needs to pre-populate the pgtables
to the last level (PAGE_SIZE).  But it seems fine so far to service either
purpose above, so we can leave optimizations for later.

The series brings pte markers to anonymous memory too.  There's some change
in the common mm code path in the 1st patch, great to have some eye looking
at it, but hopefully they're still relatively straightforward.

Thanks,

[1] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/

Peter Xu (2):
  mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
  selftests/mm: Smoke test WP_UNPOPULATED

 fs/userfaultfd.c                         | 14 ++++++
 include/linux/mm_inline.h                |  6 +++
 include/linux/userfaultfd_k.h            |  6 +++
 include/uapi/linux/userfaultfd.h         | 10 +++-
 mm/memory.c                              | 56 ++++++++++++++++------
 mm/mprotect.c                            | 59 ++++++++++++++++++++----
 tools/testing/selftests/mm/userfaultfd.c | 45 +++++++++++++++++-
 7 files changed, 169 insertions(+), 27 deletions(-)

-- 
2.39.1

