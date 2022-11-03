Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6D617C20
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiKCMGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiKCMG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:06:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A24A12770;
        Thu,  3 Nov 2022 05:06:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v1so2409676wrt.11;
        Thu, 03 Nov 2022 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DLUDsiw05g4Mq+tu60AP2NfJMNxrmmZZAuBLJdj/+ss=;
        b=lxJmCasm1+VP1Qubc/vAFKpv97dE0no8M/PO4B/C4PRfKcBMlc2+R434KHvfFOB3/1
         bOXTL6xQsVrDbSV7UWZIReaB+1spj/zPvxyu0nFm6y3Gah87o/5z+ACj9+jzjj3I+gxW
         HBv+eXtPWCkBJuoaPWtGQXgdaw6hgEn3lWCrg4BqGSba68rjTD2R2AT62cDh8qa2cRrl
         ZilBB1aOl8O7jEvXZ5trIHZLscqN9/EhHTx9BN5LpJnuomX9hBAGwihANJECLWeQjgPa
         ffezZ8VkmQNxJGuBMrN4D9PJkosrgUp4y4CZow+9WJX32YF7E1UevLQQHTwgsMp8tec/
         QGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLUDsiw05g4Mq+tu60AP2NfJMNxrmmZZAuBLJdj/+ss=;
        b=kxyCWPHBLokBV385xpAUOjbvoUMqk3hedd0uBQhJ/FgOZx5fr+9G5+Ty4vT1veJXUU
         qww3VsIkwOXbN9FeRVUsegroWMQM3T67p0Nty7LJUgYU1PidKGLKuamF+Q/5B17is/yn
         04DNcyyFJbxtve9FeGr60ztsBAy3R7bKBbz3mQ8t1IqTAdgPuGVOjPHKqGL3odhiNNTp
         yA41epsXnMeMfXQ1MXDiEw6UIdS/3Y8Jmdxpl62RvrsW7dfd0gGenI/7zCsI3AiBK11k
         JhZ5r6a4bB41Kc6aKlOvDgPUDXA8si6rr7+iOu35sgalmMvRCNNLie5jyAWq6nopmS5p
         +IsA==
X-Gm-Message-State: ACrzQf0547ampu9xR6w3Yan4D10hFjV6fdzjKnD8JeJafF/2CrsDzmit
        WEmCS0imonlmYGgfKEjfthksjTxeoKollhOl
X-Google-Smtp-Source: AMsMyM40p6IC3WQf7nsrHFzJRU6pEK8D3jpJ8vv4G0tC/JBAROZCtVy4eQQpaxeZHxSQE1bKB7AnAQ==
X-Received: by 2002:adf:feca:0:b0:236:b258:c19b with SMTP id q10-20020adffeca000000b00236b258c19bmr18014378wrs.57.1667477185703;
        Thu, 03 Nov 2022 05:06:25 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b003b4935f04a4sm1537933wms.5.2022.11.03.05.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:06:25 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: cirrus-common: Make const array uid_strings static
Date:   Thu,  3 Nov 2022 12:06:24 +0000
Message-Id: <20221103120624.72583-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only const array uid_strings on the stack but
instead make it static. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/intel/boards/sof_cirrus_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_cirrus_common.c b/sound/soc/intel/boards/sof_cirrus_common.c
index 6e39eda77385..851c516c8f5b 100644
--- a/sound/soc/intel/boards/sof_cirrus_common.c
+++ b/sound/soc/intel/boards/sof_cirrus_common.c
@@ -155,7 +155,7 @@ static const char * const cs35l41_name_prefixes[] = { "WL", "WR", "TL", "TR" };
  */
 static int cs35l41_compute_codec_conf(void)
 {
-	const char * const uid_strings[] = { "0", "1", "2", "3" };
+	static const char * const uid_strings[] = { "0", "1", "2", "3" };
 	unsigned int uid, sz = 0;
 	struct acpi_device *adev;
 	struct device *physdev;
-- 
2.38.1

