Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7366E23F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDNM76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjDNM7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C97B470;
        Fri, 14 Apr 2023 05:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C36E637DB;
        Fri, 14 Apr 2023 12:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCE8C433D2;
        Fri, 14 Apr 2023 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681477159;
        bh=BaN8i5TpFQuSHnQB44TUL3cxmY9lLmJo2EoDj/fQwSE=;
        h=From:To:Cc:Subject:Date:From;
        b=Eq/W4LJPPzfaEzWEHTg4TSccaMQdALsmfcK1HXCq/iuCFTsaOVxUFZMMlBB1fGxNT
         J5HyWmj1v+169ian2toHXF5acIcX/fa9FLOjUuI5Kw++vHqXe4JGabJeOi+WzHWeFW
         V7IQWentx/iEPehmjiJljw+UwVPexVHuYMhfePz8VlrZ7ePJT/+lzx+3cOYN63vw2Y
         PyMh2V5j0a3kHh3j5QHN+R91kEdnAPhe7mxQC5HVqLImWxkHk/Ixl+W2DEV12U+lXg
         oTY0rWCap2wi2DKCsdSF4IrbsgMifBTi7TOOmNJNCVbUhz/rcmDF68kL7P3+4Kpdkl
         LiJYE4GP7x10w==
From:   broonie@kernel.org
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm-misc tree with the mm-stable tree
Date:   Fri, 14 Apr 2023 13:59:12 +0100
Message-Id: <20230414125913.851920-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/ttm/ttm_pool.c

between commit:

  23baf831a32c0 ("mm, treewide: redefine MAX_ORDER sanely")

from the mm-stable tree and commit:

  56e51681246e5 ("drm/ttm: revert "Reduce the number of used allocation orders for TTM pages"")

from the drm-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.


diff --cc drivers/gpu/drm/ttm/ttm_pool.c
index 4db3982057be8,dfce896c4baeb..0000000000000
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c

[Just the version in mm]
