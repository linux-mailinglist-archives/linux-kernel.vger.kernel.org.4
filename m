Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3984C671DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjARNZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjARNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:25:20 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4F545BF5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674046351;
  x=1705582351;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o0DfuEULqUsAV5hFmVD5dpXwoVgIGc6OdHCzJL9RknI=;
  b=UXoYcsPlEGN2z2AARacNQlXTY6CoZb7nKj9mVD3/UWkHhOnL7v65YUWL
   G9a9fYq05gkz4bLKkQHLYo5whI9ldoP1fUWJE7/ckwsEQDNfy+IDD1pUs
   98a91Fxo23hco7O6zQ9Q0AbB/Tcfa2jVdDe9Q1devN84anugYMxFUI0is
   Ce65GFyaOEB0QCtzFUahaWb4UB5bXpl4eIRiG6KUapBHndHFhoVpdiBtx
   o1R/mh1fCA3/fJTfi1I/kOKorIJISe0oYqaSHDvn5DH1uFQ/IQVr/J3Z7
   hS95HmAQgemW++IeiZa/Wg82p/Eg3dPno704H8HFuxBWZQHojbJ5U54Af
   A==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v1 0/4] ASoC: simple-card-utils: jack for aux_devs
Date:   Wed, 18 Jan 2023 13:52:22 +0100
Message-ID: <20230118125226.333214-1-astrid.rost@axis.com>
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
device list (aux_devs). A device which has the functions set_jack and
get_jack_supported_type counts as jack device.

Add a devicetree entry, in case not all input types are required.
simple-card,aux-jack-types:
Array of snd_jack_type to create jack-input-event for jack devices in
aux-devs. If the setting is 0, the supported type of the device is used.

Astrid Rost (4):
  [PATCH v1 1/4] ASoC: soc-component: add get_jack_supported_type
  [PATCH v1 2/4] ASoC: simple-card-utils: create jack inputs for aux_devs
  [PATCH v1 3/4] ASoC: ts3a227e: add set_jack and get_jack_supported_type
  [PATCH v1 4/4] ASoC: dt-bindings: simple-card: create jack for aux_devs

 .../bindings/sound/simple-card.yaml           | 35 +++++++++++
 include/sound/simple_card_utils.h             |  3 +
 include/sound/soc-component.h                 |  2 +
 sound/soc/codecs/ts3a227e.c                   | 17 ++++-
 sound/soc/generic/simple-card-utils.c         | 63 +++++++++++++++++++
 sound/soc/generic/simple-card.c               |  4 ++
 sound/soc/soc-component.c                     | 18 ++++++
 7 files changed, 141 insertions(+), 1 deletion(-)

-- 
2.30.2

