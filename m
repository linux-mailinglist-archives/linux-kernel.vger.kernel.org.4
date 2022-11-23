Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E36353F1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiKWJAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiKWJA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:00:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFDE1001FC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669193974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nznTvXnBCa/8GStBK6Y61dElxd8Nw2xcab+uDMFbqOc=;
        b=DbjeZvRW2wxRj76bldeiWoUUumupMh6U91vx/1MQjlTIs4MyDTlM3IJsnhnZuCPUbxXVE4
        xCHi7AnDyOGcxWmidgca/hNp18CvOfDVJ2x4PqcvDf0EKNk5hf9opf9Bc1xHqm+sOwacop
        oxIZyDG7n+arZktX8uhszzchr5SUGUA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-3n9aylo2PgOJZE7hyyIkDA-1; Wed, 23 Nov 2022 03:59:32 -0500
X-MC-Unique: 3n9aylo2PgOJZE7hyyIkDA-1
Received: by mail-ej1-f71.google.com with SMTP id sg37-20020a170907a42500b007adaedb5ba2so9601639ejc.18
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nznTvXnBCa/8GStBK6Y61dElxd8Nw2xcab+uDMFbqOc=;
        b=fanP80VPtDXGDjs6LfQrzOdrGD5Q+XIMTiqdC8C1yiE87kI5wuk1epNHKgClPgVOU+
         M13ywc8WE9MUud0v820hKGQFEFZ845ofTjzMN5Rk6ksalQaLvzxqFhE5jGWK79qbyVAz
         GNij58vZsioqfuL7RSBDAujJCvRirqWiU4UdvadO1wVj+nqd2EZx8nMTZEw5h2028MJS
         LTw0FlZoIGs+mRJHHIw9e6eGKSp1FuptCnEOyjGOQTE+U5Ul+TWRYMf0YX1NrcPecBk/
         Z2krr8+8LUt7tJYxAtIo9VVksD5kCwkuIGe9fbGiF42UVjb+xjUmG6imZi/FnW8Dt8if
         UsQg==
X-Gm-Message-State: ANoB5pm+LSpof6ekOvhtEA1cnzytxJze6XuZgzGeYc7/k//pKyCzSU3Q
        2+KMFzv7Fpo3XtKraVCgOv5SDoTVQuGc+5fGrgs+0pRc4epBNXtRp0kaSCWWq96pwWy8Y+7QMIf
        ZNCEhNjcMV6TyglQCwjv3cts=
X-Received: by 2002:a17:906:b51:b0:7ad:da22:c396 with SMTP id v17-20020a1709060b5100b007adda22c396mr23388639ejg.653.1669193971823;
        Wed, 23 Nov 2022 00:59:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ia+G3JvvCbAumvBqpqg0vXs/kl2nlvc/5g5m90/84qOBW+zgHRnBrnqrkcTcAw5f3viDf7g==
X-Received: by 2002:a17:906:b51:b0:7ad:da22:c396 with SMTP id v17-20020a1709060b5100b007adda22c396mr23388621ejg.653.1669193971521;
        Wed, 23 Nov 2022 00:59:31 -0800 (PST)
Received: from klayman.station (net-2-34-28-144.cust.vodafonedsl.it. [2.34.28.144])
        by smtp.gmail.com with ESMTPSA id k21-20020a17090632d500b007ae32daf4b9sm6951686ejk.106.2022.11.23.00.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 00:59:31 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] habanalabs/gaudi2: added memset for the cq_size register
Date:   Wed, 23 Nov 2022 09:56:39 +0100
Message-Id: <20221123085640.103084-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clang-analyzer reported a warning: "Value stored to
'cq_size_addr' is never read".

The cq_size register of dcore0 is not being zeroed using
gaudi2_memset_device_lbw(), along with the other cq_* registers,
even though the corresponding cq_size_addr variable is set.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 65e6cae6100a..05f30adefb32 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -9165,6 +9165,7 @@ static void gaudi2_restore_user_sm_registers(struct hl_device *hdev)
 	gaudi2_memset_device_lbw(hdev, cq_lbw_data_addr, size, 0);
 	gaudi2_memset_device_lbw(hdev, cq_base_l_addr, size, 0);
 	gaudi2_memset_device_lbw(hdev, cq_base_h_addr, size, 0);
+	gaudi2_memset_device_lbw(hdev, cq_size_addr, size, 0);
 
 	cq_lbw_l_addr = mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_L_0 + DCORE_OFFSET;
 	cq_lbw_h_addr = mmDCORE0_SYNC_MNGR_GLBL_LBW_ADDR_H_0 + DCORE_OFFSET;
-- 
2.38.1

