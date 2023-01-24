Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D778679EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjAXQkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjAXQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:40:04 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583166EB5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:39:59 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso11399008wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQbzhX3O4aLcuVdNK/dk+Vykc3yQgk316tpQ75kYYpw=;
        b=YWpr991DzZrpCyQD8H8S0rLyjvLpctwo+i6CeAnK+xOkNgDE8l94ht4zYl4pfCkSdF
         ejQNUFYhLR+W72nLyRG2ge6gMOXWrXbTeHAoQQyaNHLUjg8KC41RXe8QkDn+vUPzvims
         GxEbXoFeHMf/vFz4vFRP8LPvk39IK7CtXm0r9Zg+DOhTl7Z1GGCRDks24B6Jui9hUPqi
         NlEen2SWlJJT898HeQK2rnNObiMeUUSqaReAmRQoutH4vJvHKYbBveRozdz/KKg8Awud
         xDSfdiN64mK5SgKZRPC41JDAO5o7dWWkwpDgrk6h1DSRGcP/c1Wk2bIPUu/dcPX2h4Co
         UfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQbzhX3O4aLcuVdNK/dk+Vykc3yQgk316tpQ75kYYpw=;
        b=cqnRTSkwvQksktFtGwRZWU0AUvy/EN5Qijq0QtZbeRAGDPwv3GbIeDOPmXdNMaDK59
         ykvqdDNV+4VsZV9m1KPTOTo0nVwxG9YGPl82/X4VqwSIJDMOdjwv97lU7HihZu2GQLCt
         WAXBwsYZLmRjXdFDnOF05NLgqckxWpLcJz8qUvW4dRZolEzIevFijT8kh8uKTumZkHlX
         o1i7Vatzp8P2/76yCjghFq4DCQ2hzMKAyjt/fiyqNz084haU+G+xIs1zC8280cnGzDXi
         7aPN7vTDbxhraIm/xsmqoUUpelxi1IHCJTyKPmHCk0W+qFCq+bhx0oon1JgsVCFh7V4f
         Up5A==
X-Gm-Message-State: AFqh2kp76+XyAoV0OYQBzSPVTLyZEqFX6v0+k6bipYfT0e7pojcWf6hr
        Hofl1Q0h8C/yWnEdpLfMxHYERg==
X-Google-Smtp-Source: AMrXdXsf91JtIJ7nxf2E6Wp9UE/5gAhd0nWlaK0s4hgMqucVu7KQENRzpgWj9EikZa7aj7A4qseFyQ==
X-Received: by 2002:a05:600c:3ac8:b0:3da:270b:ba6b with SMTP id d8-20020a05600c3ac800b003da270bba6bmr29759259wms.41.1674578397895;
        Tue, 24 Jan 2023 08:39:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h20-20020a1ccc14000000b003dafbd859a6sm13477147wmb.43.2023.01.24.08.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:39:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ASoC: codecs: constify static sdw_port_config struct
Date:   Tue, 24 Jan 2023 17:39:52 +0100
Message-Id: <20230124163953.345949-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124163953.345949-1-krzysztof.kozlowski@linaro.org>
References: <20230124163953.345949-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct sdw_port_config is not modified, so make it a const for code
safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 2 +-
 sound/soc/codecs/wsa883x.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 35bd6f7727ed..d142ca9f2fb6 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -424,7 +424,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
 	}
 };
 
-static struct sdw_port_config wsa881x_pconfig[WSA881X_MAX_SWR_PORTS] = {
+static const struct sdw_port_config wsa881x_pconfig[WSA881X_MAX_SWR_PORTS] = {
 	{
 		.num = 1,
 		.ch_mask = 0x1,
diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 4fc7c01c27ae..de3f4b9b0dba 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -522,7 +522,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA883X_MAX_SWR_PORTS] = {
 	}
 };
 
-static struct sdw_port_config wsa883x_pconfig[WSA883X_MAX_SWR_PORTS] = {
+static const struct sdw_port_config wsa883x_pconfig[WSA883X_MAX_SWR_PORTS] = {
 	{
 		.num = 1,
 		.ch_mask = 0x1,
-- 
2.34.1

