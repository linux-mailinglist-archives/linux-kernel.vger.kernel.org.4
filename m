Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C5E677D49
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjAWN7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjAWN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:59:33 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A519265B9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674482361;
  x=1706018361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i8on6vz/Y8C01TnbzJd94dunJQctpVXOIR3eiTNXE0g=;
  b=TPJ3O0lM0Pdmhcx7X1O2AkCydCkYVJOPHmVFRFVA/GfxTYqD4WHiu6+g
   HoyrzO7e9qEfQg+6ZzNkqeP6oZJEBDkBP1AicL5DItm5MZRrVc3EmSUcc
   IKGczTRdyrUVqrk+TyQ6WliyLCkkMLJ8yeNm37gMW/iYUYkwZZUHFCE7S
   +/au2OS4ZjbCCFkOAs7Vb+R0+5qmV991TTMTVsfyYUUEzD0/J7VOlKKpa
   4viMM6V9s69W1AHfxZLhWYpp3AGJi6X/HQ4h2+KR21EDzHMqbz8rEoL0m
   8QoBE4RfOz/Vn0NWUJ2EpsV8AfnaFqKYULfCmM/I4eVA+L81wHGmR7McY
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v3 0/3] ASoC: simple-card-utils: create jack inputs for aux_devs
Date:   Mon, 23 Jan 2023 14:59:10 +0100
Message-ID: <20230123135913.2720991-1-astrid.rost@axis.com>
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

v2 -> v3:  ts3a227e: remove devictree property.

Astrid Rost (3):
  [PATCH v3 1/3] ASoC: soc-component: add get_jack_type
  [PATCH v3 2/3] ASoC: simple-card-utils: create jack inputs for aux_devs
  [PATCH v3 3/3] ASoC: ts3a227e: add set_jack and get_jack_type

 include/sound/simple_card_utils.h     |  3 ++
 include/sound/soc-component.h         |  2 ++
 sound/soc/codecs/ts3a227e.c           | 20 ++++++++++-
 sound/soc/generic/simple-card-utils.c | 49 +++++++++++++++++++++++++++
 sound/soc/generic/simple-card.c       |  4 +++
 sound/soc/soc-component.c             | 20 +++++++++++
 6 files changed, 97 insertions(+), 1 deletion(-)

-- 
2.30.2

