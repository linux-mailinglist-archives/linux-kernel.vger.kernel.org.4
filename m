Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECC65958E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 07:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiL3G7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 01:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiL3G7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 01:59:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974F6140D8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 22:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672383537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i6xNXZW5xcHpX8ctqGmuNcrSYwUwnLYg5NtdNPmfezg=;
        b=Iuj+Sh3UsyujM+7Jx8nm6hp8RFolqpvJ0KEPh6acHr/OsVyZsAYTV5DbBv641UeUgWzTEG
        xjsS7d+WESLIlLUPFLfdwy0DBcZotK8icE6nQ/cOVAZGS/VxuTxQzeCacjW2TpdN4A6eDc
        XQ9kqbTzOUmrCMlQ9Vrs4YAQCtxVuIU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-323-qI9O19EkPcOmJLpOHp_Bxg-1; Fri, 30 Dec 2022 01:58:56 -0500
X-MC-Unique: qI9O19EkPcOmJLpOHp_Bxg-1
Received: by mail-pf1-f200.google.com with SMTP id cp23-20020a056a00349700b005775c52dbceso10402279pfb.21
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 22:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6xNXZW5xcHpX8ctqGmuNcrSYwUwnLYg5NtdNPmfezg=;
        b=yCU7gsTU3wG0B0QZNFORzokFXmW4uquH1/pfcc5HuuKSPl34qatn+Ae4UvWzlYMAT/
         k35LddQAN0SsJWJJ+whIi2PAhWeY7OLELnmTMr8gRBBszsKOVQ+7PsU65qzQCz7g3h6y
         yFhlUKKnrnl6yk1ROBXLP1y4VAOOOYGKrYrevPvuCz1fjhnny8qVeCoEHKdI0Z9Mvl0P
         EcoaN9mS4Yt2Mvj7YMDxuoWxV6kXjN623/tCUFTFxSNiwN6PmWixGL5nSMPNmqxBvdb3
         UAfF7JZXWWhuIF9xtvTS2eDhL0EC6kJ/U2dYILTyTOTZVkQcfUv9KVBwdXBw28KDSOJt
         Oc4A==
X-Gm-Message-State: AFqh2krTdIYME/dNMzQdY+vO2pxIhigzWH8iaLGMgvOhACi4JTM2tL5E
        +Umumhq24OoEbFx9o9CgoxkDPwwZakiqMjpvuserzHp0kRFNbSbDK6FF2DhgeqBkQwnmpB7ILTx
        fupa8a1/+NPpKThDjAWRnsPZe
X-Received: by 2002:a05:6a20:1586:b0:9d:efc0:67 with SMTP id h6-20020a056a20158600b0009defc00067mr47397754pzj.15.1672383534929;
        Thu, 29 Dec 2022 22:58:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuS31o499EJ+P0QkGmvXR/8sEY71NzOuPxCXXw9OvVKvODqQywZozPkjeIXEo35ZNQmiVJihw==
X-Received: by 2002:a05:6a20:1586:b0:9d:efc0:67 with SMTP id h6-20020a056a20158600b0009defc00067mr47397736pzj.15.1672383534644;
        Thu, 29 Dec 2022 22:58:54 -0800 (PST)
Received: from localhost ([240e:478:10:2273:12cf:a540:d79b:db49])
        by smtp.gmail.com with ESMTPSA id s5-20020aa78bc5000000b00581e0b5ad8dsm1614157pfd.107.2022.12.29.22.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 22:58:54 -0800 (PST)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Matthew Garrett <mjg59@google.com>,
        James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] lockdown: kexec_file: prevent unsigned kernel image when KEXEC_SIG not enabled
Date:   Fri, 30 Dec 2022 14:58:49 +0800
Message-Id: <20221230065850.897967-1-coxu@redhat.com>
X-Mailer: git-send-email 2.38.1
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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
v3
 - add lockdown tests to explain why kexec_file_load failed [Mimi]

v2
 - collect reviewed-by tag from Mimi
 - s/mandate_signatute_verification/mandate_signature_verification [Mimi]
 - return the status of kexec_image_verify_sig correctly when signature
   verification is not mandated
---

 kernel/kexec_file.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index dd5983010b7b..2c1054ab21ef 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -125,6 +125,17 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->image_loader_data = NULL;
 }
 
+static bool mandate_signature_verification(void)
+{
+	/*
+	 * If IMA is guaranteed to appraise a signature on the kexec
+	 * image, permit it even if the kernel is otherwise locked
+	 * down.
+	 */
+	return !ima_appraise_signature(READING_KEXEC_IMAGE) &&
+	       security_locked_down(LOCKDOWN_KEXEC);
+}
+
 #ifdef CONFIG_KEXEC_SIG
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
@@ -168,13 +179,7 @@ kimage_validate_signature(struct kimage *image)
 			return ret;
 		}
 
-		/*
-		 * If IMA is guaranteed to appraise a signature on the kexec
-		 * image, permit it even if the kernel is otherwise locked
-		 * down.
-		 */
-		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
-		    security_locked_down(LOCKDOWN_KEXEC))
+		if (mandate_signature_verification())
 			return -EPERM;
 
 		pr_debug("kernel signature verification failed (%d).\n", ret);
@@ -211,10 +216,13 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 
 #ifdef CONFIG_KEXEC_SIG
 	ret = kimage_validate_signature(image);
-
+#else
+	if (mandate_signature_verification())
+		ret = -EPERM;
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

