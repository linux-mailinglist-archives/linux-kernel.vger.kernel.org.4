Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0908D6512C5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiLSTTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiLSTTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:05 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9721912AD0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:04 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id z19-20020a921a53000000b0030b90211df1so3338470ill.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eqmNATfXsr4DizCCpcth0y0vfLVrabd2UB2TT6EQhwI=;
        b=nRXB21sdSHLfWpo7N4XIXagu8tN6MLNzEf/XK5MEcty8CuPQL5YMnsqfai5Q+IbdIF
         14DWDkSr96sCp8k/zeJi6r+/dxB35qGUcm/v4Imy4LtNfr1hENCjQfCdPqCCXcw1NOpf
         X5brWGCUwXzedJ4uBBYdErJSmBmo9bZ+VhN4ropseS0jooJkefrkjJCxLUyqEg4yrqwA
         2JbTOWGNMctd6cY471HxpoKlkDPq/qR70l7yRpzMa443BWcv5Z/L3CP/YeVU+uugx6+O
         8OYloy1b30G4FeiksfDhGmD3kXgh7vcE1sRJe4lOtLajRMKuDx9f2PisIfIiQAmzA7uY
         UjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqmNATfXsr4DizCCpcth0y0vfLVrabd2UB2TT6EQhwI=;
        b=Ux0U/PcPm2Js44n26gzHkydUVt4fIgZPkBpt/GRIa9Q0FdIjHjbSC18c4ZRgM/ybbg
         rKp57w7/hpmip3RDJB0dHmAKDx4wl4O02O+klVwDvHWH7beZnRFac2/0TcrpT6zjcoqi
         PLKp7wZl6pCFUPdcj+GK4Z8HASDe4m+i943ZLkKfUD0kpREVkRdRuXheJS33LX2KtWGP
         TNmmuUJMhZtD5UhVu8M4FUdtZZI24KnI6wanbc9ppRW/ZcAVQoZjR7vnXMU5ZbvcJiwY
         peigGXwp7bfzdz0Ah6tQx45S2GE2wOZtIepJhx5L9YCI8H89v1n3nb4kDHY2Q/s2m2Vs
         wFsg==
X-Gm-Message-State: ANoB5pmBK5WZxUbIgFYKmGBuzw+CyhX7mPIrSDzGcTm0phDy9pUgG03r
        y9XHauRr+3riLyRJQtDp41mRTFV+ZJfHask=
X-Google-Smtp-Source: AA0mqf6/69oC+XVcb8sc3AmTmcabYuhNR/zI/qvKBjqLFxGT52ZtwxDb0ia9EL4d7otrnLTHTSp8eFpx2JtnIhc=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6e02:1d84:b0:302:ce48:40ee with SMTP
 id h4-20020a056e021d8400b00302ce4840eemr35088599ila.157.1671477543996; Mon,
 19 Dec 2022 11:19:03 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:51 -0600
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-6-allenwebb@google.com>
Subject: [PATCH v8 5/9] module.h: MODULE_DEVICE_TABLE for built-in modules
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement MODULE_DEVICE_TABLE for build-in modules to make it possible
to generate a builtin.alias file to complement modules.alias.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 include/linux/module.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index ec61fb53979a9..3d1b04ca63505 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -243,7 +243,20 @@ extern void cleanup_module(void);
 extern typeof(name) __mod_##type##__##name##_device_table		\
   __attribute__ ((unused, alias(__stringify(name))))
 #else  /* !MODULE */
-#define MODULE_DEVICE_TABLE(type, name)
+/*
+ * The names may not be unique for built-in modules, so include the module name
+ * to guarantee uniqueness.
+ *
+ * Note that extern is needed because modpost reads these symbols to generate
+ * modalias entries for each match id in each device table. They are not used
+ * at runtime.
+ */
+#define MODULE_DEVICE_TABLE(type, name)					\
+extern void *CONCATENATE(						\
+	CONCATENATE(__mod_##type##__##name##__,				\
+		__KBUILD_MODNAME),					\
+	_device_table)							\
+	__attribute__ ((unused, alias(__stringify(name))))
 #endif
 
 /* Version of form [<epoch>:]<version>[-<extra-version>].
-- 
2.37.3

