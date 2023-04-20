Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D516E9043
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjDTKcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjDTKcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:32:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A436EA5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:29:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sz19so5313430ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681986575; x=1684578575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCMVkpoP7P7euBZsvjuYLebPu+RHVGj5VTI8fVvSq8I=;
        b=fW1vi4Ep/+Nr4f2fL7p3gXV4LCYyBm2gcMqNENhN3/bPx8YBwQAHRzTpZ2A44ibLNj
         5QP6lWB3tuuobHnE8gSBfNCVpIy9LEZ8OuJ/3I3ArqUG9YWC1m4+TUzPSnTV+Dg70UZO
         IFNr+paEoUVj6joKH2W4OGJrGFGuyDgDJ0m2NDQS/HnovOrmA4VBBJs9Y86P27ShVPW7
         Sc5tEl+mrCksqhlw8wg8BTK0A76VNnnk1O8dhPQfDPFVXQJn7IXf/NaaWAsct30HTidq
         XsqMlVQUQYRM0V+faK+6UolLxM8saghWvNkC/i7ZHhFNwWYJaQ/k+VaRhGw0WVFknDSn
         6m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681986575; x=1684578575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCMVkpoP7P7euBZsvjuYLebPu+RHVGj5VTI8fVvSq8I=;
        b=bwnQF4QhT+BjC4U++2C/5zEYD4GFZfRqT5U5CXw8NTUo4bESCOfWB2trkeAz+1oRj4
         OyxlVd3nLB1/ajSoeimppm3ivcYg8/nJNxNHBZsyKOipb449Um/vuXqSDkk7L4oly/dm
         yR0v/CP9/6VkGfPr0aQ+AVVoQ1MkWfO9+y0XQ1jWyZnOPFdLFMtxsxlDHGJRmGJFW3lB
         JeDEK088gZpcekl0cPymR22wVdRBSlsEAcyEYq85k/pPTHXNMIjZ8/17MGcgYopi1J2M
         fPNxtkLnyOa7scBj4fjq/+39yw+CibYyNAwd3fEdFbIkFp/3jNriT+9eKsqUa+eCnvwO
         CsQw==
X-Gm-Message-State: AAQBX9cRY66V0rk0WUHdwJVpRsWTbrUV9RIyY2hR1M6WO954mp34ii3S
        mHmiq0uQ/PjDoIJhF81tLEw=
X-Google-Smtp-Source: AKy350ZgV/oAlSpREEAwqEPnZCT7/Ie3aR4e2EMNQUQMHHC3S/7vG34f190N4I+rHkcCdgx5YpLqNA==
X-Received: by 2002:a17:907:3ac5:b0:8ae:11ca:81de with SMTP id fi5-20020a1709073ac500b008ae11ca81demr1070910ejc.34.1681986575115;
        Thu, 20 Apr 2023 03:29:35 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090694d500b0094efe88a037sm584512ejy.9.2023.04.20.03.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:29:34 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 20 Apr 2023 12:29:21 +0200
Subject: [PATCH RFC 2/2] regulator: da9063: disable monitoring while
 regulator is off
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v1-2-f48b7438e891@skidata.com>
References: <20230419-dynamic-vmon-v1-0-f48b7438e891@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v1-0-f48b7438e891@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, support.opensource@diasemi.com
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com,
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

The PWR_OK state of the da9063 indicates whether all monitored voltages
are within the expected range. When a regulator is disabled without
disabling its voltage monitor before, the PWR_OK state becomes false. On
our board, this invalid state leads to a hard reset.

Therefore, prevent the invalid state by disabling the monitor before the
regulator is disabled.

This still requires to explicitly enable the voltage monitor in the
device tree and has no impact otherwise.

TODO: clarify if a MODE change has impact on the voltage monitor

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/da9063-regulator.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 82f52a2a031a..0fa320abad93 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -713,14 +713,27 @@ static irqreturn_t da9063_ldo_lim_event(int irq, void *data)
 /*
  * Probing and Initialisation functions
  */
+
+/* prevent !PWR_OK state by disabling monitoring while regulator is off. */
+static const struct monitoring_constraints da9063_vmon_constraints = {
+	.mon_disable_during_reg_off = 1,
+};
+
 static const struct regulator_init_data *da9063_get_regulator_initdata(
 		const struct da9063_regulators_pdata *regl_pdata, int id)
 {
+	struct regulator_init_data *initdata;
+	struct regulation_constraints *reg_constr;
 	int i;
 
 	for (i = 0; i < regl_pdata->n_regulators; i++) {
-		if (id == regl_pdata->regulator_data[i].id)
-			return regl_pdata->regulator_data[i].initdata;
+		if (id == regl_pdata->regulator_data[i].id) {
+			initdata = regl_pdata->regulator_data[i].initdata;
+			reg_constr = &initdata->constraints;
+			reg_constr->ov_constraints = &da9063_vmon_constraints;
+			reg_constr->uv_constraints = &da9063_vmon_constraints;
+			return initdata;
+		}
 	}
 
 	return NULL;

-- 
2.34.1

