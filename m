Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68306E1070
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjDMOz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjDMOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7998FAF1F;
        Thu, 13 Apr 2023 07:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5C7363F4F;
        Thu, 13 Apr 2023 14:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBB8C433D2;
        Thu, 13 Apr 2023 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681397719;
        bh=1ngw3+ChjRIyUddHJBteRhw3PmiASGHZag3zYF96owI=;
        h=From:To:Cc:Subject:Date:From;
        b=UFqDoVfdESH/IQXu4viD92MUCOsOxzznISfvQIgZ3Fo7wTd2AjamKlHfKy1fOpbXz
         sCzyg5+Re/yQNHfBs4yEPowoUw6FiH6VOO9Qqd5/nfDwO7x2eUZvil+5yWv2m01fs2
         k/CUxTOZ65gXkbytVch58Rfj3umHeyCUWOK0O+CIX4CIawFMDV3qzhqccv+F7wycE5
         C3agESBfj77BSdY04AgRkLqQIVgb6JCoI4jTmSN4mV3rXNnvzccq3LU9G9kc640Rl3
         K2OcFGH+i/GXdXItSwALtM98R5D49Fdr1yMcoHg9qF4xig4jqrlg+f5Bce7IDbTBlR
         Thl/SXENdxmxw==
From:   broonie@kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: linux-next: manual merge of the ext4 tree with the mm-stable tree
Date:   Thu, 13 Apr 2023 15:55:15 +0100
Message-Id: <20230413145515.3534108-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
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

Hi all,

Today's linux-next merge of the ext4 tree got a conflict in:

  fs/iomap/buffered-io.c

between commit:

  66dabbb65d673 ("mm: return an ERR_PTR from __filemap_get_folio")

from the mm-stable tree and commit:

  e999a5c5a19cf ("fs: Add FGP_WRITEBEGIN")

from the ext4 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc fs/iomap/buffered-io.c
index 96bb56c203f49,10a2035155835..0000000000000
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@@ -467,7 -467,8 +467,7 @@@ EXPORT_SYMBOL_GPL(iomap_is_partially_up
   */
  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
  {
- 	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
+ 	unsigned fgp = FGP_WRITEBEGIN | FGP_NOFS;
 -	struct folio *folio;
  
  	if (iter->flags & IOMAP_NOWAIT)
  		fgp |= FGP_NOWAIT;
