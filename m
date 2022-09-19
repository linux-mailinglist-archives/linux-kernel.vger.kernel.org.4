Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F135BC144
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiISCNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiISCNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:13:14 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BAE13D52;
        Sun, 18 Sep 2022 19:13:12 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o204so12998861oia.12;
        Sun, 18 Sep 2022 19:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=30wgaWcVLtlgOybwbcxXo+I/U3RzFoPIO5/LyOQBHYU=;
        b=kefEho1oRdioctlzHHj519m7ou3Q6GLu9YyuJQkiBHvWAzTbTtAfOddM/+HoeCX/BN
         rnxl/LeIOyCr7hnbPKI9W14lXsHOB9mBR/j9LJ/D/ejiYBWJlIDtF21FnA/Ox7s2QsEy
         szBB8eTYkgdGZsHuCv2ZWG4RQXT9NIlYOHy8F+9LbBkQ1MzX0TGGk/uvRM7/OQ1yIHDP
         PGQQqHQXRVqVlnnGNPMXAaxm/hX1efFY0gd65emurOz5WcjyixZs6R866vGVAmeXA70y
         XE40MaclqRlxgYUs4uO9vHD9qvTKXHoOtfJc3vtcli24euqY+3+DtdWd/4YPpygTaTcU
         M4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=30wgaWcVLtlgOybwbcxXo+I/U3RzFoPIO5/LyOQBHYU=;
        b=79N0q9IqubtPiN9CPWbN2iYsYc4G70fWH/s2wWfw3+zH4yE7EHl/+pQAHuiEpr90da
         fzHj4WxEFAvHfr1WuURbWss9dong072Jd79XWsgNFmoeNjh2UWAFZ2OL27kdVM6qjbdh
         xNAq/5o2IK6zi6ZRwDejOue7GG78ioqfAwRurNkH62AstMr9IoOw0Vd68Mv3fVo1TvS0
         si4dJW8kwe9LbvCAdpkigHUzZLLOJ3oW40al8lO8ML2jgScwcyZCQahoWQLnzFrPsDPt
         jP7vfPvjVKZfHCZYzW0DyMFf6x2fB4q3OnR4fWB3A6gLsLZUEXAzOSHsyIcJkw0k51Hb
         +//w==
X-Gm-Message-State: ACrzQf2n/z63ILfc0tPtR7EkINeCEH9BeYaHStvhonNVpHKZKDt4Ovgo
        7/29lECiasZWx+2QPzlq19Q=
X-Google-Smtp-Source: AMsMyM7iBUcCWzG2Q63UTNBmfU+y8e3Ywur+iXK5HiFuPHTNinCUrVYiqL4KrJKBstxCKuII1ke3UQ==
X-Received: by 2002:a05:6808:118e:b0:345:9c3e:121d with SMTP id j14-20020a056808118e00b003459c3e121dmr7100116oil.211.1663553591547;
        Sun, 18 Sep 2022 19:13:11 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cd:8cb3:e183:945:dc30:a2a8])
        by smtp.gmail.com with ESMTPSA id z26-20020a9d7a5a000000b006370abdc976sm13591066otm.58.2022.09.18.19.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 19:13:11 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Martin Kepplinger <martink@posteo.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: i2c: hi846: Fix memory leak in hi846_parse_dt()
Date:   Sun, 18 Sep 2022 23:12:51 -0300
Message-Id: <20220919021252.730729-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

If any of the checks related to the supported link frequencies fail, then
the V4L2 fwnode resources don't get released before returning, which leads
to a memleak. Fix this by properly freeing the V4L2 fwnode data in a
designated label.

Fixes: e8c0882685f9 ("media: i2c: add driver for the SK Hynix Hi-846 8M pixel camera")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/media/i2c/hi846.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
index ad35c3ff3611..254031503c72 100644
--- a/drivers/media/i2c/hi846.c
+++ b/drivers/media/i2c/hi846.c
@@ -2008,22 +2008,24 @@ static int hi846_parse_dt(struct hi846 *hi846, struct device *dev)
 	    bus_cfg.bus.mipi_csi2.num_data_lanes != 4) {
 		dev_err(dev, "number of CSI2 data lanes %d is not supported",
 			bus_cfg.bus.mipi_csi2.num_data_lanes);
-		v4l2_fwnode_endpoint_free(&bus_cfg);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto check_hwcfg_error;
 	}
 
 	hi846->nr_lanes = bus_cfg.bus.mipi_csi2.num_data_lanes;
 
 	if (!bus_cfg.nr_of_link_frequencies) {
 		dev_err(dev, "link-frequency property not found in DT\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto check_hwcfg_error;
 	}
 
 	/* Check that link frequences for all the modes are in device tree */
 	fq = hi846_check_link_freqs(hi846, &bus_cfg);
 	if (fq) {
 		dev_err(dev, "Link frequency of %lld is not supported\n", fq);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto check_hwcfg_error;
 	}
 
 	v4l2_fwnode_endpoint_free(&bus_cfg);
@@ -2044,6 +2046,10 @@ static int hi846_parse_dt(struct hi846 *hi846, struct device *dev)
 	}
 
 	return 0;
+
+check_hwcfg_error:
+	v4l2_fwnode_endpoint_free(&bus_cfg);
+	return ret;
 }
 
 static int hi846_probe(struct i2c_client *client)
-- 
2.34.1

