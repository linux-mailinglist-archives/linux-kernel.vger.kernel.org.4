Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3CC5EBE6E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiI0JWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiI0JUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:20:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BBFEE3A;
        Tue, 27 Sep 2022 02:19:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z25so14805097lfr.2;
        Tue, 27 Sep 2022 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=4lLAKqHQrN1fAyduMLD/hSt/zhI82biZLz/hG2MxrZI=;
        b=iUgKp7LMCmeJn+rrtuet062ceve/PB+xG6cpugqcAgAC745u0BnDvAPFGcx2K5AQmR
         y3g89+ZDFUGiv/gjatd/I8JNDcDa/pKGlkX3gYkKseK4J5YUxY5BZYyh9jhNTFyE0MYF
         GDGgSfuKmLjfah4q/Ns4vb0Soo21eIC0RCh+xqrAwjcBR85c8lDdUBP2cj/qeh+Y9ZLx
         9tuMjquGxzZzXBv2+bf+XNNaHysiuYaiOg2LGF6ezMFVqjD72a08UeyDW8Q4b0X6FCyA
         01c8kchXt+DySx97+99iGT3xehZzJgMIOqIGfMU2nVRUHX2z/7ZU5YXNLcBPBEMaqmkt
         Hi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4lLAKqHQrN1fAyduMLD/hSt/zhI82biZLz/hG2MxrZI=;
        b=c52JhMF67pArS6TZhrS1bHsBufMeloSeYnhLQiRSLPuX2C6XvUNmzGPf4+ZSFkprDV
         06vuMT7hUBAAUAv4S9X/UkTx0zkoziCCrRvr3+RPY7qOjRCNwSIb9irdeL8/DaRdu3YS
         GZJ414RLnzDlnrFvzU0FR2aHE0cKwrPGX9Na98lPWlsdo5x/j7lGqv9eN/eYe1xtStlj
         0urbPM1MkztgdwLV4ZIOuzbvks4XToROUjv0b+TzFBSydFyVbZo1eiucx7wkgpsPNJaJ
         iu3oyL+TXqZ6+s026iD9b6sy3xbRbuVmGyB8zSGC7sV9/VnP4zKzaUzloybTn6pdmqnm
         9geQ==
X-Gm-Message-State: ACrzQf2EotwLxmY+5rive1FrFow3kmz1ChQBxSxYOrfRpW+IR2DjYpbB
        iA/ndaJyh5H6NKeHEh3EhLsd35TpW+NlTw==
X-Google-Smtp-Source: AMsMyM4hCyibi09N6qpLrXSoBtUjB2rc7zxnDmim6Wz4BOJZPsVuxDxUXNd/PBqsfvqU/ncvxo08bA==
X-Received: by 2002:a05:6512:1287:b0:49e:f94f:eb72 with SMTP id u7-20020a056512128700b0049ef94feb72mr11465273lfs.376.1664270369015;
        Tue, 27 Sep 2022 02:19:29 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id h8-20020a2eb0e8000000b002648152512asm104269ljl.90.2022.09.27.02.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:19:28 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] iio: adc: mcp3911: return proper error code on failure to allocate trigger
Date:   Tue, 27 Sep 2022 11:25:37 +0200
Message-Id: <20220927092537.94663-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
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

smatch warnings:
drivers/iio/adc/mcp3911.c:441 mcp3911_probe() warn: passing zero to 'PTR_ERR'

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 0d768006eabb..e55db02c534f 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -554,7 +554,7 @@ static int mcp3911_probe(struct spi_device *spi)
 				indio_dev->name,
 				iio_device_id(indio_dev));
 		if (!adc->trig)
-			return PTR_ERR(adc->trig);
+			return -ENOMEM;
 
 		adc->trig->ops = &mcp3911_trigger_ops;
 		iio_trigger_set_drvdata(adc->trig, adc);
-- 
2.37.1

