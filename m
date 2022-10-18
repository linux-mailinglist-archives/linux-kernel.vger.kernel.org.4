Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204A7603227
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJRSQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJRSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:16:47 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DF37D1FF;
        Tue, 18 Oct 2022 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1666116998;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=rC125LhrzcYLeAaz+7xLGt5TDzCO2tDpbxIYa+6CZ+Q=;
    b=dUVBq4EWp7FElp68G5ubEHHU6vq7VSWGoRKg22Z3+nqAZ5DVhb361VMPwLbrgCzLA+
    LD/GIjFVBdhKL7xVyCt3q/7GLptm4+mRf52hkjwye8pJyu8vQtjRRptFkKJ/wPFdqIkd
    XhzU7Q29prm03Y7nO4Fj/vBqlDx+7TfPIdQxKUGbAbEoxnY7r+dNekLpHXEE+sTUN0H9
    XxNqCXDJMARatumuPcSN3MCkKIHR8nfHeqt9eHsq3HS3QSKvTPGCWMqsh5rNvvvhCUs5
    C4rh5NLtOC1b8em//4mVWvp7S6zZrZmpGaORLYF8Mjzfy8wL6BJMFQ4YLD52H4EJh2da
    VG3w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
X-RZG-CLASS-ID: mo00
Received: from linux.micron.com
    by smtp.strato.de (RZmta 48.2.0 AUTH)
    with ESMTPSA id zad98cy9IIGZYSS
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 18 Oct 2022 20:16:35 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com, huobean@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Changes for ufshcd.c
Date:   Tue, 18 Oct 2022 20:16:24 +0200
Message-Id: <20221018181627.326657-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
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

From: Bean Huo <beanhuo@micron.com>

v2--v3:
    1. Add patch 3/3
    2. Add remove unused parameter param_offset in patch 1/3 based on Daejun's comment
    3. Further optimized patch 2/3 based on Bart's comment

v1--v2:
    1. change in ufshcd_lu_init() in  patch 2/2:
        1) Remove duplicate parameter initialization
        2) Move lun parameter initialization before kmalloc()

Bean Huo (3):
  scsi: ufs: core: Remove unnecessary if statement
  scsi: ufs: core: Cleanup ufshcd_slave_alloc()
  scsi: ufs: core: Use is_visible to control UFS unit descriptor sysfs
    nodes

 drivers/ufs/core/ufs-sysfs.c   |  21 ++++-
 drivers/ufs/core/ufshcd-priv.h |   6 +-
 drivers/ufs/core/ufshcd.c      | 155 ++++++++++++---------------------
 3 files changed, 77 insertions(+), 105 deletions(-)

-- 
2.34.1

