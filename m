Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F86C57B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjCVUeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjCVUds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:33:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D087968FB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:25:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w9so78004452edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679516667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFiAU6kcHoigzDtMXwhFSfPfpz2SNfjgCvziPh6MpgE=;
        b=g6gAfQ2tMtyW7znnqkb64BkQCCeOTrSTqUsEP4mxaiVMzv9u06C25j/Misejy59xjh
         rRRQXRKcX1ic7NSR5DKC5FVbBlBDy9crJletBWsfZ+EFOta41M1m3r/r7ncS5DEZbxQU
         zXfYjsHEf+Z+gwSKeEA26YZ6Tc6C9v4TRQeqgy4gvnigkeqCm28aRUjf/1vP41nDvTrX
         vQhdlMYoN03/t31003Ha0zKcm6i8vOAvWvfGyfkH5YzUwL2sqOQSHKZ642Say6BSPHfC
         kwOVkZtpS+JUJIba4/2NuSgC2E2aqZLpcwN/C694XOZcVIncE/TjoeYXVl1ibxDFe3P/
         W1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679516667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFiAU6kcHoigzDtMXwhFSfPfpz2SNfjgCvziPh6MpgE=;
        b=yrE4rxm88zAuo7lhupMU2SYfnau4BynqmZza0jZsVPhUfXA2i53HMfRHU/5vU5v5vF
         jv4m3X3/J5phSTBZTG1vn8sVJFETkiENkTWttqrdMvSiyOQmPU8TKfE69IZtE1IrIomg
         2C71utjZGjd4HuIH5DrcRH/b6YQ0NdIicGkd7criLuHF2eW7BDtF4UmBaMF3vPWL50Vw
         jkl+vbLeYP1dcbxduVEDd0hiJgaX5Dn7ZnLAXM3wMluOPO9zf5Nj7Sn335Zm1bOX9gIb
         LosaClYiMayK8BbqOpzFJrlpCw082IFGXZeBMHgKp4cYfdiqu3NgrlP4sRmMaJiR5OFe
         dn/A==
X-Gm-Message-State: AO0yUKV55mP/ggbWqog5zuMSFiVRG5jlkeCa+wGtTyTS817WmLCapXi4
        6ZMmqrsG13Uizq5RmsTsQKpu9NgmMxE=
X-Google-Smtp-Source: AKy350a3xpjOlkK7w+KfhYsEbFs37Ieqct5P7hE3kgxprKFW39C6yLjQE6YTy1UDhlV26vuO0YfBag==
X-Received: by 2002:a5d:4b44:0:b0:2ce:ae2b:cfe1 with SMTP id w4-20020a5d4b44000000b002ceae2bcfe1mr778903wrs.4.1679515765466;
        Wed, 22 Mar 2023 13:09:25 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id a7-20020adff7c7000000b002c70ce264bfsm14664342wrq.76.2023.03.22.13.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:09:24 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 0/4] further cleanup of vma_merge()
Date:   Wed, 22 Mar 2023 20:09:17 +0000
Message-Id: <cover.1679515236.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following on from Vlastimil Babka's patch series "cleanup vma_merge() and
improve mergeability tests" which was in turn based on Liam's prior
cleanups, this patch series introduces changes discussed in review of
Vlastimil's series and goes further in attempting to make the logic as
clear as possible.

Nearly all of this should have absolutely no functional impact, however it
does add a singular VM_WARN_ON() case.

With many thanks to Vernon for helping kick start the discussion around
simplification - abstract use of vma did indeed turn out not to be
necessary, Liam for his excellent suggestions which greatly simplified
things, and Vlastimil for his careful review and feedback.

v4:
- Mention 'A' -> '*' in commit message.
- Various small nits.

v3:
- Combine vma_lookup() cases and reinsert accidentally excluded next = NULL
  assignment.
- Reword commit messages to more correctly reflect the current changes.
- Avoid multiple assignment to prev, take vma_start, vma_pgoff assignment
  out of the local variable declarations and revert to setting in if (prev)
  block.
https://lore.kernel.org/all/cover.1679468982.git.lstoakes@gmail.com

v2:
- Put the patch series on a serious diet, cut comments down to avoid
  bloat.
- Added clever use of find_vma_intersection() and vma_lookup() as suggested
  by Liam which improved clarity + brevity significantly.
- Eliminated the use of a temporary vma local as suggested by Vernon, it
  does seem this was ultimately adding confusion and Liam's suggestions
  eliminated the need for this.
- Moved around initial variables to be more sensible and to initialise each
  variable in one place where possible.
https://lore.kernel.org/all/cover.1679431180.git.lstoakes@gmail.com

v1:
https://lore.kernel.org/all/cover.1679137163.git.lstoakes@gmail.com

Lorenzo Stoakes (4):
  mm/mmap/vma_merge: further improve prev/next VMA naming
  mm/mmap/vma_merge: fold curr, next assignment logic
  mm/mmap/vma_merge: explicitly assign res, vma, extend invariants
  mm/mmap/vma_merge: init cleanup, be explicit about the non-mergeable
    case

 mm/mmap.c | 138 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 71 insertions(+), 67 deletions(-)

--
2.39.2
