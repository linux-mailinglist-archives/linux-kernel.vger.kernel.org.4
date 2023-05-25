Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2701D7103B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbjEYEGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjEYEE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:04:27 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BDDE5E;
        Wed, 24 May 2023 21:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8LddvSprDhEznGBMdyZoKgXbNv0SgICpMxxb43tkSPM=; b=m7PMsANWAUO9nbSCBaPZIxCehR
        cyTf07pJUC/PadELpwlnrFtfqKqTRII8+0k8bNnRjMr2CESvUrcixCZ1BN9Nvm9GTKyhwWcElVms1
        nMLY7i9Ig+8lcQ5WJrbXkjFY7+wrtmeUB1mEImePpj0UXGh3NtC7zm7UApNObO0JS5ks=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52970 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q22D0-0001dB-74; Thu, 25 May 2023 00:04:14 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 25 May 2023 00:03:16 -0400
Message-Id: <20230525040324.3773741-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525040324.3773741-1-hugo@hugovil.com>
References: <20230525040324.3773741-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v3 03/11] serial: sc16is7xx: mark IOCONTROL register as volatile
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Bit SRESET (3) is cleared when a reset operation is completed. Having
the IOCONTROL register as non-volatile will always read SRESET as 1.
Therefore mark IOCONTROL register as a volatile register.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 00054bb49780..a7c4da3cfd2b 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -488,6 +488,7 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 	case SC16IS7XX_TXLVL_REG:
 	case SC16IS7XX_RXLVL_REG:
 	case SC16IS7XX_IOSTATE_REG:
+	case SC16IS7XX_IOCONTROL_REG:
 		return true;
 	default:
 		break;
-- 
2.30.2

