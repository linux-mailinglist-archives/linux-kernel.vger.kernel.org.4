Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC205F51D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJEJhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJEJg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:36:58 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7305F3A17D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1664962615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GrTXW+i4vQzPkBYNKN03HHAzvuwG4eQQ9N957/o46ik=;
        b=QoVjGVdVIKtOyXyo2iJxfBpx+oFINW5v3cmGhvx19LMt+oCPWPKYEnHMV21rxDW7GJeVNA
        fIhYnmxmZfIizjXmkEbg1swFxlizcEtWk/NFs9YDFou0JfllYhnDVjEpWcImMXrFUE2B0T
        RTd5Yp2FyKyNzPaXeqvGLZY65HshUg2SJWW0k3P88KL7iQnwgHmODoJs1AcX/tcPRqRH78
        vOadKNvfaAKL6B3Ok8BImxnOwWv2JSNJx9Nl4lbmXc6bCqTr7Jkdwqg7dS0j247uRFWD4w
        3QqsH4Rp2tacP/ZXJtevx2wQpm+clfxoe3jnp8VHKfBTiB+1SWaMUtZFTcqquQ==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-314-yZDrrdzeMvaSFx15uxalaw-1; Wed, 05 Oct 2022 05:36:54 -0400
X-MC-Unique: yZDrrdzeMvaSFx15uxalaw-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 5 Oct 2022 02:36:50 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>, <yzhu@maxlinear.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH v3 3/4] clk: mxl: Add option to override gate clks enable/disable
Date:   Wed, 5 Oct 2022 17:36:37 +0800
Message-ID: <19cffbf46579cfd5e771098a4001a6404343af1f.1664958833.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1664958833.git.rtanwar@maxlinear.com>
References: <cover.1664958833.git.rtanwar@maxlinear.com>
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

Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 drivers/clk/x86/clk-cgu.c | 32 ++++++++++++++++++++++++--------
 drivers/clk/x86/clk-cgu.h |  1 +
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
index 1f7e93de67bc..d24173cfe0b0 100644
--- a/drivers/clk/x86/clk-cgu.c
+++ b/drivers/clk/x86/clk-cgu.c
@@ -258,8 +258,12 @@ static int lgm_clk_gate_enable(struct clk_hw *hw)
 =09struct lgm_clk_gate *gate =3D to_lgm_clk_gate(hw);
 =09unsigned int reg;
=20
-=09reg =3D GATE_HW_REG_EN(gate->reg);
-=09lgm_set_clk_val(gate->membase, reg, gate->shift, 1, 1);
+=09if (gate->flags & GATE_CLK_HW) {
+=09=09reg =3D GATE_HW_REG_EN(gate->reg);
+=09=09lgm_set_clk_val(gate->membase, reg, gate->shift, 1, 1);
+=09} else {
+=09=09gate->reg =3D 1;
+=09}
=20
 =09return 0;
 }
@@ -269,8 +273,12 @@ static void lgm_clk_gate_disable(struct clk_hw *hw)
 =09struct lgm_clk_gate *gate =3D to_lgm_clk_gate(hw);
 =09unsigned int reg;
=20
-=09reg =3D GATE_HW_REG_DIS(gate->reg);
-=09lgm_set_clk_val(gate->membase, reg, gate->shift, 1, 1);
+=09if (gate->flags & GATE_CLK_HW) {
+=09=09reg =3D GATE_HW_REG_DIS(gate->reg);
+=09=09lgm_set_clk_val(gate->membase, reg, gate->shift, 1, 1);
+=09} else {
+=09=09gate->reg =3D 0;
+=09}
 }
=20
 static int lgm_clk_gate_is_enabled(struct clk_hw *hw)
@@ -278,8 +286,12 @@ static int lgm_clk_gate_is_enabled(struct clk_hw *hw)
 =09struct lgm_clk_gate *gate =3D to_lgm_clk_gate(hw);
 =09unsigned int reg, ret;
=20
-=09reg =3D GATE_HW_REG_STAT(gate->reg);
-=09ret =3D lgm_get_clk_val(gate->membase, reg, gate->shift, 1);
+=09if (gate->flags & GATE_CLK_HW) {
+=09=09reg =3D GATE_HW_REG_STAT(gate->reg);
+=09=09ret =3D lgm_get_clk_val(gate->membase, reg, gate->shift, 1);
+=09} else {
+=09=09ret =3D gate->reg;
+=09}
=20
 =09return ret;
 }
@@ -315,7 +327,8 @@ lgm_clk_register_gate(struct lgm_clk_provider *ctx,
 =09init.num_parents =3D pname ? 1 : 0;
=20
 =09gate->membase =3D ctx->membase;
-=09gate->reg =3D reg;
+=09if (cflags & GATE_CLK_HW)
+=09=09gate->reg =3D reg;
 =09gate->shift =3D shift;
 =09gate->flags =3D cflags;
 =09gate->hw.init =3D &init;
@@ -326,7 +339,10 @@ lgm_clk_register_gate(struct lgm_clk_provider *ctx,
 =09=09return ERR_PTR(ret);
=20
 =09if (cflags & CLOCK_FLAG_VAL_INIT) {
-=09=09lgm_set_clk_val(gate->membase, reg, shift, 1, list->gate_val);
+=09=09if (cflags & GATE_CLK_HW)
+=09=09=09lgm_set_clk_val(gate->membase, reg, shift, 1, list->gate_val);
+=09=09else
+=09=09=09gate->reg =3D 1;
 =09}
=20
 =09return hw;
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

