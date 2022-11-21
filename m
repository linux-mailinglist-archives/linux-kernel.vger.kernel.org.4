Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951CA63288B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKUPqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKUPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:46:38 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1137EB49;
        Mon, 21 Nov 2022 07:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669045597; x=1700581597;
  h=from:to:cc:subject:date:message-id;
  bh=4O2mVRtKtbYO8hFbw2WsR+vVqotiqPdna7qLhf5sQH8=;
  b=PvjWNenFqQ1Zc9dk9MZD2mJqIql6DcKRVi9eomn5VMMgZb7c8Dj069tc
   PiKVH/mVMSx3dMXYXUJTQYTmlozueZralTjJJgt2IFUvfAjo6w7rTPv91
   FAmqX0IgL512tF6+e0ITIST5JII+7aeJQoIMVdmRqpADkMRHuiSv5JaIV
   a49V0hy70aRgn2wVcggUkYWFW6dUq9IYF+UPWMBFQlF+NqumdHPpAAaie
   0zG/zMkh+uOM/Z11v1h57zAiFH76aUzZxNt8oDhZ4oFJdzWNWZOm9nFZx
   BmvBhvy9fIDIJkKgZ28w6ojFOeMnUyluTMAuyL/WiJhAuNM63eDCJoGO9
   A==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665417600"; 
   d="scan'208";a="215054341"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 23:46:36 +0800
IronPort-SDR: dL7YLiT1yEvs8ew047BaVno3VZkkyCCwp+MPYyoOjyJ/yVJr8AFhihV+4+CC3ji1PGISWHywTF
 Q15BSvOoBrXGxj/2Z7fXnMcjlLhumiRQQrS4SzrEHBmdYQpdFlvKGS4s+RVGkeCAIyTjP/1JJW
 CKtG6dHVrmRAEEBFYjroy2PPnkgn04IdNV8cr5EX8uEEnq2rQ0gvqA/rAjyagY3sybz1G2nilo
 kxLvJMGH5iDLiyMiQM8vKLxesRDYknGVJnVGY00MZqkHgsvoWzV9T7PXxmdLpoOa40o+FByMgs
 Ods=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 06:59:41 -0800
IronPort-SDR: /tX3QofnQoij5DIaXYJXcIuVFWDxMpgqqo8/k5GTNUO/N+IhqAdFBavciTkoXhY4vYPGGN+xMo
 z+Qi7Q0ePS6wQXy9CFIC2J/zQrcnkoxX4QOZIIDxExXSxOSOcszDF8C74HwcezWAODrU/89NWG
 Iz33UAbQsqVLDchFiG8vJDmOt6EORhJIJia+lYTrZCuXdWlrhGZbRTZ/u5XUm3YOj9c1qGcUTZ
 6SqFua5wDYfXMfFzTb+BF708jbWHDIFUBONy0VFumNhJDZFARFjVTfX/x6atpFJvPrh0fMjxpG
 xmY=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Nov 2022 07:46:35 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v2 0/4] ufs: core: Always read the descriptors with max length
Date:   Mon, 21 Nov 2022 17:46:26 +0200
Message-Id: <1669045590-26101-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2--v3:
  Based on Bean's comments:
  1)Use kzalloc instead of kmalloc in ufshcd_set_active_icc_lvl - patch 2/4
  2)Delete  UFS_RPMB_UNIT definition - patch 2/4
  3)Delete len description - patch 3/4

v1--v2:
  Fix argument warning in ufshpb.c

Read any descriptor with a maximum size of QUERY_DESC_MAX_SIZE.
According to the spec the device rerurns the actual size.
Thus can improve code readability and save CPU cycles.
While at it, cleanup few leftovers around the descriptor size parameter.

Suggested-by: Bean Huo <beanhuo@micron.com>

Arthur Simchaev (4):
  ufs:core: Remove redundant wb check
  ufs:core: Remove redundant desc_size variable from hba
  ufs: core: Remove len parameter from ufshcd_set_active_icc_lvl
  ufs: core: Remove ufshcd_map_desc_id_to_length function

 drivers/ufs/core/ufs_bsg.c     |   7 +--
 drivers/ufs/core/ufshcd-priv.h |   3 --
 drivers/ufs/core/ufshcd.c      | 100 ++++++++++-------------------------------
 drivers/ufs/core/ufshpb.c      |   5 +--
 include/ufs/ufshcd.h           |   1 -
 5 files changed, 26 insertions(+), 90 deletions(-)

-- 
2.7.4

