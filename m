Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FB26B6ABB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 20:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCLThh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 15:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCLThc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 15:37:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22FC3B205
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 12:37:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id er25so12465618edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678649846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niZ49NwKIKnUlhDrrDMPQvHlix5tiBHxs5a++Iu3kNM=;
        b=dZHBv3fpclRkJpXkr056M8pLpc9EqpXsKdseJZtMtnU7ZcwoW7s/jbN64NjjkJ+qXh
         YaXqtt0pdGcW08FdQwImV3VBXpX/58Oc0WE6Vykgd9iMoUDleWEfykFh0Schb0SLkebH
         i28eX1fQMbIra1SdIFE5BZ/BV7fNPLiTKtl2SpQlbzjwlSlZxsQjrMGeXrTUUuBpHKUA
         2Y4V0D+KsQWWvtKJHMZYgjDGyS0/31xDBsmOfkBFcr+FRBCVlbsEZkj+A0IMLYXOLe4N
         zuFIfqsGR8Vqshfo6aQR098Ak2JgwhxkRNseg5wg6xgT0rTDWENKlzZd9AUS55/qjSSq
         /yLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678649846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niZ49NwKIKnUlhDrrDMPQvHlix5tiBHxs5a++Iu3kNM=;
        b=X/D6tTImwrDg3DknNU8KRXPrn7Ylss10heO0amqyofwnBu8GoULeUYunC1Cc9e1msM
         dToYOF5J/11l1JuHCZ//KibcELmZGNPLR09qmbPACllUEyjDw7nhRuOnt7WrRT9HQLsY
         4X8ykp6oraSvg5X8mqAjiysztdfBCQ8168aaPGONFbhjwREparTcsx2dwHB8m7rpuxD6
         kEo4URpHcLmI+GatqXk1HL0670RrXLr/P3KbsVeSHnJPNnG/TF1Z+4gHR+QjrDYwPuDA
         EnhQ1rQeylNB5kWAAVuT1UgvNqfvuvRPTa9G4NBsxTIDBMA0FMSJO5iXdSY0XrPQmMWD
         hgKQ==
X-Gm-Message-State: AO0yUKUUO5Jf4w757BbuepUTPmKCsWnRoW4EhRFEyC+toS6DC+uFL0sl
        rjvmXubEqB/FYmczz+ep5kjONQ==
X-Google-Smtp-Source: AK7set+ftcd1IvaJjF+eXw7jk202V5krr4p1485X5GA+Fy+U0m2HfnO9bXVBsRzYtuGlgffL3fXTSw==
X-Received: by 2002:a17:907:701:b0:8f3:f976:ac13 with SMTP id xb1-20020a170907070100b008f3f976ac13mr38420621ejb.10.1678649846365;
        Sun, 12 Mar 2023 12:37:26 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id gb17-20020a170907961100b00882f9130eafsm2526071ejc.26.2023.03.12.12.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 12:37:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] hwmon: tmp512: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 20:37:23 +0100
Message-Id: <20230312193723.478032-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312193723.478032-1-krzysztof.kozlowski@linaro.org>
References: <20230312193723.478032-1-krzysztof.kozlowski@linaro.org>
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

The driver will match mostly by DT table (even thought there is regular
ID table) so there is little benefit in of_match_ptr (this also allows
ACPI matching via PRP0001, even though it might not be relevant here).
This also fixes !CONFIG_OF error:

  drivers/hwmon/tmp513.c:610:34: error: ‘tmp51x_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Rework patch and commit msg - drop of_match_ptr.
---
 drivers/hwmon/tmp513.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index 47bbe47e062f..7d5f7441aceb 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -758,7 +758,7 @@ static int tmp51x_probe(struct i2c_client *client)
 static struct i2c_driver tmp51x_driver = {
 	.driver = {
 		.name	= "tmp51x",
-		.of_match_table = of_match_ptr(tmp51x_of_match),
+		.of_match_table = tmp51x_of_match,
 	},
 	.probe_new	= tmp51x_probe,
 	.id_table	= tmp51x_id,
-- 
2.34.1

