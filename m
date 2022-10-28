Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A08611AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJ1TOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJ1TN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:13:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F6D242CA0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:13:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k2so15227425ejr.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pbLU8G2nPUHM4Aab1zDWh7+8gBmTVjh77cKTi8zqoN8=;
        b=iB/0wWsjCnaggGgC/IT/FEvhnyhXnoD47LxIjJOB1HtLYBtTNgbRYrnvcSTVG659yR
         40c7ER61HF7eRuVIKqMstbMzUP1iSh6aCvp8Zx5ZfU0yyyF/98c0SncHaxIicILYnrk7
         gvkB4yXgIU9D7CD1UXfOMGShMGPIVvYTqkU+DcBYvHNsmrtoF3ez4Y23JDYiM13TE6t2
         +vAqNaUITbL9z+EnwnMt7D0c0Ve5r1rz/s1xwOYgC8zYcWK28vJ1mS/5FA4tZEMMG7O3
         6HwR512UXMTC0Af8L1CCXU2KyeAYDXds3FazhwL/Q4ZdSbWCnU7jhm01GuN42O0RYCL1
         2GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbLU8G2nPUHM4Aab1zDWh7+8gBmTVjh77cKTi8zqoN8=;
        b=q3F3leurbZuq+1efHepe0xIEqlmPmwEZJ4o2KSyod4A60PP3z2UOhks7M1UGPRXmlp
         S2lkosptvMjuw4HHyF92p9lp/fep8sayc6a5/jktj73fa1c/G7B1NwvEgVf1ZznBKf9R
         rVwWDVJTx6Nl6jqaelknvbrfVP1/e11g0hmT7t+aKJaGUk4TFxD2opkYLm08HPLYTZK9
         ymAO1WCydmmOu6BDxRu6H1S0Ilg9jfeUR9HLRTroUScQGVjtAlDITdZGuDAVLcFdiSMZ
         FUECpGXFiiog1jsJfPK5lTPDWObxoqbXGJBsLI5bbUdt44DeXbrfW8zFu/NkU5APqdEq
         M0SA==
X-Gm-Message-State: ACrzQf13B5A23yBCQFSmWrpSO1rYco4gINBwvke9no2fDCuht0Yq8jIo
        IbHiJC0GX9l0r0uglccqqTvKRQ==
X-Google-Smtp-Source: AMsMyM5uCxbSrhg0tSnHUKHalAicTtK/sVJNhz5Eofzc65Oicx6YsX2ct3ebblLWKywVW+0w+4Vufg==
X-Received: by 2002:a17:906:d550:b0:7ad:a0df:d4c1 with SMTP id cr16-20020a170906d55000b007ada0dfd4c1mr780615ejc.210.1666984434295;
        Fri, 28 Oct 2022 12:13:54 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id hr25-20020a1709073f9900b007aacfce2a91sm2568922ejc.27.2022.10.28.12.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:13:53 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        alexandre.belloni@bootlin.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: simple-mux: add read function
Date:   Fri, 28 Oct 2022 21:13:01 +0200
Message-Id: <20221028191303.166115-1-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During initialisation DAPM tries to read the state of the MUX
being connected, resulting in this error log:
input-mux: ASoC: error at soc_component_read_no_lock on input-mux: -5

Provide a read function which allows DAPM to read the state of the
MUX.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---
 sound/soc/codecs/simple-mux.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/simple-mux.c b/sound/soc/codecs/simple-mux.c
index d30c0d24d90a..bf67de12d20b 100644
--- a/sound/soc/codecs/simple-mux.c
+++ b/sound/soc/codecs/simple-mux.c
@@ -55,6 +55,14 @@ static int simple_mux_control_put(struct snd_kcontrol *kcontrol,
 					     e, NULL);
 }
 
+static unsigned int simple_mux_read(struct snd_soc_component *component,
+				    unsigned int reg)
+{
+	struct simple_mux *priv = snd_soc_component_get_drvdata(component);
+
+	return priv->mux;
+}
+
 static const struct snd_kcontrol_new simple_mux_mux =
 	SOC_DAPM_ENUM_EXT("Muxer", simple_mux_enum, simple_mux_control_get, simple_mux_control_put);
 
@@ -76,6 +84,7 @@ static const struct snd_soc_component_driver simple_mux_component_driver = {
 	.num_dapm_widgets	= ARRAY_SIZE(simple_mux_dapm_widgets),
 	.dapm_routes		= simple_mux_dapm_routes,
 	.num_dapm_routes	= ARRAY_SIZE(simple_mux_dapm_routes),
+	.read			= simple_mux_read,
 };
 
 static int simple_mux_probe(struct platform_device *pdev)
-- 
2.37.3

