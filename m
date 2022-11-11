Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402AE6265BA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 00:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiKKXxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 18:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbiKKXxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 18:53:46 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414BD27FEB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:53:45 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id s10so4662807ioa.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDC3yaSpzn6xQIRdL0a12mrbMLjfHFMInVN/5qQvsDc=;
        b=MlQ6f2v1QjZgYotknfDEoyhiJJr3J0ffm+KlKSwJM0NbCdg/ok2Nq+ViySlaE34tgH
         Dj83WlRJC1i2sgx0Whctls3St3xX/gPWKxQ+Zxf4mj8VmdAQSQOKR7pPshjLil0qtKg0
         TvrC5xTm/XxajPsWFmv4oy1DJyjdKa1SZZIvCx2JXtuRfJ9r4KVjPfYpd5TI4OCE165f
         Mok4UrbcI2R5lCere/OYYqrHu5PGUje9IHG89wKbPPi24skNKrRBoPtqWQLkdDnlZi7t
         Nk66wxKtm9+9Xt2pL2waiHfhiTquHAGExaxvrnncTgZqRl8zIt9zDfJvkRcM8E/OclrV
         ZhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDC3yaSpzn6xQIRdL0a12mrbMLjfHFMInVN/5qQvsDc=;
        b=qJuAWJHbA/7BFnx1LpEYB8pkZeahwq5m4liz1aOYLu4t+oIOFR7mgGEf4YNVVQ008g
         65lu4sSFJVAAi9phk82+Gel40J3UmC5g3y+vYcSfvLEgJhKSfJr7U9l2MzoAskBM9DTH
         GSh1P92xsMb3LhxESCtrKlg199BF/K/lt/HUIogQwN5Aa7UxPYAis+KaDOgCz/gorkSB
         mffyY4gPPdc0siVVZJBfBPPgP75RKo1NKQ76AAQQCL21wTnlCn/SL+PLBSj6l5zEs2MM
         +Fk0wkCG8k3VBVNbRuzRP7cc++qY1mP/SVIbNjojIKBBpSpzVYt/TUjFhm8jhQs8z2HP
         G1YA==
X-Gm-Message-State: ANoB5pkakMoQpz/UcB74laSRQIbTfNhzfzQMHTXp1ziUNC4MAIu/dJzt
        xPDr+sUFaHMmYgacQ2RgVWPBGP13rqSjMA==
X-Google-Smtp-Source: AA0mqf5Uo/KgiEGOIEGqJiVz54pfOOEe96+xEjngMAMAC/ADgJeOOkxCMcGYWaEmqaSdcfvQmCn5kQ==
X-Received: by 2002:a02:ccd1:0:b0:375:4dc7:d3ed with SMTP id k17-20020a02ccd1000000b003754dc7d3edmr1847647jaq.262.1668210824268;
        Fri, 11 Nov 2022 15:53:44 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o18-20020a02cc32000000b003634aa4a55asm1249355jap.82.2022.11.11.15.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:53:43 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/1] vmlinux.lds.h: improve BOUNDED_SECTION macros
Date:   Fri, 11 Nov 2022 16:53:41 -0700
Message-Id: <20221111235341.567987-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
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

1- replace _s_ & _e_ with the more visibly obvious _BEGIN_ & _END_.

2- add a new _HDR_ linker symbol before the KEEP(*(.gnu.linkonce.##_sec_)).
   This gives the optional header record an extern'd name/address,
   which is "_hdr_", b4/after the _sec_/_label_.

3- move existing _BEGIN_ linker symbol after the KEEP.
   This insures the extern'd name always points at the data,
   independent of whether a header has been defined.

NOTE: if (start - hdr) { /* section has a header record */ }

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index cfad4511cd68..c9b204b0364c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -199,20 +199,22 @@
 # endif
 #endif
 
-#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _s_, _e_)		\
-	_s_##_label_ = .;						\
+#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_HDR_##_label_ = .;						\
 	KEEP(*(.gnu.linkonce.##_sec_))					\
+	_BEGIN_##_label_ = .;						\
 	KEEP(*(_sec_))							\
-	_e_##_label_ = .;
+	_END_##_label_ = .;
 
-#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _s_, _e_)		\
-	_label_##_s_ = .;						\
+#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_label_##_HDR_ = .;						\
 	KEEP(*(.gnu.linkonce.##_sec_))					\
+	_label_##_BEGIN_ = .;						\
 	KEEP(*(_sec_))							\
-	_label_##_e_ = .;
+	_label_##_END_ = .;
 
 #define BOUNDED_SECTION_BY(_sec_, _label_)				\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop, _hdr_)
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
-- 
2.38.1

