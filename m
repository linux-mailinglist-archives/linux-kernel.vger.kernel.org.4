Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4382D6C3C22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCUUqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCUUq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:46:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C59653716
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:46:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l27so6715546wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679431580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JJZvn4i52w6uqtdykKTHiGurQP95OxTlrYhIRyImreM=;
        b=VhCMBbTc1OwR3ws5VjY1dvQYOrgszHYil4QhEBOmCLwzpY+7XdOZal9kptjh+z9glZ
         MiPXAojzxD95F8ZCsKXzE3PS7Vz0TXzVBjbZ+N3LLtrd/yA90/61Sh4YVLFxRKIaSktC
         PGXuRw4GjxulKbm+uw44ROlfhv22Ode6s+ii5EXNXG4pdZ9OWMyIwIdzb+MEkuNpJSEl
         H7KdnfPSiDsY29b2dwIz7fdOHMu5yZClfoVbQCHZ29fCDZ/RfimUnvrlabYOK7kvNivC
         aa65t++CkEfaQ6KiFXlAs++svwoE5EeNIdsjPTNs3aTOnRM4e4FtbZveBZTJ6RwLGM7w
         lODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679431580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJZvn4i52w6uqtdykKTHiGurQP95OxTlrYhIRyImreM=;
        b=xfwnM2aKTwazaD+lCYFwpYbUR0hNubWjBSkZiqpAfID3WWVNa+2Z4/xCxhIEUc7e3L
         e108c7BKCr15ReJHpmbYdoRzFAg+bKLL+prJ6F/AxQuFmRbYKaiXvj5HxTyiGr1MMTSK
         KzarEDeyTrbnGni+pGlWuuEvw+nBAZQhhX0vNlWFXp1F3xOvpZxfahiaGYEvw7IlcaCe
         /F0tZkCh2EezX4XhsPrAFcsnyAXV1qgnaWTXwWMISgIgYByCLcyd7XHVaZsXRrnAdYDw
         6ECA23wBWTIG9TyHfRHRMUfwHWzPs7QVhvXV2hiGHBKerWcXa5y8tfLiYy+Nu8KxaLJ5
         DufA==
X-Gm-Message-State: AO0yUKVv3F6ne0wyko1XH2NIsYNdo8aJIXUcfM+6uq9XQ03BOi5L5u/S
        /OwuWXzJ2K3NeSKAS9rIccxm57vt4xk=
X-Google-Smtp-Source: AK7set8T1Bjs3C6ZFaqvWMtG5bf79ANPDPm22WVuGlwYFMNYV09cRjIKur+a7WziZ+AGag5aEINiaA==
X-Received: by 2002:adf:e484:0:b0:2d8:a7df:bce9 with SMTP id i4-20020adfe484000000b002d8a7dfbce9mr3226350wrm.23.1679431579946;
        Tue, 21 Mar 2023 13:46:19 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id a4-20020adffb84000000b002d322b9a7f5sm12142491wrr.88.2023.03.21.13.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:46:19 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 0/4] further cleanup of vma_merge()
Date:   Tue, 21 Mar 2023 20:45:54 +0000
Message-Id: <cover.1679431180.git.lstoakes@gmail.com>
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
necessary - and to Liam for his excellent suggestions which greatly
simplified things.

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

v1:
https://lore.kernel.org/all/cover.1679137163.git.lstoakes@gmail.com

Lorenzo Stoakes (4):
  mm/mmap/vma_merge: further improve prev/next VMA naming
  mm/mmap/vma_merge: set next to NULL if not applicable
  mm/mmap/vma_merge: extend invariants, avoid invalid res, vma
  mm/mmap/vma_merge: init cleanup, be explicit about the non-mergeable
    case

 mm/mmap.c | 155 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 80 insertions(+), 75 deletions(-)

--
2.39.2
