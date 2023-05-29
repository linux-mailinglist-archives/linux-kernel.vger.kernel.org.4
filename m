Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2B27148A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjE2LfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjE2LfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:35:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D0EE4B;
        Mon, 29 May 2023 04:34:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso4481328a12.0;
        Mon, 29 May 2023 04:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685360077; x=1687952077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DOq/HrIR7Z74omn1uMHDqmsxPsFhRGLq90Em68o5Hnc=;
        b=n88ZNxooq98tGCJH/ZDpfc+ZwzZP7T3U9j6XQ3++j40KgdsdCgwy0Ss8dEl7ojJLpX
         DFXx5qrVrGNB2BR+EYGAY1Ae+sbNMKKUhPCXXLg/47EIJ/cPmqIzjE1de0FXifF3AsJE
         nN+T9jrcHkBt3NzHjXyqTy45S61wVSZud6JkSRQAZY7aJBEcGh6jqhl+e2sxJBpAFsuh
         6H6Cn1E8CyXjsP71V0Woh5eKPhPwsI5gU2jzdB/V7E9Afyuy38H7mpT9uupbqHwSQRr5
         a12aBg9Oo7GWJVVsVnag6JlR6AJesjN7xOY8Llbkk5WexGXAQBRx1TnKx2D030pxQuVz
         rmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685360077; x=1687952077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOq/HrIR7Z74omn1uMHDqmsxPsFhRGLq90Em68o5Hnc=;
        b=Q7zsgbFvmePgPl9ob/CVM+TZRWP1SQJo6/GQ5xL5IYsknUXwjFgwiinMasfPvxqttO
         eYTFcp118k/FQ74bSrYJNbn6SKI5E71JDVRHUQ+GdaSz6dPDy9mtdUP0LNr6Bbn3HQBT
         Wp4EkQTuFGLP5hqn3Cr7eixZL2jJPOBDD0pTq1KwUW5evG2ln5nyCoahVbwnRGtCRwsi
         n2QAaq2LEvIzQVQL+x1MaI6sgmB+a9YSOsLOgn2XdASfNC1OXBWVWtwObwGSguUDSIto
         f2kKmHTZx22DwZeZDu4JcJb4kIjidjNAi+2l9WcHKXVEdSq+gdeUbBSaV/EMMhcVepA9
         EpzA==
X-Gm-Message-State: AC+VfDzZ5HPbs9bLuR9uHu43ly/mpGm2EJmGI1BnfJiVMvUkbyBYz4S3
        cimTEWItzPKP3objB77sKz3rkVoczG3SQw==
X-Google-Smtp-Source: ACHHUZ6Kd1k80CRBilbe/6IsFq8E9QMYCweT7lNvBxokT1GsnTX7Qm1Oy1heg7d/Xi22uKIj3zszJw==
X-Received: by 2002:a05:6402:31f3:b0:50d:88f3:2e30 with SMTP id dy19-20020a05640231f300b0050d88f32e30mr9392909edb.13.1685360077267;
        Mon, 29 May 2023 04:34:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:b8b2:5ed7:fb5f:eadd])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402069300b005149461b1e0sm2104722edy.25.2023.05.29.04.34.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 May 2023 04:34:36 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH] mips: Fix spacing issue
Date:   Mon, 29 May 2023 13:34:21 +0200
Message-Id: <20230529113421.8970-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
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

This removes the following checkpatch issue:
- ERROR: need consistent spacing around '-' (ctx:WxV)

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 arch/mips/sibyte/swarm/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/sibyte/swarm/platform.c b/arch/mips/sibyte/swarm/platform.c
index 484969db7713..06bf7105e7b1 100644
--- a/arch/mips/sibyte/swarm/platform.c
+++ b/arch/mips/sibyte/swarm/platform.c
@@ -90,7 +90,7 @@ device_initcall(swarm_pata_init);
 		.name = "SB1250 MAC " __stringify(num),		\
 		.flags = IORESOURCE_MEM,		\
 		.start = A_MAC_CHANNEL_BASE(num),	\
-		.end = A_MAC_CHANNEL_BASE(num + 1) -1,	\
+		.end = A_MAC_CHANNEL_BASE(num + 1) - 1,	\
 	};\
 	static struct platform_device sb1250_dev##num = {	\
 		.name = "sb1250-mac",			\

base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
-- 
2.39.2 (Apple Git-143)

