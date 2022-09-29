Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581155EEF01
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiI2H3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiI2H3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:29:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E5EFD1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:29:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a29so704489pfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/tZNUqIuW2LgU2Y9VqaDgSpmLoQ9J9brfNhqe2zcUd4=;
        b=TbtdNNzpWV35S/fp7qRYAa/xZ0A9UAnyY/vJ09WVw5b64FS8Kqscx6qcR56xV0MHc0
         WNyigkhyYcUO8kHFJw7/MWS6iRdYDebD2nN5FV9095BtgrOsQQSEnNRxJq8YdU/+D0m2
         L8rDOrhcfWRj2lbv5uKcP8wRgOk6WJ1j0AV+C4l9Mg1pt1bZdNI85sEKLPhIr1PZcQLx
         ace/RLjSmrW2eBlPWIvjtxpNL7E5TSbLaiLZeb6i9qwC0iFbtCr5FDG5AAjITJx0DrtC
         XSSN0mnajnXEY/g86XEnDiTbDON/bIz9WLoOGthqMdgONsC4v3d14lPhc1Jny/OcaG8A
         ILuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/tZNUqIuW2LgU2Y9VqaDgSpmLoQ9J9brfNhqe2zcUd4=;
        b=Gh91dqS82NrtsqLiDeGXOfA32DO2YWeO4Zc0MBzCbSu9SjzJS2KB8ZavmjDI6/FafC
         fo1MYoTJ2CpJQ9EMdzswoLFjWIvNdKsDRY+FO0SAk7u9WWP4xzNPBL51RPacYCYaVjqO
         ShaRvcahnsI3+SaIa4Y4uPk3NPklVK2gn1nvQo3oZtb9UYgMgU74FXulAL7MPkmEYL+h
         cE1GdU7/RAgA3GWmXRbAOky5CNyKMaCtcOnXK8luVzApwHcBkgibUfcGGflQWpzHYwd5
         bWG6Z1t5fHGq5ANLUsquUotX8vpOCMrN1Y/N00/n4Qm6j0tlWb1EXLg4N7VSCs888ZUm
         +slQ==
X-Gm-Message-State: ACrzQf1k7Iw6Gsb1ViR6lkbE+sbye01WIOYl0zS9yY+N9T319SJwPSOx
        3PUA5l2frmM9/tcGwIOr0sE=
X-Google-Smtp-Source: AMsMyM6PDL1TFKiLzj869qO2hFoH0crHj9TTJXQQ1kQG1tFQrRVwd54oMzyOsq8V0HfgM5LPGooVwg==
X-Received: by 2002:a05:6a00:cd6:b0:546:d03:3dd7 with SMTP id b22-20020a056a000cd600b005460d033dd7mr2182591pfv.19.1664436571966;
        Thu, 29 Sep 2022 00:29:31 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q4-20020a634304000000b0042b5095b7b4sm4861948pga.5.2022.09.29.00.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 00:29:31 -0700 (PDT)
From:   xu.panda668@gmail.com
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, broonie@kernel.org, maz@kernel.org,
        kristina.martsenko@arm.com, vladimir.murzin@arm.com,
        mark.rutland@arm.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        cgel.zte@gmail.com, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Xu Panda <xu.panda668@gmail.com>
Subject: [PATCH linux-next] arm64/idreg: use strscpy() is more robust and safer
Date:   Thu, 29 Sep 2022 07:29:06 +0000
Message-Id: <20220929072905.282639-1-xu.panda668@gmail.com>
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

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda668@gmail.com>
---
 arch/arm64/kernel/idreg-override.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 95133765ed29..61bbec7ef62e 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -246,7 +246,7 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
                        return;

                len = min(len, ARRAY_SIZE(buf) - 1);
-               strncpy(buf, cmdline, len);
+               strscpy(buf, cmdline, len);
                buf[len] = 0;

                if (strcmp(buf, "--") == 0)
-- 
2.15.2
