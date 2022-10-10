Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539FA5FA1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJJQSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiJJQSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:18:38 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EE974E1C;
        Mon, 10 Oct 2022 09:18:32 -0700 (PDT)
Date:   Mon, 10 Oct 2022 16:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1665418710; x=1665677910;
        bh=QUBvfLf5/ZmxmXVHIOzXGKhSL4wLDsnRHwe2CVD15XI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=ZvDwxUNGzYPeSrC8Lsx1Gi1FU0Far9/X9nhkaxT1FFaLy48ihRNwEuiZz6JQXaFXh
         tMc0x+o30U+S2+o+dtylWAjA0uQoptWI5s5Ml+chgSN2nWk0bm38pnzadm1nfCwIle
         VivCi4qc/keFVX1fiBTwBZ13VB//62PF84XsJ+zw=
To:     caleb@connolly.tech
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rob Herring <robh+dt@kernel.org>, Tom Rix <trix@redhat.com>
Subject: [PATCH v5 2/2] input: add Qualcomm SPMI haptics driver
Message-ID: <20221010161727.1298112-3-caleb@connolly.tech>
In-Reply-To: <20221010161727.1298112-1-caleb@connolly.tech>
References: <20221010161727.1298112-1-caleb@connolly.tech>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the haptics found in pmi8998 and related PMICs.
Based on the ff-memless interface. Currently this driver provides
a partial implementation of hardware features.

This driver only supports LRAs (Linear Resonant Actuators) in the "buffer"
mode with a single wave pattern.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 drivers/input/misc/Kconfig                |  15 +
 drivers/input/misc/Makefile               |   1 +
 drivers/input/misc/qcom-pmi8998-haptics.c | 690 ++++++++++++++++++++++
 3 files changed, 706 insertions(+)
 create mode 100644 drivers/input/misc/qcom-pmi8998-haptics.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index a18ab7358d8f..c3b59ea23144 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -186,6 +186,21 @@ config INPUT_PMIC8XXX_PWRKEY
 =09  To compile this driver as a module, choose M here: the
 =09  module will be called pmic8xxx-pwrkey.

+config INPUT_QCOM_PMI8998_HAPTICS
+=09tristate "Qualcomm SPMI HAPTICS"
+=09depends on ARCH_QCOM
+=09depends on MFD_PM8XXX || MFD_SPMI_PMIC
+=09select INPUT_FF_MEMLESS
+=09help
+=09  This option enables support for the haptics found in pmi8998 and
+=09  related PMICs. Based on the ff-memless interface.
+
+=09  This driver is for hardware too new for the INPUT_PM8XXX_VIBRATOR
+=09  driver.
+
+=09  To compile this driver as module, choose M here: the
+=09  module will be called qcom_pmi8998_haptics.
+
 config INPUT_SPARCSPKR
 =09tristate "SPARC Speaker support"
 =09depends on PCI && SPARC64
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 28dfc444f0a9..039d0a97f2f4 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)=09+=3D pmic8xxx-pwrke=
y.o
 obj-$(CONFIG_INPUT_POWERMATE)=09=09+=3D powermate.o
 obj-$(CONFIG_INPUT_PWM_BEEPER)=09=09+=3D pwm-beeper.o
 obj-$(CONFIG_INPUT_PWM_VIBRA)=09=09+=3D pwm-vibra.o
+obj-$(CONFIG_INPUT_QCOM_PMI8998_HAPTICS)+=3D qcom-pmi8998-haptics.o
 obj-$(CONFIG_INPUT_RAVE_SP_PWRBUTTON)=09+=3D rave-sp-pwrbutton.o
 obj-$(CONFIG_INPUT_RB532_BUTTON)=09+=3D rb532_button.o
 obj-$(CONFIG_INPUT_REGULATOR_HAPTIC)=09+=3D regulator-haptic.o
