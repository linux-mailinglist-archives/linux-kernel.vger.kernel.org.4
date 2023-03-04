Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50D36AAA5E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCDORF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDORE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:17:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8E71E5E6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 06:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677939376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U3owH7kSULJ38O6Qo7Jgo8/hXPlc1X07as0wsxO2/zQ=;
        b=b4cwbJOd7s6S/mWVqFLCDdXod0Nroz8E+ookDJ3V9Q9lYQS7hd650E0BWo/E0GRC6dxeaB
        EhbHzNVfAsfz8oe0mI3vqK69qksM1vpLaUpj94fD7nd3XR7LYN93GLvpzcIS0AaMqqERly
        2aDQFL4blyVYHbkUbl7FK58Jc17HfUc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-tHnmKgZ0PseOzVPDZ9bdxA-1; Sat, 04 Mar 2023 09:16:15 -0500
X-MC-Unique: tHnmKgZ0PseOzVPDZ9bdxA-1
Received: by mail-qk1-f197.google.com with SMTP id u28-20020a05620a085c00b0073b88cae2f5so3105531qku.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 06:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677939374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3owH7kSULJ38O6Qo7Jgo8/hXPlc1X07as0wsxO2/zQ=;
        b=l31vuxje/NzqdAuV2uS04GGADPi0NwqQhhJhF+3dF0QHvEfoohtHONxdWLw2Ai/NS3
         OuJZG7JSz5P12H7toe7+D/mTw3fvkGdsBAi0BC4WoOlL/K73xueDVoFw2HIABmxHBG0W
         AlXwOn9sP2gFYaQzXmIZV2mQUcUCnSL0KmIKYOGX98c/vMdp4/gwqrXgQOd0B1s8tBkK
         hjlyDqXNTiuAsgWkaaIik0giii049k6tRTCiZFq7AlAMdzWvcTS4B1PUZGTOzPesn+ln
         ghvdA9Qm1m+CufriLBE+1T9FfsPJ0dp8yw3Ij0DVhbiAYWEQ94EPN3OS0TiFIxpe4KRN
         fXxA==
X-Gm-Message-State: AO0yUKWMvIYJmWsYbYDVF4/f5ymFVbFI4t0DMK9DkSj2gdR6dJ/PCHe3
        cWkI8xjsAYdYdTYzdWfg037J1zkfaD3MYGm3jaNKSAeO16uDCJL9Y7V42n/Y7elQob6ahTFznwb
        SIIBab2KtLr5kjyhGqMlNPet6
X-Received: by 2002:a05:622a:1993:b0:3ba:1f09:94ab with SMTP id u19-20020a05622a199300b003ba1f0994abmr8753175qtc.57.1677939374773;
        Sat, 04 Mar 2023 06:16:14 -0800 (PST)
X-Google-Smtp-Source: AK7set/jK154JMMOiBXERJyzZNOcpcympluZ6y/jVTObW0aK6O3m2t1pJjJUIauy+IQoM4RSEQs5ag==
X-Received: by 2002:a05:622a:1993:b0:3ba:1f09:94ab with SMTP id u19-20020a05622a199300b003ba1f0994abmr8753141qtc.57.1677939374531;
        Sat, 04 Mar 2023 06:16:14 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w19-20020ac843d3000000b003bfbf3afe51sm3740960qtn.93.2023.03.04.06.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 06:16:14 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mhiramat@kernel.org,
        yangjihong1@huawei.com, ast@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] x86/kprobes: remove extern from arch_unoptimized_kprobes
Date:   Sat,  4 Mar 2023 09:15:44 -0500
Message-Id: <20230304141544.1936934-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
arch/x86/kernel/kprobes/opt.c:537:13: warning:
  function 'arch_unoptimize_kprobes' with external linkage has definition

extern is only needed in a declaration, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/kernel/kprobes/opt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 57b0037d0a99..1e699deb77fe 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -534,8 +534,8 @@ void arch_unoptimize_kprobe(struct optimized_kprobe *op)
  * Recover original instructions and breakpoints from relative jumps.
  * Caller must call with locking kprobe_mutex.
  */
-extern void arch_unoptimize_kprobes(struct list_head *oplist,
-				    struct list_head *done_list)
+void arch_unoptimize_kprobes(struct list_head *oplist,
+			     struct list_head *done_list)
 {
 	struct optimized_kprobe *op, *tmp;
 
-- 
2.27.0

