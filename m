Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1428D6147B7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKAK35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAK3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:29:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD40E18B38;
        Tue,  1 Nov 2022 03:29:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z14so19480796wrn.7;
        Tue, 01 Nov 2022 03:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N2+PF9plcSy2ATWJiPecwWooFcxaUwfoTFa4mF3SLg4=;
        b=o7VSw37luCk1txJUxzqGQMkFhWqPrkJ/Xe4dZxvAF9K2NLZee08637+m3uU3zEBMD8
         bFO4nxwVEdbyrKqJly8BfZ4hWbE3+grDvZdJlZ3q9qPOcgAUJ59XiFJ3BbU149QiwV/7
         P6oI8ORxdxlYwPKtwapsFoBp/qyk00T9LJq9ctjEF87jRgCoMec0FV3ZFXt3rNp6ANKp
         UTLiY1KkIG6lcSKnnBfk95DYCakxEpX58/xK7SZgBaLPB0R6qV3LehugPLa+KaAv/7LJ
         LsDY6ETq96leRawKoZTv4IjoR86J5X00p7uloSGefTQn2z3a+f60lCUKVmeRVCiwUzo8
         t8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2+PF9plcSy2ATWJiPecwWooFcxaUwfoTFa4mF3SLg4=;
        b=xeoKtjNtVT1EhgFhLPXYjMzLl/8/iFCKIc9BI8XOEVlLD5ayu/iqSTjea5wblp0mNq
         Hc4WkYnUGsTik7v5g+1wUi4hzkvw4tAGfKsZK0k6dRVhkIvjQurINDG+IppgxzlWueFQ
         GhIEQTf7w/85AwnemYqSsW225RCNVaNlaGZ+qJdAavdHOAiDT3HmATzuZBsCDZ/ntRY5
         kiMWZrj/HiJ7EK82ckf2kzGWJC5CvDSAWJTqfMjnnKSmHr4imnOXVZEGV9sWzKCgK2Xz
         Xb9rBektvOYE+4RLM5I31rP4QHPBv12Oot8AvbE1QGxRgqDl3W5ImW5oNJl/JM5+9H95
         y5qw==
X-Gm-Message-State: ACrzQf0DpS8hImHpcvmE53bSyEz5M8UiQByB27ceDVXfOt1vWYm9Zn9e
        rJY+Rn/Lhb6AOyBqSGmGIdeFM0pWvpo2CYpN
X-Google-Smtp-Source: AMsMyM6AaaZkGwEBkHo0F9rE7Xc/JyFXaDjj/Nj1mXN0rOHNFWvZVdKnRcqhCbJgXxu8mE3QnxWurg==
X-Received: by 2002:a5d:4ecb:0:b0:236:be56:1a6 with SMTP id s11-20020a5d4ecb000000b00236be5601a6mr8691097wrv.252.1667298589374;
        Tue, 01 Nov 2022 03:29:49 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n44-20020a05600c502c00b003cf537ec2efsm132921wmr.36.2022.11.01.03.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 03:29:48 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: omapfb: remove redundant variable checksum
Date:   Tue,  1 Nov 2022 10:29:47 +0000
Message-Id: <20221101102947.27524-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Variable checksum is being used to accumulate values however
it is never read or used afterwards. It is redundant and can
be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
index cb63bc0e92ca..b33f62c5cb22 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
@@ -129,7 +129,6 @@ static int hdmi_core_ddc_edid(struct hdmi_core_data *core, u8 *pedid, u8 ext)
 {
 	void __iomem *base = core->base;
 	u8 cur_addr;
-	char checksum = 0;
 	const int retries = 1000;
 	u8 seg_ptr = ext / 2;
 	u8 edidbase = ((ext % 2) * 0x80);
@@ -178,7 +177,6 @@ static int hdmi_core_ddc_edid(struct hdmi_core_data *core, u8 *pedid, u8 ext)
 		}
 
 		pedid[cur_addr] = REG_GET(base, HDMI_CORE_I2CM_DATAI, 7, 0);
-		checksum += pedid[cur_addr];
 	}
 
 	return 0;
-- 
2.37.3