diff --git a/drivers/input/misc/qcom-pmi8998-haptics.c b/drivers/input/misc=
/qcom-pmi8998-haptics.c
new file mode 100644
index 000000000000..4aab2c5fe9db
--- /dev/null
+++ b/drivers/input/misc/qcom-pmi8998-haptics.c
@@ -0,0 +1,690 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Caleb Connolly <caleb@connolly.tech>
+ * Qualcomm QPMI haptics driver for pmi8998 and related PMICs.
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+// clang-format off
+#define HAP_STATUS_1_REG=09=090x0A
+#define HAP_BUSY_BIT=09=09=09BIT(1)
+#define SC_FLAG_BIT=09=09=09BIT(3)
+#define AUTO_RES_ERROR_BIT=09=09BIT(4)
+
+#define HAP_LRA_AUTO_RES_LO_REG=09=090x0B
+#define HAP_LRA_AUTO_RES_HI_REG=09=090x0C
+
+#define HAP_EN_CTL_REG=09=09=090x46
+#define HAP_EN_BIT=09=09=09BIT(7)
+
+#define HAP_EN_CTL2_REG=09=09=090x48
+#define BRAKE_EN_BIT=09=09=09BIT(0)
+
+#define HAP_AUTO_RES_CTRL_REG=09=090x4B
+#define AUTO_RES_EN_BIT=09=09=09BIT(7)
+#define AUTO_RES_ERR_RECOVERY_BIT=09BIT(3)
+#define AUTO_RES_EN_FLAG_BIT=09=09BIT(0)
+
+#define HAP_CFG1_REG=09=09=090x4C
+#define HAP_ACT_TYPE_MASK=09=09BIT(0)
+
+#define HAP_CFG2_REG=09=09=090x4D
+#define HAP_LRA_RES_TYPE_MASK=09=09BIT(0)
+
+#define HAP_SEL_REG=09=09=090x4E
+#define HAP_WF_SOURCE_MASK=09=09GENMASK(5, 4)
+#define HAP_WF_SOURCE_SHIFT=09=094
+
+#define HAP_LRA_AUTO_RES_REG=09=090x4F
+#define LRA_AUTO_RES_MODE_MASK=09=09GENMASK(6, 4)
+#define LRA_AUTO_RES_MODE_SHIFT=09=094
+#define LRA_HIGH_Z_MASK=09=09=09GENMASK(3, 2)
+#define LRA_HIGH_Z_SHIFT=09=092
+#define LRA_RES_CAL_MASK=09=09GENMASK(1, 0)
+#define HAP_RES_CAL_PERIOD_MIN=09=094
+#define HAP_RES_CAL_PERIOD_MAX=09=0932
+
+#define HAP_VMAX_CFG_REG=09=090x51
+#define HAP_VMAX_OVD_BIT=09=09BIT(6)
+#define HAP_VMAX_MASK=09=09=09GENMASK(5, 1)
+#define HAP_VMAX_SHIFT=09=09=091
+
+#define HAP_ILIM_CFG_REG=09=090x52
+#define HAP_ILIM_SEL_MASK=09=09BIT(0)
+#define HAP_ILIM_400_MA=09=09=090
+#define HAP_ILIM_800_MA=09=09=091
+
+#define HAP_SC_DEB_REG=09=09=090x53
+#define HAP_SC_DEB_MASK=09=09=09GENMASK(2, 0)
+#define HAP_SC_DEB_CYCLES_MIN=09=090
+#define HAP_DEF_SC_DEB_CYCLES=09=098
+#define HAP_SC_DEB_CYCLES_MAX=09=0932
+
+#define HAP_RATE_CFG1_REG=09=090x54
+#define HAP_RATE_CFG1_MASK=09=09GENMASK(7, 0)
+#define HAP_RATE_CFG2_SHIFT=09=098 // As CFG2 is the most significant byte
+
+#define HAP_RATE_CFG2_REG=09=090x55
+#define HAP_RATE_CFG2_MASK=09=09GENMASK(3, 0)
+
+#define HAP_SC_CLR_REG=09=09=090x59
+#define SC_CLR_BIT=09=09=09BIT(0)
+
+#define HAP_BRAKE_REG=09=09=090x5C
+#define HAP_BRAKE_PAT_MASK=09=090x3
+
+#define HAP_WF_REPEAT_REG=09=090x5E
+#define WF_REPEAT_MASK=09=09=09GENMASK(6, 4)
+#define WF_REPEAT_SHIFT=09=09=094
+#define WF_REPEAT_MIN=09=09=091
+#define WF_REPEAT_MAX=09=09=09128
+#define WF_S_REPEAT_MASK=09=09GENMASK(1, 0)
+#define WF_S_REPEAT_MIN=09=09=091
+#define WF_S_REPEAT_MAX=09=09=098
+
+#define HAP_WF_S1_REG=09=09=090x60
+#define HAP_WF_SIGN_BIT=09=09=09BIT(7)
+#define HAP_WF_OVD_BIT=09=09=09BIT(6)
+#define HAP_WF_SAMP_MAX=09=09=09GENMASK(5, 1)
+#define HAP_WF_SAMPLE_LEN=09=098
+
+#define HAP_PLAY_REG=09=09=090x70
+#define HAP_PLAY_BIT=09=09=09BIT(7)
+#define HAP_PAUSE_BIT=09=09=09BIT(0)
+
+#define HAP_SEC_ACCESS_REG=09=090xD0
+#define HAP_SEC_ACCESS_UNLOCK=09=090xA5
+
+#define HAP_TEST2_REG=09=09=090xE3
+
+
+#define HAP_VMAX_MIN_MV=09=09=09116
+#define HAP_VMAX_MAX_MV=09=09=093596
+#define HAP_VMAX_MAX_MV_STRONG=09=093596
+
+#define HAP_WAVE_PLAY_RATE_MIN_US=090
+#define HAP_WAVE_PLAY_RATE_MAX_US=0920475
+#define HAP_WAVE_PLAY_TIME_MAX_MS=0915000
+
+#define AUTO_RES_ERR_POLL_TIME_NS=09(20 * NSEC_PER_MSEC)
+#define HAPTICS_BACK_EMF_DELAY_US=0920000
+
+#define HAP_BRAKE_PAT_LEN=09=094
+#define HAP_WAVE_SAMP_LEN=09=098
+#define NUM_WF_SET=09=09=094
+#define HAP_WAVE_SAMP_SET_LEN=09=09(HAP_WAVE_SAMP_LEN * NUM_WF_SET)
+#define HAP_RATE_CFG_STEP_US=09=095
+
+#define SC_MAX_COUNT=09=09=095
+#define SC_COUNT_RST_DELAY_US=09=091000000
+
+// Actuator types
+#define HAP_TYPE_LRA=09=09=090
+#define HAP_TYPE_ERM=09=09=091
+
+// LRA Wave type
+#define HAP_WAVE_SINE=09=09=090
+#define HAP_WAVE_SQUARE=09=09=091
+
+// Play modes
+#define HAP_PLAY_DIRECT=09=09=090
+#define HAP_PLAY_BUFFER=09=09=091
+#define HAP_PLAY_AUDIO=09=09=092
+#define HAP_PLAY_PWM=09=09=093
+
+#define HAP_PLAY_MAX=09=09=09HAP_PLAY_PWM
+
+// Auto resonance type
+#define HAP_AUTO_RES_NONE=09=090
+#define HAP_AUTO_RES_ZXD=09=091
+#define HAP_AUTO_RES_QWD=09=092
+#define HAP_AUTO_RES_MAX_QWD=09=093
+#define HAP_AUTO_RES_ZXD_EOP=09=094
+// clang-format on
+
+static const uint8_t default_brake_pattern[] =3D {
+=090x3, 0x3, 0x3, 0x3, 0x3,
+};
+
+static const uint8_t wave_sample_pattern[] =3D {
+=090x7e, 0x7e, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28,
+};
+
+/**
+ * struct spmi_haptics - struct for spmi haptics data.
+ *
+ * @dev: Our device parent.
+ * @regmap: Register map for the hardware block.
+ * @input: The input device used to receive events.
+ * @work: Work struct to play effects.
+ * @base: Base address of the regmap.
+ * @play_irq: Fired to load the next wave pattern.
+ * @sc_irq: Short circuit irq.
+ * @last_sc_time: Time since the short circuit IRQ last fired.
+ * @sc_count: Number of times the short circuit IRQ has fired in this inte=
rval.
+ * @actuator_type: The type of actuator in use.
+ * @wave_shape: The shape of the waves to use (sine or square).
+ * @play_mode: The play mode to use (direct, buffer, pwm, audio).
+ * @vmax: Max voltage to use when playing.
+ * @current_limit: The current limit for this hardware (400mA or 800mA).
+ * @play_wave_rate: The wave rate to use for this hardware.
+ * @play_lock: Lock to be held when updating the hardware state.
+ */
+struct spmi_haptics {
+=09struct device *dev;
+=09struct regmap *regmap;
+=09struct input_dev *input;
+=09struct work_struct work;
+=09uint32_t base;
+
+=09int play_irq;
+=09int sc_irq;
+=09ktime_t last_sc_time;
+=09uint8_t sc_count;
+
+=09uint8_t actuator_type;
+=09uint8_t wave_shape;
+=09uint8_t play_mode;
+=09uint32_t vmax;
+=09uint32_t current_limit;
+=09uint32_t play_wave_rate;
+=09struct mutex play_lock;
+};
+
+static int haptics_write_vmax(struct spmi_haptics *haptics)
+{
+=09uint8_t val =3D 0;
+=09uint32_t vmax_mv =3D haptics->vmax;
+
+=09vmax_mv =3D clamp_t(uint32_t, vmax_mv, HAP_VMAX_MIN_MV, HAP_VMAX_MAX_MV=
);
+=09vmax_mv =3D DIV_ROUND_CLOSEST(vmax_mv, HAP_VMAX_MIN_MV);
+
+=09val =3D FIELD_PREP(HAP_VMAX_MASK, vmax_mv);
+
+=09return regmap_update_bits(haptics->regmap,
+=09=09=09=09  haptics->base + HAP_VMAX_CFG_REG,
+=09=09=09=09  HAP_VMAX_MASK | HAP_WF_OVD_BIT, val);
+}
+
+static int haptics_module_enable(struct spmi_haptics *haptics, bool enable=
)
+{
+=09return regmap_update_bits(haptics->regmap,
+=09=09=09=09  haptics->base + HAP_EN_CTL_REG, HAP_EN_BIT,
+=09=09=09=09  enable ? HAP_EN_BIT : 0);
+}
+
+static int haptics_play(struct spmi_haptics *haptics, bool play)
+{
+=09return regmap_update_bits(haptics->regmap, haptics->base + HAP_PLAY_REG=
,
+=09=09=09=09  HAP_PLAY_BIT | HAP_PAUSE_BIT,
+=09=09=09=09  play ? HAP_PLAY_BIT : 0);
+}
+
+static bool is_haptics_module_enabled(struct spmi_haptics *haptics)
+{
+=09uint32_t val;
+
+=09regmap_read(haptics->regmap, haptics->base + HAP_EN_CTL_REG, &val);
+=09return !!val;
+}
+
+/*
+ * This IRQ is fired to tell us to load the next wave sample set.
+ * As we only currently support a single sample set, it's unused.
+ */
+static irqreturn_t haptics_play_irq(int irq, void *data)
+{
+=09struct spmi_haptics *haptics =3D data;
+
+=09dev_dbg(haptics->dev, "play_irq triggered");
+
+=09return IRQ_HANDLED;
+}
+
+/*
+ * Fires every ~50ms whilst the haptics are active.
+ * If the SC_FLAG_BIT is set then that means there isn't a short circuit
+ * and we just need to clear the IRQ to indicate that the device should
+ * keep vibrating.
+ *
+ * Otherwise, it means a short circuit situation has occurred.
+ */
+static irqreturn_t haptics_sc_irq(int irq, void *data)
+{
+=09struct spmi_haptics *haptics =3D data;
+=09int ret;
+=09uint32_t val;
+=09long sc_delta_time_us;
+=09ktime_t temp;
+
+=09mutex_lock(&haptics->play_lock);
+
+=09ret =3D regmap_read(haptics->regmap, haptics->base + HAP_STATUS_1_REG,
+=09=09=09  &val);
+=09if (ret)
+=09=09goto out;
+
+=09if (!(val & SC_FLAG_BIT)) {
+=09=09haptics->sc_count =3D 0;
+=09=09goto out;
+=09}
+
+=09temp =3D ktime_get();
+=09sc_delta_time_us =3D ktime_us_delta(temp, haptics->last_sc_time);
+=09haptics->last_sc_time =3D temp;
+
+=09if (sc_delta_time_us > SC_COUNT_RST_DELAY_US)
+=09=09haptics->sc_count =3D 0;
+=09else
+=09=09haptics->sc_count++;
+
+=09ret =3D regmap_update_bits(haptics->regmap,
+=09=09=09=09 haptics->base + HAP_SC_CLR_REG, SC_CLR_BIT,
+=09=09=09=09 SC_CLR_BIT);
+=09if (ret)
+=09=09goto out;
+
+=09if (haptics->sc_count > SC_MAX_COUNT) {
+=09=09cancel_work_sync(&haptics->work);
+=09=09dev_err(haptics->dev,
+=09=09=09"Short circuit persists, disabling haptics\n");
+=09=09ret =3D haptics_module_enable(haptics, false);
+=09=09if (ret)
+=09=09=09dev_err(haptics->dev, "Error disabling module, rc=3D%d\n",
+=09=09=09=09ret);
+=09}
+
+out:
+=09mutex_unlock(&haptics->play_lock);
+=09return IRQ_HANDLED;
+}
+
+static int haptics_vibrate(struct spmi_haptics *haptics)
+{
+=09int ret;
+
+=09if (haptics->sc_count > SC_MAX_COUNT) {
+=09=09dev_err(haptics->dev, "Can't play while in short circuit");
+=09=09return -EINVAL;
+=09}
+
+=09ret =3D haptics_write_vmax(haptics);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D haptics_module_enable(haptics, true);
+=09if (ret) {
+=09=09dev_err(haptics->dev, "Error enabling module, ret=3D%d\n", ret);
+=09=09return ret;
+=09}
+
+=09ret =3D haptics_play(haptics, true);
+=09if (ret) {
+=09=09dev_err(haptics->dev, "Error enabling play, ret=3D%d\n", ret);
+=09=09return ret;
+=09}
+
+=09return ret;
+}
+
+static int haptics_stop_vibrate(struct spmi_haptics *haptics)
+{
+=09int ret;
+
+=09ret =3D haptics_play(haptics, false);
+=09if (ret) {
+=09=09dev_err(haptics->dev, "Error disabling play, ret=3D%d\n", ret);
+=09=09return ret;
+=09}
+
+=09ret =3D haptics_module_enable(haptics, false);
+=09if (ret) {
+=09=09dev_err(haptics->dev, "Error disabling module, ret=3D%d\n", ret);
+=09=09return ret;
+=09}
+
+=09return ret;
+}
+
+static void haptics_play_stop_work(struct work_struct *work)
+{
+=09struct spmi_haptics *haptics =3D
+=09=09container_of(work, struct spmi_haptics, work);
+
+=09int ret;
+
+=09mutex_lock(&haptics->play_lock);
+
+=09if (!is_haptics_module_enabled(haptics) && haptics->vmax)
+=09=09ret =3D haptics_vibrate(haptics);
+=09else
+=09=09ret =3D haptics_stop_vibrate(haptics);
+=09if (ret)
+=09=09dev_err(haptics->dev, "Error setting haptics, ret=3D%d", ret);
+
+=09mutex_unlock(&haptics->play_lock);
+}
+
+static int spmi_haptics_play_effect(struct input_dev *dev, void *data,
+=09=09=09=09    struct ff_effect *effect)
+{
+=09struct spmi_haptics *haptics =3D input_get_drvdata(dev);
+=09uint32_t magnitude;
+
+=09dev_dbg(haptics->dev, "%s: Rumbling with strong: %d and weak: %d",
+=09=09 __func__, effect->u.rumble.strong_magnitude,
+=09=09 effect->u.rumble.weak_magnitude);
+
+=09magnitude =3D effect->u.rumble.strong_magnitude >> 8;
+=09if (!magnitude)
+=09=09magnitude =3D effect->u.rumble.weak_magnitude >> 10;
+
+=09if (!magnitude)
+=09=09haptics->vmax =3D 0;
+=09else
+=09=09haptics->vmax =3D
+=09=09=09((HAP_VMAX_MAX_MV - HAP_VMAX_MIN_MV) * magnitude) /
+=09=09=09=09100 +
+=09=09=09HAP_VMAX_MIN_MV;
+
+=09schedule_work(&haptics->work);
+
+=09return 0;
+}
+
+/**
+ * spmi_haptics_close - callback for input device close
+ * @dev: input device pointer
+ *
+ * Turns off the vibrator.
+ */
+static void spmi_haptics_close(struct input_dev *dev)
+{
+=09struct spmi_haptics *haptics =3D input_get_drvdata(dev);
+
+=09cancel_work_sync(&haptics->work);
+=09haptics->vmax =3D 0;
+
+=09if (is_haptics_module_enabled(haptics))
+=09=09haptics_stop_vibrate(haptics);
+}
+
+static int haptics_write_brake_pattern(struct spmi_haptics *haptics,
+=09=09=09=09       const uint8_t *brake_pattern)
+{
+=09int ret, i;
+=09uint8_t val =3D 0;
+
+=09for (i =3D HAP_BRAKE_PAT_LEN - 1; i >=3D 0; i--)
+=09=09val |=3D FIELD_PREP(HAP_BRAKE_PAT_MASK, brake_pattern[i])
+=09=09       << (i * 2);
+
+=09ret =3D regmap_update_bits(haptics->regmap, haptics->base + HAP_BRAKE_R=
EG,
+=09=09=09=09 0xff, val);
+
+=09return ret   ?:
+=09=09       regmap_update_bits(haptics->regmap,
+=09=09=09=09=09  haptics->base + HAP_EN_CTL2_REG,
+=09=09=09=09=09  BRAKE_EN_BIT, BRAKE_EN_BIT);
+}
+
+static int haptics_init(struct spmi_haptics *haptics)
+{
+=09int ret;
+=09uint8_t val, mask;
+=09uint16_t play_rate;
+
+=09ret =3D regmap_update_bits(haptics->regmap, haptics->base + HAP_CFG1_RE=
G,
+=09=09=09=09 HAP_ACT_TYPE_MASK, haptics->actuator_type);
+=09if (ret)
+=09=09return ret;
+
+=09/*
+=09 * Configure auto resonance
+=09 * see qpnp_haptics_lra_auto_res_config downstream
+=09 * This is greatly simplified.
+=09 */
+=09val =3D FIELD_PREP(LRA_RES_CAL_MASK, ilog2(32 / HAP_RES_CAL_PERIOD_MIN)=
) |
+=09      FIELD_PREP(LRA_AUTO_RES_MODE_MASK, HAP_AUTO_RES_ZXD_EOP) |
+=09      FIELD_PREP(LRA_HIGH_Z_MASK, 1);
+=09mask =3D LRA_AUTO_RES_MODE_MASK | LRA_HIGH_Z_MASK | LRA_RES_CAL_MASK;
+
+=09ret =3D regmap_update_bits(haptics->regmap,
+=09=09=09=09 haptics->base + HAP_LRA_AUTO_RES_REG, mask,
+=09=09=09=09 val);
+=09if (ret)
+=09=09return ret;
+
+=09val =3D FIELD_PREP(HAP_WF_SOURCE_MASK, haptics->play_mode);
+=09ret =3D regmap_update_bits(haptics->regmap, haptics->base + HAP_SEL_REG=
,
+=09=09=09=09 HAP_WF_SOURCE_MASK, val);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D regmap_update_bits(haptics->regmap,
+=09=09=09=09 haptics->base + HAP_ILIM_CFG_REG,
+=09=09=09=09 HAP_ILIM_SEL_MASK, haptics->current_limit);
+=09if (ret)
+=09=09return ret;
+
+=09/* Configure the debounce for short-circuit detection. */
+=09ret =3D regmap_update_bits(haptics->regmap,
+=09=09=09=09 haptics->base + HAP_SC_DEB_REG,
+=09=09=09=09 HAP_SC_DEB_MASK, HAP_SC_DEB_CYCLES_MAX);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D regmap_update_bits(haptics->regmap, haptics->base + HAP_CFG2_RE=
G,
+=09=09=09=09 HAP_LRA_RES_TYPE_MASK, haptics->wave_shape);
+=09if (ret)
+=09=09return ret;
+
+=09/*
+=09 * Configure RATE_CFG1 and RATE_CFG2 registers.
+=09 * Note: For ERM (unsupported) these registers act as play rate and
+=09 * for LRA these represent resonance period
+=09 */
+=09play_rate =3D haptics->play_wave_rate / HAP_RATE_CFG_STEP_US;
+=09val =3D FIELD_PREP(HAP_RATE_CFG1_MASK, play_rate);
+=09ret =3D regmap_update_bits(haptics->regmap,
+=09=09=09=09 haptics->base + HAP_RATE_CFG1_REG,
+=09=09=09=09 HAP_RATE_CFG1_MASK, val);
+=09val =3D FIELD_PREP(HAP_RATE_CFG2_MASK, play_rate >> 8);
+=09ret =3D ret   ?:
+=09=09      regmap_update_bits(haptics->regmap,
+=09=09=09=09=09 haptics->base + HAP_RATE_CFG2_REG,
+=09=09=09=09=09 HAP_RATE_CFG1_MASK, val);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D haptics_write_brake_pattern(haptics, default_brake_pattern);
+=09if (ret)
+=09=09return ret;
+
+=09/* Currently this is the only supported play mode */
+=09if (haptics->play_mode =3D=3D HAP_PLAY_BUFFER) {
+=09=09/* zero repeats and zero sample repeats */
+=09=09val =3D FIELD_PREP(WF_REPEAT_MASK, 0) |
+=09=09      FIELD_PREP(WF_S_REPEAT_MASK, 0);
+=09=09ret =3D regmap_update_bits(haptics->regmap,
+=09=09=09=09=09 haptics->base + HAP_WF_REPEAT_REG,
+=09=09=09=09=09 WF_REPEAT_MASK | WF_S_REPEAT_MASK,
+=09=09=09=09=09 val);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09ret =3D regmap_bulk_write(haptics->regmap,
+=09=09=09=09=09haptics->base + HAP_WF_S1_REG,
+=09=09=09=09=09wave_sample_pattern, HAP_WAVE_SAMP_LEN);
+=09=09if (ret)
+=09=09=09return ret;
+=09}
+
+=09return 0;
+}
+
+static int spmi_haptics_probe(struct platform_device *pdev)
+{
+=09struct spmi_haptics *haptics;
+=09struct input_dev *input_dev;
+=09int ret, irq;
+
+=09haptics =3D devm_kzalloc(&pdev->dev, sizeof(*haptics), GFP_KERNEL);
+=09if (!haptics)
+=09=09return -ENOMEM;
+
+=09haptics->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
+=09if (!haptics->regmap)
+=09=09return -ENODEV;
+
+=09haptics->dev =3D &pdev->dev;
+
+=09platform_set_drvdata(pdev, haptics);
+
+=09ret =3D device_property_read_u32(haptics->dev, "reg", &haptics->base);
+=09if (ret)
+=09=09return dev_err_probe(haptics->dev, ret,
+=09=09=09=09     "Couldn't read base address");
+
+=09/* This is the only currently supported configuration, these values
+=09 * are left to allow future additions
+=09 */
+=09haptics->actuator_type =3D HAP_TYPE_LRA;
+=09haptics->play_mode =3D HAP_PLAY_BUFFER;
+=09haptics->wave_shape =3D HAP_WAVE_SINE;
+=09haptics->current_limit =3D HAP_ILIM_400_MA;
+
+=09ret =3D device_property_read_u32(haptics->dev, "qcom,wave-play-rate-us"=
,
+=09=09=09=09       &haptics->play_wave_rate);
+=09if (ret)
+=09=09return dev_err_probe(haptics->dev, ret,
+=09=09=09=09     "qcom,wave-play-rate-us is required\n");
+
+=09INIT_WORK(&haptics->work, haptics_play_stop_work);
+
+=09ret =3D haptics_init(haptics);
+=09if (ret)
+=09=09return ret;
+
+=09input_dev =3D devm_input_allocate_device(&pdev->dev);
+=09if (!input_dev)
+=09=09return -ENOMEM;
+
+=09input_dev->name =3D "spmi_haptics";
+=09input_dev->id.version =3D 1;
+=09input_dev->close =3D spmi_haptics_close;
+=09input_set_drvdata(input_dev, haptics);
+
+=09haptics->input =3D input_dev;
+
+=09/* In the future this should become FF_PERIODIC */
+=09input_set_capability(haptics->input, EV_FF, FF_RUMBLE);
+
+=09ret =3D input_ff_create_memless(input_dev, NULL,
+=09=09=09=09      spmi_haptics_play_effect);
+=09if (ret)
+=09=09return dev_err_probe(
+=09=09=09&pdev->dev, ret,
+=09=09=09"Couldn't register haptics as EV_FF device\n");
+
+=09ret =3D input_register_device(input_dev);
+=09if (ret)
+=09=09return dev_err_probe(&pdev->dev, ret,
+=09=09=09=09     "Couldn't register input device\n");
+
+=09/* NOTE: the play IRQ is only used for buffer mode */
+=09irq =3D platform_get_irq_byname(pdev, "play");
+=09if (irq < 0) {
+=09=09return dev_err_probe(&pdev->dev, irq,
+=09=09=09=09     "Unable to get play irq\n");
+=09}
+=09ret =3D devm_request_threaded_irq(haptics->dev, irq, NULL,
+=09=09=09=09=09haptics_play_irq, IRQF_ONESHOT,
+=09=09=09=09=09"haptics_play_irq", haptics);
+=09if (ret)
+=09=09return dev_err_probe(haptics->dev, ret,
+=09=09=09=09     "Couldn't request play irq\n");
+
+=09irq =3D platform_get_irq_byname(pdev, "short");
+=09if (irq < 0)
+=09=09return dev_err_probe(&pdev->dev, irq,
+=09=09=09=09     "Unable to get short circut irq\n");
+=09ret =3D devm_request_threaded_irq(haptics->dev, irq, NULL, haptics_sc_i=
rq,
+=09=09=09=09=09IRQF_ONESHOT, "haptics_short_irq",
+=09=09=09=09=09haptics);
+=09if (ret)
+=09=09return dev_err_probe(haptics->dev, ret,
+=09=09=09=09     "Couldn't request short circuit irq\n");
+
+=09mutex_init(&haptics->play_lock);
+
+=09return 0;
+}
+
+static int __maybe_unused spmi_haptics_suspend(struct device *dev)
+{
+=09struct spmi_haptics *haptics =3D dev_get_drvdata(dev);
+
+=09cancel_work_sync(&haptics->work);
+=09haptics_stop_vibrate(haptics);
+
+=09return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(spmi_haptics_pm_ops, spmi_haptics_suspend, NULL);
+
+static int spmi_haptics_remove(struct platform_device *pdev)
+{
+=09struct spmi_haptics *haptics =3D dev_get_drvdata(&pdev->dev);
+
+=09cancel_work_sync(&haptics->work);
+=09mutex_destroy(&haptics->play_lock);
+=09input_unregister_device(haptics->input);
+
+=09return 0;
+}
+
+static void spmi_haptics_shutdown(struct platform_device *pdev)
+{
+=09struct spmi_haptics *haptics =3D dev_get_drvdata(&pdev->dev);
+
+=09cancel_work_sync(&haptics->work);
+=09haptics_stop_vibrate(haptics);
+}
+
+static const struct of_device_id spmi_haptics_match_table[] =3D {
+=09{ .compatible =3D "qcom,spmi-haptics" },
+=09{}
+};
+MODULE_DEVICE_TABLE(of, spmi_haptics_match_table);
+
+static struct platform_driver spmi_haptics_driver =3D {
+=09.probe=09=09=3D spmi_haptics_probe,
+=09.remove=09=09=3D spmi_haptics_remove,
+=09.shutdown=09=3D spmi_haptics_shutdown,
+=09.driver=09=09=3D {
+=09=09.name=09=3D "spmi-haptics",
+=09=09.pm=09=3D &spmi_haptics_pm_ops,
+=09=09.of_match_table =3D spmi_haptics_match_table,
+=09},
+};
+module_platform_driver(spmi_haptics_driver);
+
+MODULE_DESCRIPTION("spmi haptics driver using ff-memless framework");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Caleb Connolly <caleb@connolly.tech>");
--
2.38.0


