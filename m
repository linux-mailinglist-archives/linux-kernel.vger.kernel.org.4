Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3565FA31
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjAFD24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjAFD2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:28:54 -0500
Received: from out29-50.mail.aliyun.com (out29-50.mail.aliyun.com [115.124.29.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C5C676DE;
        Thu,  5 Jan 2023 19:28:51 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0864198|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00381174-5.27625e-05-0.996136;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.QlbrouW_1672975717;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.QlbrouW_1672975717)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 11:28:46 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com, james.schulman@cirrus.com,
        flatmax@flatmax.com, cezary.rojewski@intel.com,
        wangweidong.a@awinic.com, povik+lin@cutebit.org,
        yangxiaohua@everest-semi.com, daniel.beer@igorinstitute.com,
        13691752556@139.com, srinivas.kandagatla@linaro.org,
        jonathan.albrieux@gmail.com, steve@sk2.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liweilei@awinic.com, zhaolei@awinic.com, yijiangtao@awinic.com
Subject: [PATCH V9 0/5] ASoC: codecs: Add Awinic AW883XX audio amplifier driver
Date:   Fri,  6 Jan 2023 11:28:30 +0800
Message-Id: <20230106032835.141918-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
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

v8 -> v9: Delete extra empty lines
          Use devm_kzalloc instead of kzalloc
          Structure members applied with devm_kzalloc are not initialized to NULL
          DAMP is used for power management
          In Kcontrol, out-of-range values return -EINVAL
          Delete switch Kcontrol
          Use devm_snd_soc_unregister_component instead of snd_soc_unregister_component
          Use aw88395 instead of aw883xx in awinic,aw88395.yaml file
          Add the sound-dai-cells in awinic,aw88395.yaml file
          Use unevaluatedProperties: false in awinic,aw88395.yaml file

Weidong Wang (5):
  ASoC: codecs: Add i2c and codec registration for aw883xx and their
    associated operation functions
  ASoC: codecs: Aw883xx function for ACF file parse and check
  ASoC: codecs: Aw883xx common function for ALSA Audio Driver
  ASoC: codecs: Aw883xx chip register file, data type file and Kconfig
    Makefile
  ASoC: dt-bindings: Add schema for "awinic,aw883xx"

 .../bindings/sound/awinic,aw883xx.yaml        |   53 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    6 +
 sound/soc/codecs/aw883xx/aw883xx.c            |  579 ++++++
 sound/soc/codecs/aw883xx/aw883xx.h            |   58 +
 sound/soc/codecs/aw883xx/aw883xx_bin_parse.c  | 1067 ++++++++++
 sound/soc/codecs/aw883xx/aw883xx_bin_parse.h  |   92 +
 sound/soc/codecs/aw883xx/aw883xx_data_type.h  |  142 ++
 sound/soc/codecs/aw883xx/aw883xx_device.c     | 1756 +++++++++++++++++
 sound/soc/codecs/aw883xx/aw883xx_device.h     |  196 ++
 .../soc/codecs/aw883xx/aw883xx_pid_2049_reg.h |  383 ++++
 11 files changed, 4342 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_bin_parse.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_bin_parse.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_data_type.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_device.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_device.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_pid_2049_reg.h


base-commit: 1f5abbd77e2c1787e74b7c2caffac97def78ba52
-- 
2.39.0

