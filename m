Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6336A94C5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCCKET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjCCKEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:04:15 -0500
Received: from out-22.mta1.migadu.com (out-22.mta1.migadu.com [IPv6:2001:41d0:203:375::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82A21448D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:04:12 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677837851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j5Z5sdd2BdV1dzkgQLa3P+giXSo0A/xE3te2w2iBryE=;
        b=OfJurxfk/AWSgt5hfN+ATcKhKO56sCye+5OBTGv3nRygs3ovkGc5hphUfMEtqVA56tEFdI
        DeEKltZQw7AmUpYSj2VW/DKssUkHfQ9PyZ9jJveLtr8dN3QK5+M1zEX60fSlLPUPRNZ4sY
        htIZI+afZuPrsFj8b+syDzsIBMm63r4=
From:   richard.leitner@linux.dev
Subject: [PATCH v2 0/3] Add "mclk" support for maxim,max9867
Date:   Fri, 03 Mar 2023 11:04:00 +0100
Message-Id: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABDGAWQC/x3NQQ6CQAyF4auQri2OxSB4FeOiA1UadTBTMGMId
 3dw8RZ/8iVvAZOoYnAuFojyUdMx5KBdAd3A4S6ofW4gR5WrHOGLU9vUJzy2rjnkMbGHrD2boI8
 cumHz9tCeJ94/NcwJ65LK76beUW6a/n+X67r+APhLWa1/AAAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     Benjamin Bara <bbara93@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1315;
 i=richard.leitner@skidata.com; h=from:subject:message-id;
 bh=lABtBknjf+2ofJrshcscPhXS8qeqNM0qmvagAqkFnOk=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFIYj0nyPtVfnbJEySEgtvrB0t6tNat3xJ2xFz2dvYIv7M4+
 m3r/jlIWBjEuBlkxRRZ7Y65299yy95WKOrkwc1iZQIYwcHEKwEQ40hgZ5hzI15rDvT3FPeaUW8iZNO
 uEmzklx85csV/IJWg+k13GieF/7j/1BCEGK627CjtfOk2/JZjEOd1hM2+4cny0hevVFE9+AA==
X-Developer-Key: i=richard.leitner@skidata.com; a=openpgp;
 fpr=3F330A87476D76EF79212C6DFC189628387CFBD0
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the clocks properties in the
maxim,max9867 bindings. Furthermore the binding definitions are
converted from txt to yaml.

The clock property is needed to define the mclk for one of our
boards which uses the the i.MX8MP SAI MCLK as clock for the
maxim,max9867.

ChangeLog:
v2:
 - dt-bindings:
  - add "additionalProperties: false" property
  - remove "clock-names" property
  - fix $id
  - fix example
 - max9867:
  - Enable and prepare mclk on SND_SOC_BIAS_ON
  - disable and unprepare mclk on SND_SOC_BIAS_OFF
  - drop "mclk" clock-name

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
Benjamin Bara (1):
      ASoC: maxim,max9867: add "mclk" support

Richard Leitner (2):
      ASoC: dt-bindings: maxim,max9867: convert txt bindings to yaml
      ASoC: dt-bindings: maxim,max9867: add clocks property

 .../devicetree/bindings/sound/max9867.txt          | 17 ------
 .../devicetree/bindings/sound/maxim,max9867.yaml   | 66 ++++++++++++++++++++++
 sound/soc/codecs/max9867.c                         | 19 ++++++-
 3 files changed, 83 insertions(+), 19 deletions(-)
---
base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
change-id: 20230302-max9867-49081908a2ab

Best regards,
-- 
Richard Leitner <richard.leitner@skidata.com>

