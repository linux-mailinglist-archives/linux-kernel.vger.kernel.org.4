Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A875E5B57
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiIVGZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIVGY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:24:57 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2660196773
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1663827893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+UK/3xmvV65NQU0nckZ1VWPUugzCRzrBeOVEtHB3BM=;
        b=gW+zCglgOseJJHk5MxDhefFXYzY703HBb0OZfkrRxAphmDaqSpsiToJdcVFDEr+P8k3T6w
        ZQUVJaVP6nqO2+kCaOTysgo/uAF7AdJ3ZgBzHDWuo/BJsW5zutM2Lr514NKH04j+zukHLR
        ASSSthD9gW5qIqU/JuuOle1S+qPfOG9RA35agzKot5qBGMv4QM7USSitvQJ9/M8cKEEStE
        gi6IWoPYRk615nPjvnWn8ZXa0RlUNxolCqGd9iqboDwW37gpMXIWZGwtLPA9IYC9OgJDc1
        1plb0c3IScUjbtm5jB6df2d1/e9azw/CypEa+9K6Y4mLFZd9RjQbQisII+yfug==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-496-aR5Q6_71PcOaYhPJh2KEcA-1; Thu, 22 Sep 2022 02:24:51 -0400
X-MC-Unique: aR5Q6_71PcOaYhPJh2KEcA-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 21 Sep 2022 23:24:48 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH RESEND v2 4/5] clk: mxl: Add validation for register reads/writes
Date:   Thu, 22 Sep 2022 14:24:27 +0800
Message-ID: <3bcdfdf0f66dd2fdcffbdeabb5e3ab0bfb2e3489.1663827071.git.rtanwar@maxlinear.com>
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

Some clocks support parent clock dividers but they do not
support clock gating (clk enable/disable). Such types of
clocks might call API's for get/set_reg_val routines with
width as 0 during clk_prepare_enable() call. Handle such
cases by first validating width during clk_prepare_enable()
while still supporting clk_set_rate() correctly.

Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 drivers/clk/x86/clk-cgu.h | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/x86/clk-cgu.h b/drivers/clk/x86/clk-cgu.h
index 73ce84345f81..46daf9ebd6c9 100644
--- a/drivers/clk/x86/clk-cgu.h
+++ b/drivers/clk/x86/clk-cgu.h
@@ -299,29 +299,51 @@ struct lgm_clk_branch {
 static inline void lgm_set_clk_val(struct regmap *membase, u32 reg,
 =09=09=09=09   u8 shift, u8 width, u32 set_val)
 {
-=09u32 mask =3D (GENMASK(width - 1, 0) << shift);
+=09u32 mask;
=20
+=09/*
+=09 * Some clocks support parent clock dividers but they do not
+=09 * support clock gating (clk enable/disable). Such types of
+=09 * clocks might call this function with width as 0 during
+=09 * clk_prepare_enable() call. Handle such cases by not doing
+=09 * anything during clk_prepare_enable() but handle clk_set_rate()
+=09 * correctly
+=09 */
+=09if (!width)
+=09=09return;
+
+=09mask =3D (GENMASK(width - 1, 0) << shift);
 =09regmap_update_bits(membase, reg, mask, set_val << shift);
 }
=20
 static inline u32 lgm_get_clk_val(struct regmap *membase, u32 reg,
 =09=09=09=09  u8 shift, u8 width)
 {
-=09u32 mask =3D (GENMASK(width - 1, 0) << shift);
+=09u32 mask;
 =09u32 val;
=20
+=09/*
+=09 * Some clocks support parent clock dividers but they do not
+=09 * support clock gating (clk enable/disable). Such types of
+=09 * clocks might call this function with width as 0 during
+=09 * clk_prepare_enable() call. Handle such cases by not doing
+=09 * anything during clk_prepare_enable() but handle clk_set_rate()
+=09 * correctly
+=09 */
+=09if (!width)
+=09=09return 0;
+
 =09if (regmap_read(membase, reg, &val)) {
 =09=09WARN_ONCE(1, "Failed to read clk reg: 0x%x\n", reg);
 =09=09return 0;
 =09}
=20
+=09mask =3D (GENMASK(width - 1, 0) << shift);
 =09val =3D (val & mask) >> shift;
=20
 =09return val;
 }
=20
-
-
 int lgm_clk_register_branches(struct lgm_clk_provider *ctx,
 =09=09=09      const struct lgm_clk_branch *list,
 =09=09=09      unsigned int nr_clk);
--=20
2.17.1

