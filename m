Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3E9622110
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiKIA4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKIA4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:56:39 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09216657E4;
        Tue,  8 Nov 2022 16:56:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j15so23545098wrq.3;
        Tue, 08 Nov 2022 16:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7fTAhiVVxrQpabu/VwldyEMjHFg35hTidaLAfmWyILs=;
        b=ltKPNbDkcoBF9CoEybhxzda6g14YIAaFtjWpGmKTFx6btvvsfHce2ZyLfLv6U4uO8e
         NyC/vzlFec2xZEQCZCEEbqZSDgBJJLDNvmoTA4qrphn4oK6iVHW561Zc2l90FQahakV2
         I0zIh7r/K0uutn0AKOlwcWK8RAEWzVF50Q8gxjvvyMXCAbfir3M/OJKMV3UssPkcSF4w
         UhT0bNQUaSAjWVjsVLWJ91hJVKpjieg3IKjaqBD9r17LlLIwhBrbiQsSZnb3Z82F9Kiy
         ZyGYAkTxrO5NwjkkN7XMwcAQrDN2Uwhd1eHWkJyhVLk9VWbEH9AeQjk+PYhbA/MgPd6y
         RnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fTAhiVVxrQpabu/VwldyEMjHFg35hTidaLAfmWyILs=;
        b=2TkpZWZca5Ln857sklSYbe4ljVGNGNwSPrM+lJJkl6ATSQ5w7N04ZkcHhjgSwxjaoZ
         NOjTHqZQPgix1zM3HxysTM+ATD1wXrW81AoSmEOticzH2wvjT+rcMcNr1k170bfozqCZ
         X8PiZArCMOiSyOih+nurDK0Aw2VmG7Sf7xR7uSiBnsvdhAOAwFnluWeFLKm9ORHpbeNh
         /Gfs5twkGYRDzqUX/QICLe4klubtYl4hvHEsQaFUR9efwXsdqP6gEYrhnM1+9DX2ydgh
         ZBTXiNTrTkzsNOuV8VBO7VqAPBKM4xq44mnBNPEJYFx3/RalReHPcPMW4Y3WodPWjEt6
         NlhQ==
X-Gm-Message-State: ANoB5pm+l0ezJ295fOpnWUu4zY/NOn9HXBW4E9CBshDH6R3hKAkBDccQ
        0VyQvYnFRjav7H5yq0p1Zl0=
X-Google-Smtp-Source: AA0mqf63/8Ai37dHoH3Ly3mVPXe2aUflPnIghx200bdBRun0aFLppTePp+v/5LgDzz8FhIYbfdw59w==
X-Received: by 2002:a05:6000:705:b0:23d:7ee7:67ed with SMTP id bs5-20020a056000070500b0023d7ee767edmr13163342wrb.352.1667955396377;
        Tue, 08 Nov 2022 16:56:36 -0800 (PST)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id z14-20020adff74e000000b0022cdb687bf9sm14130285wrp.0.2022.11.08.16.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:56:35 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/5] clk: qcom: krait-cc: fix wrong parent order for secondary mux
Date:   Wed,  9 Nov 2022 01:56:27 +0100
Message-Id: <20221109005631.3189-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
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

The secondary mux parent order is swapped.
This currently doesn't cause problems as the secondary mux is used for idle
clk and as a safe clk source while reprogramming the hfpll.

Each mux have 2 or more output but he always have a safe source to
switch while reprogramming the connected pll. We use a clk notifier to
switch to the correct parent before clk core can apply the correct rate.
The parent to switch is hardcoded in the mux struct.

For the secondary mux the safe source to use is the qsb parent as it's
the only fixed clk as the acpus_aux is a pll that can source from pxo or
from pll8.

The hardcoded safe parent for the secondary mux is set to index 0 that
in the secondary mux map is set to 2.

But the index 0 is actually acpu_aux in the parent list.

Fix the swapped parents to correctly handle idle frequency and output a
sane clk_summary report.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index cfd961d5cc45..c2a261cfeb6a 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -116,8 +116,8 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 	int ret;
 	struct krait_mux_clk *mux;
 	static const char *sec_mux_list[] = {
-		"acpu_aux",
 		"qsb",
+		"acpu_aux",
 	};
 	struct clk_init_data init = {
 		.parent_names = sec_mux_list,
-- 
2.37.2

