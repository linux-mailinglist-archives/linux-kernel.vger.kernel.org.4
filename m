Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A226B8205
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCMUAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCMUAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:00:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCC77F00A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t11so17222576lfr.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678737611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LG9NJ+7VzcSXixzcJuGz/otV9zl3aRjMN7yJDrw95Iw=;
        b=b/z9VX0t/E5CFoDxX4tZqENYL46VomKqx5y8vHR1zjryCVsXbRE5Yg2rELkJ+U03sj
         IT4YFr4ZN0p+U+ufJeMSIJeFAkLp5mVAqOCWqofSZjoWONUWv55i0LwaLnLvYAEST1a8
         kBHjIHbAurfUKInww8klUJHgfc6+NeovhhbheuyqPgE0ww4OzMFpWcsHQu/X9Eiq+Xts
         v5/Gd485oIwFWXetqJHbiwDEA36uBWyrDqX2lK73KGVFtddLqTIVnBTkzGpELWuZyRpu
         nhBaVRK/UulrYqumG5+fkx7hk70aYhwBXYHa+iyBxws1dXgmzWk+Z76Wb+7WO/l8dfic
         BQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LG9NJ+7VzcSXixzcJuGz/otV9zl3aRjMN7yJDrw95Iw=;
        b=svIpl0rGKA2gTz7TMissFIsv25u28Kk7PdMk3K0JfYt4ZKjtyYuOlb+M5Je1g2Osyk
         BLQNPkxjsXElmj+i+MiU1PNkTwbAbTFe54/bgBwX6XMSryEc8oJbTC+nqExSuT5K6iZe
         8c1vyrJyx88Xs7kJYydcqnVyLEFl+Laqc9CSyehfeeiRdjDNRq8r7icBJfXTgjfAoq/Z
         qXiMRb9mlkUwQHJVNqv1p4638GifpYjFA4dgV7h9ZgwRrooktb+8574aXRO8mzTtqQAR
         euBC/WozoVB4KnDdMxua6pYNL0S6IRZRfadtCgdk9D8mpEqlhT2fdt0glpppGaqpfu+U
         eVFA==
X-Gm-Message-State: AO0yUKU9TgPXxMTOD6VjxLQariL8YuQAtCVzNVOk4Sr4joNjtWzADKgh
        bbT08HN6eQcfvzqNns3iwEkXDA==
X-Google-Smtp-Source: AK7set9WRs08poOLGJgXFQ0ZTgpY6cEr3f76a+wNw14e3b74Du0mIhTL6g5pPvry4KZt3Pj6cf5Cew==
X-Received: by 2002:a19:a416:0:b0:4e1:8309:1db5 with SMTP id q22-20020a19a416000000b004e183091db5mr10137419lfc.2.1678737611255;
        Mon, 13 Mar 2023 13:00:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w3-20020ac254a3000000b004cc800b1f2csm75431lfk.238.2023.03.13.13.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:00:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 21:00:03 +0100
Subject: [PATCH v3 05/10] soc: qcom: rpmpd: Expand struct definition macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-rpmpd-v3-5-06a4f448ff90@linaro.org>
References: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
In-Reply-To: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678737603; l=13996;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=LqNYONkOs5cm7veJYbA2qMFrHJFjySasIXFxZdAbdrY=;
 b=gSRaUOsCkVSMgeAj4lBzicnESuk2deZzeseUqUR+ePeKEz+VEjFLps50BWfTuM9iiovTqPC9dNZs
 3BGUFV5JDasp53KcaQyhntS6ENzMkO3rkfHXR2gibvrh6sfJSpXN
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the struct definition macros to make things easier to see and
maintain. Now that the macros are unnecessary, remove them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 539 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 441 insertions(+), 98 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 8f145663af9a..df4e0d8a2aa9 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -40,56 +40,6 @@
 
 #define MAX_CORNER_RPMPD_STATE	6
 
