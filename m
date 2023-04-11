Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DEA6DCE83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 02:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjDKAes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 20:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDKAeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 20:34:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D75A13A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:34:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 184-20020a2515c1000000b009419f64f6afso7257710ybv.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681173284;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VV8PXIioY+lpB4ukX6X0D5BOfhtAOO5OAgem+yfBPzU=;
        b=MmK3pxBNM65yrkcmg8H132ZjPXqBIfU8z53aiLZbcxVHdcwb5CxL8/4Ji3dTd45Ip+
         LH4bIxVQsf56Vf+CzVcoUVCFcU/eEyCgoDSaYc+HqLLM7hM8dqa102ICTIcGv7qsMHi1
         J/xwCIAjHtxOMJaInNbFK8BeHNh/qjqh7EY4zQ2YwOTKUbt29zBQmAN3AqYH6uuXGbEH
         UiXkilwXN53YlQxZZVx2k9i8YWOSaYRcLTkImGjjcDnk3DzPFom7ZZKbhapeq4ayIQfp
         n04N3l/3G+PsiwKyKl3fdGBEo5ieR6beOSTFl9D01wkPtnHUs3jQlqmZY/Nr/kfSC7YE
         pabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681173284;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VV8PXIioY+lpB4ukX6X0D5BOfhtAOO5OAgem+yfBPzU=;
        b=AqG9JhEKWJwIGiNMWjRuNiM8+KnYLp2albgbrAfy12mR92bejmIYVX9pWfWN0iTnmf
         fDKH6RQdBxuPK/hAje+cxwmxYEXiCRwhTkVNaA/p92ycHhNEXECE0U2yprmyCxYt6Sta
         5jSMcCaryqOZzp6oIx2jGrsj0GCaMGNsoqk60adp5rsgaNx8KdrymI4joRqbMz1bWYPE
         eCbbHTQRtNjSWolLurpk7j4aWkg443XQ+H7zCPX6QVFWELabhRUasDshW5mG5Y0UH/xw
         nAEzmaC1xsO7NwDzaxQ9s+qEMBle9wkx7THgduEB9qh0vndO0hfBUQwxBVfT2fFr2QZ+
         judg==
X-Gm-Message-State: AAQBX9cqrpqw4RR3lH13onohjC7lDwPSnNucQIqNTg+pWV3QZgMJljdk
        iUZsHUy8LG6L7mJR5YPXTR+bICCSHj+r
X-Google-Smtp-Source: AKy350ZOwDyxZ5zmnvjOtmK+m8d2Zb+sInKjo5gza1IG8xreF6QccHiFCV8qDL7zjDXDQLZcFmYPSNKGp1ua
X-Received: from ezekiel.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:108e])
 (user=shraash job=sendgmr) by 2002:a81:b284:0:b0:544:94fe:4244 with SMTP id
 q126-20020a81b284000000b0054494fe4244mr636814ywh.10.1681173284695; Mon, 10
 Apr 2023 17:34:44 -0700 (PDT)
Date:   Tue, 11 Apr 2023 06:04:31 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411003431.4048700-1-shraash@google.com>
Subject: [PATCH] ASoC: mediatek: common: Fix refcount leak in parse_dai_link_info
From:   Aashish Sharma <shraash@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Aashish Sharma <shraash@google.com>,
        kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing of_node_put()s before the returns to balance
of_node_get()s and of_node_put()s, which may get unbalanced
in case the for loop 'for_each_available_child_of_node' returns
early.

Fixes: 4302187d955f ("ASoC: mediatek: common: add soundcard driver common code")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Link: https://lore.kernel.org/r/202304090504.2K8L6soj-lkp@intel.com/
Signed-off-by: Aashish Sharma <shraash@google.com>
---
 sound/soc/mediatek/common/mtk-soundcard-driver.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
index 7c55c2cb1f21..738093451ccb 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
@@ -47,20 +47,26 @@ int parse_dai_link_info(struct snd_soc_card *card)
 	/* Loop over all the dai link sub nodes */
 	for_each_available_child_of_node(dev->of_node, sub_node) {
 		if (of_property_read_string(sub_node, "link-name",
-					    &dai_link_name))
+					    &dai_link_name)) {
+			of_node_put(sub_node);
 			return -EINVAL;
+		}
 
 		for_each_card_prelinks(card, i, dai_link) {
 			if (!strcmp(dai_link_name, dai_link->name))
 				break;
 		}
 
-		if (i >= card->num_links)
+		if (i >= card->num_links) {
+			of_node_put(sub_node);
 			return -EINVAL;
+		}
 
 		ret = set_card_codec_info(card, sub_node, dai_link);
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(sub_node);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.40.0.577.gac1e443424-goog

