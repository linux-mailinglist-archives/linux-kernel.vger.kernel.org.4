Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32D362E2B7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbiKQRQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbiKQRQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:16:44 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B84786C0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:16:43 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id p184so1844066iof.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g45vmLNr3T8L9tQdS63erVOB1IUABPfK3xYft3/SwQE=;
        b=eOQWrIYB2qxOjWkWNg310qcA4ou1hMsC9SKlnBGThNkTh8lQssJpdFuCNfkbcmMZZ2
         TIP3gIme50FkzhTk0v3dumgy8sLrk5rVxJXtkC05iK93vLp8eMaJQZA7QpEzURHF2Y0l
         5dqts3tfrh1kcD8TStlC64TvLsUOv5awaK3pMwtZHLKIel8xGt4lL0EcDeBkc9zbFC59
         ZGc+77M3IGvV/hwwzC1ZhsuHgF0cuwRANOI+9CHSjCbfdHmRdCIXNMS4LfxvcvNHT2c8
         yG49CFG6P5fTPqgOTBMmB6VrO96XMC9CvmJH8jwNhni3POc8j/g3ICRvY+7EyvUq4e89
         QLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g45vmLNr3T8L9tQdS63erVOB1IUABPfK3xYft3/SwQE=;
        b=uQtlwn97+CnAxI8dcb4go83Jka43zESElPInsUq/EMF0tREGOPt/Npgzd85eNGqK4v
         MaoW+yRuxzFwPpB1wS13XhA9esKCkA/24zaczjF1c+7VYsrt9a94cmBSFbOwSCrgoneE
         WpcgsiaDRpuGcK6mKiB2SyIpgRZVOK9V0DR1ESdKpmnT6GMOFguR2+2D/DjsB4PFqYGn
         4znBSDYNIPBPNtF9m2YMOH6m5Ulrn9h3tKtUrVcrWjxHPhV7NX3ibSYT5LMiRY7ujYHm
         QG1d4ZdT//8d5Xeh4WglbXwV/oyM9eihrSfU++jMPh0P3Ii2ZRTSAYLe25Xi7u7D7oSP
         b2hg==
X-Gm-Message-State: ANoB5pmG62p9cDN2VDVt75oak5YhlBhiSzNzsN4PA3cqe0tLQVxcrWcm
        nZtqZ5/fC2hfpmsj9s5Rf5desUkA/M+7tQ==
X-Google-Smtp-Source: AA0mqf5t/+A2cQoGLBvqicfEHQc7SInv4gaHfBCVsrg6/nOSD+mKGgmkLucGoZzDbs389iXcDDAlYQ==
X-Received: by 2002:a02:ccaf:0:b0:372:4b69:fe1f with SMTP id t15-20020a02ccaf000000b003724b69fe1fmr1440398jap.109.1668705402274;
        Thu, 17 Nov 2022 09:16:42 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o1-20020a92d381000000b002faf6559e90sm495322ilo.51.2022.11.17.09.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:16:41 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/2] vmlinux.lds.h: fix BOUNDED_SECTION_(PRE|POST)_LABEL macros
Date:   Thu, 17 Nov 2022 10:16:32 -0700
Message-Id: <20221117171633.923628-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117171633.923628-1-jim.cromie@gmail.com>
References: <Y3XU59mj80wvTD6Y@kroah.com>
 <20221117171633.923628-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2f465b921bb8 ("vmlinux.lds.h: place optional header space in BOUNDED_SECTION")

added BOUNDED_SECTION_(PRE|POST)_LABEL macros, encapsulating the basic
boilerplate to KEEP/pack records into a section, and to mark the begin
and end of the section with linker-symbols.

But it tried to do extra, adding KEEP(*(.gnu.linkonce.##_sec_)) to
optionally reserve a header record in front of the data.  It wrongly
placed the KEEP after the linker-symbol starting the section,
so if a header was added, it would wind up in the data.

Moving the KEEP to the "correct" place proved brittle, and too clever
by half.  The obvious safe fix is to remove the KEEP and restore the
plain old boilerplate.  The header can be added later, with separate
macros.

Also, the macro var-names: _s_, _e_ are nearly invisible, change them
to more obvious names: _BEGIN_, _END_

Fixes: 2f465b921bb8 ("vmlinux.lds.h: place optional header space in BOUNDED_SECTION")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b3ca56ac163f..c17f94785253 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -193,17 +193,15 @@
 # endif
 #endif
 
-#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _s_, _e_)		\
-	_s_##_label_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
+#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	_BEGIN_##_label_ = .;						\
 	KEEP(*(_sec_))							\
-	_e_##_label_ = .;
+	_END_##_label_ = .;
 
-#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _s_, _e_)		\
-	_label_##_s_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
+#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	_label_##_BEGIN_ = .;						\
 	KEEP(*(_sec_))							\
-	_label_##_e_ = .;
+	_label_##_END_ = .;
 
 #define BOUNDED_SECTION_BY(_sec_, _label_)				\
 	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-- 
2.38.1

