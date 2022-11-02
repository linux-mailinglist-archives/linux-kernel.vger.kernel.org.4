Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B24F616525
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiKBOaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKBO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:29:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A202B19B;
        Wed,  2 Nov 2022 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667399383; x=1698935383;
  h=from:to:cc:subject:date:message-id;
  bh=5kjv+Eofbg6EEagVUtsebL/TmswxuzBGGl0iDd2sZaI=;
  b=pG9IhfjdUGXQ/kxaYNXNNCTowoMJc/6SlcWoZIzX8FuHdr0x4VPpFRiq
   Gz6Zu+InqnMsfHcnjgf0+PUs2NpQRRYDrPni8iU3dUXy0mM0iOBc4Po9W
   vuazxSMNEKNQ/ZSemE0MdKkiWio+95pyr4qUV9LQ/dO1EZZrTdERj4ubm
   6uH+lddcny2ITC2l4vo/bnjzFHw9v9EjAXZP8XRSV4PBzHRiCUyZGUF2a
   CVKm6LPn7niBJbpsW0yswPOOiFV33dWbcbs0ZZqUNA5EMFg8xZVGA74BW
   kK7vDe/OOAoETyg788IvH7/ASyLrsJtAmhufUuQHeJY/e2ysnDtHmH7Ue
   w==;
X-IronPort-AV: E=Sophos;i="5.95,234,1661788800"; 
   d="scan'208";a="213607169"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 22:29:42 +0800
IronPort-SDR: Glrt0U51kRzVgTuIg9Q//0eWCWoMRntqizlxRbx5yGtwL+sUmPMUlVbSunUBhSguG+lNbmbp09
 RScG+S01WZnc57VjGWcBGgQm0k/5NcD/WF3+n9Zvi5LxbSlw5smqEtZa7+/OQ0nsYPyr4INE4V
 eGcgoS5tsAsV3wBOzxA7vDrANdDy/cagTBrNQgjSa3RkXrdby6ODrA8sOfK5/hkuAvaKi6Wj8l
 URa1eW2b9lE3QM4X+/NPjxAIDFEu00GuUT68dLd+JcibIu3fTcnSwWOCHtVDAMtagWTMzlJvtw
 GcE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 06:48:55 -0700
IronPort-SDR: uESj0/LdP+QqMomig9AN2xK4/BAuRV24flBO2w+o8d+h7ehzW6FX/ZKSCN5AmpyJAA1Qm+7xDb
 PKCTiPPhLyYbzDAVjgQL91Q9Mj/EJFipeViB2Yuy4oYb9ojbPJ/bua8QvWlSPS3HXt97S2eHvC
 fXkPtzPIVp2Y7yM2kCynTVGzxP9w7WUmibI+K+yTclW3zA0efmvSN/hKz78NqwoEbxBN6hueHt
 pDpBmvIoyEpWVbURqGWp8+Y+oBj3LH/fVB2CJOxWCYJ0uh2jEForLKk2h+UOAT96LNHOnrwf9Q
 uss=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Nov 2022 07:29:40 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v2 0/4] ufs: core: Always read the descriptors with max length
Date:   Wed,  2 Nov 2022 16:29:09 +0200
Message-Id: <1667399353-10228-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

