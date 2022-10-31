Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361B5613607
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiJaMXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiJaMWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:22:50 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3288F59C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:22:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so5761388pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SIKG/oo700nGZV4lbYvo18YgIVmpoqqm9J9pS6SKop0=;
        b=pSFqsqmB6iD2hTJHlxCmZ5NN1/0+mRNsNZqEYWat8iEJ87MWgA1PL7adKCzGNIOn0/
         gkV18E/0rOa4kFsHSC+/iRck53OqhKc1b59DIRt7/9wOlm/GTnsR2muo8FmRLD+CHWMq
         1/4uin+d0XC8IrToPzg2XjJX0NcRkWSLE0U3fpi70lXp2+7k19kVM7EJd1FaXhtSn3xR
         oUsPNJywZ842FStSZQoLgUxFVxfPHSz5WbWEjT6lospF5Lu+o/wjom+OMM+77gH8AUOy
         TBkE7xvdaMHvAm+4fW32ewQ96AoKIRDui1COF6g+u/LFlcJnaRpEcuRFcuUcrgAyuZhY
         bHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIKG/oo700nGZV4lbYvo18YgIVmpoqqm9J9pS6SKop0=;
        b=k/HDFSEScGnDAOLeP3x5kUNKqHGHNCM2XNVhQ+4k7AjKoie4M8k6Yt1GcWm0Vgt4S0
         pIy6P50vWVVEDfY7aeV0magvZZSAy1niwjvh+Yr2TdLmmJor65OJVYiaLtWhWN2sAKdw
         kTEKhHvJuRamZJARFUBY/pFT/SQc0ZcTpT6oybeJTVLgqj0gV/fuF6BtpEvi4w73qJL6
         d0WrxypJg+H3xCtrKUU+FzAFBizEAI2I/c7F6ZOR/1yPbpka4d/InHK9gKNK1+TYb3wl
         hxbxKKOCIMOLb0+R5D8SAgl2r8i5qQHbnxByWgwyhmEhAmXSBz1GU00wpm/PHRprIGtf
         M8Xw==
X-Gm-Message-State: ACrzQf001uOC7dwnJi84hgGZN0hPE7pq10qPgmdIyi5U6Oc59f4IvH2H
        pbENBn8k7N2xJFCMyNheqDJG+0MQ8+7vTw==
X-Google-Smtp-Source: AMsMyM6PT3C30U5ROrwUvLdWSI5V9ryZ2Nt8uqeYCtw+vZNgm+XT+lZF2IX9+s6Dpcss8q3cpVBc0g==
X-Received: by 2002:a17:90b:305:b0:213:8a6:8bb4 with SMTP id ay5-20020a17090b030500b0021308a68bb4mr32360323pjb.33.1667218951966;
        Mon, 31 Oct 2022 05:22:31 -0700 (PDT)
Received: from localhost.localdomain (118-167-185-125.dynamic-ip.hinet.net. [118.167.185.125])
        by smtp.gmail.com with ESMTPSA id y123-20020a623281000000b0056bf24f0837sm4445483pfy.166.2022.10.31.05.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 05:22:31 -0700 (PDT)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v5 0/2] Modify documentation and machine driver for mt8186_rt1019_rt5682s sound card
Date:   Mon, 31 Oct 2022 20:22:22 +0800
Message-Id: <20221031122224.1846221-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:
- Documentation: 
  - Add #include <dt-bindings/gpio/gpio.h> in order to use
    GPIO_ACTIVE_HIGH.
  - Remove the change-id in message.

v4:
- Documentation: 
  - Fix the FATAL ERROR: Unable to parse input tree.

v3:
- Documentation: 
  - Add an explain example in description.
  - Add the pinctrl-name and pinctrl id in its example.

v2:
- dmic codec driver: 
  - Remove the unnecessary use of_property_read_bool()

v1:
- Documentation: Add dmic-gpios optional prop for two DMICs case.
- dmic codec driver: 
  - "dmic-gpios" property is used for amixer control to switch
     the dmic signal source between the Front and Rear Dmic.

Thanks for the review!

Ajye Huang (2):
  ASoC: mediatek: dt-bindings: modify machine bindings for two MICs case
  ASoC: mediatek: mt8186-rt5682: Modify machine driver for two DMICs
    case

 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   |  14 ++-
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 102 +++++++++++++++++-
 2 files changed, 114 insertions(+), 2 deletions(-)

-- 
2.25.1

