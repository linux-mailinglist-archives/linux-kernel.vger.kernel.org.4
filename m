Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7E36AAC21
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCDTkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCDTkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:40:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A623ECC27
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 11:40:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A74860A55
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 19:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D67BC433EF;
        Sat,  4 Mar 2023 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677958800;
        bh=6TeDbR5GXJJF54b96kNnySeQoyETESDXw9WrPqnw/VI=;
        h=From:To:Cc:Subject:Date:From;
        b=Fw/AwxpST4BRnmybFAJfo3Nj/+vYbZKVoaSa9sAipEycxpJGLaFSszOvb/ysWG2jJ
         VXBIITE+AAcbftEmWT0cfga+EKGTg4i8xf6/YJv3zsJvQFq8bqeUP9zdUnL+BiokZj
         yfNWULFx3tTWr5pHWx7nocG0143d9WM5WFZlKnHGfAO0oC1CSNRdFpFdPo0n7fkr9Q
         2mi4zYhPjP+8E/yjG8B+S/L54IPPOJuLOsi8fLXJp/mY0qXBl4aa75IsJyskcq3OIb
         C0BdMqOtsdBgMpxjFZI8AmHXkDxlSTtS7PfBR5CD6GyuFwsdwP/Hid9xU1G99hXRtT
         0+oV4gHxOIVSg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon/paddr: Fix folio-use-after-put bugs
Date:   Sat,  4 Mar 2023 19:39:47 +0000
Message-Id: <20230304193949.296391-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two folio accesses after folio_put() in mm/damon/paddr.c file.
Fix those.

SeongJae Park (2):
  mm/damon/paddr: fix folio_size() call after folio_put() in
    damon_pa_young()
  mm/damon/paddr: fix folio_nr_pages() after folio_put() in
    damon_pa_mark_accessed_or_deactivate()

 mm/damon/paddr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.25.1

