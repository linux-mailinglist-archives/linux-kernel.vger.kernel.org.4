Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0A46E8FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjDTKSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjDTKRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:17:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349D1469B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:16:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50674656309so672658a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681985782; x=1684577782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4BKaB6wmdSC39nGuq4uVk57d3AR6NoTUK0psnv39YEI=;
        b=Y0mOhXZTuZ4nez1P8JdLmChICVL4d7Or6M64/LwQUOcN0zHXwwCzyywmyjVJQAd9+q
         myAr0408kLXfNmkXbD4i/RWKw8/Me0snlbCFKbxRK8NIvwx0PZGC1xfUUeFUZ/jqfAVk
         0J3ptix/C21PHgzNRaDoM5+rAMeYGc6CTV+UiZBKboppIgnHkgxfvYTlrC1nfXzRaQ7i
         jW1JHRt7NARXOXvTk+ny+M4JDpJFet4B35ePM+X6SF9WpP/lNy13GVhqkfMa7RHAfPWx
         YUHuvrfj/aoyu/45D8OVWxnIBF9VJsoqGLEaPe4nRRfj99qxJVWgZIOzwcWk66lLVv8C
         7vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985782; x=1684577782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BKaB6wmdSC39nGuq4uVk57d3AR6NoTUK0psnv39YEI=;
        b=BTqycqCirQjayLu1hXHWVgf0qxnlWNAjvG6f4jJTnrb/jkjBYmOpw6BzqKUHlZe+M5
         PktBKAVZ8scKDq22YvFMYE3nO7gR0DTi/qUH01u+853IDHuaktpPj8tbKmxmwfHdB2p5
         dPNjmWGHibMmJroClchdBvnGdyPLwSc3ZMl10ZnUYHkkV9MOY08fsD/TferOiqNxp1f4
         pJZ0x5riwPFBwsgtLuVsJoieaCe97xxa0+75Ya/82nrhr8MBbC9tmbT0vxZcNW5hwIw4
         WG9LooZZ5zhJduSCTdjMvO/VgCjtlojqcYCxqELuDVsOjkqI3p20J8x3zoY6Y1V4EidV
         S/mg==
X-Gm-Message-State: AAQBX9d3YQOAagv6h+NP3qEvZFLjQ3JzgX2FbImGVpKGRVKUJ0T5ENCI
        PX3u6uQp6LWxijktJ8Tx7RShSLGo0glJGwCZYBaG6g==
X-Google-Smtp-Source: AKy350bcrkmc6o+TztYUElI7htTmgFNkAH4v60w5elbqDvjghZiRFJts/+OXkM9ieyGeYORp6EoZ5g==
X-Received: by 2002:a05:6402:48e:b0:506:bc26:d6a9 with SMTP id k14-20020a056402048e00b00506bc26d6a9mr1563945edv.8.1681985782601;
        Thu, 20 Apr 2023 03:16:22 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id l22-20020aa7c3d6000000b00506be898998sm588954edr.29.2023.04.20.03.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:16:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Patrick Lai <quic_plai@quicinc.com>
Subject: [PATCH 0/6] ASoC/soundwire: qcom: correctly probe devices after link init
Date:   Thu, 20 Apr 2023 12:16:11 +0200
Message-Id: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dependencies
============
1. ASoC codec: changes are independent, however they should rather come the same
   cycle as Soundwire changes, to avoid new warning and small delay.

2. Soundwire: changes (context) depend on:
   https://lore.kernel.org/r/20230209131336.18252-3-srinivas.kandagatla@linaro.org
   https://lore.kernel.org/all/20230418095447.577001-1-krzysztof.kozlowski@linaro.org/

Problems solved
===============
Soundwire devices are supposed to be kept in reset state (powered off)
till their probe() or component bind() callbacks.  However if they are
already powered on, then they might enumerate before the master
initializes bus in qcom_swrm_init() leading to occasional errors like:

  qcom-soundwire 6d30000.soundwire-controller: Qualcomm Soundwire controller v2.0.0 Registered
  wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:4 (ops wcd938x_sdw_component_ops)
  wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:3 (ops wcd938x_sdw_component_ops)
  qcom-soundwire 6ad0000.soundwire-controller: swrm_wait_for_wr_fifo_avail err write overflow

The problem primarily lies in Qualcomm Soundwire controller probe() sequence:
1. request_threaded_irq()
2. sdw_bus_master_add() - which will cause probe() and component bind()
   of Soundwire devices, e.g. WCD938x codec drivers.  Device drivers
   might already start accessing their registers.
3. qcom_swrm_init() - which initializes the link/bus and enables
   interrupts.

Any access to device registers at (2) above, will fail because link/bus
is not yet initialized.

Cc: Patrick Lai <quic_plai@quicinc.com>

Best regards,
Krzysztof

Dmitry Torokhov (1):
  ASoC: wcd938x: switch to using gpiod API

Krzysztof Kozlowski (5):
  ASoC: codecs: wcd938x: Keep device in reset till bind
  ASoC: codecs: wcd938x: Check for enumeration before using TX device
  soundwire: qcom: drop unused struct qcom_swrm_ctrl members
  soudnwire: master: protect concurrecnt check for bus->md
  soundwire: qcom: do not probe devices before bus/link init

 drivers/soundwire/master.c |  7 ++-
 drivers/soundwire/qcom.c   | 92 +++++++++++++++++++++++++++++---------
 sound/soc/codecs/wcd938x.c | 44 +++++++++++-------
 3 files changed, 107 insertions(+), 36 deletions(-)

-- 
2.34.1

