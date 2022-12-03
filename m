Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2806413F0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 04:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiLCDGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 22:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiLCDFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 22:05:51 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B928F81B4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 19:05:50 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-14449b7814bso2639764fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 19:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2YyULr6voUl0K8zSMvH0UpwnL7vHX7Ko6WXAdvVD7V4=;
        b=LjKZauW2LJ43l8LQ9GYVsJbxk/jGfuyExLPKHOxAyS9agtgI7mypi1eWWBTLXIAVhQ
         V802P1uPqd6ZrrqnnHIV/3SIlyBenE++NV44aw2GShUjd1PYJ/4eNpql1GfwBvA839PD
         deMNeWiShyRdALtVJ2h4XKb9ljvbT7z+ps/VXyCFy9hp+TfccFyYRaSXVVDLpjUTzWua
         973mAzQr34cfmXATF3GhEw38SllUmdHkEeSdTJheV5UVHKW+Mv29Kn4reHzQlNCHATKx
         2+bmv0FfzIUbc2wOQLqk1hLRL78UZt+VgQsCoCtnI5zIzFyMWDbdaoY6AVJ86cCcHbcO
         dvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YyULr6voUl0K8zSMvH0UpwnL7vHX7Ko6WXAdvVD7V4=;
        b=KHlKmj1VnBw94iJSMZFO3N6GNXUcYtaghpmkWMIqDVtIhtYCUBtuqXFlRXKFVco7iQ
         T0HuHo6g4attYHh0uRPcjBTnedSkWZ4pvn/q3EXzbfzK4J7u4S77Hkfpr4nBxdArjvSB
         VoSUy9z5oY4YuvVUuPlYksztKhifCDoSO+8BV0kCCcP74zU9vz1NbqNbzPlM9Tvht0eA
         8n/6uBBBoX3BwvxZRm+mRjfOBVbxRJ5FQO0IOvYsbwqtBa0GqNpeY0UMnrLWLJhsJ3r7
         /M0ggXdeohHzjuqmhe9wI+WLVvs9sK30t3ZLC3iSrceV2tG5X5Z2T9dfwpXWcyUuYrVU
         Q0lA==
X-Gm-Message-State: ANoB5pkWF/ZUgmlbr6hAo93zD4KK9VF4CQxur+SaLcpfyuq6yYoDsSy3
        isabuAVcwoP4iIMV4nw2sVKXuAE2ISqRgA==
X-Google-Smtp-Source: AA0mqf5sSQdwViXhDoF2cR9NyqiwAhWWJMqIM9rRWq8evUJ75qaQH4GTFDpZF0m5osJ9edwkSrkd6Q==
X-Received: by 2002:a05:6870:4720:b0:13c:2ced:9d9a with SMTP id b32-20020a056870472000b0013c2ced9d9amr32156019oaq.105.1670036748699;
        Fri, 02 Dec 2022 19:05:48 -0800 (PST)
Received: from otter001.hsd1.tx.comcast.net ([2601:2c0:8800:a510::6e2d])
        by smtp.gmail.com with ESMTPSA id g13-20020a056870c14d00b001375188dae9sm5136561oad.16.2022.12.02.19.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 19:05:48 -0800 (PST)
From:   Joe Peterson <jwp.linux@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Joe Peterson <jwp.linux@gmail.com>
Subject: [PATCH] staging: board: Remove control flow from macro
Date:   Fri,  2 Dec 2022 21:05:44 -0600
Message-Id: <20221203030544.11543-1-jwp.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
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

Adhere to Linux coding style

Reported by checkpatch:

WARNING: Macros with flow control statements should be avoided

There is only one return value possible. Remove the checkpatch warning
without effecting functionality.

Signed-off-by: Joe Peterson <jwp.linux@gmail.com>
---
 drivers/staging/board/board.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/board/board.h b/drivers/staging/board/board.h
index 5609daf4d869..94823d3ffbe9 100644
--- a/drivers/staging/board/board.h
+++ b/drivers/staging/board/board.h
@@ -33,12 +33,10 @@ void board_staging_register_devices(const struct board_staging_dev *devs,
 				    unsigned int ndevs);
 
 #define board_staging(str, fn)			\
-static int __init runtime_board_check(void)	\
+static void __init runtime_board_check(void)	\
 {						\
 	if (of_machine_is_compatible(str))	\
 		fn();				\
-						\
-	return 0;				\
 }						\
 						\
 device_initcall(runtime_board_check)
-- 
2.20.1

