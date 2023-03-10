Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCAB6B4E4E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjCJRQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCJRQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:16:45 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA782F28A8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:16:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso6600636wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678468579;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAR+tMsmaLBFht+LOOo6dlI0N6MA2He87h1FBYd556U=;
        b=GgkXGPRYJD1/1urxX2uFNloozieprwnGBXW20LtiPUWOPXlneOPVOP8cgbBUJjU+HW
         OJA+rvAJJTc3m53enR+tP+rPGkhxOITNNeKC8+rL74m+7HwUwKHgkHS5CklSp5/e4l8b
         xc7OjOmOZGUlLWpofLetfpEQbBhjJ0RcVCbNwVKhZMnuvrQ9nGq6FxARxOb5543igWwm
         Um7sGDsQveroqRyU7Rcj1w/75Oz6hywGtoXX0S4x1RTkcY6z4XVtv7jxxeF2bqI71AyV
         9IZrjfQy4u4OGNNpNqASHy/GjP04vsWF6K4vBEnADj6JgtdNlytnunoQLnMsLBBULlAo
         Hwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678468579;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAR+tMsmaLBFht+LOOo6dlI0N6MA2He87h1FBYd556U=;
        b=cgLbTxaDh6wisfBXWxd1nHerA4isQa9Jj9PB81y8NsYfHRM+fJb2/VCOKbN5ttKo9G
         PnU7sL1R9ui3nF0m2h5j2PzjhUgi56G7efiHkPaUmrO3zB164/PJSfzJ0MOQyKwtyRi+
         5hxo+HxwQwClQjh4M8Cp1eIJmbwDMqaDBfgjV1s86ndEB96uORcmlAQ/UpoPdJZ5fEIH
         daL0iWFKscj7hmmYexmth6l6MTqK/6mvGkbTkq3o45RB5cYiWvDFxc8AjNlcZ0cIJ7uX
         Ik4HD7GF0EmzgnIhrSkeCMPiGxitKterC4+BuPNIwdxnLShHDk/Rl3ajTh0iviyECrZz
         GPSQ==
X-Gm-Message-State: AO0yUKXG7sZgWzcMrXzHfvKfaZ537rIsMN/CMSmhcOjSKOgvh2F/K7jB
        8+pT+oNCCCae5lzIRg7R0yGD/3+gozYAtA==
X-Google-Smtp-Source: AK7set/lS3wOFh5G2z0zqZSDgneiAy5uHUpEj6yjIO9vtmogf89N2COYP70UlHfslHyih10vrE94eg==
X-Received: by 2002:a05:600c:35c1:b0:3df:deb5:6ff5 with SMTP id r1-20020a05600c35c100b003dfdeb56ff5mr3633557wmq.24.1678468579241;
        Fri, 10 Mar 2023 09:16:19 -0800 (PST)
Received: from archlinux (p200300e7370bbe5f73e3aef84e627e25.dip0.t-ipconnect.de. [2003:e7:370b:be5f:73e3:aef8:4e62:7e25])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c290100b003e89e3284fasm414421wmd.36.2023.03.10.09.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:16:18 -0800 (PST)
Date:   Fri, 10 Mar 2023 18:16:17 +0100
From:   Nils Hartmann <nils1hartmann@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Using MAP_SHARE_VALIDATE in mmap without fd
Message-ID: <20230310171617.wqnqs42l2viwjsz5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
I have a rather simple question about the MAP_SHARED_VALIDATE flag in mmap.
When used without a file pointer, EINVAL is returned. Is there a reason for this?
I researched a bit but could not find anything. I attached a simple patch that adds MAP_SHARE_VALIDATE to the flags switch and checks for invalid flags.

Signed-off-by: Nils Hartmann <nils1hartmann@gmail.com>
---
 mm/mmap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 740b54be3..fd7db51af 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1196,6 +1196,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	vm_flags_t vm_flags;
+	unsigned long flags_mask;
 	int pkey = 0;
 
 	validate_mm(mm);
@@ -1266,14 +1267,14 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (mlock_future_check(mm, vm_flags, len))
 		return -EAGAIN;
 
+	flags_mask = LEGACY_MAP_MASK;
 	if (file) {
 		struct inode *inode = file_inode(file);
-		unsigned long flags_mask;
 
 		if (!file_mmap_ok(file, inode, pgoff, len))
 			return -EOVERFLOW;
 
-		flags_mask = LEGACY_MAP_MASK | file->f_op->mmap_supported_flags;
+		flags_mask |= file->f_op->mmap_supported_flags;
 
 		switch (flags & MAP_TYPE) {
 		case MAP_SHARED:
@@ -1327,6 +1328,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		}
 	} else {
 		switch (flags & MAP_TYPE) {
+		case MAP_SHARED_VALIDATE:
+			if (flags & ~flags_mask)
+				return -EOPNOTSUPP;
+			fallthrough;
 		case MAP_SHARED:
 			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
 				return -EINVAL;
-- 
2.39.2

