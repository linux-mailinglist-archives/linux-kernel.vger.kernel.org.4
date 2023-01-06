Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DBD6605CC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbjAFRkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjAFRkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:40:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ABD7D9DC;
        Fri,  6 Jan 2023 09:40:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CA4F616F5;
        Fri,  6 Jan 2023 17:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC3CC433EF;
        Fri,  6 Jan 2023 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673026830;
        bh=RPl7e2yBo83c5bpefsyB/x5AStixSmvwCt6OqN8mVRA=;
        h=From:To:Cc:Subject:Date:From;
        b=NXZXYzIz+4ecrSUefmPBaOBbALJel/O/I56Yx+vNVLtvvGtgf94GV1QFNHD6OR3I6
         i0GyyTkuKlVocoLBOqq50sdu/aj0RGLCZQQGq0eeDZOgBS1WJbFl7nB+/Alqr6eRfC
         uvUP/EUfkOQjMyV2e31sJWCdpo13LLjLtdfx//WtynQZE6FL68aYh45dJwALkyPfqj
         B9vGPTfQVeZUQMdGN8tiOq2V5qDa3+AeBncTri0dCoSdXqRp9Tmyhp9/xGMkWGvohs
         gQlzaWNk2/L8YwsNRRwssuwjPlp5u8iFDA/rLIvSqqbbIFZSLKTLYdUBFs/ixfvZSt
         d9h5NGQ00D4xg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, willy@infradead.org,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] add folio_headpage() macro
Date:   Fri,  6 Jan 2023 17:40:25 +0000
Message-Id: <20230106174028.151384-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard idiom for getting head page of a given folio is
'&folio->page'.  It is efficient and safe even if the folio is NULL,
because the offset of page field in folio is zero.  However, it makes
the code not that easy to understand at the first glance, especially the
NULL safety.  Also, sometimes people forget the idiom and use
'folio_page(folio, 0)' instead.  To make it easier to read and remember,
add a new macro function called 'folio_headpage()' with the NULL case
explanation.  Then, replace the 'folio_page(folio, 0)' calls with
'folio_headpage(folio)'.


SeongJae Park (3):
  include/linux/page-flags: add folio_headpage()
  mm: use folio_headpage() instead of folio_page()
  fs/ceph/addr: use folio_headpage() instead of folio_page()

 fs/ceph/addr.c             | 2 +-
 include/linux/page-flags.h | 8 ++++++++
 mm/shmem.c                 | 4 ++--
 mm/slab.c                  | 6 +++---
 mm/slab_common.c           | 4 ++--
 mm/slub.c                  | 4 ++--
 6 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.25.1

