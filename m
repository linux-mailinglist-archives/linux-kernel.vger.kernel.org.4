Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F26316D1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 23:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiKTWW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 17:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiKTWWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 17:22:36 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72090BE12;
        Sun, 20 Nov 2022 14:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1668982947;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=rHIWmEiOCODPVWqiYPeHv9zjayliBfKoMjHI89CGOSU=;
    b=B8BTSLJYogGD67WP+p7TUWk+N1y5g+8q4pNLQh4zlADms0no54mmKEaPQkYkC2XOcQ
    qZLDQEJp4fRnpCa1NPDSBawCE0az6RtIgSwXDCaCsFSMnpKr0Ap5awmlsUXl3y5lzeCf
    Jrw9IrtXgGBt8QYpayZo2SeSg7zc+uqphTsJV3rB91/OOpiTSqnHG2qbak1+9X5d/Hkp
    sslSlxvCko8ckgPWsyw/fjjqU3tE6rh5cCnbIlWdKU9wzLOmCwP5zDaX8gSvNPvuOh4M
    xWHrwPQFYp6HlCcpxPQOYnU8xL1t6lydCyirBJouvmMMft7HCzN6CVejhsJyeYjLjXUT
    +u2A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RvWtIfZ/7Q8ZGqEBlwxF4QH61wYa9UK/y81Dg=="
X-RZG-CLASS-ID: mo00
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyAKMMQWc4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 20 Nov 2022 23:22:26 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v2 0/6] UFS Advanced RPMB
Date:   Sun, 20 Nov 2022 23:22:11 +0100
Message-Id: <20221120222217.108492-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

V1 -- V2:
    1. Added RPMB request completion handling in patch 6/6
RFC -- V1:
    1. Split the patch and Remove RFC
    2. Add all 8 types of rpmb operations
    3. Fix one EHS copy error in ufshcd_advanced_rpmb_req_handler()
    4. Fix several issues raised by Avri in the RFC patch:
    https://patchwork.kernel.org/project/linux-scsi/patch/20221107131038.201724-3-beanhuo@iokpp.de/#25081912

Bean Huo (6):
  ufs: ufs_bsg: Remove unnecessary length checkup
  ufs: ufs_bsg: Cleanup ufs_bsg_request
  ufs: core: Split ufshcd_map_sg
  ufs: core: Advanced RPMB detection
  ufs: core: Pass EHS length into ufshcd_prepare_req_desc_hdr()
  ufs: core: Add advanced RPMB support in ufs_bsg

 drivers/ufs/core/ufs_bsg.c       | 137 +++++++++++++++---------
 drivers/ufs/core/ufshcd.c        | 176 +++++++++++++++++++++++++------
 include/uapi/scsi/scsi_bsg_ufs.h |  46 +++++++-
 include/ufs/ufs.h                |  29 +++++
 include/ufs/ufshcd.h             |   6 +-
 include/ufs/ufshci.h             |   1 +
 6 files changed, 315 insertions(+), 80 deletions(-)

-- 
2.25.1

