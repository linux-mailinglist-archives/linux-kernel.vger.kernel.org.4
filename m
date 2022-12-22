Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605AE654110
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiLVMdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiLVMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:33:01 -0500
Received: from out29-80.mail.aliyun.com (out29-80.mail.aliyun.com [115.124.29.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC70C22B3C;
        Thu, 22 Dec 2022 04:32:51 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08830656|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00327242-5.26072e-05-0.996675;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.QbObWQR_1671712327;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.QbObWQR_1671712327)
          by smtp.aliyun-inc.com;
          Thu, 22 Dec 2022 20:32:16 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, james.schulman@cirrus.com,
        flatmax@flatmax.com, ryan.lee.analog@gmail.com,
        jonathan.albrieux@gmail.com, tanureal@opensource.cirrus.com,
        povik+lin@cutebit.org, 13691752556@139.com,
        cezary.rojewski@intel.com, stephan@gerhold.net,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liweilei@awinic.com, zhaolei@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com, duanyibo@awinic.com,
        Weidong Wang <wangweidong.a@awinic.com>
Subject: [PATCH V7 0/5] ASoC: codecs: Add Awinic AW883XX audio amplifier driver
Date:   Thu, 22 Dec 2022 20:32:01 +0800
Message-Id: <20221222123205.106353-1-wangweidong.a@awinic.com>
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

v6 -> v7: Change name-prefix.yaml to dai-common.yaml in awinic,aw883xx.yaml file
          Delete redundant header files
          Use EINVAL and so on instead of custom error return values
          Remove unnecessary comment
          No longer assign NULL to pointer
          Change the way the if statement is written
          Use devm_kcalloc instead of devm_kzalloc
          Use crc8 and crc32 that come with linux          

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
 sound/soc/codecs/aw883xx/aw883xx.c            |  706 +++++++
 sound/soc/codecs/aw883xx/aw883xx.h            |   61 +
 sound/soc/codecs/aw883xx/aw883xx_bin_parse.c  | 1138 ++++++++++
 sound/soc/codecs/aw883xx/aw883xx_bin_parse.h  |  123 ++
 sound/soc/codecs/aw883xx/aw883xx_data_type.h  |  143 ++
 sound/soc/codecs/aw883xx/aw883xx_device.c     | 1840 +++++++++++++++++
 sound/soc/codecs/aw883xx/aw883xx_device.h     |  201 ++
 .../soc/codecs/aw883xx/aw883xx_pid_2049_reg.h |  490 +++++
 11 files changed, 4767 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_bin_parse.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_bin_parse.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_data_type.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_device.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_device.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_pid_2049_reg.h


base-commit: 9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
-- 
2.38.1

