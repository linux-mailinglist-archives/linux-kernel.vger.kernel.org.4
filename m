Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C86562CF6C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiKQAUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiKQAUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:20:31 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B264730C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:20:30 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p141so241722iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYrGcKZ90fvfsXSmxF4aK7/kvJ4eaidpI88a5ZAW7vs=;
        b=qwy/1FEzGt4fj7T2IyliiuYzYT/y/jniUSkgNGUXxB9xhsBPLzotbdGrENzUTLXf7x
         RJB4utHxjzAr5t2Rhp/XzN40Wf6TNKfz7HOtk2Izc5Xr4E6WyBH1fxO1CB9tCh2Xkf/n
         t7m1fDRkQOpeebwotn03PTV9Ei1Jzy4mTfZCrMH00SjR0xUTLa1JxKkeXhrhvq80mMBU
         AQaSXgSH8GP9Hq/vYdmBmd8o1GRPyVKM09TKTCkKXI9vBV2OwEov/Izuzlb+EXQI1968
         JYfbC3rz54rYvb4EOSJS/YltrSYcpk+oziYnuHfVGUN8Et8HWOYom7TTsKRnKbd41Hvv
         yF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYrGcKZ90fvfsXSmxF4aK7/kvJ4eaidpI88a5ZAW7vs=;
        b=xcTY2aT3rTRObLlK3GqiWAbjifUxsRROnv64zMhkOr7/RI2m0waa1Pyw2rIyIjiLwE
         3IXx2/VrFEyFCrbu63vapq6rKxStra4zYUzpkJVVdwZzfDecDYnOPE3BdwHRLbvZpUZV
         q4nh7bAmKL+lYlgbduk4CgkpJ04wzH6372/WwRali+I7Q0Je6usUsNpyR9owIsfMu/87
         68UBOFqIdpFPF6lP+dFRfGZeZi7M+7B1V7cpn5ieBntoAOTMvqto1kwQ6MWWtxGmGz7G
         lCcUCWXrV2EU5lZLK1noHsFhiKPbMS5vsdEYubGQBGHDfZZf5uPQi5mxpSl8VmLDfELe
         A/ZA==
X-Gm-Message-State: ANoB5pk/ofsQmQqPr53v+Njr4oYjwTi0k/1gF8s2immlpQti+UVjxGA7
        tM7cuNuUlZz/VN6IBD/bnPI=
X-Google-Smtp-Source: AA0mqf7MkLdT3LDwVcU3vntvtiB3i8aOtNLifHD9++d93Q3Rokww5EVhJt/szI4+iKX0rypCOnnICg==
X-Received: by 2002:a05:6602:4190:b0:6a4:9ae9:1303 with SMTP id bx16-20020a056602419000b006a49ae91303mr353818iob.43.1668644429402;
        Wed, 16 Nov 2022 16:20:29 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o194-20020a0222cb000000b0037556012c63sm6119777jao.132.2022.11.16.16.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 16:20:29 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/2] vmlinux.lds.h: fix BOUNDED_SECTION_(PRE|POST)_LABEL macros
Date:   Wed, 16 Nov 2022 17:20:21 -0700
Message-Id: <20221117002022.860237-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117002022.860237-1-jim.cromie@gmail.com>
References: <Y20+PqtF+dFAe7hX@kroah.com>
 <20221117002022.860237-1-jim.cromie@gmail.com>
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

commit foo added BOUNDED_SECTION_(PRE|POST)_LABEL macros,
encapsulating the basic boilerplate to: KEEP/pack records into a
section, and to mark the begin and end of the section with
linker-symbols.

But it tried to do extra, adding KEEP(*(.gnu.linkonce.##_sec_)) to
optionally reserve a header record in front of the data.  It wrongly
placed the KEEP after the linker-symbol starting the section,
so if a header was added, it would wind up in the data.

Putting the KEEP in the "correct" place proved brittle, and too clever
by half.  The obvious safe fix is to remove the KEEP, and provide
separate macros to do the extra work.

While here, the macro var-names: _s_, _e_ are nearly invisible, change
them to more obvious names: _BEGIN_, _END_

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 50851425b229..85d5d5b203dc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -199,17 +199,15 @@
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

