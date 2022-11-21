Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70F0631A57
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKUHbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUHbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:31:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5276DFD0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669015798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PzrpIQOcRog587drqyOgalYCERQdLn/ggTvNzPloyBI=;
        b=hKTW+BfQMY55SqBtFY9LYsktEBaAYXmU9RV1DItvZ7eo86DbMHwfQMOCA74GI0RvAT0LGT
        Sg7tnrHM+3ZDEJEkI6ZPmLoguwd5cN5IfDhPIf0bF/M1QQUVBpL2sVbJVnYi3iGT5RHEly
        6PJ2+9bjcaWqSnmgQmIPN8FBFQD9JQA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-185-0WixvXDrPT-di3yDihU1gw-1; Mon, 21 Nov 2022 02:29:57 -0500
X-MC-Unique: 0WixvXDrPT-di3yDihU1gw-1
Received: by mail-pl1-f197.google.com with SMTP id a6-20020a170902ecc600b00186f035ed74so8873710plh.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:29:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzrpIQOcRog587drqyOgalYCERQdLn/ggTvNzPloyBI=;
        b=SWr9aX3Lvg0ZyQPyManAiEjTsHZF4uh0rchxhLEbC3ibvA19rfgtZ9VYFtrBk5bSll
         lUsCbd3I/cXPQUbtB4b8tinGzO0hQPPbDflDRlgk3zgbnh9nCoG19tnTo8v6ysbOKTPu
         dGWO++JPgo8OHjyEg8EqdXIDuCJurTJea2CWmM0lDMAh4bbk7liCGWqHRJQz53OhEXzc
         /LshD2E2tACcz5pHxSYhAxOlLGZpjMBzyAgnYyfkQ9mAv2PPOPxn1c59vzk/hzK+bCx/
         ACt9KQI3Aj9FU0MSoCK/LlxzPK3cA8UwnB6xTHchaE6yEoJ7+Lr//gqXbKJf5M3St/Zi
         gGoQ==
X-Gm-Message-State: ANoB5plA6vqHsX/XuwBseI67LVwfd0R/IV2u5Hxz/7ybCCW0gpc0+WfF
        w2t8CFhmdL02fZlhJrwDYnQ/NWCIHp9sPLfs0fw9a5PsREWGyROKpgw3aPoqWNmSiu2DzkaHV/2
        YUnVmwB36m+wQ8kqhKxe4OvUR
X-Received: by 2002:a17:902:bcc7:b0:188:f42e:6a90 with SMTP id o7-20020a170902bcc700b00188f42e6a90mr926384pls.127.1669015795848;
        Sun, 20 Nov 2022 23:29:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7EcYX61iVqKcEdoBRAEQ94b78zalp2WbshZ4Dz+5rKx3bpryPWxZ9XpTzupJLi96mob2prPA==
X-Received: by 2002:a17:902:bcc7:b0:188:f42e:6a90 with SMTP id o7-20020a170902bcc700b00188f42e6a90mr926361pls.127.1669015795583;
        Sun, 20 Nov 2022 23:29:55 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm8886857plq.34.2022.11.20.23.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:29:54 -0800 (PST)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] lockdown: kexec_file: prevent unsigned kernel image when KEXEC_SIG not enabled
Date:   Mon, 21 Nov 2022 15:29:47 +0800
Message-Id: <20221121072947.836672-1-coxu@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kernel builder may not enable KEXEC_SIG and some architectures like
ppc64 simply don't have KEXEC_SIG. In these cases, unless both
IMA_ARCH_POLICY and secure boot also enabled, lockdown doesn't prevent
unsigned kernel image from being kexec'ed via the kexec_file_load
syscall whereas it could prevent one via the kexec_load syscall. Mandate
signature verification for those cases.

Fixes: 155bdd30af17 ("kexec_file: Restrict at runtime if the kernel is locked down")
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: David Howells <dhowells@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 kernel/kexec_file.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..04d56b6e6459 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -125,6 +125,20 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->image_loader_data = NULL;
 }
 
+static int mandate_signatute_verification(void)
+{
+	/*
+	 * If IMA is guaranteed to appraise a signature on the kexec
+	 * image, permit it even if the kernel is otherwise locked
+	 * down.
+	 */
+	if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
+	    security_locked_down(LOCKDOWN_KEXEC))
+		return -EPERM;
+
+	return 0;
+}
+
 #ifdef CONFIG_KEXEC_SIG
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
@@ -168,14 +182,9 @@ kimage_validate_signature(struct kimage *image)
 			return ret;
 		}
 
-		/*
-		 * If IMA is guaranteed to appraise a signature on the kexec
-		 * image, permit it even if the kernel is otherwise locked
-		 * down.
-		 */
-		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
-		    security_locked_down(LOCKDOWN_KEXEC))
-			return -EPERM;
+		ret = mandate_signatute_verification();
+		if (ret)
+			return ret;
 
 		pr_debug("kernel signature verification failed (%d).\n", ret);
 	}
@@ -211,10 +220,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 
 #ifdef CONFIG_KEXEC_SIG
 	ret = kimage_validate_signature(image);
-
+#else
+	ret = mandate_signatute_verification();
+#endif
 	if (ret)
 		goto out;
-#endif
+
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
-- 
2.38.1

