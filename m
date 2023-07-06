Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813D9749D5F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjGFNXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjGFNXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:23:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6995B1994;
        Thu,  6 Jul 2023 06:23:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992acf67388so81793166b.1;
        Thu, 06 Jul 2023 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649824; x=1691241824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YMgn8v5HSr1CwulZfQm2e0c4LiCcjYghl7RePYF3Io4=;
        b=jpy3SNoTSnMnS3x/7zAxQzz/XTlzy17ldr228oGAP/Xg3V+9epfdo7Z6fxtc61UDY6
         BF9Jic/dXx03T4dhI9Z2/nmLamZVb9XV7stxUkqVGdmcxTEHj8Sc3P7e5J5/ywfubHPJ
         53AR6eU2vP0kXzZ2V05E5Cq0hNMEss9qE+Jr4fiU/V8/HU/VFrUn8rQ3sJ5vEST9RwRM
         hs+LPBn6dznCGQVF78+4O1/mI76LLSqwn0gqCEBZ5VvLLEovATYVnvn9K91/V5ikdy0m
         PHIewlEU+uEsezVRORrmi1ZkJHUhVPEP501P81U5exIcNEUwvhqahsDqcPuU9grOGAa7
         TBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649824; x=1691241824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMgn8v5HSr1CwulZfQm2e0c4LiCcjYghl7RePYF3Io4=;
        b=WcfmKpqOA+vYe6vR9SLsfa/qQq4g2irLGPhpJcTUhcyu2pikZqDbzX1rcHg7zzN9ej
         QubZOEj4VoxVbh7RDnNRwOqBVyO6Nv9Ov65YM3I9ww5UkKQgJmrrPyZSdQfy0a7etkNA
         i28tNRSR5nv4Ezx8CQ/4QMoAF6MK3uCeHVPEvpFsHMkLuVv4bqL7qI4DEZjCZNBwdqTA
         +Cljh6m9dMfvxx0YgF8b6UzfcUArnWDWWTjHp6mMW6WlkPgPdjpo9i6r2ZzrjKsNtqwB
         IVQK/ohiHvIFRo6mLVRHLOaIn0wnxjGrcEm52KdXVkDYnr1ZXV8U+aVdXWyC9J6iiPdz
         B3CA==
X-Gm-Message-State: ABy/qLaeC+dXvmDldtJriJpT1W/fvaa8gdvBKR0YnXAxfWgqaqiupQEs
        rXnVgDGaXhsRIHpTpTeyZqit/pZ6BjK0oPCB
X-Google-Smtp-Source: APBJJlFgmj/+QSgNFv8mSQQTWgHKLzeq7A2LBLwU6guAw9JIAleSC3NfGCZaY/drGJm1XdQ6LAdVAQ==
X-Received: by 2002:a17:906:51da:b0:992:4a1b:30e2 with SMTP id v26-20020a17090651da00b009924a1b30e2mr1598976ejk.7.1688649823591;
        Thu, 06 Jul 2023 06:23:43 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/20] selinux: check for multiplication overflow in put_entry()
Date:   Thu,  6 Jul 2023 15:23:16 +0200
Message-Id: <20230706132337.15924-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The function is always inlined and most of the time both relevant
arguments are compile time constants, allowing compilers to elide the
check.  Also the function is part of outputting the policy, which is not
performance critical.

Also convert the type of the third parameter into a size_t, since it
should always be a non-negative number of elements.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 74b63ed1173f..6b4ad8e91265 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -366,9 +366,12 @@ static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)
 	return 0;
 }
 
-static inline int put_entry(const void *buf, size_t bytes, int num, struct policy_file *fp)
+static inline int put_entry(const void *buf, size_t bytes, size_t num, struct policy_file *fp)
 {
-	size_t len = bytes * num;
+	size_t len;
+
+	if (unlikely(check_mul_overflow(bytes, num, &len)))
+		return -EINVAL;
 
 	if (len > fp->len)
 		return -EINVAL;
-- 
2.40.1

