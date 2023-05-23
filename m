Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B2D70DAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbjEWKzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbjEWKzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC00FF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684839262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BJTjmH1bvSQiv1dY4ZXd2PGQrsClXzAj4WHKRaeS0KE=;
        b=YwgxeksrEZUzxV3KiGgLzU9f2XcidoWWvEO76NLvUwzi/n9LIj4e6B1vrLRqegGiqD/BC9
        TF/UuC8F+8BExb44rU9vm+P402PMtDijGLU17NhofBrnEdLaZCUz8d3O0ubXXjKlrogDE7
        C3VLvtZS+TaXJWGSSeeOLt/SG1pFUHY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-IsNu_UZEOk67pwoPBqva1w-1; Tue, 23 May 2023 06:54:19 -0400
X-MC-Unique: IsNu_UZEOk67pwoPBqva1w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2009629AA382;
        Tue, 23 May 2023 10:54:19 +0000 (UTC)
Received: from dba62.ml3.eng.bos.redhat.com (dba62.ml3.eng.bos.redhat.com [10.19.176.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B802D492B0A;
        Tue, 23 May 2023 10:54:18 +0000 (UTC)
From:   David Arcari <darcari@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     David Arcari <darcari@redhat.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] platform/x86/intel/ifs: Annotate work queue on stack so object debug does not complain
Date:   Tue, 23 May 2023 06:54:00 -0400
Message-Id: <20230523105400.674152-1-darcari@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Object Debug results in the following warning while attempting to load
ifs firmware:

[  220.007422] ODEBUG: object 000000003bf952db is on stack 00000000e843994b, but NOT annotated.
[  220.007459] ------------[ cut here ]------------
[  220.007461] WARNING: CPU: 0 PID: 11774 at lib/debugobjects.c:548 __debug_object_init.cold+0x22e/0x2d5
[  220.137476] RIP: 0010:__debug_object_init.cold+0x22e/0x2d5
[  220.254774] Call Trace:
[  220.257641]  <TASK>
[  220.265606]  scan_chunks_sanity_check+0x368/0x5f0 [intel_ifs]
[  220.288292]  ifs_load_firmware+0x2a3/0x400 [intel_ifs]
[  220.332793]  current_batch_store+0xea/0x160 [intel_ifs]
[  220.357947]  kernfs_fop_write_iter+0x355/0x530
[  220.363048]  new_sync_write+0x28e/0x4a0
[  220.381226]  vfs_write+0x62a/0x920
[  220.385160]  ksys_write+0xf9/0x1d0
[  220.399421]  do_syscall_64+0x59/0x90
[  220.440635]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  220.566845] ---[ end trace 3a01b299db142b41 ]---

Correct this by calling INIT_WORK_ONSTACK instead of INIT_WORK.

Fixes: 684ec215706d ("platform/x86/intel/ifs: Authenticate and copy to secured memory")

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Jithu Joseph <jithu.joseph@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/intel/ifs/load.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 61dffb4c8a1d..e6ae8265f3a3 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -208,7 +208,7 @@ static int scan_chunks_sanity_check(struct device *dev)
 			continue;
 		reinit_completion(&ifs_done);
 		local_work.dev = dev;
-		INIT_WORK(&local_work.w, copy_hashes_authenticate_chunks);
+		INIT_WORK_ONSTACK(&local_work.w, copy_hashes_authenticate_chunks);
 		schedule_work_on(cpu, &local_work.w);
 		wait_for_completion(&ifs_done);
 		if (ifsd->loading_error) {
-- 
2.27.0

