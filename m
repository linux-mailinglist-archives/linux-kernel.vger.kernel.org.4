Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CD569502E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjBMTBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjBMTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:01:09 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E261D22A00
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:00:44 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id k13so14566931plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmM4r2OMh3Z32taltePOHPkCX28LIQpMjGdIpNNCepQ=;
        b=BbCglAumr1w4yfMO9nnPzrlkWzgJpWhFPiAwdVbeoz6GhgmQcDEz6NnJ3ZR86Zzhan
         Cy6wXZQVkbsTOQsAogqzjUoPDAiHSkLZc1eNbSb3wHBIXO/xqYRcqGB2I1lXL8Qg7Dg7
         7IpQvk/VWxDmYHLOLGglUh2sTm6y/TWvcMNY90aO66llgm92Uq1wspHlJqLqJpVNs0WW
         DPyCe9X8cWW+dnk8DAvLu9eyBL40uL7W23WUwFdmoVkYPV0oW1aWxkqLCZZuFOns1CYR
         T4abaO21d4RAlN/PUNZ+7myxs5/cTqIyEkwV+tL/TATOkld60AVAcLac95as5Lhp9KXd
         MHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmM4r2OMh3Z32taltePOHPkCX28LIQpMjGdIpNNCepQ=;
        b=A8WG2ZR0i0g0LC+T2Urbe9caFr+CPrcNX97gVcpSdy2ff7eYaNaVKk7NzXmhYEND1a
         5H4u96UV3982D8ix+IezN8jwh6f0ppbKJYnseYkGOfjgKpQAMD85kG9yu5duYa8sCLRq
         DcbAA8kH4F4cTyaYf7s4MwOLpZgkJaapCrJz9Bmy654bx4Eckkq6+3HhEaJlJLSV6LKB
         OIblYgD2i3/L3KOcwyVDhfVxZzs0nawvtmVYN2loTKhS3vv0auygia1rxTG+U1XlRJPW
         2v6q8uXCH2ncu8jCdOXw4W/eRHWivMPQN3RJoC+p/7uSRcu2drmzHenmZ5jWdBufoyKo
         lHJg==
X-Gm-Message-State: AO0yUKV1zs0Hrcs0tCKVBubHpp0/FVbhUXrxyLHM9+PEmK2n/IrOqQn5
        n6gvUpDow6rPbLG02/jyCF0fGHUmgeLcyw==
X-Google-Smtp-Source: AK7set9YYQVqNcm6c1cNH7Pma5TmpQhfxviw5O64zgUOIryOsqaWSV+ENJYsXDchpX2n8LLlqstAbw==
X-Received: by 2002:a05:6a21:6da8:b0:bc:55ca:e63e with SMTP id wl40-20020a056a216da800b000bc55cae63emr33016509pzb.53.1676314844404;
        Mon, 13 Feb 2023 11:00:44 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id c25-20020a62e819000000b0056bc5ad4862sm2032452pfi.28.2023.02.13.11.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:00:44 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v3 5/6] sign-file: use const with a global string constant
Date:   Tue, 14 Feb 2023 00:30:33 +0530
Message-Id: <20230213190034.57097-5-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213190034.57097-1-sshedi@vmware.com>
References: <20230213190034.57097-1-sshedi@vmware.com>
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

Fix a space issue (cosmetic)
Both reported by checkpatch.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 scripts/sign-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index b48832d54f45..0729d8df5660 100644
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

