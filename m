Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E9773C1BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjFWVEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFWVEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:04:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3FC2114
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 14:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 686C161B5A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 21:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198ABC433C8;
        Fri, 23 Jun 2023 21:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687554289;
        bh=7hI9rVh1AROgGPI9A/ZuJDlHTrmVy3Qkk2LrdeMj2Kk=;
        h=From:Date:Subject:To:Cc:From;
        b=VlCJlzWiJhxlsIWBv4CSmwjV0upRi6bO6AsGQu1Ee+4kXm7LGHaaAD/uJGeLtSZjr
         q9M9qjSpKlw+cYOXxUlhV+qwBt/zshTr73l3O7zRynpFoEINfId2hV8uMFHvPHbLib
         DzuSLSfdOILXsnOUOu9tedmGJSejKmy+n+Rp7mTr9lV2MEaw1A7cZHj/xhZoqiwm/R
         C581VpO+YtYn/NaaZl9NUR4dltaNMZxP6giVB+/VUmXO8vTKa72OUDIBOWQ36A7bWN
         JPqa2n7fMeveCGq4CNTld6Lk+vgpKvSa66ztmQ26zFHZ5TbfUqwTMnQ8/x19I0yKUr
         66I4HFPC6tFHg==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 23 Jun 2023 22:04:39 +0100
Subject: [PATCH] ASoC: core: Always store of_node when getting DAI link
 component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230623-asoc-fix-meson-probe-v1-1-82b2c2ec5ca4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOYIlmQC/x3NwQqDMBCE4VeRPXeLSazQvkrpIRvHmkMT2YVSE
 N+90ePP8DEbGTTD6NFtpPhmy7W0cJeO0hLLG5yn1uR7H/rRB45WE8/5xx9YLbxqFfB9QJqcCwI
 RalSigUVjScuBTzNeb8e0Kpo+H5+vff8DeQlCsoEAAAA=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=2220; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7hI9rVh1AROgGPI9A/ZuJDlHTrmVy3Qkk2LrdeMj2Kk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBklgju/hRIWDmE+d0m//kTBjqBjvxFk+xPU8keL
 uIdzkUSermJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZJYI7gAKCRAk1otyXVSH
 0KeCB/47Tcfz9mxx4ktjj+ob071MA3r7VDmxA4L4Y8SZmFa15oo3ev5L1UnwYw02OZciRhTspyB
 DdRPC3Ws7UxmCX/cvSlAdcq9ZV6OcCzmhkTRlMC7coRblp5PuopGC40rNDXfI9pPri08Z6wGaHX
 wk3TBK6iL1Rb7u1e/QL8Z+S6SUt1OVv4L1wWytnqb34u+zx4Aa1wPF+VJb7cOtU3b2ch9urcBCw
 HzGE3jaKBWaWyhAG6irJ8zJcq2AbYXAIv99WxMahylDkz3UvAlU+cd4I2wQES+xtC7KFmxf803u
 l/CQOrhnlNf/Qe6oIyUA/KQ6qIwxnRXMLx6sRq/kfH8VvHSE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic snd_soc_dai_get_dlc() contains a default translation function
for DAI names which has factored out common code in a number of card
drivers, resolving the dai_name and of_node either using a driver provided
translation function or with a generic implementation. Unfortunately the
of_node can't be set by the translation function since it currently doesn't
have an interface to do that but snd_soc_dai_get_dlc() only initialises the
of_node in the case where there is no translation function.

This breaks the Meson support after conversion to use the generic helpers
since the DPCM cards for it check which component of the SoC is connected
to each link by checking the compatible for the component and the Meson
components provide a custom operation so don't use the generic code.

Fix this and potentially other cards by unconditionally storing the node in
the dai_link_component, there shouldn't be a binding specific of_node
selected since that's how we determine the translation function.

Fixes: 2e1dbea1f8a3 ("ASoC: meson: use snd_soc_{of_}get_dlc()")
Fixes: 3c8b5861850c ("ASoC: soc-core.c: add index on snd_soc_of_get_dai_name()")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f06a20773a34..11bc5250ffd0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3262,6 +3262,8 @@ int snd_soc_get_dlc(const struct of_phandle_args *args, struct snd_soc_dai_link_
 	struct snd_soc_component *pos;
 	int ret = -EPROBE_DEFER;
 
+	dlc->of_node = args->np;
+
 	mutex_lock(&client_mutex);
 	for_each_component(pos) {
 		struct device_node *component_of_node = soc_component_to_node(pos);
@@ -3300,7 +3302,6 @@ int snd_soc_get_dlc(const struct of_phandle_args *args, struct snd_soc_dai_link_
 				id--;
 			}
 
-			dlc->of_node	= args->np;
 			dlc->dai_name	= dai->driver->name;
 			if (!dlc->dai_name)
 				dlc->dai_name = pos->name;

---
base-commit: 154756319cc6f8b8b86241da02da6a8fcc6abd1f
change-id: 20230623-asoc-fix-meson-probe-94ecd113bebb

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>

