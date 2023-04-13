Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDFF6E1069
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDMOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjDMOwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:52:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E5099;
        Thu, 13 Apr 2023 07:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 111E360F3C;
        Thu, 13 Apr 2023 14:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19746C433EF;
        Thu, 13 Apr 2023 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681397563;
        bh=C5RPtjfJHy3vGZq9VS1zqyK+5+lTi0Wy962NJzcAZ/0=;
        h=From:To:Cc:Subject:Date:From;
        b=eJmdsAqbh7wdm4KJcGA080EFTOb5vqr9PCSwPsSGPeCkq0dQLygobv4vPCRRb7HRc
         Sv07AS+bhTrL6M/NV0qxMDmr6Jk9w2wLd/QZTWlyRcDKVv8LkmfP1xyGVWvHwzPUuW
         e/Bbz3yj+DXK7M9gnVVZc/ARFLSCmaALj5VvSFC6fuHw5suYGss2a8IU6Vi7SAPXp6
         B3hfNjBbyLzco3/xBDL59CzXk287uUBpuXjD8vKw7H1udoGp6FA9hXOvI/BqT8/FZv
         DELjX6k3RBcSmE0ODW9pHgtBpXYhze//Y1JvtgC1bO44Pw2jzgMU7bUxoxL/pmP9m0
         4+w7wTW1RVbeA==
From:   broonie@kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: linux-next: manual merge of the ext4 tree with the mm-stable tree
Date:   Thu, 13 Apr 2023 15:52:39 +0100
Message-Id: <20230413145239.3529907-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
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

Hi all,

Today's linux-next merge of the ext4 tree got a conflict in:

  include/linux/pagemap.h

between commit:

  263e721e3ba1f ("mm: make mapping_get_entry available outside of filemap.c")

from the mm-stable tree and commit:

  e999a5c5a19cf ("fs: Add FGP_WRITEBEGIN")

from the ext4 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.


diff --cc include/linux/pagemap.h
index fdcd595d22944,51b75b89730ed..0000000000000
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@@ -504,9 -504,11 +504,11 @@@ pgoff_t page_cache_prev_miss(struct add
  #define FGP_NOFS		0x00000010
  #define FGP_NOWAIT		0x00000020
  #define FGP_FOR_MMAP		0x00000040
 -#define FGP_ENTRY		0x00000080
 -#define FGP_STABLE		0x00000100
 +#define FGP_STABLE		0x00000080
  
+ #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
+ 
 +void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
  struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
  		int fgp_flags, gfp_t gfp);
  struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
