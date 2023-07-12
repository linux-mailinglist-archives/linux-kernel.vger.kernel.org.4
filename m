Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD9D7508C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjGLMxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjGLMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:53:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5929A1736
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:53:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9891c73e0fbso159261566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689166384; x=1691758384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ef9ldj54LfSreJO+VbHq1Yil94yCCRtncr0AA0IgxoI=;
        b=HZPxYS2q0wdP+oUdlVbS0bHA1gduL/QbI3aYqBTAD7g0jrxG3ckLP7O+qlZaCgpYtZ
         uR4tL/+dPcz2X7WQA7Fx5G0jEmaDPw2Hhj0hWt2d2dgvDINwW3fJ9RFCZgPA9NDBkJb5
         kZgq4OzAms76DQJFiMj/dA8201Fs9jVy+T1gw9BJIwYxEbnqt9CZPa1Yi9XAcVJYJGtm
         dTuHFo/YgPTWVnjwjFDJgMYaMbkZMTOHkjl9hN/mRikq8ZEUDstWunwXChiIZQ93QvNf
         N/sg+1KPo3DQA/CI8eCoAQaMO9n1/x2MW6pBZtB+m1YOE0718F6Wvr9mm4rOJU8SuPhc
         u1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689166384; x=1691758384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ef9ldj54LfSreJO+VbHq1Yil94yCCRtncr0AA0IgxoI=;
        b=acOGQIwxpjcCAIXkpIb8FD260mzuGwcqjSal+yfkMXHpSxvBh/eemwxf5Lc7WjwQ2u
         VwXAITmUgOinKXE42vZZWlj4LMk3ZHoH8siLXoOkmxLitm2+rY5VLy5EratXG463EoYq
         Zn2/mEa+4yvI9/s7hL3Gw2XBMhmH7f8lPjGwELmb9A0bKSb115WskGk5c4vNuDjpTzl8
         4eooqyA+U+jzbtvzDbB78HC5g41u1d96TUwzjrckzlvL0/sGwWMq3zxx6aULwIJ2KqNP
         RFi3kOeQgBW/ydV7GNZzVeyKnFlUqggzKPHyEX3xNsDwd8LlWAC1kEZt/0wElCbQWmlv
         Km3w==
X-Gm-Message-State: ABy/qLa17vpdNC4yq2z25R0tC37WYrYzaUobA8nSlr5NzdiIs4/svu+m
        Q5DoGW0mmNaYTfdrIpp5ZBI=
X-Google-Smtp-Source: APBJJlEQwzCXnLSG9Db+b/tZpzul5Q8lvD7Ip0hLgkyKGo/6GNq4Xfrpf2kkMy9+NX6RlyZ+hk/4uQ==
X-Received: by 2002:a17:906:64c2:b0:993:d632:2c3 with SMTP id p2-20020a17090664c200b00993d63202c3mr2421780ejn.21.1689166383605;
        Wed, 12 Jul 2023 05:53:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:c844:242b:b300:215:5dff:fe81:5e96])
        by smtp.gmail.com with ESMTPSA id l6-20020a170906230600b00991faf3810esm2544506eja.146.2023.07.12.05.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 05:53:03 -0700 (PDT)
From:   Matus Gajdos <matuszpd@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Matus Gajdos <matuszpd@gmail.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: Disable bit clock with transmitter
Date:   Wed, 12 Jul 2023 14:49:33 +0200
Message-Id: <20230712124934.32232-1-matuszpd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise bit clock remains running writing invalid data to the DAC.

Signed-off-by: Matus Gajdos <matuszpd@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 2 +-
 sound/soc/fsl/fsl_sai.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5e09f634c61b..dcc7fbe7acac 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -719,7 +719,7 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	u32 xcsr, count = 100;
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
-			   FSL_SAI_CSR_TERE, 0);
+			   FSL_SAI_CSR_TERE | FSL_SAI_CSR_BCE, 0);
 
 	/* TERE will remain set till the end of current frame */
 	do {
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 8254c3547b87..550df87b6a06 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -91,6 +91,7 @@
 /* SAI Transmit/Receive Control Register */
 #define FSL_SAI_CSR_TERE	BIT(31)
 #define FSL_SAI_CSR_SE		BIT(30)
+#define FSL_SAI_CSR_BCE		BIT(28)
 #define FSL_SAI_CSR_FR		BIT(25)
 #define FSL_SAI_CSR_SR		BIT(24)
 #define FSL_SAI_CSR_xF_SHIFT	16
-- 
2.25.1

