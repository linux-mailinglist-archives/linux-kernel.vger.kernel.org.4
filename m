Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3D6316AF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 23:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiKTWC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 17:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKTWCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 17:02:50 -0500
Received: from mo4-p05-ob.smtp.rzone.de (mo4-p05-ob.smtp.rzone.de [85.215.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D254EB843;
        Sun, 20 Nov 2022 14:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1668981574;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7gKo6W2XG8PXmAvzufvOcLgOJPE7tHjQ3B2GDJ9irCg=;
    b=jsKSIRU0H05+Lx1O+pbuXvAYS2yABMqhc2xFZP/+jyhbPcXSGshHJ2YuGSnNKiAsTS
    u0VJ6ZdO6W2QCaImH6lJlmVDj/63MyFKzpT9NVSCRR5B+i3WsEUXahEIuTpq+UmTTXM4
    jj4mcdCwsw6nXQwiaMcjJOBoq9IXGGE0BSUFRSEsZT30k69i5e75m7WxZ+8NnytKQOcJ
    Ov3YTiuPnJ2nXoFPcqtBPsKLO6ZvOkLy+nL2UA6bHD1tbJImVcyiwbBQEVTZtin1yqEe
    DJ+JiwdnGl/XoxCUc/TU7kyrd7Zox7I80+/e/F097m967AKerLLMoqng5XFezpiSdpiS
    QBdg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RvWtIfZ/7Q8ZGqEBlwxF4QH61wYa9UK/y81Dg=="
X-RZG-CLASS-ID: mo05
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyAKLxXWa2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 20 Nov 2022 22:59:33 +0100 (CET)
From:   Bean Huo <beanhuo@micron.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] UFS Advanced RPMB
Date:   Sun, 20 Nov 2022 22:59:20 +0100
Message-Id: <20221120215927.104580-1-beanhuo@micron.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

V1 --> V2:
    1. Added RPMB request completion handling in patch 6/6

RFC --> V1:
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

