Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A15F6E513C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjDQTyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDQTyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F35159E8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681761202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ebFG+472EPgV/DQISB+I4k3P3R91wLCZUBIgWp1pKI8=;
        b=isxPKGPVkPx5j8RX5RPo3mH1eXcYY0Gd+oHPlKHHsBubU1H5Kp79MlUX9zvKn4OTc8ZjPG
        7GEAwyJccjoWt+KIUCMVjCOEI4rjhJ1Gg5fEGbcCbiOOefGW5SNfbnOBmKNYzy75SiZhvq
        bTfNfMWMS3uKD3lTVh5GvBM2FfIe3tU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-UVKm5D07MYu31SCrmKTefA-1; Mon, 17 Apr 2023 15:53:21 -0400
X-MC-Unique: UVKm5D07MYu31SCrmKTefA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ef3116d1dcso1936911cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761200; x=1684353200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebFG+472EPgV/DQISB+I4k3P3R91wLCZUBIgWp1pKI8=;
        b=E9BC8hjC0LUoje1NMgnMFO6LPEsuvfx30MOue2xbN4GzNFEhKmGM+nTaSTJPr/grO3
         3iL2FamspD/ZPZdVAQvd5Kpg4TdsUxE78lKBe3HNzP3BHQKS1zITHZvS2zNb8s7MJ/Sh
         VSJWV/TecxcxMcRre9PtMGcrFn0iutGMWd49ixQMSq8IsTdLYdkgna5KVD5wSoR0YU4N
         7U38JT3Q+qlur5Dll7ND0PKPH/rkcp+6zQyRT+WKEwxJY4DGXut2mxK7+oDmx9iisnJL
         J1kMCZQoNpxMFir0BaCPxTW+J+h/5hP8742u2UKVJvMQH52zek2kK9cBuRw7QTrIEK8G
         +9XA==
X-Gm-Message-State: AAQBX9d7Gu0ibgItuLMFDkz90gaxD2JtMHwt8i80JaNBZnVQ3IjETdti
        Nd9vN/2Ydk+ldgQK8X1p/cQtsWUzD2EFUPH9gn/3HaOUlUnLyPVwvK7PN1ZA39s0rpM9XdQxuX+
        Xcc4EOpwE4KREJdvca9bypH9RraTVr4bcAhuE3tYDXMwlU74k3wu8vwigB7nksQGtThg8kwBsZR
        YVSeJ65A==
X-Received: by 2002:ac8:5e0b:0:b0:3ee:5637:29be with SMTP id h11-20020ac85e0b000000b003ee563729bemr9983926qtx.5.1681761200087;
        Mon, 17 Apr 2023 12:53:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y7FmrLa3ajN6sxzqw5IZyM7aQ1g+z9cTCpvCk6Tr9Ciuz7Fh5tTLjRr0XS17ftu31HbsFXKA==
X-Received: by 2002:ac8:5e0b:0:b0:3ee:5637:29be with SMTP id h11-20020ac85e0b000000b003ee563729bemr9983891qtx.5.1681761199702;
        Mon, 17 Apr 2023 12:53:19 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id r17-20020ac87ef1000000b003edfb5d7637sm1731278qtc.73.2023.04.17.12.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:53:19 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/6] mm/hugetlb: More fixes around uffd-wp vs fork() / RO pins
Date:   Mon, 17 Apr 2023 15:53:11 -0400
Message-Id: <20230417195317.898696-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Added R-bs
- Fix patch 1 issue on hugetlb swap entry [Mika]

This is a follow up of previous discussion here:

https://lore.kernel.org/r/20230324222707.GA3046@monkey

There, Mike correctly pointed out that uffd-wp bit can get lost too when
Copy-On-Read triggers.  Last time we didn't have a reproducer, I finally
wrote a reproducer and attached as the last patch.

When at it, I decided to also add some more uffd-wp tests against fork(),
and I found more bugs.  None of them were reported by anyone probably
because none of us cares, but since they're still bugs and can be
reproduced by the unit test I fixed them too in another patch.

The initial patch 1-2 are fixes to bugs, copied stable.

The rest patches 3-6 introduces unit tests to verify (based on the recent
rework on uffd unit test).  Note that not all the bugfixes in patch 1 is
verified (e.g. on changes to hugetlb hwpoison / migration entries), but I
assume they can be reviewed with careful eyes.

Thanks,

Peter Xu (6):
  mm/hugetlb: Fix uffd-wp during fork()
  mm/hugetlb: Fix uffd-wp bit lost when unsharing happens
  selftests/mm: Add a few options for uffd-unit-test
  selftests/mm: Extend and rename uffd pagemap test
  selftests/mm: Rename COW_EXTRA_LIBS to IOURING_EXTRA_LIBS
  selftests/mm: Add tests for RO pinning vs fork()

 mm/hugetlb.c                                 |  31 +-
 tools/testing/selftests/mm/Makefile          |   8 +-
 tools/testing/selftests/mm/check_config.sh   |   4 +-
 tools/testing/selftests/mm/uffd-unit-tests.c | 318 +++++++++++++++++--
 4 files changed, 314 insertions(+), 47 deletions(-)

-- 
2.39.1

