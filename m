Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E05D6986D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjBOVCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjBOVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:01:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A214743D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676494691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VA3IhoymnkRNZGYwmqaugl8AyufVG6VWORGx5RUpBQ4=;
        b=R+K4PIC5Ti12tGpgwLI5+k5Bqy7Nlg8NuNkr2/VP6s++vG/oy2zoe6jXS3JrxEbk1YPTGK
        xT3Ty8Yvg5mWo8bXFCEzCX3OBClAF+7Gd9QcDI5P0O+u6FSxAAgh5+m5KHyaPvirtTRy/C
        fnd0GiMCIz/4ZKYaP7qqxd7lGht+hYY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-361-6fd1YEpCOK-ODr6ed88X1A-1; Wed, 15 Feb 2023 15:58:05 -0500
X-MC-Unique: 6fd1YEpCOK-ODr6ed88X1A-1
Received: by mail-il1-f199.google.com with SMTP id o1-20020a92c041000000b0031559e98af9so101019ilf.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676494683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VA3IhoymnkRNZGYwmqaugl8AyufVG6VWORGx5RUpBQ4=;
        b=wl9UJnodWHzO2k+JeFuoEiTzld08dvpdNNt3iKLpY/wQxexU+xlDanSf4eZGUpt31c
         QYdwP8dMhqJWDkklfJ85+IcKDdbRSTMgRXb9NQcNUASBMCChsgQsilnQoxhS0b2Qjvuq
         ed2BtEomtDY8uUksqPHRw1bFVV30O00JEB4SMPsGgiovIEu1IK3SfXTusqWDJkPrGFCm
         7ZrcY0v/xW/OuOh+cJ37RZ1wGNb4bGKRZ5NkoAZGGWNM3JM6ISqVrLYwJx34cqNzbZVe
         mUi89tPhJaxQ3lv68ESzFPd5onP+RoXaq3ZlwTKL57GaRb1975Q7+oO4YKN4sDSJmj/j
         1Uhw==
X-Gm-Message-State: AO0yUKXK9MLM8Ys8am7noTCrck9iv1XfZkfZLYjRYIPefJ/smSpph/9W
        HB56mYDjzERpiNAD9iWaCLgkZKEGroGBTQey6cnVn+0a0B9+eZqM3NQzAhytJaXHnm9lM21NiXJ
        HK1MQcGed/306zJJpntQvx/0sBosmknfPeNllTZojbhkwnNO+JWbNbtpY4I5bUkpl2l7+7O1RBa
        GRzCY=
X-Received: by 2002:a05:6602:17ce:b0:73a:397b:e311 with SMTP id z14-20020a05660217ce00b0073a397be311mr2559568iox.0.1676494683336;
        Wed, 15 Feb 2023 12:58:03 -0800 (PST)
X-Google-Smtp-Source: AK7set+Qmg+H5DVGksjKPw0AwrFzwBVOBTnDY5b+saqXAO/8ynNHS9nDddP7dC9o6FbUZrMgcmx51g==
X-Received: by 2002:a05:6602:17ce:b0:73a:397b:e311 with SMTP id z14-20020a05660217ce00b0073a397be311mr2559550iox.0.1676494682997;
        Wed, 15 Feb 2023 12:58:02 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id y74-20020a6bc84d000000b0073fd8ca79c6sm2686264iof.9.2023.02.15.12.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 12:58:02 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH] mm/uffd: Fix comment in handling pte markers
Date:   Wed, 15 Feb 2023 15:58:00 -0500
Message-Id: <20230215205800.223549-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
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

The comment is obsolete after f369b07c8614 ("mm/uffd: reset write
protection when unregister with wp-mode", 2022-08-20).  Remove it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7a04a1130ec1..f456f3b5049c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3627,9 +3627,7 @@ static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
 {
 	/*
 	 * Just in case there're leftover special ptes even after the region
-	 * got unregistered - we can simply clear them.  We can also do that
-	 * proactively when e.g. when we do UFFDIO_UNREGISTER upon some uffd-wp
-	 * ranges, but it should be more efficient to be done lazily here.
+	 * got unregistered - we can simply clear them.
 	 */
 	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
 		return pte_marker_clear(vmf);
-- 
2.39.1

