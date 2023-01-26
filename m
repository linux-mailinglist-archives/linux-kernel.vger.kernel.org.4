Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E6867CBB1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjAZNLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjAZNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:11:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A3F5CE64;
        Thu, 26 Jan 2023 05:11:20 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b7so1738877wrt.3;
        Thu, 26 Jan 2023 05:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2S/ipA/9g/mh++oTHmcKnPzLXdLbeAd12iCuLVYH2Ac=;
        b=YE7O1pGbE9s7qoerwgEuDCce7W4G47Zh0EjoFKJwGkLuGDR2QNVcxQkVNLQeIV1adF
         rKiyTAaKYb/Oyu7h1Xkztxzk710tofZricu92GhutCKcdsVTQV7PcrbnALUYXA81IrYV
         eLUT13lEBXFZMs/XnITaAJVccaWDYU+oh4MS2l/6vJ+SnCpX5sofnAAo1c2O/jaQHKEI
         e26BEpLZNCel7ufinTuAsl3MpDeWMgoSfi59BKUNutkRZY4uzjkxlJ8kqfWn6aWH0T5l
         9A9X9KecOiE4YwxwqPekxkOFDcttMSj9sdOL14wqcWoebglPbrplaosu6hJ5HFKsQdpW
         cdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2S/ipA/9g/mh++oTHmcKnPzLXdLbeAd12iCuLVYH2Ac=;
        b=tECCcBKLkYBUMtGOyNWfRznQOoRC4+TXCpAa+2DOfi/G2CRY+LFSNUZ3ECbviFT+/0
         Kq1Xin+fV0/EHtpdf+SpcbMcHrz4zOB8p0ZbENiF6Te8lNV3mGcUBzk+E5HRwhoW97s3
         8RGxll247MVw1Yedcdg0q0o8ieiLjuZwc4VW1eDrDH8EjOn3k1IYVg2EYD8IkHJ0ndpB
         4RsI48KJcn9U51R5szX54pZ33YQiH+/RCAak1W2SAAtGprFDPkmP5wT+NQZbgG4iTqAe
         t2A+sFi3lx+14idVkfyseeUg3iFZVjA2JFA1phTuUBu+xkcTWIltpS+t6AXPfhVZhfRX
         pn/w==
X-Gm-Message-State: AO0yUKWUW6aRSxQ5F0yKQ/tUHqDY19sfNCV2pxa4CQAjTlPz1CrN4F0v
        hgcOrKLMrFN/HjdDhpswlpg=
X-Google-Smtp-Source: AK7set8epWsBnAVvgWMdmPSduDWfaWuOG8jT4g/kO2JssZ3fn5qs401EZPgqp1HuWGcwXL0MngR7ow==
X-Received: by 2002:adf:e507:0:b0:2bf:c14e:ca00 with SMTP id j7-20020adfe507000000b002bfc14eca00mr2898893wrm.51.1674738679344;
        Thu, 26 Jan 2023 05:11:19 -0800 (PST)
Received: from bg0vshp.festo.net ([165.225.26.201])
        by smtp.googlemail.com with ESMTPSA id p6-20020a5d48c6000000b002bfc0558ecdsm1215256wrs.113.2023.01.26.05.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:11:18 -0800 (PST)
From:   Ivo Borisov Shopov <ivoshopov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     ivoshopov@gmail.com, Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools: gpio: fix -c option of gpio-event-mon
Date:   Thu, 26 Jan 2023 15:10:33 +0200
Message-Id: <20230126131033.23011-1-ivoshopov@gmail.com>
X-Mailer: git-send-email 2.20.1
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

Following line should listen for a rising edge and exit after the first
one since '-c 1' is provided.

    # gpio-event-mon -n gpiochip1 -o 0 -r -c 1

It works with kernel 4.19 but it doesn't work with 5.10. In 5.10 the
above command doesn't exit after the first rising edge it keep listening
for an event forever. The '-c 1' is not taken into an account.
The problem is in commit 62757c32d5db ("tools: gpio: add multi-line
monitoring to gpio-event-mon").
Before this commit the iterator 'i' in monitor_device() is used for
counting of the events (loops). In the case of the above command (-c 1)
we should start from 0 and increment 'i' only ones and hit the 'break'
statement and exit the process. But after the above commit counting
doesn't start from 0, it start from 1 when we listen on one line.
It is because 'i' is used from one more purpose, counting of lines
(num_lines) and it isn't restore to 0 after following code

    for (i = 0; i < num_lines; i++)
        gpiotools_set_bit(&values.mask, i);

This patch just restore the initial value of the iterator to 0 in
order to allow counting of loops to work for any cases.

Fixes: 62757c32d5db ("tools: gpio: add multi-line monitoring to gpio-event-mon")
Signed-off-by: Ivo Borisov Shopov <ivoshopov@gmail.com>
---
 tools/gpio/gpio-event-mon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/gpio/gpio-event-mon.c b/tools/gpio/gpio-event-mon.c
index 6c122952c589..5dee2b98ab60 100644
--- a/tools/gpio/gpio-event-mon.c
+++ b/tools/gpio/gpio-event-mon.c
@@ -86,6 +86,7 @@ int monitor_device(const char *device_name,
 			gpiotools_test_bit(values.bits, i));
 	}
 
+	i = 0;
 	while (1) {
 		struct gpio_v2_line_event event;
 
-- 
2.20.1

