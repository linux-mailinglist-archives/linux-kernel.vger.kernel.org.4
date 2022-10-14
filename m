Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2885FED6A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJNLrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJNLrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:47:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5541CA595;
        Fri, 14 Oct 2022 04:47:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so7667032pjq.3;
        Fri, 14 Oct 2022 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pndTdcmBYUOsi9vNLnQJgPVCRSImYXTUpjmesPh3caE=;
        b=OIK0HUXYxLkLmDR1b5O1tpDl+0bj/jV/c1+RX+tkeIc6bvZfYRy+E0FzY4SKaALiPH
         3oxkVICIKJmHTQey6MEn7/1KRMXBwQFxQqlx2/6H6fRszD2yJSfSeTaR4FDD46YOKnsM
         VWV7nlEzNqBb7loX3jMHvdFa6kCobHqZO9krFhWImxrMZjzxMfLuqJ0BvpdXIBbuHs38
         hXWIOTw+llzDE5l+cqSg3E0USlEthoNrwlkKVW4GShrjSKWCBl7S67s8vaL/8bJnI+pL
         MGP7j0W/hEXvn756vGt6QTstFwcmA6aWd9oYMIG52WGN8+uqdPHrHiLaT4Ufa2sG7JUB
         9lDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pndTdcmBYUOsi9vNLnQJgPVCRSImYXTUpjmesPh3caE=;
        b=DLK4hDw5W6rGNt9CQgX4yGnxxaFrcrAinBKmCjBwhABdfXoBpOoqE+x3rJCFLHQroH
         tSGIgrDS69OvxN/kPfZd6c4U3M7mIVjEdyU89QBNpe6OpUQLZH//F0xS8vm804XMnlUe
         5ZR+g/XXtIxIhEa1nyd6luPPMkAGtq0dHnMQYKA0Akfm+3WvRza262ZxAM0ZK93lH/4L
         c2CsgECa347Qzg4bGKM6jmfj2q1XyUK+AMpGXPbKi94obKb20LcjkziTJOuzZWQlWosy
         DiAPs72hjq3pV/+qiYM+8qgV6+bEGDEE6rjWemuPlBqxZqCiZDUuwzE/o4cGzLrJOiQ8
         FQFw==
X-Gm-Message-State: ACrzQf2jPbjtXaizc/WSTQRf54bp1bJcdugJerGNmsgmpZFO2oyaG8TF
        tCOjoWMwuiUdOjxvNmZ+okQ=
X-Google-Smtp-Source: AMsMyM6/L4jftuZCThbByLTdr1rJnQVH8mr2BFUVohEIjFGyaRysjEi+Jp/pP1jL+exgVUE2etmO1g==
X-Received: by 2002:a17:902:724a:b0:177:fd96:37bf with SMTP id c10-20020a170902724a00b00177fd9637bfmr4439901pll.25.1665748050772;
        Fri, 14 Oct 2022 04:47:30 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:47:30 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 07/26] mmc: sdhci: add a kernel configuration for enabling UHS-II support
Date:   Fri, 14 Oct 2022 19:45:42 +0800
Message-Id: <20221014114601.15594-8-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
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

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
in the following commits to indicate UHS-II specific code in sdhci
controllers.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e63608834411..d89e7bf91c35 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -89,6 +89,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 
 	  This is the case for the Nintendo Wii SDHCI.
 
+config MMC_SDHCI_UHS2
+	tristate "UHS2 support on SDHCI controller"
+	depends on MMC_SDHCI
+	help
+	  This option is selected by SDHCI controller drivers that want to
+	  support UHS2-capable devices.
+
+	  If you have a controller with this feature, say Y or M here.
+
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
-- 
2.25.1

