Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC6F717C71
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbjEaJwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjEaJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:51:57 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03392E8
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1685526716; x=1717062716;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4Igss+3x2agx8603xsL3qm5IWad8k5KD3BTAi7rhQkg=;
  b=aErPPfG9X0Q2wH99EK8AWi1mDKh2i0dZcdVFu5Q+2UV1VDSstOoW7OMz
   SvinBnjvq8bclHU/a8FOcKYOQGKkvmnqtSrkQv5M/cusj5v+SBlURwk4H
   EK8qWSl1dqiIPAzmPP80PSvQ60qDPO3qskzG1T109Do7SH1+FP/tehbs2
   c=;
X-IronPort-AV: E=Sophos;i="6.00,205,1681171200"; 
   d="scan'208";a="330534393"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:51:51 +0000
Received: from EX19D017EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 87BD940E17;
        Wed, 31 May 2023 09:51:49 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19D017EUA001.ant.amazon.com (10.252.50.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 09:51:46 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.1.212.23) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 09:51:43 +0000
From:   Babis Chalios <bchalios@amazon.es>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        <linux-kernel@vger.kernel.org>
CC:     <bchalios@amazon.es>, <graf@amazon.de>, <mzxreary@0pointer.de>,
        <xmarcalx@amazon.co.uk>
Subject: [PATCH 0/1] User space notifications about VM cloning
Date:   Wed, 31 May 2023 11:51:18 +0200
Message-ID: <20230531095119.11202-1-bchalios@amazon.es>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.1.212.23]
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch revisits the story of user space notification about VM
events. It uses uevents to send a notification to user space that the
VMGENID has changed, thus we are now in a new VM.

Please note, that this is not a "you need to reseed your PRNGs" event,
which was what the previous RFC [1] was trying to do. It is, explicitly,
meant to be a "you are now running in a new VM" event for the user space
to consume, so it can do things like regenerating its MAC addresses and
refreshing DHCP. For these cases, we do not want to tie on the "you need
to reseed your PRNGs" event, since these do not necessarily get emitted
only when VMs get cloned.

[1] https://lore.kernel.org/lkml/65d872db2e1be29bb03b43ed606e7cc9e74ec08d.camel@infradead.org/T/

Babis Chalios (1):
  vmgenid: emit uevent when VMGENID updates

 drivers/virt/vmgenid.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.39.2

