Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC536AE280
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjCGOcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCGOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:31:28 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DBD8C505;
        Tue,  7 Mar 2023 06:27:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C587C424CD;
        Tue,  7 Mar 2023 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678199237;
        bh=BAqN8OMTaXAhucXUriExOzQpMpPUhvwTh5OsDzrSkpo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=sdJUn/+TKQ7o8T8HGDCq3r2jd7AAtYK04d56jZmlkVNBzcSniG/yHCP6fDIbG9ehZ
         kSFIfPufTMbHtE461pYVmVq6FGQDfJAAWzZ+90gdyChquINRMvLM7Mg7xqF3pK2ikK
         qiAnhXlPguV04IZom9jBVBQYf/B2wNZqnpf4IeV4QUImr7ycS2rQu7K+yITkcDLmhI
         VqIH6ZmHfnCKkRScdcKV56rpQVzl1pvVoqyVKpWimedHzo3r7Xioq4dddbVh9q9+4x
         X/8VYqv9CrMVzNN3zky2OB830unrsw9d1jxOn5VWOFJIiSIKvp0HQl9KEC13yFGfV1
         vfcseqiRi4TEw==
From:   Asahi Lina <lina@asahilina.net>
Date:   Tue, 07 Mar 2023 23:25:30 +0900
Subject: [PATCH RFC 05/18] drm/gem-shmem: Export VM ops functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-rust-drm-v1-5-917ff5bc80a8@asahilina.net>
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
In-Reply-To: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678199191; l=2745;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=BAqN8OMTaXAhucXUriExOzQpMpPUhvwTh5OsDzrSkpo=;
 b=g9pqskVqJS3ljWoohfpCNH4NDQdA/LBauCNqtM+x0fz44GOfEY/N8GW4sqZzjgPhnydgE4j/x
 Si9bKq4ETQwDZpvyu6TbEWKU1rzJi6sGVUQQEwWgtVhiU5HoHMICe3I
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There doesn't seem to be a way for the Rust bindings to get a
compile-time constant reference to drm_gem_shmem_vm_ops, so we need to
duplicate that structure in Rust... this isn't nice...

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 9 ++++++---
 include/drm/drm_gem_shmem_helper.h     | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 75185a960fc4..10c09819410e 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -534,7 +534,7 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
 
-static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
+vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
@@ -563,8 +563,9 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(drm_gem_shmem_fault);
 
-static void drm_gem_shmem_vm_open(struct vm_area_struct *vma)
+void drm_gem_shmem_vm_open(struct vm_area_struct *vma)
 {
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
@@ -585,8 +586,9 @@ static void drm_gem_shmem_vm_open(struct vm_area_struct *vma)
 
 	drm_gem_vm_open(vma);
 }
+EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_open);
 
-static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
+void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
 {
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
@@ -594,6 +596,7 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
 	drm_gem_shmem_put_pages(shmem);
 	drm_gem_vm_close(vma);
 }
+EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_close);
 
 const struct vm_operations_struct drm_gem_shmem_vm_ops = {
 	.fault = drm_gem_shmem_fault,
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index a2201b2488c5..b9f349b3ed76 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -138,6 +138,9 @@ void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 			      struct drm_printer *p, unsigned int indent);
 
 extern const struct vm_operations_struct drm_gem_shmem_vm_ops;
+vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf);
+void drm_gem_shmem_vm_open(struct vm_area_struct *vma);
+void drm_gem_shmem_vm_close(struct vm_area_struct *vma);
 
 /*
  * GEM object functions

-- 
2.35.1

