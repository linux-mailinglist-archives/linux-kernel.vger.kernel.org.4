Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285886E1061
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDMOup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjDMOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0C9138;
        Thu, 13 Apr 2023 07:50:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B09B63F31;
        Thu, 13 Apr 2023 14:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82361C433EF;
        Thu, 13 Apr 2023 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681397436;
        bh=Zp14WLpMOyA9wKkZ+ALcUNnm0KONCzHc0Ay7MkAege4=;
        h=From:To:Cc:Subject:Date:From;
        b=SxjdRtsfCmBAnK84WP9KAe9BuoRsikWYtsQHP/JiUNI7cLaVVNGstVzMyKkBkr1i0
         Vb2GY28J3Xvjcoy296o3DiFQ0cRBPRpxbH59bRxiqwH7LxGDlpuwU07UwCd697Cipd
         W5ZxWX2HAX9KK608ZXgtiRWAuz8VMbg/nN5aZzA122jht7Tv0qwWlaPcBbHMDZtJ9Z
         JXPTAkZBQwvOeSH0CAZ/AhbbBEXAXUBRgmXgmap5vXLtimKzkwcH3X8aYvdlW1vuoP
         kEA0hppSdkIs8GJALVbD/r3I2UYOtAmDuAPOtBFuFgFwNQsGUiawA+Nvr90aYTEUkp
         93If4Vb6b1elA==
From:   broonie@kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: linux-next: manual merge of the ext4 tree with the mm-stable tree
Date:   Thu, 13 Apr 2023 15:50:31 +0100
Message-Id: <20230413145031.3526017-1-broonie@kernel.org>
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

  fs/nfs/file.c

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

diff --cc fs/nfs/file.c
index 1d03406e6c039,2474cbc30712a..0000000000000
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@@ -335,9 -326,10 +326,10 @@@ static int nfs_write_begin(struct file 
  		file, mapping->host->i_ino, len, (long long) pos);
  
  start:
- 	folio = nfs_folio_grab_cache_write_begin(mapping, pos >> PAGE_SHIFT);
+ 	folio = __filemap_get_folio(mapping, pos >> PAGE_SHIFT, FGP_WRITEBEGIN,
+ 				    mapping_gfp_mask(mapping));
 -	if (!folio)
 -		return -ENOMEM;
 +	if (IS_ERR(folio))
 +		return PTR_ERR(folio);
  	*pagep = &folio->page;
  
  	ret = nfs_flush_incompatible(file, folio);
