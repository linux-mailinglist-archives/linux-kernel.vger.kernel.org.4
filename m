Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B7691B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjBJJT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjBJJTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:19:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B3E5AB16;
        Fri, 10 Feb 2023 01:19:48 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1E1D766020E1;
        Fri, 10 Feb 2023 09:19:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676020786;
        bh=bcTEB5behk+3CjFXvFCGBI3SS/+zk38IRBQan1mcZck=;
        h=From:To:Cc:Subject:Date:From;
        b=IGKmteq2Wdd2d34t/OeHy23Ubr4WFmME7/qtFxYKJs6SAEpFqqylgDVbWhy+Dhiki
         KbckeAdPuYkM3Rx5nOi8Pii3iuserGBrALwnu7KNR5pvlA0nu9UvZ4LouMqhimwHGN
         B3TTqfXWuyBcmCfCFETGdLB8hXPAfsWpiRqRgQpXa/zBuMOMXcM2WPRTnaN317GA+m
         BixWoFLIV1Ej8wSJmw51vGmISPxfedJmAO3vmMgBwEBkB6tcJpu5k7pDkPMvUOl6is
         LBnpZAKZ7S4UEEDp2KpEaf1TLQ/2JTmgTajb+OtwJCoUJCBdU/iIECcaXcKcSI0WfK
         I+YaqTAAS0r3w==
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
Subject: [PATCH v5 0/4] Add CS35L41 shared boost feature
Date:   Fri, 10 Feb 2023 09:19:38 +0000
Message-Id: <20230210091942.10866-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.1
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
2.39.1

