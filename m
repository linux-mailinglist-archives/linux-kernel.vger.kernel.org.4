Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A8761955E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiKDLbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKDLbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810A625C7B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667561423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJy9Oiy5cpKmClijTkDe6KXjFE6VRuxm2Fp2gVJ4PwQ=;
        b=bJqRPoj97lfwAH3FnNZ+rWUXDiD/3fFA1GuzCGLaFnFIsTAy1aXvMHf4D9eRkI7ReTxqDy
        q/tyAvq2fEdXvBV1KDfk0AtQLc3pzh2bHMNh1M6TvCck4qXal14g18aMRh26nWpK6gzqzO
        pTZWKFXiRDJT4/BpuQVFNh6P7FR2WUQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-yre60jxfOqymj_ahPo6OAA-1; Fri, 04 Nov 2022 07:30:20 -0400
X-MC-Unique: yre60jxfOqymj_ahPo6OAA-1
Received: by mail-pl1-f200.google.com with SMTP id x18-20020a170902ec9200b001869f20da7eso3425537plg.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 04:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJy9Oiy5cpKmClijTkDe6KXjFE6VRuxm2Fp2gVJ4PwQ=;
        b=jSvhnX/ti1b3fC24Zs33lEVAEDAcNWa1cMzYUrl6dnBMPO8pse+kf7iAx/Lf2C3zXt
         41SqcxViRrRKzJp5sq/qz/cFeZiGGzdT4/1qdcrjcKXVDM9F3PPBgsqfWD+DzcNk8lCD
         zcLJ0f5p7axhVxR6aqzW10oE0w6iAcjtpmmRdYIszBmc17Wue/AsFfMYFSvBYgFjiwYe
         ryyW68dHTbBbFQJ2JvteJfcKwPZs6lpsmI5VG86OuNvjaKqZ6jGjvl26mqBZ6wN+hE/1
         a6izrOoJ+wSqJepGmL8mM8D5dXYAJxjfkullIa9cgYLhD7ppYfr1qxlq1kOTsaFzePNs
         rX4w==
X-Gm-Message-State: ACrzQf1Mlz6A2OCHZmhf1RpA3xESKkXZQ9rVC3B153yz4glCd97FquVu
        2bQ5yrqGD1BFfp3pBcDFWP4Rw1CaD1dXn2AkNnJ7TXYBDH5DKgerZiU3ibef8qBwKSeuBVP/tSX
        Bh3lfHyl7/ydv9OHpNjchMlMl
X-Received: by 2002:a17:902:aa46:b0:186:e220:11d4 with SMTP id c6-20020a170902aa4600b00186e22011d4mr35254830plr.163.1667561419298;
        Fri, 04 Nov 2022 04:30:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5pcZ6tNaPqq0YoJX850E6WOJZ5lbYOLfvzVTVy1cDIH4ecstbrpazqOrRO+fSBQKpe6bAfZw==
X-Received: by 2002:a17:902:aa46:b0:186:e220:11d4 with SMTP id c6-20020a170902aa4600b00186e22011d4mr35254808plr.163.1667561419017;
        Fri, 04 Nov 2022 04:30:19 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902684b00b0018855a22ccfsm2430982pln.91.2022.11.04.04.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:30:18 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>
Subject: [RFC v2 1/5] kexec_file: allow to place kexec_buf randomly
Date:   Fri,  4 Nov 2022 19:29:56 +0800
Message-Id: <20221104113000.487098-2-coxu@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221104113000.487098-1-coxu@redhat.com>
References: <20221104113000.487098-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kexec_buf is placed in order which means for the same
machine, the info in the kexec_buf is always located at the same
position each time the machine is booted. This may cause a risk for
sensitive information like LUKS volume key. Now struct kexec_buf has a
new field random which indicates it's supposed to be placed in a random
position.

Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_file.c   | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 13e6c4b58f07..c0edb64bf6c4 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -182,6 +183,7 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+	bool random;
 };
 
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index a7b411c22f19..ed9fcc369312 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -25,6 +25,7 @@
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
+#include <linux/prandom.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
@@ -412,6 +413,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	return ret;
 }
 
+static unsigned long kexec_random_start(unsigned long start, unsigned long end)
+{
+	unsigned long temp_start;
+	unsigned short i;
+
+	get_random_bytes(&i, sizeof(unsigned short));
+	temp_start = start + (end - start) / USHRT_MAX * i;
+	return temp_start;
+}
+
 static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 				    struct kexec_buf *kbuf)
 {
@@ -420,6 +431,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz;
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, temp_end);
 
 	do {
 		/* align down start */
@@ -457,6 +470,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_start = max(start, kbuf->buf_min);
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, end);
 
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
-- 
2.37.3

