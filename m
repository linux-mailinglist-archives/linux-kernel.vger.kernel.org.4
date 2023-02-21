Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561E069E58E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjBURIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjBURIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:08:17 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CCE1ADD6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:08:16 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b14-20020a17090a8c8e00b002349579949aso5349478pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LT9PI+hvKnGp//vCvvtr6dHvYoipI+WYbzo+vYB5AXo=;
        b=kaanlbS2ClreyB+3yGuX/XEgzpiI8CggiMa1Obk778fzFZt+ho9JaXOSoAHzYARz1e
         c4UMoxucjIst2L8tyJ9BnrdY18rkc8vSqLtux8vntsKjnBRUQrMOCgp/8FHB1nvoVCvP
         Q5CDXMPEWFKTpH3NPbKm5B6uhyPT26xu8AfYyj+v6grq/ne47OEUELkiOvG8CLWUg3/K
         z3JkPUug/jzKHa3mi5pg7V2kDbsOCMR5fmZtD+UmUqfxH2td/MH7Z7qbU44DGd+VzK+Q
         Qq2NCS8/DSJqIB8/RKKEM69eHsAgM2tzMvGPVHHQ8uuoe+1joXRcPSqQEVBLrsPr9ArV
         yzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LT9PI+hvKnGp//vCvvtr6dHvYoipI+WYbzo+vYB5AXo=;
        b=Xjz/IsERfBJXjgPxsDYqBzcOw1csaDDE8HQ/L93BqtAJrXRDcO3piviaKtCWaBQ3RF
         hdFmqFzsqnfeLqGPnEImeRYdRjTnQbcnvvbMESRmknrZa6xBmzeVJyQ4ciD4hJmM31mO
         oJhU/Fm4N8Y2WeFXrq99G157YhhZfnvCjeAe8oVmZxUFqIuPxofKP4W+3ZevXNGEDDhh
         LJ8Isiumne0XBPuCBTTFfRO+EfdIMxxONwAbqYpkDKztTHBJCHqXC9+gxAC66o/dAr65
         6YptU4hEtfqM8Kt3ZgI8WUh3JdMvblBEc5kJ0QugfYtbZPxv2po7Tp/nAFyB94EPiJeH
         IyYQ==
X-Gm-Message-State: AO0yUKWGYsSy64iwHVWeu794g/R3RqTVN2I5iYGX2pUKaeZadN3WIgRY
        ABuXJ3hHkmUBXIfeKv8iPuw=
X-Google-Smtp-Source: AK7set/sySDWgtmJX8NgdP02jcNU541gbyGnD1YvR08ee/NkEQw+td5TEm2RAhRLnRful4KNM8pmog==
X-Received: by 2002:a17:90b:3183:b0:237:2045:5198 with SMTP id hc3-20020a17090b318300b0023720455198mr2847572pjb.36.1676999295525;
        Tue, 21 Feb 2023 09:08:15 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id 15-20020a17090a01cf00b0020b21019086sm4522572pjd.3.2023.02.21.09.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:08:15 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     yesshedi@gmail.com, dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [ PATCH v4 5/6] sign-file: use const with a global string constant
Date:   Tue, 21 Feb 2023 22:38:03 +0530
Message-Id: <20230221170804.3267242-5-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221170804.3267242-1-sshedi@vmware.com>
References: <20230221170804.3267242-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreenidhi Shedi <yesshedi@gmail.com>

Fix a space issue (cosmetic)
Both reported by checkpatch.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index b6856fd5cb10..b6d6bcbf5a04 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -71,7 +71,7 @@ struct module_signature {
 
 #define PKEY_ID_PKCS7 2
 
-static char magic_number[] = "~Module signature appended~\n";
+static const char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
 void format(void)
@@ -116,7 +116,7 @@ static void drain_openssl_errors(void)
 		if (__cond) {				\
 			errx(1, fmt, ## __VA_ARGS__);	\
 		}					\
-	} while(0)
+	} while (0)
 
 static const char *key_pass;
 
-- 
2.39.1

