Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CE560CC11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiJYMl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiJYMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:41:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C380817C54A;
        Tue, 25 Oct 2022 05:41:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bs21so4732568wrb.4;
        Tue, 25 Oct 2022 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yH8jcG0t2JnpHFP328ErEiy3xOc8p7F+XJJ12TGrYJ4=;
        b=ADcgveVq42dClUSYh1OdhJor5VPmcRA6oevJkoIoUn3cs3uhGEVs3eTiNOnAQDUoJ3
         jqZ/Cza0BIP9QGy8ZetmZ8xAoA7TYpkv0rRaIJ4iysx4ine4E4lEjxcHjGGMNC4p77Bs
         gVHSlRuSEYGign0vPFAYRcC/AVLOPVWpMUF8xX7GO4RkO1Af9UuWuD4yhAOTmBV3v1ml
         etxwfTQTQXCVmxYSy4oMnLxyZS/v40OOCw0y+anTWWnZ9czbBgVVn3RxflHj91yVsNYu
         JXRLAlTRPXOMxGb0Q8lAXZBI+SKVQ4xjDFNYj36MnwsrfDzCTVN5rEzyN1uoUxj/6PKv
         UREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yH8jcG0t2JnpHFP328ErEiy3xOc8p7F+XJJ12TGrYJ4=;
        b=dFjm2pf5lzCVYOQAb26TuKW5//53ZaP/3hxc76LA5QNeKsr+ejrnRBmWbzIIrjzwEm
         QovPdajXuhd8++ZFtxLdM7KNWmqU3c86+6bHvvP69CDjlLTfFWwEdQ+zo5Y0o+24Zdmz
         rx6KaQXMrw++JpO0oHEeq15I/erGANMmnbximK3IkX97ayoeriE3kQt9+X0CgpIlmOHu
         PQhe1M+RdD3B9xM3ScAbVUEHpGQVcPpC4vWSVpTBc2tvAxdH1K0TQtEp+fnbkKFh31ar
         Ktiu8HMslFO3e52ghZ90SVO864Uu4QGF88a5EX3/zmSk+CpUkkNxUU/VJCHa/nJ2hPT8
         mNEQ==
X-Gm-Message-State: ACrzQf2c7xAPL9ubQJSvScOEoExyWUYacD2aRMOGXbxg/Hc6TGzPO1xT
        UT+UfHAIYqJyUrv3pFtN5r6kiVXN5U8=
X-Google-Smtp-Source: AMsMyM79M+Qo60SRQPkng0nGNuvvyofmUH45lXPvafVewbcusEHRtb9umhJDmerFTJrt94xMZHytvQ==
X-Received: by 2002:a5d:4ac8:0:b0:236:781a:8d2d with SMTP id y8-20020a5d4ac8000000b00236781a8d2dmr5463369wrs.715.1666701710247;
        Tue, 25 Oct 2022 05:41:50 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b003a1980d55c4sm11250664wmb.47.2022.10.25.05.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 05:41:49 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] RK3588 Audio Support
Date:   Tue, 25 Oct 2022 14:41:28 +0200
Message-Id: <20221025124132.399729-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset refactors the Rockchip I2S/TDM driver in order to
support the RK3588 SoC, and then adds the necessary compatible
string to load the driver for it.

Patch 1 rectifies a problem with the bindings where we were too
strict about requiring the rockchip,grf property. Most features
of this audio device don't need access to the GRF to function.

Patch 2 modifies the driver to adjust its behaviour to what the
changed bindings now allow, namely using most things without the
GRF.

Patch 3 and 4 are boring compatible string stuff that enables
RK3588 support. No special data is needed to initialise the
driver for this instance of the I2S/TDM IP.

Nicolas Frattaroli (4):
  ASoC: dt-bindings: rockchip: i2s-tdm: Make grf property optional
  ASoC: rockchip: i2s_tdm: Make the grf property optional
  ASoC: dt-bindings: rockchip: i2s-tdm: Add RK3588 compatible
  ASoC: rockchip: i2s_tdm: Add support for RK3588

 .../bindings/sound/rockchip,i2s-tdm.yaml      |  2 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c         | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.38.1

