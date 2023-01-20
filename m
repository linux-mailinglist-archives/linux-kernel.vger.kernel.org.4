Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50DA675258
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjATK0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjATK0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:26:08 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44548C91E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 02:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674210364;
  x=1705746364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RvZNX3FYVF5mNab85ida8KMtTEb9QvKaCGvhzjrKy1Q=;
  b=FgJmG2TVE3nXMzsNpX7xsebUF1SSGut5ChAf9ML82pQzgczKCJFr6MP5
   8TPKjva3pZ5RWESo3enYLHYXKgNeWi/bcA2vAGG/Wsktiawc2FP+VewFq
   p7z4iqdt83nMPzrYQN0LJXz9R0j64AMuHaZ2xhJ9+4sIP7En4yWb3ITMB
   E2MniFq60vVit39aDaVeP/kV1U2nMR+CKcyHBaS+Q30MvZITtRZo4C0Yd
   u6ZPLQ3Ksxfv4687IgivG4FRk+xEgyHoQcdwLpRuET4v2/QcAAeQGFRc+
   runSM/11+61HP9aurxIKoqcBXn5Hv6NG5gRi5RnEJ8iWa/Px17qqcjcvK
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v2 0/4] ASoC: simple-card-utils: create jack inputs for aux_devs
Date:   Fri, 20 Jan 2023 11:25:50 +0100
Message-ID: <20230120102555.1523394-1-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic way to create jack inputs for auxiliary jack detection
drivers (e.g. via i2c, spi), which are not part of any real codec.
The simple-card can be used as combining card driver to add the jacks,
no new one is required.

Create a jack (for input-events) for jack devices in the auxiliary
device list (aux_devs). A device which returns a valid value on
get_jack_type counts as jack device; set_jack is required
to add the jack to the device.

v1 -> v2: Auxiliary jack drivers return the correct snd_jack_type with
 the function: get_jack_type.
- No devicetree changes in simple-card.
- soc-component: changed name to: get_jack_type.
- simple-jack-utils: updated algorithm to add jack devices.
   A device which returns a valid value on get_jack_type counts as jack
   device
- ts3a227e: added devicetree property jack-type, added NULL check for jack.

Astrid Rost (4):
  [PATCH v2 1/4] ASoC: soc-component: add get_jack_type
  [PATCH v2 2/4] ASoC: simple-card-utils: create jack inputs for aux_devs
  [PATCH v2 3/4] ASoC: ts3a227e: add set_jack and get_jack_type
  [PATCH v2 4/4] ASoC: dt-bindings: ti,ts3a227e.yaml: add jack-type

 .../bindings/sound/ti,ts3a227e.yaml           |  8 +++
 include/sound/simple_card_utils.h             |  3 ++
 include/sound/soc-component.h                 |  2 +
 sound/soc/codecs/ts3a227e.c                   | 29 ++++++++++-
 sound/soc/generic/simple-card-utils.c         | 49 +++++++++++++++++++
 sound/soc/generic/simple-card.c               |  4 ++
 sound/soc/soc-component.c                     | 20 ++++++++
 7 files changed, 114 insertions(+), 1 deletion(-)

-- 
2.30.2

