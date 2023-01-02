Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2338F65B10B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbjABL37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABL30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:29:26 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E16565A5;
        Mon,  2 Jan 2023 03:28:54 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p24so6810910plw.11;
        Mon, 02 Jan 2023 03:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBKmxmk+PNQSBGyHxHAqURGaUcC718UdtWX3gmDzrTk=;
        b=NAQxwnqMteNLaN4SsuUnZfL9t+D2xNfYU8o7Vk7fCwBwurFz9/zAtWZ1z3GH+hniHQ
         JZWPH7Lw6aMPeWxoIZK51WFGGSOxbgH6V/rdZBKsQThip4qq1ZPFdx8GNjss9Hg6u6MF
         Wztnpy+B1a+LbFU7EfQIWtXknb+b13y931EZNiwePHm3fMdZ9lAwa5z5fFpwMdeHOuBx
         znwM7P8QSUSgkl8Y9gRV81N5iKMV294rsdiBY9u8nkXv6YiXgFKSBUTO+LT/wQAFW/wP
         t5OfF42Wz1Cd/bXNIymbZm9NW6lIbUw4dBKQHAeeNw2p/NiNSVmWyQR6vmVaqBbFDwDL
         dFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBKmxmk+PNQSBGyHxHAqURGaUcC718UdtWX3gmDzrTk=;
        b=o/PzA33+WkQ9G+QvJfe78rHtiB4qHNPtzfJi8QbsMvehGY/mYHEGkwe+JIlGDLFxEu
         4AKac4m3RHQJnW7bEo8RJrG5m6S9Ny7lwdo4843sI6cwifOjrRToPp5/GACdLAWaAY4N
         342jPGPrL5cKRQ2RmnDcLwsItIRCK1xqIMGjBizRLQaEk7MPGzeh2y3gSMWGGx6MvNCi
         ivJhZ+quP6PNC1ZMJxoipdE2dJILgdm3DtRwwZXkl1VK6Eis6BRFF1KAI8niwrNLCvYa
         rUexpc/M+pfxgZsQjt+y9Ott9CrxZtZXiqOLl+45MicTsi7P8v+T3GHOgoOM3nCVDVQ/
         VPcA==
X-Gm-Message-State: AFqh2kpYVHyOfwqTud8boD0pABBl2PhPXxY/MAXpFzWvkCx19PJWaahH
        4mQj4m6Ip9hzgXgH8zAYt8Q=
X-Google-Smtp-Source: AMrXdXv/9sCjzggdaDkY0VUokqf3GLUZF1q5QPRnxXrit88ybAKuI94pRMqWsDHuwcHl1eRBLCOLJw==
X-Received: by 2002:a05:6a21:3a48:b0:ad:5cde:5beb with SMTP id zu8-20020a056a213a4800b000ad5cde5bebmr49641340pzb.47.1672658933920;
        Mon, 02 Jan 2023 03:28:53 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id on16-20020a17090b1d1000b0020b21019086sm33140160pjb.3.2023.01.02.03.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 03:28:53 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] pinctrl: rockchip: Fix refcount leak in rockchip_pinctrl_parse_groups
Date:   Mon,  2 Jan 2023 15:28:45 +0400
Message-Id: <20230102112845.3982407-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_phandle() returns a node pointer with refcount incremented,
We should use of_node_put() on it when not needed anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: d3e5116119bd ("pinctrl: add pinctrl driver for Rockchip SoCs")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index da974ff2d75d..0bc3dc2220fd 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -3036,6 +3036,7 @@ static int rockchip_pinctrl_parse_groups(struct device_node *np,
 		np_config = of_find_node_by_phandle(be32_to_cpup(phandle));
 		ret = pinconf_generic_parse_dt_config(np_config, NULL,
 				&grp->data[j].configs, &grp->data[j].nconfigs);
+		of_node_put(np_config);
 		if (ret)
 			return ret;
 	}
-- 
2.25.1

