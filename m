Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94514694FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjBMSu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjBMSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:50:44 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F93206A9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:50:31 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so13156960pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmM4r2OMh3Z32taltePOHPkCX28LIQpMjGdIpNNCepQ=;
        b=oV+CDAboP9CwLuNWFmxr43IPnIbYgHm5io/9RxtjfnskTG6XliM8h/GsK31HOjSviA
         nGk18OpI2RAL9UakURhU1+d6KkoSl5bQb/NUI62dK8jq/fHA9S56uS3wmI+rLtUtet2q
         KirX6GfMIiiEKMal5WWK8g63opD/Nj0NlIBR+OKFi4RPOgRiiqcYVS52RHeh0H3T/1rZ
         QIujUQ+UlIPKivu7mFcl9oqP2RhPHOTI6SPcApQqonQtAdQ6+KIvK/icmr+z+jlv1c6L
         Ylzf0jLXjk8SEsgzwcwuOLxyhGS98zcTDoFVQ1u/bzAPhQLs41n7o3o+us9/WxrPtCXD
         3fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmM4r2OMh3Z32taltePOHPkCX28LIQpMjGdIpNNCepQ=;
        b=csLHLAC7BWRgpsz+TSMH07cvUA+8876jclCKdjTVEANS8tqHR3Db/UQT9TCdqaiclC
         3EJcW1PEc+YxkrJankIzod5PmhM2XMKEAWXJ4IDw4l379fXxbxNwY7FVd92CR0uOPdin
         0xBGhImfdC+NpsTmm56gysRkCKoOaEHzsLBaNX8IfNDssxDsyK3COihODKcDIwY2c7F4
         YCFXKi+Rrfal9BNN6x3VaHRHBdzssKNMNWZqTfbGKuspi0YBuoPC10aVBwvYVEqJ/+tv
         GWPEb/Bo10FgzRReSY8nwudVeksSNZY3r8h+gI2/XEe/hXI8hYqw2Pmry120ew7pzY0I
         u82A==
X-Gm-Message-State: AO0yUKULpiIzpiEm8+n5TQccafSKde0uejQ95wdI9NGpU4kT3RZmTEgI
        eaTNfpq1to3BBN6t1PCvqTE=
X-Google-Smtp-Source: AK7set9+dyUeOBkh6n/hI1BBPXlp4XavXHDSuRu7QocNMMRE/VuP4ohYjHiXHAr00/JoShGa9K8qLQ==
X-Received: by 2002:a17:903:41cd:b0:199:4be8:be48 with SMTP id u13-20020a17090341cd00b001994be8be48mr17938311ple.19.1676314230890;
        Mon, 13 Feb 2023 10:50:30 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id p14-20020a170902a40e00b00198f256a192sm8535036plq.171.2023.02.13.10.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:50:30 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v2 5/6] sign-file: use const with a global string constant
Date:   Tue, 14 Feb 2023 00:20:18 +0530
Message-Id: <20230213185019.56902-6-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213185019.56902-1-sshedi@vmware.com>
References: <20230213185019.56902-1-sshedi@vmware.com>
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

