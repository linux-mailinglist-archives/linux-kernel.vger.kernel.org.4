Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96495612BE0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 18:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJ3R0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 13:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJ3R0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 13:26:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D983795B4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 10:26:21 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u6so8904610plq.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLXxaEi/fgQzftVcfZ/5ZZW/Hv9wZqoHOKy0rIFeuG8=;
        b=bcK5f8GSJ5au6s7UOKhNfCDgpZhwaC4LcSCnk+IiN0XipjzOVWFQHfnmNcJZVO0Ar5
         YdWDkuBbVY9SYg7w8/m/pVwcHjpcGjLO4IkQ2V10e6rcMvJ1rm74AKG5tkv4OF3lHK6I
         RSOBTelhZdmuUSEsnQSbmx0PAaaEBYZEi1xSQPuSm0Sbbq6EHv/flF8jK7igMQB8NuGV
         lxLZRsXFTBAffbC0d9CwKQbdHbX+ZbtXxH0JKVaxxVf5qKsvVe84vazlXbrZRG9A203V
         uwkownSc2icUzj4KwF8azkioe0pb8die0hGVgPk/OeUF8sM7dzzftXrAylTAri4cgkkw
         +mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLXxaEi/fgQzftVcfZ/5ZZW/Hv9wZqoHOKy0rIFeuG8=;
        b=nLtf4vq1A6aCR7r+XEPNc56vkrzi0y0XbItRTJ3YBm0nqGsy2g59j/tiYr8q8sM4iI
         iu92gRI+GbN/zm0Q3Jt6osi+lXeoW+2CkcGSJt0csNpbxIFvXa4Z8A4TzVYhrWbcFtnr
         0JfaGp69+EYScQlqERudmmCnhCDyX551v/IFM6WtKhoCCbrygSdYN02Itmz9isnyjEd3
         YG9Evs6Fhx4/C0Unl4PUKyga2XDAOSiQc74gd8KR0r68nTbGeN6odz8qWyhgAtwV+rjT
         B+l5Q9igw49vq3yH/jNjNUrEt08zrNYI5YbVrwttDaKwavozvzcE/jXyFYNiJBsdGT7T
         ulHQ==
X-Gm-Message-State: ACrzQf0U6mvLb53vDaLUaW1uodtXnI9Q25nQB8sJ9EXmYcI64srAvAyh
        /KhC+1d6f2R9xNcHbd0eDNzfYRY2MMnCKA==
X-Google-Smtp-Source: AMsMyM57weFMujeT2e1myPTiJTj/yCu1MkIsK+ndDUMX4i6e/QPc5/xyzt5HOPqMh/2WCIiV3wZ0kg==
X-Received: by 2002:a17:903:2346:b0:186:ba56:f520 with SMTP id c6-20020a170903234600b00186ba56f520mr9937566plh.138.1667150781108;
        Sun, 30 Oct 2022 10:26:21 -0700 (PDT)
Received: from localhost.localdomain (118-167-185-125.dynamic-ip.hinet.net. [118.167.185.125])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm2933881plb.26.2022.10.30.10.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 10:26:20 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Modify documentation and machine driver for mt8186_rt1019_rt5682s sound card
Date:   Mon, 31 Oct 2022 01:26:07 +0800
Message-Id: <20221030172609.1635096-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   |  13 ++-
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 102 +++++++++++++++++-
 2 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.25.1

