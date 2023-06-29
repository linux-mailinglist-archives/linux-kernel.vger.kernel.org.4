Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E1B742FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjF2VtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjF2Vsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:48:55 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E3330C4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1688075328; bh=FmbTdi5zuk0SN6bL1GqPa/XWvQtYc/7aqiZNLWHawfs=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=NEiKHIJ0TUMYNtqnwBh+nXrpc/xNRmaFOGHgjNsXoei9R5BGYQKVn5NmDjKh1V94J
         1HV9c7P5WWoYcneL9f/UPyMoRDHxIAzq4gN0ebLt8XV0hj/b2fX3x8gzpg7KnqJrTO
         AbedOhy3yPVCoKnuuogWyjyFYWXJy/rN4Oz4PPzw=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 29 Jun 2023 23:48:48 +0200 (CEST)
X-EA-Auth: 3d8hHa0w8x3ZBksDX9dBDvaPGrI6/UQcOzXV03+dW5/YH8jZrj6A54owRMUqSTdC4zEFF+HTckpwy1YG1yyVVQC252uw6y2c
Date:   Fri, 30 Jun 2023 03:18:37 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v3 0/6] gfs2: kmap{_atomic} conversion to
 kmap_local_{page/folio}
Message-ID: <cover.1688073459.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series proposes to replace the kmap/kmap_atomic implementation to the
preferred kmap_local_* APIs.

The code blocks for this module where kmap/kmap_atomic calls are implemented do
not appear to depend on disabling page-faults or preemption. Hence such code
blocks are safe for converting to improved kmap_local_{page,folio} APIs.

Note: The proposed patches are build tested only.

Initially, only a single patch was sent and now being converted into a patch
series including the other files/functions of this module. Hence all patches,
that are included for the first time in this series are also marked as v3.

Changes in v3:
   - Patch set introduced to include all gfs2 kmap conversions
   - Patches 3/6 through 6/6 are included to build the series
   - Initial stand-alone patch split into 2 patches [1/6 and 2/6]

Changes in v2:
   - 3/6 to 6/6: None.
   - 1/6 + 2/6: Correct patch description for the replacement function name from
     kmap_local_folio to kmap_local_page

Deepak R Varma (6):
  gfs2: Replace kmap_atomic() by kmap_local_page() in stuffed_readpage
  gfs2: Replace kmap_atomic()+memcpy by memcpy_from_page()
  gfs2: Replace kmap() by kmap_local_page() in gfs2_unstuffer_page
  gfs2: Replace kmap_atomic() by kmap_local_page() in lops.c
  gfs2: Replace kmap() by kmap_local_page() in gfs2_read_super
  gfs2: Replace kmap_atomic() by kmap_local_page() in
    gfs2_write_buf_to_page

 fs/gfs2/aops.c       | 13 ++++++-------
 fs/gfs2/bmap.c       |  4 ++--
 fs/gfs2/lops.c       | 12 ++++++------
 fs/gfs2/ops_fstype.c |  4 ++--
 fs/gfs2/quota.c      |  4 ++--
 5 files changed, 18 insertions(+), 19 deletions(-)

-- 
2.34.1



