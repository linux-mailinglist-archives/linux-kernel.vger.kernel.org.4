Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE086F8DE1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjEFCPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEFCPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:15:40 -0400
Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B2976A5;
        Fri,  5 May 2023 19:15:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2457787|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0424939-0.00109742-0.956409;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=chenh@yusur.tech;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.SZYz9Ya_1683339330;
Received: from localhost.localdomain(mailfrom:chenh@yusur.tech fp:SMTPD_---.SZYz9Ya_1683339330)
          by smtp.aliyun-inc.com;
          Sat, 06 May 2023 10:15:32 +0800
From:   Hao Chen <chenh@yusur.tech>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     huangml@yusur.tech, zy@yusur.tech
Subject: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum MTU' bigger than 1500
Date:   Sat,  6 May 2023 10:15:29 +0800
Message-Id: <20230506021529.396812-1-chenh@yusur.tech>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VIRTIO_NET_F_MTU(3) Device maximum MTU reporting is supported.
If offered by the device, device advises driver about the value of its
maximum MTU. If negotiated, the driver uses mtu as the maximum
MTU value. But there the driver also uses it as default mtu,
some devices may have a maximum MTU greater than 1500, this may
cause some large packages to be discarded, so I changed the MTU to a more
general 1500 when 'Device maximum MTU' bigger than 1500.

Signed-off-by: Hao Chen <chenh@yusur.tech>
---
 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8d8038538fc4..e71c7d1b5f29 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4040,7 +4040,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 			goto free;
 		}
 
-		dev->mtu = mtu;
+		if (mtu > 1500)
+			dev->mtu = 1500;
+		else
+			dev->mtu = mtu;
 		dev->max_mtu = mtu;
 	}
 
-- 
2.27.0

