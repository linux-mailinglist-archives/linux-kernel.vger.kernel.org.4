Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288FD71FD11
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjFBJFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFBJEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:04:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2DD10D2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:03:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-97460240863so75007166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1685696629; x=1688288629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMKaght3EZRcwtR4hLhGpGozkma4rbwmuu+0lxvlO3A=;
        b=aG3Fb8X3K9WKKxNliXyqCzqEZZLOAoC6+28JL4RDvnce9WPai1yKdx0ChsOA6lzB7y
         sgOHuV1st30My66XqPWbpZNBLehHxsHl9kFZRb4hR8CuRGTZfAUA8pTLXzixnF/cixb5
         jPt1Pdg3POHJ5A2WTe56XJ2P0GNmJmOCmrvIIQUviHJgSY5tVV5CvfpKte6P6z/3oh4l
         PSHUkwTIQqidY85LpUOWYubwIctytCIgg7cbqb6ySfLJr/0Jw9w1RQU2wNtJGYmfrmaS
         RZyfs8UuR7zTmy/p6b+RZIJkHQg+dM/aGHLTvzNl2PD0I6gI2Ldpn2M+nbY4iTKv7H4X
         d5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696629; x=1688288629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMKaght3EZRcwtR4hLhGpGozkma4rbwmuu+0lxvlO3A=;
        b=h1XSIrra4ZWJHgx8Rgr9Je71Zd0czzyZnDiIh93ul/COcxn3vp3SiQiM54hj9pJUja
         dZ3ImXErdO3iC+IN2aB9a+HU8J1SEcT6sUomE7vE+t0Im9xFUOH22CkYRNI0i6r5hp4O
         FhV7k2udz6wExnSjpHU8dQiO//WWdvVGkuzy/3qHYpE0xwt1Q3FJdzItLdYsH3hnB8Rc
         HxoBW71NtvF9wmFDEI8W96eNOH47UFEUUBQR5vsHZl3iFq5t5kdlQLRPqW1PffXd7Qdo
         3YPxTh5Dv0C9BYzaAyuiXy/6wD4O3l1zDO9uVH35b9yT0+v01EM8c1xOJMp6Q0PlrDti
         gBMQ==
X-Gm-Message-State: AC+VfDx+MZxTv8uqLqHCMDtC+9BWohvcthnCcOc77XAgAux8qvQDvrpj
        ivaoVMVlt/1CpemA1KSdDVyb3Q==
X-Google-Smtp-Source: ACHHUZ4jmlviWCEZ9d2sqlZKV0HRtlTNsu09RrXOh72/ySDy+4DwbEEj8oyV65wODyolmmip16qHpg==
X-Received: by 2002:a17:906:d550:b0:974:6334:f6b2 with SMTP id cr16-20020a170906d55000b009746334f6b2mr806371ejc.22.1685696629567;
        Fri, 02 Jun 2023 02:03:49 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id w23-20020a170906385700b009707fa1c316sm488031ejc.213.2023.06.02.02.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 02:03:49 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ASoC: simple-card: parse symmetric-clock-roles property
Date:   Fri,  2 Jun 2023 11:03:21 +0200
Message-Id: <20230602090322.1876359-5-alvin@pqrs.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230602090322.1876359-1-alvin@pqrs.dk>
References: <20230602090322.1876359-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The property, when set, specifies that both ends of the dai-link should
have the same clock consumer/provider roles. As with other simple-card
properties, a prefix can be specified.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 sound/soc/generic/simple-card.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 5a5e4ecd0f61..4513e30948b7 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -181,6 +181,7 @@ static int simple_link_init(struct asoc_simple_priv *priv,
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
+	char prop[128];
 	int ret;
 
 	ret = asoc_simple_parse_daifmt(dev, node, codec,
@@ -188,6 +189,9 @@ static int simple_link_init(struct asoc_simple_priv *priv,
 	if (ret < 0)
 		return 0;
 
+	snprintf(prop, sizeof(prop), "%ssymmetric-clock-roles", prefix);
+	dai_link->symmetric_clock_roles = of_property_read_bool(node, prop);
+
 	dai_link->init			= asoc_simple_dai_init;
 	dai_link->ops			= &simple_ops;
 
-- 
2.40.0

