Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAED064C927
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiLNMjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiLNMjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:39:24 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713DB1DF0B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:38:07 -0800 (PST)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A2FE385163;
        Wed, 14 Dec 2022 13:38:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671021485;
        bh=aZYpr7PdIIEjRHAo8aMLeYDllEQgPdCTCsRbDEX5RrE=;
        h=From:To:Cc:Subject:Date:From;
        b=jdIEWdtiQi/UuZ1yVszQKCK5h9Qg9GUZVF38U3I9a3Y2XQtr8QLlbCLiWSm3BV7nP
         oCLOl76rJzoC4jAo2eiOWGonPPRp/+u4cRqYV6D/Zj8+4BAcz+bdkaNYEMFfw7mL3M
         0B9UT3uoY7CNfS4fVcYe2xl1UIQuBmNxgtj8taM5JVLyfLCFqsDt0Ion9Lv5KdtttP
         nXkuWEjl7o1znyRvKvE99vnqL1qkcGKW8rtIVloAsqlb+/GeWTRggWME2od6R3dWwh
         V3jPF1jmnWAk9c5oKacT8lBUA6i/TvotzFP+kVuzWidgA8Kzk3DQy7EA/coXcsumdH
         X0xb4RA0rrVpg==
From:   Lukasz Majewski <lukma@denx.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 0/4] ASoC: Fixes for WM8940 codec
Date:   Wed, 14 Dec 2022 13:37:39 +0100
Message-Id: <20221214123743.3713843-1-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides fixes for WM8940 codec.

The most notable change is the clock rewrite, so this driver now
can either generate proper clock frequency by itself or use one
provided from the clock subsystem of the SoC.

Lukasz Majewski (4):
  ASoC: wm8940: Remove warning when no plat data present
  ASoC: wm8940: Rewrite code to set proper clocks
  ASoC: wm8940: Mute also the speaker output
  ASoC: wm8940: Read chip ID when wm8940 codec probing

 sound/soc/codecs/wm8940.c | 129 +++++++++++++++++++++++++++++++-------
 sound/soc/codecs/wm8940.h |   6 ++
 2 files changed, 111 insertions(+), 24 deletions(-)

-- 
2.20.1

