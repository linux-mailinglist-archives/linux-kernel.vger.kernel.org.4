Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA835FFEA5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJPKgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 06:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJPKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 06:35:59 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Oct 2022 03:35:54 PDT
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [IPv6:2001:67c:2050:103:465::209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7F13A162;
        Sun, 16 Oct 2022 03:35:54 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4MqxDD3tsQz9td7;
        Sun, 16 Oct 2022 12:28:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1665916108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SOmvazYlegZ4LyhI1lnP3c7B4CLLHK3pQ+YSzG3ZBS4=;
        b=Ui7d9hsffYYPGsApD0q4wze6+Y21q4caGV0s/k8d0xruIaIWx3n+KMgos/lNdobP7Cp8fB
        x2h1WmMFmr0TMiibwQrBgGUS50GU80B6cJi9uCIbLl7DAjgadHYZx1Xu/Wp3B8KvW/M4XD
        u090SzrWPoeO8ZhlXepEjOfUMlgweDF+bvoS25hforSFdE8nxGw7oLh3HNOOPZbjbxG8Ml
        vRSApZhlUwfGSKA1QKT5CkgMvFOCo1NrLsfqUxAsZfwAIQv40CcZfm1oYZf0OO+nDuYnkD
        ca8cUCgycuPHNmDeuYcVRQ4cE6A7hzh7e6tH2hV1n9SwsYXJxGbxSx6dRM2Raw==
From:   Job Noorman <job@noorman.info>
To:     Job Noorman <job@noorman.info>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 0/3] Add Himax hx83112b touchscreen driver
Date:   Sun, 16 Oct 2022 12:27:52 +0200
Message-Id: <20221016102756.40345-1-job@noorman.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4MqxDD3tsQz9td7
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
- v2: https://lore.kernel.org/lkml/20221012202341.295351-1-job@noorman.info/
- v1: https://lore.kernel.org/lkml/20221011190729.14747-1-job@noorman.info/

Job Noorman (3):
  dt-bindings: touchscreen: add Himax hx83112b bindings
  Input: add driver for Himax hx83112b touchscreen devices
  arm64: dts: qcom: sdm632: fairphone-fp3: add touchscreen

 .../input/touchscreen/himax,hx83112b.yaml     |  63 +++
 MAINTAINERS                                   |   7 +
 .../boot/dts/qcom/sdm632-fairphone-fp3.dts    |  14 +
 drivers/input/touchscreen/Kconfig             |  11 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/himax_hx83112b.c    | 382 ++++++++++++++++++
 6 files changed, 478 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
 create mode 100644 drivers/input/touchscreen/himax_hx83112b.c


base-commit: d4a596eddb90114f5f5f32a440057a175517b090
-- 
2.38.0

