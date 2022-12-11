Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF47D649453
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiLKNFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiLKNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:05:22 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B43E0E9;
        Sun, 11 Dec 2022 05:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670763920; x=1702299920;
  h=from:to:cc:subject:date:message-id;
  bh=J+KXlTuqaTrj22MKrwsYLiuUnNDoqiMO7Sry1BoAuI8=;
  b=R4NOp85lYDkZ1YHfAajGMkHPHm55FU4yRI/lFqKNSXmXxjMqjSeEf4go
   XFKwD8TK/CgXcuA7GmdCFojZWzP7g0Q1DbAHseY7+OoVceEFU6Xk/RLkx
   c5eZASE5pbRtdsr5Avo3XVZlsYljXp95ml3ygbMEVDU07CkLikx12SbB9
   pjhxOPFZX+yLO7/853BP66Gc+ZEUkTOkosRv8wNg17cI/EB4DR3jxJ2Z4
   qkjN59IT6JgKvX8X6HKXCkXOEJblPixRWOPJov337art5hi5GgWpUgE5e
   gjUs7T5PceoxIrM2TJ/SjjTRpmu4GxSZVb1ccNSqpJ7BixWUYnWHWrTeH
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,236,1665417600"; 
   d="scan'208";a="218373504"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2022 21:05:19 +0800
IronPort-SDR: qZc73nlSy5CxP4+JrRtH5vVRYjepRSFwqbkIHiEEFL7gxgCp4HicsuvR6sqo7Hvjw32MnXGt7H
 YmidoQEycVbQlyP7LvTA2iD/LiSRwiTqK60qaRH4i5sQCm+q+OaScYSUt7QGbuZsG2eDpEdMUt
 3VicizbCq9BH8yXuVuAPDRFECvSpNPuONUpLTZuBufhlDZoiqeNnM49P4bITIzneMGp6lxflFL
 prnbCvds2kyg/mibwPq9t1KtOT73kxMRCVGSAVktrORU3n62KJiZ215jrrmGjdEDUH4hzM1ZPb
 lJI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2022 04:23:46 -0800
IronPort-SDR: kD9bzD+a7erEthjoM2ZGC+MnyzCFueSb5WolrcwjaMhhrOPnFUkPQGaRMbRWYak+b3/PTJUyNO
 1zV9g/s+5aO5dasTaz8qtb7QG+IwmnOcpIz/9s1HR4qPHqD7UCRjSJl8xgmO4SmDqXihDzAGOd
 v7zDU0TafaEWz63HqMTPHIfXlpNm54Ofs0oNl8C5hHeg/ItLbhinuSMTV+2Lieei2mKmaIl0ng
 cLDcLn+eet8aUGnsGxd5RRtJt7K4jDuTxNwkk22DfTo/jLeXkj2+/cB8FSvG5mbgTVMu/zZmc5
 2Wc=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Dec 2022 05:05:18 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v5 0/4] ufs: core: Always read the descriptors with max length
Date:   Sun, 11 Dec 2022 15:05:07 +0200
Message-Id: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4--v5:
  Change patch 2 according to Bart's comment

v3--v4:
  Add "Reviewed-by" to patch's commits
  Use kzalloc instead of kmalloc in drivers/ufs/core/ufshcd.c - patch 2/4

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

