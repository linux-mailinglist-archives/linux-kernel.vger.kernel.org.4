Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D786D29AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjCaU4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjCaU4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E36422C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680296151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4iXEOFNILcUMsIjcydKfmGYblvwSUsIqK+R28wpgVSw=;
        b=QvlhnNWdvR63emgQlVSCI0MMGQmbswSkfPKRjOy2joYUteSP9FktX8hMeLy+5D3a4s3MbQ
        ed/VqdQTjOEexlYQe7EbLiEQdlApHZdZZiCIdv406XCVdgpO0LH/6C1zCuypj+HQzECVIr
        nBYbdbr84ARtjDK18wJvjpPIFapq1+o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-Z-irLgpsOsWstfv7RBHwxQ-1; Fri, 31 Mar 2023 16:55:49 -0400
X-MC-Unique: Z-irLgpsOsWstfv7RBHwxQ-1
Received: by mail-qk1-f199.google.com with SMTP id b34-20020a05620a272200b007460c05a463so11073426qkp.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680296149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iXEOFNILcUMsIjcydKfmGYblvwSUsIqK+R28wpgVSw=;
        b=aCaqx8dNdrz9DS6ZcVWrl/Hga3d2g467+Sh5lN6kXfruQMwGLUEOxBMk4tobb/8D3K
         QouzLK4PgqZ+evH7aynTStLI6YqW1h0UiX5ocBPfxOQpnwnOUVsw/KhnywwQijJ7jdhK
         VQ5gLtkt3389EprmCos+NiSlRUYU33SqQbYVUKn6YYHzGGi+6eLBEb1e9bWODSwUc1PM
         qp9FrWQlsyF47yDa5uadUHErOH+C44WPpyTZ9xC/2FuKOjN8mh19pkanRlvQWhKTJiy+
         EYc1iOgt3Z0ZlzTrGFnlRqYPSNq8RLTPAkhIZopfphHVW4ns3XDsek+AhhJSbRNRlC3P
         lJPQ==
X-Gm-Message-State: AAQBX9ftPeq4rYPEGkVKpap3TRPh9GYizF/zmi227A+B5haq+bkrIK3X
        qdcF5xrEKdDKp/La3PQc0BT4oQ3KhdGpbisYYCar9gL0tU8g5JOxlkHhHLShCpNa2SykCR79him
        XaSNwonPbbTmdrC0o+bYZXXmW
X-Received: by 2002:a05:6214:d83:b0:5df:3310:c1f9 with SMTP id e3-20020a0562140d8300b005df3310c1f9mr28014874qve.5.1680296149145;
        Fri, 31 Mar 2023 13:55:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350b7lU6rfvonQF6UvzHAg1z9y6+ns7pWBTCXqEidZmccRyfV4/pcAgSDviIOorQpDT9jgOtcwg==
X-Received: by 2002:a05:6214:d83:b0:5df:3310:c1f9 with SMTP id e3-20020a0562140d8300b005df3310c1f9mr28014849qve.5.1680296148838;
        Fri, 31 Mar 2023 13:55:48 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o6-20020a0c9006000000b005e0cd3c21c8sm875543qvo.13.2023.03.31.13.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:55:48 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jes@trained-monkey.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-acenic@sunsite.dk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: alteon: remove unused len variable
Date:   Fri, 31 Mar 2023 16:55:45 -0400
Message-Id: <20230331205545.1863496-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/net/ethernet/alteon/acenic.c:2438:10: error: variable
  'len' set but not used [-Werror,-Wunused-but-set-variable]
                int i, len = 0;
                       ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/alteon/acenic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/alteon/acenic.c b/drivers/net/ethernet/alteon/acenic.c
index d7762da8b2c0..eafef84fe3be 100644
--- a/drivers/net/ethernet/alteon/acenic.c
+++ b/drivers/net/ethernet/alteon/acenic.c
@@ -2435,7 +2435,7 @@ static netdev_tx_t ace_start_xmit(struct sk_buff *skb,
 	} else {
 		dma_addr_t mapping;
 		u32 vlan_tag = 0;
-		int i, len = 0;
+		int i;
 
 		mapping = ace_map_tx_skb(ap, skb, NULL, idx);
 		flagsize = (skb_headlen(skb) << 16);
@@ -2454,7 +2454,6 @@ static netdev_tx_t ace_start_xmit(struct sk_buff *skb,
 			const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 			struct tx_ring_info *info;
 
-			len += skb_frag_size(frag);
 			info = ap->skb->tx_skbuff + idx;
 			desc = ap->tx_ring + idx;
 
-- 
2.27.0

