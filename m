Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130F2601154
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiJQOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiJQOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:41:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C7A52455
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:41:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id 13so25467954ejn.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuBb5ljQMpmcyaTrGqF1Fy74D+G132DrFCMrIoW3IlA=;
        b=YfHjKFirxF/uU5tvjOiYI8MDgrsuFH+rzZTctvdHoxu4J5uIvM5uNDryofSIuBCPOS
         rEc+icCdKPeWSz1RxXEmt/GDRj6VikjonJjpt6v44MXBG0DaB0jpUM0kg/CoZKFGLbme
         AIyTSw1RRcGoVlElAhPDP9KyGBshifi/VQ2iH/6aH4hWQEvD2rbMbuUeqr1/b5cqOJp9
         TQHxZEcyxEdOzX0PNyvZJ0qjJNjxvDNAMD/pQ64OxsaZUnF/BKRt0nekFtLkO8D8FWus
         ed9aqWODkE/P7db8UCQGjAXBW27ouhAhP9fVZ+W2a6TZZ4S3p43X2/ZBTih/5qYVsOJZ
         CRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuBb5ljQMpmcyaTrGqF1Fy74D+G132DrFCMrIoW3IlA=;
        b=b0eFek+i0BIz+QsrHCH2jmCRxiDwJ/JKuA/3AQJQ5ecs3UhRS7O/gYLitFZq41GGsH
         HY+vfMD5+mTZ4Rvm0XU5WXmQQFJVzAuIcWlqo3AWAmmfZ0NWD1lEBjRxMqJb9gsRtdMx
         TnZKMHsFDAKt7ywBELWYfGCSN0I8Hf8FpQVbZoRmHpSutCpn5ETZNhNAaCPnKgtzPgm5
         L78ZRtBE2xwLy0FSfnQIgYEmWi31XHOxgQ5nh7W/7uU+Y1I7/AtmJLYwWUrM1/rfn263
         MFdWxWYTp3IJT4eUlvzI7/d8DISO5VowXIoVLTE6MFDzYnpxKV8E837KbVNryMH/yufy
         LC4A==
X-Gm-Message-State: ACrzQf1d5P3kF0fMCWHZYNYlnZDyxQy5hyX27z1y7gjW1L5e0IwJcOf2
        iITaa70zfex0uBJd5nOq8Nx16Rw+NU+yGg==
X-Google-Smtp-Source: AMsMyM6j8xNXHz7nj9oU8cJB2C/2vyCxJUVwOjhzlM3EeEVuD4gmuBM9CitJAFvs8G78oNudvED/YA==
X-Received: by 2002:a17:907:70b:b0:740:ef93:2ffb with SMTP id xb11-20020a170907070b00b00740ef932ffbmr8748604ejb.93.1666017680684;
        Mon, 17 Oct 2022 07:41:20 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id dn2-20020a05640222e200b00459cf672a65sm7469144edb.71.2022.10.17.07.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 07:41:20 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH RESEND 2/2] ucount: Use atomic_long_try_cmpxchg in atomic_long_inc_below
Date:   Mon, 17 Oct 2022 16:40:49 +0200
Message-Id: <20221017144049.3404-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017144049.3404-1-ubizjak@gmail.com>
References: <20221017144049.3404-1-ubizjak@gmail.com>
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

Use atomic_long_try_cmpxchg instead of
atomic_long_cmpxchg (*ptr, old, new) == old in atomic_long_inc_below.
x86 CMPXCHG instruction returns success in ZF flag, so this change saves
a compare after cmpxchg (and related move instruction in front of cmpxchg).

Also, atomic_long_try_cmpxchg implicitly assigns old *ptr value to "old"
when cmpxchg fails, enabling further code simplifications.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ucount.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 74f5b4959feb..2c04589a61ff 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -214,16 +214,14 @@ void put_ucounts(struct ucounts *ucounts)
 
 static inline bool atomic_long_inc_below(atomic_long_t *v, long u)
 {
-	long c, old;
-	c = atomic_long_read(v);
-	for (;;) {
+	long c = atomic_long_read(v);
+
+	do {
 		if (unlikely(c >= u))
 			return false;
-		old = atomic_long_cmpxchg(v, c, c+1);
-		if (likely(old == c))
-			return true;
-		c = old;
-	}
+	} while (!atomic_long_try_cmpxchg(v, &c, c+1));
+
+	return true;
 }
 
 struct ucounts *inc_ucount(struct user_namespace *ns, kuid_t uid,
-- 
2.37.3

