Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99E16D6A6B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbjDDRXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjDDRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0746D49FE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eh3so133535940edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ri+KMEjNpTYZIPFjCFx+/7TZlMVFVOLpk39qoMQAgfg=;
        b=g47Eyvoz8Tk4i6j/vn+dxRpCAVTVdVE4TXuZg8PzIVfppbGwgy0MDR4Q77wPYhebqR
         VhvVS0bNDuSwevinLOYXyqQyXo03ehN1IlnCR1AIOYDR9MZo8Ql/6J+MjQcER2clQCZV
         FIvzBf0BdZbsBozUTG0hKqW+1xLjW603Lr5n/L8TCBqLe7L6/idbTNC2yEcajq+ldAv6
         y2IKQKF+OH6QEBwXdd/5DAaSxnyDXpjhq4d4uRmSn2K5ZBGsNWHTz7Lq1HutUidrzzFB
         Vtj9GOMms3yPOeOEVjcQRyxSEYY9D/Cct9YQ98WFbwmuJOWo3uPaCrCv//Kjsxec4yrN
         GJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri+KMEjNpTYZIPFjCFx+/7TZlMVFVOLpk39qoMQAgfg=;
        b=Q82n4nxq8hKyUjLNENe3/3p90okUst75x6WLHkdnKAMBAq+XIkc3XvtZN0+qN3Zi18
         wrmqdkc3alI/4PU3K4PdTPMNjFUSd44eCSSrNLvtnwoLx88RIWJTi9kkdE/U1BffBw4R
         KtUpERFzlP4UEU693vRndWofhJo14y18odIC+Mo1vKGw35U0iugT6Y2HoARkQ2JDy/YD
         MUxqVw3vDbX/u+7gdMeoJtYyKCwvkdUipEFPY30nxCIKgRLj31JzhCwfkKrtSkfftuwZ
         RZc+dc0D4khUXDQuNUZ+TAbkVG9kGqbtqqd3HdPujhSzOi5NtLCxyVpGRGkMsJeCqc6R
         18Xg==
X-Gm-Message-State: AAQBX9eJRpJBatRAFHEV/AgTKR2jeV3Uao+Eu+8I9a/zeiwg079HViLW
        gJjzenGARVXhj/4ZyVOreaS1CQ==
X-Google-Smtp-Source: AKy350Zu1ynxaL+pFI0WvSJjMsGmvmskIY7obMu4Bm5IQbZ86beTly4vL4lxC2Xyzvj2TgNUA+AwwA==
X-Received: by 2002:a17:906:3e06:b0:930:3840:1c4d with SMTP id k6-20020a1709063e0600b0093038401c4dmr325039eji.32.1680628956558;
        Tue, 04 Apr 2023 10:22:36 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/40] usb: ulpi: Use of_request_module()
Date:   Tue,  4 Apr 2023 18:21:19 +0100
Message-Id: <20230404172148.82422-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

There is a new helper supposed to replace of_device_request_module(),
called of_request_module(). They are both strictly equivalent, besides
the fact the latter receives a "struct device_node" directly. Use it.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/usb/common/ulpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index a98b2108376a..6977cf380838 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -229,7 +229,7 @@ static int ulpi_read_id(struct ulpi *ulpi)
 	request_module("ulpi:v%04xp%04x", ulpi->id.vendor, ulpi->id.product);
 	return 0;
 err:
-	of_device_request_module(&ulpi->dev);
+	of_request_module(ulpi->dev.of_node);
 	return 0;
 }
 
-- 
2.25.1

