Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFDA72ABF0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 15:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjFJN7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjFJN7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:59:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5CE3A8D;
        Sat, 10 Jun 2023 06:59:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AABC361789;
        Sat, 10 Jun 2023 13:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3361C433D2;
        Sat, 10 Jun 2023 13:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686405556;
        bh=tcF/HfmUxjZ7gfHyYrjWsy+yGL6Y7F2Q0gJIGvetk8k=;
        h=From:Subject:Date:To:Cc:From;
        b=MDo3auGGo+o5iX9Yxl1HKqCjO6PmDPtt6J6DCMVlpxortmzMHBXiGHsqbVfvf3Euh
         4Y8/NlFPX29oP/a2WYDClnKcFRaz8ZuJ6vo03vuVVcYvxPNoIidAOavjQrnADL4KLO
         X0JWOIAqlhOcn19rc5wnQ+GwhLGWETKhoq3vAHPiKwJ6Xd/44wHdzP16zhr7Gy6rYL
         AlpHI+tQB2rFeVfgedK2UZtJqWvgiLLALnv2pD0VgMzXdkPvKUEhQ2y1BRJ2wtipsC
         ll3bupqvfWbosYsuGKG1wsJCsdDEHxWuDqvU4uV71M0egvOzHK9q9B2kuh4AtA+4Lm
         FJ0luIZXrnuQA==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/5] hwmon: Update single register drivers to use maple
 tree register cache
Date:   Sat, 10 Jun 2023 14:59:06 +0100
Message-Id: <20230609-hwmon-maple-v1-0-8edacce86b28@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKuBhGQC/x2NQQqEMAwAvyI5G6gVxO5XFg+tRhvUVlJQQfy71
 eMMDHNBImFK8CsuENo5cQwZqrKA3tswEfKQGbTStWqUQX+sMeBqt4WwNUqbqqkdDRpy4WwidGJ
 D79/miDK/ehMa+fwm/+6+Hz9DjrZ0AAAA
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tcF/HfmUxjZ7gfHyYrjWsy+yGL6Y7F2Q0gJIGvetk8k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIGt4dLiHXLhlv9N88TWy2ztCvktUKHsFbASaKIu
 tMjLuMOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISBrQAKCRAk1otyXVSH0K87B/
 9ETl1B6IsaR/IC8UI0SKHj7Ibh95quRCqJUFcc1yEcySXW8Cl/xjPQtiBikHT1btkBQ4fVoeh82uZ3
 QEWNrA1Dqo7koFh98WKVQ4P/l4/iYcfQKhdpkkiA9IT0Oz4qhFO53vZc3wZHzz0F5a/2pAAfJ6hs69
 bebIyX7OC2z38QblW8M8M92jjf9gNwQIoRdgUAEM3X36tP0PwUOdLTAAFVg1eC4xWtPMQm+I2/oJMj
 LUWqMhDt0q2sXlG3v8I/3xA94SMkgljLLFHOU66UR0QYPD7pTSDQ49s+vbskJ9IQPRK+M99OxoZkNd
 FMDr19/Ti7PIn25DiKoW5eKVBfrxPL
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of hwmon drivers only support single register I/O and therefore
gain no benefit from using the more modern maple tree register cache
over the rbtree cache, convert them to maple tree.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (5):
      hwmon: (lm75) Use maple tree register cache
      hwmon: (lm95245) Use maple tree register cache
      hwmon: (tmp102) Use maple tree register cache
      hwmon: (tmp108) Use maple tree register cache
      hwmon: (tmp464) Use maple tree register cache

 drivers/hwmon/lm75.c    | 2 +-
 drivers/hwmon/lm95245.c | 2 +-
 drivers/hwmon/tmp102.c  | 2 +-
 drivers/hwmon/tmp108.c  | 2 +-
 drivers/hwmon/tmp464.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230609-hwmon-maple-89029163bed2

Best regards,
-- 
Mark Brown <broonie@kernel.org>

