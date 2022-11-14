Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5C6284E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbiKNQSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiKNQRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:17:45 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC122EF22;
        Mon, 14 Nov 2022 08:17:16 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DEEDE8C0965;
        Mon, 14 Nov 2022 16:17:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a241.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5613E8C117F;
        Mon, 14 Nov 2022 16:17:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668442635; a=rsa-sha256;
        cv=none;
        b=DqLkr/NVtL9fTRq34HMQVFSEkcdXGppZ7d+0Vm+649EMblna/A2fDfnPjwcI1mQGs/cskD
        PSnfSRNxRBJMAMClimYfCibpfzeGmpVE4kMON9QDGHuFRTtM7ZSXyxxOLsQi0FklWLtAwg
        M4r0zAs1PLNvf4FZpRJZn2+yLJVhrjUDEcknNXWBeZqtPWNjqlo4/1fJoXhx4Jd7svsTsO
        a/MveePgDddIFQGv1FzRRLDJwtRcju7imt2mWh8QHh9BSeDIB4nemrTnP3fwhGSbdHoOpP
        jE6y2bKhEOn7KkyY4wKN1i/pOdk2htrNW/XJcHW9UiswjIuPucl2JXzJ3gJXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668442635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=KLS+vSxs8gwJG3YMn4U1bLyXDJOpV05P8AVhQBv5De4=;
        b=nO1BUIK5TfHRU3Ox4Y9KujYKxMCeK6uhcAo9RzaoJW/NJZxm1KUk1blxYGOJSqzglx0pBD
        hlqpUQ031JWz+ZaUqhAsaEAa3GNDekSgr8CLvQ7gtkcS592FGsv4YZvE193a0Ql45SNlc3
        gjg7X7tAegNoKynobQjeQg9n6S3QrnKU4iT7BlSlw6zAzAD6yMcWAHgo9dVe3YSMoJvE3e
        Pxyb6Cq53h0ebx04zyKv+wdyEAk0CwUll0wL95fdcALu7lyowW6Yu+JekKqlZYGDOPUvLa
        KlcASYHwrBdP9VbvZJGr6wnXL0Tp7GYX3TPEhg9KWF5adRSoS4DljpH1S7lQQg==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-8nkdq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Left-Keen: 4fe5a40d3e7ca607_1668442635676_4045162582
X-MC-Loop-Signature: 1668442635676:2388102611
X-MC-Ingress-Time: 1668442635676
Received: from pdx1-sub0-mail-a241.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.71 (trex/6.7.1);
        Mon, 14 Nov 2022 16:17:15 +0000
Received: from rhino.lan (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a241.dreamhost.com (Postfix) with ESMTPSA id 4N9vbG39ksz2m;
        Mon, 14 Nov 2022 08:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668442635;
        bh=KLS+vSxs8gwJG3YMn4U1bLyXDJOpV05P8AVhQBv5De4=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=PaV+kIEqmfgHnb5M0WJdnocKyOm7AzwLwdwr0QL6I886JyijVS+xhEK70Ph9p2qey
         0nOsILXC3/EQ456SMpauCi0DLm9fvdbUifxuUWJNMw35E5e1w7+4BFrGFdKjUoyMnD
         pMX0iNsxKzirDsXAVrTLWHhpk8t8OTietHF6Q7gS5Le1C60CCu8ST0GUduZlveAgX+
         PlrVH0Xt02FJCdh66r9z6f+L3+l5McoXO1Y+RuVdPKmf/xK7fBiLF6FslQRCUIPEWP
         bPgjMLaoEtESEcH9y0tlcGDNE9OSfC1vZCDUWlA4alK22oTpSdaT1Ftg9e+nbqdjhm
         rtvBeH96S7zPA==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH] staging: media: omap4iss: remove cacheflush import
Date:   Mon, 14 Nov 2022 11:17:00 -0500
Message-Id: <20221114161700.14378-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cacheflush import is never used, so it is safe to remove it as an
import.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/media/omap4iss/iss_video.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/omap4iss/iss_video.c b/drivers/staging/media/omap4iss/iss_video.c
index 842509dcfedf..e732f08fad26 100644
--- a/drivers/staging/media/omap4iss/iss_video.c
+++ b/drivers/staging/media/omap4iss/iss_video.c
@@ -19,8 +19,6 @@
 #include <media/v4l2-ioctl.h>
 #include <media/v4l2-mc.h>
 
-#include <asm/cacheflush.h>
-
 #include "iss_video.h"
 #include "iss.h"
 
-- 
2.38.1

