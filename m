Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2BF6596D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiL3Jfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiL3JfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:35:21 -0500
Received: from out29-81.mail.aliyun.com (out29-81.mail.aliyun.com [115.124.29.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E141A3B1;
        Fri, 30 Dec 2022 01:35:19 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09643909|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00387715-6.27374e-05-0.99606;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.Qh0QfiN_1672392896;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Qh0QfiN_1672392896)
          by smtp.aliyun-inc.com;
          Fri, 30 Dec 2022 17:35:04 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        povik+lin@cutebit.org, pierre-louis.bossart@linux.intel.com,
        james.schulman@cirrus.com, flatmax@flatmax.com,
        cezary.rojewski@intel.com, srinivas.kandagatla@linaro.org,
        tanureal@opensource.cirrus.com, steve@sk2.org, stephan@gerhold.net,
        zhuning0077@gmail.com, shumingf@realtek.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
Cc:     zhaolei@awinic.com, liweilei@awinic.com, yijiangtao@awinic.com,
        duanyibo@awinic.com
Subject: [PATCH V8 0/5] ASoC: codecs: Add Awinic AW883XX audio amplifier driver
Date:   Fri, 30 Dec 2022 17:34:49 +0800
Message-Id: <20221230093454.190579-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

The Awinic AW883XX is an I2S/TDM input, high efficiency
digital Smart K audio amplifier with an integrated 10.25V
smart boost convert

Add a DT schema for describing Awinic AW883xx audio amplifiers. They are
controlled using I2C

v7 -> v8: Delete retry for double loops Enable PA
          Delete useless initialization and use reverse x-mas tree style
          Add Spaces in comments
          Modify aw883xx_switch_set function
          Delete our own workqueue, use a default one
          Change variable name
          Modifying function name
          Use dev_ replace pr_ function
          Use define replace number
          Modify the compatible of the awinic,aw883xx.yaml file

Weidong Wang (5):
  ASoC: codecs: Add i2c and codec registration for aw883xx and their
    associated operation functions
  ASoC: codecs: Aw883xx function for ACF file parse and check
  ASoC: codecs: Aw883xx common function for ALSA Audio Driver
  ASoC: codecs: Aw883xx chip register file, data type file and Kconfig
    Makefile
  ASoC: dt-bindings: Add schema for "awinic,aw883xx"

 .../bindings/sound/awinic,aw883xx.yaml        |   49 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    6 +
 sound/soc/codecs/aw883xx/aw883xx.c            |  667 ++++++
 sound/soc/codecs/aw883xx/aw883xx.h            |   59 +
 sound/soc/codecs/aw883xx/aw883xx_bin_parse.c  | 1067 ++++++++++
 sound/soc/codecs/aw883xx/aw883xx_bin_parse.h  |   92 +
 sound/soc/codecs/aw883xx/aw883xx_data_type.h  |  143 ++
 sound/soc/codecs/aw883xx/aw883xx_device.c     | 1790 +++++++++++++++++
 sound/soc/codecs/aw883xx/aw883xx_device.h     |  198 ++
 .../soc/codecs/aw883xx/aw883xx_pid_2049_reg.h |  384 ++++
 11 files changed, 4465 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_bin_parse.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_bin_parse.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_data_type.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_device.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_device.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_pid_2049_reg.h


base-commit: bff687b3dad6e0e56b27f4d3ed8a9695f35c7b1a
-- 
2.38.1

