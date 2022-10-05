Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A205F51D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJEJhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJEJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:37:03 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9692B50723
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1664962618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRHA7B5ZXZ1fLFZbKRgDI3qoJ/Kk/Wb4SZdAMQoiEt8=;
        b=BeS1MRVYMBF+OoP6cWTmLQpxUinSXyy0U0clWEwkzx12quAO/G0BWfResj05nDoO4i73xV
        bi+vfrOO1SLzN46Ve5hOVAodODMf2mn2krbLjpUhTTBSx53l/zxeSuAQ3slSCf5lpH5ZrS
        raC0SK6lbyBpgF8OKletfGfZh2QCOwVOOg30FKj3gYk06C1BKJwXHfdb5X27wGN3/yP2b8
        cmnFK46B63PtUOVAR40dmyqsLRm5Rgl3e6RfBxujjU7RBpHtvtHQleFmd+RFjRHt7s1JZ2
        qt93GViRN8zluTtF5zBRU4O2jnZ9UB1RT/g+61eVSpsUVbngYO8J4HOMPVwa8w==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-209-mP8fTz0GNrS9cfO_-0NzIw-1; Wed, 05 Oct 2022 05:36:57 -0400
X-MC-Unique: mP8fTz0GNrS9cfO_-0NzIw-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 5 Oct 2022 02:36:53 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>, <yzhu@maxlinear.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH v3 4/4] clk: mxl: Fix a clk entry by adding relevant flags
Date:   Wed, 5 Oct 2022 17:36:38 +0800
Message-ID: <bb11192a959ac74ca440a206b9d81ea6e7717484.1664958833.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1664958833.git.rtanwar@maxlinear.com>
References: <cover.1664958833.git.rtanwar@maxlinear.com>
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

One of the clock entry "dcl" clk has some HW limitations. One is that
its rate can only by changed by changing its parent clk's rate & two
is that HW does not support enable/disable for this clk.

Handle above two limitations by adding relevant flags. Add standard
flag CLK_SET_RATE_PARENT to handle rate change and add driver internal
flag DIV_CLK_NO_MASK to handle enable/disable.

Fixes: d058fd9e8984c ("clk: intel: Add CGU clock driver for a new SoC")
Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 drivers/clk/x86/clk-cgu.c | 5 +++--
 drivers/clk/x86/clk-cgu.h | 1 +
 drivers/clk/x86/clk-lgm.c | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
index d24173cfe0b0..f5a99e21599e 100644
--- a/drivers/clk/x86/clk-cgu.c
+++ b/drivers/clk/x86/clk-cgu.c
@@ -164,8 +164,9 @@ static int lgm_clk_divider_enable_disable(struct clk_hw=
 *hw, int enable)
 {
 =09struct lgm_clk_divider *div =3D to_lgm_clk_divider(hw);
=20
-=09lgm_set_clk_val(div->membase, div->reg, div->shift_gate,
-=09=09=09div->width_gate, enable);
+=09if (div->flags !=3D DIV_CLK_NO_MASK)
+=09=09lgm_set_clk_val(div->membase, div->reg, div->shift_gate,
+=09=09=09=09div->width_gate, enable);
 =09return 0;
 }
=20
diff --git a/drivers/clk/x86/clk-cgu.h b/drivers/clk/x86/clk-cgu.h
index 73ce84345f81..bcaf8aec94e5 100644
--- a/drivers/clk/x86/clk-cgu.h
+++ b/drivers/clk/x86/clk-cgu.h
@@ -198,6 +198,7 @@ struct lgm_clk_branch {
 #define CLOCK_FLAG_VAL_INIT=09BIT(16)
 #define MUX_CLK_SW=09=09BIT(17)
 #define GATE_CLK_HW=09=09BIT(18)
+#define DIV_CLK_NO_MASK=09=09BIT(19)
=20
 #define LGM_MUX(_id, _name, _pdata, _f, _reg,=09=09\
 =09=09_shift, _width, _cf, _v)=09=09\
diff --git a/drivers/clk/x86/clk-lgm.c b/drivers/clk/x86/clk-lgm.c
index e312af42e97a..4de77b2c750d 100644
--- a/drivers/clk/x86/clk-lgm.c
+++ b/drivers/clk/x86/clk-lgm.c
@@ -255,8 +255,8 @@ static const struct lgm_clk_branch lgm_branch_clks[] =
=3D {
 =09LGM_FIXED(LGM_CLK_SLIC, "slic", NULL, 0, CGU_IF_CLK1,
 =09=09  8, 2, CLOCK_FLAG_VAL_INIT, 8192000, 2),
 =09LGM_FIXED(LGM_CLK_DOCSIS, "v_docsis", NULL, 0, 0, 0, 0, 0, 16000000, 0)=
,
-=09LGM_DIV(LGM_CLK_DCL, "dcl", "v_ifclk", 0, CGU_PCMCR,
-=09=0925, 3, 0, 0, 0, 0, dcl_div),
+=09LGM_DIV(LGM_CLK_DCL, "dcl", "v_ifclk", CLK_SET_RATE_PARENT, CGU_PCMCR,
+=09=0925, 3, 0, 0, DIV_CLK_NO_MASK, 0, dcl_div),
 =09LGM_MUX(LGM_CLK_PCM, "pcm", pcm_p, 0, CGU_C55_PCMCR,
 =09=090, 1, CLK_MUX_ROUND_CLOSEST, 0),
 =09LGM_FIXED_FACTOR(LGM_CLK_DDR_PHY, "ddr_phy", "ddr",
--=20
2.17.1

