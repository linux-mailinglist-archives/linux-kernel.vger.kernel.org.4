Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26827685F26
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBAFq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjBAFqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:46:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971A35420B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 21:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675230336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=13iyMrEPGqfJCvL2yfeb8yGxwtVrKuwJE/ODZ2h33NQ=;
        b=cgU08k4eJHyIocTHTgEXkDSy9fuuCjXSrJT4Tvimfc0C9RrRFYoc7/OfCj84aEZVdfAWjF
        ckwqaq+vhmfLUbgBPmsYDRO8j1x16BtGqkEzzlxu6zCQDVEPb+vWmFYeqcUHYi/Lv36jFW
        mZc0xZqztWj6u76wKzXwKO1tteQQguc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-Z_ToLan2PaSYDSt7Z0MoEA-1; Wed, 01 Feb 2023 00:45:33 -0500
X-MC-Unique: Z_ToLan2PaSYDSt7Z0MoEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FF932A59546;
        Wed,  1 Feb 2023 05:45:33 +0000 (UTC)
Received: from q.redhat.com (unknown [10.66.61.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 814DF401531B;
        Wed,  1 Feb 2023 05:45:30 +0000 (UTC)
From:   shahuang@redhat.com
To:     kvm@vger.kernel.org
Cc:     Shaoqin Huang <shahuang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests: KVM: Replace optarg with arg in guest_modes_cmdline
Date:   Wed,  1 Feb 2023 13:45:20 +0800
Message-Id: <20230201054522.162611-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shahuang@redhat.com>

The parameter arg in guest_modes_cmdline not being used now, and the
optarg should be replaced with arg in guest_modes_cmdline.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 tools/testing/selftests/kvm/lib/guest_modes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/guest_modes.c b/tools/testing/selftests/kvm/lib/guest_modes.c
index 99a575bbbc52..1f2dca4520ab 100644
--- a/tools/testing/selftests/kvm/lib/guest_modes.c
+++ b/tools/testing/selftests/kvm/lib/guest_modes.c
@@ -127,7 +127,7 @@ void guest_modes_cmdline(const char *arg)
 		mode_selected = true;
 	}
 
-	mode = strtoul(optarg, NULL, 10);
+	mode = strtoul(arg, NULL, 10);
 	TEST_ASSERT(mode < NUM_VM_MODES, "Guest mode ID %d too big", mode);
 	guest_modes[mode].enabled = true;
 }
-- 
2.39.0

