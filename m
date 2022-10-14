Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FF55FF073
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJNOja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJNOj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E5A1D52EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665758364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lTZutTqg6l/tUb0ClIPj0CXP2uGe9pth4vROQpMfvV8=;
        b=Yz3D+V4Ua4I8ugO/N1anyaHjM6aOUTSLRmltj5i8E/lGlMK4Z/yUd33V+41Ig/yhzY+8XM
        N/0G15xAeTRKrUJYT+nCjecMxp/1HjSQo2VaujZX+oB+/fl/OJvMFHxlpLDFzGOyNk3oJY
        xonFdyROpTotiFuWlQ+9sf30k4/Hi+Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-65-FFLHy17LMs6FHyMZPqT4gg-1; Fri, 14 Oct 2022 10:39:23 -0400
X-MC-Unique: FFLHy17LMs6FHyMZPqT4gg-1
Received: by mail-qk1-f198.google.com with SMTP id h9-20020a05620a244900b006ee944ec451so3616837qkn.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTZutTqg6l/tUb0ClIPj0CXP2uGe9pth4vROQpMfvV8=;
        b=bmRxdiy0qRgcP/JvQozArVwIMPGvz5FKZV1NjiUjwpxCIHhiuR9vVIL7k2bNGOfycv
         jmWeYNdqf1W4x9GJ0rsx2PnpXXGGRi0O4aQa8az973++zc11F+2GKUzWmFTtQ2Q3Q0/N
         CEMAOg+3wHadQgF7r7jLKHMRGrTAhY3T47f2z/1IJuA2prkfv1QEgGBOOERU6NTKL77G
         LFQr4O2i5d0cAHRP/tuw/cdhwej3obr230Pmg9drP+iLsr8oq1RiDNu46PYAXgEWoXF6
         FrJaf7YDC2WSPQelSEvx/JovnA3eGKrC8SIflVWPP8mSs/JxY/dLp4AlG16Xz7iQLBzj
         FQPg==
X-Gm-Message-State: ACrzQf3rwrUQdRopNdQ2RMMIivfu9BcH5aGdRJwc4J7x7hlisBMIyizJ
        Eaj2G2Arr3B61KstxJ6R9l/Oh9dJp5vjeu0HtukkUj/CWE9QEL69gyCyVOTgpIAjQg23BoXRGTf
        UBIEd9BE/TpFAaCmo8bSJtQOSgM2mUUJQt3xYVB/7NzR5A24L5LA6NtfS81p6XFjTASXrAdPPoQ
        ==
X-Received: by 2002:a37:8003:0:b0:6ec:5699:1c8f with SMTP id b3-20020a378003000000b006ec56991c8fmr3951679qkd.671.1665758363060;
        Fri, 14 Oct 2022 07:39:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5o3SRxSl0SJVuIq5do40FGeFeJlSgZ3Z6fkt8XcS9T/i+Xokcu5XDx6cUajafMQ0jJNwPyUA==
X-Received: by 2002:a37:8003:0:b0:6ec:5699:1c8f with SMTP id b3-20020a378003000000b006ec56991c8fmr3951658qkd.671.1665758362796;
        Fri, 14 Oct 2022 07:39:22 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q4-20020a05620a2a4400b006ec09d7d357sm2675541qkp.47.2022.10.14.07.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:39:22 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 0/4] selftests/vm: Drop hugetlb mntpoint in run_vmtests.sh
Date:   Fri, 14 Oct 2022 10:39:17 -0400
Message-Id: <20221014143921.93887-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Add r-b for Axel
- Patch 1:
  - Changed subject to "selftests/vm: Use memfd for uffd hugetlb tests"
  - Touch up example to reflect the cmdline change [Axel]

Since I started working on patch 1 when debugging the race anyway, I
cleaned it up so we can use the same memfd for both hugetlb and shmem which
is cleaner.

Then I figured it's not hard if with patch 1 to replace all the file-based
test to use memfd for hugetlbb so I did.  Then patch 4 dropped the hugetlb
mntpoint for run_vmtests.sh.

Please have a look, thanks.

Peter Xu (4):
  selftests/vm: Use memfd for uffd hugetlb tests
  selftests/vm: Use memfd for hugetlb-madvise test
  selftests/vm: Use memfd for hugepage-mremap test
  selftests/vm: Drop mnt point for hugetlb in run_vmtests.sh

 tools/testing/selftests/vm/hugepage-mremap.c | 21 +++----
 tools/testing/selftests/vm/hugetlb-madvise.c | 12 +---
 tools/testing/selftests/vm/run_vmtests.sh    | 18 +-----
 tools/testing/selftests/vm/userfaultfd.c     | 62 +++++++-------------
 4 files changed, 36 insertions(+), 77 deletions(-)

-- 
2.37.3

