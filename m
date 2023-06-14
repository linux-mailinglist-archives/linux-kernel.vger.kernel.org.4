Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D3672F4D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbjFNGbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243154AbjFNGal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:30:41 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701421FCC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:30:22 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686724220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kf6zgkDUnecNfzu3j5XSu5/huKGd/SdarF/Qmk9HXkg=;
        b=ZgToFv6kXV0KhJSTl92ii6RlUbRLDMkIf2OuYuvSLGVaebwUuK5+kRvMfry1Rcq2lIj8Ot
        AmilI1hLbUuCrTC/xguPSLN5yJOM5WhMA0t0LL/LtaIVkR6/kyhk4lcSA8ILjkigNwP2Mh
        dTLbaKcRRnnfzhsIpLI1NfP81x8bXVc3dDmV3G0RoaGcpyM4AuUz5smiDioeHngUjqL2UL
        sgHvPHHZQKImn5RxxXLQhlZnUCqlrPO+mx/YaaALv0e5Zb2yon35hK33cXYMuwt6IXmkkm
        nt5rfa1vK19j5oO300bAmg6D2aFMP8/cvWu0I9+KIBTg4jLfN6Bi3yEBKAmCpg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 144CFFF806;
        Wed, 14 Jun 2023 06:30:19 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 1/4] sysfs: Improve readability by following the kernel coding style
Date:   Wed, 14 Jun 2023 08:30:15 +0200
Message-Id: <20230614063018.2419043-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614063018.2419043-1-miquel.raynal@bootlin.com>
References: <20230614063018.2419043-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of the if/else block is to select the right sysfs directory
entry to be used for the files creation. At a first look when you have
the file in front of you, it really seems like the "create_files()"
lines right after the block are badly indented and the "else" does not
guard. In practice the code is correct but lacks curly brackets to show
where the big if/else block actually ends. Add these brackets to comply
with the current kernel coding style and to ease the understanding of
the whole logic.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 fs/sysfs/group.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index eeb0e3099421..990309132c93 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -142,8 +142,10 @@ static int internal_create_group(struct kobject *kobj, int update,
 				return PTR_ERR(kn);
 			}
 		}
-	} else
+	} else {
 		kn = kobj->sd;
+	}
+
 	kernfs_get(kn);
 	error = create_files(kn, kobj, uid, gid, grp, update);
 	if (error) {
-- 
2.34.1

