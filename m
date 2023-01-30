Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2770F68099D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjA3Jes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjA3JeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:34:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE05976E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:32:55 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so10467149pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w06XLuTGv42ExA7kvsEzi3HmqNn0e+XIKH+7gH1xWFk=;
        b=PPfshnuneZVuaGMsWsf0abmeP49jp4AxSkkBj/mh1QI/DzHKXdaR6hl+H+ItCxqyBK
         8EvW4xXW6VegaasREhK2bUhShb9wvty8UOLr3wp/rbISnmKVHRVvA0rpCOSUt0MCj0ZR
         oPhRoLukyOzJLiU4C/lp/aLdGjZGUoPkShPRj19HLGlGJVneY/5JrOxKgYSDAs+kHckA
         ZbAar3Gjnh03WMx7A3k5Ncx3kq8vJdKp0fzptQZusU7UMj0/chZLjSo/ClNBAAPUYkSd
         8bm/XpTxdY/MmYvytxFvGcJV04KPmAG08wqBrYkaeFcuRA8URaK7P1WcmVaJR2IZIpdw
         jMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w06XLuTGv42ExA7kvsEzi3HmqNn0e+XIKH+7gH1xWFk=;
        b=YfFZfKKUvIPcHiSYYWNTwp//vEHixxZ161ii8aDnHEdsGW+qoACooiJPd7edgh1XYT
         09q0ODlqcAtCPs++lcqg2KXHJ3328BPTRdzHer0sejwWVJBDFePcjKD0GgWjV56PPzIM
         QCo5cJxp54BXHzV9r7RzWfCVqfF/5EMW5VbtLbkW8lroTM1WFsIpNdUvCNK6gvGFXyCK
         tYLeNp5fkiuIcv/cT3BWyU5xGI6ivH3Hyt6SsKtyCqueucPCgW7qQl9TUk1qgdc9UCin
         9WfL8SaY7jwqL1PM0qO2Kh+ubjbXudjShmp5eJ6iiLIs3rtfgGNZiUPpV+DIjXCbkfa5
         ug0g==
X-Gm-Message-State: AFqh2kol0n6srg/Ib2UH1kTZbsl+iIuBxQBNYT1Gjc8WJ3ls5Ok0xKdJ
        Ims2+V30UMskhQmPXcn/3wR1rA==
X-Google-Smtp-Source: AMrXdXtS3CCualmkzbk7XdCqctKx3U6p6dFg1oHURin04Tlb0OJZb8OfiFW6kp53r9/H5XL1owCXrw==
X-Received: by 2002:a05:6a20:1596:b0:b8:7905:b6c4 with SMTP id h22-20020a056a20159600b000b87905b6c4mr62293777pzj.61.1675071165340;
        Mon, 30 Jan 2023 01:32:45 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id t13-20020a6564cd000000b004db2b310f95sm6245704pgv.16.2023.01.30.01.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:32:44 -0800 (PST)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nylon.chen@sifive.com, nylon7717@gmail.com, zong.li@sifive.com,
        greentime.hu@sifive.com, vincent.chen@sifive.com
Subject: [PATCH v2 2/2] pwm: sifive: change the PWM controlled LED algorithm
Date:   Mon, 30 Jan 2023 17:32:29 +0800
Message-Id: <20230130093229.27489-3-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230130093229.27489-1-nylon.chen@sifive.com>
References: <20230130093229.27489-1-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `frac` variable represents the pulse inactive time, and the result of
this algorithm is the pulse active time. Therefore, we must reverse the
result.

The reference is SiFive FU740-C000 Manual[0].

[0]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf

Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 62b6acc6373d..a5eda165d071 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -158,6 +158,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
 	/* The hardware cannot generate a 100% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	frac = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
-- 
2.36.1

