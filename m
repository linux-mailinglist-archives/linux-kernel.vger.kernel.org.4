Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA5A5B7976
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiIMS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiIMS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:26:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AFF24F10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 585C061520
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4D8C433C1;
        Tue, 13 Sep 2022 17:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091091;
        bh=LTJFQvu3fbUeoBlxoYkTj8tKAF1KlT7wckZz/6RxiTk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZH1Dt/WEu+RKqwakhbFJdLk1LRaoAY6d4pBecFD6CWCBB29RD8d9bRfAAAaeBSX6C
         J0CX8Ug8EdBVLn/vyrwrvjm02pykj6JLmd5iCoKLbASMe8H/WM5CLDwpSejRPuVtTN
         lvcEW6KKG3POEsv3eX4pnhNGTUUf63tgNuj57ns8zhNcA1yk6GUgjyj0AFn/RFU1+z
         N67qc4s3i7+lq8pKR5UiAleJFeo8yg6V+JellPHu7HT/z8PGh5kzu6qYyHhGq5LpJr
         7qxKE/2WauPs0gTPhIMQgSC70NQ9yAnw/CYd6n8B3QQQemnkB1pSDK2UOZrSRczE20
         Fn+UI+hVckl0A==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/22] mm/damon: cleanup code
Date:   Tue, 13 Sep 2022 17:44:27 +0000
Message-Id: <20220913174449.50645-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON code was not so clean from the beginning, but it has been too much
nowadays, especially due to the duplicates in DAMON_RECLAIM and
DAMON_LRU_SORT.  This patchset cleans some of the mess.

SeongJae Park (22):
  mm/damon/paddr: make supported DAMOS actions of paddr clear
  mm/damon/paddr: deduplicate
    damon_pa_{mark_accessed,deactivate_pages}()
  mm/damon/core: copy struct-to-struct instead of field-to-field in
    damon_new_scheme()
  mm/damon/core: factor out 'damos_quota' private fileds initialization
  mm/damon/core: use a dedicated struct for monitoring attributes
  mm/damon/core: reduce parameters for damon_set_attrs()
  mm/damon/reclaim: use 'struct damon_attrs' for storing parameters for
    it
  mm/damon/lru_sort: use 'struct damon_attrs' for storing parameters for
    it
  mm/damon: implement a monitoring attributes module parameters
    generator macro
  mm/damon/lru_sort: use monitoring attributes parameters generaotr
    macro
  mm/damon/reclaim: use monitoring attributes parameters generator macro
  mm/damon/modules-common: implement a watermarks module parameters
    generator macro
  mm/damon/lru_sort: use watermarks parameters generator macro
  mm/damon/reclaim: use watermarks parameters generator macro
  mm/damon/modules-common: implement a stats parameters generator macro
  mm/damon/reclaim: use stat parameters generator
  mm/damon/lru_sort: use stat generator
  mm/damon/modules-common: implement a damos quota params generator
  mm/damon/modules-common: implement damos time quota params generator
  mm/damon/reclaim: use the quota params generator macro
  mm/damon/lru_sort: use quotas param generator
  mm/damon/lru_sort: deduplicate hot/cold schemes generators

 include/linux/damon.h     |  34 +++--
 mm/damon/core.c           |  87 +++++------
 mm/damon/dbgfs.c          |  15 +-
 mm/damon/lru_sort.c       | 303 +++++++++-----------------------------
 mm/damon/modules-common.h |  46 ++++++
 mm/damon/ops-common.c     |   4 +-
 mm/damon/paddr.c          |  29 ++--
 mm/damon/reclaim.c        | 220 ++++++---------------------
 mm/damon/sysfs.c          |  12 +-
 mm/damon/vaddr.c          |   4 +-
 10 files changed, 246 insertions(+), 508 deletions(-)
 create mode 100644 mm/damon/modules-common.h

-- 
2.25.1

