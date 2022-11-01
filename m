Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA396154E6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKAWXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiKAWXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:23:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3415A1A811
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:22:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p21so11003932plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/atQqeE7yew2f3NLAU7m28aDdmCRbd7A5xTuP3olaM=;
        b=Z/SVfi/W/l0ZbgH7VD2JPBlUzJN4/MyupL9V4lXL/QK1qKQT1oJDwbnPQRJF1Flhw3
         RQgQVZ3rB3x2DDjEg+v2Fs7tYMStDaw4ahLmgdpZ1FuqcFmDO9Rn3/uADJGqGfEjlNC0
         uhzcpvSIuDLiZCO+KiAGnCUuLzMTSInGH8NcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/atQqeE7yew2f3NLAU7m28aDdmCRbd7A5xTuP3olaM=;
        b=38rlth+7NAx3RIAO2fM/n3os5umAZPEWJzMk/n/nkpaaGT1Qvb0sRPVj8EbvFFpZO8
         P0hsl+96mFDGUMCQ3QhWERoiaVcvobBDZl6rOuUKM8PbKrnEgnFK6j1pDsLeSDN0W96E
         ATxrztTFVZ8jqlkm33JsxY0m9NEKVqb8eQ9+r2lV0LA2VCKULTapjSyGEI02eD6ahvus
         FvYKKO64TgQG9iNk/38aX/wfmFTziVUbdDpDXhBOSXn1ZQI+HMyP+OL8ysbDuCZHOtK3
         AVyhvThUAs5Idx9y2KDv9MXDC0TYjYMLHntI1Q8DqP8m01OVs5BcXaKVx0EEVwGaUcIU
         8Fbw==
X-Gm-Message-State: ACrzQf20zGglE+PRRU4LgURsMvz3keqyek+mSasCzuzSm3yx4+I4Krb9
        mPt4vb6oD7pbh+O9L0RDAkHeyQ==
X-Google-Smtp-Source: AMsMyM6tT1E2ZOGyLhi6joXexZS2tF424ZuU80HT1E8PlX5VEfgewkfgxiOERbPawxoJGiTPW3hzAQ==
X-Received: by 2002:a17:90b:4c48:b0:214:25cd:96e3 with SMTP id np8-20020a17090b4c4800b0021425cd96e3mr1808035pjb.188.1667341376942;
        Tue, 01 Nov 2022 15:22:56 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:9c5f:7c8e:b8a2:3495])
        by smtp.gmail.com with UTF8SMTPSA id m10-20020a170902f64a00b001769cfa5cd4sm6865385plg.49.2022.11.01.15.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 15:22:56 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 5/5] platform/chrome: cros_ec_spi: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Tue,  1 Nov 2022 15:22:10 -0700
Message-Id: <20221101152132.v2.5.Ia458a69e1d592bfa4f04cde7018bbc7486f91a23@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221101152132.v2.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
References: <20221101152132.v2.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver often takes on the order of 10ms to start, but in some cases
as much as 600ms [1]. It shouldn't have many cross-device dependencies
to race with, nor racy access to shared state with other drivers, so
this should be a relatively low risk change.

This driver was pinpointed as part of a survey of top slowest initcalls
(i.e., are built in, and probing synchronously) on a lab of ChromeOS
systems.

[1] 600ms was especially surprising to me, so I checked a little deeper.
This driver is used to interface with Embedded Controllers besides just
the traditional laptop power-state controller -- it also interfaces with
some fingerprint readers, which may start up in parallel with the
kernel, or which may not even be present on some SKUs, despite having a
node for it. Thus, our time is wasted just timing out talking to it. At
least we can do that without blocking everyone else.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 drivers/platform/chrome/cros_ec_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 7360b3ff6e4f..21143dba8970 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -834,6 +834,7 @@ static struct spi_driver cros_ec_driver_spi = {
 		.name	= "cros-ec-spi",
 		.of_match_table = cros_ec_spi_of_match,
 		.pm	= &cros_ec_spi_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= cros_ec_spi_probe,
 	.remove		= cros_ec_spi_remove,
-- 
2.38.1.273.g43a17bfeac-goog

