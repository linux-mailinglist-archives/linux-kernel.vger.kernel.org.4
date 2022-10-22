Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0145C608F19
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJVTN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJVTNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:13:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C507B75496;
        Sat, 22 Oct 2022 12:13:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v11so4258716wmd.1;
        Sat, 22 Oct 2022 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ognYeBAHyjV6DhEhzd6mofoEeOgyCKwh9lCaizz9hQ=;
        b=UnvqPBSdZK9Uxfvo8rI+n7WwpQ6NQM8pIJ3FUFJHTm+670JeuHmP2fokFK+z7ra4fW
         FmycXFCv77/+Ak+cAgoHtwf7qIgCCWuLzcr2QS7+fLnE0dhzrxq9VHcF0Akc0qk1f8cF
         EeqgXW6UnT1IoZJ0pURz9ukELufrEtmcu4PW1LH7Te6DrQM1Zw85YKskuqUPBeW1tMqg
         g1UbaY963fEPYLg/Q+pOlSgSP06qc6WH3UOlVUZcq14Mmd5pf/KwxmztASjJCrTRJCRC
         Lowxd2EgXH1TbuTIo8LRx9/Nodbes86RWEnaxBusyiTNPuEyp9So4PbTBALAU/ZU99VZ
         GKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ognYeBAHyjV6DhEhzd6mofoEeOgyCKwh9lCaizz9hQ=;
        b=lhgXrB/WSM9BD1ShdxcRqp7TflTMhz18jRcOrJ93HLwQocTvYnNa4PTTFWe/Pk+qXZ
         EZTqUwg4DyoBBgYgBEsmmMyq7lRTMIFPIl+98wfQgPH5JJaBd/LOounTtIjOzlZAF8YM
         N/IDtvcHGoycOvLDguKV0gw5htM7yZJI4zGz+0HkEQ/VOPysdfKrEbFQXORIH/pmbUEl
         uErMf/5XYWQBiqL98ShfGQVYiZYLEFTPNNg1HLa/bGq62wz8lr09XzgkKs9hDyKij81+
         PXXaZ6UslisgoM/lN9OU/ITI0UZtmHyXxwyF8UNn22H3DUdLMNINxmv5m9m50vZQwafE
         1bWA==
X-Gm-Message-State: ACrzQf3qu1kdJpC/pVLhUUnEq1xGCY9X9a3HMI3JlYrmwowxyXwafOLi
        Y1ne3Lipem9WlRU5XOycgMk=
X-Google-Smtp-Source: AMsMyM4Fly1NOTAQ6nzGc+s1mhbV32J/ZMCVv2lX5yueZRU8qxEaYXhKxopnfxjaFDE8Dh8AVUjtmQ==
X-Received: by 2002:a05:600c:3b97:b0:3cc:c287:46fe with SMTP id n23-20020a05600c3b9700b003ccc28746femr1436984wms.148.1666466000037;
        Sat, 22 Oct 2022 12:13:20 -0700 (PDT)
Received: from localhost (94.197.1.68.threembb.co.uk. [94.197.1.68])
        by smtp.gmail.com with ESMTPSA id v6-20020a1cf706000000b003a4efb794d7sm6460794wmh.36.2022.10.22.12.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 12:13:19 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/9] ASoC: cleanups and improvements for jz4740-i2s
Date:   Sat, 22 Oct 2022 20:12:59 +0100
Message-Id: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a preparatory cleanup of the jz4740-i2s driver before
adding support for a new SoC. The two improvements are lifting
unnecessary restrictions on sample rates and formats -- the existing
ones appear to be derived from the limitations of the JZ4740's internal
codec and don't reflect the actual capabilities of the I2S controller.

I'm unable to test the series on any JZ47xx SoCs, but I have tested
on an X1000 (which is the SoC I'll be adding in a followup series).

Changes in v5:

* Drop 'mem' resource removal patch already upstream.
* Update FIFO flush bits fix to address Paul's review comments.
* Drop PLL clock name patch, that needs a different approach.

Link for v4: URLHERE

Aidan MacDonald (9):
  ASoC: jz4740-i2s: Handle independent FIFO flush bits
  ASoC: jz4740-i2s: Convert to regmap API
  ASoC: jz4740-i2s: Simplify using regmap fields
  ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
  ASoC: jz4740-i2s: Align macro values and sort includes
  ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
  ASoC: jz4740-i2s: Support continuous sample rate
  ASoC: jz4740-i2s: Move component functions near the component driver
  ASoC: jz4740-i2s: Refactor DAI probe/remove ops as component ops

 sound/soc/jz4740/Kconfig      |   1 +
 sound/soc/jz4740/jz4740-i2s.c | 455 ++++++++++++++++++----------------
 2 files changed, 243 insertions(+), 213 deletions(-)

-- 
2.38.1