-#define DEFINE_RPMPD_PAIR(_name, _active, r_type, r_key, r_id)		\
-	static struct rpmpd r_type##r_id##_##r_key##_##_active;			\
-	static struct rpmpd r_type##r_id##_##r_key##_##_name = {			\
-		.pd = {	.name = #_name,	},				\
-		.peer = &r_type##r_id##_##r_key##_##_active,				\
-		.res_type = RPMPD_##r_type,				\
-		.res_id = r_id,						\
-		.key = KEY_##r_key,					\
-	};								\
-	static struct rpmpd r_type##r_id##_##r_key##_##_active = {			\
-		.pd = { .name = #_active, },				\
-		.peer = &r_type##r_id##_##r_key##_##_name,				\
-		.active_only = true,					\
-		.res_type = RPMPD_##r_type,				\
-		.res_id = r_id,						\
-		.key = KEY_##r_key,					\
-	}
-
-#define DEFINE_RPMPD_CORNER(_name, r_type, r_id)			\
-	static struct rpmpd r_type##r_id##_##_name##_corner = {			\
-		.pd = { .name = #_name, },				\
-		.res_type = RPMPD_##r_type,				\
-		.res_id = r_id,						\
-		.key = KEY_CORNER,					\
-	}
-
-#define DEFINE_RPMPD_LEVEL(_name, r_type, r_id)				\
-	static struct rpmpd r_type##r_id##_##_name##_lvl = {			\
-		.pd = { .name = #_name, },				\
-		.res_type = RPMPD_##r_type,				\
-		.res_id = r_id,						\
-		.key = KEY_LEVEL,					\
-	}
-
-#define DEFINE_RPMPD_VFC(_name, r_type, r_id)				\
-	static struct rpmpd r_type##r_id##_##_name = {			\
-		.pd = { .name = #_name, },				\
-		.res_type = RPMPD_##r_type,				\
-		.res_id = r_id,						\
-		.key = KEY_FLOOR_CORNER,				\
-	}
-
-#define DEFINE_RPMPD_VFL(_name, r_type, r_id)				\
-	static struct rpmpd r_type##r_id##_##_name = {			\
-		.pd = { .name = #_name, },				\
-		.res_type = RPMPD_##r_type,				\
-		.res_id = r_id,						\
-		.key = KEY_FLOOR_LEVEL,					\
-	}
-
 struct rpmpd_req {
 	__le32 key;
 	__le32 nbytes;
@@ -117,54 +67,447 @@ struct rpmpd_desc {
 
 static DEFINE_MUTEX(rpmpd_lock);
 
-DEFINE_RPMPD_PAIR(cx, cx_ao, RWCX, LEVEL, 0);
-DEFINE_RPMPD_PAIR(cx, cx_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_PAIR(cx, cx_ao, SMPA, CORNER, 2);
-DEFINE_RPMPD_PAIR(cx, cx_ao, SMPA, LEVEL, 2);
-DEFINE_RPMPD_PAIR(cx, cx_ao, SMPA, LEVEL, 3);
-DEFINE_RPMPD_VFL(cx_vfl, RWCX, 0);
-DEFINE_RPMPD_VFL(cx_vfl, RWSC, 2);
-DEFINE_RPMPD_VFC(cx_vfc, SMPA, 1);
-DEFINE_RPMPD_VFC(cx_vfc, SMPA, 2);
-DEFINE_RPMPD_VFL(cx_vfl, SMPA, 2);
-DEFINE_RPMPD_VFL(cx_vfl, SMPA, 3);
-
-DEFINE_RPMPD_CORNER(gfx, SMPB, 2);
-DEFINE_RPMPD_VFC(gfx_vfc, SMPB, 2);
-
-DEFINE_RPMPD_PAIR(gx, gx_ao, RWGX, LEVEL, 0);
-
-DEFINE_RPMPD_PAIR(mx, mx_ao, LDOA, CORNER, 3);
-DEFINE_RPMPD_PAIR(mx, mx_ao, LDOA, LEVEL, 12);
-DEFINE_RPMPD_PAIR(mx, mx_ao, SMPA, CORNER, 2);
-DEFINE_RPMPD_PAIR(mx, mx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_PAIR(mx, mx_ao, SMPA, LEVEL, 6);
-DEFINE_RPMPD_PAIR(mx, mx_ao, SMPA, LEVEL, 7);
-DEFINE_RPMPD_VFL(mx_vfl, LDOA, 12);
-DEFINE_RPMPD_VFL(mx_vfl, RWMX, 0);
-DEFINE_RPMPD_VFL(mx_vfl, RWSM, 6);
-
-DEFINE_RPMPD_PAIR(md, md_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_PAIR(md, md_ao, SMPA, LEVEL, 1);
-DEFINE_RPMPD_VFC(md_vfc, SMPA, 1);
-
-DEFINE_RPMPD_LEVEL(lpi_cx, RWLC, 0);
-DEFINE_RPMPD_VFL(lpicx_vfl, RWLC, 0);
-
-DEFINE_RPMPD_LEVEL(lpi_mx, RWLM, 0);
-DEFINE_RPMPD_VFL(lpimx_vfl, RWLM, 0);
-
-DEFINE_RPMPD_CORNER(sscx, LDOA, 26);
-DEFINE_RPMPD_LEVEL(ssccx, RWLC, 0);
-DEFINE_RPMPD_LEVEL(ssccx, RWSC, 0);
-DEFINE_RPMPD_VFC(sscx_vfc, LDOA, 26);
-DEFINE_RPMPD_VFL(ssccx_vfl, RWLC, 0);
-DEFINE_RPMPD_VFL(ssccx_vfl, RWSC, 0);
-
-DEFINE_RPMPD_LEVEL(sscmx, RWLM, 0);
-DEFINE_RPMPD_LEVEL(sscmx, RWSM, 0);
-DEFINE_RPMPD_VFL(sscmx_vfl, RWLM, 0);
-DEFINE_RPMPD_VFL(sscmx_vfl, RWSM, 0);
+/* CX */
+static struct rpmpd RWCX0_LEVEL_cx_ao;
+static struct rpmpd RWCX0_LEVEL_cx = {
+	.pd = { .name = "cx", },
+	.peer = &RWCX0_LEVEL_cx_ao,
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd RWCX0_LEVEL_cx_ao = {
+	.pd = { .name = "cx_ao", },
+	.peer = &RWCX0_LEVEL_cx,
+	.active_only = true,
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd SMPA1_CORNER_cx_ao;
+static struct rpmpd SMPA1_CORNER_cx = {
+	.pd = { .name = "cx", },
+	.peer = &SMPA1_CORNER_cx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd SMPA1_CORNER_cx_ao = {
+	.pd = { .name = "cx_ao", },
+	.peer = &SMPA1_CORNER_cx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd SMPA2_CORNER_cx_ao;
+static struct rpmpd SMPA2_CORNER_cx = {
+	.pd = { .name = "cx", },
+	.peer = &SMPA2_CORNER_cx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd SMPA2_CORNER_cx_ao = {
+	.pd = { .name = "cx_ao", },
+	.peer = &SMPA2_CORNER_cx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd SMPA2_LEVEL_cx_ao;
+static struct rpmpd SMPA2_LEVEL_cx = {
+	.pd = { .name = "cx", },
+	.peer = &SMPA2_LEVEL_cx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd SMPA2_LEVEL_cx_ao = {
+	.pd = { .name = "cx_ao", },
+	.peer = &SMPA2_LEVEL_cx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd SMPA3_LEVEL_cx_ao;
+static struct rpmpd SMPA3_LEVEL_cx = {
+	.pd = { .name = "cx", },
+	.peer = &SMPA3_LEVEL_cx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 3,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd SMPA3_LEVEL_cx_ao = {
+	.pd = { .name = "cx_ao", },
+	.peer = &SMPA3_LEVEL_cx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 3,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd RWCX0_cx_vfl = {
+	.pd = { .name = "cx_vfl", },
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd RWSC2_cx_vfl = {
+	.pd = { .name = "cx_vfl", },
+	.res_type = RPMPD_RWSC,
+	.res_id = 2,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd SMPA1_cx_vfc = {
+	.pd = { .name = "cx_vfc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_FLOOR_CORNER,
+};
+
+static struct rpmpd SMPA2_cx_vfc = {
+	.pd = { .name = "cx_vfc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_FLOOR_CORNER,
+};
+
+static struct rpmpd SMPA2_cx_vfl = {
+	.pd = { .name = "cx_vfl", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd SMPA3_cx_vfl = {
+	.pd = { .name = "cx_vfl", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 3,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+/* G(F)X */
+static struct rpmpd SMPB2_gfx_corner = {
+	.pd = { .name = "gfx", },
+	.res_type = RPMPD_SMPB,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd SMPB2_gfx_vfc = {
+	.pd = { .name = "gfx_vfc", },
+	.res_type = RPMPD_SMPB,
+	.res_id = 2,
+	.key = KEY_FLOOR_CORNER,
+};
+
+static struct rpmpd RWGX0_LEVEL_gx_ao;
+static struct rpmpd RWGX0_LEVEL_gx = {
+	.pd = { .name = "gx", },
+	.peer = &RWGX0_LEVEL_gx_ao,
+	.res_type = RPMPD_RWGX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd RWGX0_LEVEL_gx_ao = {
+	.pd = { .name = "gx_ao", },
+	.peer = &RWGX0_LEVEL_gx,
+	.active_only = true,
+	.res_type = RPMPD_RWGX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+/* MX */
+static struct rpmpd LDOA3_CORNER_mx_ao;
+static struct rpmpd LDOA3_CORNER_mx = {
+	.pd = { .name = "mx", },
+	.peer = &LDOA3_CORNER_mx_ao,
+	.res_type = RPMPD_LDOA,
+	.res_id = 3,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd LDOA3_CORNER_mx_ao = {
+	.pd = { .name = "mx_ao", },
+	.peer = &LDOA3_CORNER_mx,
+	.active_only = true,
+	.res_type = RPMPD_LDOA,
+	.res_id = 3,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd LDOA12_LEVEL_mx_ao;
+static struct rpmpd LDOA12_LEVEL_mx = {
+	.pd = { .name = "mx", },
+	.peer = &LDOA12_LEVEL_mx_ao,
+	.res_type = RPMPD_LDOA,
+	.res_id = 12,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd LDOA12_LEVEL_mx_ao = {
+	.pd = { .name = "mx_ao", },
+	.peer = &LDOA12_LEVEL_mx,
+	.active_only = true,
+	.res_type = RPMPD_LDOA,
+	.res_id = 12,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd SMPA2_CORNER_mx_ao;
+static struct rpmpd SMPA2_CORNER_mx = {
+	.pd = { .name = "mx", },
+	.peer = &SMPA2_CORNER_mx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd SMPA2_CORNER_mx_ao = {
+	.pd = { .name = "mx_ao", },
+	.peer = &SMPA2_CORNER_mx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd RWMX0_LEVEL_mx_ao;
+static struct rpmpd RWMX0_LEVEL_mx = {
+	.pd = { .name = "mx", },
+	.peer = &RWMX0_LEVEL_mx_ao,
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd RWMX0_LEVEL_mx_ao = {
+	.pd = { .name = "mx_ao", },
+	.peer = &RWMX0_LEVEL_mx,
+	.active_only = true,
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd SMPA6_LEVEL_mx_ao;
+static struct rpmpd SMPA6_LEVEL_mx = {
+	.pd = { .name = "mx", },
+	.peer = &SMPA6_LEVEL_mx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 6,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd SMPA6_LEVEL_mx_ao = {
+	.pd = { .name = "mx_ao", },
+	.peer = &SMPA6_LEVEL_mx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 6,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd SMPA7_LEVEL_mx_ao;
+static struct rpmpd SMPA7_LEVEL_mx = {
+	.pd = { .name = "mx", },
+	.peer = &SMPA7_LEVEL_mx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 7,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd SMPA7_LEVEL_mx_ao = {
+	.pd = { .name = "mx_ao", },
+	.peer = &SMPA7_LEVEL_mx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 7,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd LDOA12_mx_vfl = {
+	.pd = { .name = "mx_vfl", },
+	.res_type = RPMPD_LDOA,
+	.res_id = 12,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd RWMX0_mx_vfl = {
+	.pd = { .name = "mx_vfl", },
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd RWSM6_mx_vfl = {
+	.pd = { .name = "mx_vfl", },
+	.res_type = RPMPD_RWSM,
+	.res_id = 6,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+/* MD */
+static struct rpmpd SMPA1_CORNER_md_ao;
+static struct rpmpd SMPA1_CORNER_md = {
+	.pd = { .name = "md", },
+	.peer = &SMPA1_CORNER_md_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd SMPA1_CORNER_md_ao = {
+	.pd = { .name = "md_ao", },
+	.peer = &SMPA1_CORNER_md,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd SMPA1_LEVEL_md_ao;
+static struct rpmpd SMPA1_LEVEL_md = {
+	.pd = { .name = "md", },
+	.peer = &SMPA1_LEVEL_md_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd SMPA1_LEVEL_md_ao = {
+	.pd = { .name = "md_ao", },
+	.peer = &SMPA1_LEVEL_md,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd SMPA1_md_vfc = {
+	.pd = { .name = "md_vfc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_FLOOR_CORNER,
+};
+
+/* LPI_CX */
+static struct rpmpd RWLC0_lpi_cx_lvl = {
+	.pd = { .name = "lpi_cx", },
+	.res_type = RPMPD_RWLC,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd RWLC0_lpicx_vfl = {
+	.pd = { .name = "lpicx_vfl", },
+	.res_type = RPMPD_RWLC,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+/* LPI_MX */
+static struct rpmpd RWLM0_lpi_mx_lvl = {
+	.pd = { .name = "lpi_mx", },
+	.res_type = RPMPD_RWLM,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd RWLM0_lpimx_vfl = {
+	.pd = { .name = "lpimx_vfl", },
+	.res_type = RPMPD_RWLM,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+/* SSC_CX */
+static struct rpmpd LDOA26_sscx_corner = {
+	.pd = { .name = "sscx", },
+	.res_type = RPMPD_LDOA,
+	.res_id = 26,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd RWLC0_ssccx_lvl = {
+	.pd = { .name = "ssccx", },
+	.res_type = RPMPD_RWLC,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd RWSC0_ssccx_lvl = {
+	.pd = { .name = "ssccx", },
+	.res_type = RPMPD_RWSC,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd LDOA26_sscx_vfc = {
+	.pd = { .name = "sscx_vfc", },
+	.res_type = RPMPD_LDOA,
+	.res_id = 26,
+	.key = KEY_FLOOR_CORNER,
+};
+
+static struct rpmpd RWLC0_ssccx_vfl = {
+	.pd = { .name = "ssccx_vfl", },
+	.res_type = RPMPD_RWLC,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd RWSC0_ssccx_vfl = {
+	.pd = { .name = "ssccx_vfl", },
+	.res_type = RPMPD_RWSC,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+/* SSC_MX */
+static struct rpmpd RWLM0_sscmx_lvl = {
+	.pd = { .name = "sscmx", },
+	.res_type = RPMPD_RWLM,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd RWSM0_sscmx_lvl = {
+	.pd = { .name = "sscmx", },
+	.res_type = RPMPD_RWSM,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd RWLM0_sscmx_vfl = {
+	.pd = { .name = "sscmx_vfl", },
+	.res_type = RPMPD_RWLM,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd RWSM0_sscmx_vfl = {
+	.pd = { .name = "sscmx_vfl", },
+	.res_type = RPMPD_RWSM,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
 
 /* mdm9607 RPM Power Domains */
 static struct rpmpd *mdm9607_rpmpds[] = {

-- 
2.39.2

