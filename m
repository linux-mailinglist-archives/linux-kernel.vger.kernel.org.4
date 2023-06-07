Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B40726945
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjFGSyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjFGSyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:54:01 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04F31BD6;
        Wed,  7 Jun 2023 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686164040; x=1717700040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QQccf1KeyTZf6ZPMjV/HwnVR62uBW11Zlzl2mRiQIRQ=;
  b=jpy35Re/yLIbl7HDAU7wscKlGkE1bdjlUv8Y3WpC8q0RI5mBI+wXcKtb
   3dbDLBuSCWNu4r7uAsxdP7ygCZOu4BfL3LNyq5N6koDpiiF4W1kJk5qxc
   M7wTJnQgazMmIlIMkJTB/pgR6AWTsAJOmE37Ou3jJf9hbZKcbKaDUxrwA
   Y=;
X-IronPort-AV: E=Sophos;i="6.00,224,1681171200"; 
   d="scan'208";a="1136280854"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 18:54:00 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 31AA0413FA;
        Wed,  7 Jun 2023 18:54:00 +0000 (UTC)
Received: from EX19D002UWC001.ant.amazon.com (10.13.138.148) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 18:53:50 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D002UWC001.ant.amazon.com (10.13.138.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 18:53:50 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 18:53:50 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id BF818222F; Wed,  7 Jun 2023 18:53:49 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <gregkh@linuxfoundation.org>
CC:     <sfrench@samba.org>, <stable@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Rishabh Bhatnagar" <risbhat@amazon.com>
Subject: [PATCH 5.4 0/2] Backport few dfs related fixes to cifs
Date:   Wed, 7 Jun 2023 18:53:11 +0000
Message-ID: <20230607185313.11363-1-risbhat@amazon.com>
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

*** BLURB HERE ***

Paulo Alcantara (2):
  cifs: get rid of unused parameter in reconn_setup_dfs_targets()
  cifs: handle empty list of targets in cifs_reconnect()

 fs/cifs/connect.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.39.2

