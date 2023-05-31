Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684E4717C70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjEaJwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjEaJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:51:57 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B70E2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1685526717; x=1717062717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TBWF4D4UZjXgQx987Mw0MVO5pVy0dCOmulH6bn2mnIY=;
  b=KE6oKdzWSXn/9hEaJkjf3KHNLjvzXDCBSCxhX1Ud2PlGn4lYfhndsvko
   g6PYi3AKVgFqdjv5vpjKPHBwOc5JQ6gcOJCO46P+V+0pNQXCtz69LUMRj
   26TdQLlxKSbbWx4mPVLUVEuTPLlzWYfvOwpXTCRiIMkGoQpZxIUApmB5c
   o=;
X-IronPort-AV: E=Sophos;i="6.00,205,1681171200"; 
   d="scan'208";a="217609750"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:51:53 +0000
Received: from EX19D016EUA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com (Postfix) with ESMTPS id 5984E662A5;
        Wed, 31 May 2023 09:51:51 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19D016EUA002.ant.amazon.com (10.252.50.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 09:51:49 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.1.212.23) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 09:51:46 +0000
From:   Babis Chalios <bchalios@amazon.es>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        <linux-kernel@vger.kernel.org>
CC:     <bchalios@amazon.es>, <graf@amazon.de>, <mzxreary@0pointer.de>,
        <xmarcalx@amazon.co.uk>
Subject: [PATCH 1/1] vmgenid: emit uevent when VMGENID updates
Date:   Wed, 31 May 2023 11:51:19 +0200
Message-ID: <20230531095119.11202-2-bchalios@amazon.es>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230531095119.11202-1-bchalios@amazon.es>
References: <20230531095119.11202-1-bchalios@amazon.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.1.212.23]
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We receive an ACPI notification every time the VM Generation ID changes
and use the new ID as fresh randomness added to the entropy pool. This
commits emits a uevent every time we receive the ACPI notification, as a
means to notify the user space that it now is in a new VM.

Signed-off-by: Babis Chalios <bchalios@amazon.es>
---
 drivers/virt/vmgenid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index a1c467a0e9f7..b67a28da4702 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -68,6 +68,7 @@ static int vmgenid_add(struct acpi_device *device)
 static void vmgenid_notify(struct acpi_device *device, u32 event)
 {
 	struct vmgenid_state *state = acpi_driver_data(device);
+	char *envp[] = { "NEW_VMGENID=1", NULL };
 	u8 old_id[VMGENID_SIZE];
 
 	memcpy(old_id, state->this_id, sizeof(old_id));
@@ -75,6 +76,7 @@ static void vmgenid_notify(struct acpi_device *device, u32 event)
 	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
 		return;
 	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
+	kobject_uevent_env(&device->dev.kobj, KOBJ_CHANGE, envp);
 }
 
 static const struct acpi_device_id vmgenid_ids[] = {
-- 
2.39.2

