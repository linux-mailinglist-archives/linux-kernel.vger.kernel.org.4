Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A6871F0C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjFARac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjFARab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:30:31 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3411A2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:30:25 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 4m7qqKkRYe9XV4m7qqJitg; Thu, 01 Jun 2023 19:30:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685640618;
        bh=rhggJM25UscX66J1Ug1pJJ1oVkQChGg3ni6GqVZhFI0=;
        h=From:To:Cc:Subject:Date;
        b=hEQw/usFf5yS+y9l4ClFR8rgeZwr2277zC+d2Mk73yPZjHgov2C9HuWtcnxXuChk3
         wD8vpbixpGVJtCJoCRO3FNPLN8dON09RpnfHLZbYdz8sheqbwP/nrdWgN1ERr2kIMx
         LkrEFfXDsYMJmUDxGpbh3sfPP0cK5Lxe4hKUc0Br7+GXhSSe4WUjwFnwA18lEb9nXh
         fYQCz1GoLvK946K59PwI7IAbtVItKflaWfb0yS6dsU3uK6k4uTe1mPyBwtkQ0A99cu
         S0OphpjdSucfnF2u9NJ4wUzWLIVvUAaq08Xx8GayAB5iILrKzn7Xke+Ja+ZT/Ov3Yi
         HcGfLUBumtO1A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 01 Jun 2023 19:30:18 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: ipc4-topology: Use size_t for variable passed to kzalloc()
Date:   Thu,  1 Jun 2023 19:30:12 +0200
Message-Id: <a311e4ae83406f714c9d1f7f2f857284265e581c.1685640591.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct_size() checks for overflow, but assigning its result to just a u32
may still overflow after a successful check.

Use a size_t instead in order to be cleaner.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Based on analysis from Dan Carpenter on another patch (see [1]).

[1]: https://lore.kernel.org/all/00e84595-e2c9-48ea-8737-18da34eaafbf@kili.mountain/
---
 sound/soc/sof/ipc4-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index db64e0cb8663..50faa4c88b97 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -881,7 +881,7 @@ static int sof_ipc4_widget_setup_comp_process(struct snd_sof_widget *swidget)
 	/* allocate memory for base config extension if needed */
 	if (process->init_config == SOF_IPC4_MODULE_INIT_CONFIG_TYPE_BASE_CFG_WITH_EXT) {
 		struct sof_ipc4_base_module_cfg_ext *base_cfg_ext;
-		u32 ext_size = struct_size(base_cfg_ext, pin_formats,
+		size_t ext_size = struct_size(base_cfg_ext, pin_formats,
 						swidget->num_input_pins + swidget->num_output_pins);
 
 		base_cfg_ext = kzalloc(ext_size, GFP_KERNEL);
-- 
2.34.1

