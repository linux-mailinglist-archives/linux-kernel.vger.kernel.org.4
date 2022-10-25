Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A38460D6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiJYWZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiJYWZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:25:06 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE6B4AD4F;
        Tue, 25 Oct 2022 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1666736696;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4Nxlvyuq0njEtgrR0gNydVwaHz1seLH1VE0uZGgp5b0=;
    b=ED46xP2LxtaYKgw/KI9g4BnK9yYCBSlsnXTv6leA/karDJoDeVehNBB6sIPWfa7USH
    TLHrNXkLkg6dE7gvsKz2SeusIRyfyO4S0FLLRdgQGHLr3SaUt7iD3kFsT+/YSV0ET/Tt
    6sJZYtQtxr4+sYrBKCcXMhwlmdVhB731HVN129CPalsOz8XL7DhgwFZMO2I94M3q3N0B
    EeOZb8dcuSFvUhZRu64EEYZFKKiNhkHwSYtYoRDexKeMYhzvYE1J/FK9wI4C+HOaFgkv
    xSFJ7t9oJ4EdFuyNG7gway9FHW6dGX8SAH5kZYJjaSSA5hwBV9ULeY1DlOuO9w9g8MmE
    y1DQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD/R51xABQjgPFtj5ophaE="
X-RZG-CLASS-ID: mo00
Received: from linux..
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id z9cfbfy9PMOs2EA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 26 Oct 2022 00:24:54 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Changes for ufshcd.c
Date:   Wed, 26 Oct 2022 00:24:27 +0200
Message-Id: <20221025222430.277768-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

v4--v5:
    1. Rebase the patch
    2. Change commit message of patch 1/3

v3--v4:
    1. Change patch 1/3 title
    2. Fix one typo in patch 3/3
    3. Fix coding type issue in  patch 2/3 based on Bart's comment

v2--v3:
    1. Add patch 3/3
    2. Add remove unused parameter param_offset in patch 1/3 based on Daejun's comment
    3. Further optimized patch 2/3 based on Bart's comment

v1--v2:
    1. change in ufshcd_lu_init() in  patch 2/2:
        1) Remove duplicate parameter initialization
        2) Move lun parameter initialization before kmalloc()

Bean Huo (3):
  scsi: ufs: core: Revert "WB is only available on LUN #0 to #7"
  scsi: ufs: core: Cleanup ufshcd_slave_alloc()
  scsi: ufs: core: Use is_visible to control UFS unit descriptor sysfs
    nodes

 drivers/ufs/core/ufs-sysfs.c   |  21 ++++-
 drivers/ufs/core/ufshcd-priv.h |   6 +-
 drivers/ufs/core/ufshcd.c      | 152 ++++++++++++---------------------
 3 files changed, 74 insertions(+), 105 deletions(-)

-- 
2.34.1

