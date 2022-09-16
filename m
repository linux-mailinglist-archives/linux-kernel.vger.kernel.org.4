Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199305BA490
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiIPCPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIPCPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:15:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8282D58DFE;
        Thu, 15 Sep 2022 19:15:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso24243269pjk.0;
        Thu, 15 Sep 2022 19:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ETyx8IQCepnGQ6yUcDGyA+MzQ9TZbCoht1acGd3UBlc=;
        b=O6wPxm/dvX+ifr7286Mn7rOx3FUJwj9pwfiSC8ryHe/NsAJbAWTFh6pXtPIX66Naz1
         o3haEWZpa1N8TAzqO0+K0QN6BuqByZ4w8AGouP0QXXDs8t9uKI2LIovSe+HQ80pUGKYx
         BpwhnAwCS4MYsmOVP0lac+QuuZ3X2KFw3ailGyCt+fQ1x3Xe1ch5OiJvzZCXv1dE0D8K
         E/2DSXbztQpNOXbw63sDa+fD3sCU8/98Ah43RT9SzltDFPHXjz190BQjMM+aq3+9EzyV
         jqMErCvETCMAGMqjMkBlDMz3/Etguz9Ti2GOJfI/w+7TqUNVCNojF8X38petPm4IXgWo
         mnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ETyx8IQCepnGQ6yUcDGyA+MzQ9TZbCoht1acGd3UBlc=;
        b=pAOPONEB2+qoQmnSesdLw2ctp6dcAdDl9COvzbwAr7I2C7iyndXDz1S8LPvXDpxLL0
         jgdTKtoIsKQ3XR3RAvXyXHj9Y8KVxq3wkVM5TcQ33KRqiu7B15u/pj8sO74WFi47K3vB
         PruLlAKjOClCe7IQqIrG7AxJA8tZTD3lADuzTB9yu1vs5HLFRgTvnm8PF5oQ5mrXEkdB
         VfpAA5LuJRj7t+gy5rstwVHTD7MugHwrlMIb663J+uwZw38GAL7Ww5/+ZqbhqKRNHqI4
         FhK0zC2NJMc7Z1pxTNnuM/B5dAZ847vybOBg/FCtJK4HTMe+nTw9qjnWa5UnR3+29V3b
         jSUA==
X-Gm-Message-State: ACrzQf2svIooyb1asDrKLCOthaM2Qbn6fXo55rVoDpe1ew0/9ZPPQqjN
        3OtIyYbjjDwXWTszsbjmfRo=
X-Google-Smtp-Source: AMsMyM7nNgtoE1VvKfoFP7+Y97bE9l0C1nG9c/1YlyO8PPdOho8VzQkNuM2KKtY1W12MnJojlL+htg==
X-Received: by 2002:a17:902:bc44:b0:176:909f:f636 with SMTP id t4-20020a170902bc4400b00176909ff636mr2353932plz.21.1663294507705;
        Thu, 15 Sep 2022 19:15:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:578:40c5:44cb:7b1e:21e9:77e5])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902714100b001780e4e1a0fsm13549334plm.125.2022.09.15.19.15.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Sep 2022 19:15:07 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] PM: core: Add pm_wakeup_pending check in device suspend_noirq
Date:   Fri, 16 Sep 2022 10:15:01 +0800
Message-Id: <1663294501-6377-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

In 'dpm_suspend_noirq', it will do the sychronized_irq to guarantee all
irqs are all done, and then do any wakeup flag set.

For some peripherial deivces like as I2C/SPI, to speed up the irq handling,
it may use 'pm_stay_awake' and really handle in another thread context like
as workqueue.

But in mem suspend flow, after 'dpm_suspend_noirq" stage, the next
'pm_wakeup_pending' check will be at 'syscore_suspend'.

The checkpoint seems too late and cause I2C/SPI fail during 'noirq' to
'syscore_suspend'. But some adapter was already be marked as 'suspended'
at 'noirq' callback, any I2C/SPI xfer will return the error flag '-ESHUTDOWN'.

After the code trace, it seems all device callback will do 'pm_wakeup_pending'
check, except 'noirq'.

This patch is to add 'pm_wakeup_pending' check in 'noirq' sage to prevent this
kind of usage.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,

Is there any rule to define when I2C/SPI host controller need to mark adapter as
'suspended'?

I trace 'drivers/i2c/buses'.It seems there's no common rule, Some are 'suspend',
others may did it at 'suspend_noirq'.

---
 drivers/base/power/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index c501392..7cd7dc5 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1210,6 +1210,11 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	if (async_error)
 		goto Complete;
 
+	if (pm_wakeup_pending()) {
+		async_error = -EBUSY;
+		goto Complete;
+	}
+
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
-- 
2.7.4

