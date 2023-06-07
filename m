Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42FC726C78
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjFGUdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjFGUdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:33:39 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F2E184;
        Wed,  7 Jun 2023 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686170019; x=1717706019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JFQnltE05obEPa/KtKPh+QioRvgaOvNdBJH+YPUUyrY=;
  b=lzkTE7pPMPsptBoV40x+i9DKEraVwEBa5KZw/s+ehCtJ6jgCw4P/By7D
   UoNErAupcnC7+vRricJkh4mglPDR0FvC4O2ue4SMUIpzyUihIO4NryLi+
   h6kFOnrAkcGmxMOlb27O0C57ETe8u+wEaVNtEyUgAAw/LtaMSd9DHtY2I
   Q=;
X-IronPort-AV: E=Sophos;i="6.00,225,1681171200"; 
   d="scan'208";a="337509663"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 20:33:38 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com (Postfix) with ESMTPS id 7CA1D804AF;
        Wed,  7 Jun 2023 20:33:36 +0000 (UTC)
Received: from EX19D002UWA004.ant.amazon.com (10.13.138.230) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 20:33:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D002UWA004.ant.amazon.com (10.13.138.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 20:33:34 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 20:33:34 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id 53423222F; Wed,  7 Jun 2023 20:33:34 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <gregkh@linuxfoundation.org>
CC:     <sfrench@amazon.com>, <stable@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Rishabh Bhatnagar" <risbhat@amazon.com>
Subject: [PATCH v2 5.4 0/2] Backport few dfs related fixes to cifs
Date:   Wed, 7 Jun 2023 20:33:31 +0000
Message-ID: <20230607203333.26669-1-risbhat@amazon.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we have been seeing kernel panic in cifs_reconnect function
while accessing tgt_list. Looks like tgt_list is not initialized
correctly. There are fixes already present in 5.10 and later trees.
Backporting them to 5.4

 CIFS VFS: \\172.30.1.14 cifs_reconnect: no target servers for DFS
 failover
 BUG: unable to handle page fault for address: fffffffffffffff8
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 260e067 P4D 260e067 PUD 2610067 PMD 0
 Oops: 0000 [#1] SMP PTI
 RIP: 0010:cifs_reconnect+0x51d/0xef0 [cifs]
 RSP: 0018:ffffc90000693da0 EFLAGS: 00010282
 RAX: fffffffffffffff8 RBX: ffff8887fa63b800 RCX: fffffffffffffff8
 Call Trace:
 cifs_handle_standard+0x18d/0x1b0 [cifs]
 cifs_demultiplex_thread+0xa5c/0xc90 [cifs]
 kthread+0x113/0x130

Paulo Alcantara (2):
  cifs: get rid of unused parameter in reconn_setup_dfs_targets()
  cifs: handle empty list of targets in cifs_reconnect()

 fs/cifs/connect.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
Changelog:
v2 -> v1:
- Correct the kernel tree from 5.10 to 5.4 for the patches.

2.39.2

