Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A44F60559E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 04:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJTCpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 22:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJTCpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 22:45:50 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B04361D;
        Wed, 19 Oct 2022 19:45:49 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13af2d12469so343466fac.13;
        Wed, 19 Oct 2022 19:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Cq+099au1fcIZkEuYX8fyyY/A6S9ZGFUDhQxD4wNUM=;
        b=lSldbcAWPhA/wXSb/o6zEJ+EhogaGACATRZgbSCtFGuMbC/ndba8gJbtw9kCWk8/Ck
         XtNK7nW0mL/k0I68ZgGPVuVaw5kjHNvc2MYgrGXVaTJxUYU/gD9oTDGJLnSaReTwFzdc
         kPmZGaJbkbkjNubHkjnr6Dy9nI6rBA9L52CZLnt7pZjaaJLYjHbepQ8LxELgGvcYZadW
         8MNoeVjvmw7GnvrpPVcRrw2ajbCYs5CiLnXnhG/mnrRJfu/OOH2iqVJJSkvhRuM8PO6C
         TkEftRdOe2mK1lvi/RhteXv0Bi90dOmeCpePCu+T4bvrGowWkMKdsZGQK52X2scNbW5u
         1TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Cq+099au1fcIZkEuYX8fyyY/A6S9ZGFUDhQxD4wNUM=;
        b=Xo3LTJk8DV7udbrPTdkKcNCo3p6ewp1/3S/HkK1u7LYvVUPYbCggU7xTMU33vAHH/p
         KKMVY9aXfptHWNTcrAbRC1aTIQmnV5wgrFWaLGGiPLcd5NjyfuKmRPkvMl1YQkFx2rEq
         kve0Zdlf1YMQ3a4l88/NXpLs8ao3MsJegC+5Q5z/8ns9flFaxr/6J7ykN0ZPu77qKe7k
         sUr2KuUsK1AcEgFAnQAb87dhmg7PPS6kCLmUtrojcoCaiiAKuIFO8bTJf0Ey12pDq97n
         HXtFGjAwVb4GVYJw7Y2X53l7HWRLNkjXNEkrGfPYTbI2Xa26crO9oOs/lbhPwh0cLCUN
         A7qg==
X-Gm-Message-State: ACrzQf0hePY+kHE6L2j96plVPBDFZhhCdHmdAQJ60VaTBiCbcOCNxxCL
        OEyvM6MIzLb/uLvnqSyAHJOI76Q0j8UdyA==
X-Google-Smtp-Source: AMsMyM4P5p3sSnu7XTPKLwvTl/t67AYBSqAa/3Mf4OpKDUxDSZ+8fkxi0XJtwpMU3u08s4UIyQEpow==
X-Received: by 2002:a17:90a:b118:b0:20d:65f4:fde9 with SMTP id z24-20020a17090ab11800b0020d65f4fde9mr47029210pjq.184.1666233938800;
        Wed, 19 Oct 2022 19:45:38 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 33-20020a630d61000000b004351358f056sm10546364pgn.85.2022.10.19.19.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 19:45:38 -0700 (PDT)
From:   Wenchao Chen <wenchao.chen666@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     axboe@kernel.dk, avri.altman@wdc.com, adrian.hunter@intel.com,
        kch@nvidia.com, CLoehle@hyperstone.com,
        vincent.whitchurch@axis.com, bigeasy@linutronix.de,
        s.shtylyov@omp.ru, michael@allwinnertech.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Subject: [PATCH] mmc: block: Support Host to control FUA.
Date:   Thu, 20 Oct 2022 10:45:29 +0800
Message-Id: <20221020024529.25227-1-wenchao.chen666@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenchao Chen <wenchao.chen@unisoc.com>

This patch introduces host->fua_disable for MMC host controller.
The host can turn off FUA to improve performance.

1. fua_disable = 1
/sys/block/mmcblk0/queue # cat fua 0
I tested 5 times for each case and output a average speed.

1) Sequential read:
Speed: 266.8MiB/s, 265.1MiB/s, 262.9MiB/s, 268.7MiB/s, 265.2MiB/s
Average speed: 265.74MiB/s

2) Random read:
Speed: 98.75MiB/s, 98.7MiB/s, 98.5MiB/s, 99.4MiB/s, 98.7MiB/s
Average speed: 98.81MiB/s

3) Sequential write:
Speed: 199.94MiB/s, 199.1MiB/s, 205.5MiB/s, 206.5MiB/s, 191.5MiB/s
Average speed: 200.5MiB/s

4) Random write:
Speed: 68.6MiB/s, 71.8MiB/s, 77.1MiB/s, 64.8MiB/s, 69.3MiB/s
Average speed: 70.32MiB/s

2. fua_disable = 0 (default 0)
/sys/block/mmcblk0/queue # cat fua 1
I tested 5 times for each case and output a average speed.

1) Sequential read:
Speed: 259.3MiB/s, 258.8MiB/s, 258.2MiB/s, 259.5MiB/s, 253.5MiB/s
Average speed: 257.86MiB/s

2) Random read:
Speed: 98.9MiB/s, 101MiB/s, 101MiB/s, 99MiB/s, 101.1MiB/s
Average speed: 100.2MiB/s

3) Sequential write:
Speed: 153.7MiB/s, 146.2MiB/s, 151.2MiB/s, 148.8MiB/s, 147.5MiB/s
Average speed: 149.48MiB/s

4) Random write:
Speed: 12.9MiB/s, 12.3MiB/s, 12.6MiB/s, 12.8MiB/s, 12.8MiB/s
Average speed: 12.68MiB/s

According to the above data, disable FUA (fua_disable = 1) improves the
performance. Therefore, it is recommended to support the host to control
FUA.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/core/block.c | 3 ++-
 include/linux/mmc/host.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 54cd009aee50..333e819e077a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2490,7 +2490,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
 	     card->ext_csd.rel_sectors)) {
 		md->flags |= MMC_BLK_REL_WR;
-		fua_enabled = true;
+		if (!card->host->fua_disable)
+			fua_enabled = true;
 		cache_enabled = true;
 	}
 	if (mmc_cache_enabled(card->host))
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8fdd3cf971a3..16a5bee3eeae 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -517,6 +517,9 @@ struct mmc_host {
 	struct blk_crypto_profile crypto_profile;
 #endif
 
+	/* Host FUA support */
+	bool			fua_disable;
+
 	/* Host Software Queue support */
 	bool			hsq_enabled;
 
-- 
2.17.1

