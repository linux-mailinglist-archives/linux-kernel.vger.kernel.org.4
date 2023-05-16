Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743F0705AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjEPWha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjEPWhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:37:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84F36182;
        Tue, 16 May 2023 15:37:07 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52c6f8ba7e3so13605808a12.3;
        Tue, 16 May 2023 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684276627; x=1686868627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MJGpY/NrMrg0JPSvmjgjr2tdaUCxwO0LhI4q74mpwfE=;
        b=ska/yoAStgLqoC6IkwvPhKPiq7vXwb59GUYHSaIf8DtpCSLlwOU2aYHAo0+P+Re1AN
         XdEGGSOwLUK9aJJ/qgqkhxfk/cCLHHy7RUBItrWoWClEskoawObzfeLdKUN5Ac8lE/74
         oTUOI8oscxXl8UCiwBmd0lVKStdoA3jxLWruQWGw3hmlT5YuNOKTVVQsIs1EIJZtMAIE
         su0MNU7RgNu5h4ImCfRd5HyTfFfr9jHslAQH9PFLzLN66JbAPR7PvWbJqodEwo6jm/5X
         p0YETctd9o3jsJTE5IEk9C9Qsvx1JcAM6GX8NYjDQn+/Zka0fAk+xtBRLGRqHv0NAm1i
         ndTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276627; x=1686868627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJGpY/NrMrg0JPSvmjgjr2tdaUCxwO0LhI4q74mpwfE=;
        b=f8WkRj261eJcbafeJHl3UZP+ZzVS5smb4jIpz7IIX9LBZRMoPkm9dXj1p52KdF/W4m
         /W1di7KVTHhvIUbaCsqeHUaS2OQSWO5g3P4T+zh2kQTrZolD53phuS78p+6ryxtIx0MW
         aRlo6eTrZK+M1l7v7r1auIOpjWhZnOyiI3aVv7lBlQuxj4Xo+/NThNQ5u+bj1wEBqhDM
         /yvlRbDp92B8iESPCqImgRrM4qtauyQLcMZbMmEtoQtPU3ujAbbiYqvS9vX3eAPNnwUU
         MznNqVIiuz2ytXRnzk0w4oXX/UUeDiE+d7G0UpbnJSFZhwOhCSRsWMVyGqujXG+hUbO/
         rhQw==
X-Gm-Message-State: AC+VfDxt2NPTF3Ky+VAJoJ6uDmUamVkR8x8Zjp0F3Jslf1kRBOS1qUCk
        /gIRZP6uy73MLXzO8yjKnkgSaiKvD8c=
X-Google-Smtp-Source: ACHHUZ4UgpIFYQ3VqL6Zs6iIB+uR3kp7qBDoMHFkDx/rQyJ5l2jMSu8mNXq5xOPBWr7JyPCo88kaVA==
X-Received: by 2002:a05:6a20:7f9d:b0:105:66a1:5d05 with SMTP id d29-20020a056a207f9d00b0010566a15d05mr15148395pzj.55.1684276627209;
        Tue, 16 May 2023 15:37:07 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-97-28.dynamic-ip.hinet.net. [36.228.97.28])
        by smtp.gmail.com with ESMTPSA id b20-20020aa78714000000b0062dbafced27sm11961983pfo.27.2023.05.16.15.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:37:06 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tegra: tegra210_adx: fix snd_pcm_format_t type
Date:   Wed, 17 May 2023 06:36:59 +0800
Message-Id: <20230516223700.185569-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use snd_pcm_format_t instead of unsigned int to fix
the following sparse warnings:

sound/soc/tegra/tegra210_adx.c:125:14: sparse: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/tegra/tegra210_adx.c:128:14: sparse: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/tegra/tegra210_adx.c:131:14: sparse: warning: restricted snd_pcm_format_t degrades to integer

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 sound/soc/tegra/tegra210_adx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra210_adx.c b/sound/soc/tegra/tegra210_adx.c
index 41117c1d61fb..bd0b10c70c4c 100644
--- a/sound/soc/tegra/tegra210_adx.c
+++ b/sound/soc/tegra/tegra210_adx.c
@@ -109,7 +109,7 @@ static int __maybe_unused tegra210_adx_runtime_resume(struct device *dev)
 
 static int tegra210_adx_set_audio_cif(struct snd_soc_dai *dai,
 				      unsigned int channels,
-				      unsigned int format,
+				      snd_pcm_format_t format,
 				      unsigned int reg)
 {
 	struct tegra210_adx *adx = snd_soc_dai_get_drvdata(dai);
-- 
2.34.1

