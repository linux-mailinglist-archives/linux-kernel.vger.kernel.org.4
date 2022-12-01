Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77263F239
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiLAOFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiLAOE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:04:56 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2CFA5189;
        Thu,  1 Dec 2022 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669903488;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=cktZ8eBe15WhB2GT5dx5rK60MFWZn1si+g5+Wplkdmg=;
    b=gOqxyoMZOskqz6SpYzUtTqpjORWSzWVWQe8jcySX2XoAQg/I3t3LjfdgcS+3Qx/68P
    gvuDwtlBdHRQFX00pxfTj6leTSV4tyfHBvGDKpsj3iNMHLGe4SjzUdQwvwSgTSVzsYVq
    w+YiwBUiRBy86OHx76zFTajpW1RhfzdHu1e9KgJXHUUtCI2Uh792PiWTzY6gWNJCGVY/
    Vkvc3b/jRkGWEiTwvi1xIoVdKBaGKavyU9pHD1kR5gvJWWl44SwempReCSg/Edf+jCYI
    fPIWpI5Fj1J8qloA7Xj5fxEUj/T2i7UNBWNaujHQfwFsZecQf1ZzAGnBxZdvQTrozH2D
    PLYQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
X-RZG-CLASS-ID: mo00
Received: from blinux.micron.com
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyB1E4lHoS
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 1 Dec 2022 15:04:47 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v3 0/7] UFS Advanced RPMB
Date:   Thu,  1 Dec 2022 15:04:30 +0100
Message-Id: <20221201140437.549272-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series of changes is to add support for UFS advanced RPMB
in ufs_bsg. The advanced RPMB application of user space is ufs_utils, the reference code is
https://github.com/beanhuo/ufs-utils-Micron/blob/ufs_arpmb/ufs_arpmb.c.

Changes to ufs_utils will be pushed to https://github.com/westerndigitalcorporation/ufs-utils
When ARPMB patch is merged into the kernel.


Changelog:

V2 -- V3:
    1. Add new patch 1/7
    2. Addresses several coding issues raised by Avri Altman.
    3. Add  __attribute__((__packed__)) for EHS struct in 7/7

V1 -- V2:
    1. Added RPMB request completion handling in patch 6/6

RFC -- V1:
    1. Split the patch and Remove RFC
    2. Add all 8 types of rpmb operations
    3. Fix one EHS copy error in ufshcd_advanced_rpmb_req_handler()
    4. Fix several issues raised by Avri in the RFC patch:
    https://patchwork.kernel.org/project/linux-scsi/patch/20221107131038.201724-3-beanhuo@iokpp.de/#25081912

Bean Huo (7):
  ufs: bsg: Let result in struct ufs_bsg_reply be signed int
  ufs: ufs_bsg: Remove unnecessary length checkup
  ufs: ufs_bsg: Cleanup ufs_bsg_request
  ufs: core: Split ufshcd_map_sg
  ufs: core: Advanced RPMB detection
  ufs: core: Pass EHS length into ufshcd_prepare_req_desc_hdr()
  ufs: core: Add advanced RPMB support in ufs_bsg

 drivers/ufs/core/ufs_bsg.c       | 137 +++++++++++++++---------
 drivers/ufs/core/ufshcd.c        | 178 +++++++++++++++++++++++++------
 include/uapi/scsi/scsi_bsg_ufs.h |  48 ++++++++-
 include/ufs/ufs.h                |  29 +++++
 include/ufs/ufshcd.h             |   6 +-
 include/ufs/ufshci.h             |   1 +
 6 files changed, 318 insertions(+), 81 deletions(-)

-- 
2.25.1

