Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB136C5798
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjCVUaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjCVU3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:29:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C892A992
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:20:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l27so10033838wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679516344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ULNFGmgjlrGeScNdGFqUo+Do+eHDgxaOWgwKJGAicVc=;
        b=DV82tGJ6ztr+hx8zuEea02ViH8ImWV2I9MZlbTPQ0lhLy+Lp7fQZfurPuCnBwUED5V
         NblGIrtNp/WMgHsGdLh1jH5e4e8DZtr7CZjXrR8/dAswGkoaSyoDMeef32bThqms3BCG
         2/HJFXyfLS1LpqhxMWbgyNgbgylobOezGCOQ9sVf+EBT3iBBisLeeRZZSiV8lVwOu6Jg
         kDyfeCJPyAECAkd7CVGlfIwC7NsEUqfOpAsU0aRqq3fBAt+wVhLZ5BPVZjkH3LofwN1y
         BLgrPmw5yn45GGTK1PnPh+FBjv2lH2QaIrDXN/5hyvsNlyB6utPGtqXmBIOySsOfocdR
         VURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679516344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULNFGmgjlrGeScNdGFqUo+Do+eHDgxaOWgwKJGAicVc=;
        b=xuaWPAib3ygbrp6iy01lyu6S1xb/6ttDiGrfBEaq8hKNKDQe162z6PY0ndyK+83IOv
         AhTIzeAvu9E9EZVK6MzLZjSnPTNGtzoXsKFaoqMjdOEBTEh/UqmNU4Ov/mOmNhr4Bg48
         ZI2j6kpBo0Yf8VoyQtmrLzgIcoxsBWRuNuVWx5vNOnQKITCYPNtAUu2KRl2Jl/DCNww8
         l15hr+ck6T9BggWwxpIFq+DG1L9eJEeuevQF5jAe+iuLlkeOIR1qkUr5wUBf7arkCVEb
         01D0kY0e9Mjql/+aMx5gSSUgtnrns+w5SSSZ46dV7xXEh8A4zxUIc05l7h+Nj3c0ryNm
         ZGkg==
X-Gm-Message-State: AAQBX9eWKJ7jKQxsxw2PIbQRJ3ATfrtCauWoE2pq6JKSdWO9/aAbUvGf
        LtX1H/oZzAW89UbbIHxvkbs=
X-Google-Smtp-Source: AKy350YpnNeH0mDZje6H1d+VJiZj5cUFCmhc6lDzBEFyHfpr5+NNkdcuV39QfuWdYgwwKy96OyurwA==
X-Received: by 2002:adf:fc12:0:b0:2ce:a8e9:bb35 with SMTP id i18-20020adffc12000000b002cea8e9bb35mr825984wrr.3.1679516343637;
        Wed, 22 Mar 2023 13:19:03 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e4-20020a5d4e84000000b002ceac2ccc4asm14570690wru.23.2023.03.22.13.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:19:02 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v5 0/4] further cleanup of vma_merge()
Date:   Wed, 22 Mar 2023 20:18:56 +0000
Message-Id: <cover.1679516210.git.lstoakes@gmail.com>
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

v5:
- Fixup typo.
- Fix email client snafu with duplicate cover letter.

v4:
- Mention 'A' -> '*' in commit message.
- Various small nits.
https://lore.kernel.org/all/cover.1679515236.git.lstoakes@gmail.com

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
