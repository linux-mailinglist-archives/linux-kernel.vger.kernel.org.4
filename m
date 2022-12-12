Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5283664A5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiLLROE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiLLRNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:13:53 -0500
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7212AE7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:13:46 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-381662c78a9so155972017b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPWM30xIqvrbd4o8O1iaeCeAFtWpQew9Gut9+/kteFU=;
        b=IXe0fzWypqud2dSa1RNowf/Znp/79qS7PF/pLOy1WiNbRdC2j8ATXZPBY02f8Q0yut
         T3so0yLvTqniUXTQxcIUGNlbiESU5i70F4lAkc7efE6gsM+jhCrm+aATAIJdvkMvUJ8u
         SEDHBTBu9nGUrK8bHteBLCbS0+FTMPRhMLmgHpNmKypdByPHYLWlKqMGRlKk2LL0GNYY
         KzG/S2c9Vaxps8AKReqaUxYwFWAfflMzrqHL+K/Dd1RcvLGR4/JUdMY/eTIbqxfAq+Vl
         +2HrCCz51nb9UicbkXJlIdtoIWSmYxqRKMIB14WEuHJ03aAN9Fj958ydOXsjrcMQGn4/
         KVzQ==
X-Gm-Message-State: ANoB5pkdlBKVuK+VRakTp3oGyXr1hExW9zGY1UeK3m2gdnbyS2UOURTm
        7gb2/mfljOjOE3QPyENABw0=
X-Google-Smtp-Source: AA0mqf7xFC0hw+JpNA/Cv6k/8lCgNkxROruITqT6CSc2IVeazbYSlT1I9tPEjaRmV14JaMUCvb0ijA==
X-Received: by 2002:a81:190e:0:b0:364:1ba5:67e4 with SMTP id 14-20020a81190e000000b003641ba567e4mr15183353ywz.17.1670865225813;
        Mon, 12 Dec 2022 09:13:45 -0800 (PST)
Received: from fedora ([50.220.117.222])
        by smtp.gmail.com with ESMTPSA id f1-20020ac84981000000b003a7fc70d59csm6082190qtq.41.2022.12.12.09.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:13:45 -0800 (PST)
Date:   Mon, 12 Dec 2022 09:13:42 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v6.2-rc1
Message-ID: <Y5dhRrNFzNX1Z64/@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Baoquan was nice enough to run some clean ups for percpu. There will be
a minor merge conflict with Vlastimil's slab PR [1]. This is due to
adjusting the PERCPU_DYNAMIC_EARLY_SIZE up for proper early percpu
reservation size on arm64 with 64k pages.

[1] https://lore.kernel.org/all/20221122163634.3b21cf71@canb.auug.org.au/

Some new eventual work is potential BPF accounting of percpu.

Thanks,
Dennis

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-6.2

for you to fetch changes up to d667c94962c1c81ef587ac91dc5c01a1cfe339c7:

  mm/percpu: remove unused PERCPU_DYNAMIC_EARLY_SLOTS (2022-11-07 22:59:28 -0800)

----------------------------------------------------------------
Baoquan He (7):
      mm/percpu: remove unused pcpu_map_extend_chunks
      mm/percpu: use list_first_entry_or_null in pcpu_reclaim_populated()
      mm/percpu: Update the code comment when creating new chunk
      mm/percpu: add comment to state the empty populated pages accounting
      mm/percpu: replace the goto with break
      mm/percpu.c: remove the lcm code since block size is fixed at page size
      mm/percpu: remove unused PERCPU_DYNAMIC_EARLY_SLOTS

 include/linux/percpu.h |  7 +++----
 mm/percpu.c            | 44 ++++++++++++++++++--------------------------
 2 files changed, 21 insertions(+), 30 deletions(-)
