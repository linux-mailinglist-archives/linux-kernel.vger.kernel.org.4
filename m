Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39206A423B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjB0NGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjB0NGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93431E5EB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677503149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q92sQcBkpoH/Y89DMN/b2PnZ1a4R3LQUabxaooE41f4=;
        b=Cve3AzZt/JXYEOQ3/uHWJz5rOGGi3ViP/6YMw9lDLxksNO9znxhCKatEh+/CX+f6bsb5Xy
        6DBkJYZG1EA5igJM9j0v03HMXRNoN9W/OwzvI8fJ2X4gA7XrYjj9zlBodrde3nwh7CyOtr
        Yst0sh82rHWEdyTixjkicrMbRoJ5z60=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-LyQOOrGsNRi3G5UrEFr9nA-1; Mon, 27 Feb 2023 08:05:48 -0500
X-MC-Unique: LyQOOrGsNRi3G5UrEFr9nA-1
Received: by mail-qk1-f197.google.com with SMTP id c13-20020a05620a0ced00b007422bf7c4aeso4022500qkj.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q92sQcBkpoH/Y89DMN/b2PnZ1a4R3LQUabxaooE41f4=;
        b=xvadd5ZrSIRvL1LPekeXDaPw8CUMF2a4WHdkr61Losz0ta8R8poxntmneT0XEqD/ne
         hN1uP8FYuEyPUnYo7Sr0D4+kfANEESLMMxRJjPHmmuFLV9AGvF5IZfwvrNWSvgPhH+mS
         hA1FdQw+BNQf0EpASTPsl7/dBjgZtb9VDG9LbAIRYD2VVrwAwypKcISFIJwXzDSVRecs
         V914k3QlQl7dDk/tPpCNDqeXJA78ziFcqLr1rEAbcX2ORWjGAtI/Xu9zywmkUuEVqKGV
         EiIi4DlYRZcYrz5NC9Q0PJg/N7bB8+mmZ6zlwJjr/+EVAM8spGLjZlVI6sViYg5qulNZ
         zQaw==
X-Gm-Message-State: AO0yUKWyl/oB3rj/AdGAmvv8vNmW1ozhXqt0kRZGQXamEZ8iICdnyDIc
        IfnxRi8xD8CjncgyhiQlsMhOquhhOsQNC3o0FNpzMjLHULRRpcXC1veqZGThOq+C3i+uOpkLFoE
        VUkDaGKtzWpf8XatCDcJ3llVM
X-Received: by 2002:a05:622a:198d:b0:3ba:1c07:e472 with SMTP id u13-20020a05622a198d00b003ba1c07e472mr31833336qtc.51.1677503148160;
        Mon, 27 Feb 2023 05:05:48 -0800 (PST)
X-Google-Smtp-Source: AK7set/Q83c86U2flHpqHGPKAg/isPSifHH7doggpAJ/IZmXIvW61I9KlhY599MXX2oNeKrX9jDULg==
X-Received: by 2002:a05:622a:198d:b0:3ba:1c07:e472 with SMTP id u13-20020a05622a198d00b003ba1c07e472mr31833272qtc.51.1677503147482;
        Mon, 27 Feb 2023 05:05:47 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t136-20020a37aa8e000000b0073b967b9b35sm4830749qke.106.2023.02.27.05.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 05:05:46 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, steen.hegelund@microchip.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] net: lan743x: LAN743X selects FIXED_PHY to resolve a link error
Date:   Mon, 27 Feb 2023 08:05:35 -0500
Message-Id: <20230227130535.2828181-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A rand config causes this link error
drivers/net/ethernet/microchip/lan743x_main.o: In function `lan743x_netdev_open':
drivers/net/ethernet/microchip/lan743x_main.c:1512: undefined reference to `fixed_phy_register'

lan743x_netdev_open is controlled by LAN743X
fixed_phy_register is controlled by FIXED_PHY

and the error happens when
CONFIG_LAN743X=y
CONFIG_FIXED_PHY=m

So LAN743X should also select FIXED_PHY

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: Add config setting that trigger the error to commit log
---
 drivers/net/ethernet/microchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 24c994baad13..43ba71e82260 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -47,6 +47,7 @@ config LAN743X
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select PHYLIB
+	select FIXED_PHY
 	select CRC16
 	select CRC32
 	help
-- 
2.27.0

