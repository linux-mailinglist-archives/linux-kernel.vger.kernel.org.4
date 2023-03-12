Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A462D6B66AA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjCLN1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjCLN1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:27:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4535C36FE5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:26:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x3so38512403edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678627612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WytfSS5SlCtvN3tu8z+yu+BDV1OoIWQw97CMtR0M6Fs=;
        b=bCtUd4r0Jb3+ogB8NYH1QXQ0YXhVjJo+KKZ4Gzj/Op4ikKit5BrweRpAP2o870HJgv
         Op2Reu1uH8mjdQYkSiASSjust4eEpPAxUDnSa/KrVd9T8XiFv18g3Sw4Q9Eie1AiGtdr
         npE15I5zCfFGgGgLGKZMTDf+c/WmgfDK0hM+2hagUNjN4Vsc6E7/IgemNZzpm955YvOf
         RsVaW43G2YJCAtohoOuph7X6Y1PWw0U2he4YU5J7aJ6c0pkQ4ev+aLwmBMTxZR1DSioG
         4QOb1IjZEqPgikZBTaFORuZqRRhdAlUzaGzPLPO0MtufrLtO0pVQe87cYkxBr4uDvPmU
         6wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678627612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WytfSS5SlCtvN3tu8z+yu+BDV1OoIWQw97CMtR0M6Fs=;
        b=biXi/8xqo+GkA5aEAiLeoY2BoqXHdWm5RAJKFD9jL2YlYc0dS5y0UMieH1MeQt69hy
         QYCvVIydmwC2lz77h5hPPWOTWCZ1VZ7I2Cr2ArLJ1r642qltBMZ5S0FJq8ZbWNJ2qGiV
         9TE3K0/KB+dYsC6OHdP73mflDO7KyLMMo1GiDjaNwzJqivH31vf5DDivhknaBcYdjlEh
         IvADVqaz+nI/1ASWZfHEE7MPAxh9WqkDvmcWXHq3qxg1VYkuRWSfcoIDRyE2nN/5cVy4
         rrnksXIYJS+4M9Pcm9bn4pUbnPDwjdXYiEQ8GUOBn7vaSp70MTHXH4q+LlemnR1T31V5
         yoxw==
X-Gm-Message-State: AO0yUKVA+3mPh3LaCr6tuzvImOczBHA0eFljS6j9gzQTxEBe+4FgRNqa
        VGak825WoYitl1yK1GbC7DjWSYAp0EDXwuMc9/Q=
X-Google-Smtp-Source: AK7set9B3LhrBjMfL2aw3ioMNOnb2g+Fi2MOAMLriFy7O5vDSEwmI/ai/0OLcMaSr73LkK7rgJPgzg==
X-Received: by 2002:a50:ef18:0:b0:4ab:4b85:a69f with SMTP id m24-20020a50ef18000000b004ab4b85a69fmr29958230eds.1.1678627612626;
        Sun, 12 Mar 2023 06:26:52 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090657d500b008b69aa62efcsm2244715ejr.62.2023.03.12.06.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:26:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] soc: renesas: mark OF related data as maybe unused
Date:   Sun, 12 Mar 2023 14:26:49 +0100
Message-Id: <20230312132650.352796-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/soc/renesas/renesas-soc.c:272:34: error: ‘renesas_socs’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/renesas/renesas-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 468ebce1ea88..9e0a5707d917 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -269,7 +269,7 @@ static const struct renesas_soc soc_shmobile_ag5 __initconst __maybe_unused = {
 };
 
 
-static const struct of_device_id renesas_socs[] __initconst = {
+static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
 #ifdef CONFIG_ARCH_R7S72100
 	{ .compatible = "renesas,r7s72100",	.data = &soc_rz_a1h },
 #endif
-- 
2.34.1

