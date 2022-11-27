Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A293F639A54
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiK0MIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiK0MIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:08:37 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571A2F589;
        Sun, 27 Nov 2022 04:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669550916; x=1701086916;
  h=from:to:cc:subject:date:message-id;
  bh=WsOMxY+mPL8jQ8iYAIC8w8tkwMDA68IYjaiBaloXufk=;
  b=d0kdRU7ssy4opxR7tuVZSXThA+doI0fGRtugjDgqwczXBhsSwqsA7wXD
   unTeTXkGypOAfi1UGEM/rdm9Jeb7f5BPjKukvaWj6Rc7NKN+HuCLipWEN
   70bqTAccUJZ+qbjGVAdFldQjbvelcSx+5W3l6c5jzxPeVTEUYpJaNq3cc
   t/mIXMZUrTPOgrXdhuDp+JAII2WwKuoE7EgeC4qF1Q0WbgaQeF2tFQNhc
   1r5UHN8Es1o5ZzR5QFhD0boYrSNkg2P508YFDzgBBxq3BPAxlnfdTsBsj
   eSC/zpypX+9RNL7SfPOiZPAZM/zeKw7HwiKQmZRhs4JhcmZ/oxKYASBq1
   w==;
X-IronPort-AV: E=Sophos;i="5.96,198,1665417600"; 
   d="scan'208";a="215510875"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2022 20:08:35 +0800
IronPort-SDR: iaJd2Nw4Kw7krW7tJnTtai54dvUfJFAahhQlgxE4ozOuihy+ObwMQfgCxteqR+IxlU6DmHyPkb
 QqExMAb2OcxSQOtHetwqgKafveGlWixs9fTgSIWhd1qer1qHFgrb92mSFIhWbchz/e0/OBfoaG
 TMBfdGjCvGiMITex+xdTtGYCK7C8obSxwq6x8H88dYh/uFkdDUKLc4kB7jk1TmmLmLM6pytPex
 7Ud/aEt543xkD64ZJ7MaDRyTg2YnNcYYrfI1kcPWU5RWBZHpnYz8Vn/F+qP4OSfyW/evp4mTHg
 NXM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2022 03:27:18 -0800
IronPort-SDR: MUeIfeHbTxG4k+b7YqnOPpFiuVh8xYG4afDViF9r95qFJap4Q4eY890R6nAXJiBdMNfaJJdDGO
 aykeH8jPjZfsi/ebZ/iUD2UJHia+lj/TL4cEaO+NQS8Hvs5xiUeckM3qB4H7QGk0Xu54CLCOv1
 LZtp/4qW2ECRD7LpUiQ0bWFed8kP6PvsNYkJPzeBNrrLfjNzCQ8ZEOubs7hsBLvNX9OKydI0p+
 v6BNhMyYsYP0VSGAMZXcdk25jhR15/OiAsLPqFER5fDlNosOPNifQdFqtXLWSCuCxNRZnBsCnC
 +RM=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Nov 2022 04:08:33 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v4 0/4] ufs: core: Always read the descriptors with max length
Date:   Sun, 27 Nov 2022 14:08:26 +0200
Message-Id: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

