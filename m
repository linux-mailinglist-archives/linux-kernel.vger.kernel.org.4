Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7B2735C21
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjFSQXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjFSQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:22:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52DBE5C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:22:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25df7944f60so2830051a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687191778; x=1689783778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYKfkHUhPmEWMTYBe49vLBB3BZHoBpD7ULXkFfcwNLg=;
        b=PVrB+7LDEV23b7y1JNuNcTb1lKoZ1vu0xbLyaKzfUTuvybQu4kEoQ8WQ4Fi2reP2SZ
         fmGKtpaTl8EYEQQLXtN4k1F5/Anq9IX3h1oKnYMMNVm3JKIdOUjIJeYEyBgpPEHLCeZV
         cv4RVUpLhNI6jtT0k2JoH3ZA4SCDnDJzPXvsRGPo+7LABM/6eL4KhO/ba6JUoqzVQvc8
         B1oJv9EY0Sq6le4qG3auPcsCNNx0ObsnxD/qLTTSzVi/rsHsM5+YdhrZXzYNZO7jXVm2
         mjWt4ZPUxbDyQ2dUVg5symwJzUq0XEkr/pD3vuFQ/XXNCIEwWAqffNrMXf9IpsNtSIuQ
         lqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191778; x=1689783778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYKfkHUhPmEWMTYBe49vLBB3BZHoBpD7ULXkFfcwNLg=;
        b=ePdvsztj9IOsY7KKYDeBiF2e+sHgSqaDUGo48ZIEGKgon/gE+Mx3LbWsIdn7Tb4uHd
         3DkWbeR7mA4hc4y/xYNjUuwlt1Bod8NQ2NdyM+oaV3pgkoVleD1lQBqGuWtjO4aKUcQc
         ep0ytP91PDvGmehFWlePXZRnb7iwl83sXhUBuUQ1bkctGUeWAkTEavhgSforbe/Ty5qL
         4pnf5a5xk/8jjVzZYCzse6epAaB4lnEhzFrVwd2lsyZUKEdflffCzHO9zpUxd9r8DFgd
         AT+naGRrpPs7W7n+3/0H8mRBJz3sjXQyofgfSGISMruaMrCUtc9JvKSUe9CzoTVYrb3q
         rLqA==
X-Gm-Message-State: AC+VfDymKHJimdzQL2ust5RmLTBvEBgPgBM9mXem6gJbtwjqkZpH5Pd+
        aLelbw1gNu1ONkyM2UK95Jk=
X-Google-Smtp-Source: ACHHUZ6f9DaBoWHDnC1YKiYnePtJl2GpijXt3bvzF+SpR4F244IpBpmOoILvRr8H/MFV6v2hANaJQw==
X-Received: by 2002:a17:90a:f83:b0:25b:f66c:35a9 with SMTP id 3-20020a17090a0f8300b0025bf66c35a9mr8970440pjz.48.1687191778229;
        Mon, 19 Jun 2023 09:22:58 -0700 (PDT)
Received: from redkillpc.. ([49.207.216.186])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a1a4200b0025f09822d7csm62997pjl.24.2023.06.19.09.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:22:57 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     prathubaronia2011@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: [PATCH v6 2/2] axis-fifo: change device name by assigning unique device id
Date:   Mon, 19 Jun 2023 21:52:45 +0530
Message-Id: <20230619162246.33007-2-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619162246.33007-1-prathubaronia2011@gmail.com>
References: <ZI/5H+GZU6/2osGT@redkillpc>
 <20230619162246.33007-1-prathubaronia2011@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocating the device name with a unique identifier
instead of a kernel address.

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 7d8da9ce2db8..5e070e00e27a 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -853,7 +853,7 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
 
 	/* create unique device name */
-	device_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%p", DRIVER_NAME, &r_mem->start);
+	device_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%d", DRIVER_NAME, pdev->id);
 	if (!device_name) {
 		rc = -ENOMEM;
 		goto err_initial;
-- 
2.34.1

