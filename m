Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4AC6BF98C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 12:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCRLPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 07:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRLPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 07:15:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478B652F55
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 04:15:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m35so4722174wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679138126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gAMkUBmCN5X3r9kQm0uq8aZ07PDcKdoRSeFhCE7Nwzc=;
        b=oJlevLsej7ONWhGMXP1jpMP9Rg/PeQtbFPG4kE0U4DQvnk2+/FuXnGGyj43qJxJLFI
         CAdJ1UUutiXpDPrOQCzGpm/1rxyWKN69Vvg0hkSWZOMCSHyam5/NveP3dMKTVMUZ6mGN
         9jwTFaFalUmqfWib5uFG/ZA4il+IAGOJeiW3FaR6ZQPiJYTkHNfrybEmjMsowAxdAqwJ
         yOXD5sN/QiWTi+tN29VdoFi6AlWib+WfsZ6sDuAXauV3B5uzowRB2OjLgjjdop0kiA7w
         P01LF+kMU9pDtKSoRlF9TLPA28Z3y3yLzE9967WkKMF/Ag5hK9LV/LKs7pNi16OCM5ge
         FU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679138126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAMkUBmCN5X3r9kQm0uq8aZ07PDcKdoRSeFhCE7Nwzc=;
        b=tvlaU2acSF8MazZOBANbU7hEn4J2vIs7FwWGq9pkBgiH4N+hlQno1MSM/bTamicvJP
         pZ6CnMu3igYHq6fSMBgEz+foU5Q8M37+JNRAYRCskJctko89p2GnnlmAL0BEhcQWrfNX
         8TNPUZlXjW9BxMFURJ75HmZuORfQfVXPrYWH/b9XmTwfI/27fZECY2306s+N8RTTn04G
         l5MjGFZaZCMQUK3/A1q+1iEe5QP/Bwt3+Jn5QUh3N4ol9N0mLuF2q9ZL8YvKrvnXg5E9
         Zd2yy6uLqAtAIQdKkBXSiaRlCq+/2rpPnyo/JtmZyhTOghRi+v+89F6pEn7oEbl2Oi1D
         Qy7w==
X-Gm-Message-State: AO0yUKWUneyT8cwZygVEY2Kl8gnPraz9jmtaQFvH7XXRfrDWjQDSUhxK
        hjpeIJhSj8N8hzzRY1EVjFw=
X-Google-Smtp-Source: AK7set+m/2ZPNjyCcJsdIdEHcdktjiSMXPMjWYZjOWW4p0HAFsK5LwUTnqP6V4m6krhRKntwbzdw8A==
X-Received: by 2002:a05:600c:4f50:b0:3ed:4b0f:5378 with SMTP id m16-20020a05600c4f5000b003ed4b0f5378mr9061075wmq.27.1679138126468;
        Sat, 18 Mar 2023 04:15:26 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id n23-20020a1c7217000000b003eb68bb61c8sm4849965wmc.3.2023.03.18.04.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 04:15:25 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 0/4] further cleanup of vma_merge()
Date:   Sat, 18 Mar 2023 11:13:17 +0000
Message-Id: <cover.1679137163.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Lorenzo Stoakes (4):
  mm/mmap/vma_merge: further improve prev/next VMA naming
  mm/mmap/vma_merge: set next to NULL if not applicable
  mm/mmap/vma_merge: extend invariants, avoid invalid res, vma
  mm/mmap/vma_merge: be explicit about the non-mergeable case

 mm/mmap.c | 165 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 107 insertions(+), 58 deletions(-)

--
2.39.2
