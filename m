Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15C373C2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjFWVfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjFWVfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:35:38 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B51BD8;
        Fri, 23 Jun 2023 14:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687556138; x=1719092138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2TUgoT4bLvHLzmABFNFloySgnKYSBz0bB+q6744uJI4=;
  b=W6bX+dkFhb4x/ZnzNi+WpJuq8G8bKGfu7xN1CwRkWf3AyQcl9BICpGDb
   r1a0a/MpSed3II+NMh5HHdXvoJrZ+FOJJF//jQ6G3FJq3Un+K/4vXj27I
   LM9pSJKFmWofB5LVwfHZGNHQcY26PJjb1vPytO6U7pZFbd8HxKPdyTvyv
   4=;
X-IronPort-AV: E=Sophos;i="6.01,153,1684800000"; 
   d="scan'208";a="222572587"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 21:35:37 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id 28E5960A79;
        Fri, 23 Jun 2023 21:35:35 +0000 (UTC)
Received: from EX19D002UWA001.ant.amazon.com (10.13.138.247) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 23 Jun 2023 21:35:35 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D002UWA001.ant.amazon.com (10.13.138.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 23 Jun 2023 21:35:35 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Fri, 23 Jun 2023 21:35:34
 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id B1DBD25EC; Fri, 23 Jun 2023 21:35:34 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <gregkh@linuxfoundation.org>, <pc@cjr.nz>
CC:     <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>,
        Rishabh Bhatnagar <risbhat@amazon.com>
Subject: [PATCH 5.4 0/5] CIFS DFS fixes for 5.4
Date:   Fri, 23 Jun 2023 21:34:01 +0000
Message-ID: <20230623213406.5596-1-risbhat@amazon.com>
X-Mailer: git-send-email 2.40.1
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

We are seeing deadlock in cifs code while updating volume in
cifs_reconnect. There are few fixes available in stable trees
already. This series backports some patches back to 5.4 stable.

 __schedule+0x268/0x6e0
 schedule+0x2f/0xa0
 schedule_preempt_disabled+0xa/0x10
 __mutex_lock.isra.7+0x20b/0x470
 ? dfs_cache_update_vol+0x45/0x2a0 [cifs]
 dfs_cache_update_vol+0x45/0x2a0 [cifs]
 cifs_reconnect+0x6f2/0xef0 [cifs]
 cifs_handle_standard+0x18d/0x1b0 [cifs]
 cifs_demultiplex_thread+0xa5c/0xc90 [cifs]
 ? cifs_handle_standard+0x1b0/0x1b0 [cifs]

Paulo Alcantara (SUSE) (5):
  cifs: Clean up DFS referral cache
  cifs: Get rid of kstrdup_const()'d paths
  cifs: Introduce helpers for finding TCP connection
  cifs: Merge is_path_valid() into get_normalized_path()
  cifs: Fix potential deadlock when updating vol in cifs_reconnect()

 fs/cifs/dfs_cache.c | 701 +++++++++++++++++++++++---------------------
 1 file changed, 372 insertions(+), 329 deletions(-)

-- 
2.40.1

