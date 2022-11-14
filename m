Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFAB628A70
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiKNUbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbiKNUbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:31:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ECEE093
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668457799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QSwGPQPGYuSJyzjFn4FohKoV+SdPmLV3qCVTVk9ZraQ=;
        b=CnJDtJUki6MMlMei2+mDauFqzPMBPaCVjPI37UG7BPyoV3hAkm/PbzII7g2RGrdRO+n6uF
        DKsnfUcIgp/1gKuLJg18NugzYn9zd/g1O1MQ3O/goOe9RnVl6dynHulay+sYA7xL5/dgX5
        vBDycBu8RtKroSqPhjzwpTNa9Au6HFo=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-307-zdX3zkjyOWmbtyK6E55pfw-1; Mon, 14 Nov 2022 15:29:58 -0500
X-MC-Unique: zdX3zkjyOWmbtyK6E55pfw-1
Received: by mail-io1-f71.google.com with SMTP id f2-20020a5ec602000000b006dc67829888so6328295iok.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSwGPQPGYuSJyzjFn4FohKoV+SdPmLV3qCVTVk9ZraQ=;
        b=ZiqJEt7fR2yD6dFgc5jbZlb8bc+jhe4DPs3ASgCJWPfa+rwrsuRJTnSqQOikJ/Ndmh
         AhGOQdfSFx9W51qQJ4VU8cqy4Pbq8bYmgGtyvEp3MRsMug/tCyqTiumn851HUjxKoTn8
         rck0M0VZu1LrcrOfgePNMrL1o2Y4s5ARjiOHUQWssRSiYxrMi1MWJUSmTAM8eBvRxewb
         vrUO4MGq9iSWmgS7LB4G4NoNJpJg76M7pY0y1PJ2Bz3HvqmU9ztai6O2o6wpLZ5OhG6l
         TpivRQXCW0QiUbcfnYB/lf914RE2xKAS2ovwheRZrmxBbVSvWPhswFyc92jpe0pC5iQ8
         Mrsg==
X-Gm-Message-State: ANoB5plK58pE4Ma4vRx8Ax3qoNNf+WDl2cmxTNlqbgJqzKENLDuEqrh7
        8CgFxc8xMSUai6lvc47uwWiMmMWWB+CxFgCDf8Pkv0z2Ee7yTBHcLM24oJ0ZxlI4QCnQ4bbiK+6
        HrkZBimEVq9hGvYG51xtdHF9N
X-Received: by 2002:a92:c90a:0:b0:302:759b:6fb7 with SMTP id t10-20020a92c90a000000b00302759b6fb7mr52456ilp.199.1668457796828;
        Mon, 14 Nov 2022 12:29:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7laylm71gj6zlFb/LlA13vJqijVyI7RxHqdo/irUmdJzG3ZY3TN+ZFadUzPNOPfZdDFz8cNQ==
X-Received: by 2002:a92:c90a:0:b0:302:759b:6fb7 with SMTP id t10-20020a92c90a000000b00302759b6fb7mr52446ilp.199.1668457796596;
        Mon, 14 Nov 2022 12:29:56 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id n20-20020a02a194000000b00374f8a0ed3csm3864044jah.103.2022.11.14.12.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:29:56 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, psodagud@quicinc.com,
        quic_shazhuss@quicinc.com, quic_ppareek@quicinc.com,
        ahalaney@redhat.com, echanude@redhat.com,
        nicolas.dechesne@linaro.org
Subject: [PATCH RFC] gpiolib: ensure that fwnode is properly set
Date:   Mon, 14 Nov 2022 15:29:43 -0500
Message-Id: <20221114202943.2389489-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that this is a RFC patch and not meant to be merged. I looked into
a problem with linux-next-20221110 on the Qualcomm SA8540P automotive
board (sc8280xp) where the UFS host controller would fail to probe due
to repeated probe deferrals when trying to get reset-gpios via
devm_gpiod_get_optional().

of_get_named_gpiod_flags() returns -EPROBE_DEFER, which is caused by
of_gpiochip_match_node_and_xlate() returning 0 since the of_xlate function
pointer is not set for the qcom,sc8280xp-tlmm pinctrl driver. The
pinctrl driver doesn't define one, so of_gpiochip_add() should
automatically setup of_gpio_simple_xlate() on it's behalf. This doesn't
happen since the fwnode member on the struct gpiochip is set to null
when of_gpiochip_add() is called. Let's work around this by ensuring
that it's set if available.

Note that this broke sometime within the last few weeks within
linux-next and I haven't bisected this. I'm posting this in the hopes
that someone may know offhand which patch(es) may have broken this.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 11fb7ec883e9..8bec66008869 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -678,7 +678,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	 * Assign fwnode depending on the result of the previous calls,
 	 * if none of them succeed, assign it to the parent's one.
 	 */
-	gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
+	gc->fwnode = gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
 
 	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
 	if (gdev->id < 0) {
-- 
2.38.1

