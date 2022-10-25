Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E025860CC15
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiJYMmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiJYMmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:42:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2AC18B77D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:41:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v1so20607519wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIKotX5ooYCDPVEKi3IZCfl55eak5yxZs56MABYXuTk=;
        b=WM9o7GxTlXLmPNHjXk2Fn1+OVVEmRPipyhgvnOuYvoqTrzNOxH1gBm7FQLhnAG3AtX
         E3FkjRghlQQoSWLyK5i95gFBdGiD9sShrvBlg2LkIKJ3Cuqeq0jNFbOOklfwvpGCDxTN
         qrIKz6Z9rEuahjhhtdWP8D7OWZS24e8w0tcIW128tcn5KbQzDeZ8AS87BAAWjRMtArDX
         16Ti6CdwDxDcsTO6H4+NpzzskolLqwR4Vdu68xIorqXov7Q91Crf10M+VjbCxIeq07Hk
         b3WsaG5U3lrbesOzUDIHnhQnL/+mJdsruiBxaOxpiRDJfbqLTgdYMcIi3taTmS8SJxkn
         wPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIKotX5ooYCDPVEKi3IZCfl55eak5yxZs56MABYXuTk=;
        b=6qj9rJIXJ7b+lQWimHK/GawpftOSgMQokzV7UtlVP6GSCHDJIF3TuML/3IvDUekmBm
         qU+Rol7a1zoEp3BR9sGn7ywqzjmQ4iB/NAQ7BS40m2QPU9ruxg68Qu9aE8KEJCh4u3Ln
         Vva3iXXLDHgNAhrpObZ1wVsk/Y2ApWjG3Fvv+JYNzxu5wMoLHk57UmuQE/lQl2wCO0zG
         mqkHrx9BSEWEuQHKiWfWWwa19zQelUpg6hoER9L23FkoBtr0PLDurVWf5rA8NhYnrlxL
         EILnjL1EyVOqlXXusSK2g1PLW6HSwygBg/EInz8Etu3wUi/vmduPVENjd/8u86DIx2A5
         rgyg==
X-Gm-Message-State: ACrzQf3ibcjm5cO1brHFnWeZHJ3uDemzXHdr/vZob+xYIzwQHtehfnt7
        dO+7hm+hX0ThuupQtLsZsKY=
X-Google-Smtp-Source: AMsMyM60B8oxsFHLS4Cs0RPNNh1I7NmYcXnq2aWXeGunVPT5z/H92YLK84eclOwVh4IjAMrLrTtXCw==
X-Received: by 2002:a1c:4454:0:b0:3cf:4792:d3ad with SMTP id r81-20020a1c4454000000b003cf4792d3admr886197wma.5.1666701718486;
        Tue, 25 Oct 2022 05:41:58 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b003a1980d55c4sm11250664wmb.47.2022.10.25.05.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 05:41:58 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ASoC: rockchip: i2s_tdm: Make the grf property optional
Date:   Tue, 25 Oct 2022 14:41:30 +0200
Message-Id: <20221025124132.399729-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025124132.399729-1-frattaroli.nicolas@gmail.com>
References: <20221025124132.399729-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only IO Multiplex and two TRCM modes need access to the GRF, so
making it a hard requirement is not a wise idea, as it complicates
support for newer SoCs which do not do these things.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 2550bd2a5e78..917f17107891 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -756,6 +756,12 @@ static int rockchip_i2s_io_multiplex(struct snd_pcm_substream *substream,
 	if (!i2s_tdm->io_multiplex)
 		return 0;
 
+	if (IS_ERR_OR_NULL(i2s_tdm->grf)) {
+		dev_err(i2s_tdm->dev,
+			"io multiplex not supported for this device\n");
+		return -EINVAL;
+	}
+
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		struct snd_pcm_str *playback_str =
 			&substream->pcm->streams[SNDRV_PCM_STREAM_PLAYBACK];
@@ -1222,6 +1228,12 @@ static int common_soc_init(struct device *dev, u32 addr)
 	if (trcm == TRCM_TXRX)
 		return 0;
 
+	if (IS_ERR_OR_NULL(i2s_tdm->grf)) {
+		dev_err(i2s_tdm->dev,
+			"no grf present but non-txrx TRCM specified\n");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < i2s_tdm->soc_data->config_count; i++) {
 		if (addr != configs[i].addr)
 			continue;
@@ -1568,10 +1580,6 @@ static int rockchip_i2s_tdm_probe(struct platform_device *pdev)
 		return ret;
 
 	i2s_tdm->grf = syscon_regmap_lookup_by_phandle(node, "rockchip,grf");
-	if (IS_ERR(i2s_tdm->grf))
-		return dev_err_probe(i2s_tdm->dev, PTR_ERR(i2s_tdm->grf),
-				     "Error in rockchip,grf\n");
-
 	i2s_tdm->tx_reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
 								      "tx-m");
 	if (IS_ERR(i2s_tdm->tx_reset)) {
-- 
2.38.1

