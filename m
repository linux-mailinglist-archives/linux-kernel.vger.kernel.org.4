Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F047973BADA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjFWOzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjFWOyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:54:25 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0C82968
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:18 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39e8a7701f0so494541b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687532058; x=1690124058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGa/E1EozA1ONh5cNmJYBRSriG6HQN403JbmkXULwlo=;
        b=hDmOERX6zZrj/O5nFegU7i8WbSyvwnE2Tf/OYuCslAtDzhnEjihN7iXEHJT3qqLNXU
         x5qs/wZpgWE3X6xkUDGYjSgoNNXMcsH/VxHJH1yg+64h6Wk73wpYiCZH8fLmLLYDuk5m
         8HNGY6nWzUtyYpd/DCFCsmqJbJfHtVGL9NBW2kflxSMbfNXHLKFxkIWf1j27uUaIrU7u
         Az2GM3Dd3SzaVxL35LCDfYtOWrT1FRn/0MjA1dDQBP2CFNV29CTEcfsQvjG0inVx9V7N
         ihVvqw/aFvjdsC+X5UgNWl/32fcqmHdNnf8hasLG6c8QnvU9/nIGtGjIZcWLox3MeCzy
         W+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532058; x=1690124058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGa/E1EozA1ONh5cNmJYBRSriG6HQN403JbmkXULwlo=;
        b=gc7c2Jy5x8WoHKVJbrO54VvzUeg9KvuYr2ZbctjRa7RlvpEWXdYJ92HgLV6DQeWzzD
         qe5O6z9U+e9TpEEZ4v4AWiLgem2kaSeLX4WKxQVdyDYyJkSZNvnATolF1UyeK63j0fvX
         G9MP3TXoS5wvsS7hRgjeaz7rVjwTVcixk6k+ftDsrOX78P5abwIyOnwgVEkLX0pmEajN
         TGjUumq1qjeb8449iK0vyBDTHp1ILZpZMwEdZTIH6oyhFFg6dC6XzBDOuazk6aX8NOkK
         9wim6KEx5nc3rLySeURGzCbQgR2pASp86NqOJd1nNLQ7HP/7hwmC9mGRRTPi+Bj9iFsI
         1reg==
X-Gm-Message-State: AC+VfDynVKSDcelXBado3rFBOldHi2spVu54s22cl40A69a3HxNByaKj
        J9MGf8yF3Fp6i3kiapPWwYk=
X-Google-Smtp-Source: ACHHUZ53ScG04P5CNQsWhcYGtcHprBtu+blXjp3c2joIMKuIhDAxHlzTN6PTZs2fUfPAu1KippZdNw==
X-Received: by 2002:a05:6808:6398:b0:39c:8bc5:f8db with SMTP id ec24-20020a056808639800b0039c8bc5f8dbmr19444734oib.37.1687532058231;
        Fri, 23 Jun 2023 07:54:18 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id fa17-20020a17090af0d100b002565cd237cdsm3359624pjb.3.2023.06.23.07.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:54:17 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v7 7/8] sign-file: fix do while styling issue
Date:   Fri, 23 Jun 2023 20:23:57 +0530
Message-ID: <20230623145358.568971-8-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623145358.568971-1-yesshedi@gmail.com>
References: <20230623145358.568971-1-yesshedi@gmail.com>
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

Reported by checkpatch.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index e8dfbdd3eea3..0c95275c4564 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -147,7 +147,7 @@ static void drain_openssl_errors(void)
 		if (__cond) {				\
 			errx(1, fmt, ## __VA_ARGS__);	\
 		}					\
-	} while(0)
+	} while (0)
 
 static const char *key_pass;
 
-- 
2.41.0

