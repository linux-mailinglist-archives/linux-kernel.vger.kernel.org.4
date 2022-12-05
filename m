Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D7B642412
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiLEIG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiLEIGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:06:52 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CD8120A4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:06:51 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id k79so10599215pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Skw+x75ggHd0E2vUlZvkCuULGR1hwXkr/b91aOSkmo=;
        b=H2IXUIEu82Eqws1HCPXnGM3iwRB4LzJeMB196NvcmBEiaNq+0DDuGdBdz6ykk6JbRP
         MnkFYQSiKb79mD9YOkNbz7+SDtkX0frRHLZtrBfAEX1EPCOU9zQhSn4ytDOSWp+K6VDn
         n5b7nNey8aeHdU9/NKXxf1WxDWKUxkvHU2TuHs6fJUvIe051wUr3szXQk41qUC1oX0OF
         zNJewOCGdFLMLK+SIUdfOT0ITSTL4hS+5sAoAoJkVVLuMdYm/bSQPqQ6XLcrHgoilYpn
         U8U08qnE59+Y4T1NYHuI4ljCMATJH/v15SC5LgBUbgFeAvQcd1ru6ZRmdfiq43yj2Rur
         gWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Skw+x75ggHd0E2vUlZvkCuULGR1hwXkr/b91aOSkmo=;
        b=U0sOh0MB+ZzFezRQypFdny4tRE3aw0DwekH3T/WcbGwpAKJK5DjS6Af3q6/6ectgQG
         4aPVTgM1TrG298zMkR+PLvQ2r6CPcnWi/s4U/luqatmdYdgXlfng3mXvrfLZ3RHjcLPP
         j45zMMZoHt7RRdCSs7v6Ehy2FvyY8WXCODhLTO5YkeFfvdNXylegC121LFPasv59KwAL
         Gtt674Gt5vL8PU5LfcGJpwhXWhkwqhQk55Wdas/v6q/KPB1eLJ9TyTyFk4kneZVF4J5b
         Wr5RE1wdtrqO56EhlmVteRksgbsV69Ipxhn70eJsw7AIJWBIPkTA/dEZwlh8w92MbQK2
         d49A==
X-Gm-Message-State: ANoB5pkjTGODmemS9QR1e4ps88I+EVPMF3e9vWV5RA8mMNG28QkP3WGT
        1aAwIDE1KfssOIi5LFT87aWdaFtJmnRZKA==
X-Google-Smtp-Source: AA0mqf7lkgbBMtfcU3Kh+vMaA+WggDWQ+0fOANWXhb7NO/EXG+OpmYUDlR77YCEoaPmPSmrz3SgCMA==
X-Received: by 2002:a65:5606:0:b0:477:b96f:1f62 with SMTP id l6-20020a655606000000b00477b96f1f62mr49429334pgs.563.1670227611409;
        Mon, 05 Dec 2022 00:06:51 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id q61-20020a17090a17c300b00218d894fac3sm10684657pja.3.2022.12.05.00.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 00:06:50 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] objtool: Fix memory leak in create_static_call_sections
Date:   Mon,  5 Dec 2022 12:06:42 +0400
Message-Id: <20221205080642.558583-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strdup() allocates memory for key_name. We need to release the memory in
the following error paths. Add free to avoid memory leak.

Fixes: 1e7e47883830 ("x86/static_call: Add inline static call implementation for x86-64")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 43ec14c29a60..55ce695017f8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -668,6 +668,7 @@ static int create_static_call_sections(struct objtool_file *file)
 		if (strncmp(key_name, STATIC_CALL_TRAMP_PREFIX_STR,
 			    STATIC_CALL_TRAMP_PREFIX_LEN)) {
 			WARN("static_call: trampoline name malformed: %s", key_name);
+			free(key_name);
 			return -1;
 		}
 		tmp = key_name + STATIC_CALL_TRAMP_PREFIX_LEN - STATIC_CALL_KEY_PREFIX_LEN;
@@ -677,6 +678,7 @@ static int create_static_call_sections(struct objtool_file *file)
 		if (!key_sym) {
 			if (!opts.module) {
 				WARN("static_call: can't find static_call_key symbol: %s", tmp);
+				free(key_name);
 				return -1;
 			}
 
-- 
2.25.1

