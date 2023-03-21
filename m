Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD0B6C3ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCUTfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCUTe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:34:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205B570AE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so16986604pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679427233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orHz49MEtEREu43pkNm/tKqUuGAbP6UFRUzWf1lMbKM=;
        b=Iu7lFuzYgxMBD2is5xuyIPdQFrTrSGgbg+1D0Fc9vavmcTU2AgpwtPsecJb3S9pkHk
         KKjXKnvgEgALI8WVKQDM+fdpBWZzhrrFhjZWbqcuTDgFuLuGlbZjbEqFg8lJWOszxTaU
         BfnUVKt6kumqRz8xNLLCYhkDJtpAxBCZ+tqqsUjaEDLAGjYic36hbFBwd7B+Ifu+f66h
         7G3lplMwVw898GhVpPudgEPdXduilp5Zrh2KcMjezDNwow2DbeyddRVO1MmcFIHRxU41
         8dU64iy5DzLNoSD7SJlQjy7W76pLJLDPAhSiYsaezal1KY8AFTMP1h7ZKlxPW3fbP/9Q
         PUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orHz49MEtEREu43pkNm/tKqUuGAbP6UFRUzWf1lMbKM=;
        b=LcoO6hCMUDyv3HWLUAr0z51zVkT7M1S5eSHvpbst0uwTnHJP/mKJ8l8Xpiu8hnyAcq
         Qxvn3M7nQfq45Buo9XhO/r32Z5Q2QeWkf0MvaRQDaUBzfu+/YbUuvegL9vy4JEOAFCSW
         5W1GIDlBl1EIBAYpU7yamlvSJ/wMou1YxyfEPKP/w127v5HWONxoldcqgj67ZAEPgtqX
         oaOoXrpZC+5k3c10baQwJFPOCcP8RrY5jXtEc1I5NSaUq19SEybpTi3Us4g3lS/XC5Ph
         CuD6BRliEttxcOJTmh/3FA0OlVFK85j7n+K9lR4/8z/Pp6ts0YNf77z4nuk3T2nbl3qN
         PMnw==
X-Gm-Message-State: AO0yUKVh9TDBw77kgO5uSE50S0CL9lerqIkWlV5w/l+DSMyTeJlGTQeQ
        c5NbNHCNOQUklXt+3IoulVc0EZKFKDgVLA==
X-Google-Smtp-Source: AK7set+EWZ8xOyhR6UvvpHkCf9PTFuddYXAucaUStZQVzs1Zzn8sniZj5wRrZdTOp9J5f9yPbpJJHg==
X-Received: by 2002:a05:6a20:c87:b0:d6:7d3a:c6e with SMTP id dt7-20020a056a200c8700b000d67d3a0c6emr3265804pzb.44.1679427233676;
        Tue, 21 Mar 2023 12:33:53 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id k23-20020aa790d7000000b006247123adf1sm8843044pfk.143.2023.03.21.12.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:33:53 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com, yesshedi@gmail.com
Subject: [PATCH v6 7/7] sign-file: fix do while styling issue
Date:   Wed, 22 Mar 2023 01:03:41 +0530
Message-Id: <20230321193341.87997-8-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193341.87997-1-sshedi@vmware.com>
References: <20230321193341.87997-1-sshedi@vmware.com>
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

From: Shreenidhi Shedi <yesshedi@gmail.com>

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
2.39.2

