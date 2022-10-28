Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98888611935
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJ1RW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiJ1RWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:22:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF5E226E7F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:22:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b11so5232168pjp.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dEA0uRMa8TxeJYRdNlWPFcX94wVGyCXF1Xf/+3rheBY=;
        b=HHoLoNdPB0qkrK/smItvMUXw2MX16VkSG3Wb6Sq6wx1V5zCqD30UFGrBr6hXMJ2NtD
         LmeLb+qv3HvSjyGgy12ZddE/iB7mNJ7JACuFtGcqPrzY8mHwKGHuriAvzs62BV4v2wG/
         lPfKQGVJ1gcrxo5EH1kUey1p98r0h9hf44iALh02HzL9VrGySlyiw3AQ+jNgcgRhRChG
         cgt7Dv10M9fjuoNaWYZCw0b9JYPbif7hrOOO7Tp7m9aSLnZ7q/rBt+LOb2B+D0Sxwz3H
         DrtV+1G4JEpf+TtxaM5YmKKbcsbZ9g9PWX+5pkTs8zGbvhQtUxY0yDrsctYzapLpogQJ
         tWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEA0uRMa8TxeJYRdNlWPFcX94wVGyCXF1Xf/+3rheBY=;
        b=v9K1gaxOd8rG7sQt2NCvMJadqTksZj2MOHNlyKLLQ6WYGggp9+K6UWP/57lp150Kev
         MuIBImjjwtgjfDl1Vwgpj42drjNKUM0jlsWEGjLvKy5u5Uz583vqCKWwvnhcO7+QlR8a
         KUUY2Kuop4gbyD3wiaAqZ+LMunkoQg1IMOQWGSmix4U1HIBEquMc7MNlHqxiF0us12No
         Qu/wwAIvebbVTfbjdb1Q2GR9DDiqRZE77fhC5j6muLfhpvHVbaZxPajdckv3j35YvpoI
         0/MmhUfF/+19Sjw43XNVV00P4gMZcJYDQouj6XkvDTWnrbbcmOT+jrhRuZoIHDtzu69A
         Pe1A==
X-Gm-Message-State: ACrzQf1rbXDlac+Er/qaabim0RIQ+Oxvrzn05ZbJdCF6thu2GZuAuKa3
        lmQM+9YMrMUSI4h+VSA61CHfyprpJEz4+Q==
X-Google-Smtp-Source: AMsMyM5gtzHQRDvYEJ+/LqCO9vp/O/hO+OoVwkhVr64TlqUb8zjaWEuqctF2XEOxHfx05VuyUlixGw==
X-Received: by 2002:a17:90b:3504:b0:213:5b03:639 with SMTP id ls4-20020a17090b350400b002135b030639mr15666082pjb.16.1666977742507;
        Fri, 28 Oct 2022 10:22:22 -0700 (PDT)
Received: from localhost.localdomain (118-167-210-30.dynamic-ip.hinet.net. [118.167.210.30])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b0021282014066sm4604945pjb.9.2022.10.28.10.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:22:22 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Modify documentation and machine driver for mt8186_rt1019_rt5682s sound card
Date:   Sat, 29 Oct 2022 01:22:13 +0800
Message-Id: <20221028172215.1471235-1-ajye_huang@compal.corp-partner.google.com>
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

 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   |   6 ++
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 102 +++++++++++++++++-
 2 files changed, 107 insertions(+), 1 deletion(-)

-- 
2.25.1

