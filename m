Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE92719420
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjFAHZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjFAHZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24179184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685604294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AV8aUvr4ixGLZyIesmYQLsbGSBUr0/xlhliel/t7Lh8=;
        b=K9c8Zm6BwoJeB31EY74w3URzxj6zFDliZuWsim08otfp6MIJWyaGgiNGjp+dWv7TrLJPDR
        dCxy2nX/fGlCsZM8pVZ06mYTalwn9vVDEXI4R9NwXk1xVsu6CkX+akptNNzdu6+aVAeaB1
        ti+KiOoPUMVY8pY0xSsycA2cjD6qCtQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-oVvbfSETNHap7HRxXCrzfQ-1; Thu, 01 Jun 2023 03:24:53 -0400
X-MC-Unique: oVvbfSETNHap7HRxXCrzfQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b031a8fbe5so1757505ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 00:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604292; x=1688196292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AV8aUvr4ixGLZyIesmYQLsbGSBUr0/xlhliel/t7Lh8=;
        b=TYFVh+p2kDOM5KzD6LophXd19IFL0SDunKEiMcbETcJNVO2iPgF290I9FfT/lBYs4K
         q/kiQl3540xSgqeWiRp37jZTAxgdJTK3VSJf8LcQiQBbjxhiwlO2Vd0x84mcl2rsMixc
         61p9R9NPtDR4Ht3TPtkqzP5Brkd8Udiw48+9etlBVkJNF+DI2vI+YiS+px6G9I5kasQN
         xrLj6Q7PJh8HGjyLzpw+6GTTmA9rpx28PJQRtG2AA9A2rcBmIYhrnUN0IHDJ3ez9QUxV
         8Q/855cb8sRHbgRoljaXWxNpLAdFaN2QDVxFwTb3ddeZkFOZPQ4tT7eIf09gHiOYAhgx
         kMTg==
X-Gm-Message-State: AC+VfDzi9gnLquowFEm/HF/QrL2nKD3eP5MaN1jTuBpqSFafmy+rJxc3
        XyD+JiZY2/mSdtwPCkXhbtcr1YCxPX4Yvj7qExMYoxB2SAhkoNQ0lQuk40rn/3m/lz1C6lGa5hb
        dOU9fOyua3JkBTKjtkso5e3oP
X-Received: by 2002:a17:902:e811:b0:1b0:5e97:ee2e with SMTP id u17-20020a170902e81100b001b05e97ee2emr6960535plg.19.1685604292000;
        Thu, 01 Jun 2023 00:24:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ662P0lLrFIg86H16E966109yZnfDIKygWQtWOgjwFAIugqodl1XMDNcj6+cm1VNgP+uGfilg==
X-Received: by 2002:a17:902:e811:b0:1b0:5e97:ee2e with SMTP id u17-20020a170902e81100b001b05e97ee2emr6960516plg.19.1685604291629;
        Thu, 01 Jun 2023 00:24:51 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00199203a4fa3sm2666890plg.203.2023.06.01.00.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:24:51 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 1/5] kexec_file: allow to place kexec_buf randomly
Date:   Thu,  1 Jun 2023 15:24:40 +0800
Message-Id: <20230601072444.2033855-2-coxu@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601072444.2033855-1-coxu@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index 22b5cd24f581..5b2440444112 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -172,6 +172,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -183,6 +184,7 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+	bool random;
 };
 
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..5dbfc119eb6a 100644
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
@@ -419,6 +420,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
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
@@ -427,6 +438,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz;
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, temp_end);
 
 	do {
 		/* align down start */
@@ -464,6 +477,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_start = max(start, kbuf->buf_min);
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, end);
 
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
-- 
2.40.1

