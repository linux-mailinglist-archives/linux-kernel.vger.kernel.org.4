Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097BA749023
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjGEVsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGEVsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:48:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8BF198D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:48:06 -0700 (PDT)
Received: from localhost (unknown [188.24.137.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CAD0C6600B9D;
        Wed,  5 Jul 2023 22:48:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688593685;
        bh=X4jBCjEotkAu/UwZyifyK18UpJoKiAqALQAD8kiDayU=;
        h=From:To:Cc:Subject:Date:From;
        b=PVOMhYlaWetjlWsJLadfVSwt3pZfTmynd2X90/laNnM/kG4oDAEGKBCxhe68J9ltT
         mCSaW9RqEljCBwxlS5CikQZ/vnprYZ9fhgWuOR8dS9WOKzTyCu+wtXCaw8IlRc+wGd
         5r5N4dXrqaThPQvBYv5nlVnFgYKZVrjjzkrt+fX08Zgl59haLGx+JNAHEj7muxCNLv
         odO1ykHA7H0qnhGQD37xMvwT0D/LbFsuHSmsrQdKsVnKIAnoiW6x2mjk7hOZAP9qy0
         99m1eqvFp4IFdojEYdXRTxp5uAHKWXTvId4aiHEkgyg7HJfqPUhSJQil1W3iozr1hh
         XEhE9Ybh970uw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 0/3] AMD Vangogh support for NAU8821/MAX98388
Date:   Thu,  6 Jul 2023 00:47:57 +0300
Message-ID: <20230705214800.193244-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series extends the Vangogh machine driver to support a variant
based on the Nuvoton NAU88L21 Codec and the Analog Devices MAX98388 
Speaker Amplifier.

Changes in v3:
 * Dropped acp5x_max98388_hw_params() in PATCH 3/3 and rely on dai_link
   to set format, according to Mark's review
 * v2: https://lore.kernel.org/all/20230705134341.175889-1-cristian.ciocaltea@collabora.com/

Changes in v2:
 * Reworked series to ensure the existing devices based on the CS35L41 
   codec continue to work fine
 * Rebased onto next-20230703

Cristian Ciocaltea (3):
  ASoC: amd: vangogh: Make use of DRV_NAME
  ASoC: amd: vangogh: Use dmi_first_match() for DMI quirk handling
  ASoC: amd: vangogh: Add support for NAU8821/MAX98388 variant

 sound/soc/amd/Kconfig              |   5 +-
 sound/soc/amd/vangogh/acp5x-mach.c | 149 +++++++++++++++++++++++++----
 2 files changed, 131 insertions(+), 23 deletions(-)

-- 
2.41.0

