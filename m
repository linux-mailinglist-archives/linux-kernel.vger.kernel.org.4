Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E64A737596
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjFTUES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjFTUDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251EB1985
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a5eec783cso2940474a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291422; x=1689883422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhgdg4E3TDsPGYojFdzrWAXjpzqjE4U2T6j3QbwzmRg=;
        b=BUdPTgPQ9aBRs7OgBGVW3mzGqrEDBrZd9omeMyypo9a6JXXCaFbCPz1bM82876+1xh
         IdDHeEGb1aL6at9MG4e5u8VewpP6jh0aumkA31H8fNLSmxo/f/u9gi5bdh7FVva6sRw7
         FhoLZFh5kn2FABmEGnVpBNhCFx21+Is2EQhh6kMSoqrgUqKYTv5Z1v6WqAdkouo+X43T
         0ev5vLpuy6KrT4Wq95jL+Uvfa/NYGKmoWEV5K2rg/zClW53vPpsntfjkwpRQSouZB0Md
         O4aO22oz8JvsKeAPjdsMxMXMWGiXj+seC1WT5pbh3A63TaFbl7rm791ZE2PLWFvm8Bm7
         Wwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291422; x=1689883422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhgdg4E3TDsPGYojFdzrWAXjpzqjE4U2T6j3QbwzmRg=;
        b=b6yXaNo36D4WIG/0Rl75AeYROFoxdIfTpDPYo4C4YthCj9RyQ9GhN4NPNt3xGUKI1S
         B+Nk59jWvIGtPWUtP7PbGqlU1gZWCUldRCNxzN2nppH5kPlWR1wDVOUQulo1pphlvLyp
         64050THUVM8X3hJvC1DiNU5pPOW11XosHxcbk4BNJvp4ASdUN/4GtZG+cMZN8l5801G3
         BP/EHMjHIzT/xO3om1bh3vFOtDQIW3B1dH8lNMzKWRemwqw4p/HHP+i3eQOFHPBoB3jJ
         HezjQqvvXkT83uU8qLbfVk3bwz+ST3PEo2flVszlgNhjkbHB49JhAIwLcI8grMLscEG+
         pr8Q==
X-Gm-Message-State: AC+VfDwH+JvC4izyAB/O9VQ8tFGtORyCHPcliAKu+5nUJvRqRSwMHExS
        WeCYpTNuatkzvuxPK0ADEJI=
X-Google-Smtp-Source: ACHHUZ7n2toVmG7JNKrk0hJckH1nNmM0+5Mwlexgev19xhM0QWQYHR9f1tsL/zEtIjlx5InukNs/xA==
X-Received: by 2002:a17:907:728b:b0:988:e0cd:99c4 with SMTP id dt11-20020a170907728b00b00988e0cd99c4mr4431959ejc.31.1687291422599;
        Tue, 20 Jun 2023 13:03:42 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:42 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:03:04 +0200
Subject: [PATCH RFC v4 11/13] regulator: implement
 mon_unsupported_reg_modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-11-4d3734e62ada@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The mon_unsupported_reg_modes property disables all dt-enabled monitors
when the mode of the regulator is changed to an "unsupported" one.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 74b9c12d38e9..ca768d0ddb1e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4816,8 +4816,21 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode)
 	if (ret < 0)
 		goto out;
 
+	if (mode & rdev->desc->mon_unsupported_reg_modes) {
+		ret = monitors_disable(rdev, REGULATOR_MONITOR_ALL);
+		if (ret)
+			goto out;
+	}
+
 	ret = rdev->desc->ops->set_mode(rdev, mode);
+
 out:
+	/* if changing mode failed, ignore monitoring error. */
+	if (ret)
+		monitors_reenable(rdev, REGULATOR_MONITOR_ALL);
+	else
+		ret = monitors_reenable(rdev, REGULATOR_MONITOR_ALL);
+
 	regulator_unlock(rdev);
 	return ret;
 }

-- 
2.34.1

