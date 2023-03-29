Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6902D6CF6C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjC2XPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2XPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC43596
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680131654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RDa5o+kZyCZFoDwvixD+yMC8DGY8pjS5wLyVr2om2qE=;
        b=hshW0keDAhAaXayV6NI88ssrjo0Vez0mgIXhMusnMF0hDfkp4iNOKl+DNePWaotbTbD97E
        BCNvTs7xXa/LrmwvFK6oDfFV56h/pLnf8PZmzxBsiImSz/GjpyqSARVf8omgw2iHOt5x17
        HIYFCxgIeF3JPB8IdFfUGa50C27fBCk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-JxTlfr55MAyL1UdCIIrung-1; Wed, 29 Mar 2023 19:14:13 -0400
X-MC-Unique: JxTlfr55MAyL1UdCIIrung-1
Received: by mail-qv1-f69.google.com with SMTP id dl18-20020ad44e12000000b005a4d5420bc6so7375280qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680131652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDa5o+kZyCZFoDwvixD+yMC8DGY8pjS5wLyVr2om2qE=;
        b=s8tBlAPAUNYKNXrpPppxoI2VzGe1aUub0ZIBMlvmeWibSUjBnV9wKnHLT2/kRUJ8E+
         cdQO4+LtffOdTREc9D4FNVzd3ij7bJ3xxhnVrphnvNnzJOJDJSTmXTRH+NCCqrPkQGOO
         Rsh+/ZL9eMlB8Q/HU8V8QYkD3UkrlB7ZCvn40XvVllHSxtZmaoWGZR7tmY9GID0gXAV7
         Bf3uNpjT5/2AehUHjzW7o9CdDr3eBuzJDxYkAfAjKxRX6B4BRKzQRkfCijLovVe5Hhqx
         nLY4wPUgo8LN8rXhUSo7yu2i5QCioJ3Znm18UOhyil64WkjF4yfPDJ6A95ve8F2KJt2Q
         fJ/g==
X-Gm-Message-State: AO0yUKXhwA0PB/0v9bTKNpSBO+W+8Jj/siFKKAGNtwb+K1QYYn+UpsSC
        YgHyNIb12elw8gX+fVKjTJP4YaRf39f61ZXMlWmC6El7rh1+BvmluUVEVARHW23r4FgWNL576vO
        BmuxkYAowV+6dVjDboE9KsijN
X-Received: by 2002:a05:622a:53:b0:3bf:c3e8:c19b with SMTP id y19-20020a05622a005300b003bfc3e8c19bmr39717914qtw.22.1680131652538;
        Wed, 29 Mar 2023 16:14:12 -0700 (PDT)
X-Google-Smtp-Source: AK7set9FAlt8CkZ7gP0dtRURdKafeSyXrPgA0ctSwHl2YRdMc9jHIn4kx1HtMkkz0/D/w1j49owN7A==
X-Received: by 2002:a05:622a:53:b0:3bf:c3e8:c19b with SMTP id y19-20020a05622a005300b003bfc3e8c19bmr39717885qtw.22.1680131652329;
        Wed, 29 Mar 2023 16:14:12 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x16-20020ae9e910000000b007435a646354sm12246105qkf.0.2023.03.29.16.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 16:14:12 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/svm: remove unused ret variable
Date:   Wed, 29 Mar 2023 19:14:07 -0400
Message-Id: <20230329231407.1816570-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/gpu/drm/nouveau/nouveau_svm.c:929:6: error: variable
  'ret' set but not used [-Werror,-Wunused-but-set-variable]
        int ret;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index a74ba8d84ba7..e072d610f2f9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -926,15 +926,14 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
 		 unsigned long addr, u64 *pfns, unsigned long npages)
 {
 	struct nouveau_pfnmap_args *args = nouveau_pfns_to_args(pfns);
-	int ret;
 
 	args->p.addr = addr;
 	args->p.size = npages << PAGE_SHIFT;
 
 	mutex_lock(&svmm->mutex);
 
-	ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args,
-				struct_size(args, p.phys, npages), NULL);
+	nvif_object_ioctl(&svmm->vmm->vmm.object, args,
+			  struct_size(args, p.phys, npages), NULL);
 
 	mutex_unlock(&svmm->mutex);
 }
-- 
2.27.0

