Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09945F842E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 10:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJHIBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 04:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiJHIBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:01:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95C5306
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 01:01:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso9107776pjf.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 01:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lM67uZd3PuvNYw+i0pkmt+skR8bo67DWOjK10ubuDi0=;
        b=i/vZG9IwQfgubVK61C5ZBjaNerM9s+TdYrT9705+jLOwF0qEYMKPU7uvxDPzB+Bw4U
         JPomSl18WijtChLeItlyPrKqsMsF0ipnmN8Gzpb+mDJNwcZRiz2EbpZq/hLqg4jm9CQr
         9PX3Ml+ulrdV1h+eXictYoMwiatrM7Xcrm7u175v+kHsOQLoUJWxE+OhHCuEaUPp/q0W
         aXDzNs9zYp5+yNd4u8YZyA/1fLqj695vdlnHAfN3L+stxC/OIzYEOyXCpQUfiY12eQcv
         Gg054a18unUcnxhOlb4sue0u8soK+/W6/htfGuXgXWFRW+ywbhchpKI4aGClqtU8pm2A
         E95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lM67uZd3PuvNYw+i0pkmt+skR8bo67DWOjK10ubuDi0=;
        b=zp+P3M1aRqqaCdSWGFzAdEI/K580zcishkW4I0S+ezKATXAXNW2IQ8Qr8/KkwEJFHu
         Ce10Uk6e7+4u5AJtgh1W6vR6BjzAVrvUWIuQzNLDIWkypjtOT4lmoIhpdggflDohuqGX
         GiAtnaFLDQ6mSk9Vy5gaMUGehlsVIyCByploAw3psTIZJFHahd9FwoZZZ/xAIwOLES7B
         4StXulggJ9lj8xAV56LH3YXTkd6fNKX8EtRhvCyXmUvrsYlV6wuJixQK7HGH1X7Eu9+4
         09OaMPAD9qKhovnag9HqzW9jS25UINAqb/cd1LZdpB8m/DzhqGAWU6GiqCLGm3Vs9tSn
         ZSBg==
X-Gm-Message-State: ACrzQf1CX3RR9kl1vDcar8FQhmcFw25/tniEqAHAySBWK058SqWbW+F+
        Wq+EIvnRuBlFpd8b4nZHQjinTSuBmDPUifBm
X-Google-Smtp-Source: AMsMyM4NK2EYMf7YWkPBn6FtXf8t3kLvuIcMBHchjYO5FoZVhQgmKN9aJqM/dOBESI/E+YW/dS7t+g==
X-Received: by 2002:a17:90b:350b:b0:205:dfc1:63a7 with SMTP id ls11-20020a17090b350b00b00205dfc163a7mr9454255pjb.41.1665216076243;
        Sat, 08 Oct 2022 01:01:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902780d00b0017d0e793932sm1337409pll.215.2022.10.08.01.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 01:01:15 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, wsa+renesas@sang-engineering.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] PNP: replace !strcmp with sysfs_streq
Date:   Sat,  8 Oct 2022 08:01:10 +0000
Message-Id: <20221008080110.309089-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_streq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/pnp/pnpacpi/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 38928ff7472b..d5748a21a7e1 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -317,7 +317,7 @@ static int __init pnpacpi_setup(char *str)
 {
 	if (str == NULL)
 		return 1;
-	if (!strncmp(str, "off", 3))
+	if (sysfs_streq(str, "off"))
 		pnpacpi_disabled = 1;
 	return 1;
 }
-- 
2.25.1

