Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD645E5D41
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiIVIRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIVIRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:17:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D64DAE877
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:17:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e18so12467326edj.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1k72TxQk2XInW+TFTqOgkqy7p+VetIyc10AJO+4jvxc=;
        b=pX/jVSaLO9K//GiJQijoGuDJTP9IxasXFTRyHrfMFk2i4E2LZmDQHlElFkV7v/xOIl
         ww+aKiLw3vmS2M4gM/u5d3pXWompUKAkdx934gRs33YCbQDLUos539B/9CGvf0X15ri4
         t88YdklfYK09MCzR11+QR/XKpaZYic9+h4QuNEzkv20m+1zUarpL004FOtK//GFazim3
         B+dzS7wG6VeIHODGtqiVOFMnjrady8jAkHCfRg0OUM/cxCLVevxX731F/jCEQyjnKJzv
         18VACQUsXvW+2xMgKD7K0IBTqjfals8MBylV7paJHLuU3xRL/E0pUxRX/ePVtZr4MYXj
         UVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1k72TxQk2XInW+TFTqOgkqy7p+VetIyc10AJO+4jvxc=;
        b=eF+FG88mwasbvVxz09d4vmsGd51mBaBJsTqu0fz85Wj0ko0Ma6VXoGdO4L6aekVZGW
         jZBPEGBgD657oGyNGYclOoFT4KERfToUQllSCVM+f8BRNk7+Ri+Wpg/Y3MYMAwoBdPRO
         iV3eLmBQYiP32X/IeHw7taFgD0omOnAa/lMXNLirVM2pZO9DhUiRYLQqBLA1X1H5xdgM
         4Po/iujjxuN9soHS4TVrZnRv7aqTXwYDWsHrvjVWY1Z4WxQ+g9YP2parD2d43jCJHll7
         KFSFfLmvxMcKZnYh87T+h0llF+Gi7taiRKiTnp+SVMqYuIdtEOAEqBRn9XHuwloGKdQ4
         wFQw==
X-Gm-Message-State: ACrzQf2PrHdtGvttHmaecK11YZhdgYUcQ19j00SIwyzv8gu34GGTsois
        ydW44n6T30En195vCnwFmXWUKYOk1vvI2w==
X-Google-Smtp-Source: AMsMyM6Zlfb7U2V7ivSXl/LJl3Y62UGKjZAQVMzdMdEjj88VgzW2VCHB0Nzk+iFQvjYEgrKVeUc4cA==
X-Received: by 2002:a05:6402:380a:b0:451:ae08:7a6c with SMTP id es10-20020a056402380a00b00451ae087a6cmr1960322edb.161.1663834650083;
        Thu, 22 Sep 2022 01:17:30 -0700 (PDT)
Received: from cmo-ThinkPad-T495.tess.elex.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7df8a000000b0044e01e2533asm3301303edy.43.2022.09.22.01.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:17:29 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v6 3/3] iio: temperature: mlx90632 Change return value of sensor measurement channel
Date:   Thu, 22 Sep 2022 10:13:24 +0200
Message-Id: <565d4df2592d751dc0f40908f2569b7c9af8e56e.1663834141.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1663834141.git.cmo@melexis.com>
References: <cover.1663834141.git.cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crt Mori <cmo@melexis.com>

The current EINVAL value is more applicable to embedded library, where
user can actually put the fixed value to the sensor. In case of the
driver if the value of the channel is invalid it is better in inform
userspace that Channel was out of range as that implies more to internal
driver error than invalid input. It also makes for easier debugging of
where the error comes from during the development.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 081803940261..224db7513baa 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -435,7 +435,7 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
 		*channel_old = 1;
 		break;
 	default:
-		return -EINVAL;
+		return -ECHRNG;
 	}
 
 	return 0;
-- 
2.34.1

