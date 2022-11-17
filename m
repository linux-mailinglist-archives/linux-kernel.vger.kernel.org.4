Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F25E62E2AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiKQRPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240718AbiKQRPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:15:41 -0500
X-Greylist: delayed 2422 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 09:15:40 PST
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C4673B95
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:15:40 -0800 (PST)
Date:   Thu, 17 Nov 2022 17:15:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668705338; x=1668964538;
        bh=dW92NfqJF9I5odBniSAN3HdOJVVBTtflw7kZQiRR6D8=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=KlkGvxw6ftiz2mNoE9miBobvV1zFeKvvM2HwSC/Jjh+qx9h+1/rzgH30rQ06maH2J
         Wg/m+tTo0V4GZoE9pEjC9cJmvOmCjRwOMRyoKAL4S86a4tBJ0o9VLnpocjBxX1L2yw
         jkAbQ7BmnobI4TP/sfX4VM46H5DpAGMj294p9KGDUTpI57mW2KGBMBmBixOJP1joeF
         FZA943yFVU3hqOJo9sxyVzrXG15eJ/JqRVzVFGex6WYQzg8xEk2pTzY91aDaEnzyG9
         UevOrmhK6Sn4QQcUKmU+jU2SUOA3/phKg/aoFDDOkwDJ5qoMGOjMNYH1mbu03urWt0
         WAPstBe57vL7g==
To:     linux-clk@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:QUALCOMM CLOCK DRIVERS" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: qcom: gcc-msm8939: Add rates to the GP clocks
Message-ID: <20221117171343.24216-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to msm8916, msm8939 has (at least) 6 "General Purpose" clocks that
can be muxed to SoC pins. These clocks are:

GP_CLK{0, 1} : GPIO_{31, 32} (Belongs to CAMSS according to Linux)
GP_CLK_{1-3}{A, B} : GPIO_{49-51, 97, 12, 13} (Belongs to GCC itself)
GP_MN : GPIO_110 (Doesn't seem to be described in gcc,
    ignored in this patch)

Those clocks may be used as e.g. PWM sources for external peripherals.
Add more frequencies to the table for those clocks so it's possible
for arbitrary peripherals to make use of them.

Reference: https://lore.kernel.org/r/20220612145955.385787-5-nikita@trvn.ru

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 drivers/clk/qcom/gcc-msm8939.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8939.c b/drivers/clk/qcom/gcc-msm8939.=
c
index af608f165896..712073f9dc69 100644
--- a/drivers/clk/qcom/gcc-msm8939.c
+++ b/drivers/clk/qcom/gcc-msm8939.c
@@ -1033,7 +1033,20 @@ static struct clk_rcg2 cci_clk_src =3D {
 =09},
 };
=20
+/*
+ * This is a frequency table for "General Purpose" clocks.
+ * These clocks can be muxed to the SoC pins and may be used by
+ * external devices. They're often used as PWM source.
+ *
+ * See comment at ftbl_gcc_gp1_3_clk.
+ */
 static const struct freq_tbl ftbl_gcc_camss_gp0_1_clk[] =3D {
+=09F(10000,   P_XO,    16,  1, 120),
+=09F(100000,  P_XO,    16,  1,  12),
+=09F(500000,  P_GPLL0, 16,  1, 100),
+=09F(1000000, P_GPLL0, 16,  1,  50),
+=09F(2500000, P_GPLL0, 16,  1,  20),
+=09F(5000000, P_GPLL0, 16,  1,  10),
 =09F(100000000, P_GPLL0, 8, 0, 0),
 =09F(200000000, P_GPLL0, 4, 0, 0),
 =09{ }
@@ -1198,7 +1211,29 @@ static struct clk_rcg2 crypto_clk_src =3D {
 =09},
 };
=20
+/*
+ * This is a frequency table for "General Purpose" clocks.
+ * These clocks can be muxed to the SoC pins and may be used by
+ * external devices. They're often used as PWM source.
+ *
+ * Please note that MND divider must be enabled for duty-cycle
+ * control to be possible. (M !=3D N) Also since D register is configured
+ * with a value multiplied by 2, and duty cycle is calculated as
+ *                             (2 * D) % 2^W
+ *                DutyCycle =3D ----------------
+ *                              2 * (N % 2^W)
+ * (where W =3D .mnd_width)
+ * N must be half or less than maximum value for the register.
+ * Otherwise duty-cycle control would be limited.
+ * (e.g. for 8-bit NMD N should be less than 128)
+ */
 static const struct freq_tbl ftbl_gcc_gp1_3_clk[] =3D {
+=09F(10000,   P_XO,    16,  1, 120),
+=09F(100000,  P_XO,    16,  1,  12),
+=09F(500000,  P_GPLL0, 16,  1, 100),
+=09F(1000000, P_GPLL0, 16,  1,  50),
+=09F(2500000, P_GPLL0, 16,  1,  20),
+=09F(5000000, P_GPLL0, 16,  1,  10),
 =09F(19200000, P_XO, 1, 0,=090),
 =09{ }
 };
--=20
2.30.2


