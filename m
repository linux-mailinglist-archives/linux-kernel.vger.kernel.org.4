Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380C05B6B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiIMJur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIMJup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:50:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760D657E08
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:50:44 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MRdvX39PgzHnk2;
        Tue, 13 Sep 2022 17:48:40 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 17:50:40 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <cezary.rojewski@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <liam.r.girdwood@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <alsa-devel@alsa-project.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [-next] =?UTF-8?q?ASoC:=20Intel:=20fix=20compiler=20warning=20of?= =?UTF-8?q?=20function=20=E2=80=98probe=5Fcodec=E2=80=99?=
Date:   Tue, 13 Sep 2022 18:02:00 +0800
Message-ID: <1663063320-29158-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the variable ‘skl’ define to
CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC enabled, to fix the compiler
warning:
  sound/soc/intel/skylake/skl.c: In function ‘probe_codec’:
  sound/soc/intel/skylake/skl.c:729:18: warning: unused variable ‘skl’ [-Wunused-variable]
    729 |  struct skl_dev *skl = bus_to_skl(bus);
        |                  ^~~

Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 sound/soc/intel/skylake/skl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index c7c1cad..52a041d 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -726,8 +726,8 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	unsigned int res = -1;
-	struct skl_dev *skl = bus_to_skl(bus);
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC)
+	struct skl_dev *skl = bus_to_skl(bus);
 	struct hdac_hda_priv *hda_codec;
 #endif
 	struct hda_codec *codec;
-- 
1.8.3.1

