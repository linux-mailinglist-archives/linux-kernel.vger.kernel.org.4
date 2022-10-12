Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697375FCBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJLUYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJLUYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:24:13 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E749748CC;
        Wed, 12 Oct 2022 13:24:10 -0700 (PDT)
Date:   Wed, 12 Oct 2022 20:23:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=protonmail3; t=1665606245; x=1665865445;
        bh=qrc2MlwsGZBeWu2rGFxLZt1zuU7TmkMkUIqp0/CTDJ0=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=XJxCkgJ1KHYB5GP2b7kb/AbxIX7+5j7hP4VKrlqSIzghQ0/V2S7F/23HhUP2wYk1F
         5EZiOgSYozVfte3I3E92eJsYSiB4EPVJtPQw2Zmf102BOw4rOW+TQJgqjAc0uw2wyv
         PpxL05sG/8rzicWiaHPG3GetzMm3VzzKDolX6biEr65wffPki5YqPPd0TAt6HzwVpl
         1ieg8Tnf8zN2xDeb9tjVURWgdjx/n2HPgvRn4aUYx8B77lP69fCn51iLPdcAx1/Ydo
         yODoy6VKpeqRl001eccaaDyU1KA7zbT/g85QGkfP/OUpOnxkZWtO6ePwwuFsFLT5VO
         YlrrqhR7SD7AQ==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Henrik Rydberg <rydberg@bitmath.org>
From:   Job Noorman <job@noorman.info>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/3] Add Himax hx83112b touchscreen driver
Message-ID: <20221012202341.295351-1-job@noorman.info>
Feedback-ID: 14439221:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Changes since v1:
- Fix sparse warnings. Reported-by: kernel test robot <lkp@intel.com>.
- Fix dt_binding_check.

Best regards,
Job

Previous versions:
- v1: https://lore.kernel.org/lkml/20221011190729.14747-1-job@noorman.info/

Job Noorman (3):
  dt-bindings: touchscreen: add Himax hx83112b bindings
  Input: add driver for Himax hx83112b touchscreen devices
  arm64: dts: qcom: sdm632: fairphone-fp3: add touchscreen

 .../input/touchscreen/himax,hx83112b.yaml     |  61 +++
 MAINTAINERS                                   |   7 +
 .../boot/dts/qcom/sdm632-fairphone-fp3.dts    |  14 +
 drivers/input/touchscreen/Kconfig             |  11 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/himax_hx83112b.c    | 377 ++++++++++++++++++
 6 files changed, 471 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/him=
ax,hx83112b.yaml
 create mode 100644 drivers/input/touchscreen/himax_hx83112b.c


base-commit: d4a596eddb90114f5f5f32a440057a175517b090
--
2.38.0


