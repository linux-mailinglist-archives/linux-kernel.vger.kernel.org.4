Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4799260B40A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiJXRZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiJXRZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:25:15 -0400
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:103:465::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56FD107AB8;
        Mon, 24 Oct 2022 09:00:23 -0700 (PDT)
Received: from smtp1.mailbox.org (unknown [91.198.250.123])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4MwxXs6BMdz9tNZ;
        Mon, 24 Oct 2022 16:00:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1666620013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D1QoMnqnd5xmhZpHisqOGEewGnuBN0iyQID+c/VrmZ0=;
        b=md4FJE5bVrjkl7AOie2cpAYJoKiQTE3o3n9Vsc8TzfALBj5QXexuZSUCaayKwOP++pcQyZ
        3uDPKXMg19I2XWmiFarks5rkA3Bg2ii4u7TyMLDuZqmCS8TSAGrcr5nUM2AEJUttanbKp1
        xmR+4SRRctpLpCfxEovmzX0rvM1I7sACRa7DkKPpQH/M7r4w/kco1h6eYUn5T8NUxjgxa3
        PBl3jUhtpqzsdYtmWcJ8mZK96l2r3fd14dZvCPoAGI7CrbCpmkL7d3fMIHDA/eqBkxZYyG
        +2NPBWkMqNWDAGYscHu4jfoHq/44V9jbHrE+xI3JAgD2PaaDETq/zG4qc4RV+A==
From:   Job Noorman <job@noorman.info>
To:     Job Noorman <job@noorman.info>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 0/3] Add Himax hx83112b touchscreen driver
Date:   Mon, 24 Oct 2022 15:59:56 +0200
Message-Id: <20221024140001.139111-1-job@noorman.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4MwxXs6BMdz9tNZ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series adds support for the Himax hx83112b. The hx83112b supports 10
point multitouch with hardware tracking of touch points. It is the
touchschreen used by the Fairphone 3.

Note that a datasheet was unavailable for this device, so it was built
based on the Android driver that was tagged as GPLv2. This series is a
complete rewrite, though, and the code bears no resemblence to the original
implementation.

It is expected that this driver can be made to work on other hx83xxx
devices, especially the hx83112a used in the Fairphone 4. However, since we
have been unable to verify this, this driver only declares compatibility
with the hx83112b and uses very specific file names.

Changes since v5 (based on Jeff LaBundy's 3rd round of comments):
- Consistently reuse local variable dev in himax_probe()

Changes since v4 (based on Jeff LaBundy's 2nd round of comments):
- Kconfig: depend on I2C and select REGMAP_I2C
- Don't suppress dev_err() on EPROBE_DEFER
- Some minor coding style updates

Changes since v3 (based on Dmitry Torokhov's comments):
- Use gpiod_set_value_cansleep (instead of gpiod_set_value) during probe
- Inline some small helper functions
- Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
- Use PTR_ERR_OR_ZERO instead of IS_ERR+PTR_ERR
- Some minor coding style updates (e.g., use C-style comments)

Changes since v2 (based on Jeff LaBundy's comments):
- Kconfig: depend on REGMAP_I2C instead of I2C
- Don't use dev_err_probe()
- Return IRQ_NONE on failed register reads to prevent possible interrupt
  storm
- Add small delay after de-asserting reset pin
- Some minor coding style updates
- dt-bindings: make touchscreen-size-{x,y} required

Changes since v1:
- Fix sparse warnings. Reported-by: kernel test robot <lkp@intel.com>.
- Fix dt_binding_check.

Best regards,
Job

Previous versions:
- v5: https://lore.kernel.org/lkml/20221023163032.144150-1-job@noorman.info/
- v4: https://lore.kernel.org/lkml/20221017100409.189293-1-job@noorman.info/
- v3: https://lore.kernel.org/lkml/20221016102756.40345-1-job@noorman.info/
- v2: https://lore.kernel.org/lkml/20221012202341.295351-1-job@noorman.info/
- v1: https://lore.kernel.org/lkml/20221011190729.14747-1-job@noorman.info/

Job Noorman (3):
  dt-bindings: touchscreen: add Himax hx83112b bindings
  Input: add driver for Himax hx83112b touchscreen devices
  arm64: dts: qcom: sdm632: fairphone-fp3: add touchscreen

 .../input/touchscreen/himax,hx83112b.yaml     |  63 +++
 MAINTAINERS                                   |   7 +
 .../boot/dts/qcom/sdm632-fairphone-fp3.dts    |  14 +
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/himax_hx83112b.c    | 361 ++++++++++++++++++
 6 files changed, 458 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
 create mode 100644 drivers/input/touchscreen/himax_hx83112b.c


base-commit: 8b96465c93a8c0f85ead5b3f8d4305beac97899e
-- 
2.38.1

