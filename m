Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC94068DDE1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjBGQZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjBGQZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:25:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2121526873;
        Tue,  7 Feb 2023 08:25:39 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 691776602083;
        Tue,  7 Feb 2023 16:25:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675787137;
        bh=31IOxFAe/uIvuzK/A+EiEaSGYIq/CqYNbT9qcYN/ap0=;
        h=From:To:Cc:Subject:Date:From;
        b=WJexhMKVMZ42nwHjTQdqi004u44KDYcawU/7IqdygN4EMpd5qH5ZvSJPPT0R5RdQv
         9sPMvgY6ElcZ5bhQX1PHm4bo9A3J3j8xzgDc8R3q+x6CsbKvFxS+SuWFfumO8zXHkb
         tHcn+/sLVJ/bngvCdxCf6rUk9c/oeNIv0qdUBybgAdo708mZt9HaaNnlsqeQiFLHeW
         FlOU/Wr+ygpAuejKCE7hFspSAyXjXiKcZmNgTH58XCb80ZJDF5I7ONjBRT2g4vdZ/B
         kIZr0HypTv2zVl4G4qf3pyk7y1zVkdtgLjNDIpgP3xrWIcVaTAJWXAcIgE9voyfSkX
         pjmS8p1Y9pdDA==
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
Subject: [PATCH v2 0/5] Add CS35L41 shared boost feature
Date:   Tue,  7 Feb 2023 16:25:21 +0000
Message-Id: <20230207162526.1024286-1-lucas.tanure@collabora.com>
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

Valve's Steam Deck uses CS35L41 in shared boost mode,
where both speakers share the boost circuit.
Add this support in the shared lib, but for now,
shared boost is not supported in HDA systems as
would require BIOS changes.
Based on David Rhodes shared boost patches.

Also, fix boost config overwriting in IRQ found
in the review and do a small refactor of the code.

Changes from V1:
 - Fix Documentation patch subject
 - New patch for External boost without VSPK Documentation
 - New patch to fix boost IRQ overwriting issue
 - New patch to refactor IRQ release error code
 - reinit_completion on pcm_startup
 - fix DRE switch overwriting
 - return IRQ_HANDLED in PLL_LOCK case

Lucas Tanure (5):
  ASoC: cs35l41: Only disable internal boost
  ASoC: cs35l41: Refactor error release code
  ALSA: cs35l41: Add shared boost feature
  ASoC: cs35l41: Document CS35l41 external boost without VSPK
  ASoC: cs35l41: Document CS35l41 shared boost

 .../bindings/sound/cirrus,cs35l41.yaml        |  12 +-
 include/sound/cs35l41.h                       |  10 +-
 sound/pci/hda/cs35l41_hda.c                   |   6 +-
 sound/soc/codecs/cs35l41-lib.c                |  56 +++++++-
 sound/soc/codecs/cs35l41.c                    | 125 +++++++++---------
 sound/soc/codecs/cs35l41.h                    |   1 +
 6 files changed, 139 insertions(+), 71 deletions(-)

-- 
2.39.1

