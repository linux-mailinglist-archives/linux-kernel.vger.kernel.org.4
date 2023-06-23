Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67FD73AF01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjFWDVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFWDVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:21:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D062136
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687490475; x=1719026475;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+GyKTZuy62fSfS3VYDAFPO3eY0d0wtMRS4HB7F+xZTk=;
  b=UXRtpRdeP0WCWv8KRHrpt+zydrH3O/SLjXxzRgNBB6NnDcfUaccqaUhI
   GKLLnmBxjuLsn3uY0hvNlj3dtYs3g07bHf2vlRzZRsRc92NKXs1hmpcOW
   J1OPmA1Kjo3O48XAqbWrDn7clux+MLHdRYFESlR4LcBq7n5IcejjuBaLG
   aJT2yN46l4Vc3HDDE8mu82RUZzJzBaf8zeU4fNHPnjy7NmJKONfO1tvg5
   STmqoM/spgDRY8P6jLxCj0L/EDAD1fr6MCPeFawsQEjzDwMtSoOEnU6pU
   gKkDCOxdctXc2Nomq7vYpc00lCkfgq0PPom9KA6b6iP9XXkz9E3kwS1z5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359539530"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359539530"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692526394"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="692526394"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 20:21:13 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 00/12] New Crypto service commands
Date:   Fri, 23 Jun 2023 11:20:17 +0800
Message-Id: <20230623032029.1755017-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

hi,
This patch set comprises updates to the svc driver to add new crypto
services for AES encryption/decryption, SHA2 digest generation, SHA2 
MAC verification, ECDSA hash signing, ECDSA SHA2 data signing, ECDSA
hash signature verification, ECDSA SHA2 data signature verification
crypto key management and lastly ECDSA public key retrieval.
The additions of the commands are all standard entries to svc driver 
with minimal logic. 

Ang Tien Sung (12):
  firmware: stratix10-svc: support open & close crypto session
  firmware: stratix10-svc: crypto key management
  firmware: stratix10-svc: AES encrypt and decrypt
  firmware: stratix10-svc: increase msg arg size
  firmware: stratix10-svc: SHA-2 digest
  firmware: stratix10-svc: HMAC SHA2 verify
  firmware: stratix10-svc: ECDSA Hash signing
  firmware: stratix10-svc: ECDSA SHA2 data signing
  firmware: stratix10-svc: hash signature verification
  firmware: stratix10-svc: SHA2 signature verification
  firmware: stratix10-svc: public key request
  firmware: stratix10-svc: ECDH request

 drivers/firmware/stratix10-svc.c              | 309 +++++++-
 include/linux/firmware/intel/stratix10-smc.h  | 708 ++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  86 ++-
 3 files changed, 1100 insertions(+), 3 deletions(-)

-- 
2.25.1

