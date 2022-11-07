Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4E661F40A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiKGNLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiKGNLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:11:03 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB15F1C118;
        Mon,  7 Nov 2022 05:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1667826654;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=+rhn3V8+zDKpCdIBPe9SURIvaAZ23v/3ueIpZJEDWQ0=;
    b=g6dwblg/pDuVaigLWqElocSfGdhVaheY0cG1ITQ8y4QosjDFfaX1NhXPo9UFzO0eZ3
    UwUNFupM+mLeeywVbst7wuVjX+piHoYp22OwcvdIZNszkpcYsey76+iJ294L7Tg3CfYH
    yJs0n/Gp0siCPkRvnsveshmza6L32rtnidpIyUBxtUKPo2LbaaA47N+95AwRn1ZqSxSI
    QJAO+os50OFPH/qy00eRhgNiN7HYnb85n3bhXfelS8wKBw4HZDT/EWMNdX8SnjM7PDLV
    QlZCFMAiYBq7SrZttfbLk8fk7RcY8GLA8NwJhCxNXmSfjWG1eoMqv6W78GZ7H8ZTtRmW
    ygxw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RvWtIeMr7Q/U8vM/+oObyVBycbphAC+CkWyag=="
X-RZG-CLASS-ID: mo00
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyA7DArjG8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 7 Nov 2022 14:10:53 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@iokpp.de>
Subject: [RFC PATCH v1 0/2] UFS Advanced RPMB
Date:   Mon,  7 Nov 2022 14:10:36 +0100
Message-Id: <20221107131038.201724-1-beanhuo@iokpp.de>
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

In UFS 4.0, it introduced advanced RPMB, which can significantly improve RPMB's command
performance, enhancing its atomic operation. We don't know which implementation will please
everyone, mark this advanced RPMB patch as RFC. Any suggestions to make the patch a master
patch are welcome.

Based on suggestions and feedback from Hannes Reinecke and Bart, we can use job_bsg->request
and job_bsg->reply to pass EHS packets without changing the BSG V4 structure and BSG core. So
we push RFC patch just to start Advanced RPMB mainlining

Bean Huo (2):
  ufs: core: Advanced RPMB detection
  ufs: core: Add advanced RPMB support in ufs_bsg

 drivers/ufs/core/ufs_bsg.c       | 115 +++++++++++++---------
 drivers/ufs/core/ufshcd.c        | 161 ++++++++++++++++++++++++-------
 include/uapi/scsi/scsi_bsg_ufs.h |  30 +++++-
 include/ufs/ufs.h                |   3 +
 include/ufs/ufshcd.h             |   5 +
 5 files changed, 233 insertions(+), 81 deletions(-)

-- 
2.25.1

