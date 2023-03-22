Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D956C3FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCVBhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCVBg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:36:59 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDFC5A1AF;
        Tue, 21 Mar 2023 18:36:40 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d14so4945371ion.9;
        Tue, 21 Mar 2023 18:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679448994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geHKdXSrTd+j0bEZzl4suSAJY2V13AlXRMEuZwesJq4=;
        b=Exufr2+FbVYVB3TWRJVhvwsg8XcRWMUuRQptkHRHLVySLmV1zl7ipHgwLV1WPnAtfz
         9s9W0Bf6jpkzFDFwuH7+Gim+gQsiRVzNT9VxjoEDBZdhBqUTnrYaMd0C7EcM/DicNDBd
         emCvxY2pqCAD6dF4vX1zHdw9EBswdlp333p46frCDHCIYwYHjogNnFuBgCbqx61+JlY7
         QF41Rvi1utPIA6WEHJnef5WG91skX+HUGllM4t4nlg2yrTqTfDl68D1LrtQFbT9GXaJB
         PHWknxafPLiGb1RL6keJqd1kxW/4PkPWLqSX8/TVnUWD4FbBplxsvrmAplcjip3eJtia
         BYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679448994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geHKdXSrTd+j0bEZzl4suSAJY2V13AlXRMEuZwesJq4=;
        b=tblbSf0QcTZsSfhuuOzWSGJzuEnko1YCSuelYXRz95lZQUy+IrnUY3TNNBDDx7TsyK
         d7qgtrBXHU0k/7tFOydhKcbdooSFRLdnickvE+7i4KG1U2NGkhDcgbZrekiUeCe+4ETD
         vGxZDuU2Jviev61oBz3gbeU1J3eY0XtEztpsXqFCeyluUR99PfS4aG2PqdIN/Lhy/aqy
         P2adBIkCPZqZllurKkSpR9VFRn71/LMPg5hlef8FcHfR4IqwRx/FHQZrXcdJWb6dCmvL
         UAZdcctTJDBNi9B4M5tUFgZsEECxth1zYRVT77C7Uu3RP8UEEIu66RvayNL/drPHUV3y
         kBuw==
X-Gm-Message-State: AO0yUKVKWOqvqMjCMOtqcCPI2PFNrrbFgvr9Cvhi8Be8K6+PCoNxozsR
        D86jYLu68xbCfmFAHDHhcaI=
X-Google-Smtp-Source: AK7set/ButdII1reoOj79AjhVSnxCvB73puNkd1bHq1GdqNgjFlfAp3flBeK3PvwhlyM6cjFjvmM6g==
X-Received: by 2002:a5e:d60f:0:b0:74c:bb78:25d7 with SMTP id w15-20020a5ed60f000000b0074cbb7825d7mr3149817iom.19.1679448994193;
        Tue, 21 Mar 2023 18:36:34 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id a22-20020a6b6616000000b007530bbfa577sm3925058ioc.18.2023.03.21.18.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:36:33 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/4] module: add symbol-name to pr_debug Absolute symbol
Date:   Tue, 21 Mar 2023 19:36:21 -0600
Message-Id: <20230322013623.251401-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322013623.251401-1-jim.cromie@gmail.com>
References: <20230322013623.251401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pr_debug("Absolute symbol" ..) reports value, (which is usually
0), but not the name, which is more informative.  So add it.

no functional changes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/module/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 39f267c40286..e248a3697ffb 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1350,8 +1350,8 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 
 		case SHN_ABS:
 			/* Don't need to do anything */
-			pr_debug("Absolute symbol: 0x%08lx\n",
-			       (long)sym[i].st_value);
+			pr_debug("Absolute symbol: 0x%08lx %s\n",
+				 (long)sym[i].st_value, name);
 			break;
 
 		case SHN_LIVEPATCH:
-- 
2.39.2

