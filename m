Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C806B503B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCJSmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCJSmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:42:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA7D121B5A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:42:13 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso6065013pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112; t=1678473732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NUkP7iMk62KicMLNDd9BONghE79lxMRHNMqjVddqeEY=;
        b=5D/IrCBNlqsFdQEotLM08QXSEwuzu2FsMhZ5GQVd9rc/Fpm6QsZ4zvjWozspgkb9pM
         bX7EkVdQQPPTlqmhb3D62wXWEqDqrTWEvkyNlda8NrVboOwG52cU/CYHB1phHFQLHorJ
         VZ33Ma1xqjG1QE1kwoy1fV8JhYj3r9m5rNWVySJWtyexcUZ7dk95sjHOnM/k8qZMJM+D
         xfKRPlR/8iV53xJpg62wS8RQJfcDtvWOvFeoy7mEoSODcu7MdcCqJNRUNWmukqb3z9Ix
         fpM5PjrG8ncUyvG70z6oPa1zD7Y1KwWTkAs+us9eOhR2IrKyHZlemVLQ23JVuyhxm3vu
         edNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678473732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUkP7iMk62KicMLNDd9BONghE79lxMRHNMqjVddqeEY=;
        b=ORZzcePvmHEAD2OGW3Av7ACRj4XDdEK1jUq1eml+VOt73oPEdIYV/eHDjRr0G6wNcC
         XIS/eQbplvo9gWr0sMDGsWQAFtbXWH+DfqlRRzQgjyexQ3DR3KVEiFtHi2NjNv7TFnNz
         oLKqbAuyj+zK8HCpUBMMQYzmPiV1olyuX8StykHO86yYrZSM9UsP4kMnlpFjqS9yVdQw
         lznxklYiZ4cG6kvG9LI+aeinAXzaiQ6xRPDRcx9gTytsDADvZ60ufAZZP7dCZas2BhTm
         H5V6gr/r1xbfSXTP/N0J9sIDCoI4/V66WL/KFNjgmBzOwlUJhH/LYBvhkhrA96tG1/o2
         38+A==
X-Gm-Message-State: AO0yUKWLajRxFIT5XajnNOL/jPRYhK6RjC9p9HQOeUR4mb2UnB92KaoJ
        wJ5fM4VMB/N+LF2JK2UzeW2SkfH/FwrWAQGPVGM=
X-Google-Smtp-Source: AK7set860Vqv2C+1CB57cpDPc4uXVqQY/Vb5fpr9eIyb1UBzdvJHeHaLRK9kTImQvRdbX8fyMPlbow==
X-Received: by 2002:a17:902:da87:b0:199:3a4a:d702 with SMTP id j7-20020a170902da8700b001993a4ad702mr3462541plx.0.1678473732597;
        Fri, 10 Mar 2023 10:42:12 -0800 (PST)
Received: from localhost.localdomain (1-171-145-144.dynamic-ip.hinet.net. [1.171.145.144])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e5cf00b0019949fd956bsm309309plf.178.2023.03.10.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 10:42:12 -0800 (PST)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Yong Zhi <yong.zhi@intel.com>, dharageswari.r@intel.com,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        alsa-devel@alsa-project.org, Mac Chiang <mac.chiang@intel.com>
Subject: [PATCH v1] ASoC: Intel: sof_rt5682: Enable Bluetooth offload on adl_rt1019_rt5682
Date:   Sat, 11 Mar 2023 02:42:01 +0800
Message-Id: <20230310184201.1302232-1-ajye_huang@compal.corp-partner.google.com>
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

Enable Bluetooth audio offload for drv_name "adl_rt1019_rt5682" with
following board configuration specifically:

SSP0 - rt5682 Headset
SSP1 - alc1019p speaker amp
SSP2 - Bluetooth audio

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Signed-off-by: Mac Chiang <mac.chiang@intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 4fe448295a90..2eec32846078 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -1109,7 +1109,9 @@ static const struct platform_device_id board_ids[] = {
 					SOF_SPEAKER_AMP_PRESENT |
 					SOF_RT1019_SPEAKER_AMP_PRESENT |
 					SOF_RT5682_SSP_AMP(1) |
-					SOF_RT5682_NUM_HDMIDEV(4)),
+					SOF_RT5682_NUM_HDMIDEV(4) |
+					SOF_BT_OFFLOAD_SSP(2) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
 	{
 		.name = "mtl_mx98357_rt5682",
-- 
2.25.1

