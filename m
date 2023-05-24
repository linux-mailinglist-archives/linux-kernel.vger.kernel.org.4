Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E94270FBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjEXQnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjEXQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:43:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CE2E9;
        Wed, 24 May 2023 09:43:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so1186854e87.1;
        Wed, 24 May 2023 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684946584; x=1687538584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9CuijodwmqfQEn0tXnJ/TJge8dao1nUkPKEeKc5bsE=;
        b=LVUlJKuVYlpNMW29XV3jIECyQbFSj3bWTETGmb0R7CzhXjzDlD1rY7l1WrmnBwJWmn
         BnzibY/ek5gOXN6RjrLK87SBPwLYR2LrltbfKJoUGK/cRexkw+rrWeDaMNxaper/nNBz
         zkotIqK3UH+JV8bH+7kbCpixIEWeFwFeg3GPCOuzmuct7fLYiD73qsmFdk3strrS6AQz
         o+V02g+WuJ1enKw+GN+nrvHbZFU4tcJPG0K6WYBGVTv6prrRpYs28cucuLpRrx1htlBF
         UHwC/Roc8OhXSx5TSWbC3vw012buikQq10F1vaFp7yh9/ef62Cuc1OySaHTWtrDuTOEN
         TrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684946584; x=1687538584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9CuijodwmqfQEn0tXnJ/TJge8dao1nUkPKEeKc5bsE=;
        b=KxPMNdr7qrD19u6A7rfvsOpmhcxyegJD/6mnO75Pe+rQSbW3UE6z2FYzZsxtPS9z78
         olzhVsB6F1IrkIn+fZmonnUwn865kAPXGvDm92K9pNlx/mz9IoBV4CLorJBa+/wyh0Tp
         eQUWmDCirNz3K8q8K2XmUVgYh0NuoySQh/DD6LDrAmSy7y22Azdizj1RcKtBoFtr/l7E
         G0kY1D56oM6B3mZLf+ZGqtbfD21xaoofIxD/M6QkXDeCvzYoNA0x3QqyC/pXmkpIKi6P
         RNRy0MW7KGmczsvAI9pnNph/rjRrdCossEjvylmfMkR0iEKdeLQKXMORR8YBVlJP950Y
         vWug==
X-Gm-Message-State: AC+VfDy2DDUL4yCo7L2LookKsOQVc+3afqJed+ZIAVqJ4+7IV1qlmcv5
        nfrRLPmTOvNfMFhoLJs7//Q=
X-Google-Smtp-Source: ACHHUZ4EFbSnq+c3HYQfxYKh0/QV2vuVNHKwVIAprpx7mnG4XfSlyIKoKS2xuWBdCam7yLAn7FQ+nw==
X-Received: by 2002:ac2:414a:0:b0:4e9:59cd:416c with SMTP id c10-20020ac2414a000000b004e959cd416cmr4242690lfi.0.1684946583693;
        Wed, 24 May 2023 09:43:03 -0700 (PDT)
Received: from Osmten.. ([103.84.150.66])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002ab0c9fab23sm2143689ljb.79.2023.05.24.09.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:43:03 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] smsdvb-debugfs.c: Fix error checking for debugfs_create_file
Date:   Wed, 24 May 2023 21:42:10 +0500
Message-Id: <20230524164210.20567-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch fixes the error checking in smsdvb-debugfs.c in
debugfs_create_file. The correct way to check if an error occurred
is using 'IS_ERR_OR_NULL' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/media/common/siano/smsdvb-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/siano/smsdvb-debugfs.c b/drivers/media/common/siano/smsdvb-debugfs.c
index 8916bb644756..0f8750d7993c 100644
--- a/drivers/media/common/siano/smsdvb-debugfs.c
+++ b/drivers/media/common/siano/smsdvb-debugfs.c
@@ -469,7 +469,7 @@ int smsdvb_debugfs_create(struct smsdvb_client_t *client)
 
 	d = debugfs_create_file("stats", S_IRUGO | S_IWUSR, client->debugfs,
 				client, &debugfs_stats_ops);
-	if (!d) {
+	if (IS_ERR_OR_NULL(d)) {
 		debugfs_remove(client->debugfs);
 		return -ENOMEM;
 	}
-- 
2.34.1

