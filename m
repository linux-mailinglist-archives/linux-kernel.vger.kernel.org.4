Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA496CD9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjC2NAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjC2NA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670B4C28
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680094779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=86UBb8HdpgIHfVhY0bm+TJ2suHKWLXTuDDNwC3Il230=;
        b=K4dVvPFNAEIwvJ14NkN6u80ZBxec75BLRdAdDMh0M4pXd6kxQCvu+7VxBHHxWFEAC4QUtO
        Xp1RuMIzhzFn1GKTOynpi1MhwJluJEYtLtvDGUl3BdeX6k1lEgbWX6AB3uASMTZ8ZrHlE6
        gN/j9XATikS9aRNRn+PaBH7laEUBpoE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-ibnC5hM9OsSldptKvtze4g-1; Wed, 29 Mar 2023 08:59:38 -0400
X-MC-Unique: ibnC5hM9OsSldptKvtze4g-1
Received: by mail-qv1-f71.google.com with SMTP id v8-20020a0ccd88000000b005c1927d1609so6502791qvm.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680094778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86UBb8HdpgIHfVhY0bm+TJ2suHKWLXTuDDNwC3Il230=;
        b=7kfVsiVCSi6kV+AnSwUt0bu90+3wQNuN6EAjqF2L5DH1plGp0yOpKfxebI7lh4h81Z
         vybRgSLjB/2cfLBH+y5B5CiYLEq6xIkJJztA1kg2J314FthAuA5IDyv+ybmz6HzBJk/I
         OngFuNolNZ4NlikZmF65fWD9kVUT8i9GbPqAAxu8wlo29taClCaQPrxV91A+8N8C6s8r
         CjiNmG8zD3vVXBcmir+fAXWs4nPI3tN+ZGqh9+bnSrd6e4cxzr4GG3V8drhKeGsluLHw
         W89xOEBtQir6kHwyUwiJ0Jv20XJplsp7GuVH66jPKzClRwJOC0rLmHYTEt0bMiD/ee44
         ifdA==
X-Gm-Message-State: AAQBX9cTKUvvorBrer7ts0UraL51jOQ3NXoJ8ouY0pQkrL931OpNQ0Me
        gm5BVPRS8Y3+oSSRtqZ6tZdrNCiJUpu4TStMPMZWnl7RE+gREOVJZdXqYe8lgDCes8gtx0htIO9
        ScY/JQYmURTKqVPE/1ngetvoA
X-Received: by 2002:a05:6214:27e8:b0:5a9:2bc0:ea8b with SMTP id jt8-20020a05621427e800b005a92bc0ea8bmr30791795qvb.47.1680094778312;
        Wed, 29 Mar 2023 05:59:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350aCFDVmgs9QLSrptBUrHI+9EDrPp4bz2FZhJVxYqlzrqAKxcL7EnPJxxdbqcRi5DywnP3LffQ==
X-Received: by 2002:a05:6214:27e8:b0:5a9:2bc0:ea8b with SMTP id jt8-20020a05621427e800b005a92bc0ea8bmr30791765qvb.47.1680094778084;
        Wed, 29 Mar 2023 05:59:38 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id mu10-20020a056214328a00b005dd8b9345aasm4515697qvb.66.2023.03.29.05.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 05:59:37 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
        petrm@nvidia.com, leon@kernel.org, shayagr@amazon.com,
        wsa+renesas@sang-engineering.com, yangyingliang@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: ksz884x: remove unused change variable
Date:   Wed, 29 Mar 2023 08:59:29 -0400
Message-Id: <20230329125929.1808420-1-trix@redhat.com>
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
drivers/net/ethernet/micrel/ksz884x.c:3216:6: error: variable
  'change' set but not used [-Werror,-Wunused-but-set-variable]
        int change = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/micrel/ksz884x.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ksz884x.c b/drivers/net/ethernet/micrel/ksz884x.c
index e6acd1e7b263..f78e8ead8c36 100644
--- a/drivers/net/ethernet/micrel/ksz884x.c
+++ b/drivers/net/ethernet/micrel/ksz884x.c
@@ -3213,7 +3213,6 @@ static void port_get_link_speed(struct ksz_port *port)
 	u8 remote;
 	int i;
 	int p;
-	int change = 0;
 
 	interrupt = hw_block_intr(hw);
 
@@ -3260,17 +3259,14 @@ static void port_get_link_speed(struct ksz_port *port)
 					port_cfg_back_pressure(hw, p,
 						(1 == info->duplex));
 				}
-				change |= 1 << i;
 				port_cfg_change(hw, port, info, status);
 			}
 			info->state = media_connected;
 		} else {
-			if (media_disconnected != info->state) {
-				change |= 1 << i;
-
-				/* Indicate the link just goes down. */
+			/* Indicate the link just goes down. */
+			if (media_disconnected != info->state)
 				hw->port_mib[p].link_down = 1;
-			}
+
 			info->state = media_disconnected;
 		}
 		hw->port_mib[p].state = (u8) info->state;
-- 
2.27.0

