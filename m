Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDF0630F9E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 18:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiKSRLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 12:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKSRLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 12:11:31 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471E9E85
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 09:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1668877882; bh=FKEbaY7IyPQFMpBoG5mhguHiFjbHZh8X2ncstYTLPn0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=TYkmpQm6NGtu87aycupjCmDXfNZKu64JDeqvj2c0vFicANOkhB6byigpTRtd3X/Gr
         HzUMa+UQyGnMB4XxSLI3V/qyaF6/HQOe6dZyKcuI96ZMoHROBAupfrqTi+ST7JgQKL
         hzGkKTpmqf0IjSgArjgYvkmgrZ771UfHGfNSyq8Y=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 19 Nov 2022 18:11:22 +0100 (CET)
X-EA-Auth: ni8jdc27RGu78A+owJy87OHmQyFyTnn+3qZB4CS5snT62QN7iRjoo7WeH1t5COwJD/1OxtourPBt3HBrZTRIJeF5UApw/Mpc
Date:   Sat, 19 Nov 2022 22:41:17 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     drv@mailo.com
Subject: [PATCH] staging: pi433: call set_lan_gain for receiver config
Message-ID: <Y3kONX7KhQ1GX9QW@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Value for the LNA gain is captured from the user as part of the struct
pi433_rx_cfg, however, the corresponding function rf69_set_lna_gain() is
never called to set it. Include a call to this function as part of
setting up the rx configurations.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/pi433/pi433_if.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index d4e06a3929f3..e588a98d7f33 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -176,6 +176,9 @@ rf69_set_rx_cfg(struct pi433_device *dev, struct pi433_rx_cfg *rx_cfg)
 	if (ret < 0)
 		return ret;
 	ret = rf69_set_antenna_impedance(dev->spi, rx_cfg->antenna_impedance);
+	if (ret < 0)
+		return ret;
+	ret = rf69_set_lna_gain(dev->spi, rx_cfg->lna_gain);
 	if (ret < 0)
 		return ret;
 	ret = rf69_set_rssi_threshold(dev->spi, rx_cfg->rssi_threshold);
--
2.34.1



