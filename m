Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED335B34D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiIIKKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiIIKKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:10:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8E19A6A7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:10:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f24so1348061plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Uu8/Y7CXXBHRNAqM/p4WezJYKvf+VwWvJUdWkJfyMKo=;
        b=KkyxGz1900lycU6F64B1E5AGOyGFi9NaUG/1QGhRXkEnya90K3ATDXi/QwnFauVwsh
         2kalkbOwpmu8FwpDQRx3Qk8hmPNSeqNL6bK1WokhhHqCvClPjW8AKgJY6i0uoucARmQj
         N+Dh1O+uvpEQ2R/kF8zluGF4JMnhUOxmMLNecZmPtST5aqgAt3R5LkWbnIAF4V3La7S0
         3PbkiXnblk7DP9oSmwfo8H+PHYfvr40kppotFzvKf7I4dIWYmMwht+8Zx/rTYJLQMcYS
         LnXGGJ9Ih3GXR9ZUBHNP19U/vlzzm4VZCSY0AkOCMw8NYPAHkQLN+dm/E5KfOiDsade2
         rKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Uu8/Y7CXXBHRNAqM/p4WezJYKvf+VwWvJUdWkJfyMKo=;
        b=EcCHQTFg1LAYPCar3fUtcStgC72kp5XyaQhng9ImaXC10Qop6cT7JJK9jJE+8yuRsR
         fFh1kjC1hm1Fh1rHV24dQvzJ7KidxAhCf4ZQZ54aUqVTysXbqbZPHZ8yGfDXX+XgJfxy
         j0jlAKkD8/qYB4AyMZI64CBYteFlIFwLnwlGfES6mJ3geUJaGZwmjrbob5hb4Yavakr9
         1gfxJOCxALqt5SXhypKat7/TqJI8RcXbAzmeqoYZV9aklZxVLaax4q8C1/3tf3vfTvW9
         wYfpEjaTcw1H3pXcE+qqBW8d9nb61jcXv5Gret6UOgemCXOtRSicbNcr9EUqvu66TMZn
         aDFg==
X-Gm-Message-State: ACgBeo0D9eEmgkIiiGO+eCK2RKVIXx9UWkaXPRF6JQ0uzJRhn9YIb/ah
        /vviu26ox58GzA6DLjM48EmOyofGyxk=
X-Google-Smtp-Source: AA6agR5GRcLHupA/O/ATwASHpZ3W7F7CXeIy2G8uy7pg2Jhd4zriysokpuJwLhFMn90IsyKSTmj/qA==
X-Received: by 2002:a17:90b:350b:b0:202:8495:6275 with SMTP id ls11-20020a17090b350b00b0020284956275mr4081802pjb.216.1662718230775;
        Fri, 09 Sep 2022 03:10:30 -0700 (PDT)
Received: from C02FG34WMD6R.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id o10-20020a62cd0a000000b00537d0207b30sm107469pfg.184.2022.09.09.03.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 03:10:30 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     hch@lst.de, axboe@kernel.dk, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] relay: use kvcalloc to alloc page array in relay_alloc_page_array
Date:   Fri,  9 Sep 2022 18:10:25 +0800
Message-Id: <20220909101025.82955-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kvcalloc is safer because it will check the integer overflows,
and using it will simple the logic of allocation size.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 kernel/relay.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 6a611e779e95..d7edc934c56d 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -60,10 +60,7 @@ static const struct vm_operations_struct relay_file_mmap_ops = {
  */
 static struct page **relay_alloc_page_array(unsigned int n_pages)
 {
-	const size_t pa_size = n_pages * sizeof(struct page *);
-	if (pa_size > PAGE_SIZE)
-		return vzalloc(pa_size);
-	return kzalloc(pa_size, GFP_KERNEL);
+	return kvcalloc(n_pages, sizeof(struct page *), GFP_KERNEL);
 }
 
 /*
-- 
2.20.1

