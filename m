Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B4174469E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 06:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGAEsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 00:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGAEsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 00:48:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50568E65
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 21:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Ouh+ENUfH7xDuVT7/QdgSLCq0AO5QpecmqQ9yR+vKU4=; b=5BOjmmRRZbyzHZwHcUwvpKsx0g
        z3P5naFfEu/0m6BSaanaNGWs0IRuQQBjI2xz2BRVJivDYa54kRd6nAFudndfJ41KsYlzYS9bpBIEo
        Jk+yvhFndjxf5pUexRyWK76ivhXUKoNgb/YzvdBzUi6CDAsM/8j1WWDo8sV0SW89W1qcqumHH4KEa
        pxRzobws8/Oz2fNBIWWeuAzP9w3Jj7Y6w6Pmc/GcV1WuOWOBXkSu6Q+x7t2/1iODekyJTH4LQtfz9
        rfAmqI+bgo2ITH9ai2jQ9nQadsFeDp8c0cwyq/9fGwl70hDCcIfEi6WY3q957fbrQ95rkuYjWj6N2
        /PRYpzcg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qFSXF-005AKU-1V;
        Sat, 01 Jul 2023 04:48:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: stac9766: fix build errors with REGMAP_AC97
Date:   Fri, 30 Jun 2023 21:48:36 -0700
Message-ID: <20230701044836.18789-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select REGMAP_AC97 to fix these build errors:

ERROR: modpost: "regmap_ac97_default_volatile" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
ERROR: modpost: "__regmap_init_ac97" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!

Fixes: 6bbf787bb70c ("ASoC: stac9766: Convert to regmap")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
---
v2: rebase/resend

 sound/soc/codecs/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1707,6 +1707,7 @@ config SND_SOC_STA529
 config SND_SOC_STAC9766
 	tristate
 	depends on SND_SOC_AC97_BUS
+	select REGMAP_AC97
 
 config SND_SOC_STI_SAS
 	tristate "codec Audio support for STI SAS codec"
