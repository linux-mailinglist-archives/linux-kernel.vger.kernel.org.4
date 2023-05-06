Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B6B6F92FD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjEFQE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 12:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFQEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 12:04:23 -0400
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B3510DE
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 09:04:21 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id vKOPpaWk2Mk9uvKOQpAa5h; Sat, 06 May 2023 18:04:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683389060;
        bh=0FotBQHha+qZRI5XXIk6G0iRigNGwWlnzMiCXh1rLH4=;
        h=From:To:Cc:Subject:Date;
        b=hzhoxFp4qyXukAuHJwGCYHcARfYcqtaflHFyYmnwCigie8I9Dkr0YB30gX/hsHSDH
         82HIL/wNNcR/7rkugu9UBXo4MG0m+SFLSc/luFK5VbaQzEqA6fnbEUwvVBcqKu+eSQ
         FsaUvN9pb0a311jkTEzOvsokL9rtmSS6VNoslvbPgEeMx1PVIjJhepH3BqegU5+TKA
         RH7zhU2aND9zTSbmOi38vS3auJLVG/tdPEg2wceGnLS1Jh3TKzgQVrQgApvUvAFHMA
         p/XH7iws/UBPoiW5cZmJun5f2YIZ+pZME0lKx4ast4MF3UZg51mUydDGsqpZ2q6bqC
         2vGIF8YaYvSDQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 May 2023 18:04:20 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org, dev@openvswitch.org
Subject: [PATCH net-next] net: openvswitch: Use struct_size()
Date:   Sat,  6 May 2023 18:04:16 +0200
Message-Id: <e7746fbbd62371d286081d5266e88bbe8d3fe9f0.1683388991.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct_size() instead of hand writing it.
This is less verbose and more informative.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
It will also help scripts when __counted_by macro will be added.
See [1].

[1]: https://lore.kernel.org/all/6453f739.170a0220.62695.7785@mx.google.com/
---
 net/openvswitch/meter.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
index f2698d2316df..c4ebf810e4b1 100644
--- a/net/openvswitch/meter.c
+++ b/net/openvswitch/meter.c
@@ -69,9 +69,7 @@ static struct dp_meter_instance *dp_meter_instance_alloc(const u32 size)
 {
 	struct dp_meter_instance *ti;
 
-	ti = kvzalloc(sizeof(*ti) +
-		      sizeof(struct dp_meter *) * size,
-		      GFP_KERNEL);
+	ti = kvzalloc(struct_size(ti, dp_meters, size), GFP_KERNEL);
 	if (!ti)
 		return NULL;
 
-- 
2.34.1

