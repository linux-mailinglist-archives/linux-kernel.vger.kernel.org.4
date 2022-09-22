Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112965E5B55
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiIVGZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiIVGYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:24:55 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206699A9E8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1663827891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AdS8+B/O/n4mduTrHxo0RL4fuHx8wGK9eiouBtBzHLE=;
        b=EenPhqvWigLB7aTvIy0DSg/REUhWFPlCNZq6ndHh/kiZXDl5ua9MqqFlh1PMLxT0HMdk7G
        r5cdOWHlMjy3z+2GVZBCAUIvfe1cD1FfsH+AwGvil8aA6A+LlP5QBw8Gna2t8iKGN/QTjj
        LzxZ1uMvjwrya+gwqiBv/eYRqbdNWF0qJH+Cl4vsA+Fcmalga31oK1nODSEYg8VlUlkHmP
        Kv0fIBBRdYIe9+EeBH9cPgtYDp2MG3stX6JhDm/KmBaohWk6FFVCf+gV+DOi3ZzfNOWbjg
        /qqda3Vj+G2IykvwYwDRHx8QNFzpAjX/Gz2kTH4MEbZs2GBlIwD6ZN6wTBB4sw==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-151-LhUWCdljOtSMnXHrnA6CAg-1; Thu, 22 Sep 2022 02:24:48 -0400
X-MC-Unique: LhUWCdljOtSMnXHrnA6CAg-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 21 Sep 2022 23:24:45 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH RESEND v2 3/5] clk: mxl: Avoid disabling gate clocks from clk driver
Date:   Thu, 22 Sep 2022 14:24:26 +0800
Message-ID: <5a88bd5a9e93cc6e794080e5cac821ae0c27ec56.1663827071.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663827071.git.rtanwar@maxlinear.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MxL's LGM SoC, gate clocks are supposed to be enabled or disabled
from EPU (power management IP) in certain power saving modes. If gate
clocks are allowed to be enabled/disabled from CGU clk driver, then
there arises a conflict where in case clk driver disables a gate clk,
and then EPU tries to disable the same gate clk, then it will hang
polling for the clk gated successful status.

To avoid such a conflict, disable gate clocks enabling/disabling from
CGU clk driver. But add a GATE_CLK_HW flag to control this in order to
be backward compatible with other SoCs which share the same CGU IP but
not the same EPU IP.

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

