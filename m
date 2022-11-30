Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8FC63D2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiK3KMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiK3KL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:11:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58FB32B8C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669803055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcX4h7B4Cn2uY8DsNhXZd0MIAMkHSmKLkxFeut2xdUs=;
        b=bo1QeYRmFl8wjGWCL4ReZe95FtPshmJ4lekS3XeQCVcAiJLfl99wB71wofLPiiiNd6jlNT
        E36Ai2YqFozufibn/jZm1mgu2SpS9IA98BS+q7poCls4yZZhcMOqJRAAikhmhWEDDBZHqC
        bKzKMi+B55or4VCQxZ9YDpuqFDjPFAQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-al01h2BcNG2dZSPCXBRCdQ-1; Wed, 30 Nov 2022 05:10:52 -0500
X-MC-Unique: al01h2BcNG2dZSPCXBRCdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72A063804066;
        Wed, 30 Nov 2022 10:10:51 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.195.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D45540E978E;
        Wed, 30 Nov 2022 10:10:33 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] HID: bpf: enforce HID_BPF dependencies
Date:   Wed, 30 Nov 2022 11:10:20 +0100
Message-Id: <20221130101021.1868764-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20221130101021.1868764-1-benjamin.tissoires@redhat.com>
References: <20221130101021.1868764-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in the link below, having JIT and BPF is not enough to
have fmod_ret and error injection APIs. This resolves the error that
happens on a system without tracing enabled when hid-bpf tries to
load itself.

Link: https://lore.kernel.org/r/CABRcYmKyRchQhabi1Vd9RcMQFCcb=EtWyEbFDFRTc-L-U8WhgA@mail.gmail.com
Fixes: f5c27da4e3c8 ("HID: initial BPF implementation")
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/bpf/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/Kconfig b/drivers/hid/bpf/Kconfig
index 298634fc3335..498232f9faa9 100644
--- a/drivers/hid/bpf/Kconfig
+++ b/drivers/hid/bpf/Kconfig
@@ -4,7 +4,9 @@ menu "HID-BPF support"
 config HID_BPF
 	bool "HID-BPF support"
 	default HID_SUPPORT
-	depends on BPF && BPF_SYSCALL
+	depends on BPF && BPF_SYSCALL && \
+		   DYNAMIC_FTRACE_WITH_DIRECT_CALLS && \
+		   FUNCTION_ERROR_INJECTION
 	help
 	This option allows to support eBPF programs on the HID subsystem.
 	eBPF programs can fix HID devices in a lighter way than a full
-- 
2.38.1

