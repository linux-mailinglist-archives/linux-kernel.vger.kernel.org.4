Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE871717D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjEaKm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjEaKm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:42:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9980BE;
        Wed, 31 May 2023 03:42:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5289ce6be53so589436a12.0;
        Wed, 31 May 2023 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685529745; x=1688121745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPx/iynNOvvlzHXUOH2e7MeUR4JsTfqmjD2ESWI6jAk=;
        b=WQJCOdK8bkEEUi3W8bYSccdBi0KK8d/PuHyguCmhIcxFPjyQg9kmIbjRT91RyIGp3z
         iN5uHJA8HVaAlja5+C+IydMnxdtKs0mhUh9lXLYeZ4Kt915dl85EaVQx/GHMwSqlAC0V
         07Cnu4LxQbOY92umdz62Bx9aNgCLz72M80gtMybIW2Yts8H2SL232S/wdGOD7G/DYco+
         ectahprf5qKQ9eA005OCN/zFnL3LdKVPtbzxIXAaIC6oyMAVLlW4OkMfL6a5mNpqlx8n
         57x1aoMXyf00aJOdqY0Ye365X2XDtIhVbKHDXIyPUlg0IMBUBAmp9hp/DRU6yg3dr6mP
         0wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685529745; x=1688121745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPx/iynNOvvlzHXUOH2e7MeUR4JsTfqmjD2ESWI6jAk=;
        b=a1q1ltMfxF98pEXSrbGkS44PxjKzKFbkxI7+UQ3tG9gJ4WVfe94bO0OyjPcdN6vhGG
         SLQK6U8KHN/5f3fPoH+Q8bNUa8syeq+NsEdqk9mJqeXHm5HbH/iy3PJdAgRlNJgV/RyK
         sd2OtfaU1UY9tE4nYqw6T+TyHx55onUXOkVsYWef/IOO41kK8+cXbA/F1Y2clzIJVk7d
         5Ike+9M7qzQ4rsuuAvE4l3A8OLRr5QNWqujrKNcQKLOTvmmdafKVJPE6nBHB370tg0MQ
         zkFIA+m1pCymAfwMEX9WTDEMEzwrWJWKHbWHFrphjUpGtgmy5cEGGQHgxwzYKzeqNZk/
         2ULg==
X-Gm-Message-State: AC+VfDyb1iuhGsdXErKKCDsle43u3mweQI+77ar9UpwZISmvjCXjMeIV
        nfoKa9wUHksePS9XMgFTozs=
X-Google-Smtp-Source: ACHHUZ6o46Y/n+GcSntg8AOOWkMoF7eJjyTe/+vZiYx7xrA2akLeDPFlNoHc5jbMW5vDiCYPMnuwJA==
X-Received: by 2002:a17:902:ce82:b0:1af:e116:4b42 with SMTP id f2-20020a170902ce8200b001afe1164b42mr14286520plg.34.1685529745248;
        Wed, 31 May 2023 03:42:25 -0700 (PDT)
Received: from DESKTOP-4R0U3NR.siflower.com ([104.28.228.28])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d30400b001b0395c3ffasm1015500plc.180.2023.05.31.03.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 03:42:25 -0700 (PDT)
From:   Qingfang DENG <dqfext@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
        Ville Nuorvala <vnuorval@tcs.hut.fi>,
        Masahide NAKAMURA <nakam@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qingfang DENG <qingfang.deng@siflower.com.cn>
Subject: [PATCH net] neighbour: fix unaligned access to pneigh_entry
Date:   Wed, 31 May 2023 18:42:33 +0800
Message-Id: <20230531104233.50645-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qingfang DENG <qingfang.deng@siflower.com.cn>

After the blamed commit, the member key is longer 4-byte aligned. On
platforms that do not support unaligned access, e.g., MIPS32R2 with
unaligned_action set to 2, this will trigger a crash when accessing
an IPv6 pneigh_entry, as the key is cast to an in6_addr pointer.

Align the member to 4 bytes on said platforms.

Fixes: 62dd93181aaa ("[IPV6] NDISC: Set per-entry is_router flag in Proxy NA.")
Signed-off-by: Qingfang DENG <qingfang.deng@siflower.com.cn>
---
 include/net/neighbour.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 3fa5774bddac..c0195ed9d111 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -180,7 +180,11 @@ struct pneigh_entry {
 	netdevice_tracker	dev_tracker;
 	u32			flags;
 	u8			protocol;
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	u8			key[];
+#else
+	u8			key[] __aligned(4);
+#endif
 };
 
 /*
-- 
2.34.1

