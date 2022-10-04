Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA6C5F3AB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJDAhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiJDAhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9361D29358
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664843829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a+4neDEGm4qY5mM8TS4YY0MjY3kwM/R5AbLZxz3+qnY=;
        b=NPbrqL0tGMXIOE/sUndLuCdH/LVHG3+ByZDJ6pVIzHMr6ktLR971PO38GRxowQ10bWmRvz
        4VCS1jyLdpfIH1OkpXLNXrXpk8bBg9l+30BywR/7FObjDneN8FVfSnA9SfczIrl8RtFJAo
        98jUBy0InsJ36KkHf84racsTTqGK6Uo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-uy0PhskEMmuwZZH6Fo0y3A-1; Mon, 03 Oct 2022 20:37:08 -0400
X-MC-Unique: uy0PhskEMmuwZZH6Fo0y3A-1
Received: by mail-qk1-f199.google.com with SMTP id w10-20020a05620a444a00b006ce9917ea1fso10394977qkp.16
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=a+4neDEGm4qY5mM8TS4YY0MjY3kwM/R5AbLZxz3+qnY=;
        b=i9VI+ZjUhhQM2+7x5vjBFaZBOllAhjQvmw5QHyVqsKthliii77WqmcvqyBVNEDSTvm
         nNcpK8QECDPzCzDoMdMCLoG9C6Pe+IpuHS3KaaZjvQmtkdk28OBltqYV1tQYHksadtNZ
         0T5ZdWDOwqd5XRlqyORF9+ItL873o7OpCZU8t/K5KdApXJcgUXtEFuIzt3wCflwZZRh4
         2S+ry4mak6QlzFp5roc2vaKwqUn9IyjDbkfvXtnRgvba53SzlBpvPKnFmmQo9VY65/VH
         NZN6G+2BDKxPt6AKKhcsBxjYPtitFYPIfG0XB7agkU0rJYQa62W9MR1nFaqQF8hOjkc7
         2SWg==
X-Gm-Message-State: ACrzQf1uxreUUtk2A5PcjgqXflYi0vyOVDGoUKC9pc1LofvdeNUqOamf
        o8ucSC6LjAnIy+DruW0eFOCFBo07E6XC51Uv+P9u1yweBPzgbeTTSQ4aThP+MtZyhsGzAu97zu+
        WbtohdBewWfZnbQP9uIIGqGDhSKAltwAVbD4t0zMcCJ7f32RlerQcu+K5vpgcDgv6wtAzTQtmuA
        ==
X-Received: by 2002:ac8:5953:0:b0:35b:ab1a:ff09 with SMTP id 19-20020ac85953000000b0035bab1aff09mr17755054qtz.144.1664843828038;
        Mon, 03 Oct 2022 17:37:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6oIbv4111ipisxZpy1VyfdEf/bNYfh0MKHzB7EDgYemIqOR3iCFBPWDoRKNWFWin16V0hhDA==
X-Received: by 2002:ac8:5953:0:b0:35b:ab1a:ff09 with SMTP id 19-20020ac85953000000b0035bab1aff09mr17755036qtz.144.1664843827792;
        Mon, 03 Oct 2022 17:37:07 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u30-20020a37ab1e000000b006bb9125363fsm12228104qke.121.2022.10.03.17.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 17:37:07 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 0/3] mm/hugetlb: Fix selftest failures with write check
Date:   Mon,  3 Oct 2022 20:37:02 -0400
Message-Id: <20221004003705.497782-1-peterx@redhat.com>
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
- Fix the commit message of patch 1, replacing CoW with wr-unprotect
  example

Currently akpm mm-unstable fails with uffd hugetlb private mapping test
randomly on a write check.

The initial bisection of that points to the recent pmd unshare series, but
it turns out there's no direction relationship with the series but only
some timing change caused the race to start trigger.

The race should be fixed in patch 1.  Patch 2 is a trivial cleanup on the
similar race with hugetlb migrations, patch 3 comment on the write check
so when anyone read it again it'll be clear why it's there.

Thanks,

Peter Xu (3):
  mm/hugetlb: Fix race condition of uffd missing/minor handling
  mm/hugetlb: Use hugetlb_pte_stable in migration race check
  mm/selftest: uffd: Explain the write missing fault check

 mm/hugetlb.c                             | 62 ++++++++++++++++++++----
 tools/testing/selftests/vm/userfaultfd.c | 22 ++++++++-
 2 files changed, 73 insertions(+), 11 deletions(-)

-- 
2.37.3

