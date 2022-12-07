Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F5645950
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiLGLv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiLGLvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:51:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EBA51337
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:51:33 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id d14so19582621edj.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 03:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6KVLYAPLygGoe4sQi/p1SsV3HWl1bxrtOXgL4oTXqs=;
        b=J30v1DLLJRwACySk/YtVqRU3GkFmVzKkIrrQw06qLOBQuaoFmpU2vx3paOASsJIQra
         O8Pk7NYj1MNmzQgSw0wnoem3+mYToznn6NbAlshUNv9CleRAr8xSGdbILoBj0WedlJc3
         wPZewCgsR7X6/cz5xGOr6agtr5Y34w3W0xaYFgGRN6LD/oUR46jm7RwSz9nAMxtE3QQz
         Viz+suMJwJqQ0sKOwVVFN+W5JSnwc6/eLeLRvqFtCp/cRgJ6HWuV3PIMASbXyBi/d+5O
         60OhqraU9TU6PyEsc1p4ZrQcn4okEJbHI5Eidlhp8cJb+981mRM/4l+Vw7f/YKwRf0vE
         fJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6KVLYAPLygGoe4sQi/p1SsV3HWl1bxrtOXgL4oTXqs=;
        b=XLvlHwaxgkWx7lttWUZ6Llky+zDT+x5RH+QOsrtKQX16ilVAW57qcZONkYGfK3Q3By
         MwS50HNOKLS5zgFpeUuDGhse3oCDOYKxhLrdsz1im3AV54CV8bpzdDdT3HM+lxW/gBXr
         gpdybocTLRHMK61hRuL6Ys+Kgi4zwswhACZQz7RLF3dCE08kpqZh34zx3mD5kTYVSX+7
         Gdg9b6KkjPFJu9ItE89YXv+WJHh760xKbxprq8qTix7PoDkw4gJxVCL5SkUAgM0qDNSh
         ryQWD3B4/6TdKA2ynAJ+GtTFCZbZQNPibUGu8v1fifZr0IBdFE0R6HQ/AY8KlpGCTega
         b2jA==
X-Gm-Message-State: ANoB5pngWAUvlmpGlOVR6ioOerDX+3dxUqMi+08oynQgprAmqamwxYyU
        fA+cIpPjnbuBhFmb7bVrsZ9lLQ==
X-Google-Smtp-Source: AA0mqf5nuG78G3ParQRGYGQx9/qgTYYpjKlI4g1n6r6f8suS7gW7VmK8EXRf7oBTGYdKcv14pR5JCA==
X-Received: by 2002:a05:6402:3886:b0:463:ab08:2bc6 with SMTP id fd6-20020a056402388600b00463ab082bc6mr63763991edb.143.1670413889261;
        Wed, 07 Dec 2022 03:51:29 -0800 (PST)
Received: from localhost.localdomain ([193.33.38.48])
        by smtp.gmail.com with ESMTPSA id g26-20020a056402181a00b004618a89d273sm2132816edy.36.2022.12.07.03.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 03:51:28 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH v5 3/6] driver/net/tun: Added features for USO.
Date:   Wed,  7 Dec 2022 13:35:55 +0200
Message-Id: <20221207113558.19003-4-andrew@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207113558.19003-1-andrew@daynix.com>
References: <20221207113558.19003-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for USO4 and USO6.
For now, to "enable" USO, it's required to set both USO4 and USO6 simultaneously.
USO enables NETIF_F_GSO_UDP_L4.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/tap.c | 10 ++++++++--
 drivers/net/tun.c |  8 +++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 9e75ed3f08ce..a2be1994b389 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -957,6 +957,10 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 			if (arg & TUN_F_TSO6)
 				feature_mask |= NETIF_F_TSO6;
 		}
+
+		/* TODO: for now USO4 and USO6 should work simultaneously */
+		if ((arg & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
+			features |= NETIF_F_GSO_UDP_L4;
 	}
 
 	/* tun/tap driver inverts the usage for TSO offloads, where
@@ -967,7 +971,8 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 	 * When user space turns off TSO, we turn off GSO/LRO so that
 	 * user-space will not receive TSO frames.
 	 */
-	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6))
+	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6) ||
+	    (feature_mask & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
 		features |= RX_OFFLOADS;
 	else
 		features &= ~RX_OFFLOADS;
@@ -1091,7 +1096,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 	case TUNSETOFFLOAD:
 		/* let the user check for future flags */
 		if (arg & ~(TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
-			    TUN_F_TSO_ECN | TUN_F_UFO))
+			    TUN_F_TSO_ECN | TUN_F_UFO |
+			    TUN_F_USO4 | TUN_F_USO6))
 			return -EINVAL;
 
 		rtnl_lock();
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 24001112c323..a7b9808368d0 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -185,7 +185,7 @@ struct tun_struct {
 	struct net_device	*dev;
 	netdev_features_t	set_features;
 #define TUN_USER_FEATURES (NETIF_F_HW_CSUM|NETIF_F_TSO_ECN|NETIF_F_TSO| \
-			  NETIF_F_TSO6)
+			  NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4)
 
 	int			align;
 	int			vnet_hdr_sz;
@@ -2885,6 +2885,12 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
 		}
 
 		arg &= ~TUN_F_UFO;
+
+		/* TODO: for now USO4 and USO6 should work simultaneously */
+		if (arg & TUN_F_USO4 && arg & TUN_F_USO6) {
+			features |= NETIF_F_GSO_UDP_L4;
+			arg &= ~(TUN_F_USO4 | TUN_F_USO6);
+		}
 	}
 
 	/* This gives the user a way to test for new features in future by
-- 
2.38.1

