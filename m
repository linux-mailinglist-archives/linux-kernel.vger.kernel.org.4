Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4653471F447
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjFAU6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFAU6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:58:32 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550ADB3;
        Thu,  1 Jun 2023 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685653111; x=1717189111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0//iUfwElF6+Ol5SZRiYFlOIxvlZ/qXnBBIyuRbnzNg=;
  b=MnPQiEPjqAJ+nbgcNruMDa6ww83bE66OseZF9QEnLO25R6jVymwZ+FMX
   1U9IL5kdJ0pREJW5UKlwx+Bipuw5iluyZDNjefzwSMZxJCTci1Irdt73y
   qyjcRJJcAzW44g9u3CMOrsRKZrzQ8fx+jiorSTwTEfdQ/qu89kUwj5r13
   I=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681171200"; 
   d="scan'208";a="7512814"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 20:58:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id B85D68B58C;
        Thu,  1 Jun 2023 20:58:30 +0000 (UTC)
Received: from EX19D002UWC001.ant.amazon.com (10.13.138.148) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 20:58:30 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D002UWC001.ant.amazon.com (10.13.138.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 20:58:30 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 20:58:30 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id 4D47EE6E; Thu,  1 Jun 2023 20:58:30 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <gregkh@linuxfoundation.org>, <sfrench@samba.org>
CC:     <stable@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Rishabh Bhatnagar <risbhat@amazon.com>
Subject: [PATCH 5.4 0/2] Backport few dfs related fixes to cifs
Date:   Thu, 1 Jun 2023 20:58:15 +0000
Message-ID: <20230601205817.3957-1-risbhat@amazon.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.39.2

