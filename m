Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808466C5762
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjCVUUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjCVUU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:20:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAC399C1B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:10:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d17so9887217wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679515767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFiAU6kcHoigzDtMXwhFSfPfpz2SNfjgCvziPh6MpgE=;
        b=g0oMOR67khKD+EmgWCaa5Bd2pTHSpJN5yRpqyHrXr2cyO+zAtd0D3Vl+FUouPFy1fO
         T/HmIw1ImffUyL5uxX43xNllJpxgFsU43DjUP5lTfEHtSyGgxTRaE6lgazp1CZvDWkko
         Ck2UCrA6f7vibk0oN1gHcKuvg23IRhjOFDKu5Xz7zOJc/+Dh78onJdH5HTjyviTIEnTI
         MtYtonaudyGyU7WRvn7IO8ornijieNWluVuY/Qsa3bdk4QS/ZdqPe+L1KhH8T3lVMBWn
         xRsA6C8FGt3TEm1ZA9gMVUX2TxMuLIojI4RvHVjPDlWZzk6b3ncrsOHoNwYgVi6Fb5zp
         27gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFiAU6kcHoigzDtMXwhFSfPfpz2SNfjgCvziPh6MpgE=;
        b=joj4NugUmXFmLIhu5dUbw2Zy1+/Q7y6JimHCuskCcWk5W+3XD8FmwRibZ7bzmMcaM0
         LT/nGHTlY+C1kiVGetHoKKpoEG+aDM0/agyT9sfI8jfporlC4QYcNUSmFjhmBc1BdW7u
         vjzSguEpC40sjg0ZlGbgUep+c4yf3Jg7A3OuDJtr+UJTNQByKSUpaYhy1h777ig2sTZ+
         C7HgAysOdYw+ZbRmKfIjI6Rup227tvOgq/MEz4lEg6oyomSPHUNgf8D7msPtJu86nhjq
         ka26I/3ZTG7RVRt1Gewk204nUq9vx557L+0KepBcRuPk0a1leGuwiGuG+AyRJwqPBrlL
         MVww==
X-Gm-Message-State: AAQBX9cV1j2ba5RWPO01Kuwvm8GqkADN2L2F4dxXgtsdfD09zqRhFg0S
        jaHxG/zkL4/gH+VfEEvpQK0=
X-Google-Smtp-Source: AKy350aApIAm05g+oGrDEowgzBjL2AWZ53JF9GvZ19wuoZTvd2RNvqJHEhAcM2mxUeFvn7u3DRMYHw==
X-Received: by 2002:adf:dd52:0:b0:2d9:457a:1069 with SMTP id u18-20020adfdd52000000b002d9457a1069mr777390wrm.37.1679515766954;
        Wed, 22 Mar 2023 13:09:26 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id a7-20020adff7c7000000b002c70ce264bfsm14664342wrq.76.2023.03.22.13.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:09:26 -0700 (PDT)
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
Date:   Wed, 22 Mar 2023 20:09:18 +0000
Message-Id: <cover.1679515236.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679515236.git.lstoakes@gmail.com>
References: <cover.1679515236.git.lstoakes@gmail.com>
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
