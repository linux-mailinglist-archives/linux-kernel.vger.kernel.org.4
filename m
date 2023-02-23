Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361846A040F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjBWInh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjBWIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:43:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F313732CE8;
        Thu, 23 Feb 2023 00:43:29 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7FE7266021EF;
        Thu, 23 Feb 2023 08:43:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677141807;
        bh=Pyy4+SZVekNirtkGEkJ02ji/jAYr8ndwKDae9kAk4h8=;
        h=From:To:Cc:Subject:Date:From;
        b=GN1EV4egjuQkjjKlRoGVPI2vqp2VDVWfpmo5EsK3Udl7/F1zH7op0TTVcBS2onQIj
         Cq5Eh4VD0XPF6GjNggCP57dEFoobbNRAYtOV8WNBwG/TimPYUrhfHYQQ0pfjuhJWFJ
         QF/+TCk0cxoGpfSnovFFsqLbFkTVUjUYfdOdLUsX3pKQPEvHnmCn6ne6pBxrVZF5ms
         Ehr3aZuNm9+gIaD7SZKxLbbpqZRxxlpgMWkm8YM7rrGEJgMWXa0F4cJH5x+IHsRuTG
         PSEuNv+kOhjtgYPDIbgEHORCYNbfWyjAU7dFrAPc1+Mf2BQLOfr2QTzrwQAfGfLIoF
         1Of5N0o9ZjpOQ==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Lucas Tanure <lucas.tanure@collabora.com>
Subject: [PATCH v7 0/4] Add CS35L41 shared boost feature
Date:   Thu, 23 Feb 2023 08:43:20 +0000
Message-Id: <20230223084324.9076-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valve's Steam Deck uses CS35L41 in shared boost mode, where both speakers
share the boost circuit.
Add this support in the shared lib, but for now, shared boost is not
supported in HDA systems as would require BIOS changes.

Based on David Rhodes shared boost patches.

Also, fix boost config overwriting in IRQ found in the review and do a
small refactor of the code.

Changes from V6:
 - Fix TX/RX bits in passive amp

Changes from V5:
 - Improved documentation from Cirrrus
 - All amps use MDSCYN for boost source
 - Active amp has TX and RX enabled

Changes from V4:
 - Fix Document subject

Changes from V3:
 - Fix wrong code sent
 - Fix ISO C90 mixed declarations and code 

Changes from V2:
 - Drop External boost without VSPK Documentation
 - Move Shared boost to use values 2 and 3
 - Revert back to reg_sequence but reading the value first and only update
the necessary bits
 - Fix bug found by Intel kernel Test Robot

Changes from V1:
 - Fix Documentation patch subject
 - New patch for External boost without VSPK Documentation
 - New patch to fix boost IRQ overwriting issue
 - New patch to refactor IRQ release error code
 - reinit_completion on pcm_startup
 - fix DRE switch overwriting
 - return IRQ_HANDLED in PLL_LOCK case

Lucas Tanure (4):
  ASoC: cs35l41: Only disable internal boost
  ASoC: cs35l41: Refactor error release code
  ALSA: cs35l41: Add shared boost feature
  ASoC: dt-bindings: cirrus,cs35l41: Document CS35l41 shared boost

 .../bindings/sound/cirrus,cs35l41.yaml        |  10 +-
 include/sound/cs35l41.h                       |  13 +-
 sound/pci/hda/cs35l41_hda.c                   |   6 +-
 sound/soc/codecs/cs35l41-lib.c                |  73 +++++++++-
 sound/soc/codecs/cs35l41.c                    | 125 +++++++++---------
 sound/soc/codecs/cs35l41.h                    |   1 +
 6 files changed, 157 insertions(+), 71 deletions(-)

-- 
2.39.2

