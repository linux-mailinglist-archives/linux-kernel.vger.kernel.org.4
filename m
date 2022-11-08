Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7B620838
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiKHE13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiKHE10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:27:26 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB0128732
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 20:27:24 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q9so12744397pfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 20:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6096okKnM3LniZ6Nj0Sm7F7LQMDqNvSSnwZPCnhiw8=;
        b=1mGeDBlyTC13IDKQ7R/QnajcvqgJQfgZKF9EJFcZ1Wv3Zg+6kOzzFohV0Ws7IJWOwo
         P7c6++vGOIY0iOFd66JNFjfUpRRy0GGBQit8XrrPez1kAinal56iOnsD/f2H837IL33V
         pYQ1aPuaRQkDphfxjqVMUBCJWj7kwyI6RcWluOCaotT7PT4QcCYUC7K3sKqMoMEIpCkw
         dUJNDHipjWv5gTpwh04xssT+K9UidBxu0eBRhBKoCrbniH+8+0HvzASN3lggPLByED4b
         bv/mxlSmFxHvt4laSlPrqcUK0uioyQ/nfDfmoW6UWCMuEF6l5pUu1bQ7Gac8EudYQSEY
         iVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6096okKnM3LniZ6Nj0Sm7F7LQMDqNvSSnwZPCnhiw8=;
        b=ey7I6GF8bhaCz4kZxu7DntHGTL1+Op+W2V+5nCCyLOP5Az9NzP+8V5yZ2k7Io9dp/x
         B4hmFQe6S8nWFlPW9I/WAuFfKcuv5eDcdiDzPMSv9+5otBEM9cKtj9oeMKFZ7BvF75gz
         RMIcPXtojbDYYJIL0KN0DGdlio8up1j+OZBZzl+MlVurfbNl8g9lOAcNrCRUVhJqyJ6g
         1VSHcE8AauAESMAqhNmq8Ij3GXb8DcpGUsnxjiaiTf9fNNrwcF5ARoRaRcOSIlAj8WwU
         j1IsCpt2MpI/5fmb58EkAqYOIdkIkcxGYFrUvDeexsU0OHYskbLG5s4cOlOtjtX/eaA4
         4FNQ==
X-Gm-Message-State: ACrzQf19AlEHYECHKLAzrQZONQ6QkncaRnyniDDJMiByPMHf6zXjMX12
        Dp2cotuNJimko9nxzxXFY7Ewq8kRE3woGg==
X-Google-Smtp-Source: AMsMyM57qEEZLOfYjTD7nChVxavKbgKE3kQblo1X8M0SPae/WSCgHhVjERi7H1bdIYn7+pzFRkuGVA==
X-Received: by 2002:a62:ea09:0:b0:562:a86f:63af with SMTP id t9-20020a62ea09000000b00562a86f63afmr55027060pfh.71.1667881643602;
        Mon, 07 Nov 2022 20:27:23 -0800 (PST)
Received: from localhost.localdomain (118-167-183-234.dynamic-ip.hinet.net. [118.167.183.234])
        by smtp.gmail.com with ESMTPSA id j63-20020a625542000000b005627868e27esm5265945pfb.127.2022.11.07.20.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:27:23 -0800 (PST)
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
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Mac Chiang <mac.chiang@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, alsa-devel@alsa-project.org
Subject: [PATCH v1 0/2] Adds the combination of headset codec ALC5682I-VD + amp rt1019p
Date:   Tue,  8 Nov 2022 12:27:14 +0800
Message-Id: <20221108042716.2930255-1-ajye_huang@compal.corp-partner.google.com>
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

v1:
- machine driver: 
  - Adds the combination of headset codec ALC5682I-VD + amp rt1019p.
  - Remove the duplicate code in machine driver.

Ajye Huang (2):
  ASoC: Intel: sof_rt5682: add support for ALC5682I-VD with amp rt1019p
  ASoC: Intel: sof rt5682: remove the duplicate codes

 sound/soc/intel/boards/sof_rt5682.c               | 7 +------
 sound/soc/intel/common/soc-acpi-intel-adl-match.c | 4 ++--
 2 files changed, 3 insertions(+), 8 deletions(-)

-- 
2.25.1

