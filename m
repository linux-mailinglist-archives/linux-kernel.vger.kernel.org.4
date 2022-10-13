Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EBA5FD537
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJMGtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJMGtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:49:03 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964881463B0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1665643737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yW/6V1qRcDmA37h7BKc8WxQSHaHKLLO2foHGntzZ9N4=;
        b=oqts3gZXDybtQLXgKB3l3e/izVkY53vCSb16Vi9jFmp6S6YqCHXc4Yj8uYtJZ2luRF2fY4
        Q91UhyVZKM/HBrI/iLUM2GzmVfIOPIeBBseKgIdRzYUqN9I7fDGLaHr9O7KA2Utdny1EmI
        HcYhQYF4CY7Ww0toRkYYCzklNVRuXZhGDOBhqBu+ECr/XfoOJrKCDKposl9UuJYAXOuCLX
        mMj/ekCc/0t0Xe1XfPM4O/w8bvA4QOVtrLtNCrd+Q6B/Bf1DwpUhKyo7yu88Gkzp9J8/VH
        bQU7SVwFUnob2H8UxLSXih2lNbtppHqjlaZ+QsWOLZokPUZtiEHcpKeC/5v/Cw==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-562-APN1wHB2N8KLM2CyH0UUIw-1; Thu, 13 Oct 2022 02:48:48 -0400
X-MC-Unique: APN1wHB2N8KLM2CyH0UUIw-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 12 Oct 2022 23:48:45 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>, <yzhu@maxlinear.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH v4 3/4] clk: mxl: Add option to override gate clks
Date:   Thu, 13 Oct 2022 14:48:32 +0800
Message-ID: <bdc9c89317b5d338a6c4f1d49386b696e947a672.1665642720.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1665642720.git.rtanwar@maxlinear.com>
References: <cover.1665642720.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MxL's LGM SoC, gate clocks can be controlled either from CGU clk driver
i.e. this driver or directly from power management driver/daemon. It is
dependent on the power policy/profile requirements of the end product.

To support such use cases, provide option to override gate clks enable/disa=
ble
by adding a flag GATE_CLK_HW which controls if these gate clks are controll=
ed
by HW i.e. this driver or overridden in order to allow it to be controlled
by power profiles instead.

Reviewed-by: Yi xin Zhu <yzhu@maxlinear.com>
Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 drivers/clk/x86/clk-cgu.c | 15 ++++++++++++++-
 drivers/clk/x86/clk-cgu.h |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
index 1f7e93de67bc..5eafd7e0d945 100644
--- a/drivers/clk/x86/clk-cgu.c
+++ b/drivers/clk/x86/clk-cgu.c
@@ -354,8 +354,21 @@ int lgm_clk_register_branches(struct lgm_clk_provider =
*ctx,
 =09=09=09hw =3D lgm_clk_register_fixed_factor(ctx, list);
 =09=09=09break;
 =09=09case CLK_TYPE_GATE:
-=09=09=09hw =3D lgm_clk_register_gate(ctx, list);
+=09=09=09if (list->gate_flags & GATE_CLK_HW)
+=09=09=09=09hw =3D lgm_clk_register_gate(ctx, list);
+=09=09=09else
+=09=09=09=09/*
+=09=09=09=09 * GATE_CLKs can be controlled either from
+=09=09=09=09 * CGU clk driver i.e. this driver or directly
+=09=09=09=09 * from power management driver/daemon. It is
+=09=09=09=09 * dependent on the power policy/profile requirements
+=09=09=09=09 * of the end product. To override control of gate
+=09=09=09=09 * clks from this driver, provide NULL for this index
+=09=09=09=09 * of gate clk provider.
+=09=09=09=09 */
+=09=09=09=09hw =3D NULL;
 =09=09=09break;
+
 =09=09default:
 =09=09=09dev_err(ctx->dev, "invalid clk type\n");
 =09=09=09return -EINVAL;
diff --git a/drivers/clk/x86/clk-cgu.h b/drivers/clk/x86/clk-cgu.h
index 0aa0f35d63a0..73ce84345f81 100644
--- a/drivers/clk/x86/clk-cgu.h
+++ b/drivers/clk/x86/clk-cgu.h
@@ -197,6 +197,7 @@ struct lgm_clk_branch {
 /* clock flags definition */
 #define CLOCK_FLAG_VAL_INIT=09BIT(16)
 #define MUX_CLK_SW=09=09BIT(17)
+#define GATE_CLK_HW=09=09BIT(18)
=20
 #define LGM_MUX(_id, _name, _pdata, _f, _reg,=09=09\
 =09=09_shift, _width, _cf, _v)=09=09\
--=20
2.17.1

