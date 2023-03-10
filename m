Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0FE6B3A30
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjCJJR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCJJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:17:27 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CAEE90098;
        Fri, 10 Mar 2023 01:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=y8znz
        v8EogzdwmgG5+xhB25PTiRTxgErQ92Q7uiUT9o=; b=jxTSZ8spskYRjkBy3BupA
        T6GOPeknXjQlZLWEjGDogJb4h4jDqzEu2KwONowyqwxW5f8twLSzMula8L0//fce
        mRrDMyv6JPV3h5PJOk+FTlO63Hk6Rh7TMwdG281UGJM5dfyOWoln3+4unHbDNVq8
        AJu/q4JqQY0rufwYmoJeGA=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3_5uI9Apkyr5QCw--.41643S2;
        Fri, 10 Mar 2023 17:12:40 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     eugen.hristev@collabora.com
Cc:     jic23@kernel.org, lars@metafoo.de, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] iio: at91-sama5d2_adc: Fix use after free bug in at91_adc_remove due to race condition
Date:   Fri, 10 Mar 2023 17:12:39 +0800
Message-Id: <20230310091239.1440279-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_5uI9Apkyr5QCw--.41643S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr17XrWUCFW3ur1DtF4Dtwb_yoW8GF4Dpa
        na9FWDCFW7WF10qa1UA34jyFy8t3W5Kw10grZxua43uw45ZryYvr15Ka48XFW5tFyjyFsr
        XFy8Kw45KF1jyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRnmRUUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXQ4uU1WBo3P3ewABsn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In at91_adc_probe, &st->touch_st.workq is bound with
at91_adc_workq_handler. Then it will be started by irq
handler at91_adc_touch_data_handler

If we remove the driver which will call at91_adc_remove
  to make cleanup, there may be a unfinished work.

The possible sequence is as follows:

Fix it by finishing the work before cleanup in the at91_adc_remove

CPU0                  CPU1

                    |at91_adc_workq_handler
at91_adc_remove     |
iio_device_unregister|
iio_dev_release     |
kfree(iio_dev_opaque);|
                    |
                    |iio_push_to_buffers
                    |&iio_dev_opaque->buffer_list
                    |//use
Fixes: 23ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 50d02e5fc6fc..1b95d18d9e0b 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2495,6 +2495,8 @@ static int at91_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
+	disable_irq_nosync(st->irq);
+	cancel_work_sync(&st->touch_st.workq);
 	iio_device_unregister(indio_dev);
 
 	at91_adc_dma_disable(st);
-- 
2.25.1

