Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1DF712C34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjEZSH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242167AbjEZSHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:07:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACAF13A;
        Fri, 26 May 2023 11:07:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-969f90d71d4so145760966b.3;
        Fri, 26 May 2023 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685124468; x=1687716468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WNhXWuAHGSvY84FPzjUJiY/WdxRG1SooFMStX8dS0s=;
        b=p076qqBSbmH95CyWYwmxDLH1EofZTcSiQwfiZ/E2g+jrabSJlxYZAL8tW5SovUU0kl
         yLBT6ySFrxmU6QBCoG+/w9wNaXrhM6kSFDav/FoWx57bbKxeMC0zSf+jgfbdaSbCA3D0
         +yyffE5niZ+54MJDvnh3PdrOH51yGAGIzB7/3QNQ9Vr4IUFQ35ESQj8Z0XaViynvnlxD
         43tGsEqpLFaW5vnMFYkdhgIpzXE9nJHz7Om8Y+Iqbjhb0JIWkbGOT0+QPUmAH3MS0mdT
         RRtORElzNkNcV286rOehX3U5leti+tVt6mhHQOhvu8Sgf3XWJhh3VUoBFjV2kKEfDLBo
         A1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685124468; x=1687716468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WNhXWuAHGSvY84FPzjUJiY/WdxRG1SooFMStX8dS0s=;
        b=bpDjAZWzNOc4UTHUQw0kolOpZDMWgOVOiyQgBt9p8Zaf0BIemJLHoAjPy6mEgfkDLi
         GCrgD/OjBTNu+7Wy3z+vspT8o4Ma/swLS6rU3orcX/jlPBmXVtIzWtazHwhtZm8MmzvE
         uFVnbt5UM1earM+LeR2y2fQNmwtQGDiPBemZWPyZ6U0cE5QEpl5PvDcGjTUmrugH3sJp
         FwOx5ZVJd3G6COzuUOnO5Ss3wi/F/gk6oFKTlkRkLs9CWSXDsfHGNr3LPp/ZCEuZN3fA
         jaIZ0llFENbv5+xIpL7tugR4c9VuqqackLlPeLk5GbwZ5f/9sSX6erAL9lkmTS1PmCfg
         yjcg==
X-Gm-Message-State: AC+VfDxziYzqVdUNNLoC9bmCypCIMneM+k178mf5wpBCxbDsrh+0CfPf
        tPpV+wi31qNMDQ4ZaSNAmz8=
X-Google-Smtp-Source: ACHHUZ7wPGY8XaZ5Q26iK1pWupLRHG9OW5fzWVth17mX8oMMlY9eqhpM3UjCV5KozN8rgYMknhXCcA==
X-Received: by 2002:a17:907:a40d:b0:968:1102:1fb7 with SMTP id sg13-20020a170907a40d00b0096811021fb7mr2680886ejc.6.1685124468084;
        Fri, 26 May 2023 11:07:48 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906410b00b0096f689848desm2410823ejk.195.2023.05.26.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:07:47 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] media: camss: Link CAMSS power domain
Date:   Fri, 26 May 2023 21:07:12 +0300
Message-Id: <20230526180712.8481-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526180712.8481-1-y.oudjana@protonmail.com>
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

The CAMSS power domain was previously enabled implicitly when the VFE
power domains were enabled.
Commit 46cc03175498 ("media: camss: Split power domain management")
delayed enabling VFE power domains which in turn delayed enabling the
CAMSS power domain. This made CSIPHY fail to enable camss_top_ahb_clk
which requires the CAMSS power domain to be on:

[  199.097810] ------------[ cut here ]------------
[  199.097893] camss_top_ahb_clk status stuck at 'off'
[  199.097913] WARNING: CPU: 3 PID: 728 at drivers/clk/qcom/clk-branch.c:91 clk_branch_wait+0x140/0x160
...
[  199.100064]  clk_branch_wait+0x140/0x160
[  199.100112]  clk_branch2_enable+0x30/0x40
[  199.100159]  clk_core_enable+0x6c/0xb0
[  199.100211]  clk_enable+0x2c/0x50
[  199.100257]  camss_enable_clocks+0x94/0xe0 [qcom_camss]
[  199.100342]  csiphy_set_power+0x154/0x2a0 [qcom_camss]
...
[  199.101594] ---[ end trace 0000000000000000 ]---

Link the CAMSS power domain in camss_configure_pd to make sure it gets
enabled before CSIPHY tries to enable clocks.

Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/media/platform/qcom/camss/camss.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 1ef26aea3eae..9aea8220d923 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1453,6 +1453,7 @@ static const struct media_device_ops camss_media_ops = {
 static int camss_configure_pd(struct camss *camss)
 {
 	struct device *dev = camss->dev;
+	int camss_pd_index;
 	int i;
 	int ret;
 
@@ -1496,7 +1497,13 @@ static int camss_configure_pd(struct camss *camss)
 		}
 	}
 
-	if (i > camss->vfe_num) {
+	/* Link CAMSS power domain if available */
+	camss_pd_index = device_property_match_string(camss->dev, "power-domain-names", "camss");
+	if (camss_pd_index >= 0)
+		device_link_add(camss->dev, camss->genpd[camss_pd_index], DL_FLAG_STATELESS |
+				DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+
+	if (i > camss->vfe_num && i != camss_pd_index) {
 		camss->genpd_link[i - 1] = device_link_add(camss->dev, camss->genpd[i - 1],
 							   DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME |
 							   DL_FLAG_RPM_ACTIVE);
-- 
2.40.1

