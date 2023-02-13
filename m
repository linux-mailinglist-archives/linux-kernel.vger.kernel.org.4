Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C0E69482B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBMOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjBMOfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:35:39 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B846716325
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:35:36 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qb15so30309431ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1AUm79K5qRxcoKaBb2AFl12FqpHDk2GXzyUEMzaXfs=;
        b=QRoN/kGTukq67Xj76EPDFHxZz/osow5g6l/5SQcjTmU2XN0wQSQNYO+lyBx3R1qHdY
         3hG6Oq4DTkCn0lxGbN0T7tsL6q/VVDgJrmcX7d1ByAueGfLBnKsor2vi3u34xl79cn0l
         FThOyNwr4LQzYg97g2nIip5NiGfLzsKMhSnAxNmcytvHF+WoI8kJeRil81rjWIOAXS1i
         tCv5RkDZMbYjPrFki8/sCbhqSSGRJEXIXPeF3wxB3dUp+a+FmfmkH2dgs9n7s5ZB3HmM
         GFAxq/Zdu7ZUhewdhqAv1BGyPvtoOJ7UCf8oc7Ryetkw8/LZHOdCRdNeHmuKfJgdEGQo
         KRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1AUm79K5qRxcoKaBb2AFl12FqpHDk2GXzyUEMzaXfs=;
        b=JStEgYurE7trUCBIt5KTBadT5RCUK4ekwJpsF9GJu2E3VFpRycgzOVwO9eYbdPzcNX
         15ut7ThwA+8BZD2FNw1pNTP/tjDifa6NFt+QGd3wNvFtuwhnrpm1oPjgU6nTOE/mE0Si
         ZzuvnP/wVEvwPVOOhZ7Q26hDQj0lGSa8qAqc9LVqgkMQ9CWJUFuY4ywb2/evdNp/8j/E
         NNR5AVJDUOry1T1YLqhIXxGYNUhOt9oWTl1FXHySxMLaV1vWCFy7AbyYusoV+xJnDFnz
         pmgtBk4bKgUL75peOh6KL8EDEXyScmTXSHwrU7TUtRCn72ROd27GIj+2vhWHQFiYeKUa
         e0nQ==
X-Gm-Message-State: AO0yUKVcAhwxEmVqs/Kixa7UZZjc4R95CHIvGJ/aB5jC0lj8iuU2yDql
        OXE1gfNDHZ8ra5yHycHPVGmV3Jekiklg0ljW
X-Google-Smtp-Source: AK7set/nrRpngkGIj2i/jQakhxLs+1QliXsY6t28Oodtr3sWBmq2+s0l4T14b1p4UU8LvLePr7CvNQ==
X-Received: by 2002:a17:906:fe4c:b0:8aa:be5c:b7c5 with SMTP id wz12-20020a170906fe4c00b008aabe5cb7c5mr29054495ejb.41.1676298936334;
        Mon, 13 Feb 2023 06:35:36 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id uz6-20020a170907118600b0088a2397cb2csm6927186ejb.143.2023.02.13.06.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 06:35:35 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] soc: qcom: rpmpd: Expand struct definition macros
Date:   Mon, 13 Feb 2023 15:35:19 +0100
Message-Id: <20230213143524.1943754-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213143524.1943754-1-konrad.dybcio@linaro.org>
References: <20230213143524.1943754-1-konrad.dybcio@linaro.org>
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

Expand the struct definition macros to make things easier to see and
maintain. Now that the macros are unnecessary, remove them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 539 ++++++++++++++++++++++++++++++++-------
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
2.39.1

