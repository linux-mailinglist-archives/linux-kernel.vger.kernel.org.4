Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB1A6C8640
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjCXTy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjCXTy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAD31BDA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679687651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l3XY7P7qXKaSPDLbgUFV6/pwM2nIqWoTRMEvcOe7JBo=;
        b=M/wdW+03cwUeiV4wPqoVrZ+e3b/eqHkxDgBK+zCMXUoEN4ntAv9zp/gEEE3izD1XealyXT
        kiIGaooW7e77pncfs0KaBD86tN7To42ryqzTN2FFkzLPWQAgU9N8zw4R/G35vIMp6uCfPm
        TlS67+fOU/P5+Z6uQkLqJVQsKIgwABc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-ewVED8lRMVio4RWK7yYdKg-1; Fri, 24 Mar 2023 15:54:09 -0400
X-MC-Unique: ewVED8lRMVio4RWK7yYdKg-1
Received: by mail-qv1-f70.google.com with SMTP id c15-20020a056214070f00b005bb308e7c12so1508503qvz.19
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679687649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3XY7P7qXKaSPDLbgUFV6/pwM2nIqWoTRMEvcOe7JBo=;
        b=xafp2oQjgTJCI3mZcowXTWRvZFWgL+qhNqabwkJU/NkHUuNETi1SN1NyjoyT2OGj2j
         6xdfHdZJ9ghPQNtAWGS+oMSZ+DOohm+4R6s26WnrkOfxnVEJK6ae8eqQHFWAt32QYkcC
         rPVx62n8tKz7myZ68BMJOMhCWaFj5HKntQZa2B1PxuZEtvpkXf9t6WF5DyyzMK3hc/MD
         Rxad2nuFcK/HQnpCI3XmFBumSYaGz2FjH7GuyM96xjMpRZ/weOkx+eXK6msCnzTky1/i
         VAhj/oeJ+JhUmn+STIXtJkFSvYW+Iw/7Hd99H5oXoVsOI1JylkcUWwQQkO+38C5mjzsu
         LIww==
X-Gm-Message-State: AAQBX9fkYMiQJFsXCSZPdIEPtuS7eG3PyK+xmG5lsqnWSfq9HJvXBxkq
        rUJYvLkg40DqUs+7FiVi7SRa9o9SpZQVihgIfAxlNRYKQ1NGQ82gzpbQoKX/oTjYiACkI0vdGfq
        1arxiu2kVB7PEfcfhabILOLNMOeeyrKGR
X-Received: by 2002:a05:6214:2aad:b0:56e:9317:eb9a with SMTP id js13-20020a0562142aad00b0056e9317eb9amr6592658qvb.29.1679687649093;
        Fri, 24 Mar 2023 12:54:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y3suJMoeD22pwLpecdSYpxhvSJ69sCrGTjVBJLxJGFJIxRx3Oe7uCHkoJj7IPUAMd1rm5fxw==
X-Received: by 2002:a05:6214:2aad:b0:56e:9317:eb9a with SMTP id js13-20020a0562142aad00b0056e9317eb9amr6592635qvb.29.1679687648834;
        Fri, 24 Mar 2023 12:54:08 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j185-20020a37b9c2000000b007465ad44891sm13466083qkf.102.2023.03.24.12.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 12:54:08 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/vmwgfx: remove unused mksstat_init_record function
Date:   Fri, 24 Mar 2023 15:54:03 -0400
Message-Id: <20230324195403.2655148-1-trix@redhat.com>
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
drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:716:21: error: unused function
  'mksstat_init_record' [-Werror,-Wunused-function]
static inline char *mksstat_init_record(mksstat_kern_stats_t stat_idx,
                    ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index e76976a95a1e..ca1a3fe44fa5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -702,32 +702,6 @@ static inline void hypervisor_ppn_remove(PPN64 pfn)
 /* Header to the text description of mksGuestStat instance descriptor */
 #define MKSSTAT_KERNEL_DESCRIPTION "vmwgfx"
 
-/**
- * mksstat_init_record: Initializes an MKSGuestStatCounter-based record
- * for the respective mksGuestStat index.
- *
- * @stat_idx: Index of the MKSGuestStatCounter-based mksGuestStat record.
- * @pstat: Pointer to array of MKSGuestStatCounterTime.
- * @pinfo: Pointer to array of MKSGuestStatInfoEntry.
- * @pstrs: Pointer to current end of the name/description sequence.
- * Return: Pointer to the new end of the names/description sequence.
- */
-
-static inline char *mksstat_init_record(mksstat_kern_stats_t stat_idx,
-	MKSGuestStatCounterTime *pstat, MKSGuestStatInfoEntry *pinfo, char *pstrs)
-{
-	char *const pstrd = pstrs + strlen(mksstat_kern_name_desc[stat_idx][0]) + 1;
-	strcpy(pstrs, mksstat_kern_name_desc[stat_idx][0]);
-	strcpy(pstrd, mksstat_kern_name_desc[stat_idx][1]);
-
-	pinfo[stat_idx].name.s = pstrs;
-	pinfo[stat_idx].description.s = pstrd;
-	pinfo[stat_idx].flags = MKS_GUEST_STAT_FLAG_NONE;
-	pinfo[stat_idx].stat.counter = (MKSGuestStatCounter *)&pstat[stat_idx];
-
-	return pstrd + strlen(mksstat_kern_name_desc[stat_idx][1]) + 1;
-}
-
 /**
  * mksstat_init_record_time: Initializes an MKSGuestStatCounterTime-based record
  * for the respective mksGuestStat index.
-- 
2.27.0

