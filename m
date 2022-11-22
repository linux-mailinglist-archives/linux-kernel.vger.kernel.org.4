Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A32633359
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiKVCbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiKVCa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:30:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88D260E8D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669084141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEmhWIzG88GfbOvn0VVAGamAN6Tv4nOnLrUclwx8MGE=;
        b=OHC9PaYudkAynYpW8QquTpVaUi/9SzydteqDhz7JSQgI+JGYMDhLDUpleccDSpYddR0m+l
        jtk5skpsmj84hffxTLxxiH990Es+QhGHAOwoZMF7JY7L/QEHxeB/FjMM+3WYDAkmoHtzdB
        SzcXrJILZbcd2rBj2DPTScj8bsETCt8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-i2nL5zGlOQSkJ1MWN8t-Dg-1; Mon, 21 Nov 2022 21:29:00 -0500
X-MC-Unique: i2nL5zGlOQSkJ1MWN8t-Dg-1
Received: by mail-pl1-f200.google.com with SMTP id i8-20020a170902c94800b0018712ccd6bbso10543381pla.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEmhWIzG88GfbOvn0VVAGamAN6Tv4nOnLrUclwx8MGE=;
        b=Z0zhsBydDWju1myYvVmq4H5+MwA+jYZnnKd3Z83T5/rJJOxDIgix6VlOL9/XTZv6FW
         APW0Q5r5KTrc14U4kd75u1Ma/1RGNjuzxP8/jQFAeMa4X7PwKwBimyzWf7byvQOmjAy3
         EOClm2orph8VBqGFqYDbBGxjC0YfeJ1n4pKpLkwZmkxjufyayNGDKNhvv02c00/6/9i5
         jiYYGjt4qGgVYKKSpgCSBQWYNwyBM+rDmUMp2WbEoh+G52lmFnQhmxvwUnAJuehu+VGT
         Cy9UQQ6GJLqgGFuw0HTY86yB4ZtdkF1DCb6jEZCXHlQGz5aZUS9rldycZk+NfQmqAmG0
         lJYA==
X-Gm-Message-State: ANoB5plCm1GeNr5fb+tfq0gD03eTOFHAWBZfqyheTsc0jZu5G4LWiHjo
        TsO5gs8Dx9/FTe52qVioVyUcd9yc1LvlBGDhJ6qFc4Q9lqiNSPy48oxiBuPQjxYKucsi0nwqbg/
        SQOukK1y7/GsRucI87z3pQbjO
X-Received: by 2002:a17:90a:5918:b0:213:ff:1cda with SMTP id k24-20020a17090a591800b0021300ff1cdamr22749676pji.86.1669084139319;
        Mon, 21 Nov 2022 18:28:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf64JiXXabiXu4vcDpmIq38bPW0Ra2Qsb9SUEESTKt8MF2CRsg61tFBxLECGkJJFsOUhhUh8Dw==
X-Received: by 2002:a17:90a:5918:b0:213:ff:1cda with SMTP id k24-20020a17090a591800b0021300ff1cdamr22749644pji.86.1669084138958;
        Mon, 21 Nov 2022 18:28:58 -0800 (PST)
Received: from localhost ([240e:3a1:2e3:6280:f5b8:e7c9:62bf:459])
        by smtp.gmail.com with ESMTPSA id a27-20020aa794bb000000b0056e8eb09d57sm9393859pfl.63.2022.11.21.18.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 18:28:58 -0800 (PST)
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
Subject: [PATCH v2] lockdown: kexec_file: prevent unsigned kernel image when KEXEC_SIG not enabled
Date:   Tue, 22 Nov 2022 10:28:55 +0800
Message-Id: <20221122022855.888910-1-coxu@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121072947.836672-1-coxu@redhat.com>
References: <20221121072947.836672-1-coxu@redhat.com>
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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
v2
 - collect reviewed-by tag from Mimi
 - s/mandate_signatute_verification/mandate_signature_verification [Mimi]
 - return the status of kexec_image_verify_sig correctly when signature
   verification is not mandated
---
 kernel/kexec_file.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..dcde7a50fbeb 100644
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

