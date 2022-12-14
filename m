Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8564D0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiLNUPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiLNUOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496F92DAAE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671048298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+0tEQ05NQldNFQ3k4Hd8AFQ3sr6rhffixZ6eCviwSyM=;
        b=TkBmAysYwdQoI/Flesq5zHlzopWR7IWlIwV931jnE/37XAngxrDegeECkIL8bld0jHpbXG
        L+h9SNRKC14AjY1IbixRWCLTgng8o3U4Awbuj2uh1BFutBWUp41LJfV+eLTsjgl1jaLv4Z
        IfitIm6x64DXmlK+LYpv86TK62k2NdA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-381-aKthudGxNkS1ffqaDkWl_Q-1; Wed, 14 Dec 2022 15:04:57 -0500
X-MC-Unique: aKthudGxNkS1ffqaDkWl_Q-1
Received: by mail-qt1-f198.google.com with SMTP id l11-20020ac8148b000000b003a81fbc3b3bso3072388qtj.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0tEQ05NQldNFQ3k4Hd8AFQ3sr6rhffixZ6eCviwSyM=;
        b=1TWf03VRMhLn5UFQVVF5csKKID8dfJBA0+bCo7Q51vCd1uzoGIV6hEhKfzB2GIR3KQ
         6tydktQSHBMorzUfyhZeiGL+kuo5oOZzyfVp0IqqbrAmRrodZGaDci+xpdO1Wu83tG29
         8dxyVDtuxp2hSK9wVSfJWM24dYdtVnOT6IVuqCbVZJMkBgnpCh09AJzuj+bhZ8Fp+N0m
         lMaYuA+bfz1Iov+fUsYoFH8gnbvxelyyCdye9T4J1PAPT5EkHqeCLEYKQmp3LdRys1Bn
         yY0yxOxDv1CJoDtlu2VagozvMaXgYz+AfP6dB6WpEjsN0/Y8CWgbEax8eWGDmvLrj73p
         MJ6w==
X-Gm-Message-State: ANoB5plOa6bvVBGdmAx4DFhtYnac5clKGgv++/OVmvyAlls7kx/PaaFy
        fTalKJ0YywT4qlvESLQPxQ/GZSMIQ7RWaX9M+VL7FqHL+JWdeBOdxmF0ejS3OD41RrxxMxAEq49
        EJUcvL/AKPWHh3H8zxnwSuOdSheoblKofXTe5A7Jd2KPrSlExHURi/77M3YM1Dg+AHGIdhvZHjg
        ==
X-Received: by 2002:ac8:7148:0:b0:3a8:faf:296a with SMTP id h8-20020ac87148000000b003a80faf296amr21615883qtp.54.1671048296190;
        Wed, 14 Dec 2022 12:04:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf61MiKdzyQd0u/ypYXorFpfgYGbyvVMeTrVNxGFhAntVd9JJHdDk3vcTBJAO8sRiCNxRyYGtw==
X-Received: by 2002:ac8:7148:0:b0:3a8:faf:296a with SMTP id h8-20020ac87148000000b003a80faf296amr21615862qtp.54.1671048295900;
        Wed, 14 Dec 2022 12:04:55 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id l11-20020ac848cb000000b003a689a5b177sm2199352qtr.8.2022.12.14.12.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:04:54 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Huang Ying <ying.huang@intel.com>
Subject: [PATCH 0/2] mm: Fixes on pte markers
Date:   Wed, 14 Dec 2022 15:04:51 -0500
Message-Id: <20221214200453.1772655-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
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

Patch 1 resolves the syzkiller report from Pengfei.

Patch 2 further harden pte markers when used with the recent swapin error
markers.  The major case is we should persist a swapin error marker after
fork(), so child shouldn't read a corrupted page.

No report so far with patch 2, but it can be somehow tested with things
like:
https://github.com/xzpeter/clibs/blob/master/misc/pageout.c
Plus some hacks.

Please have a look, thanks.

Peter Xu (2):
  mm/uffd: Fix pte marker when fork() without fork event
  mm: Fix a few rare cases of using swapin error pte marker

 mm/hugetlb.c  |  3 +++
 mm/memory.c   | 14 +++++++-------
 mm/mprotect.c |  8 +++++++-
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.37.3

