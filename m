Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC658610E61
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJ1KZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiJ1KZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:25:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEAE2BB11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:25:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id g24so4485950plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZC8394g/oSHb1w89qyTVGSgqWEPdgXV2NM/y2pTr74=;
        b=sSlppe4NJWWXV5yBu1kykNWWxehe88U/8q1q7SnG4d8/WcqVJemFszw5xqDtTOAz8w
         xq4RciBvf4yPH5XG1rgJCpKsvZ2Uiz1dtWq9mKevLqAJKl+Sljr76rdWM8+QcOCBk5py
         b5+hl4NYdGHrmKSDTF6/9PBnzHqy5D3xz0UF3jM82vPT1Ex7P7ehHekVkwh0uL4EYeau
         VWE389takqz8EWZQEyn1nGd6Kavmbt6bANsZxcLtnvGr+EtXt4C7zjXBtsxEQ5hk8u25
         yOoYwTQPUdzLk3NgegKrU8ijW81H73g6p/U95lOfhCh6CvqqnOLmK3AbAlLFOuOanXwM
         1Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZC8394g/oSHb1w89qyTVGSgqWEPdgXV2NM/y2pTr74=;
        b=qT44PAfnpQPi977XqNlJAPhl8rzDxZmqIMjI2Rap53Bi0EtTB9xe6PIlEbAwpJxUYv
         3BHDR423G7uzvLQ2q+ZgsS77+QcfbJLsAuMIR6iaIJ3fq16n/bH9qurYnyz2WgS93rYt
         +KANIbmSuH4mzLgtkUIs6nQKaLMRYts8fwkEUs9cErtZgTf056Tfa/z/me4ZkE8sQwF4
         FL2QaQSZq12fgz8OUgVp+ZEbc3qzQCd2Ii9Q/9Po7J89grOjJaPIlyqmsM78GBM2MuI6
         P01H7h9Ia0U862qco0IX216hgwoqmeFtun19JQ663HsWYyKylQ8cb7N7bJur6sfzpi93
         NE+w==
X-Gm-Message-State: ACrzQf0yRcsgh6nQW2DC55JAiNfk2j/Rz9da5f84bdfbIXfLn/J70XeB
        EFwhD1aFdhJsf+xyLneCAE+BMs+7ziqDLg==
X-Google-Smtp-Source: AMsMyM7iANNZTI00sQBDnQzS9j9Z/a/chwN4BciHmlrMm0hBj6pNIK7fSz1HfepBKyrCF4zBiPYruw==
X-Received: by 2002:a17:90b:384e:b0:213:7c41:1018 with SMTP id nl14-20020a17090b384e00b002137c411018mr7282132pjb.63.1666952704646;
        Fri, 28 Oct 2022 03:25:04 -0700 (PDT)
Received: from localhost.localdomain (118-167-210-30.dynamic-ip.hinet.net. [118.167.210.30])
        by smtp.gmail.com with ESMTPSA id o1-20020aa79781000000b0056b6a22d6c9sm2565236pfp.212.2022.10.28.03.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:25:04 -0700 (PDT)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, robh@kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        angelogioacchino.delregno@collabora.corp-partner.google.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v1 0/2] Add optional dmic selection for two DMICs
Date:   Fri, 28 Oct 2022 18:24:48 +0800
Message-Id: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
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
- Documentation: Add dmic_sel-gpios optional prop for two DMICs.
- dmic codec driver: 
  - "dmic_sel-gpios" property is used for a mixer control to switch
     the dmic signal source between the Front and Rear Dmic.

Thanks for the review!

Ajye Huang (2):
  ASoC: dt-bindings: Document dmic_sel-gpios optional prop for two DMICs
    case
  ASoC: dmic: Add optional dmic selection

 .../devicetree/bindings/sound/dmic-codec.yaml |  5 ++
 sound/soc/codecs/dmic.c                       | 52 +++++++++++++++++++
 2 files changed, 57 insertions(+)

-- 
2.25.1

