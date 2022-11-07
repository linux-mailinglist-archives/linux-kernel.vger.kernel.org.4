Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781BD61F807
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiKGPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiKGPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:55:23 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B3C1CB3E;
        Mon,  7 Nov 2022 07:55:22 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id hh9so7062237qtb.13;
        Mon, 07 Nov 2022 07:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cyfnek7GcKCYztRwEEteaAUP1JbSEVGwmlhNomSJ9DQ=;
        b=Qb2rhdwl5kKh3DP3eKzJ51Ip4dUtLDWZTKx/yBg98j4iBVqpQ9ejkVjdMnlEnJySXs
         F3vXSTypH7o+LgRfw+sWzi8/08wqNYEg8PmmqUh3zS+A0IoRgB9B1FNpNU94mt7jdBh8
         MDYNMU8c46TD4C3FrndlIW2iwGZX/yubRhJVDtMXmHYeBB3HnqV5HWlz6+skafta8uUl
         nw802QL/rd2hwQXD4Zob8ISIPWF7nuu1OpvCN3vmH+uWsCdglWMjuNZD3g/I/SqXe0ST
         nwqVQzL0zWtj/s5YbySQSzvz5Al5MprPrZCbWGxAA1YBdMUXmmV3GEzg+aGxVhC6V4s0
         Zm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cyfnek7GcKCYztRwEEteaAUP1JbSEVGwmlhNomSJ9DQ=;
        b=p5XtY+gVm9lUYbUlrGSSxWDBw+CgIA570alxYZAnEFRorEAOdXckzT00Pc+GrvcvAb
         9qwPey7lJwvmX6gLZ55FlIY5KOs/oDKDrfUhF1MYzZcg+kJ7AnNay+iPDQsK4/jfgVbs
         kdyPRe5f6dCHRbCsLgDstc3znr4EUxFiVTBkR0JvbD1hmTWnggNQaKxWGb3ga1E9/g5e
         68a7tKILjno9xWRk5h3qi0Iy1gpTbo5EPmmxNunk5NC7FBXnH151i+o26FDDpoK0jki2
         bELlxOhMP5v3zfH/hr9oLK9Mmll6lS6bLbW2AGWuvkhMKAhgVtsqxPhgRLy5WCnEm8QG
         UMrA==
X-Gm-Message-State: ANoB5pn0VY/o4qX7hYYLCY5S3Y12GlKZVAPw5iq5Tdj9EZD6Lzs+Tq4M
        sy0rp7WlbwbEXllM8GDdiAxL5tThiYq88A==
X-Google-Smtp-Source: AA0mqf6ZL8FmMgQ1Z7gQccrehDQhUWdMkI2RboZSu6xgHS0hJDwtdHLwFvHZ5ygOTKnEFr+nFIbjEQ==
X-Received: by 2002:ac8:598a:0:b0:3a5:a09e:4154 with SMTP id e10-20020ac8598a000000b003a5a09e4154mr136491qte.160.1667836521282;
        Mon, 07 Nov 2022 07:55:21 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id u11-20020a05622a17cb00b003972790deb9sm6309617qtk.84.2022.11.07.07.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:55:20 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        andy.shevchenko@gmail.com, mdudek@internships.antmicro.com,
        paulus@ozlabs.org
Subject: [PATCH] mmc: litex_mmc: ensure `host->irq == 0` if polling
Date:   Mon,  7 Nov 2022 10:55:16 -0500
Message-Id: <20221107155516.2535912-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Ensure the flag is explicitly set to 0 if we determine that polling is
needed during driver probe, to cover all possible cases.

Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/mmc/host/litex_mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index 6ba0d63b8c07..39c6707fdfdb 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -502,6 +502,7 @@ static int litex_mmc_irq_init(struct platform_device *pdev,
 
 use_polling:
 	host->mmc->caps |= MMC_CAP_NEEDS_POLL;
+	host->irq = 0;
 	return 0;
 }
 
-- 
2.37.3

