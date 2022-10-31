Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BEC6132B6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJaJ3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJaJ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:29:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC32C74;
        Mon, 31 Oct 2022 02:29:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so7622326wmb.3;
        Mon, 31 Oct 2022 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMmXwX2kZtnLFA2mGASTAOPHlqknUPuxDlQJ9/B4KI8=;
        b=C9j5VF0dsTbD+JLT8ejZhxNJ2VoKSgpNNPcIfCl2vnV7DdWp2nZiCiP1z8hGuo1MGt
         lK5nlV88f30ryEE5zFSWSvhCWujEobt1fmnRcFeePjt/M7aP2SVYXeYyXAMZfPfUSAGT
         TyPSQcZcoda3c1f6mYWB5qM/6yuSnv6ObDN9G8ZS3pP4s3oUPLxIBKrxemqFblwOTz5f
         fIWyOI1SmUp4rEn1Yzmt3iohv8jhb3Au+AFS/W0fm8S4eA0o/V6FgemjfFvmhYAhVwgP
         +MNgrruqi2x8pHv49k8wfZTmGkgR2KsTBC+68fQEqpEyhjmilMd4iYGtQGCiB37fkSo9
         ghJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMmXwX2kZtnLFA2mGASTAOPHlqknUPuxDlQJ9/B4KI8=;
        b=jYLCnml/7GEH5gW0E1MuUIbqZLzj+gDM9j+MlGYfeKIT5YH2rTNsPJ5Zx3NB58tPhT
         iQU6zKRThG8roiuaeBnkYCwzlQIJRNnhdOpKoNBv+IEJe2bDQTQJ2Vwg+22gqgtQgm72
         +C3nNXLhLF38nYrKTU5QQv3r+wWEhXJ3WWpaEYzlO1NDzjQyGBvNdQDmHF4gaMocWT3v
         b1pyCI4gLrUP3tMKRSRIauzTEHJe1ASzbWpTm54R/YzS0FcjvJ4ae+N52mtpUqFgsMMJ
         Im0LRbY+7r0WnopBH9G5bUeAz0CD8B+FcOM6gjcNxiIaKVV1G2eLGaBVy5vSDk6iCZdX
         bcVw==
X-Gm-Message-State: ACrzQf3u2SqH9QxMZGwVhahdg/dqD9Vp26Kk43wh2EZqWUKngVU82OH1
        VfUba/ET/EAZ97HUAHsJxU0=
X-Google-Smtp-Source: AMsMyM5NXBeV83FylCy3VTrad1d5Lus1OQZ8qbxKFQB6vAVbGLMHp+Gbg8Fgf8Wdlpsn1BMiaCahoQ==
X-Received: by 2002:a05:600c:19ca:b0:3c6:ee5a:45fd with SMTP id u10-20020a05600c19ca00b003c6ee5a45fdmr7387764wmq.106.1667208564832;
        Mon, 31 Oct 2022 02:29:24 -0700 (PDT)
Received: from felia.fritz.box (200116b826c494005d8b6b3bdc900ff8.dip.versatel-1u1.de. [2001:16b8:26c4:9400:5d8b:6b3b:dc90:ff8])
        by smtp.gmail.com with ESMTPSA id e15-20020adfe7cf000000b0022cc0a2cbecsm6660833wrn.15.2022.10.31.02.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 02:29:24 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mm/slab_common: repair kernel-doc for __ksize()
Date:   Mon, 31 Oct 2022 10:29:20 +0100
Message-Id: <20221031092920.976-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 445d41d7a7c1 ("Merge branch 'slab/for-6.1/kmalloc_size_roundup' into
slab/for-next") resolved a conflict of two concurrent changes to __ksize().

However, it did not adjust the kernel-doc comment of __ksize(), while the
name of the argument to __ksize() was renamed.

Hence, ./scripts/ kernel-doc -none mm/slab_common.c warns about it.

Adjust the kernel-doc comment for __ksize() for make W=1 happiness.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 mm/slab_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 33b1886b06eb..74a991fd9d31 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1010,7 +1010,7 @@ EXPORT_SYMBOL(kfree);
 
 /**
  * __ksize -- Report full size of underlying allocation
- * @objp: pointer to the object
+ * @object: pointer to the object
  *
  * This should only be used internally to query the true size of allocations.
  * It is not meant to be a way to discover the usable size of an allocation
@@ -1018,7 +1018,7 @@ EXPORT_SYMBOL(kfree);
  * the originally requested allocation size may trigger KASAN, UBSAN_BOUNDS,
  * and/or FORTIFY_SOURCE.
  *
- * Return: size of the actual memory used by @objp in bytes
+ * Return: size of the actual memory used by @object in bytes
  */
 size_t __ksize(const void *object)
 {
-- 
2.17.1

